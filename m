Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585AEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13214207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rb/EYCEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13214207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CNp-0006Co-6E
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BME-00046E-FT
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:13:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54541
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BMC-0003PN-2c
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCRGuFsItJm1p9/SqoSGCnUWdo5I0PNjTpt8wDKhwPI=;
 b=Rb/EYCEZMRg+TT4m46e4QkL8aMDf1dEM/jO4C5tlAVAMQqxYhFs0BZk9otXB2e/F8SEVkx
 GKjMr567tYvh85Sy0CgYOJOjkbnW8atq4yJeAiGp5GdX5VnwzCpecw3D4yZ4sD3NSW5Ug2
 zKC9+sAw3jaCCUfLe80CDZEgolnWYN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-Cvhye9DsPvao7mi3m56T7w-1; Mon, 10 Aug 2020 13:13:05 -0400
X-MC-Unique: Cvhye9DsPvao7mi3m56T7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66211106B249
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:13:04 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BDD25F1EA;
 Mon, 10 Aug 2020 17:13:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 143/147] meson: convert po/
Date: Mon, 10 Aug 2020 19:09:01 +0200
Message-Id: <1597079345-42801-144-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:00:11
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
 Makefile       |  5 +---
 configure      |  2 +-
 meson.build    |  3 +++
 po/LINGUAS     |  7 ++++++
 po/Makefile    | 52 -----------------------------------------
 po/POTFILES    |  1 +
 po/meson.build |  5 ++++
 po/messages.po | 74 ----------------------------------------------------------
 8 files changed, 18 insertions(+), 131 deletions(-)
 create mode 100644 po/LINGUAS
 delete mode 100644 po/Makefile
 create mode 100644 po/POTFILES
 create mode 100644 po/meson.build
 delete mode 100644 po/messages.po

diff --git a/Makefile b/Makefile
index 1eec727..f0970ea 100644
--- a/Makefile
+++ b/Makefile
@@ -200,7 +200,7 @@ distclean: clean
 	rm -f config-host.mak config-host.h*
 	rm -f tests/tcg/config-*.mak
 	rm -f config-all-disas.mak config.status
-	rm -f po/*.mo tests/qemu-iotests/common.env
+	rm -f tests/qemu-iotests/common.env
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
 	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -f config.log
@@ -275,9 +275,6 @@ endif
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
index ce9669e..5d64337 100755
--- a/configure
+++ b/configure
@@ -8083,7 +8083,7 @@ DIRS="$DIRS docs docs/interop fsdev scsi"
 DIRS="$DIRS pc-bios/optionrom pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios"
 LINKS="Makefile"
-LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
+LINKS="$LINKS tests/tcg/lm32/Makefile"
 LINKS="$LINKS tests/tcg/Makefile.target"
 LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
diff --git a/meson.build b/meson.build
index 426f9d8..6556a48 100644
--- a/meson.build
+++ b/meson.build
@@ -1108,6 +1108,9 @@ subdir('tools')
 subdir('pc-bios')
 subdir('tests')
 subdir('docs')
+if 'CONFIG_GTK' in config_host
+  subdir('po')
+endif
 
 if build_docs
   makeinfo = find_program('makeinfo', required: build_docs)
diff --git a/po/LINGUAS b/po/LINGUAS
new file mode 100644
index 0000000..054930d
--- /dev/null
+++ b/po/LINGUAS
@@ -0,0 +1,7 @@
+bg
+de_DE
+fr_FR
+hu
+it
+tr
+zh_CN
diff --git a/po/Makefile b/po/Makefile
deleted file mode 100644
index c041f4c..0000000
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
index 0000000..d34d5ed
--- /dev/null
+++ b/po/POTFILES
@@ -0,0 +1 @@
+ui/gtk.c
diff --git a/po/meson.build b/po/meson.build
new file mode 100644
index 0000000..b99d8e2
--- /dev/null
+++ b/po/meson.build
@@ -0,0 +1,5 @@
+i18n = import('i18n')
+
+i18n.gettext(meson.project_name(),
+             args: '--msgid-bugs-address=qemu-devel@nongnu.org',
+             preset: 'glib')
diff --git a/po/messages.po b/po/messages.po
deleted file mode 100644
index 065bd45..0000000
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
-- 
1.8.3.1



