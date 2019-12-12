Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B75C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600582077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQVWl8sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600582077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifO8i-00078G-WB
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy6-00033v-0W
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy3-00069M-Q1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:21 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:44405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNy3-00067l-GF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:19 -0500
Received: by mail-wr1-x42e.google.com with SMTP id q10so2580107wrm.11
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h2WmlWx3TeSk0rWNd7ZO7z25+/tVsJHnbWq8wdQ78Ho=;
 b=EQVWl8sxOJQPqjWydrB0WUQBAyJa5SSUv9km4MgiTocNzll6i9rA2ZAOOStXK8o2KH
 tc+iDE9FKePeLryNv2CNnLM7rUxmd4YpUhb7BVtGtQ6GS0fPVTdBOSmI4k7gAmCSLk/a
 O+IS4KzFpg7eV3EY/PLIqxW3y+QE9YKkc6NY9vaf0BvaUMVGYV4UmgdpNRBonk4zwKyV
 BlHfLBzvkF7ZGtHJ+TBBtCKhnrXIYsMtsE+IRmoNOTo1Z4gQRL4blCAjV9O3zOpO0YDb
 R/NR9n6egR4a64/nvurlqYEHxPNohQjcAQXs5trspwuk9ASYVgeWqZbnQnTqTVu0VwAJ
 pFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=h2WmlWx3TeSk0rWNd7ZO7z25+/tVsJHnbWq8wdQ78Ho=;
 b=jfvS4fJzaJSE59WfT93qGBMhHmlci4Gyyze0gR4IngCGIBS/HieHc/iEALdMnlWqVr
 hLWPdUSNul38P3oLFsyMDqX6Tnmx/M6ciPQsibgSbahQx+pGLV7RIk02RuTGCxyFsmac
 qbBLjbLAZ9rav/vjjLfxCvbYG2KHbvTBYrafTr0wM2vfXmNY6iPfdjKY7S9A0OYRvu/I
 q+x5eY0vt4ycLS/BRmmxiCa0pjTlNrFfSCv9beVHbpS7pgKK86xie0kKZegspxKh06eH
 ezpLXu7GFRM5YIOBqEeRACZtVXWx899T+9Q1cxbsD2L2A2qolo5SPXc6Qf4I+uvR+4eE
 FZOg==
X-Gm-Message-State: APjAAAXr9nXm3bTuXl30QWC7V8UTu4KnNl9JGjkI2gZyXSqGSPk1+W+y
 kwr2NGtFmkHM/4GxCL1Qr1FEcbh4
X-Google-Smtp-Source: APXvYqxKU8ymnOTCaG/pSxg83lOx5K+rGlav2WpVTcsT6kQWzqlY9fsx6IhjDeIHOhfW21kzooK1Wg==
X-Received: by 2002:a5d:4d0e:: with SMTP id z14mr5994213wrt.208.1576155198112; 
 Thu, 12 Dec 2019 04:53:18 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 020/132] meson: convert qemu-ga
Date: Thu, 12 Dec 2019 13:51:04 +0100
Message-Id: <1576155176-2464-21-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                  | 44 ++++++--------------------------------------
 Makefile.objs             |  1 -
 configure                 |  9 ++++-----
 meson.build               |  8 ++++++++
 qga/Makefile.objs         |  8 --------
 qga/installer/qemu-ga.wxs |  2 +-
 qga/meson.build           | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include    |  4 ++--
 tests/test-qga.c          |  8 ++++----
 9 files changed, 68 insertions(+), 59 deletions(-)
 create mode 100644 qga/meson.build

