Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8F2C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCDA2206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgNeSLr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDA2206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Wq5-0000DR-3b
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vo7-00009u-LB
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vnx-0003EP-II
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ja1I5Qw/WLCnTYx4aaHPWOGuAKToAKt0NOASimddMSw=;
 b=UgNeSLr2phRyS7WLksuSD2wKOy2bQTi8/E+v6R9FQG4qFAzI2xLx9E9paViG41xHw7n3Zm
 fzb+1pMGFCsPDMqa1XSPHfhlT0TSeTr3CCI1rRCbiBQCbhJ2dR7PorXjip9C0l6587/g61
 XRZwR5POF2RWbyw52UKeaox3xHqPL4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-LWAwIdVBMOqAf6E-BaStJw-1; Fri, 14 Aug 2020 05:15:14 -0400
X-MC-Unique: LWAwIdVBMOqAf6E-BaStJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78D6F1015DBE
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:15:13 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88C595C1BD;
 Fri, 14 Aug 2020 09:15:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 140/150] meson: build texi doc
Date: Fri, 14 Aug 2020 05:13:16 -0400
Message-Id: <20200814091326.16173-141-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:37
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                       | 106 ++-------------------------------
 docs/interop/qemu-ga-ref.texi  |   2 +-
 docs/interop/qemu-qmp-ref.texi |   2 +-
 meson.build                    |  85 ++++++++++++++++++++++++++
 qga/meson.build                |  12 +++-
 version.texi.in                |   2 +
 6 files changed, 104 insertions(+), 105 deletions(-)
 create mode 100644 version.texi.in

diff --git a/Makefile b/Makefile
index d8e2a86e69..373dd7286c 100644
--- a/Makefile
+++ b/Makefile
@@ -11,7 +11,6 @@ BUILD_DIR=$(CURDIR)
 SRC_PATH=.
 
 UNCHECKED_GOALS := %clean TAGS cscope ctags dist \
-    html info pdf txt \
     help check-help print-% \
     docker docker-% vm-help vm-test vm-build-%
 
@@ -119,20 +118,13 @@ generated-files-y += .git-submodule-status
 Makefile: ;
 configure: ;
 
-.PHONY: all clean cscope distclean html info install install-doc \
-	pdf txt recurse-all dist msi FORCE
+.PHONY: all clean cscope distclean install \
+	recurse-all dist msi FORCE
 
 $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-ifdef BUILD_DOCS
-DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
-DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
-else
-DOCS=
-endif
-
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet) BUILD_DIR=$(BUILD_DIR)
 
 ifneq ($(wildcard config-host.mak),)
@@ -141,7 +133,7 @@ endif
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) recurse-all modules
+all: recurse-all modules
 
 # LIBFDT_lib="": avoid breaking existing trees with objects requiring -fPIC
 DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_lib=""
@@ -214,7 +206,7 @@ qemu-%.tar.bz2:
 
 distclean: clean ninja-distclean
 	-test -f ninjatool && ./ninjatool $(if $(V),-v,) -t clean -g
