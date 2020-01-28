Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90546C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFF22467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcBh34H4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFF22467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWTM-0005EJ-Fv
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8N-0004v0-AQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8L-00015y-15
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:43 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:45425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8K-00012k-Md
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:40 -0500
Received: by mail-wr1-x435.google.com with SMTP id a6so2512841wrx.12
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qDLCPnXjd/iVjHweWz1qT0ww0/vBO7l7RrD/8qo57Hk=;
 b=OcBh34H4WJ+GgiSNW84/wAjA2FRc5At4htUh/r8kv86N18t5tiwxr8j+m6iiQNKP9s
 vsP/df5YdfyrzLoBskjJyzcVIqN0JawMRlP9yOD0N2+2aTGVAkF6WX1Fv6koQ/u4Szw8
 K1x3q5rIOw77UrARjcIEVZKyshf0J+dgFYnoGxx35Q0kTaOiEkYklgMF3wo0PeJWYLRM
 21TD6RHe6BD4rWxQvZMC/9thOQ9zo+wza62VM+Ahis1H79DuekPOj0XaHn3dQuFS9VIe
 768SpMK+xS5wrjiRu7j8ey/ICctmVbMHsmx1AxyjRh6Ddx8BDITzRRxIjfE8f4P7W4ce
 /aiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qDLCPnXjd/iVjHweWz1qT0ww0/vBO7l7RrD/8qo57Hk=;
 b=p79f6WkBylElHoNjK070QBP1ke2OOUpH7W/eCc7yABOxy+qO9ff7De709SGM7JUVw4
 B8vc3SLe2mON7EeGJkfU5L0Qbgqt3heT+jTc222KEEYgO4Ltnf0UVjYuPFnKbq73qZGE
 Qpiqj7EoU9yar/tUrME59GPFoBSniCgfbcrIv9DWCmtu/vpPz+bpBWWJMEPdSbeNTrYZ
 jk9VpxCGuDxAYH8Hn3jEtH2AP/JXnQxSq3QE9DE3bpSJ1D733atb7M9PEOkeM42fjId6
 toSmbGxmIV9PKkJrlyoUY6YZcJL9VfY479FThuZo6sB3jnpULgGLhxP6blpnBIDX21NM
 YPSQ==
X-Gm-Message-State: APjAAAXzQnEvQx4qRCVg/omsn1w2/SxBjmjtN2B842T8VifgDLrP2POM
 Pl6i72VtDGwnj+noFVTXmK3XYP3V
X-Google-Smtp-Source: APXvYqx5E6ZFrvT5cL/i3rWArR00ORfhLBw1L2T/G3BVZIoiPmm6PnY5Z/mWGERvW50eGU9de1FQ+w==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr28447293wrt.136.1580234319453; 
 Tue, 28 Jan 2020 09:58:39 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 123/142] meson: sphinx-build
Date: Tue, 28 Jan 2020 18:53:23 +0100
Message-Id: <20200128175342.9066-124-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
 Makefile         | 67 ++----------------------------------
 docs/meson.build | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 meson.build      |  2 ++
 3 files changed, 92 insertions(+), 65 deletions(-)
 create mode 100644 docs/meson.build

diff --git a/Makefile b/Makefile
index 898aa81232..c8681ddec7 100644
--- a/Makefile
+++ b/Makefile
@@ -121,19 +121,8 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-# Sphinx does not allow building manuals into the same directory as
-# the source files, so if we're doing an in-tree QEMU build we must
-# build the manuals into a subdirectory (and then install them from
-# there for 'make install'). For an out-of-tree build we can just
-# use the docs/ subdirectory in the build tree as normal.
-ifeq ($(realpath $(SRC_PATH)),$(realpath .))
-MANUAL_BUILDDIR := docs/built
-else
-MANUAL_BUILDDIR := docs
-endif
-
 ifdef BUILD_DOCS
-DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 $(MANUAL_BUILDDIR)/interop/qemu-ga.8
+DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
 DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
 DOCS+=docs/qemu-block-drivers.7
@@ -231,11 +220,6 @@ dist: qemu-$(VERSION).tar.bz2
 qemu-%.tar.bz2:
 	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.bz2,%,$@)"
 