diff --git a/Makefile b/Makefile
index 6f2141f..a78d5e0 100644
--- a/Makefile
+++ b/Makefile
@@ -261,7 +261,6 @@ endif
 dummy := $(call unnest-vars,, \
                 authz-obj-y \
                 chardev-obj-y \
-                qga-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -393,44 +392,15 @@ endif
 qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
-qemu-ga$(EXESUF): LIBS = $(LIBS_QGA)
-qemu-ga$(EXESUF): QEMU_CFLAGS += -I qga/qapi-generated
-
 qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
 qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
 
-qapi-py = $(SRC_PATH)/scripts/qapi/commands.py \
-$(SRC_PATH)/scripts/qapi/events.py \
-$(SRC_PATH)/scripts/qapi/introspect.py \
-$(SRC_PATH)/scripts/qapi/types.py \
-$(SRC_PATH)/scripts/qapi/visit.py \
-$(SRC_PATH)/scripts/qapi/common.py \
-$(SRC_PATH)/scripts/qapi/doc.py \
-$(SRC_PATH)/scripts/qapi-gen.py
-
-qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h \
-qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h \
-qga/qapi-generated/qga-qapi-commands.h qga/qapi-generated/qga-qapi-commands.c \
-qga/qapi-generated/qga-qapi-doc.texi: \
-qga/qapi-generated/qapi-gen-timestamp ;
-qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
-		-o qga/qapi-generated -p "qga-" $<, \
-		"GEN","$(@:%-timestamp=%)")
-	@>$@
-
-QGALIB_GEN=$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-visit.h qga-qapi-commands.h)
-$(qga-obj-y): $(QGALIB_GEN)
-
-qemu-ga$(EXESUF): $(qga-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-
 ifdef QEMU_GA_MSI_ENABLED
 QEMU_GA_MSI=qemu-ga-$(ARCH).msi
 
 msi: $(QEMU_GA_MSI)
 
-$(QEMU_GA_MSI): qemu-ga.exe $(QGA_VSS_PROVIDER)
+$(QEMU_GA_MSI): qga/qemu-ga.exe $(QGA_VSS_PROVIDER)
 
 $(QEMU_GA_MSI): config-host.mak
 
@@ -443,8 +413,8 @@ msi:
 endif
 
 ifneq ($(EXESUF),)
-.PHONY: qemu-ga
-qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
+.PHONY: qga/qemu-ga
+qga/qemu-ga: qga/qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
@@ -471,8 +441,6 @@ clean: recurse-clean
 	rm -f trace/generated-tracers-dtrace.dtrace*
 	rm -f trace/generated-tracers-dtrace.h*
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
-	rm -f qapi-gen-timestamp
-	rm -rf qga/qapi-generated
 	rm -f config-all-devices.mak
 
 VERSION ?= $(shell cat VERSION)
@@ -600,7 +568,7 @@ endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
 endif
-ifneq (,$(findstring qemu-ga,$(TOOLS)))
+ifeq ($(CONFIG_GUEST_AGENT),y)
 	$(INSTALL_DATA) qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
@@ -617,7 +585,7 @@ install-datadir:
 
 install-localstatedir:
 ifdef CONFIG_POSIX
-ifneq (,$(findstring qemu-ga,$(TOOLS)))
+ifeq ($(CONFIG_GUEST_AGENT),y)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_localstatedir)"/run
 endif
 endif
@@ -790,7 +758,7 @@ qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 	@cp -p $< $@
 
-docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
+docs/interop/qemu-ga-qapi.texi: qga/qga-qapi-doc.texi
 	@cp -p $< $@
 
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
diff --git a/Makefile.objs b/Makefile.objs
index e91cdb9..736bdaa 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -101,5 +101,4 @@ util-obj-y +=  trace/
 # FIXME: a few definitions from qapi/qapi-types.o and
 # qapi/qapi-visit.o are needed by libqemuutil.a.  These should be
 # extracted into a QAPI schema module, or perhaps a separate schema.
-qga-obj-y = qga/
 qga-vss-dll-obj-y = qga/
diff --git a/configure b/configure
index b38da39..4ed65db 100755
--- a/configure
+++ b/configure
@@ -3664,7 +3664,6 @@ for i in $glib_modules; do
         glib_libs=$($pkg_config --libs $i)
         QEMU_CFLAGS="$glib_cflags $QEMU_CFLAGS"
         LIBS="$glib_libs $LIBS"
-        libs_qga="$glib_libs $libs_qga"
     else
         error_exit "glib-$glib_req_ver $i is required to compile QEMU"
     fi
@@ -4795,7 +4794,6 @@ if compile_prog "" "" ; then
   :
 elif compile_prog "" "-lm" ; then
   LIBS="-lm $LIBS"
-  libs_qga="-lm $libs_qga"
 else
   error_exit "libm check failed"
 fi
@@ -4820,7 +4818,6 @@ if compile_prog "" "" ; then
 # we need pthread for static linking. use previous pthread test result
 elif compile_prog "" "$pthread_lib -lrt" ; then
   LIBS="$LIBS -lrt"
