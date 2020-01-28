Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BA6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382832467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw57Xil3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382832467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwW8i-0002Xw-6B
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:03:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6O-0001jL-Kb
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6M-0004t3-HB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:40 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6M-0004r1-9G
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:38 -0500
Received: by mail-wm1-x344.google.com with SMTP id g1so3500145wmh.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7FD8lBysHG6DuO/snjpl5bv5yWCYtV/OlNWH2YE3Duw=;
 b=aw57Xil3Vkma3ELfecysg3EQ/jTpIEqYsLqCtLjG4NQkdBRg4THLtYOmABFv1VAoTg
 VN2KLDVgpFQBv5RgtM7ZR863Jaz00odj9S62pltgXDA7Vq1VojMHuHLrHax4FausOp+W
 af5DBuSCftMSO79zcZBtV3+uHnTPYITdO7f+qlP80wHlOr4PEKCjHmILHHm182Fjomk4
 JtqS2T4gikX58k1mKe+tuoM/CdTkUVR3l8eIITyRCzi30xG1HwSgi9Ofxj+OCN0LJ1/j
 RXji54/Wt5aT13SI6iPyvgIod4QEKCb+EVUJ6IWU4Esomr4Zgt6DrzRAZDp+GwocUWSx
 n7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7FD8lBysHG6DuO/snjpl5bv5yWCYtV/OlNWH2YE3Duw=;
 b=olDC4Vw58TWu7BBTZZrXT4+X002xmwKHF0M7fkSCREoatuGriVaWzDEzAthoFBGJTx
 2y2NOZa+EZCypesgBPdTIFDzBnlhNTvH9++IAc/6gKOqInXcofs7AT+OqzD8g7LyCKuT
 K8GE25LC3GuveCqFHzie2iro+dFwKEQ8TcU/t32+7inPn9eOlASUtWrTgvGXxBtukUbI
 ZF4Jh/XjG63REZhODvedjPqX0MvnUA+Y/l+BAEmSYtvsV/WOUjv5yIpAJ7dWUutk2Wqr
 heGSay2DoijtH6vVo0qGX3U0t6KHc93dsZuTTZYXJBs2YwtxyOEbdX091IHDSS5WKbdt
 aRjw==
X-Gm-Message-State: APjAAAWsNLVGqbIePjmsmbAclDgxT7jbLk+obUUM0bczrrn2rs/ZCPIa
 MoPhDWEibb40rgJYiV8kVZLrZe7n
X-Google-Smtp-Source: APXvYqym3iJfSucsKEjwICgMFtUn/5RI762H6/klIqfaBCm42KX8jlZGTwa0zmDDnQdksjU9QrNHsA==
X-Received: by 2002:a1c:4e05:: with SMTP id g5mr6132137wmh.138.1580234197163; 
 Tue, 28 Jan 2020 09:56:37 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 071/142] meson: convert hw/semihosting
Date: Tue, 28 Jan 2020 18:52:31 +0100
Message-Id: <20200128175342.9066-72-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs             | 1 -
 hw/meson.build               | 1 +
 hw/semihosting/Makefile.objs | 2 --
 hw/semihosting/meson.build   | 4 ++++
 4 files changed, 5 insertions(+), 3 deletions(-)
 delete mode 100644 hw/semihosting/Makefile.objs
 create mode 100644 hw/semihosting/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 3e3ac7fe79..3501559584 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -36,7 +36,6 @@ devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 devices-dirs-$(CONFIG_NUBUS) += nubus/
-devices-dirs-y += semihosting/
 devices-dirs-y += smbios/
 endif
 
diff --git a/hw/meson.build b/hw/meson.build
index fe7c466460..66a2f6cddd 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,2 +1,3 @@
 subdir('core')
+subdir('semihosting')
 subdir('xen')
diff --git a/hw/semihosting/Makefile.objs b/hw/semihosting/Makefile.objs
deleted file mode 100644
index 4ad47c05c0..0000000000
--- a/hw/semihosting/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-$(CONFIG_SEMIHOSTING) += config.o
-obj-$(CONFIG_SEMIHOSTING) += console.o
diff --git a/hw/semihosting/meson.build b/hw/semihosting/meson.build
new file mode 100644
index 0000000000..f40ac574c4
--- /dev/null
+++ b/hw/semihosting/meson.build
@@ -0,0 +1,4 @@
+specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
+  'config.c',
+  'console.c',
+))
-- 
2.21.0



