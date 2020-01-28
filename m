Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07505C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2314214D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3DI5E2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2314214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWbW-0004im-Sc
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8T-00053u-Aa
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8Q-0001Lq-Q1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:49 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8Q-0001HL-FZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:46 -0500
Received: by mail-wm1-x343.google.com with SMTP id p9so3521438wmc.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D/DK8VQpigR6LqDpMI8lCYXI3QQOVMmBO7lwOM6akAY=;
 b=J3DI5E2Qmu6mcfhy4WIix0ZM027Ixwwjl3copCKSCp5h4DZPXHsMk7Io+bcU5CfenY
 IdK57sFOOPbQUtL8DO+YkjK/wfnnHnTYHBVwM+RZd3YxCeaSEukgmRC0VBb6J8Jfw3M4
 NP7SNffeXU2po1ycAjMlBKtkhofaN94GuwBi0z4alzBmQ/s4ZfZtwBFHrDXi5v/AylgU
 kF4zg4C+hKLMJ6zQ2m57p/AGXf78xRDwZv94V3vKrJ7bl9kx6kcshr6NnPdMiZryHjEE
 6CQwj4kLZc+j+Jy4IOzgWAHPj9fIbrcrFMC0j8zcY3BCUM6ajemFkdr6ejOAtats6yB2
 gJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=D/DK8VQpigR6LqDpMI8lCYXI3QQOVMmBO7lwOM6akAY=;
 b=Q8ySZ7mSCOU2rQF+bPDv0dTmlLfU/Lbjd34AHRTnVeJpdeMH5fC2Gn5EqHnaBcfQdQ
 xSxhFLWeLD6Gks+CifId9Ef7GPywxfC6e4WuJi1OT+O9nCRJ91m4G1pSqw+MBebgcrrm
 AatM5nOL3Ccqnwn8SbybOFUuWUn54MDI5qFuY+wPBssjEe04SPd2MIhkB5H9a70/6mKk
 pH47t22AAzNaRisOtOfOLfGvonilJLw0tZELmzwItOG4UIU4sMQS1js2h4OLSL77U4vX
 dhknq9W1KFVS33pU0qiNndlnEYmT+oOC0GcTCkT2yFTb1OVAPKLNH1Yx/6bPt1VygVr4
 eGwg==
X-Gm-Message-State: APjAAAXrNaFc/pIaenjGtzvLX7hfi6PiWNKNUbWL+UG52ANI7kWCYSN6
 MrS+kDH+TcN0PVRNm+lr7KuM3AQM
X-Google-Smtp-Source: APXvYqxNmkh4R4e2Lm51tOS78tQX4dIixEr1fjvmLWO918wolRwf/Zew7FhECmRP2KAfdDdj54JblQ==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr6523340wmb.33.1580234324154; 
 Tue, 28 Jan 2020 09:58:44 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 125/142] meson: build texi doc
Date: Tue, 28 Jan 2020 18:53:25 +0100
Message-Id: <20200128175342.9066-126-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 Makefile                       | 138 ++-------------------------------
 docs/interop/qemu-ga-ref.texi  |   2 +-
 docs/interop/qemu-qmp-ref.texi |   2 +-
 docs/meson.build               |   1 +
 meson.build                    | 115 ++++++++++++++++++++++++++-
 rules.mak                      |  12 ---
 6 files changed, 123 insertions(+), 147 deletions(-)

diff --git a/Makefile b/Makefile
index 2614138f62..e99d09c5ee 100644
--- a/Makefile
+++ b/Makefile
@@ -11,7 +11,6 @@ BUILD_DIR=$(CURDIR)
 SRC_PATH=.
 
 UNCHECKED_GOALS := %clean TAGS cscope ctags dist \
-    html info pdf txt \
     help check-help print-% \
     docker docker-% vm-help vm-test vm-build-%
 
@@ -114,29 +113,13 @@ edk2-decompressed = $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
 Makefile: ;
 configure: ;
 
-.PHONY: all clean cscope distclean html info install install-doc \
-	pdf txt recurse-all dist msi FORCE
+.PHONY: all clean cscope distclean install \
+	recurse-all dist msi FORCE
 
 $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-ifdef BUILD_DOCS
-DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8
-DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
-DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
-DOCS+=docs/qemu-block-drivers.7
-DOCS+=docs/qemu-cpu-models.7
-ifdef CONFIG_VIRTFS
-DOCS+=fsdev/virtfs-proxy-helper.1
-endif
-ifdef CONFIG_TRACE_SYSTEMTAP
-DOCS+=scripts/qemu-trace-stap.1
-endif
-else
-DOCS=
-endif
-
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet) BUILD_DIR=$(BUILD_DIR)
 
 ifneq ($(wildcard config-host.mak),)
