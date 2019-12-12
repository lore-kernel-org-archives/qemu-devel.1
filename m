Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F25BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED56D214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssso5cba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED56D214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOY2-0008FX-2w
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:30:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyS-0003fB-BX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyQ-0006sz-09
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:44 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyP-0006rI-Lg
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:41 -0500
Received: by mail-wm1-x32f.google.com with SMTP id a5so2258465wmb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mYe4xppyLjVYcXs3vvJ0AnJuoQAO+jYdDpByA8Rg4vU=;
 b=Ssso5cbaYryOUQC8EIGptx3ILIVOm4Lov0nOiR56S5Di9t+3VYjlRIhRQH9oBxz9G+
 17H/vu60325/0VfQTZmU42VlocPLD97q4tGplW7tDQ9+KkBdT7Jp0dzmIniNOWkNmRZ6
 68s10Hq/Q/3lKxCWX8HaDRkOunfQlrn2DUYh9BpSMyeuLH0HF/iqcd6zbU8OtuHZad+9
 a9bwyh7P1MZv0vVejd+XX/R3h+dsn7PrsfU2fPZGC1tDkXZB853JbkhMb5KZPbWGBMpY
 LJJmL7VG73w+ozssH/JvVhAqNqc/lqJ3B4f4fpy6aWQr8esZPC5jUAxwVimquHAHWmGG
 IV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mYe4xppyLjVYcXs3vvJ0AnJuoQAO+jYdDpByA8Rg4vU=;
 b=aIGWCMfnXX7e4xr/+CQjUj20xdmqn3gVqrVuiurNoW5D2xnpe/XzR8/gMAlnla/dhc
 6X9rQIwbrAoCru0kTHjGBll119hhD8nFVJKNM+kKOc3yIbGu5tpWTOgho4dv0NDmzmMU
 ktPdnv1v+GBVJM6Cv1KtBbNkXbscnczh6KPNbuN53B4UNR2O3wI5r8VHZTGNJLsY/jVD
 8lka9F5pxv1J1XMq4V1/YCGp1y4eSS93vsAm4lI3eUiQMANJw3E1YBQ7w5Mi9GHZG4g9
 pSWA408LGKkgzfpiQnpkY5jiyk6p7GJ4eIuiT4vkiwtRzTvz0YM5VZgaQBsvjDuTmdeO
 WZMg==
X-Gm-Message-State: APjAAAXyUNNfb3NOCVq9neZEcs/Ek2SuLpSIAtaJDOA3Fmfimro5r2nl
 Tz5FAFwkbJEhx0hRKKNNYOdu2mLy
X-Google-Smtp-Source: APXvYqyQ2/jgDZ1HUVbzTJTkdsYpTs1RKduaPPUPas/VJ+TlQG3d9lE/nGRQLNAGbUCkU3Iir0aAsw==
X-Received: by 2002:a1c:1d16:: with SMTP id d22mr6697430wmd.158.1576155219762; 
 Thu, 12 Dec 2019 04:53:39 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 042/132] meson: convert block
Date: Thu, 12 Dec 2019 13:51:26 +0100
Message-Id: <1576155176-2464-43-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
 Makefile                        |   9 ----
 Makefile.objs                   |  30 +++++++++---
 Makefile.target                 |   3 +-
 block.c                         |   2 +-
 block/Makefile.objs             |  64 -------------------------
 block/meson.build               | 101 ++++++++++++++++++++++++++++++++++++++++
 configure                       |  10 ++--
 meson.build                     |  63 +++++++++++++++++++++++++
 nbd/Makefile.objs               |   1 -
 nbd/meson.build                 |   5 ++
 rules.mak                       |   3 +-
 scripts/modules/module_block.py |   0
 scsi/Makefile.objs              |   4 --
 scsi/meson.build                |   4 ++
 14 files changed, 206 insertions(+), 93 deletions(-)
 create mode 100644 block/meson.build
 delete mode 100644 nbd/Makefile.objs
 create mode 100644 nbd/meson.build
 mode change 100644 => 100755 scripts/modules/module_block.py
 delete mode 100644 scsi/Makefile.objs
 create mode 100644 scsi/meson.build

