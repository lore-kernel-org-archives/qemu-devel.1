Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AADC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A5A221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ow/ipYkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A5A221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mD0-0002JY-Bg
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lR7-0002nB-9Y
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24262
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lR3-0006t1-NR
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkyiC31YIl0cu0rpw8f52jESdGw1MBfxzBOo1Zie2nw=;
 b=Ow/ipYkHHrhtJ0pelyPigLC0/tnrqA7AIxhV6UzfOxroW3yBJX95fKtlYK7O+ikwLx2z/U
 4BbCymi+EdBE3ubSHUcfOCtbmmOgYu6WNi8+xOVykcLbWLvyE9xCtV6TtVR1c5x2Ki6b+/
 7AP67llIhASPbuOzzgXNx9M/YnVBGUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-3Q4tvilpOyG_lIzHZre0BA-1; Thu, 06 Aug 2020 15:20:13 -0400
X-MC-Unique: 3Q4tvilpOyG_lIzHZre0BA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45DB6800468
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:20:12 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DDB05F9DC;
 Thu,  6 Aug 2020 19:20:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 126/143] meson: linux-user
Date: Thu,  6 Aug 2020 21:16:02 +0200
Message-Id: <1596741379-12902-127-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target                     |  3 ---
 configure                           | 27 ++++++++++++---------------
 linux-user/Makefile.objs            | 25 -------------------------
 linux-user/alpha/Makefile.objs      |  5 -----
 linux-user/alpha/meson.build        |  5 +++++
 linux-user/arm/Makefile.objs        |  8 --------
 linux-user/arm/meson.build          | 10 ++++++++++
 linux-user/arm/nwfpe/Makefile.objs  |  2 --
 linux-user/arm/nwfpe/meson.build    | 10 ++++++++++
 linux-user/hppa/Makefile.objs       |  5 -----
 linux-user/hppa/meson.build         |  5 +++++
 linux-user/i386/Makefile.objs       |  5 -----
 linux-user/i386/meson.build         |  5 +++++
 linux-user/i386/syscall_nr.h        |  1 +
 linux-user/m68k/Makefile.objs       |  5 -----
 linux-user/m68k/meson.build         |  5 +++++
 linux-user/meson.build              | 37 +++++++++++++++++++++++++++++++++++++
 linux-user/microblaze/Makefile.objs |  5 -----
 linux-user/microblaze/meson.build   |  5 +++++
 linux-user/mips/Makefile.objs       |  5 -----
 linux-user/mips/meson.build         |  5 +++++
 linux-user/mips/syscall_nr.h        |  1 +
 linux-user/mips64/Makefile.objs     | 12 ------------
 linux-user/mips64/meson.build       |  6 ++++++
 linux-user/mips64/syscall_nr.h      |  7 +++++++
 linux-user/ppc/Makefile.objs        |  6 ------
 linux-user/ppc/meson.build          |  5 +++++
 linux-user/s390x/Makefile.objs      |  5 -----
 linux-user/s390x/meson.build        |  5 +++++
 linux-user/sh4/Makefile.objs        |  5 -----
 linux-user/sh4/meson.build          |  5 +++++
 linux-user/sparc/Makefile.objs      |  5 -----
 linux-user/sparc/meson.build        |  5 +++++
 linux-user/sparc64/Makefile.objs    |  5 -----
 linux-user/sparc64/meson.build      |  5 +++++
 linux-user/x86_64/Makefile.objs     |  5 -----
 linux-user/x86_64/meson.build       |  5 +++++
 linux-user/x86_64/syscall_nr.h      |  1 +
 linux-user/xtensa/Makefile.objs     |  5 -----
 linux-user/xtensa/meson.build       |  5 +++++
 meson.build                         | 16 +++++++++++++++-
 41 files changed, 165 insertions(+), 132 deletions(-)
 delete mode 100644 linux-user/Makefile.objs
 delete mode 100644 linux-user/alpha/Makefile.objs
 create mode 100644 linux-user/alpha/meson.build
 delete mode 100644 linux-user/arm/Makefile.objs
 create mode 100644 linux-user/arm/meson.build
 delete mode 100644 linux-user/arm/nwfpe/Makefile.objs
 create mode 100644 linux-user/arm/nwfpe/meson.build
 delete mode 100644 linux-user/hppa/Makefile.objs
 create mode 100644 linux-user/hppa/meson.build
 delete mode 100644 linux-user/i386/Makefile.objs
 create mode 100644 linux-user/i386/meson.build
 create mode 100644 linux-user/i386/syscall_nr.h
 delete mode 100644 linux-user/m68k/Makefile.objs
 create mode 100644 linux-user/m68k/meson.build
 create mode 100644 linux-user/meson.build
 delete mode 100644 linux-user/microblaze/Makefile.objs
 create mode 100644 linux-user/microblaze/meson.build
 delete mode 100644 linux-user/mips/Makefile.objs
 create mode 100644 linux-user/mips/meson.build
 create mode 100644 linux-user/mips/syscall_nr.h
 delete mode 100644 linux-user/mips64/Makefile.objs
 create mode 100644 linux-user/mips64/meson.build
 create mode 100644 linux-user/mips64/syscall_nr.h
 delete mode 100644 linux-user/ppc/Makefile.objs
 create mode 100644 linux-user/ppc/meson.build
 delete mode 100644 linux-user/s390x/Makefile.objs
 create mode 100644 linux-user/s390x/meson.build
 delete mode 100644 linux-user/sh4/Makefile.objs
 create mode 100644 linux-user/sh4/meson.build
 delete mode 100644 linux-user/sparc/Makefile.objs
 create mode 100644 linux-user/sparc/meson.build
 delete mode 100644 linux-user/sparc64/Makefile.objs
 create mode 100644 linux-user/sparc64/meson.build
 delete mode 100644 linux-user/x86_64/Makefile.objs
 create mode 100644 linux-user/x86_64/meson.build
 create mode 100644 linux-user/x86_64/syscall_nr.h
 delete mode 100644 linux-user/xtensa/Makefile.objs
 create mode 100644 linux-user/xtensa/meson.build

