Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D47EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B25206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Agv8BDwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B25206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvDr-0004yb-Sc
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihurx-0000VG-9a
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurq-0002Iv-KT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41209
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurp-0002Fu-Pv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lLCOLGc9HCwQfuDdNFFvWe1ryUt857w2OCIR1OAe89s=;
 b=Agv8BDwD5XlpNejOJ2J0bIojyQxwAUNzfHnIr2t7RVV/2UZsRy8Cw560UudgcXbo1gj9z+
 qvc7TJHDCRhiDUx/rvXnyL4Erv2ZOspP1CjetjxKtaU1gF7qJc3aVMhp+Ca8rFKOWYYDuL
 OjG5ZO7zXTnjXW1J1swniQp1WefK2dI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-dQ1CxBNONDCAo45GkHnWkQ-1; Thu, 19 Dec 2019 07:25:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F828107ACC4
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:14 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3011660C18;
 Thu, 19 Dec 2019 12:25:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 118/132] meson: build texi doc
Date: Thu, 19 Dec 2019 13:23:38 +0100
Message-Id: <1576758232-12439-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: dQ1CxBNONDCAo45GkHnWkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile                       | 139 ++-----------------------------------=
----
 docs/interop/qemu-ga-ref.texi  |   2 +-
 docs/interop/qemu-qmp-ref.texi |   2 +-
 docs/meson.build               |   1 +
 meson.build                    | 117 +++++++++++++++++++++++++++++++++-
 rules.mak                      |  12 ----
 6 files changed, 125 insertions(+), 148 deletions(-)

diff --git a/Makefile b/Makefile
index c1ea39f..ac21e14 100644
--- a/Makefile
+++ b/Makefile
@@ -11,7 +11,6 @@ BUILD_DIR=3D$(CURDIR)
 SRC_PATH=3D.
=20
 UNCHECKED_GOALS :=3D %clean TAGS cscope ctags dist \
-    html info pdf txt \
     help check-help print-% \
     docker docker-% vm-help vm-test vm-build-%
=20
@@ -106,29 +105,13 @@ edk2-decompressed =3D $(basename $(wildcard pc-bios/e=
dk2-*.fd.bz2))
 Makefile: ;
 configure: ;
=20
-.PHONY: all clean cscope distclean html info install install-doc \
-=09pdf txt recurse-all dist msi FORCE
+.PHONY: all clean cscope distclean install \
+=09recurse-all dist msi FORCE
=20
 $(call set-vpath, $(SRC_PATH))
=20
 LIBS+=3D-lz $(LIBS_TOOLS)
=20
-ifdef BUILD_DOCS
-DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
-DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/=
interop/qemu-qmp-ref.7
-DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/in=
terop/qemu-ga-ref.7
-DOCS+=3Ddocs/qemu-block-drivers.7
-DOCS+=3Ddocs/qemu-cpu-models.7
-ifdef CONFIG_VIRTFS
-DOCS+=3Dfsdev/virtfs-proxy-helper.1
-endif
-ifdef CONFIG_TRACE_SYSTEMTAP
-DOCS+=3Dscripts/qemu-trace-stap.1
-endif
-else
-DOCS=3D
-endif
-
 SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory --quiet) BUILD_DIR=3D$(=
BUILD_DIR)
=20
 ifneq ($(wildcard config-host.mak),)
@@ -137,7 +120,7 @@ endif
=20
 include $(SRC_PATH)/tests/Makefile.include
=20
-all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) recurse-all modules
+all: recurse-all modules
=20
 DTC_MAKE_ARGS=3D-I$(SRC_PATH)/dtc VPATH=3D$(SRC_PATH)/dtc -C dtc V=3D"$(V)=
" LIBFDT_srcdir=3D$(SRC_PATH)/dtc/libfdt
 DTC_CFLAGS=3D$(CFLAGS) $(QEMU_CFLAGS)
@@ -225,25 +208,13 @@ qemu-%.tar.bz2:
 =09$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.b=
z2,%,$@)"
=20
 distclean: clean