-  libs_qga="$libs_qga -lrt"
 fi
 
 # Check whether we need to link libutil for openpty()
@@ -6107,7 +6104,6 @@ if [ "$guest_agent" != "no" ]; then
   if [ "$softmmu" = no -a "$want_tools" = no ] ; then
       guest_agent=no
   elif [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" -o "$mingw32" = "yes" ] ; then
-      tools="qemu-ga\$(EXESUF) $tools"
       guest_agent=yes
   elif [ "$guest_agent" != yes ]; then
       guest_agent=no
@@ -6583,6 +6579,9 @@ fi
 if test "$want_tools" = "yes" ; then
   echo "CONFIG_TOOLS=y" >> $config_host_mak
 fi
+if test "$guest_agent" = "yes" ; then
+  echo "CONFIG_GUEST_AGENT=y" >> $config_host_mak
+fi
 if test "$slirp" != "no"; then
   echo "CONFIG_SLIRP=y" >> $config_host_mak
   echo "CONFIG_SMBD_COMMAND=\"$smbd\"" >> $config_host_mak
@@ -7349,7 +7348,7 @@ echo "PTHREAD_LIB=$PTHREAD_LIB" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
 echo "DSOSUF=$DSOSUF" >> $config_host_mak
 echo "LDFLAGS_SHARED=$LDFLAGS_SHARED" >> $config_host_mak
-echo "LIBS_QGA+=$libs_qga" >> $config_host_mak
+echo "LIBS_QGA=$libs_qga" >> $config_host_mak
 echo "TASN1_LIBS=$tasn1_libs" >> $config_host_mak
 echo "TASN1_CFLAGS=$tasn1_cflags" >> $config_host_mak
 echo "POD2MAN=$POD2MAN" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 25c3db9..f65ad9d 100644
--- a/meson.build
+++ b/meson.build
@@ -75,6 +75,10 @@ if 'CONFIG_CURL' in config_host
   curl = declare_dependency(compile_args: config_host['CURL_CFLAGS'].split(),
                             link_args: config_host['CURL_LIBS'].split())
 endif
+libudev = declare_dependency()
+if 'CONFIG_LIBUDEV' in config_host
+  libudev = declare_dependency(link_args: config_host['LIBUDEV_LIBS'].split())
+endif
 
 target_dirs = config_host['TARGET_DIRS'].split()
 have_user = false
@@ -211,6 +215,10 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 
 # Other build targets
 
+if 'CONFIG_GUEST_AGENT' in config_host
+  subdir('qga')
+endif
+
 if have_tools
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
diff --git a/qga/Makefile.objs b/qga/Makefile.objs
index 80e6bb3..9ecf249 100644
--- a/qga/Makefile.objs
+++ b/qga/Makefile.objs
@@ -1,9 +1 @@
-commands-posix.o-libs := $(LIBUDEV_LIBS)
-qga-obj-y = commands.o guest-agent-command-state.o main.o
-qga-obj-$(CONFIG_POSIX) += commands-posix.o channel-posix.o
-qga-obj-$(CONFIG_WIN32) += commands-win32.o channel-win32.o service-win32.o
-qga-obj-$(CONFIG_WIN32) += vss-win32.o
-qga-obj-y += qapi-generated/qga-qapi-types.o qapi-generated/qga-qapi-visit.o
-qga-obj-y += qapi-generated/qga-qapi-commands.o
-
 qga-vss-dll-obj-$(CONFIG_QGA_VSS) += vss-win32/
diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
index 64bf90b..ca2ac86 100644
--- a/qga/installer/qemu-ga.wxs
+++ b/qga/installer/qemu-ga.wxs
@@ -66,7 +66,7 @@
       <Directory Id="$(var.GaProgramFilesFolder)" Name="QEMU Guest Agent">
         <Directory Id="qemu_ga_directory" Name="Qemu-ga">
           <Component Id="qemu_ga" Guid="{908B7199-DE2A-4DC6-A8D0-27A5AE444FEA}">
-            <File Id="qemu_ga.exe" Name="qemu-ga.exe" Source="$(env.BUILD_DIR)/qemu-ga.exe" KeyPath="yes" DiskId="1"/>
+            <File Id="qemu_ga.exe" Name="qemu-ga.exe" Source="$(env.BUILD_DIR)/qga/qemu-ga.exe" KeyPath="yes" DiskId="1"/>
             <ServiceInstall
               Id="ServiceInstaller"
               Type="ownProcess"
diff --git a/qga/meson.build b/qga/meson.build
new file mode 100644
index 0000000..116102b
--- /dev/null
+++ b/qga/meson.build
@@ -0,0 +1,43 @@
+qga_qapi_outputs = [
+  'qga-qapi-commands.c',
+  'qga-qapi-commands.h',
+  'qga-qapi-doc.texi',
+  'qga-qapi-emit-events.c',
+  'qga-qapi-emit-events.h',
+  'qga-qapi-events.c',
+  'qga-qapi-events.h',
+  'qga-qapi-introspect.c',
+  'qga-qapi-introspect.h',
+  'qga-qapi-types.c',
+  'qga-qapi-types.h',
+  'qga-qapi-visit.c',
+  'qga-qapi-visit.h',
+]
+
+qga_qapi_files = custom_target('QGA QAPI files',
+                               output: qga_qapi_outputs,
+                               input: 'qapi-schema.json',
+                               command: [ qapi_gen, '-o', 'qga', '-p', 'qga-', '@INPUT0@' ],
+                               depend_files: qapi_gen_depends)
+qga_ss = ss.source_set()
+qga_ss.add(qga_qapi_files)
+qga_ss.add(files(
+  'commands.c',
+  'guest-agent-command-state.c',
+  'main.c',
+))
+qga_ss.add(when: 'CONFIG_POSIX', if_true: files(
+  'channel-posix.c',
+  'commands-posix.c'))
+qga_ss.add(when: 'CONFIG_WIN32', if_true: files(
+  'channel-win32.c',
+  'commands-win32.c',
+  'service-win32.c',
+  'vss-win32.c'
+))
+
+qga_ss = qga_ss.apply(config_host, strict: false)
+
+qga = executable('qemu-ga', qga_ss.sources(),
+                 link_args: config_host['LIBS_QGA'].split(),
+                 dependencies: [qemuutil, libudev])
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f3943de..9fd6a48 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -113,7 +113,7 @@ check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-cipher$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-crypto-secret$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlscredsx509$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlssession$(EXESUF)
-ifneq (,$(findstring qemu-ga,$(TOOLS)))
+ifeq ($(CONFIG_GUEST_AGENT),y)
 check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)
 endif
 check-unit-y += tests/test-timed-average$(EXESUF)