-define clean-manual =
-rm -rf $(MANUAL_BUILDDIR)/$1/_static
-rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUILDDIR)/$1/searchindex.js $(MANUAL_BUILDDIR)/$1/*.html
-endef
-
 distclean: clean
 	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
 	rm -f tests/tcg/config-*.mak
@@ -257,10 +241,6 @@ distclean: clean
 	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
 	rm -f docs/qemu-block-drivers.7
 	rm -f docs/qemu-cpu-models.7
-	rm -rf .doctrees
-	$(call clean-manual,devel)
-	$(call clean-manual,interop)
-	$(call clean-manual,specs)
 	rm -Rf .sdk
 	if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
 
@@ -300,22 +280,7 @@ BLOBS=
 DESCS=
 endif
 
-# Note that we manually filter-out the non-Sphinx documentation which
-# is currently built into the docs/interop directory in the build tree,
-# and also any sphinx-built manpages.
-define install-manual =
-for d in $$(cd $(MANUAL_BUILDDIR) && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
-for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name '*.[0-9]' -o -name 'qemu-*-qapi.*' -o -name 'qemu-*-ref.*' ')' ); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
-endef
-
-# Note that we deliberately do not install the "devel" manual: it is
-# for QEMU developers, and not interesting to our users.
-.PHONY: install-sphinxdocs
-install-sphinxdocs: sphinxdocs
-	$(call install-manual,interop)
-	$(call install-manual,specs)
-
-install-doc: $(DOCS) install-sphinxdocs
+install-doc: $(DOCS)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
@@ -337,7 +302,6 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
 endif
 ifeq ($(CONFIG_GUEST_AGENT),y)
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
@@ -435,33 +399,6 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
 %.pdf: %.texi docs/version.texi
 	$(call quiet-command,texi2pdf $(TEXI2PDFFLAGS) $< -o $@,"GEN","$@")
 
-# Sphinx builds all its documentation at once in one invocation
-# and handles "don't rebuild things unless necessary" itself.
-# The '.doctrees' files are cached information to speed this up.
-.PHONY: sphinxdocs
-sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop/index.html $(MANUAL_BUILDDIR)/specs/index.html
-
-# Canned command to build a single manual
-# Arguments: $1 = manual name, $2 = Sphinx builder ('html' or 'man')
-# Note the use of different doctree for each (manual, builder) tuple;
-# this works around Sphinx not handling parallel invocation on
-# a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
-build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
-# We assume all RST files in the manual's directory are used in it
-manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
-
-$(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
-	$(call build-manual,devel,html)
-
-$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
-	$(call build-manual,interop,html)
-
-$(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
-	$(call build-manual,specs,html)
-
-$(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
-	$(call build-manual,interop,man)
-
 docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 	@cp -p $< $@
 
diff --git a/docs/meson.build b/docs/meson.build
new file mode 100644
index 0000000000..0f86c0b522
--- /dev/null
+++ b/docs/meson.build
@@ -0,0 +1,88 @@
+sphinx = find_program('sphinx-build', required: build_docs)
+
+SPHINX_ARGS = [sphinx, '-W', '-q', '-d', '@PRIVATE_DIR@',
+               '-Dversion=' + config_host['VERSION'],
+               '-Drelease=' + config_host['PKGVERSION']]
+
+if sphinx.found()
+  devel_rst = [
+    'devel/decodetree.rst',
+    'devel/index.rst',
+    'devel/kconfig.rst',
+    'devel/loads-stores.rst',
+    'devel/memory.rst',
+    'devel/migration.rst',
+    'devel/secure-coding-practices.rst',
+    'devel/stable-process.rst',
+    'devel/tcg.rst',
+    'devel/testing.rst',
+  ]
+  devel = custom_target('sphinx-devel',
+                build_by_default: build_docs,
+                input: devel_rst,
+                depend_files: [files('conf.py', 'devel/conf.py')],
+                output: 'devel',
+                command: [SPHINX_ARGS, '-b', 'html',
+                          meson.current_source_dir() / 'devel',
+                          '@OUTPUT@',
+                         ])
+
+  interop_rst = [
+    'interop/bitmaps.rst',
+    'interop/index.rst',
+    'interop/live-block-operations.rst',
+    'interop/qemu-ga.rst',
+    'interop/pr-helper.rst',
+    'interop/vhost-user-gpu.rst',
+    'interop/vhost-user.rst',
+  ]
+  interop_man_pages = []
+  if 'CONFIG_GUEST_AGENT' in config_host
+    interop_man_pages += ['qemu-ga.8']
+  endif
+  interop = custom_target('sphinx-interop',
+                build_by_default: build_docs,
+                input: interop_rst,
+                depend_files: [files('conf.py', 'interop/conf.py')],
+                output: 'interop',
+                command: [SPHINX_ARGS, '-b', 'html',
+                          meson.current_source_dir() / 'interop',
+                          '@OUTPUT@',
+                         ])
+  interop_man = custom_target('sphinx-interop-man',
+                   build_by_default: build_docs,
+                   input: interop_rst,
+                   depend_files: [files('conf.py', 'interop/conf.py')],
+                   output: interop_man_pages,
+                   install_dir: get_option('mandir') / 'man8',
+                   command: [SPHINX_ARGS, '-b', 'man',
+                             meson.current_source_dir() / 'interop',
+                             '@OUTPUT@',
+                            ])
+  if build_docs
+    install_subdir(meson.current_build_dir() / 'interop',
+                   install_dir: config_host['qemu_docdir'],
+                   exclude_directories: '.doctrees')
+  endif
+
+  specs_rst = [
+    'specs/index.rst',
+    'specs/ppc-spapr-xive.rst',
+    'specs/ppc-xive.rst',
+  ]
+  specs = custom_target('sphinx-specs',
+                input: specs_rst,
+                depend_files: [files('conf.py', 'specs/conf.py')],
+                output: 'specs',
+                command: [SPHINX_ARGS, '-b', 'html',
+                          meson.current_source_dir() / 'specs',
+                          '@OUTPUT@',
+                         ])
+  if build_docs
+    install_subdir(meson.current_build_dir() / 'specs',
+                   install_dir: config_host['qemu_docdir'],
+                   exclude_directories: '.doctrees')
+  endif
+
+  sphinxdocs = alias_target('sphinxdocs', devel, interop, interop_man, specs)
+endif
diff --git a/meson.build b/meson.build
index 0dd6d9f723..04068fd765 100644
--- a/meson.build
+++ b/meson.build
@@ -7,6 +7,7 @@ config_host = kconfig.load(meson.current_build_dir() / 'config-host.mak')
 config_all_disas = kconfig.load(meson.current_build_dir() / 'config-all-disas.mak')
 
 enable_modules = 'CONFIG_MODULES' in config_host
+build_docs = 'BUILD_DOCS' in config_host
 
 add_project_arguments(config_host['CFLAGS'].split(),
                       language: ['c', 'objc'])
@@ -949,3 +950,4 @@ if have_tools
 endif
 
 subdir('pc-bios')
+subdir('docs')
-- 
2.21.0