diff --git a/Makefile b/Makefile
index 42077ae..cdd9d14 100644
--- a/Makefile
+++ b/Makefile
@@ -98,8 +98,6 @@ CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 
 generated-files-y = config-host.h
 
-generated-files-y += module_block.h
-
 generated-files-y += .git-submodule-status
 
 edk2-decompressed = $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
@@ -140,8 +138,6 @@ include $(SRC_PATH)/Makefile.objs
 endif
 
 dummy := $(call unnest-vars,, \
-                block-obj-y \
-                block-obj-m \
                 common-obj-y \
                 common-obj-m)
 
@@ -251,11 +247,6 @@ ifneq ($(EXESUF),)
 qga/qemu-ga: qga/qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
-module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
-	$(call quiet-command,$(PYTHON) $< $@ \
-	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
-	"GEN","$@")
-
 clean: recurse-clean
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
diff --git a/Makefile.objs b/Makefile.objs
index 39e1d41..56d0c60 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,13 +1,19 @@
 #######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img
 
-block-obj-y = nbd/
-block-obj-y += block.o blockjob.o job.o
-block-obj-y += block/ scsi/
-block-obj-y += qemu-io-cmds.o
-block-obj-$(CONFIG_REPLICATION) += replication.o
-
-block-obj-m = block/
+block-obj-y += libblock.fa
+
+libblock.fa-libs = $(LIBNFS_LIBS)
+libblock.fa-libs += $(LIBISCSI_LIBS)
+libblock.fa-libs += $(CURL_LIBS)
+libblock.fa-libs += $(RBD_LIBS)
+libblock.fa-libs += $(GLUSTERFS_LIBS)
+libblock.fa-libs += $(VXHS_LIBS)
+libblock.fa-libs += $(LIBSSH_LIBS)
+libblock.fa-libs += $(BZIP2_LIBS)
+libblock.fa-libs += $(LZFSE_LIBS)
+libblock.fa-libs += $(if $(CONFIG_LINUX_AIO),-laio)
+libblock.fa-libs += $(LIBXML2_LIBS)
 
 #######################################################################
 # libraries built entirely from meson
@@ -43,6 +49,16 @@ common-obj-$(CONFIG_LINUX) += fsdev/
 
 common-obj-y += migration/
 
+common-obj-$(if $(CONFIG_CURL),m) += block-curl$(DSOSUF)
+common-obj-$(if $(CONFIG_GLUSTERFS),m) += block-gluster$(DSOSUF)
+common-obj-$(if $(CONFIG_LIBISCSI),m) += block-iscsi$(DSOSUF)
+common-obj-$(if $(CONFIG_LIBNFS),m) += block-nfs$(DSOSUF)
+common-obj-$(if $(CONFIG_LIBSSH),m) += block-ssh$(DSOSUF)
+common-obj-$(if $(CONFIG_RBD),m) += block-rbd$(DSOSUF)
+
+common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
+common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
+
 common-obj-y += audio/
 common-obj-m += audio/
 common-obj-y += hw/
diff --git a/Makefile.target b/Makefile.target
index 95823da..1cb7bc2 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -184,13 +184,12 @@ all-obj-y := $(obj-y)
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call fix-paths,../,, \
               authz-obj-y \
+              block-obj-y \
               chardev-obj-y \
               crypto-obj-y \
               io-obj-y \
               qom-obj-y)
 dummy := $(call unnest-vars,.., \
-               block-obj-y \
-               block-obj-m \
                common-obj-y \
                common-obj-m)
 all-obj-y += $(common-obj-y)
diff --git a/block.c b/block.c
index 874a29a..f69d6ef 100644
--- a/block.c
+++ b/block.c
@@ -29,7 +29,7 @@
 #include "block/nbd.h"
 #include "block/qdict.h"
 #include "qemu/error-report.h"