@@ -855,7 +855,7 @@ endif
 qtest-obj-y = tests/libqtest.o $(test-util-obj-y)
 $(check-qtest-y): $(qtest-obj-y)
 
-tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
+tests/test-qga$(EXESUF): qga/qemu-ga$(EXESUF)
 tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
 
 SPEED = quick
diff --git a/tests/test-qga.c b/tests/test-qga.c
index 41d4fc0..ef4d0b4 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -61,8 +61,8 @@ fixture_setup(TestFixture *fixture, gconstpointer data, gchar **envp)
 
     path = g_build_filename(fixture->test_dir, "sock", NULL);
     cwd = g_get_current_dir();
-    cmd = g_strdup_printf("%s%cqemu-ga -m unix-listen -t %s -p %s %s %s",
-                          cwd, G_DIR_SEPARATOR,
+    cmd = g_strdup_printf("%s%cqga%cqemu-ga -m unix-listen -t %s -p %s %s %s",
+                          cwd, G_DIR_SEPARATOR, G_DIR_SEPARATOR,
                           fixture->test_dir, path,
                           getenv("QTEST_LOG") ? "-v" : "",
                           extra_arg ?: "");
@@ -705,8 +705,8 @@ static void test_qga_config(gconstpointer data)
     GKeyFile *kf;
 
     cwd = g_get_current_dir();
-    cmd = g_strdup_printf("%s%cqemu-ga -D",
-                          cwd, G_DIR_SEPARATOR);
+    cmd = g_strdup_printf("%s%cqga%cqemu-ga -D",
+                          cwd, G_DIR_SEPARATOR, G_DIR_SEPARATOR);
     g_free(cwd);
     g_shell_parse_argv(cmd, NULL, &argv, &error);
     g_free(cmd);
-- 
1.8.3.1



