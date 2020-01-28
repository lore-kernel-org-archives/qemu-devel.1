Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6773DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360D22467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaiyIjjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360D22467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwW8Q-0002Ki-Ar
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7p-0003j4-WF
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7o-00088K-J7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:50765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7o-00087c-C2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:08 -0500
Received: by mail-wm1-x335.google.com with SMTP id a5so3534740wmb.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R63pa3BaoQR6sTJRowljkz1+uv2L05XdtkPzVnlv3Tw=;
 b=HaiyIjjJbvyuSmF7G6d/pt6AqbeEIpRB6V0k39wqMU0vK18dieFS651QptELRUWEZV
 JdYondakpx3Z29SoyFS6hg7Fr3X4ORskNhCe2nanf9iYSRiM0XSUNC6bXD5axryOqxTh
 liZD+MidKecCoeRfFAk6mlwJLVFUgYimRwXsloDva/PrcXPCmUHR3NSWK2EF97vYslX5
 RAzwE7bUyHgVhd71a7q5D7z/0cjudm6cWDSWCgi4lUgi5U0SMj0Sz1+NdbSW/wqU8uux
 TxnN5AvZM3kIhnqmqOjGr2tPj0XdY9Cdr/YGHUExeAl/MzBQpJet/mp7efOzsV2PcRC/
 gUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=R63pa3BaoQR6sTJRowljkz1+uv2L05XdtkPzVnlv3Tw=;
 b=OAjvZPb6eZgxQoYRjs/VgJMC16b2vDEwTNKuawgCjh3ZzunsUbz3Jf14UamzBTipPv
 KekZAdWNcUrk9CTlN2JrKWnsG5m4RFJuryKCuWeDmOcypEY+keaxbR7IlKH7HB09Td2z
 YfDgFb+J/lnLzzrqJrs7zJytxzsdr+GkcdIkeqPbylm24mQP7hIrqhd+n4dT38XcswBz
 rocuhG9Gtu1Op4o5l2tGxvnu911vdWdy1lOVhs5HQN4bZpj4w4SeAImZJzNrUPQt47K8
 RSHUQ+93Xpw/Io90iBtqXUxp9f6LzpI1wTQbgUDidwXswwQG4aHB/vsbRi11PWYEFzp8
 mXJw==
X-Gm-Message-State: APjAAAW2H4lWBZ9v9ROwZPdzhKFd/C4l85WNcvfg5Hq7ABNnUikhR3F8
 9sOa5AkSVWzVpU7FW8LuesAzZ1Dg
X-Google-Smtp-Source: APXvYqyawrOaPy2l/4q//2WLklEmmxvCVeVoR9RmhaUsLEQs4s1pnj9OBJBzdBlQpV4ZfhREUYE6qg==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr6275900wmc.119.1580234287231; 
 Tue, 28 Jan 2020 09:58:07 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 110/142] meson: convert hw/9pfs
Date: Tue, 28 Jan 2020 18:53:10 +0100
Message-Id: <20200128175342.9066-111-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
 Kconfig.host          |  1 +
 Makefile.objs         |  5 -----
 Makefile.target       |  1 -
 hw/9pfs/Kconfig       |  4 ++++
 hw/9pfs/Makefile.objs |  9 ---------
 hw/9pfs/meson.build   | 20 ++++++++++++++++++++
 hw/Makefile.objs      |  6 ------
 hw/meson.build        |  1 +
 8 files changed, 26 insertions(+), 21 deletions(-)
 delete mode 100644 hw/9pfs/Makefile.objs
 create mode 100644 hw/9pfs/meson.build
 delete mode 100644 hw/Makefile.objs

diff --git a/Kconfig.host b/Kconfig.host
index 55136e037d..ce78e49c5c 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -34,6 +34,7 @@ config VHOST_KERNEL
 config XEN
     bool
     select FSDEV_9P if VIRTFS
+    select 9PFS if VIRTFS
 
 config VIRTFS
     bool
diff --git a/Makefile.objs b/Makefile.objs
index 25468baee4..9006b282bd 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -58,11 +58,6 @@ common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
 endif
 
-#######################################################################
-# Target-independent parts used in system and user emulation
-
-common-obj-y = hw/
-
 ######################################################################
 # Resource file for Windows executables
 version-obj-$(CONFIG_WIN32) += $(BUILD_DIR)/version.o
diff --git a/Makefile.target b/Makefile.target
index 1ce0c7f800..e269300203 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -155,7 +155,6 @@ endif #CONFIG_BSD_USER
 ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o gdbstub.o balloon.o ioport.o
 obj-y += qtest.o
-obj-y += hw/
 obj-y += memory.o
 obj-y += memory_mapping.o
 LIBS := $(libs_softmmu) $(LIBS)
diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
index 3ae5749661..d3ebd73730 100644
--- a/hw/9pfs/Kconfig
+++ b/hw/9pfs/Kconfig
@@ -2,8 +2,12 @@ config FSDEV_9P
     bool
     depends on VIRTFS
 
+config 9PFS
+    bool
+
 config VIRTIO_9P
     bool
     default y
     depends on VIRTFS && VIRTIO
     select FSDEV_9P
+    select 9PFS
diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
deleted file mode 100644
index 70ded6fd8f..0000000000
--- a/hw/9pfs/Makefile.objs
+++ /dev/null
@@ -1,9 +0,0 @@
-common-obj-y  = 9p.o 9p-util.o
-common-obj-y += 9p-local.o 9p-xattr.o
-common-obj-y += 9p-xattr-user.o 9p-posix-acl.o
-common-obj-y += coth.o cofs.o codir.o cofile.o
-common-obj-y += coxattr.o 9p-synth.o
-common-obj-y += 9p-proxy.o
-
-common-obj-$(CONFIG_XEN) += xen-9p-backend.o
-obj-$(CONFIG_VIRTIO_9P) += virtio-9p-device.o
diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
new file mode 100644
index 0000000000..cc09426212
--- /dev/null
+++ b/hw/9pfs/meson.build
@@ -0,0 +1,20 @@
+fs_ss = ss.source_set()
+fs_ss.add(files(
+  '9p-local.c',
+  '9p-posix-acl.c',
+  '9p-proxy.c',
+  '9p-synth.c',
+  '9p-util.c',
+  '9p-xattr-user.c',
+  '9p-xattr.c',
+  '9p.c',
+  'codir.c',
+  'cofile.c',
+  'cofs.c',
+  'coth.c',
+  'coxattr.c',
+))
+fs_ss.add(when: 'CONFIG_XEN', if_true: files('xen-9p-backend.c'))
+softmmu_ss.add_all(when: 'CONFIG_9PFS', if_true: fs_ss)
+
+specific_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-device.c'))
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
deleted file mode 100644
index 3dc4decfb5..0000000000
--- a/hw/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-ifeq ($(CONFIG_SOFTMMU), y)
-devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$(CONFIG_XEN))) += 9pfs/
-endif
-
-common-obj-y += $(devices-dirs-y)
-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 55ca2b2b61..ba8763cad8 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('9pfs')
 subdir('acpi')
 subdir('adc')
 subdir('audio')
-- 
2.21.0



