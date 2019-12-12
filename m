Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9732AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629A92077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqvO9J72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629A92077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOfM-0000q3-5g
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNym-00049N-Ah
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyl-0007Zq-05
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:04 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyk-0007YU-On
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:02 -0500
Received: by mail-wr1-x42c.google.com with SMTP id c9so2604105wrw.8
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TLIRCS+wjAUW+voOAGF0GUcqpTyXyeNhrBqncLIwiuE=;
 b=AqvO9J725lA+Hw7t70teDncrOjDv0SK5RBmENXig/vwwk9ZR/nZ5rekt7gWaodZwJS
 EXfCt96kVAhtVCHZesvAYxuY8YjZXhAJr7ZmQrz20s/ZSjGuELqsTvTTjwXuWiMETF+Q
 fIod5JagQgF3wcWyHapXJ3VbOTosZ8Y6sW+nKWZA8N4vrda0x0fi+0GiLXJkCTn8uCHO
 4e7+QZ8gRhmSlN6jonArZqcJ4sO60z3ng54qW1458WwyJqfsX+5SBi2OJcFUEMylKUg1
 JprFW/7A+axabvsSYCAONDY1sFIsoIkfte9OZt2Q+8gOSWXcKW8e2Wnib8P9PB/PrSsH
 0IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TLIRCS+wjAUW+voOAGF0GUcqpTyXyeNhrBqncLIwiuE=;
 b=VyOknBO8ZRcchQhhia7CkqxeYLtcC4vLkf0QQLWGpwjiVItrMHdX9+mnAM2sKbq1dy
 W23E2onidIIuGCnaUeCJh/XnydIexPhzDa3Nfz+JlHul0plo72OwUeEAzHi8zsRcwSU0
 LKEK7We3blEvrVCCXFW2Mj7ZxVhBQsMV+1+H9c7Zr0Jp0KOscUNKQHM4p6KpOmGzyJjD
 Nt+1ZNWvLJ/FPnRJmMWGzrUJNQAfCtGYQQ5BYmtgAHDhuRggwAPA9nPUzi/D4u0PrQmO
 OVORd/k/rwZjw9i8ASYy3hjXCunIVoth+ueocsnk00lF1w4Q1gN0mzUdFuOwMqMDPOpf
 M8/A==
X-Gm-Message-State: APjAAAVnlV+wDzCHeyIOEcqtKo6JweYe6MZ4ellOVkd98dN6jIpQG+SO
 bJ45UizkRSmo69wcSr5ZJUVAozwr
X-Google-Smtp-Source: APXvYqwYU/BQAya4ZPTXfVfLMIdfSeXkFWVSwM0hz2Lu76zS+PeH0MhUsUuGWr21lCf9yDZtTcwLOw==
X-Received: by 2002:adf:f288:: with SMTP id k8mr6539554wro.301.1576155241483; 
 Thu, 12 Dec 2019 04:54:01 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 063/132] meson: convert hw/xen
Date: Thu, 12 Dec 2019 13:51:47 +0100
Message-Id: <1576155176-2464-64-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure            |  4 ++++
 hw/Makefile.objs     |  1 -
 hw/meson.build       |  1 +
 hw/xen/Makefile.objs |  6 ------
 hw/xen/meson.build   | 18 ++++++++++++++++++
 meson.build          |  6 ++++++
 6 files changed, 29 insertions(+), 7 deletions(-)
 create mode 100644 hw/meson.build
 delete mode 100644 hw/xen/Makefile.objs
 create mode 100644 hw/xen/meson.build

diff --git a/configure b/configure
index 28746c1..c53df48 100755
--- a/configure
+++ b/configure
@@ -2454,6 +2454,8 @@ if test "$xen" != "no" ; then
     fi
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
     libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
+    xen_cflags="$($pkg_config --cflags $xen_pc)"
+    xen_libs="$($pkg_config --libs $xen_pc)"
   else
 
     xen_libs="-lxenstore -lxenctrl -lxenguest"
@@ -6843,6 +6845,8 @@ fi
 if test "$xen" = "yes" ; then
   echo "CONFIG_XEN_BACKEND=y" >> $config_host_mak
   echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=$xen_ctrl_version" >> $config_host_mak
+  echo "XEN_CFLAGS=$xen_cflags" >> $config_host_mak
+  echo "XEN_LIBS=$xen_libs" >> $config_host_mak
 fi
 if test "$linux_aio" = "yes" ; then
   echo "CONFIG_LINUX_AIO=y" >> $config_host_mak
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index ece6cc3..793d55b 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -35,7 +35,6 @@ devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
-devices-dirs-y += xen/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 devices-dirs-y += semihosting/
 devices-dirs-y += smbios/
diff --git a/hw/meson.build b/hw/meson.build
new file mode 100644
index 0000000..08112a5
--- /dev/null
+++ b/hw/meson.build
@@ -0,0 +1 @@
+subdir('xen')
diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
deleted file mode 100644
index 84df60a..0000000
--- a/hw/xen/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-# xen backend driver support
-common-obj-$(CONFIG_XEN) += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-common.o xen-bus.o xen-bus-helper.o xen-backend.o
-
-obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
-obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
-obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt_load_rom.o
diff --git a/hw/xen/meson.build b/hw/xen/meson.build
new file mode 100644
index 0000000..e9587b6
--- /dev/null
+++ b/hw/xen/meson.build
@@ -0,0 +1,18 @@
+softmmu_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
+  'xen-backend.c',
+  'xen-bus-helper.c',
+  'xen-bus.c',
+  'xen-common.c',
+  'xen-legacy-backend.c',
+  'xen_devconfig.c',
+  'xen_pvdev.c',
+))
+
+specific_ss.add(when: 'CONFIG_XEN_PCI_PASSTHROUGH', if_true: files(
+  'xen-host-pci-device.c',
+  'xen_pt.c',
+  'xen_pt_config_init.c',
+  'xen_pt_graphics.c',
+  'xen_pt_load_rom.c',
+  'xen_pt_msi.c',
+))
diff --git a/meson.build b/meson.build
index 68a5f6e..f1c5e7a 100644
--- a/meson.build
+++ b/meson.build
@@ -295,6 +295,11 @@ numa = declare_dependency()
 if 'CONFIG_NUMA' in config_host
   numa = declare_dependency(link_args: config_host['NUMA_LIBS'].split())
 endif
+xen = declare_dependency()
+if 'CONFIG_XEN_BACKEND' in config_host
+  xen = declare_dependency(compile_args: config_host['XEN_CFLAGS'].split(),
+                           link_args: config_host['XEN_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -618,6 +623,7 @@ subdir('migration')
 subdir('monitor')
 subdir('net')
 subdir('replay')
+subdir('hw')
 
 mods = []
 block_mods = []
-- 
1.8.3.1



