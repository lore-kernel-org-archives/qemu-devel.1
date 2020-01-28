Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95EAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A609F207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQjMkAXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A609F207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVg0-0000uC-SK
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5Z-0000S5-2m
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5V-0002l2-F3
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:48 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:33790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5V-0002fQ-3c
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:45 -0500
Received: by mail-wr1-x433.google.com with SMTP id b6so17135533wrq.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O+iMWY8VnNG2ykkIUCP5K6vpZlAU1rES6icLM11xFGM=;
 b=VQjMkAXkGJDRub1mclyh1NXE5LkGeTCpSfttcp1RrP2nHlDXOtaPCG5daHNax48ZUF
 QR41WvrJ8fR7uOr0ou7B7/tNk8vYYkRYrJrPYoTUqYNh0xHSR+gYFmNGQLRgcF1VvrcU
 KIoExNGGaYVZogV8+0VRRYrA4oM0crDb/HYOe2d6SBWCBID5KJtVtztVSyqh7V+hFG2u
 /8KU0Xg7T/CWUhh6cGLfW15O0+Le5rdHhR5Qqkbqf+o7VujKXJYS4XbKhQClX5/bgyTJ
 dTbwhi7moq0Uj8R+crmmJhHNp7bxZcKuUYXpN1f57HevIZnY/ZDyKK+s8O1Mi6o5LofC
 MNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=O+iMWY8VnNG2ykkIUCP5K6vpZlAU1rES6icLM11xFGM=;
 b=jF227ivl6+Z4LoydI3+D9xhkmOkV9YoqQxNA/D1J1u43hcelvJsvqMcmq2XLEDdVk6
 0Xgz4igYJRO0WNpiEv53Sfx1z1ATyE+HT2hrJfqNbZpDFEs7ZUTkaW5GkenviTyCF6O9
 hG85UH7P83NdkEu9dGh0g6dIc0Mgnsm6TQjw2wjPEWvs/AKd2P43gU3GGb18wO3Ev1D2
 PcaMtrO3aWDqfdFvrAPc7USxV1Dlbmdp+6RhdA6vBDWGZSVdMVNSPgLeUTbtHI2rFMIb
 mT+OGM/EGDb9H1ydbqy72wW+jTeawpUsN9apjzaP3M920OPujhNgLwU3aWRjCz+yJT2F
 W8TA==
X-Gm-Message-State: APjAAAVgHbQek40Rr1nuL2L/Cl/364In+aNxi6cNi0rIWs1rcL737Le7
 0D6ulhutRMb6kMwUaJxvMd9vgCnU
X-Google-Smtp-Source: APXvYqy3h75+p7jifcu7eRL5Sw4Rf1SQRzhav6qv3tu7ehRQqatxeQUfIvllfPt+K9qkypwxmrDzBw==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr30130845wrn.83.1580234142731; 
 Tue, 28 Jan 2020 09:55:42 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 048/142] meson: convert block
Date: Tue, 28 Jan 2020 18:52:08 +0100
Message-Id: <20200128175342.9066-49-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
 Makefile                        |   8 ---
 Makefile.objs                   |  30 ++++++---
 Makefile.target                 |   3 +-
 block.c                         |   2 +-
 block/Makefile.objs             |  69 ---------------------
 block/meson.build               | 106 ++++++++++++++++++++++++++++++++
 configure                       |  10 ++-
 meson.build                     |  62 +++++++++++++++++++
 nbd/Makefile.objs               |   1 -
 nbd/meson.build                 |   5 ++
 rules.mak                       |   3 +-
 scripts/modules/module_block.py |   0
 scsi/Makefile.objs              |   4 --
 scsi/meson.build                |   4 ++
 14 files changed, 210 insertions(+), 97 deletions(-)
 delete mode 100644 block/Makefile.objs
 create mode 100644 block/meson.build
 delete mode 100644 nbd/Makefile.objs
 create mode 100644 nbd/meson.build
 mode change 100644 => 100755 scripts/modules/module_block.py
 delete mode 100644 scsi/Makefile.objs
 create mode 100644 scsi/meson.build

diff --git a/Makefile b/Makefile
index 3a83b178fc..292d2e46f3 100644
--- a/Makefile
+++ b/Makefile
@@ -106,7 +106,6 @@ include $(SRC_PATH)/rules.mak
 # lor is defined in rules.mak
 CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 
-generated-files-y += module_block.h
 generated-files-y += target/s390x/gen-features.h
 target/s390x/gen-features.h: Makefile.ninja
 
@@ -161,8 +160,6 @@ include $(SRC_PATH)/Makefile.objs
 endif
 
 dummy := $(call unnest-vars,, \
-                block-obj-y \
-                block-obj-m \
                 common-obj-y \
                 common-obj-m)
 