diff --git a/Makefile.target b/Makefile.target
index 8633e2b..a68859d 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -131,9 +131,6 @@ QEMU_CFLAGS+=-I$(SRC_PATH)/linux-user/$(TARGET_ABI_DIR) \
              -I$(SRC_PATH)/linux-user \
              -Ilinux-user/$(TARGET_ABI_DIR)
 
-obj-y += linux-user/
-obj-y += gdbstub.o thunk.o
-
 endif #CONFIG_LINUX_USER
 
 #########################################################
diff --git a/configure b/configure
index 3483d6c..525f415 100755
--- a/configure
+++ b/configure
@@ -1945,20 +1945,6 @@ fi
 # Remove old dependency files to make sure that they get properly regenerated
 rm -f */config-devices.mak.d
 
-# Remove syscall_nr.h to be sure they will be regenerated in the build
-# directory, not in the source directory
-for arch in alpha hppa m68k xtensa sh4 microblaze arm ppc s390x sparc sparc64 \
-    i386 x86_64 mips mips64 ; do
-    # remove the file if it has been generated in the source directory
-    rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
-    # remove the dependency files
-    for target in ${arch}*-linux-user ; do
-        test -d "${target}" && find "${target}" -type f -name "*.d" \
-             -exec grep -q "${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
-             -print | while read file ; do rm "${file}" "${file%.d}.o" ; done
-    done
-done
-
 if test -z "$python"
 then
     error_exit "Python not found. Use --python=/path/to/python"
@@ -7925,18 +7911,22 @@ gdb_xml_files=""
 TARGET_ARCH="$target_name"
 TARGET_BASE_ARCH=""
 TARGET_ABI_DIR=""
+TARGET_SYSTBL_ABI=""
+TARGET_SYSTBL=""
 
 case "$target_name" in
   i386)
     mttcg="yes"
 	gdb_xml_files="i386-32bit.xml"
     TARGET_SYSTBL_ABI=i386