-#include "module_block.h"
+#include "block/module_block.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 35f3bca..83e87b3 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -1,65 +1 @@
-block-obj-y += raw-format.o vmdk.o vpc.o
-block-obj-$(CONFIG_QCOW1) += qcow.o
-block-obj-$(CONFIG_VDI) += vdi.o
-block-obj-$(CONFIG_CLOOP) += cloop.o
-block-obj-$(CONFIG_BOCHS) += bochs.o
-block-obj-$(CONFIG_VVFAT) += vvfat.o
-block-obj-$(CONFIG_DMG) += dmg.o
-
-block-obj-y += qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot.o qcow2-cache.o qcow2-bitmap.o qcow2-threads.o
-block-obj-$(CONFIG_QED) += qed.o qed-l2-cache.o qed-table.o qed-cluster.o
-block-obj-$(CONFIG_QED) += qed-check.o
-block-obj-y += vhdx.o vhdx-endian.o vhdx-log.o
-block-obj-y += quorum.o
-block-obj-y += blkdebug.o blkverify.o blkreplay.o
-block-obj-$(CONFIG_PARALLELS) += parallels.o
-block-obj-y += blklogwrites.o
-block-obj-y += block-backend.o snapshot.o qapi.o
-block-obj-$(CONFIG_WIN32) += file-win32.o win32-aio.o
-block-obj-$(CONFIG_POSIX) += file-posix.o
-block-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
-block-obj-y += null.o mirror.o commit.o io.o create.o
-block-obj-y += throttle-groups.o
-block-obj-$(CONFIG_LINUX) += nvme.o
-
-block-obj-y += nbd.o
-block-obj-$(CONFIG_SHEEPDOG) += sheepdog.o
-block-obj-$(CONFIG_LIBISCSI) += iscsi.o
-block-obj-$(if $(CONFIG_LIBISCSI),y,n) += iscsi-opts.o
-block-obj-$(CONFIG_LIBNFS) += nfs.o
-block-obj-$(CONFIG_CURL) += curl.o
-block-obj-$(CONFIG_RBD) += rbd.o
-block-obj-$(CONFIG_GLUSTERFS) += gluster.o
-block-obj-$(CONFIG_VXHS) += vxhs.o
-block-obj-$(CONFIG_LIBSSH) += ssh.o
-block-obj-y += accounting.o dirty-bitmap.o
-block-obj-y += write-threshold.o
-block-obj-y += backup.o
-block-obj-$(CONFIG_REPLICATION) += replication.o
-block-obj-y += throttle.o copy-on-read.o
-
-block-obj-y += crypto.o
-
 common-obj-y += stream.o
