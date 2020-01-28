Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69928C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 357192467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQswSAQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357192467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWW6-0002ez-D6
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8B-0004Od-2I
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV88-0000SK-16
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:29 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV86-0000Mr-Td
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:27 -0500
Received: by mail-wm1-x344.google.com with SMTP id b2so3602234wma.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yDMeWhFqJfE6BCp05PCiIFcKB6QDyfv+gH+4B4iyQ8Q=;
 b=pQswSAQMZ/CdW0IrUEyLTDt8ZI7Y8sdTG9cyJAj9GU8jUnoQ6lBIaDCAOs+0iS0XFv
 g1lq9qnC1ltpahFMX/NUfYAHNmny/OjXNEx0GT4ExBZdbF/+JYde6bWATC9acQN8/ZJS
 cTwq8wXGaXwh+JNMnuNAuaXKuH04xejyj+eUigL9rYdTQbhQ/cOrjw2VXJBWRHyuiDnj
 r6r6gBesF1bBdgYaNFyA6aQ7pcgHv6LIvcNdHqIO5KMvFD1tCBzaqeFuxxPNl1d31ss8
 jnkM+aq2zJCZsSyw4AyczCB0moT/E5plWIMMTe+h8foYcZd5ppyeOKsGx7D2izmSS1Jx
 fqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yDMeWhFqJfE6BCp05PCiIFcKB6QDyfv+gH+4B4iyQ8Q=;
 b=eDpFEFL7eXcOKcTZOQ5yQ57Ze+aq6UThDdKrJ9Yh+IRUUKs94DNSpqhoArlMZ8QnsB
 INfiEChyB/tQBznbAYSfTA5yysqxN4b4ahCuvOtU9M9MOppg4G0/zAEADBvtxaTNvfkl
 5NR5TBo1dInqryG2Mld6YNwDomVNLO06SCBfOyBPZO8jIw2V4uZfuyYqtod9kmOVQx+9
 +ezDjjv+LTfbVhwNzcmSggT5IqK0t/sFr79zUYPScmblrZ4tu8uL7H5me3ECaHFl93I6
 fT84I7WX14rDZU3iuyKJB+32pjJtQuk7j1Z3eYPWZyxVNvP704csMcOKWMKuoE68bgOo
 vfdw==
X-Gm-Message-State: APjAAAXgkGqHopu2ndEkPdILLXwsnb/m3J9Blnt4sATSSKgb23s2Brdj
 IqqsQ3VLdAZySawTyP/55kKj6Mh4
X-Google-Smtp-Source: APXvYqy/V8x0u6V2LgciP3RIOtFjWqRl4oKpTHVRJtTtXBv4q+zdzp4Ws4/kno4bMZiGigiN57sDfg==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr6684712wmc.154.1580234305302; 
 Tue, 28 Jan 2020 09:58:25 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 118/142] meson: plugins
Date: Tue, 28 Jan 2020 18:53:18 +0100
Message-Id: <20200128175342.9066-119-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For now link arguments end up in Makefile.target, they will move to the
right place soon.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile              |  8 +-------
 Makefile.target       | 11 +++++++++--
 meson.build           |  5 +++++
 plugins/Makefile.objs | 21 ---------------------
 plugins/meson.build   |  5 +++++
 5 files changed, 20 insertions(+), 30 deletions(-)
 delete mode 100644 plugins/Makefile.objs
 create mode 100644 plugins/meson.build

diff --git a/Makefile b/Makefile
index 3706b6d142..82492fa67c 100644
--- a/Makefile
+++ b/Makefile
@@ -404,11 +404,8 @@ endif
 
 ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 
-install-includedir:
-	$(INSTALL_DIR) "$(DESTDIR)$(includedir)"
-
 install: all $(if $(BUILD_DOCS),install-doc) \
-	install-datadir install-localstatedir install-includedir \
+	install-datadir install-localstatedir \
 	$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
 	recurse-install
 ifdef CONFIG_TRACE_SYSTEMTAP
@@ -450,9 +447,6 @@ endif
 		"$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
 ifdef CONFIG_GTK
 	$(MAKE) -C po $@
-endif
-ifeq ($(CONFIG_PLUGIN),y)
-	$(INSTALL_DATA) $(SRC_PATH)/include/qemu/qemu-plugin.h "$(DESTDIR)$(includedir)/qemu-plugin.h"
 endif
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
 	set -e; for x in $(KEYMAPS); do \
diff --git a/Makefile.target b/Makefile.target
index c1b640bd99..edc08803db 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -110,8 +110,6 @@ obj-y += trace/
 #########################################################
 LIBS := $(libs_cpu) $(LIBS)
 
-obj-$(CONFIG_PLUGIN) += plugins/
-
 #########################################################
 # Linux user emulator target
 
@@ -150,6 +148,15 @@ LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
 LIBS := $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
 LIBS := $(LIBS) $(VIRGL_LIBS) $(CURSES_LIBS)
 
+ifeq ($(CONFIG_PLUGIN),y)
+ifdef CONFIG_HAS_LD_DYNAMIC_LIST
+LIBS += -Wl,--dynamic-list=$(BUILD_DIR)/qemu-plugins-ld.symbols
+else
+ifdef CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST
+LIBS += -Wl,-exported_symbols_list,$(BUILD_DIR)/qemu-plugins-ld64.symbols
+endif
+endif
+
 generated-files-y += hmp-commands.h hmp-commands-info.h
 
 endif # CONFIG_SOFTMMU
diff --git a/meson.build b/meson.build
index 48f2114091..f924d69185 100644
--- a/meson.build
+++ b/meson.build
@@ -685,6 +685,7 @@ subdir('net')
 subdir('replay')
 subdir('hw')
 subdir('accel')
+subdir('plugins')
 subdir('bsd-user')
 subdir('linux-user')
 
@@ -835,6 +836,10 @@ endforeach
 
 # Other build targets
 
+if 'CONFIG_PLUGIN' in config_host
+  install_headers('include/qemu/qemu-plugin.h')
+endif
+
 if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
diff --git a/plugins/Makefile.objs b/plugins/Makefile.objs
deleted file mode 100644
index 6f14d91ccb..0000000000
--- a/plugins/Makefile.objs
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# Plugin Support
-#
-
-obj-y += loader.o
-obj-y += core.o
-obj-y += api.o
-
-# Abuse -libs suffix to only link with --dynamic-list/-exported_symbols_list
-# when the final binary includes the plugin object.
-#
-# Note that simply setting LDFLAGS is not enough: we build binaries that
-# never link plugin.o, and the linker might fail (at least ld64 does)
-# if the symbols in the list are not in the output binary.
-ifdef CONFIG_HAS_LD_DYNAMIC_LIST
-api.o-libs := -Wl,--dynamic-list=$(BUILD_DIR)/qemu-plugins-ld.symbols
-else
-ifdef CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST
-api.o-libs := -Wl,-exported_symbols_list,$(BUILD_DIR)/qemu-plugins-ld64.symbols
-endif
-endif
diff --git a/plugins/meson.build b/plugins/meson.build
new file mode 100644
index 0000000000..9608e5293f
--- /dev/null
+++ b/plugins/meson.build
@@ -0,0 +1,5 @@
+specific_ss.add(when: 'CONFIG_PLUGIN', if_true: [files(
+  'loader.c',
+  'core.c',
+  'api.c',
+)])
-- 
2.21.0



