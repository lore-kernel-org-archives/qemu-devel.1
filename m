Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B420C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E9B2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6ICDrgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E9B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95D2-0006rQ-Iz
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94F1-00049N-Kh
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:25:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Ei-0001ze-J1
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJWEIHTzuCHJmTdlOPf+Ltdydt6EtuUf56CFI9vv1CY=;
 b=Z6ICDrgxXcZCuWA3fnhCr2wFb9lNncl57Y+KLTNLrCA3ClZPe4M6qVf6xUQdibGL0VAd+g
 IFNUfLj8I3wSbiFpJoKXhbMRFnkgwSWMyQYijqnAj3zsO9OSkMXjLU7XUvjsnWo2t6JaEu
 /gYTWkSo2NwNUz0eUxWhsAwxKzxjvh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-7b1ypIpmOx6_PQ1Dh_7rWw-1; Fri, 21 Aug 2020 06:25:25 -0400
X-MC-Unique: 7b1ypIpmOx6_PQ1Dh_7rWw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18ED556B2D
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:25:25 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7915101E247;
 Fri, 21 Aug 2020 10:25:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 149/152] meson: convert po/
Date: Fri, 21 Aug 2020 06:23:26 -0400
Message-Id: <20200821102329.29777-150-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Meson warns if xgettext is not found.  In the future we may want to add
a required argument to i18n.gettext(); in the meanwhile, I am adding a
--enable-gettext/--disable-gettext option and feature detection in
configure.  This preserves QEMU's default behavior of detecting system
features, without any warning, if neither --enable-* nor --disable-*
is requested.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile          |  5 +---
 configure         | 21 +++++++++++++-
 meson.build       |  3 ++
 meson_options.txt |  1 +
 po/LINGUAS        |  8 +++++
 po/Makefile       | 52 ---------------------------------
 po/POTFILES       |  1 +
 po/meson.build    |  7 +++++
 po/messages.po    | 74 -----------------------------------------------
 tests/vm/freebsd  |  1 +
 tests/vm/netbsd   |  1 +
 tests/vm/openbsd  |  1 +
 12 files changed, 44 insertions(+), 131 deletions(-)
 create mode 100644 po/LINGUAS
 delete mode 100644 po/Makefile
 create mode 100644 po/POTFILES
 create mode 100644 po/meson.build
 delete mode 100644 po/messages.po

diff --git a/Makefile b/Makefile
index aa582d6554..8373ddccc9 100644
--- a/Makefile
+++ b/Makefile
@@ -219,7 +219,7 @@ distclean: clean ninja-distclean
 	rm -f config-host.mak config-host.h*
 	rm -f tests/tcg/config-*.mak
 	rm -f config-all-disas.mak config.status
