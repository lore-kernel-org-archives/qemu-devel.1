Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94113C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF0920716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqK3e2xI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF0920716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvO5-0003m8-TA
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihus8-0000gs-Qi
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihus6-0002vx-Rq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57348
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihus6-0002tG-JV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLE1nfwKXyX6lNaiMKq8XXlNtJf3EUmUtJk4eewFxvc=;
 b=WqK3e2xIybnn9Ix03PsXt+E10Scd7YKmCjjIOpvr51tJN6fbqTfM+KuktliGeP4ThuSz/g
 ZgRCyj0r0+bX6h8ndTqlfDF+KtUgcnvA7W10muRdAws3gMRPIJ0iQwByurLEKASOC4XJAn
 7NTMxcLVf35kkdbCIbNUcq7N72mZqnI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-iwmHs8uYOUeioGbCANWqag-1; Thu, 19 Dec 2019 07:25:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 232F1107ACC7
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:35 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E44C460C18;
 Thu, 19 Dec 2019 12:25:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 127/132] meson: convert po/
Date: Thu, 19 Dec 2019 13:23:47 +0100
Message-Id: <1576758232-12439-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: iwmHs8uYOUeioGbCANWqag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 Makefile       |  3 ---
 meson.build    |  4 ++++
 po/LINGUAS     |  7 ++++++
 po/Makefile    | 52 -----------------------------------------
 po/POTFILES    |  1 +
 po/meson.build |  5 ++++
 po/messages.po | 74 ------------------------------------------------------=
----
 7 files changed, 17 insertions(+), 129 deletions(-)
 create mode 100644 po/LINGUAS
 delete mode 100644 po/Makefile
 create mode 100644 po/POTFILES
 create mode 100644 po/meson.build
 delete mode 100644 po/messages.po

diff --git a/Makefile b/Makefile
index 3faf6a4..0493a3b 100644
--- a/Makefile
+++ b/Makefile
@@ -235,9 +235,6 @@ ifneq ($(vhost-user-json-y),)
 =09=09$(INSTALL_DATA) $$x "$(DESTDIR)$(qemu_datadir)/vhost-user/"; \
 =09done
 endif
-ifdef CONFIG_GTK
-=09$(MAKE) -C po $@
-endif
=20
 .PHONY: ctags
 ctags:
diff --git a/meson.build b/meson.build
index 32b9430..9a5b9d9 100644
--- a/meson.build
+++ b/meson.build
@@ -1064,3 +1064,7 @@ if host_machine.system() =3D=3D 'windows'
                 build_always_stale: true,
                 command: nsis_cmd + ['@INPUT@'])
 endif
+
+if 'CONFIG_GTK' in config_host
+  subdir('po')
+endif
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
-# This makefile is very special as it's meant to build as part of the buil=
d
-# process and also within the source tree to update the translation files.
-
-# Set SRC_PATH for in-tree builds without configuration.
-SRC_PATH=3D..
-
-# The default target must come before any include statements.
-all:
-
-.PHONY:=09all build clean install update
-
-%.mo: %.po
-=09$(call quiet-command, msgfmt -o $@ $<,"GEN","$@")
-
--include ../config-host.mak
-include $(SRC_PATH)/rules.mak
-
-PO_PATH=3D$(SRC_PATH)/po
-
-VERSION=3D$(shell cat $(SRC_PATH)/VERSION)
-SRCS=3D$(filter-out $(PO_PATH)/messages.po,$(wildcard $(PO_PATH)/*.po))
-OBJS=3D$(patsubst $(PO_PATH)/%.po,%.mo,$(SRCS))
-
-vpath %.po $(PO_PATH)
-
-all:
-=09@echo "Use 'make update' to update translation files or use 'make build=
'"
-=09@echo "or 'make install' to build and install the translation files."
-
-update: $(SRCS)
-
-build: $(OBJS)
-
-clean:
-=09rm -f $(OBJS)
-
-install: $(OBJS)
-=09for obj in $(OBJS); do \
-=09    base=3D$$(basename $$obj .mo); \
-=09    $(INSTALL) -d $(DESTDIR)$(prefix)/share/locale/$$base/LC_MESSAGES; =
\
-=09    $(INSTALL) -m644 $$obj $(DESTDIR)$(prefix)/share/locale/$$base/LC_M=
ESSAGES/qemu.mo; \
-=09done
-
-$(PO_PATH)/messages.po: $(SRC_PATH)/ui/gtk.c
-=09$(call quiet-command, ( cd $(SRC_PATH) && \
-          xgettext -o - --from-code=3DUTF-8 --foreign-user --no-location \
-=09    --package-name=3DQEMU --package-version=3D$(VERSION) \
-=09    --msgid-bugs-address=3Dqemu-devel@nongnu.org -k_ -C ui/gtk.c | \
-=09  sed -e s/CHARSET/UTF-8/) >$@,"GEN","$@")
-
-$(PO_PATH)/%.po: $(PO_PATH)/messages.po
-=09$(call quiet-command, msgmerge -q $@ $< > $@.bak && mv $@.bak $@,"GEN",=
"$@")
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
+i18n =3D import('i18n')
+
+i18n.gettext(meson.project_name(),
+             args: '--msgid-bugs-address=3Dqemu-devel@nongnu.org',
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
-"Content-Type: text/plain; charset=3DUTF-8\n"
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
--=20
1.8.3.1



