Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76041C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4354A206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC38+tHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4354A206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWBG-00069W-FX
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6U-0001wz-H8
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6T-00056w-GL
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:46 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6T-00055z-AA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:45 -0500
Received: by mail-wm1-x342.google.com with SMTP id g1so3500527wmh.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CiT2xrnkCUDt+XbyDWXNaZpFC+PLTWyb0mxHnYb7Opk=;
 b=GC38+tHTQWLWIXlLlbFG1B8aPqu51ByjsaLEX9n7m5kkP42+zygSQHpxWQLwe13pHF
 TvFKaoEFxf2102ufUEK3qApclsxeBwuMIMTGgLY2hMMbeBaR2OEs1huZYGzx4mhBYLfg
 vs/ecWfMtvEPVCyzxjYK/xMf8GfGEyB03mUho+WWQ3DvaBWuAgAOqyUPlISQGBiX7/wt
 V7mfCjmmR/h3pLKDrSk01UPAaUOZRrasK+4PpgrOwrNCoK6vTY68CqJhxmbGrOgwHqGw
 O0Y+6Hw43mJIEJZhzrdq2lJ8HVL0rF6Zl6EGAFF6p3RBl4tMOC9SA/KkTKSYRuDOe6Ox
 87oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CiT2xrnkCUDt+XbyDWXNaZpFC+PLTWyb0mxHnYb7Opk=;
 b=nyJt1gioWfRuwkDIObaITzvVhnz+SPrDR/n3xqRSiavRbzPezK12cDKTNfKu9RYA4l
 VFMjS16PYKfigPPfSHf9F0qWl6K+JGWfH0a+Gfa7a1UI597LRSxXghmS+WEzpj0fynOj
 79xJst7p+pSAJf4w0g4kkx+BaDr2oA8105XRYzmJeqK7TBOrTCi0VncpSwJ3EYNL5yMH
 4WUG3gZ2npdQwA39RjlxUuojaN+Mob/u9Zps3adTgjlHUnZPbC+FENnYRDBjnsY4ryDE
 lDaPhmVY/6ybcJLyXQ2xLFQ7WxM7pa1XGLM4SNPcnMStfQ7nKv8vMcpGqlg4c/rHGW7j
 SheQ==
X-Gm-Message-State: APjAAAVUnAVR7wQjxAxlFJ2Yu/niair8Wim6BJNr+BkjVsrNlILcWR81
 Y+ShMwlZEJXrPEX0F4Nce+jolv5b
X-Google-Smtp-Source: APXvYqzTtEJlEop/muUibq12F1dZ4EsK4qgJ2hWRiLvhF+KYucb0bOJFOO3Eq2Z/RyWwYajQkympmQ==
X-Received: by 2002:a1c:9dcb:: with SMTP id g194mr6192792wme.53.1580234204099; 
 Tue, 28 Jan 2020 09:56:44 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 074/142] meson: convert hw/mem
Date: Tue, 28 Jan 2020 18:52:34 +0100
Message-Id: <20200128175342.9066-75-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 hw/Makefile.objs   | 1 -
 hw/mem/Kconfig     | 1 +
 hw/mem/meson.build | 6 ++++++
 hw/meson.build     | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 hw/mem/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 546da511a6..636c4f1fed 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -34,7 +34,6 @@ devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
-devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index 620fd4cb59..9e6c6b8236 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -9,3 +9,4 @@ config NVDIMM
     bool
     default y
     depends on PC
+    select MEM_DEVICE
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
new file mode 100644
index 0000000000..ba424622bb
--- /dev/null
+++ b/hw/mem/meson.build
@@ -0,0 +1,6 @@
+mem_ss = ss.source_set()
+mem_ss.add(files('memory-device.c'))
+mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
+mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
diff --git a/hw/meson.build b/hw/meson.build
index dccc2d19a6..542d675618 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
-- 
2.21.0



