Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02345C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82DA52467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqVPe/jE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DA52467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwW0g-0008LU-DI
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7S-00033J-TD
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7R-0007LG-QK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:46 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7R-0007EU-JT
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:45 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so3518340wmc.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q2jpfAnc2KRQsp1K1I4kxr6g0Wc0w9Jp+uUoDxrj7nQ=;
 b=UqVPe/jEsahUQDM5q2dAvXAyelowN1aMVKwSHPoqJWfdGVDd7eWwkZJMEMdxMBZL5F
 oRwepO/dic0yN1Cz2QG8QV/5EIwKK5LlnDA20y9jid29vqIakqow5tJ3fpxIgdT8R9Xi
 c74gEA/ab9xmjEgs5+KezaseAwBwR5DdouLl6UIX0fXvdZAEKBNxe7QyJ9F0M8cVsWv1
 WlX9jqyTkIA8A1o1/X2g6TmdQWBYlcl5Io/dGkWzKeZgQpQUzP8NjPJJqwjOW8u283FQ
 0/H/TizDFnSLql8LjM/kd4BwV7sC7AHL2U2Vn7swbsau3/LlHR5SuIuBfy1rgpnghDnn
 eCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=q2jpfAnc2KRQsp1K1I4kxr6g0Wc0w9Jp+uUoDxrj7nQ=;
 b=d6xv6eawMKSddgD3sCvv2aJa2FlUgDK3JQ53GLPh7uo3HAq+yU7/0PW6LadieMBHW6
 VKbT4sQnGTNM404cdCJPSbohEbLx5DR33GnSGL+HFC+L2ntoBaLFKhBZ9SY5oya1hot1
 FUwEAOXU7MbgEsa6fgkENdQnyWrgzvjN/D8yBLcPTQTTWCVNjTCOdF9n3amufluqRlrA
 zOxjwfIrAlM+HnmkKz8JynVDOQgcfBBEl3jVecpzz2c1rLNFX27evz7MrjAydxTyji5x
 3Kc0ZcY+BzG3h2jJVS3dZClt3K0mmzse5GxtLsSxjX33ZvG5m8stGyBSWVl7UcpOqtj+
 1SFQ==
X-Gm-Message-State: APjAAAXHS5+irFnNgkhXtK+XND4TPJDk9sgV9HYilJoOx9+s/gqid/8F
 FCS+vig0cA6CZRH24fyrQgyQFLyP
X-Google-Smtp-Source: APXvYqxQfYFr6gY6EX9LWYkYBQKKjGI5tE/fjdzKyXIGavuYzf7X5Ul2xLQ56vmMDHLyfhQZptq1gA==
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr6649548wmf.189.1580234263230; 
 Tue, 28 Jan 2020 09:57:43 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 100/142] meson: convert hw/hyperv
Date: Tue, 28 Jan 2020 18:53:00 +0100
Message-Id: <20200128175342.9066-101-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs        | 1 -
 hw/hyperv/Makefile.objs | 2 --
 hw/hyperv/meson.build   | 2 ++
 hw/meson.build          | 1 +
 4 files changed, 3 insertions(+), 3 deletions(-)
 delete mode 100644 hw/hyperv/Makefile.objs
 create mode 100644 hw/hyperv/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 95c065d18f..c9999a846b 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -9,7 +9,6 @@ devices-dirs-y += cpu/
 devices-dirs-y += display/
 devices-dirs-y += dma/
 devices-dirs-y += gpio/
-devices-dirs-$(CONFIG_HYPERV) += hyperv/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/hyperv/Makefile.objs b/hw/hyperv/Makefile.objs
deleted file mode 100644
index edaca2f763..0000000000
--- a/hw/hyperv/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y += hyperv.o
-obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
new file mode 100644
index 0000000000..98663ece7a
--- /dev/null
+++ b/hw/hyperv/meson.build
@@ -0,0 +1,2 @@
+specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
+specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 983edc1d47..f9e5adfb48 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('hyperv')
 subdir('i2c')
 subdir('ide')
 subdir('input')
-- 
2.21.0