-
-nfs.o-libs         := $(LIBNFS_LIBS)
-iscsi.o-cflags     := $(LIBISCSI_CFLAGS)
-iscsi.o-libs       := $(LIBISCSI_LIBS)
-curl.o-cflags      := $(CURL_CFLAGS)
-curl.o-libs        := $(CURL_LIBS)
-rbd.o-cflags       := $(RBD_CFLAGS)
-rbd.o-libs         := $(RBD_LIBS)
-gluster.o-cflags   := $(GLUSTERFS_CFLAGS)
-gluster.o-libs     := $(GLUSTERFS_LIBS)
-vxhs.o-libs        := $(VXHS_LIBS)
-ssh.o-cflags       := $(LIBSSH_CFLAGS)
-ssh.o-libs         := $(LIBSSH_LIBS)
-block-obj-dmg-bz2-$(CONFIG_BZIP2) += dmg-bz2.o
-block-obj-$(if $(CONFIG_DMG),m,n) += $(block-obj-dmg-bz2-y)
-dmg-bz2.o-libs     := $(BZIP2_LIBS)
-block-obj-$(if $(CONFIG_LZFSE),m,n) += dmg-lzfse.o
-dmg-lzfse.o-libs   := $(LZFSE_LIBS)
-qcow.o-libs        := -lz
-linux-aio.o-libs   := -laio
-parallels.o-cflags := $(LIBXML2_CFLAGS)
-parallels.o-libs   := $(LIBXML2_LIBS)
diff --git a/block/meson.build b/block/meson.build
new file mode 100644
index 0000000..a68689b
--- /dev/null
+++ b/block/meson.build
@@ -0,0 +1,101 @@
+block_ss.add(genh)
+block_ss.add(files(
+  'accounting.c',
+  'backup.c',
+  'blkdebug.c',
+  'blklogwrites.c',
+  'blkreplay.c',
+  'blkverify.c',
+  'block-backend.c',
+  'commit.c',
+  'copy-on-read.c',
+  'create.c',
+  'crypto.c',
+  'dirty-bitmap.c',
+  'io.c',
+  'mirror.c',
+  'nbd.c',
+  'null.c',
+  'qapi.c',
+  'qcow2-bitmap.c',
+  'qcow2-cache.c',
+  'qcow2-cluster.c',
+  'qcow2-refcount.c',
+  'qcow2-snapshot.c',
+  'qcow2-threads.c',
+  'qcow2.c',
+  'quorum.c',
+  'raw-format.c',
+  'snapshot.c',
+  'throttle-groups.c',
+  'throttle.c',
+  'vhdx-endian.c',
+  'vhdx-log.c',
+  'vhdx.c',
+  'vmdk.c',
+  'vpc.c',
+  'write-threshold.c',
+))
+
+block_ss.add(when: [zlib, 'CONFIG_QCOW1'], if_true: files('qcow.c'))
+block_ss.add(when: 'CONFIG_VDI', if_true: files('vdi.c'))
+block_ss.add(when: 'CONFIG_CLOOP', if_true: files('cloop.c'))
+block_ss.add(when: 'CONFIG_BOCHS', if_true: files('bochs.c'))
+block_ss.add(when: 'CONFIG_VVFAT', if_true: files('vvfat.c'))
+block_ss.add(when: 'CONFIG_DMG', if_true: files('dmg.c'))
+block_ss.add(when: 'CONFIG_QED', if_true: files(
+  'qed-check.c',
+  'qed-cluster.c',
+  'qed-l2-cache.c',
+  'qed-table.c',
+  'qed.c',
+))
+block_ss.add(when: [libxml2, 'CONFIG_PARALLELS'], if_true: files('parallels.c'))
+block_ss.add(when: 'CONFIG_WIN32', if_true: files('file-win32.c', 'win32-aio.c'))
+block_ss.add(when: 'CONFIG_POSIX', if_true: [files('file-posix.c'), coref, iokit])
+block_ss.add(when: 'CONFIG_LIBISCSI', if_true: files('iscsi-opts.c'))
+block_ss.add(when: 'CONFIG_LINUX', if_true: files('nvme.c'))
+block_ss.add(when: 'CONFIG_REPLICATION', if_true: files('replication.c'))
+block_ss.add(when: 'CONFIG_SHEEPDOG', if_true: files('sheepdog.c'))
+block_ss.add(when: [libaio, 'CONFIG_LINUX_AIO'], if_true: files('linux-aio.c'))
+block_ss.add(when: [vxhs, 'CONFIG_VXHS'], if_true: files('vxhs.c'))
+
+block_modules = []
+
+modsrc = []
+foreach m : [
+  ['CONFIG_CURL', 'curl', [curl, glib], 'curl.c'],
+  ['CONFIG_GLUSTERFS', 'gluster', glusterfs, 'gluster.c'],
+  ['CONFIG_LIBISCSI', 'iscsi', libiscsi, 'iscsi.c'],
+  ['CONFIG_LIBNFS', 'nfs', libnfs, 'nfs.c'],
+  ['CONFIG_LIBSSH', 'ssh', libssh, 'ssh.c'],
+  ['CONFIG_RBD', 'rbd', rbd, 'rbd.c'],
+]
+  if config_host.has_key(m[0])
+    if enable_modules
+      modsrc += files(m[3])
+    endif
+    block_modules += [[m[1], files(m[3]), m[2]]]
+  endif
+endforeach
+
+# those are not exactly regular block modules, so treat them apart
+if 'CONFIG_DMG' in config_host
+  foreach m : [
+    ['CONFIG_LZFSE', 'dmg-lzfse', liblzfse, 'dmg-lzfse.c'],
+    ['CONFIG_BZIP2', 'dmg-bz2', [glib, libbzip2], 'dmg-bz2.c']
+  ]
+    if config_host.has_key(m[0])
+      block_modules += [[m[1], files(m[3]), m[2]]]
+    endif
+  endforeach
+endif
+
+module_block_py = find_program('scripts/modules/module_block.py')
+module_block_h = custom_target('module_block.h',
+                               output: 'module_block.h',
+                               input: modsrc,
+                               command: [module_block_py, '@OUTPUT0@', modsrc])
+block_ss.add(module_block_h)
+
+modules += {'block': block_modules}
diff --git a/configure b/configure
index d65b79e..7be08f3 100755
--- a/configure
+++ b/configure
@@ -3711,7 +3711,8 @@ if test "$zlib" != "no" ; then
 int main(void) { zlibVersion(); return 0; }
 EOF
         if compile_prog "" "-lz" ; then
