Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74C7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA983214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqYclX9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA983214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVSM-0005Vc-Td
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4b-0007Be-Vd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4Z-0000Wq-Mi
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:49 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:41158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4Z-0000UV-Cx
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:47 -0500
Received: by mail-wr1-x429.google.com with SMTP id c9so17100616wrw.8
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WDI7EMET7LYG1lYAK2rDsuGhyRlhoSTDweW6a6jNMXI=;
 b=CqYclX9xp9sCmxXOzut1OmbGcAmP0L/USnQFB41HWBRFNOxKsBbRvqvK9CDBdEtZ2K
 L+OLyVnQR2yVA5qNhPKjCvioHszPhxXFmCGFwLT0/uM0uWxChBwuuJUg6SGGySK91S0n
 7oics60Dnv4HPBx2mNHGfUocEEFRu0SojEcNwtwrV8nwswuzhkL0RSnOYSKKECipkJZk
 2lW+OsRhgaiPKMI7l/etHXQvvL7DKYY6aaUW4iiWed5T1LViZ5P1owGolt+YThmXoV5U
 lAcME78QpmuiCHTrIath6pE4NmhJITlUclpTwqYuSd9te77z5QB3/6pqfO2EavqXFjn+
 Frbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WDI7EMET7LYG1lYAK2rDsuGhyRlhoSTDweW6a6jNMXI=;
 b=KLscoq71l0g2ae0/Mfl0a/r6HqiiRcuZtIec8eCY9QKkDGYjs09MBpjK/PBt6enHUS
 SyCyLcSvIbmkcOAC+SPbQOSVEcO057TkBCZ6rHYoxAYXRtfEl3vAw/t/r5SnM6ho9Uno
 QRUNa5mlTJTezmR4rubBLtxdzOn4Gs/2J50Jw47K7lAY1NEM6GJ3mO7weCLLUHdmMHxT
 CWYP9KEeE8H3UcNfctRvWfWd5bDfaN+xSzAjefCckSs1rk5oPHkjnEUPfoeV9hi+bboX
 Hv1C6Lf5UtdKzd2xEMxyHVG4QMqtogNU0hhqhWmkBeHEqZa1spY4vAM4T2JiXX65wACd
 Pzlw==
X-Gm-Message-State: APjAAAVNc5iN1/2lX0WwOspkemBsdMjdg1b0H4xGGmEXllWdvBOzMdBO
 F/k/xooklyFq4NpYvoFoEIzLDNVd
X-Google-Smtp-Source: APXvYqxEkExbnolWW1iSeJ3E3iDUOCRonqNJxj4KIkzMe2e/cHyXavrvgLBN8zVpjX/CqvyO+PFkOw==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr29682978wrs.365.1580234086176; 
 Tue, 28 Jan 2020 09:54:46 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 024/142] meson: convert qemu-ga
Date: Tue, 28 Jan 2020 18:51:44 +0100
Message-Id: <20200128175342.9066-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
 Makefile                  | 51 +++++----------------------------------
 Makefile.objs             |  1 -
 configure                 |  9 +++----
 meson.build               | 22 +++++++++++++++--
 qga/Makefile.objs         |  8 ------
 qga/installer/qemu-ga.wxs |  2 +-
 qga/meson.build           | 43 +++++++++++++++++++++++++++++++++
 tests/Makefile.include    |  4 +--
 tests/test-qga.c          |  8 +++---
 9 files changed, 80 insertions(+), 68 deletions(-)
 create mode 100644 qga/meson.build

