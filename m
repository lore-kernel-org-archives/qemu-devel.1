Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CE1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1ADD2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxJHHhq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1ADD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWO5-0002pU-TO
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8t-0005Pp-G2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8m-00027V-R7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:10 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8m-00024w-IP
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:08 -0500
Received: by mail-wm1-x343.google.com with SMTP id g1so3507768wmh.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mxfBBpFk2HL0soEj2DJhlcL5zgYjAjxBqQDT/uKJ5IQ=;
 b=jxJHHhq3s0TUOeLFykXaJtD0MesbMXN8sGjn3cpq5iOAwoWHcDWe051FYhrwfmD2OM
 5n7Dboai5mFBWu8tp56Ei9/AHop67Ps6FCH+5wGM01KrsyvM05t6IjVLxQ1qSXiijsMn
 Ev1UWGclEaBSbNOlZJTHRrH5C8FZkrMgu5AWdU7ChvnDLgBpLbtQ1XubDyoF//fb1iC4
 4xCpWbpFnuTChoeFTVGnX6kQyLF0kPU481ItAlyCvEhGLsA1TsrshOZUhAe+xFIbFe2u
 wFjNhXneDXvzTA7SAQ7NNPC3Rpoey2U1sAPKmSgoPwwdHTdo4AfIGLPZjRUButzWYIbP
 oDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mxfBBpFk2HL0soEj2DJhlcL5zgYjAjxBqQDT/uKJ5IQ=;
 b=Dxg5NDswgYX7ma14QO3KNmbefNmSBh0VQZbpduU4v7a7CUWcXHPJnA3r7ZZIfBou3p
 KExb5b5z1RMA3f5t+YQL1JtO+7LUkyKAFaB85/jb+b2qXxxKfeBCZK2ledwTv6EsrU+q
 X6a24uS87TjYBNGrS/TV15GNOUbCEdpy1BjklhNCCDJwisg2fZowI6q7pv8/XTr/jod8
 BzQjUg38tkakg4AL+qAnCxTt3YXGNph9giF/scrbiVt5gXGgZRDWpD7c7urAsLNIR9gL
 Vc8Zd+sEggZg9pUyygXYRRNZab/Dd7B7UIVgRuiFfkFnMkoL18acyA3/sdW76IYrWJPY
 HnKA==
X-Gm-Message-State: APjAAAX3AA0XAwIn/bcjX1bZR3vxlz0F9ba81mhebgSTdW/+KZFBVMAz
 qiFLlUBhSZqYG2u3S588WIsGgXwx
X-Google-Smtp-Source: APXvYqx1MpfuX5SPMkVWAw+Si9+OgEJ2MeHBdgtbZkSDLcQ0DWM7xchudKkmwsPEOAmck4a200jlUA==
X-Received: by 2002:a7b:c459:: with SMTP id l25mr6169301wmi.17.1580234345050; 
 Tue, 28 Jan 2020 09:59:05 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:59:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 134/142] meson: convert po/
Date: Tue, 28 Jan 2020 18:53:34 +0100
Message-Id: <20200128175342.9066-135-pbonzini@redhat.com>
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
 Makefile       |  3 --
 meson.build    |  4 +++
 po/LINGUAS     |  7 +++++
 po/Makefile    | 52 -----------------------------------
 po/POTFILES    |  1 +
 po/meson.build |  5 ++++
 po/messages.po | 74 --------------------------------------------------
 7 files changed, 17 insertions(+), 129 deletions(-)
 create mode 100644 po/LINGUAS
 delete mode 100644 po/Makefile
 create mode 100644 po/POTFILES
 create mode 100644 po/meson.build
 delete mode 100644 po/messages.po

diff --git a/Makefile b/Makefile
index 24bacf6e3a..112bae68b2 100644
--- a/Makefile
+++ b/Makefile
@@ -222,9 +222,6 @@ endif
 endif
 
 install: all install-localstatedir
-ifdef CONFIG_GTK
-	$(MAKE) -C po $@
-endif
 
 # Add a dependency on the generated files, so that they are always
 # rebuilt before other object files
diff --git a/meson.build b/meson.build
index 2d042017bf..6083897fc7 100644
--- a/meson.build
+++ b/meson.build
@@ -1089,3 +1089,7 @@ if host_machine.system() == 'windows'
                 build_always_stale: true,
                 command: nsis_cmd + ['@INPUT@'])
 endif
+
+if 'CONFIG_GTK' in config_host
+  subdir('po')
+endif
diff --git a/po/LINGUAS b/po/LINGUAS
new file mode 100644
index 0000000000..054930d8d6
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
index 0000000000..b99d8e2f22
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
-- 
2.21.0