@@ -271,11 +268,6 @@ ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
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
index bc317060d7..bad4cb450a 100644
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
@@ -44,6 +50,16 @@ common-obj-$(CONFIG_LINUX) += fsdev/
 common-obj-y += accel/
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
index 68ec8fd83e..779a88bf8d 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -186,13 +186,12 @@ all-obj-y := $(obj-y)
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
index 1b6f7c86e8..227cb26f17 100644
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
deleted file mode 100644
index e394fe0b6c..0000000000
--- a/block/Makefile.objs
+++ /dev/null
@@ -1,69 +0,0 @@
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
-block-obj-y += block-copy.o
-
-block-obj-y += crypto.o
-
-block-obj-y += aio_task.o
-block-obj-y += backup-top.o
-
-common-obj-y += stream.o
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
index 0000000000..04e6e3c036
--- /dev/null
+++ b/block/meson.build
@@ -0,0 +1,106 @@
+block_ss.add(genh)
+block_ss.add(files(
+  'accounting.c',
+  'aio_task.c',
+  'backup.c',
+  'backup-top.c',
+  'blkdebug.c',
+  'blklogwrites.c',
+  'blkreplay.c',
+  'blkverify.c',
+  'block-backend.c',
+  'block-copy.c',
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
+softmmu_ss.add(files('stream.c'))
+
+modules += {'block': block_modules}
diff --git a/configure b/configure
index f5705bbf2e..a475268ed0 100755
--- a/configure
+++ b/configure
@@ -3802,7 +3802,8 @@ if test "$zlib" != "no" ; then
 int main(void) { zlibVersion(); return 0; }
 EOF
         if compile_prog "" "-lz" ; then
-            LIBS="$LIBS -lz"
+            zlib_libs=-lz
+            LIBS="$LIBS $zlib_libs"
         else
             error_exit "zlib check failed" \
                 "Make sure to have the zlib libs and headers installed."
@@ -7083,7 +7084,11 @@ fi
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
@@ -7177,7 +7182,6 @@ if test "$qom_cast_debug" = "yes" ; then
 fi
 if test "$rbd" = "yes" ; then
   echo "CONFIG_RBD=m" >> $config_host_mak
-  echo "RBD_CFLAGS=$rbd_cflags" >> $config_host_mak
   echo "RBD_LIBS=$rbd_libs" >> $config_host_mak
 fi
 
diff --git a/meson.build b/meson.build
index 2406cc72eb..7ea4413f9d 100644
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
@@ -121,6 +136,32 @@ libudev = declare_dependency()
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
@@ -415,6 +456,18 @@ subdir('chardev')
 subdir('fsdev')
 subdir('target')
 
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
@@ -449,6 +502,15 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
                              capture: true,
                              command: [undefsym, nm, '@INPUT@'])
 
+block_ss = block_ss.apply(config_host, strict: false)
+libblock = static_library('block', block_ss.sources(),
+                          dependencies: block_ss.dependencies(),
+                          link_depends: block_syms,
+                          name_suffix: 'fa',
+                          build_by_default: false)
+
+block = declare_dependency(link_whole: [libblock],
+                           link_args: '@block.syms')
 
 foreach m : mods
   shared_module(m['dir'] + '-' + m['name'],
diff --git a/nbd/Makefile.objs b/nbd/Makefile.objs
deleted file mode 100644
index eb3dd4461d..0000000000
--- a/nbd/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-block-obj-y += server.o client.o common.o
diff --git a/nbd/meson.build b/nbd/meson.build
new file mode 100644
index 0000000000..0c00a776d3
--- /dev/null
+++ b/nbd/meson.build
@@ -0,0 +1,5 @@
+block_ss.add(files(
+  'client.c',
+  'common.c',
+  'server.c',
+))
diff --git a/rules.mak b/rules.mak
index 8571aec190..162ecb5635 100644
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
index bb8789cd8b..0000000000
--- a/scsi/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-block-obj-y += utils.o
-
-block-obj-$(CONFIG_LINUX) += pr-manager.o pr-manager-helper.o
-block-obj-$(call lnot,$(CONFIG_LINUX)) += pr-manager-stub.o
diff --git a/scsi/meson.build b/scsi/meson.build
new file mode 100644
index 0000000000..53f3a1f716
--- /dev/null
+++ b/scsi/meson.build
@@ -0,0 +1,4 @@
+block_ss.add(files('utils.c'))
+block_ss.add(when: 'CONFIG_LINUX',
+             if_true: files('pr-manager.c', 'pr-manager-helper.c'),
+             if_false: files('pr-manager-stub.c'))
-- 
2.21.0