+    TARGET_SYSTBL=syscall_32.tbl
   ;;
   x86_64)
     TARGET_BASE_ARCH=i386
     TARGET_SYSTBL_ABI=common,64
+    TARGET_SYSTBL=syscall_64.tbl
     mttcg="yes"
-	gdb_xml_files="i386-64bit.xml"
+    gdb_xml_files="i386-64bit.xml"
   ;;
   alpha)
     mttcg="yes"
@@ -7984,6 +7974,7 @@ case "$target_name" in
     TARGET_ARCH=mips
     echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
     TARGET_SYSTBL_ABI=o32
+    TARGET_SYSTBL=syscall_o32.tbl
   ;;
   mipsn32|mipsn32el)
     mttcg="yes"
@@ -7992,6 +7983,7 @@ case "$target_name" in
     echo "TARGET_ABI_MIPSN32=y" >> $config_target_mak
     echo "TARGET_ABI32=y" >> $config_target_mak
     TARGET_SYSTBL_ABI=n32
+    TARGET_SYSTBL=syscall_n32.tbl
   ;;
   mips64|mips64el)
     mttcg="no"
@@ -7999,6 +7991,7 @@ case "$target_name" in
     TARGET_BASE_ARCH=mips
     echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
     TARGET_SYSTBL_ABI=n64
+    TARGET_SYSTBL=syscall_n64.tbl
   ;;
   moxie)
   ;;
@@ -8097,6 +8090,9 @@ esac
 if [ "$TARGET_BASE_ARCH" = "" ]; then
   TARGET_BASE_ARCH=$TARGET_ARCH
 fi
+if [ "$TARGET_SYSTBL_ABI" != "" ] && [ "$TARGET_SYSTBL" = "" ]; then
+  TARGET_SYSTBL=syscall.tbl
+fi
 
 symlink "$source_path/Makefile.target" "$target_dir/Makefile"
 
@@ -8117,6 +8113,7 @@ if [ "$HOST_VARIANT_DIR" != "" ]; then
 fi
 if [ "$TARGET_SYSTBL_ABI" != "" ]; then
     echo "TARGET_SYSTBL_ABI=$TARGET_SYSTBL_ABI" >> $config_target_mak