-            LIBS="$LIBS -lz"
+            zlib_libs=-lz
+            LIBS="$LIBS $zlib_libs"
         else
             error_exit "zlib check failed" \
                 "Make sure to have the zlib libs and headers installed."
@@ -6908,7 +6909,11 @@ fi
 if test "$posix_memalign" = "yes" ; then
   echo "CONFIG_POSIX_MEMALIGN=y" >> $config_host_mak
 fi
-
+if test "$zlib" != "no" ; then
+    echo "CONFIG_ZLIB=y" >> $config_host_mak
+    echo "ZLIB_CFLAGS=$zlib_cflags" >> $config_host_mak
+    echo "ZLIB_LIBS=$zlib_libs" >> $config_host_mak
+fi
 if test "$spice" = "yes" ; then
   echo "CONFIG_SPICE=y" >> $config_host_mak
 fi
@@ -7002,7 +7007,6 @@ if test "$qom_cast_debug" = "yes" ; then
 fi
 if test "$rbd" = "yes" ; then
   echo "CONFIG_RBD=m" >> $config_host_mak
-  echo "RBD_CFLAGS=$rbd_cflags" >> $config_host_mak
   echo "RBD_LIBS=$rbd_libs" >> $config_host_mak
 fi
 
diff --git a/meson.build b/meson.build
index b5aa6a2..a46b671 100644
--- a/meson.build
+++ b/meson.build
@@ -83,6 +83,21 @@ pam = declare_dependency()
 if 'CONFIG_AUTH_PAM' in config_host
   pam = cc.find_library('pam')
 endif
+libaio = cc.find_library('aio', required: false)
+zlib = declare_dependency()
+if 'CONFIG_ZLIB' in config_host
+  zlib = declare_dependency(compile_args: config_host['ZLIB_CFLAGS'].split(),
+                            link_args: config_host['ZLIB_LIBS'].split())
+endif
+libxml2 = declare_dependency()
+if 'CONFIG_LIBXML2' in config_host
+  libxml2 = declare_dependency(compile_args: config_host['LIBXML2_CFLAGS'].split(),
+                               link_args: config_host['LIBXML2_LIBS'].split())
+endif
+libnfs = declare_dependency()
+if 'CONFIG_LIBNFS' in config_host
+  libnfs = declare_dependency(link_args: config_host['LIBNFS_LIBS'].split())
+endif
 libattr = declare_dependency()
 if 'CONFIG_ATTR' in config_host
   libattr = declare_dependency(link_args: config_host['LIBATTR_LIBS'].split())
@@ -117,6 +132,32 @@ libudev = declare_dependency()
 if 'CONFIG_LIBUDEV' in config_host
   libudev = declare_dependency(link_args: config_host['LIBUDEV_LIBS'].split())
 endif