-	rm -f config-host.mak config-host.h* $(DOCS)
+	rm -f config-host.mak config-host.h*
 	rm -f tests/tcg/config-*.mak
 	rm -f config-all-disas.mak config.status
 	rm -f po/*.mo tests/qemu-iotests/common.env
@@ -225,12 +217,6 @@ distclean: clean ninja-distclean
 	rm -f Makefile.ninja ninjatool ninjatool.stamp Makefile.mtest
 	rm -f config.log
 	rm -f linux-headers/asm
-	rm -f docs/version.texi
-	rm -f docs/interop/qemu-ga-qapi.texi docs/interop/qemu-qmp-qapi.texi
-	rm -f docs/interop/qemu-qmp-ref.7 docs/interop/qemu-ga-ref.7
-	rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
-	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
-	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
 	rm -Rf .sdk
 
 KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv \
@@ -264,29 +250,6 @@ else
 BLOBS=
 endif
 
-install-doc: $(DOCS)
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)/interop"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)/interop"
-ifdef CONFIG_POSIX
-	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu.1 "$(DESTDIR)$(mandir)/man1"
-	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
-ifeq ($(CONFIG_GUEST_AGENT),y)
-	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)/interop"
-	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)/interop"
-	$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
-endif
-endif
-ifdef CONFIG_VIRTFS
-	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
-endif
-ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
-endif
-
 install-datadir:
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
 
@@ -301,8 +264,7 @@ ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 
 # Needed by "meson install"
 export DESTDIR
-install: all $(if $(BUILD_DOCS),install-doc) \
-	install-datadir install-localstatedir
+install: all install-datadir install-localstatedir
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
 endif
@@ -333,62 +295,6 @@ endif
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
 	done
 
-# documentation
-MAKEINFO=makeinfo
-MAKEINFOINCLUDES= -I docs -I $(<D) -I $(@D)
-MAKEINFOFLAGS=--no-split --number-sections $(MAKEINFOINCLUDES)
-TEXI2PODFLAGS=$(MAKEINFOINCLUDES) -DVERSION="$(VERSION)" -DCONFDIR="$(qemu_confdir)"
-TEXI2PDFFLAGS=$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
-
-docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
-	$(call quiet-command,(\
-		echo "@set VERSION $(VERSION)" && \
-		echo "@set CONFDIR $(qemu_confdir)" \
-	)> $@,"GEN","$@")
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
-html: docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
-info: docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
-pdf: docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
-txt: docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
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
-	$(call quiet-command, \
-	  perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl $(TEXI2PODFLAGS) $< $@.pod && \
-	  $(POD2MAN) --section=$(subst .,,$(suffix $@)) --center=" " --release=" " $@.pod > $@, \
-	  "GEN","$@")
-
-man: $(filter %.1 %.7 %.8,$(DOCS))
-
 ifdef CONFIG_WIN32
 
 INSTALLER = qemu-setup-$(VERSION)$(EXESUF)
@@ -487,7 +393,7 @@ endif
 	$(call print-help,vm-help,Help about targets running tests inside VM)
 	@echo  ''
 	@echo  'Documentation targets:'
-	$(call print-help,html info pdf txt,Build documentation in specified format)
+	$(call print-help,html info pdf txt man,Build documentation in specified format)
 	@echo  ''
 ifdef CONFIG_WIN32
 	@echo  'Windows targets:'
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
 
diff --git a/meson.build b/meson.build
index 3847e167a6..8a8c6d0fde 100644
--- a/meson.build
+++ b/meson.build
@@ -1050,6 +1050,91 @@ subdir('pc-bios')
 subdir('tests')
 subdir('docs')
 
+if build_docs
+  makeinfo = find_program('makeinfo', required: build_docs)
+
+  docs_inc = [
+    '-I', meson.current_source_dir(),
+    '-I', meson.current_build_dir() / 'docs',
+    '-I', '@OUTDIR@',
+  ]
+
+  version_texi = configure_file(output: 'version.texi',
+                              input: 'version.texi.in',
+                              configuration: {'VERSION': meson.project_version(),
+                                              'qemu_confdir': config_host['qemu_confdir']})
+
+  texi = {
+    'qemu-qmp-ref': ['docs/interop/qemu-qmp-ref.texi', qapi_doc_texi, version_texi],
+  }
+  if 'CONFIG_GUEST_AGENT' in config_host
+    texi += {'qemu-ga-ref': ['docs/interop/qemu-ga-ref.texi', qga_qapi_doc_texi, version_texi]}
+  endif
+
+  if makeinfo.found()
+    cmd = [
+      'env', 'LC_ALL=C', makeinfo, '--no-split', '--number-sections', docs_inc,
+      '@INPUT0@', '-o', '@OUTPUT@',
+    ]
+    foreach ext, args: {
+        'info': [],
+        'html': ['--no-headers', '--html'],
+        'txt': ['--no-headers', '--plaintext'],
+    }
+      t = []
+      foreach doc, input: texi
+        output = doc + '.' + ext
+        t += custom_target(output,
+                      input: input,
+                      output: output,
+                      install: true,
+                      install_dir: config_host['qemu_docdir'] / 'interop',
+                      command: cmd + args)
+      endforeach
+      alias_target(ext, t)
+    endforeach
+  endif
+
+  texi2pdf = find_program('texi2pdf', required: false)
+
+  if texi2pdf.found()
+    pdfs = []
+    foreach doc, input: texi
+      output = doc + '.pdf'
+      pdfs += custom_target(output,
+                    input: input,
+                    output: output,
+                    command: [texi2pdf, '-q', docs_inc, '@INPUT0@', '-o', '@OUTPUT@'],
+                    build_by_default: false)
+    endforeach
+    alias_target('pdf', pdfs)
+  endif
+
+  texi2pod = find_program('scripts/texi2pod.pl')
+  pod2man = find_program('pod2man', required: build_docs)
+
+  if pod2man.found()
+    foreach doc, input: texi
+      man = doc + '.7'
+      pod = custom_target(man + '.pod',
+                          input: input,
+                          output: man + '.pod',
+                          command: [texi2pod,
+                                    '-DVERSION="' + meson.project_version() + '"',
+                                    '-DCONFDIR="' + config_host['qemu_confdir'] + '"',
+                                    '@INPUT0@', '@OUTPUT@'])
+      man = custom_target(man,
+                          input: pod,
+                          output: man,
+                          capture: true,
+                          install: true,
+                          install_dir: config_host['mandir'] / 'man7',
+                          command: [pod2man, '--utf8', '--section=7', '--center=" "',
+                                    '--release=" "', '@INPUT@'])
+    endforeach
+  endif
+endif
+
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
 summary_info += {'BIOS directory':    config_host['qemu_datadir']}
diff --git a/qga/meson.build b/qga/meson.build
index 7e7174b0a3..6fdddd68e3 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -1,7 +1,6 @@
 qga_qapi_outputs = [
   'qga-qapi-commands.c',
   'qga-qapi-commands.h',
-  'qga-qapi-doc.texi',
   'qga-qapi-emit-events.c',
   'qga-qapi-emit-events.h',
   'qga-qapi-events.c',
@@ -17,12 +16,19 @@ qga_qapi_outputs = [
 ]
 
 qga_qapi_files = custom_target('QGA QAPI files',
-                               output: qga_qapi_outputs,
+                               output: qga_qapi_outputs + ['qga-qapi-doc.texi'],
                                input: 'qapi-schema.json',
                                command: [ qapi_gen, '-o', 'qga', '-p', 'qga-', '@INPUT0@' ],
                                depend_files: qapi_gen_depends)
+
 qga_ss = ss.source_set()
-qga_ss.add(qga_qapi_files)
+i = 0
+foreach output: qga_qapi_outputs
+  qga_ss.add(qga_qapi_files[i])
+  i = i + 1
+endforeach
+qga_qapi_doc_texi = qga_qapi_files[i]
+
 qga_ss.add(files(
   'commands.c',
   'guest-agent-command-state.c',
diff --git a/version.texi.in b/version.texi.in
new file mode 100644
index 0000000000..0a723b8be6
--- /dev/null
+++ b/version.texi.in
@@ -0,0 +1,2 @@
+@set VERSION @VERSION@
+@set CONFDIR @qemu_confdir@
-- 
2.26.2



