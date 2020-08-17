Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBAFC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9952065D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5CUdI9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9952065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hKA-0004tF-U9
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gLF-0003jC-6E
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gLC-0006w6-3H
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LedXecCt40e9TDykDffC5QUZbSE0DrmbXRzfa5v82bk=;
 b=N5CUdI9PZZbiJS7X1YdZ7mvTI624bYvUL2hST4AlNP4eN3FCYMMDPwwd/HtAjKZ4GU83LC
 0y3mxCsJ8AEXAH8qPcpaxetYeZbHSYVozjriY86fIrfc43z5fDCoc9/F48sZ5RfG6aYzzT
 M/q8Ws4Z13tTs3zdIeoE+dQoFYlmypw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-8zeuQgKRNXqthvgw15hY5w-1; Mon, 17 Aug 2020 10:42:21 -0400
X-MC-Unique: 8zeuQgKRNXqthvgw15hY5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97C0F1DDE8
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:42:20 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B738070C3D;
 Mon, 17 Aug 2020 14:42:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 137/150] meson: sphinx-build
Date: Mon, 17 Aug 2020 16:40:40 +0200
Message-Id: <20200817144053.345107-42-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 01:24:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

For now, sphinx is run on every invocation of make.  The previous mechanism
using $(wildcard) is not reproducible in Meson and was also brittle; for
example some .rst.inc files were left out.  The next patch will introduce
a Sphinx extension to emit a depfile.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile           | 142 +++------------------------------------------
 configure          |   1 -
 docs/index.html.in |   4 +-
 docs/meson.build   |  68 ++++++++++++++++++++++
 meson.build        |   2 +
 rules.mak          |  48 ---------------
 6 files changed, 79 insertions(+), 186 deletions(-)
 create mode 100644 docs/meson.build

diff --git a/Makefile b/Makefile
index 175776d912..fe7e719075 100644
--- a/Makefile
+++ b/Makefile
@@ -124,36 +124,9 @@ $(call set-vpath, $(SRC_PATH))
 
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
-DOCS+=$(MANUAL_BUILDDIR)/system/qemu.1
-DOCS+=$(MANUAL_BUILDDIR)/tools/qemu-img.1
-DOCS+=$(MANUAL_BUILDDIR)/tools/qemu-nbd.8
-DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-ga.8
-ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
-DOCS+=$(MANUAL_BUILDDIR)/tools/virtiofsd.1
-endif
-DOCS+=$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
 DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
-DOCS+=$(MANUAL_BUILDDIR)/system/qemu-cpu-models.7
-DOCS+=$(MANUAL_BUILDDIR)/index.html
-ifdef CONFIG_VIRTFS
-DOCS+=$(MANUAL_BUILDDIR)/tools/virtfs-proxy-helper.1
-endif
-ifdef CONFIG_TRACE_SYSTEMTAP
-DOCS+=$(MANUAL_BUILDDIR)/tools/qemu-trace-stap.1
-endif
 else
 DOCS=
 endif
@@ -237,11 +210,6 @@ dist: qemu-$(VERSION).tar.bz2
 qemu-%.tar.bz2:
 	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.bz2,%,$@)"
 