-=09rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-option=
s.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
+=09rm -f config-host.mak config-host.h* config-host.ld
 =09rm -f tests/tcg/config-*.mak
 =09rm -f config-all-disas.mak config.status
 =09rm -f po/*.mo tests/qemu-iotests/common.env
 =09rm -f roms/seabios/config.mak roms/vgabios/config.mak
-=09rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
-=09rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky qemu-doc.kys
-=09rm -f qemu-doc.log qemu-doc.pdf qemu-doc.pg qemu-doc.toc qemu-doc.tp
-=09rm -f qemu-doc.vr qemu-doc.txt
 =09rm -f config.log
 =09rm -f linux-headers/asm
-=09rm -f docs/version.texi
-=09rm -f docs/interop/qemu-ga-qapi.texi docs/interop/qemu-qmp-qapi.texi
-=09rm -f docs/interop/qemu-qmp-ref.7 docs/interop/qemu-ga-ref.7
-=09rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
-=09rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
-=09rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
-=09rm -f docs/qemu-block-drivers.7
-=09rm -f docs/qemu-cpu-models.7
 =09rm -Rf .sdk
 =09if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
=20
@@ -283,39 +254,6 @@ BLOBS=3D
 DESCS=3D
 endif
=20
-install-doc: $(DOCS)
-=09$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
-=09$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
-=09$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
-=09$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir=
)"
-=09$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)=
"
-ifdef CONFIG_POSIX
-=09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
-=09$(INSTALL_DATA) qemu.1 "$(DESTDIR)$(mandir)/man1"
-=09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
-=09$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
-=09$(INSTALL_DATA) docs/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
-=09$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
-ifeq ($(CONFIG_TOOLS),y)
-=09$(INSTALL_DATA) qemu-img.1 "$(DESTDIR)$(mandir)/man1"
-=09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
-=09$(INSTALL_DATA) qemu-nbd.8 "$(DESTDIR)$(mandir)/man8"
-endif
-ifdef CONFIG_TRACE_SYSTEMTAP
-=09$(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
-endif
-ifeq ($(CONFIG_GUEST_AGENT),y)
-=09$(INSTALL_DATA) qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
-=09$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)=
"
-=09$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
-=09$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
-endif
-endif
-ifdef CONFIG_VIRTFS
-=09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
-=09$(INSTALL_DATA) fsdev/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
-endif
-
 install-datadir:
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
=20
@@ -328,7 +266,7 @@ endif
=20
 ICON_SIZES=3D16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
=20
-install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-local=
statedir \
+install: all install-datadir install-localstatedir \
 =09$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
 =09recurse-install
 ifneq ($(vhost-user-json-y),)
@@ -397,67 +335,6 @@ cscope:
 =09find "$(SRC_PATH)/" -name "*.[chsS]" -print | sed 's,^\./,,' > "$(SRC_P=
ATH)/cscope.files"
 =09cscope -b -i"$(SRC_PATH)/cscope.files"
=20
-# documentation
-MAKEINFO=3Dmakeinfo
-MAKEINFOINCLUDES=3D -I docs -I $(<D) -I $(@D)
-MAKEINFOFLAGS=3D--no-split --number-sections $(MAKEINFOINCLUDES)
-TEXI2PODFLAGS=3D$(MAKEINFOINCLUDES) -DVERSION=3D"$(VERSION)" -DCONFDIR=3D"=
$(qemu_confdir)"
-TEXI2PDFFLAGS=3D$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
-
-%.html: %.texi docs/version.texi
-=09$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-heade=
rs \
-=09--html $< -o $@,"GEN","$@")
-
-%.info: %.texi docs/version.texi
-=09$(call quiet-command,$(MAKEINFO) $(MAKEINFOFLAGS) $< -o $@,"GEN","$@")
-
-%.txt: %.texi docs/version.texi
-=09$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-heade=
rs \
-=09--plaintext $< -o $@,"GEN","$@")
-
-%.pdf: %.texi docs/version.texi
-=09$(call quiet-command,texi2pdf $(TEXI2PDFFLAGS) $< -o $@,"GEN","$@")
-
-docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
-=09@cp -p $< $@
-
-docs/interop/qemu-ga-qapi.texi: qga/qga-qapi-doc.texi
-=09@cp -p $< $@
-
-qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-inf=
o.texi
-qemu.1: qemu-option-trace.texi
-qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
-fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
-qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
-qemu-ga.8: qemu-ga.texi
-docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
-docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
-scripts/qemu-trace-stap.1: scripts/qemu-trace-stap.texi
-
-html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-re=
f.html sphinxdocs
-info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-re=
f.info
-pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.p=
df
-txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.t=
xt
-
-qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
-=09qemu-img.texi qemu-nbd.texi qemu-options.texi \
-=09qemu-tech.texi qemu-option-trace.texi \
-=09qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi =
\
-=09qemu-monitor-info.texi docs/qemu-block-drivers.texi \
-=09docs/qemu-cpu-models.texi docs/security.texi
-
-docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
-    docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
-    docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7: \
-=09docs/interop/qemu-ga-ref.texi docs/interop/qemu-ga-qapi.texi
-
-docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-ref.html \
-    docs/interop/qemu-qmp-ref.info docs/interop/qemu-qmp-ref.pdf \
-    docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7: \
-=09docs/interop/qemu-qmp-ref.texi docs/interop/qemu-qmp-qapi.texi
-
-$(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
-
 ifdef CONFIG_WIN32
=20
 INSTALLER =3D qemu-setup-$(VERSION)$(EXESUF)
@@ -480,7 +357,7 @@ installer: $(INSTALLER)
=20
 INSTDIR=3D/tmp/qemu-nsis
=20
-$(INSTALLER): install-doc $(SRC_PATH)/qemu.nsi
+$(INSTALLER): $(SRC_PATH)/qemu.nsi
 =09$(MAKE) install prefix=3D${INSTDIR}
 ifdef SIGNCODE
 =09(cd ${INSTDIR}; \
@@ -551,10 +428,6 @@ endif
 =09@echo  '  docker          - Help about targets running tests inside con=
tainers'
 =09@echo  '  vm-help         - Help about targets running tests inside VM'
 =09@echo  ''
-=09@echo  'Documentation targets:'
-=09@echo  '  html info pdf txt'
-=09@echo  '                  - Build documentation in specified format'
-=09@echo  ''
 ifdef CONFIG_WIN32
 =09@echo  'Windows targets:'
 =09@echo  '  installer       - Build NSIS-based installer for QEMU'
diff --git a/docs/interop/qemu-ga-ref.texi b/docs/interop/qemu-ga-ref.texi
index ddb76ce..a23cc2e 100644
--- a/docs/interop/qemu-ga-ref.texi
+++ b/docs/interop/qemu-ga-ref.texi
@@ -65,7 +65,7 @@ along with this manual.  If not, see http://www.gnu.org/l=
icenses/.
 @c for texi2pod:
 @c man begin DESCRIPTION
=20
-@include qemu-ga-qapi.texi
+@include qga/qga-qapi-doc.texi
=20
 @c man end
=20
diff --git a/docs/interop/qemu-qmp-ref.texi b/docs/interop/qemu-qmp-ref.tex=
i
index bb25758..ea1d7fe 100644
--- a/docs/interop/qemu-qmp-ref.texi
+++ b/docs/interop/qemu-qmp-ref.texi
@@ -65,7 +65,7 @@ along with this manual.  If not, see http://www.gnu.org/l=
icenses/.
 @c for texi2pod:
 @c man begin DESCRIPTION
=20
-@include qemu-qmp-qapi.texi
+@include qapi/qapi-doc.texi
=20
 @c man end
=20
diff --git a/docs/meson.build b/docs/meson.build
index c71fff9..5d20afb 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -60,6 +60,7 @@ if sphinx.found()
     'specs/ppc-xive.rst',
   ]
   specs =3D custom_target('sphinx-specs',
+                build_by_default: build_docs,
                 input: specs_rst,
                 depend_files: [files('conf.py', 'specs/conf.py')],
                 output: 'specs',
diff --git a/meson.build b/meson.build
index 5b4b472..40ba735 100644
--- a/meson.build
+++ b/meson.build
@@ -457,13 +457,33 @@ foreach d : hx_headers
                 command: [hxtool, '-h', '@INPUT0@'])
 endforeach
=20
+# meson makes it a bit difficult to refer to build targets
+# and texi tools don't generate depfiles
+# let's make doc generation depend on all texi
+texi_deps =3D [
+  'docs/interop/qemu-ga-ref.texi',
+  'docs/interop/qemu-qmp-ref.texi',
+  'docs/qemu-block-drivers.texi',
+  'docs/qemu-cpu-models.texi',
+  'docs/security.texi',
+  'fsdev/virtfs-proxy-helper.texi',
+  'qemu-deprecated.texi',
+  'qemu-doc.texi',
+  'qemu-ga.texi',
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
+  texi_deps +=3D custom_target(d[1],
                 input: files(d[0]),
                 output: d[1],
                 capture: true,
@@ -925,3 +945,98 @@ endif
=20
 subdir('pc-bios')
 subdir('docs')
+
+makeinfo =3D find_program('makeinfo', required: build_docs)
+
+docs_inc =3D [
+  '-I', meson.current_source_dir(),
+  '-I', meson.current_build_dir() / 'docs',
+  '-I', '@OUTDIR@',
+]
+
+texi =3D {
+  'qemu-doc': files('qemu-doc.texi'),
+  'qemu-qmp-ref': files('docs/interop/qemu-qmp-ref.texi'),
+}
+if 'CONFIG_GUEST_AGENT' in config_host
+  texi +=3D {'qemu-ga-ref': files('docs/interop/qemu-ga-ref.texi')}
+endif
+
+if makeinfo.found() and build_docs
+  foreach doc, input: texi
+    cmd =3D [
+      'env', 'LC_ALL=3DC', makeinfo, '--no-split', '--number-sections', do=
cs_inc,
+      '@INPUT0@', '-o', '@OUTPUT@',
+    ]
+    foreach ext, args: {
+        'info': [],
+        'html': ['--no-headers', '--html'],
+        'txt': ['--no-headers', '--plaintext'],
+    }
+      output =3D doc + '.' + ext
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
+texi2pdf =3D find_program('texi2pdf', required: false)
+
+if texi2pdf.found()
+  foreach doc, input: texi
+    output =3D doc + '.pdf'
+    custom_target(output,
+                  input: input + texi_deps,
+                  output: output,
+                  command: [texi2pdf, '-q', docs_inc, '@INPUT0@', '-o', '@=
OUTPUT@'])
+  endforeach
+endif
+
+texi2pod =3D find_program('scripts/texi2pod.pl')
+pod2man =3D find_program('pod2man', required: build_docs)
+
+mans =3D {
+  'qemu-block-drivers.7': files('docs/qemu-block-drivers.texi'),
+  'qemu-cpu-models.7': files('docs/qemu-cpu-models.texi'),
+  'qemu-qmp-ref.7': files('docs/interop/qemu-qmp-ref.texi'),
+  'qemu.1': files('qemu-doc.texi'),
+}
+if 'CONFIG_GUEST_AGENT' in config_host
+  mans +=3D {'qemu-ga-ref.7': files('docs/interop/qemu-ga-ref.texi')}
+  mans +=3D {'qemu-ga.8': files('qemu-ga.texi')}
+endif
+if 'CONFIG_TOOLS' in config_host
+  mans +=3D {'qemu-img.7': files('qemu-img.texi')}
+  mans +=3D {'qemu-nbd.8': files('qemu-nbd.texi')}
+endif
+if 'CONFIG_VIRTFS' in config_host
+  mans +=3D {'virtfs-proxy-helper.1': files('fsdev/virtfs-proxy-helper.tex=
i')}
+endif
+if 'CONFIG_TRACE_SYSTEMTAP' in config_host
+  mans +=3D {'qemu-trace-stap.1': files('scripts/qemu-trace-stap.texi')}
+endif
+
+if pod2man.found() and build_docs
+  foreach man, input: mans
+    pod =3D custom_target(man + '.pod',
+                        input: input + texi_deps,
+                        output: man + '.pod',
+                        command: [texi2pod,
+                                  '-DVERSION=3D"' + config_host['VERSION']=
 + '"',
+                                  '-DCONFDIR=3D"' + config_host['qemu_conf=
dir'] + '"',
+                                  '@INPUT0@', '@OUTPUT@'])
+    section =3D man[-1]
+    man =3D custom_target(man,
+                        input: pod,
+                        output: man,
+                        capture: true,
+                        install: true,
+                        install_dir: config_host['mandir'] / 'man' + secti=
on,
+                        command: [pod2man, '--utf8', '--section=3D' + sect=
ion, '--center=3D" "',
+                                  '--release=3D" "', '@INPUT@'])
+  endforeach
+endif
diff --git a/rules.mak b/rules.mak
index 6c6b909..9259786 100644
--- a/rules.mak
+++ b/rules.mak
@@ -378,15 +378,3 @@ define unnest-vars
         $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$(filter %.=
o,$($v)))))
         $(eval $v :=3D $(filter-out %/,$($v))))
 endef
-
-TEXI2MAN =3D $(call quiet-command, \
-=09perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl $(TEXI2PODFLAGS) $< $@.pod =
&& \
-=09$(POD2MAN) --section=3D$(subst .,,$(suffix $@)) --center=3D" " --releas=
e=3D" " $@.pod > $@, \
-=09"GEN","$@")
-
-%.1:
-=09$(call TEXI2MAN)
-%.7:
-=09$(call TEXI2MAN)
-%.8:
-=09$(call TEXI2MAN)
--=20
1.8.3.1