diff --git a/Makefile b/Makefile
index 1ee3e8cb06..ab007ff60f 100644
--- a/Makefile
+++ b/Makefile
@@ -284,7 +284,6 @@ endif
 dummy := $(call unnest-vars,, \
                 authz-obj-y \
                 chardev-obj-y \
-                qga-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -421,51 +420,15 @@ endif
 qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
-qemu-ga$(EXESUF): LIBS = $(LIBS_QGA)
-qemu-ga$(EXESUF): QEMU_CFLAGS += -I qga/qapi-generated
-
 qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
 qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
 
-qapi-py = $(SRC_PATH)/scripts/qapi/__init__.py \
-$(SRC_PATH)/scripts/qapi/commands.py \
-$(SRC_PATH)/scripts/qapi/common.py \
-$(SRC_PATH)/scripts/qapi/doc.py \
-$(SRC_PATH)/scripts/qapi/error.py \
-$(SRC_PATH)/scripts/qapi/events.py \
-$(SRC_PATH)/scripts/qapi/expr.py \
-$(SRC_PATH)/scripts/qapi/gen.py \
-$(SRC_PATH)/scripts/qapi/introspect.py \
-$(SRC_PATH)/scripts/qapi/parser.py \
-$(SRC_PATH)/scripts/qapi/schema.py \
-$(SRC_PATH)/scripts/qapi/source.py \
-$(SRC_PATH)/scripts/qapi/types.py \
-$(SRC_PATH)/scripts/qapi/visit.py \
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
 
@@ -478,8 +441,8 @@ msi:
 endif
 
 ifneq ($(EXESUF),)
-.PHONY: qemu-ga
-qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
+.PHONY: qga/qemu-ga
+qga/qemu-ga: qga/qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
@@ -503,8 +466,6 @@ clean: recurse-clean
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
-	rm -f qapi-gen-timestamp
-	rm -rf qga/qapi-generated
 	rm -f config-all-devices.mak
 
 VERSION ?= $(shell cat VERSION)
@@ -623,7 +584,7 @@ endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
 endif
-ifneq (,$(findstring qemu-ga,$(TOOLS)))
+ifeq ($(CONFIG_GUEST_AGENT),y)
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
@@ -640,7 +601,7 @@ install-datadir:
 
 install-localstatedir:
 ifdef CONFIG_POSIX
-ifneq (,$(findstring qemu-ga,$(TOOLS)))
+ifeq ($(CONFIG_GUEST_AGENT),y)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_localstatedir)"/run
 endif
 endif
@@ -812,7 +773,7 @@ qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 	@cp -p $< $@
 
-docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
+docs/interop/qemu-ga-qapi.texi: qga/qga-qapi-doc.texi
 	@cp -p $< $@
 
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
diff --git a/Makefile.objs b/Makefile.objs
index 4ffe38c7b1..92321847d1 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -100,5 +100,4 @@ util-obj-y +=  trace/
 # FIXME: a few definitions from qapi/qapi-types.o and
 # qapi/qapi-visit.o are needed by libqemuutil.a.  These should be
 # extracted into a QAPI schema module, or perhaps a separate schema.
-qga-obj-y = qga/
 qga-vss-dll-obj-y = qga/
diff --git a/configure b/configure
index 6e107521d9..78cc3451ad 100755
--- a/configure
+++ b/configure
@@ -3738,7 +3738,6 @@ for i in $glib_modules; do
         glib_libs=$($pkg_config --libs $i)
         QEMU_CFLAGS="$glib_cflags $QEMU_CFLAGS"
         LIBS="$glib_libs $LIBS"
-        libs_qga="$glib_libs $libs_qga"
     else
         error_exit "glib-$glib_req_ver $i is required to compile QEMU"
     fi
@@ -4869,7 +4868,6 @@ if compile_prog "" "" ; then
   :
 elif compile_prog "" "-lm" ; then
   LIBS="-lm $LIBS"
-  libs_qga="-lm $libs_qga"
 else
   error_exit "libm check failed"
 fi
@@ -4894,7 +4892,6 @@ if compile_prog "" "" ; then
 # we need pthread for static linking. use previous pthread test result
 elif compile_prog "" "$pthread_lib -lrt" ; then
   LIBS="$LIBS -lrt"
-  libs_qga="$libs_qga -lrt"
 fi
 
 # Check whether we need to link libutil for openpty()