-define clean-manual =
-rm -rf $(MANUAL_BUILDDIR)/$1/_static
-rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUILDDIR)/$1/searchindex.js $(MANUAL_BUILDDIR)/$1/*.html
-endef
-
 distclean: clean ninja-distclean
 	-test -f ninjatool && ./ninjatool $(if $(V),-v,) -t clean -g
 	rm -f config-host.mak config-host.h* $(DOCS)
@@ -261,13 +229,6 @@ distclean: clean ninja-distclean
 	rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
 	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
-	rm -rf .doctrees
-	$(call clean-manual,devel)
-	$(call clean-manual,interop)
-	$(call clean-manual,specs)
-	$(call clean-manual,system)
-	$(call clean-manual,tools)
-	$(call clean-manual,user)
 	rm -Rf .sdk
 
 KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv \
@@ -301,28 +262,8 @@ else
 BLOBS=
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
-	$(call install-manual,system)
-	$(call install-manual,tools)
-	$(call install-manual,user)
-
-install-doc: $(DOCS) install-sphinxdocs
+install-doc: $(DOCS)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/index.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/interop"
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)/interop"
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)/interop"
 ifdef CONFIG_POSIX
@@ -330,19 +271,7 @@ ifdef CONFIG_POSIX
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
-ifeq ($(CONFIG_TOOLS),y)
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-img.1 "$(DESTDIR)$(mandir)/man1"
-	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-nbd.8 "$(DESTDIR)$(mandir)/man8"
-endif
-ifdef CONFIG_TRACE_SYSTEMTAP
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
-endif
 ifeq ($(CONFIG_GUEST_AGENT),y)
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/interop"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)/interop"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)/interop"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
@@ -429,69 +358,6 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
 %.pdf: %.texi docs/version.texi
 	$(call quiet-command,texi2pdf $(TEXI2PDFFLAGS) $< -o $@,"GEN","$@")
 
-# Sphinx builds all its documentation at once in one invocation
-# and handles "don't rebuild things unless necessary" itself.
-# The '.doctrees' files are cached information to speed this up.
-.PHONY: sphinxdocs
-sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
-            $(MANUAL_BUILDDIR)/interop/index.html \
-            $(MANUAL_BUILDDIR)/specs/index.html \
-            $(MANUAL_BUILDDIR)/system/index.html \
-            $(MANUAL_BUILDDIR)/tools/index.html \
-            $(MANUAL_BUILDDIR)/user/index.html
-
-# Canned command to build a single manual
-# Arguments: $1 = manual name, $2 = Sphinx builder ('html' or 'man')
-# Note the use of different doctree for each (manual, builder) tuple;
-# this works around Sphinx not handling parallel invocation on
-# a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
-build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" $(SPHINX_BUILD) $(if $(V),,-q) $(SPHINX_WERROR) -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
-# We assume all RST files in the manual's directory are used in it
-manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst $(SRC_PATH)/docs/$1/*/*.rst) \
-              $(SRC_PATH)/docs/defs.rst.inc \
-              $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py \
-              $(SRC_PATH)/docs/sphinx/*.py
-# Macro to write out the rule and dependencies for building manpages
-# Usage: $(call define-manpage-rule,manualname,manpage1 manpage2...[,extradeps])
-# 'extradeps' is optional, and specifies extra files (eg .hx files) that
-# the manual page depends on.
-define define-manpage-rule
-$(call atomic,$(foreach manpage,$2,$(MANUAL_BUILDDIR)/$1/$(manpage)),$(call manual-deps,$1) $3)
-	$(call build-manual,$1,man)
-endef
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
-$(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system) $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/qemu-options.hx
-	$(call build-manual,system,html)
-
-$(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools) $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc
-	$(call build-manual,tools,html)
-
-$(MANUAL_BUILDDIR)/user/index.html: $(call manual-deps,user)
-	$(call build-manual,user,html)
-
-$(call define-manpage-rule,interop,qemu-ga.8)
-
-$(call define-manpage-rule,system,qemu.1 qemu-block-drivers.7 qemu-cpu-models.7)
-
-$(call define-manpage-rule,tools,\
-       qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
-       virtiofsd.1 virtfs-proxy-helper.1,\
-       $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc)
-
-$(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
-	@mkdir -p "$(MANUAL_BUILDDIR)"
-	$(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
-             "GEN","$@")
-
 docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 	@cp -p $< $@
 
@@ -514,6 +380,12 @@ docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-ref.html \
 	docs/interop/qemu-qmp-ref.texi docs/interop/qemu-qmp-qapi.texi
 
 $(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
+	$(call quiet-command, \
+	  perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl $(TEXI2PODFLAGS) $< $@.pod && \
+	  $(POD2MAN) --section=$(subst .,,$(suffix $@)) --center=" " --release=" " $@.pod > $@, \
+	  "GEN","$@")
+
+man: $(filter %.1 %.7 %.8,$(DOCS))
 
 ifdef CONFIG_WIN32
 
diff --git a/configure b/configure
index 840a90d987..d1cdd9155f 100755
--- a/configure
+++ b/configure
@@ -7775,7 +7775,6 @@ echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
 echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
-echo "SPHINX_WERROR=$sphinx_werror" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
diff --git a/docs/index.html.in b/docs/index.html.in
index 6736fa4360..ca28047881 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -2,10 +2,10 @@
 <html lang="en">
     <head>
         <meta charset="UTF-8">
-        <title>QEMU @@VERSION@@ Documentation</title>
+        <title>QEMU @VERSION@ Documentation</title>
     </head>
     <body>
-        <h1>QEMU @@VERSION@@ Documentation</h1>
+        <h1>QEMU @VERSION@ Documentation</h1>
         <ul>
             <li><a href="system/index.html">System Emulation User's Guide</a></li>
             <li><a href="user/index.html">User Mode Emulation User's Guide</a></li>
diff --git a/docs/meson.build b/docs/meson.build
new file mode 100644
index 0000000000..20fc92e2fe
--- /dev/null
+++ b/docs/meson.build
@@ -0,0 +1,68 @@
+SPHINX_ARGS = [config_host['SPHINX_BUILD'],
+               '-Dversion=' + meson.project_version(),
+               '-Drelease=' + config_host['PKGVERSION']]
+
+if get_option('werror')
+  SPHINX_ARGS += [ '-W' ]
+endif
+
+if build_docs
+  configure_file(output: 'index.html',
+                 input: files('index.html.in'),
+                 configuration: {'VERSION': meson.project_version()},
+                 install_dir: config_host['qemu_docdir'])
+  manuals = [ 'devel', 'interop', 'tools', 'specs', 'system', 'user' ]
+  man_pages = {
+    'interop' : {
+        'qemu-ga.8': (have_tools ? 'man8' : ''),
+    },
+    'tools': {
+        'qemu-img.1': (have_tools ? 'man1' : ''),
+        'qemu-nbd.8': (have_tools ? 'man8' : ''),
+        'qemu-trace-stap.1': (config_host.has_key('CONFIG_TRACE_SYSTEMTAP') ? 'man1' : ''),
+        'virtfs-proxy-helper.1': (have_virtfs_proxy_helper ? 'man1' : ''),
+        'virtiofsd.1': (have_virtiofsd ? 'man1' : ''),
+    },
+    'system': {
+        'qemu.1': 'man1',
+        'qemu-block-drivers.7': 'man7',
+        'qemu-cpu-models.7': 'man7'
+    },
+  }
+
+  sphinxdocs = []
+  sphinxmans = []
+  foreach manual : manuals
+    private_dir = meson.current_build_dir() / (manual + '.p')
+    input_dir = meson.current_source_dir() / manual
+    sphinxdocs += custom_target(manual + ' manual',
+                build_always_stale: true,
+                build_by_default: build_docs,
+                output: manual,
+                command: [SPHINX_ARGS, '-b', 'html', '-d', private_dir,
+                          input_dir, meson.current_build_dir() / manual])
+    if build_docs and manual != 'devel'
+      install_subdir(meson.current_build_dir() / manual,
+                     install_dir: config_host['qemu_docdir'])
+    endif
+
+    these_man_pages = []
+    install_dirs = []
+    foreach page, section : man_pages.get(manual, {})
+      these_man_pages += page
+      install_dirs += section == '' ? false : get_option('mandir') / section
+    endforeach
+    if these_man_pages.length() > 0
+      sphinxmans += custom_target(manual + ' man pages',
+                         build_always_stale: true,
+                         build_by_default: build_docs,
+                         output: these_man_pages,
+                         install: build_docs,
+                         install_dir: install_dirs,
+                         command: [SPHINX_ARGS, '-b', 'man', '-d', private_dir,
+                                   input_dir, meson.current_build_dir()])
+    endif
+  endforeach
+  alias_target('sphinxdocs', sphinxdocs)
+  alias_target('man', sphinxmans)
+endif
diff --git a/meson.build b/meson.build
index 8ff7aada2c..bce7580726 100644
--- a/meson.build
+++ b/meson.build
@@ -11,6 +11,7 @@ cc = meson.get_compiler('c')
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
 config_all_disas = keyval.load(meson.current_build_dir() / 'config-all-disas.mak')
 enable_modules = 'CONFIG_MODULES' in config_host
+build_docs = 'BUILD_DOCS' in config_host
 
 add_project_arguments(config_host['QEMU_CFLAGS'].split(),
                       language: ['c', 'objc'])
@@ -1047,6 +1048,7 @@ endif
 subdir('tools')
 subdir('pc-bios')
 subdir('tests')
+subdir('docs')
 
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
diff --git a/rules.mak b/rules.mak
index 6d89001f0a..6cab0b9cbd 100644
--- a/rules.mak
+++ b/rules.mak
@@ -375,53 +375,5 @@ define unnest-vars
         $(eval $v := $(filter-out %/,$($v))))
 endef
 
-TEXI2MAN = $(call quiet-command, \
-	perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl $(TEXI2PODFLAGS) $< $@.pod && \
-	$(POD2MAN) --section=$(subst .,,$(suffix $@)) --center=" " --release=" " $@.pod > $@, \
-	"GEN","$@")
-
-%.1:
-	$(call TEXI2MAN)
-%.7:
-	$(call TEXI2MAN)
-%.8:
-	$(call TEXI2MAN)
-
-# Support for building multiple output files by atomically executing
-# a single rule which depends on several input files (so the rule
-# will be executed exactly once, not once per output file, and
-# not multiple times in parallel.) For more explanation see:
-# https://www.cmcrossroads.com/article/atomic-rules-gnu-make
-
-# Given a space-separated list of filenames, create the name of
-# a 'sentinel' file to use to indicate that they have been built.
-# We use fixed text on the end to avoid accidentally triggering
-# automatic pattern rules, and . on the start to make the file
-# not show up in ls output.
-sentinel = .$(subst $(SPACE),_,$(subst /,_,$1)).sentinel.
-
-# Define an atomic rule that builds multiple outputs from multiple inputs.
-# To use:
-#    $(call atomic,out1 out2 ...,in1 in2 ...)
-#    <TAB>rule to do the operation
-#
-# Make 4.3 will have native support for this, and you would be able
-# to instead write:
-#    out1 out2 ... &: in1 in2 ...
-#    <TAB>rule to do the operation
-#
-# The way this works is that it creates a make rule
-# "out1 out2 ... : sentinel-file ; @:" which says that the sentinel
-# depends on the dependencies, and the rule to do that is "do nothing".
-# Then we have a rule
-# "sentinel-file : in1 in2 ..."
-# whose commands start with "touch sentinel-file" and then continue
-# with the rule text provided by the user of this 'atomic' function.
-# The foreach... is there to delete the sentinel file if any of the
-# output files don't exist, so that we correctly rebuild in that situation.
-atomic = $(eval $1: $(call sentinel,$1) ; @:) \
-         $(call sentinel,$1) : $2 ; @touch $$@ \
-         $(foreach t,$1,$(if $(wildcard $t),,$(shell rm -f $(call sentinel,$1))))
-
 print-%:
 	@echo '$*=$($*)'
-- 
2.26.2