+    echo "TARGET_SYSTBL=$TARGET_SYSTBL" >> $config_target_mak
 fi
 
 if supported_xen_target $target; then
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
deleted file mode 100644
index 1940910..0000000
--- a/linux-user/Makefile.objs
+++ /dev/null
@@ -1,25 +0,0 @@
-obj-y = main.o syscall.o strace.o mmap.o signal.o \
-	elfload.o linuxload.o uaccess.o uname.o \
-	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
-        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
-
-obj-$(TARGET_HAS_BFLT) += flatload.o
-obj-$(TARGET_I386) += vm86.o
-obj-$(TARGET_AARCH64) += arm/semihost.o
-
-obj-$(TARGET_ALPHA) += alpha/
-obj-$(TARGET_ARM) += arm/
-obj-$(TARGET_HPPA) += hppa/
-obj-$(TARGET_I386) += i386/
-obj-$(TARGET_M68K) += m68k/
-obj-$(TARGET_MICROBLAZE) += microblaze/
-obj-$(TARGET_MIPS) += mips/
-obj-$(TARGET_MIPS64) += mips64/
-obj-$(TARGET_PPC) += ppc/
-obj-$(TARGET_PPC64) += ppc/
-obj-$(TARGET_S390X) += s390x/
-obj-$(TARGET_SH4) += sh4/
-obj-$(TARGET_SPARC) += sparc/
-obj-$(TARGET_SPARC64) += $(TARGET_ABI_DIR)/
-obj-$(TARGET_X86_64) += x86_64/
-obj-$(TARGET_XTENSA) += xtensa/
diff --git a/linux-user/alpha/Makefile.objs b/linux-user/alpha/Makefile.objs
deleted file mode 100644
index d6397a7..0000000
--- a/linux-user/alpha/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-generated-files-y += linux-user/alpha/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/alpha/syscallhdr.sh
-%/syscall_nr.h: $(SRC_PATH)/linux-user/alpha/syscall.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/alpha/meson.build b/linux-user/alpha/meson.build
new file mode 100644
index 0000000..a3cd22d
--- /dev/null
+++ b/linux-user/alpha/meson.build
@@ -0,0 +1,5 @@
+syscall_nr_generators += {
+  'alpha': generator(sh,
+                     arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                     output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/arm/Makefile.objs b/linux-user/arm/Makefile.objs
deleted file mode 100644
index c7eb94d..0000000
--- a/linux-user/arm/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-obj-$(TARGET_ARM) += nwfpe/
-obj-$(TARGET_ARM) += semihost.o
-
-generated-files-y += linux-user/arm/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/arm/syscallhdr.sh
-%/syscall_nr.h: $(SRC_PATH)/linux-user/arm/syscall.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/arm/meson.build b/linux-user/arm/meson.build
new file mode 100644
index 0000000..432984b
--- /dev/null
+++ b/linux-user/arm/meson.build
@@ -0,0 +1,10 @@
+linux_user_ss.add(when: 'TARGET_AARCH64', if_true: files('semihost.c'))
+linux_user_ss.add(when: 'TARGET_ARM', if_true: files('semihost.c'))
+
+subdir('nwfpe')
+
+syscall_nr_generators += {
+  'arm': generator(sh,
+                   arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                   output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/arm/nwfpe/Makefile.objs b/linux-user/arm/nwfpe/Makefile.objs
deleted file mode 100644
index 51b0c32..0000000
--- a/linux-user/arm/nwfpe/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y = fpa11.o fpa11_cpdo.o fpa11_cpdt.o fpa11_cprt.o fpopcode.o
-obj-y += single_cpdo.o double_cpdo.o extended_cpdo.o
diff --git a/linux-user/arm/nwfpe/meson.build b/linux-user/arm/nwfpe/meson.build
new file mode 100644
index 0000000..1c27e55
--- /dev/null
+++ b/linux-user/arm/nwfpe/meson.build
@@ -0,0 +1,10 @@
+linux_user_ss.add(when: 'TARGET_ARM', if_true: files(
+  'double_cpdo.c',
+  'extended_cpdo.c',
+  'fpa11.c',
+  'fpa11_cpdo.c',
+  'fpa11_cpdt.c',
+  'fpa11_cprt.c',
+  'fpopcode.c',
+  'single_cpdo.c',
+))
diff --git a/linux-user/hppa/Makefile.objs b/linux-user/hppa/Makefile.objs
deleted file mode 100644
index f8368be..0000000
--- a/linux-user/hppa/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-generated-files-y += linux-user/hppa/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/hppa/syscallhdr.sh
-%/syscall_nr.h: $(SRC_PATH)/linux-user/hppa/syscall.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/hppa/meson.build b/linux-user/hppa/meson.build
new file mode 100644
index 0000000..4709508
--- /dev/null
+++ b/linux-user/hppa/meson.build
@@ -0,0 +1,5 @@
+syscall_nr_generators += {
+  'hppa': generator(sh,
+                    arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                    output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/i386/Makefile.objs b/linux-user/i386/Makefile.objs
deleted file mode 100644
index c25cf17..0000000
--- a/linux-user/i386/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-generated-files-y += linux-user/i386/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/i386/syscallhdr.sh
-%/syscall_nr.h: $(SRC_PATH)/linux-user/i386/syscall_32.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/i386/meson.build b/linux-user/i386/meson.build
new file mode 100644
index 0000000..ee52301
--- /dev/null
+++ b/linux-user/i386/meson.build
@@ -0,0 +1,5 @@
+syscall_nr_generators += {
+  'i386': generator(sh,
+                    arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                    output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/i386/syscall_nr.h b/linux-user/i386/syscall_nr.h
new file mode 100644
index 0000000..976caab
--- /dev/null
+++ b/linux-user/i386/syscall_nr.h
@@ -0,0 +1 @@
+#include "syscall_32_nr.h"
diff --git a/linux-user/m68k/Makefile.objs b/linux-user/m68k/Makefile.objs
deleted file mode 100644
index 961bd05..0000000
--- a/linux-user/m68k/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-generated-files-y += linux-user/m68k/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/m68k/syscallhdr.sh
-%/syscall_nr.h: $(SRC_PATH)/linux-user/m68k/syscall.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/m68k/meson.build b/linux-user/m68k/meson.build
new file mode 100644
index 0000000..c0f436f
--- /dev/null
+++ b/linux-user/m68k/meson.build
@@ -0,0 +1,5 @@
+syscall_nr_generators += {
+  'm68k': generator(sh,
+                    arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                    output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/meson.build b/linux-user/meson.build
new file mode 100644
index 0000000..2b94e4b
--- /dev/null
+++ b/linux-user/meson.build
@@ -0,0 +1,37 @@
+linux_user_ss.add(files(
+  'elfload.c',
+  'exit.c',
+  'fd-trans.c',
+  'linuxload.c',
+  'main.c',
+  'mmap.c',
+  'safe-syscall.S',
+  'signal.c',
+  'strace.c',
+  'syscall.c',
+  'uaccess.c',
+  'uname.c',
+))
+linux_user_ss.add(rt)
+
+linux_user_ss.add(when: 'TARGET_HAS_BFLT', if_true: files('flatload.c'))
+linux_user_ss.add(when: 'TARGET_I386', if_true: files('vm86.c'))
+
+
+syscall_nr_generators = {}
+
+subdir('alpha')
+subdir('arm')
+subdir('hppa')
+subdir('i386')
+subdir('m68k')
+subdir('microblaze')
+subdir('mips64')
+subdir('mips')
+subdir('ppc')
+subdir('s390x')
+subdir('sh4')
+subdir('sparc64')
+subdir('sparc')
+subdir('x86_64')
+subdir('xtensa')
diff --git a/linux-user/microblaze/Makefile.objs b/linux-user/microblaze/Makefile.objs
deleted file mode 100644
index bb8b318..0000000
--- a/linux-user/microblaze/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-generated-files-y += linux-user/microblaze/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/microblaze/syscallhdr.sh
-%/syscall_nr.h: $(SRC_PATH)/linux-user/microblaze/syscall.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/microblaze/meson.build b/linux-user/microblaze/meson.build
new file mode 100644
index 0000000..f749d89
--- /dev/null
+++ b/linux-user/microblaze/meson.build
@@ -0,0 +1,5 @@
+syscall_nr_generators += {
+  'microblaze': generator(sh,
+                          arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                          output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/mips/Makefile.objs b/linux-user/mips/Makefile.objs
deleted file mode 100644
index 9be4de0..0000000
--- a/linux-user/mips/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-generated-files-y += linux-user/mips/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/mips/syscallhdr.sh
-%/syscall_nr.h: $(SRC_PATH)/linux-user/mips/syscall_o32.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI) "" 4000,"GEN","$@")
diff --git a/linux-user/mips/meson.build b/linux-user/mips/meson.build
new file mode 100644
index 0000000..6066a50
--- /dev/null
+++ b/linux-user/mips/meson.build
@@ -0,0 +1,5 @@
+syscall_nr_generators += {
+  'mips': generator(sh,
+                    arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                    output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/mips/syscall_nr.h b/linux-user/mips/syscall_nr.h
new file mode 100644
index 0000000..45d133c
--- /dev/null
+++ b/linux-user/mips/syscall_nr.h
@@ -0,0 +1 @@
+#include "syscall_o32_nr.h"
diff --git a/linux-user/mips64/Makefile.objs b/linux-user/mips64/Makefile.objs
deleted file mode 100644
index 573448f..0000000
--- a/linux-user/mips64/Makefile.objs
+++ /dev/null
@@ -1,12 +0,0 @@
-generated-files-y += linux-user/$(TARGET_ABI_DIR)/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/$(TARGET_ABI_DIR)/syscallhdr.sh
-
-ifeq ($(TARGET_SYSTBL_ABI),n32)
-%/syscall_nr.h: $(SRC_PATH)/linux-user/$(TARGET_ABI_DIR)/syscall_n32.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ n32 "" 6000,"GEN","$@")
-endif
-ifeq ($(TARGET_SYSTBL_ABI),n64)
-%/syscall_nr.h: $(SRC_PATH)/linux-user/$(TARGET_ABI_DIR)/syscall_n64.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ n64 "" 5000,"GEN","$@")
-endif
diff --git a/linux-user/mips64/meson.build b/linux-user/mips64/meson.build
new file mode 100644
index 0000000..0caab5f
--- /dev/null
+++ b/linux-user/mips64/meson.build
@@ -0,0 +1,6 @@
+syscall_nr_generators += {
+  'mips64': generator(sh,
+                      arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@',
+                                   '', 'TARGET_SYSCALL_OFFSET' ],
+                      output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/mips64/syscall_nr.h b/linux-user/mips64/syscall_nr.h
new file mode 100644
index 0000000..672f2fa
--- /dev/null
+++ b/linux-user/mips64/syscall_nr.h
@@ -0,0 +1,7 @@
+#ifdef TARGET_ABI_MIPSN32
+#define TARGET_SYSCALL_OFFSET 6000
+#include "syscall_n32_nr.h"
+#else
+#define TARGET_SYSCALL_OFFSET 5000
+#include "syscall_n64_nr.h"
+#endif
diff --git a/linux-user/ppc/Makefile.objs b/linux-user/ppc/Makefile.objs
deleted file mode 100644
index be92e67..0000000
--- a/linux-user/ppc/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-generated-files-y += linux-user/$(TARGET_ABI_DIR)/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/$(TARGET_ABI_DIR)/syscallhdr.sh
-
-%/syscall_nr.h: $(SRC_PATH)/linux-user/$(TARGET_ABI_DIR)/syscall.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/ppc/meson.build b/linux-user/ppc/meson.build
new file mode 100644
index 0000000..19fead7
--- /dev/null
+++ b/linux-user/ppc/meson.build
@@ -0,0 +1,5 @@
+syscall_nr_generators += {
+  'ppc': generator(sh,
+                   arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                   output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/s390x/Makefile.objs b/linux-user/s390x/Makefile.objs
deleted file mode 100644
index f30f162..0000000
--- a/linux-user/s390x/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-generated-files-y += linux-user/s390x/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/s390x/syscallhdr.sh
-%/syscall_nr.h: $(SRC_PATH)/linux-user/s390x/syscall.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/s390x/meson.build b/linux-user/s390x/meson.build
new file mode 100644
index 0000000..0781cce
--- /dev/null
+++ b/linux-user/s390x/meson.build
@@ -0,0 +1,5 @@
+syscall_nr_generators += {
+  's390x': generator(sh,
+                     arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                     output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/sh4/Makefile.objs b/linux-user/sh4/Makefile.objs
deleted file mode 100644
index 83fc939..0000000
--- a/linux-user/sh4/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-generated-files-y += linux-user/sh4/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/sh4/syscallhdr.sh
-%/syscall_nr.h: $(SRC_PATH)/linux-user/sh4/syscall.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/sh4/meson.build b/linux-user/sh4/meson.build
new file mode 100644
index 0000000..3bc3a69
--- /dev/null
+++ b/linux-user/sh4/meson.build
@@ -0,0 +1,5 @@
+syscall_nr_generators += {
+  'sh4': generator(sh,
+                   arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                   output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/sparc/Makefile.objs b/linux-user/sparc/Makefile.objs
deleted file mode 100644
index 29d3f06..0000000
--- a/linux-user/sparc/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-generated-files-y += linux-user/sparc/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/sparc/syscallhdr.sh
-%/syscall_nr.h: $(SRC_PATH)/linux-user/sparc/syscall.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/sparc/meson.build b/linux-user/sparc/meson.build
new file mode 100644
index 0000000..51a9c77
--- /dev/null
+++ b/linux-user/sparc/meson.build
@@ -0,0 +1,5 @@
+syscall_nr_generators += {
+  'sparc': generator(sh,
+                     arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                     output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/sparc64/Makefile.objs b/linux-user/sparc64/Makefile.objs
deleted file mode 100644
index afcd535..0000000
--- a/linux-user/sparc64/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-generated-files-y += linux-user/sparc64/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/sparc64/syscallhdr.sh
-%/syscall_nr.h: $(SRC_PATH)/linux-user/sparc/syscall.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/sparc64/meson.build b/linux-user/sparc64/meson.build
new file mode 100644
index 0000000..9527a40
--- /dev/null
+++ b/linux-user/sparc64/meson.build
@@ -0,0 +1,5 @@
+syscall_nr_generators += {
+  'sparc64': generator(sh,
+                       arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                       output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/x86_64/Makefile.objs b/linux-user/x86_64/Makefile.objs
deleted file mode 100644
index 2cef1d4..0000000
--- a/linux-user/x86_64/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-generated-files-y += linux-user/x86_64/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/x86_64/syscallhdr.sh
-%/syscall_nr.h: $(SRC_PATH)/linux-user/x86_64/syscall_64.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/x86_64/meson.build b/linux-user/x86_64/meson.build
new file mode 100644
index 0000000..203af9a
--- /dev/null
+++ b/linux-user/x86_64/meson.build
@@ -0,0 +1,5 @@
+syscall_nr_generators += {
+  'x86_64': generator(sh,
+                      arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                      output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/x86_64/syscall_nr.h b/linux-user/x86_64/syscall_nr.h
new file mode 100644
index 0000000..760302c
--- /dev/null
+++ b/linux-user/x86_64/syscall_nr.h
@@ -0,0 +1 @@
+#include "syscall_64_nr.h"
diff --git a/linux-user/xtensa/Makefile.objs b/linux-user/xtensa/Makefile.objs
deleted file mode 100644
index d4be1b7..0000000
--- a/linux-user/xtensa/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-generated-files-y += linux-user/xtensa/syscall_nr.h
-
-syshdr := $(SRC_PATH)/linux-user/xtensa/syscallhdr.sh
-%/syscall_nr.h: $(SRC_PATH)/linux-user/xtensa/syscall.tbl $(syshdr)
-	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/xtensa/meson.build b/linux-user/xtensa/meson.build
new file mode 100644
index 0000000..de77f3b
--- /dev/null
+++ b/linux-user/xtensa/meson.build
@@ -0,0 +1,5 @@
+syscall_nr_generators += {
+  'xtensa': generator(sh,
+                      arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                      output: '@BASENAME@_nr.h')
+}
diff --git a/meson.build b/meson.build
index 2b2f597..483e65f 100644
--- a/meson.build
+++ b/meson.build
@@ -678,6 +678,10 @@ subdir('net')
 subdir('replay')
 subdir('hw')
 subdir('accel')
+subdir('linux-user')
+
+linux_user_ss.add(files('gdbstub.c', 'thunk.c'))
+specific_ss.add_all(when: 'CONFIG_LINUX_USER', if_true: linux_user_ss)
 
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
@@ -775,6 +779,7 @@ foreach target : target_dirs
 
     arch_srcs += config_devices_h[target]
   else
+    abi = config_target['TARGET_ABI_DIR']
     target_type='user'
     qemu_target_name = 'qemu-' + target_name
     if 'CONFIG_LINUX_USER' in config_target
@@ -785,8 +790,17 @@ foreach target : target_dirs
     endif
     target_inc += include_directories(
       base_dir,
-      base_dir / config_target['TARGET_ABI_DIR'],
+      base_dir / abi,
     )
+    if 'CONFIG_LINUX_USER' in config_target
+      dir = base_dir / abi
+      arch_srcs += files(dir / 'signal.c', dir / 'cpu_loop.c')
+      if config_target.has_key('TARGET_SYSTBL_ABI')
+        arch_srcs += \
+          syscall_nr_generators[abi].process(base_dir / abi / config_target['TARGET_SYSTBL'],
+                                             extra_args : config_target['TARGET_SYSTBL_ABI'])
+      endif
+    endif
   endif
 
   t = target_arch[arch].apply(config_target, strict: false)
-- 
1.8.3.1