@@ -145,7 +128,7 @@ endif
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) recurse-all modules
+all: recurse-all modules
 
 DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_srcdir=$(SRC_PATH)/dtc/libfdt
 DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
@@ -221,26 +204,14 @@ qemu-%.tar.bz2:
 	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.bz2,%,$@)"
 
 distclean: clean
-	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
+	rm -f config-host.mak config-host.h* config-host.ld
 	rm -f tests/tcg/config-*.mak
 	rm -f config-all-disas.mak config.status
 	rm -f po/*.mo tests/qemu-iotests/common.env
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
-	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
-	rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky qemu-doc.kys
-	rm -f qemu-doc.log qemu-doc.pdf qemu-doc.pg qemu-doc.toc qemu-doc.tp
-	rm -f qemu-doc.vr qemu-doc.txt
 	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -f config.log
 	rm -f linux-headers/asm
-	rm -f docs/version.texi
-	rm -f docs/interop/qemu-ga-qapi.texi docs/interop/qemu-qmp-qapi.texi
-	rm -f docs/interop/qemu-qmp-ref.7 docs/interop/qemu-ga-ref.7
-	rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
-	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
-	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
-	rm -f docs/qemu-block-drivers.7
-	rm -f docs/qemu-cpu-models.7
 	rm -Rf .sdk
 	if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
 
@@ -280,38 +251,6 @@ BLOBS=
 DESCS=
 endif
 
-install-doc: $(DOCS)
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)"
-ifdef CONFIG_POSIX
-	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
-	$(INSTALL_DATA) qemu.1 "$(DESTDIR)$(mandir)/man1"
-	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
-	$(INSTALL_DATA) docs/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
-	$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
-ifeq ($(CONFIG_TOOLS),y)
-	$(INSTALL_DATA) qemu-img.1 "$(DESTDIR)$(mandir)/man1"
-	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
-	$(INSTALL_DATA) qemu-nbd.8 "$(DESTDIR)$(mandir)/man8"
-endif
-ifdef CONFIG_TRACE_SYSTEMTAP
-	$(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
-endif
-ifeq ($(CONFIG_GUEST_AGENT),y)
-	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
-endif
-endif
-ifdef CONFIG_VIRTFS
-	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
-	$(INSTALL_DATA) fsdev/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
-endif
-
 install-datadir:
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
 
@@ -324,8 +263,7 @@ endif
 
 ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 
-install: all $(if $(BUILD_DOCS),install-doc) \
-	install-datadir install-localstatedir \
+install: all install-datadir install-localstatedir \
 	$(if $(INSTALL_BLOBS),$(edk2-decompressed))
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
@@ -372,66 +310,6 @@ endif
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
 	done
 
-# documentation
-MAKEINFO=makeinfo
-MAKEINFOINCLUDES= -I docs -I $(<D) -I $(@D)
-MAKEINFOFLAGS=--no-split --number-sections $(MAKEINFOINCLUDES)
-TEXI2PODFLAGS=$(MAKEINFOINCLUDES) -DVERSION="$(VERSION)" -DCONFDIR="$(qemu_confdir)"
-TEXI2PDFFLAGS=$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
-
-%.html: %.texi docs/version.texi
-	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
-	--html $< -o $@,"GEN","$@")
-
-%.info: %.texi docs/version.texi
-	$(call quiet-command,$(MAKEINFO) $(MAKEINFOFLAGS) $< -o $@,"GEN","$@")
-
-%.txt: %.texi docs/version.texi
-	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
-	--plaintext $< -o $@,"GEN","$@")
-
-%.pdf: %.texi docs/version.texi
-	$(call quiet-command,texi2pdf $(TEXI2PDFFLAGS) $< -o $@,"GEN","$@")
-
-docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
-	@cp -p $< $@
-
-docs/interop/qemu-ga-qapi.texi: qga/qga-qapi-doc.texi
-	@cp -p $< $@
-
-qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
-qemu.1: qemu-option-trace.texi
-qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
-fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
-qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
-docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
-docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
-scripts/qemu-trace-stap.1: scripts/qemu-trace-stap.texi
-
-html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
-info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
-pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
-txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
-
-qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
-	qemu-img.texi qemu-nbd.texi qemu-options.texi \
-	qemu-tech.texi qemu-option-trace.texi \
-	qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi \
-	qemu-monitor-info.texi docs/qemu-block-drivers.texi \
-	docs/qemu-cpu-models.texi docs/security.texi
-
-docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
-    docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
-    docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7: \
-	docs/interop/qemu-ga-ref.texi docs/interop/qemu-ga-qapi.texi
-
-docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-ref.html \
-    docs/interop/qemu-qmp-ref.info docs/interop/qemu-qmp-ref.pdf \
-    docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7: \
-	docs/interop/qemu-qmp-ref.texi docs/interop/qemu-qmp-qapi.texi
-
-$(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
-
 ifdef CONFIG_WIN32
 
 INSTALLER = qemu-setup-$(VERSION)$(EXESUF)
@@ -454,7 +332,7 @@ installer: $(INSTALLER)
 
 INSTDIR=/tmp/qemu-nsis
 
-$(INSTALLER): install-doc $(SRC_PATH)/qemu.nsi
+$(INSTALLER): $(SRC_PATH)/qemu.nsi
 	$(MAKE) install prefix=${INSTDIR}
 ifdef SIGNCODE
 	(cd ${INSTDIR}; \
@@ -525,10 +403,6 @@ endif
 	@echo  '  docker          - Help about targets running tests inside containers'
 	@echo  '  vm-help         - Help about targets running tests inside VM'
 	@echo  ''
-	@echo  'Documentation targets:'
-	@echo  '  html info pdf txt'
-	@echo  '                  - Build documentation in specified format'
-	@echo  ''
 ifdef CONFIG_WIN32
 	@echo  'Windows targets:'
 	@echo  '  installer       - Build NSIS-based installer for QEMU'
diff --git a/docs/interop/qemu-ga-ref.texi b/docs/interop/qemu-ga-ref.texi
index ddb76ce1c2..a23cc2ed7f 100644
--- a/docs/interop/qemu-ga-ref.texi
+++ b/docs/interop/qemu-ga-ref.texi
@@ -65,7 +65,7 @@ along with this manual.  If not, see http://www.gnu.org/licenses/.
 @c for texi2pod:
 @c man begin DESCRIPTION
 
-@include qemu-ga-qapi.texi
+@include qga/qga-qapi-doc.texi
 
 @c man end
 
diff --git a/docs/interop/qemu-qmp-ref.texi b/docs/interop/qemu-qmp-ref.texi
index bb25758bd0..ea1d7fe6c2 100644
--- a/docs/interop/qemu-qmp-ref.texi
+++ b/docs/interop/qemu-qmp-ref.texi
@@ -65,7 +65,7 @@ along with this manual.  If not, see http://www.gnu.org/licenses/.
 @c for texi2pod:
 @c man begin DESCRIPTION
 
-@include qemu-qmp-qapi.texi
+@include qapi/qapi-doc.texi
 
 @c man end
 
diff --git a/docs/meson.build b/docs/meson.build
index 124987dc57..020ac5173e 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -75,6 +75,7 @@ if sphinx.found()
     'specs/ppc-xive.rst',
   ]
   specs = custom_target('sphinx-specs',
+                build_by_default: build_docs,
                 input: specs_rst,
                 depend_files: [files('conf.py', 'specs/conf.py')],
                 output: 'specs',
diff --git a/meson.build b/meson.build
index 04068fd765..caf99f5082 100644
--- a/meson.build
+++ b/meson.build
@@ -466,13 +466,32 @@ foreach d : hx_headers
                 command: [hxtool, '-h', '@INPUT0@'])
 endforeach
 
+# meson makes it a bit difficult to refer to build targets
+# and texi tools don't generate depfiles
+# let's make doc generation depend on all texi
+texi_deps = [
+  'docs/interop/qemu-ga-ref.texi',
+  'docs/interop/qemu-qmp-ref.texi',
+  'docs/qemu-block-drivers.texi',
+  'docs/qemu-cpu-models.texi',
+  'docs/security.texi',
+  'fsdev/virtfs-proxy-helper.texi',
+  'qemu-deprecated.texi',
+  'qemu-doc.texi',
+  'qemu-img.texi',
+  'qemu-nbd.texi',
+  'qemu-option-trace.texi',
+  'qemu-tech.texi',
+  'scripts/qemu-trace-stap.texi',
+]
+
 foreach d : [
   ['qemu-options.hx', 'qemu-options.texi'],
   ['hmp-commands.hx', 'qemu-monitor.texi'],
   ['hmp-commands-info.hx', 'qemu-monitor-info.texi'],
   ['qemu-img-cmds.hx', 'qemu-img-cmds.texi'],
 ]
-  custom_target(d[1],
+  texi_deps += custom_target(d[1],
                 input: files(d[0]),
                 output: d[1],
                 capture: true,
@@ -951,3 +970,97 @@ endif
 
 subdir('pc-bios')
 subdir('docs')
+
+makeinfo = find_program('makeinfo', required: build_docs)
+
+docs_inc = [
+  '-I', meson.current_source_dir(),
+  '-I', meson.current_build_dir() / 'docs',
+  '-I', '@OUTDIR@',
+]
+
+texi = {
+  'qemu-doc': files('qemu-doc.texi'),
+  'qemu-qmp-ref': files('docs/interop/qemu-qmp-ref.texi'),
+}
+if 'CONFIG_GUEST_AGENT' in config_host
+  texi += {'qemu-ga-ref': files('docs/interop/qemu-ga-ref.texi')}
+endif
+
+if makeinfo.found() and build_docs
+  foreach doc, input: texi
+    cmd = [
+      'env', 'LC_ALL=C', makeinfo, '--no-split', '--number-sections', docs_inc,
+      '@INPUT0@', '-o', '@OUTPUT@',
+    ]
+    foreach ext, args: {
+        'info': [],
+        'html': ['--no-headers', '--html'],
+        'txt': ['--no-headers', '--plaintext'],
+    }
+      output = doc + '.' + ext
+      custom_target(output,
+                    input: input + texi_deps,
+                    output: output,
+                    install: true,
+                    install_dir: config_host['qemu_docdir'],
+                    command: cmd + args)
+    endforeach
+  endforeach
+endif
+
+texi2pdf = find_program('texi2pdf', required: false)
+
+if texi2pdf.found()
+  foreach doc, input: texi
+    output = doc + '.pdf'
+    custom_target(output,
+                  input: input + texi_deps,
+                  output: output,
+                  command: [texi2pdf, '-q', docs_inc, '@INPUT0@', '-o', '@OUTPUT@'])
+  endforeach
+endif
+
+texi2pod = find_program('scripts/texi2pod.pl')
+pod2man = find_program('pod2man', required: build_docs)
+
+mans = {
+  'qemu-block-drivers.7': files('docs/qemu-block-drivers.texi'),
+  'qemu-cpu-models.7': files('docs/qemu-cpu-models.texi'),
+  'qemu-qmp-ref.7': files('docs/interop/qemu-qmp-ref.texi'),
+  'qemu.1': files('qemu-doc.texi'),
+}
+if 'CONFIG_GUEST_AGENT' in config_host
+  mans += {'qemu-ga-ref.7': files('docs/interop/qemu-ga-ref.texi')}
+endif
+if 'CONFIG_TOOLS' in config_host
+  mans += {'qemu-img.7': files('qemu-img.texi')}
+  mans += {'qemu-nbd.8': files('qemu-nbd.texi')}
+endif
+if 'CONFIG_VIRTFS' in config_host
+  mans += {'virtfs-proxy-helper.1': files('fsdev/virtfs-proxy-helper.texi')}
+endif
+if 'CONFIG_TRACE_SYSTEMTAP' in config_host
+  mans += {'qemu-trace-stap.1': files('scripts/qemu-trace-stap.texi')}
+endif
+
+if pod2man.found() and build_docs
+  foreach man, input: mans
+    pod = custom_target(man + '.pod',
+                        input: input + texi_deps,
+                        output: man + '.pod',
+                        command: [texi2pod,
+                                  '-DVERSION="' + config_host['VERSION'] + '"',
+                                  '-DCONFDIR="' + config_host['qemu_confdir'] + '"',
+                                  '@INPUT0@', '@OUTPUT@'])
+    section = man[-1]
+    man = custom_target(man,
+                        input: pod,
+                        output: man,
+                        capture: true,
+                        install: true,
+                        install_dir: config_host['mandir'] / 'man' + section,
+                        command: [pod2man, '--utf8', '--section=' + section, '--center=" "',
+                                  '--release=" "', '@INPUT@'])
+  endforeach
+endif
diff --git a/rules.mak b/rules.mak
index 6c6b9098e7..92597864fe 100644
--- a/rules.mak
+++ b/rules.mak
@@ -378,15 +378,3 @@ define unnest-vars
         $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$(filter %.o,$($v)))))
         $(eval $v := $(filter-out %/,$($v))))
 endef
-
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
-- 
2.21.0