+rbd = declare_dependency()
+if 'CONFIG_RBD' in config_host
+  rbd = declare_dependency(link_args: config_host['RBD_LIBS'].split())
+endif
+glusterfs = declare_dependency()
+if 'CONFIG_GLUSTERFS' in config_host
+  glusterfs = declare_dependency(compile_args: config_host['GLUSTERFS_CFLAGS'].split(),
+                                 link_args: config_host['GLUSTERFS_LIBS'].split())
+endif
+vxhs = declare_dependency()
+if 'CONFIG_VXHS' in config_host
+  vxhs = declare_dependency(link_args: config_host['VXHS_LIBS'].split())
+endif
+libssh = declare_dependency()
+if 'CONFIG_LIBSSH' in config_host
+  libssh = declare_dependency(compile_args: config_host['LIBSSH_CFLAGS'].split(),
+                              link_args: config_host['LIBSSH_LIBS'].split())
+endif
+libbzip2 = declare_dependency()
+if 'CONFIG_BZIP2' in config_host
+  libbzip2 = declare_dependency(link_args: config_host['BZIP2_LIBS'].split())
+endif
+liblzfse = declare_dependency()
+if 'CONFIG_LZFSE' in config_host
+  liblzfse = declare_dependency(link_args: config_host['LZFSE_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -398,6 +439,18 @@ subdir('io')
 subdir('chardev')
 subdir('fsdev')
 
+block_ss.add(files(
+  'block.c',
+  'blockjob.c',
+  'job.c',
+  'qemu-io-cmds.c',
+))
+block_ss.add(when: 'CONFIG_REPLICATION', if_true: files('replication.c'))
+
+subdir('nbd')
+subdir('scsi')
+subdir('block')
+
 mods = []
 block_mods = []
 softmmu_mods = []
@@ -432,6 +485,15 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
                              capture: true,
                              command: [undefsym, nm, '@INPUT@'])
 
+block_ss = block_ss.apply(config_host, strict: false)
+libblock = static_library('block', block_ss.sources(),
+                          dependencies: [authz, crypto, io, block_ss.dependencies()],
+                          link_depends: block_syms,
+                          link_with: libqemuutil,
+                          name_suffix: 'fa',
+                          build_by_default: false)
+
+block = declare_dependency(link_whole: libblock, link_args: '@block.syms')
 
 foreach m : mods
   shared_module(m['dir'] + '-' + m['name'],
@@ -441,6 +503,7 @@ foreach m : mods
                 install_dir: config_host['qemu_moddir'])
 endforeach
 
+softmmu_ss.add(block)
 common_ss.add_all(when: 'CONFIG_SOFTMMU', if_true: softmmu_ss)
 common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
 
diff --git a/nbd/Makefile.objs b/nbd/Makefile.objs
deleted file mode 100644
index eb3dd44..0000000
--- a/nbd/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-block-obj-y += server.o client.o common.o
diff --git a/nbd/meson.build b/nbd/meson.build
new file mode 100644
index 0000000..0c00a77
--- /dev/null
+++ b/nbd/meson.build
@@ -0,0 +1,5 @@
+block_ss.add(files(
+  'client.c',
+  'common.c',
+  'server.c',
+))
diff --git a/rules.mak b/rules.mak
index 8571aec..162ecb5 100644
--- a/rules.mak
+++ b/rules.mak
@@ -374,8 +374,7 @@ define unnest-vars
             # Find all the .mo objects in variables and add dependency rules
             # according to .mo-objs. Report error if not set
             $(if $($o-objs),
-                $(eval $(o:%.mo=%$(DSOSUF)): module-common.o $($o-objs)),
-                $(error $o added in $v but $o-objs is not set)))
+                $(eval $(o:%.mo=%$(DSOSUF)): module-common.o $($o-objs))))
         $(shell mkdir -p ./ $(sort $(dir $($v))))
         # Include all the .d files
         $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$(filter %.o,$($v)))))
diff --git a/scripts/modules/module_block.py b/scripts/modules/module_block.py
old mode 100644
new mode 100755
diff --git a/scsi/Makefile.objs b/scsi/Makefile.objs
deleted file mode 100644
index bb8789c..0000000
--- a/scsi/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-block-obj-y += utils.o
-
-block-obj-$(CONFIG_LINUX) += pr-manager.o pr-manager-helper.o
-block-obj-$(call lnot,$(CONFIG_LINUX)) += pr-manager-stub.o
diff --git a/scsi/meson.build b/scsi/meson.build
new file mode 100644
index 0000000..53f3a1f
--- /dev/null
+++ b/scsi/meson.build
@@ -0,0 +1,4 @@
+block_ss.add(files('utils.c'))
+block_ss.add(when: 'CONFIG_LINUX',
+             if_true: files('pr-manager.c', 'pr-manager-helper.c'),
+             if_false: files('pr-manager-stub.c'))
-- 
1.8.3.1