-	rm -f po/*.mo tests/qemu-iotests/common.env
+	rm -f tests/qemu-iotests/common.env
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
 	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -f *-config-target.h *-config-devices.mak *-config-devices.h
@@ -297,9 +297,6 @@ endif
 	mkdir -p "$(DESTDIR)$(qemu_desktopdir)"
 	$(INSTALL_DATA) $(SRC_PATH)/ui/qemu.desktop \
 		"$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
-ifdef CONFIG_GTK
-	$(MAKE) -C po $@
-endif
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
 	set -e; for x in $(KEYMAPS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
diff --git a/configure b/configure
index 56b2432f47..cdffe221c7 100755
--- a/configure
+++ b/configure
@@ -565,6 +565,7 @@ secret_keyring=""
 libdaxctl=""
 meson=""
 skip_meson=no
+gettext=""
 
 bogus_os="no"
 malloc_trim=""
@@ -1157,6 +1158,10 @@ for opt do
   ;;
   --enable-vnc) vnc="enabled"
   ;;
+  --disable-gettext) gettext="false"
+  ;;
+  --enable-gettext) gettext="true"
+  ;;
   --oss-lib=*) oss_lib="$optarg"
   ;;
   --audio-drv-list=*) audio_drv_list="$optarg"
@@ -3028,6 +3033,19 @@ if test "$whpx" != "no" ; then
     fi
 fi
 
+##########################################
+# gettext probe
+if test "$gettext" != "false" ; then
+  if has xgettext; then
+    gettext=true
+  else
+    if test "$gettext" = "true" ; then
+      feature_not_found "gettext" "Install xgettext binary"
+    fi
+    gettext=false
+  fi
+fi
+
 ##########################################
 # Sparse probe
 if test "$sparse" != "no" ; then
@@ -8095,7 +8113,7 @@ DIRS="$DIRS docs docs/interop fsdev scsi"
 DIRS="$DIRS pc-bios/optionrom pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios"
 LINKS="Makefile"
-LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
+LINKS="$LINKS tests/tcg/lm32/Makefile"
 LINKS="$LINKS tests/tcg/Makefile.target"
 LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
@@ -8227,6 +8245,7 @@ NINJA=$PWD/ninjatool $meson setup \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
 	-Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
+	-Dgettext=$gettext \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/meson.build b/meson.build
index 1ae9d42868..62bf8a51c2 100644
--- a/meson.build
+++ b/meson.build
@@ -1115,6 +1115,9 @@ subdir('tools')
 subdir('pc-bios')
 subdir('tests')
 subdir('docs')
+if 'CONFIG_GTK' in config_host
+  subdir('po')
+endif
 
 if build_docs
   makeinfo = find_program('makeinfo', required: build_docs)
diff --git a/meson_options.txt b/meson_options.txt
index 67455c57bc..e5f45243ce 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -1,3 +1,4 @@
+option('gettext', type : 'boolean', value : true)
 option('sdl', type : 'feature', value : 'auto')
 option('sdl_image', type : 'feature', value : 'auto')
 option('vnc', type : 'feature', value : 'enabled')
diff --git a/po/LINGUAS b/po/LINGUAS
new file mode 100644
index 0000000000..cc4b5c3b36
--- /dev/null
+++ b/po/LINGUAS
@@ -0,0 +1,8 @@
+bg
+de_DE
+fr_FR
+hu
+it
+sv
+tr
+zh_CN
diff --git a/po/Makefile b/po/Makefile
deleted file mode 100644
index c041f4c858..0000000000
--- a/po/Makefile
+++ /dev/null
@@ -1,52 +0,0 @@
-# This makefile is very special as it's meant to build as part of the build
-# process and also within the source tree to update the translation files.
-
-# Set SRC_PATH for in-tree builds without configuration.
-SRC_PATH=..
-
-# The default target must come before any include statements.
-all:
-
-.PHONY:	all build clean install update
-
-%.mo: %.po
-	$(call quiet-command, msgfmt -o $@ $<,"GEN","$@")
-
--include ../config-host.mak
-include $(SRC_PATH)/rules.mak
-
-PO_PATH=$(SRC_PATH)/po
-
-VERSION=$(shell cat $(SRC_PATH)/VERSION)
-SRCS=$(filter-out $(PO_PATH)/messages.po,$(wildcard $(PO_PATH)/*.po))
-OBJS=$(patsubst $(PO_PATH)/%.po,%.mo,$(SRCS))
-
-vpath %.po $(PO_PATH)
-
-all:
-	@echo "Use 'make update' to update translation files or use 'make build'"
-	@echo "or 'make install' to build and install the translation files."
-
-update: $(SRCS)
-
-build: $(OBJS)
-
-clean:
-	rm -f $(OBJS)
-
-install: $(OBJS)
-	for obj in $(OBJS); do \
-	    base=$$(basename $$obj .mo); \
-	    $(INSTALL) -d $(DESTDIR)$(prefix)/share/locale/$$base/LC_MESSAGES; \
-	    $(INSTALL) -m644 $$obj $(DESTDIR)$(prefix)/share/locale/$$base/LC_MESSAGES/qemu.mo; \
-	done
-
-$(PO_PATH)/messages.po: $(SRC_PATH)/ui/gtk.c
-	$(call quiet-command, ( cd $(SRC_PATH) && \
-          xgettext -o - --from-code=UTF-8 --foreign-user --no-location \
-	    --package-name=QEMU --package-version=$(VERSION) \
-	    --msgid-bugs-address=qemu-devel@nongnu.org -k_ -C ui/gtk.c | \
-	  sed -e s/CHARSET/UTF-8/) >$@,"GEN","$@")
-
-$(PO_PATH)/%.po: $(PO_PATH)/messages.po
-	$(call quiet-command, msgmerge -q $@ $< > $@.bak && mv $@.bak $@,"GEN","$@")
diff --git a/po/POTFILES b/po/POTFILES
new file mode 100644
index 0000000000..d34d5ed9aa
--- /dev/null
+++ b/po/POTFILES
@@ -0,0 +1 @@
+ui/gtk.c
diff --git a/po/meson.build b/po/meson.build
new file mode 100644
index 0000000000..1387fd979a
--- /dev/null
+++ b/po/meson.build
@@ -0,0 +1,7 @@
+i18n = import('i18n')
+
+if get_option('gettext')
+  i18n.gettext(meson.project_name(),
+               args: '--msgid-bugs-address=qemu-devel@nongnu.org',
+               preset: 'glib')
+endif
diff --git a/po/messages.po b/po/messages.po
deleted file mode 100644
index 065bd459a0..0000000000
--- a/po/messages.po
+++ /dev/null
@@ -1,74 +0,0 @@
-# SOME DESCRIPTIVE TITLE.
-# This file is put in the public domain.
-# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
-#
-#, fuzzy
-msgid ""
-msgstr ""
-"Project-Id-Version: QEMU 2.12.91\n"
-"Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
-"POT-Creation-Date: 2018-07-18 07:56+0200\n"
-"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
-"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
-"Language-Team: LANGUAGE <LL@li.org>\n"
-"Language: \n"
-"MIME-Version: 1.0\n"
-"Content-Type: text/plain; charset=UTF-8\n"
-"Content-Transfer-Encoding: 8bit\n"
-
-msgid " - Press Ctrl+Alt+G to release grab"
-msgstr ""
-
-msgid " [Paused]"
-msgstr ""
-
-msgid "_Pause"
-msgstr ""
-
-msgid "_Reset"
-msgstr ""
-
-msgid "Power _Down"
-msgstr ""
-
-msgid "_Quit"
-msgstr ""
-
-msgid "_Fullscreen"
-msgstr ""
-
-msgid "_Copy"
-msgstr ""
-
-msgid "Zoom _In"
-msgstr ""
-
-msgid "Zoom _Out"
-msgstr ""
-
-msgid "Best _Fit"
-msgstr ""
-
-msgid "Zoom To _Fit"
-msgstr ""
-
-msgid "Grab On _Hover"
-msgstr ""
-
-msgid "_Grab Input"
-msgstr ""
-
-msgid "Show _Tabs"
-msgstr ""
-
-msgid "Detach Tab"
-msgstr ""
-
-msgid "Show Menubar"
-msgstr ""
-
-msgid "_Machine"
-msgstr ""
-
-msgid "_View"
-msgstr ""
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index b34b14fc53..5f866e09c4 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -39,6 +39,7 @@ class FreeBSDVM(basevm.BaseVM):
         "bash",
         "gmake",
         "gsed",
+        "gettext",
 
         # libs: crypto
         "gnutls",
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 93d48b6fdd..ffb65a89be 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -37,6 +37,7 @@ class NetBSDVM(basevm.BaseVM):
         "bash",
         "gmake",
         "gsed",
+        "gettext",
 
         # libs: crypto
         "gnutls",
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 7e27fda642..8356646f21 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -36,6 +36,7 @@ class OpenBSDVM(basevm.BaseVM):
         "bash",
         "gmake",
         "gsed",
+        "gettext",
 
         # libs: usb
         "libusb1",
-- 
2.26.2