@@ -6251,7 +6248,6 @@ if [ "$guest_agent" != "no" ]; then
   if [ "$softmmu" = no -a "$want_tools" = no ] ; then
       guest_agent=no
   elif [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" -o "$mingw32" = "yes" ] ; then
-      tools="qemu-ga\$(EXESUF) $tools"
       guest_agent=yes
   elif [ "$guest_agent" != yes ]; then
       guest_agent=no
@@ -6737,6 +6733,9 @@ fi
 if test "$want_tools" = "yes" ; then
   echo "CONFIG_TOOLS=y" >> $config_host_mak
 fi
+if test "$guest_agent" = "yes" ; then
+  echo "CONFIG_GUEST_AGENT=y" >> $config_host_mak
+fi
 if test "$slirp" != "no"; then
   echo "CONFIG_SLIRP=y" >> $config_host_mak
   echo "CONFIG_SMBD_COMMAND=\"$smbd\"" >> $config_host_mak
@@ -7527,7 +7526,7 @@ echo "PTHREAD_LIB=$PTHREAD_LIB" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
 echo "DSOSUF=$DSOSUF" >> $config_host_mak
 echo "LDFLAGS_SHARED=$LDFLAGS_SHARED" >> $config_host_mak
-echo "LIBS_QGA+=$libs_qga" >> $config_host_mak
+echo "LIBS_QGA=$libs_qga" >> $config_host_mak
 echo "TASN1_LIBS=$tasn1_libs" >> $config_host_mak
 echo "TASN1_CFLAGS=$tasn1_cflags" >> $config_host_mak
 echo "POD2MAN=$POD2MAN" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 979e7f091d..04e11460a0 100644
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
@@ -89,13 +93,23 @@ have_block = have_system or have_tools
 # Generators
 
 qapi_gen = find_program('scripts/qapi-gen.py')
-qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/events.py',
+qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
+                     meson.source_root() / 'scripts/qapi/commands.py',
+                     meson.source_root() / 'scripts/qapi/common.py',
+                     meson.source_root() / 'scripts/qapi/doc.py',
+                     meson.source_root() / 'scripts/qapi/error.py',
+                     meson.source_root() / 'scripts/qapi/events.py',
+                     meson.source_root() / 'scripts/qapi/expr.py',
+                     meson.source_root() / 'scripts/qapi/gen.py',
                      meson.source_root() / 'scripts/qapi/introspect.py',
+                     meson.source_root() / 'scripts/qapi/parser.py',
+                     meson.source_root() / 'scripts/qapi/schema.py',
+                     meson.source_root() / 'scripts/qapi/source.py',
                      meson.source_root() / 'scripts/qapi/types.py',
                      meson.source_root() / 'scripts/qapi/visit.py',
                      meson.source_root() / 'scripts/qapi/common.py',
                      meson.source_root() / 'scripts/qapi/doc.py',
-                     meson.source_root() / 'scripts/qapi-gen.py' ]
+]
 
 # Collect sourcesets.
 
@@ -213,6 +227,10 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 
 # Other build targets
 
+if 'CONFIG_GUEST_AGENT' in config_host
+  subdir('qga')
+endif
+
 if have_tools
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
diff --git a/qga/Makefile.objs b/qga/Makefile.objs
index 80e6bb3c2e..9ecf2496da 100644
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
index 64bf90bd85..ca2ac86cb8 100644
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
index 0000000000..116102b865
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
index eaa57196f9..7838a45a18 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -118,7 +118,7 @@ check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-cipher$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-crypto-secret$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlscredsx509$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlssession$(EXESUF)
-ifneq (,$(findstring qemu-ga,$(TOOLS)))
+ifeq ($(CONFIG_GUEST_AGENT),y)
 check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)
 endif
 check-unit-y += tests/test-timed-average$(EXESUF)
@@ -871,7 +871,7 @@ endif
 qtest-obj-y = tests/libqtest.o $(test-util-obj-y)
 $(check-qtest-y): $(qtest-obj-y)
 
-tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
+tests/test-qga$(EXESUF): qga/qemu-ga$(EXESUF)
 tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
 
 SPEED = quick
diff --git a/tests/test-qga.c b/tests/test-qga.c
index d2b2435bb4..d1b4c3e8ce 100644
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
@@ -699,8 +699,8 @@ static void test_qga_config(gconstpointer data)
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
2.21.0



