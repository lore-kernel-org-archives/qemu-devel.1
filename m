Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D93C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625E9204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0pZIEBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625E9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gWD-0000hq-EE
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGz-0004Fr-JT
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGx-00068V-NJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so15275447wrw.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f4qt9FKyFSeN8BJ56T9zt2ILCTqUpRYsJA1sb+QqLwo=;
 b=Z0pZIEBEDHdtjk6lRkw66nGR9BpFdYVfp4DzjNHrZZq7RuFhGdPAEz3cAWIBki7A6S
 yMbH0Xacvz5A4unJ9aI/lvfEHAzyCZ8IwBxY3fuqUl6fciIvjSbY/Kc+cxtca4bgXaqn
 GD8Qxf4W6qRTt5eN+MQ/yFPXRPaNK0E/rmjTj8MVppkrI+W/Ln53+QbdGIJSVabcXSgN
 D6EqDxVMR5EkPPaNClKwmyoc4Gzri+NzDFFrFcZXdj0arXhMmPTNPKagqwh4P9Y0xnPc
 ogPEf8fS2XL5cB+KHs8UmiIGYKiie/JhzVrnYqkfYz/EkDwtPalwNxGjk3+lyTBjXofV
 VWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=f4qt9FKyFSeN8BJ56T9zt2ILCTqUpRYsJA1sb+QqLwo=;
 b=FDz9XXz6AALi+fQKJOVMBvelk7uos1ROxGNYOhokGRyKO/eAnkqtg2Tth5/wUGzBcE
 XhzPCWwLIT2+3P/q6XpSSU97z+KJ8rI4/Xz5jQ/1UXaUdg1oe9nRSugYu6Zz3bcB647p
 8Bm1GIf0tqf8eba5tMv3VzQpZPCYXk8Br5mjNu23FXDuklK7ha4dEZqOX0Y9ltb/TEt0
 v7sKyENP5nkV0FO9Nt/va51pRrOVsQoTWjXxv2uilDK0Zsupo1k/EphMk5XOESMenKk6
 OxfS6e/wEE53VyT9yx/bLhSMygK+yJ6WgZzOleXohU24EX2acnzq4wF/B5EhqGEkHB2n
 ytiw==
X-Gm-Message-State: AOAM531kKqK73Wwh5ro56cT0+LOlH4Q5WOF+bKmRJjX6rp8ZmB0iV5jz
 KqC0xPNRh4wnTyDpDv1RabbOKhTICPA=
X-Google-Smtp-Source: ABdhPJyjA8E2nBx5p0o3HHo1X2SV6mnGezH53Ta1vDnsRj4otxURC7lvAhfF3Wawcdttxib3yfQ1Vg==
X-Received: by 2002:adf:e98c:: with SMTP id h12mr15621288wrm.3.1597675082221; 
 Mon, 17 Aug 2020 07:38:02 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 036/150] contrib/elf2dmp: convert to meson
Date: Mon, 17 Aug 2020 16:35:29 +0200
Message-Id: <20200817143723.343284-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
 Makefile                      | 4 ----
 Makefile.objs                 | 6 ------
 configure                     | 3 ---
 contrib/elf2dmp/Makefile.objs | 4 ----
 contrib/elf2dmp/meson.build   | 5 +++++
 meson.build                   | 6 ++++++
 6 files changed, 11 insertions(+), 17 deletions(-)
 delete mode 100644 contrib/elf2dmp/Makefile.objs
 create mode 100644 contrib/elf2dmp/meson.build

diff --git a/Makefile b/Makefile
index 0cc478b2f1..b97a3d0eeb 100644
--- a/Makefile
+++ b/Makefile
@@ -291,7 +291,6 @@ dummy := $(call unnest-vars,, \
                 authz-obj-y \
                 chardev-obj-y \
                 qga-obj-y \
-                elf2dmp-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -501,9 +500,6 @@ ifneq ($(EXESUF),)
 qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
-elf2dmp$(EXESUF): $(elf2dmp-obj-y)
-	$(call LINK, $^)
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/Makefile.objs b/Makefile.objs
index 336a684ff3..1486254a2c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -100,9 +100,3 @@ version-obj-$(CONFIG_WIN32) += $(BUILD_DIR)/version.o
 # extracted into a QAPI schema module, or perhaps a separate schema.
 qga-obj-y = qga/
 qga-vss-dll-obj-y = qga/
-
-######################################################################
-# contrib
-elf2dmp-obj-y = contrib/elf2dmp/
-
-######################################################################
diff --git a/configure b/configure
index b6237f8102..0eb9f8aefd 100755
--- a/configure
+++ b/configure
@@ -6680,9 +6680,6 @@ if test "$want_tools" = "yes" ; then
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) qemu-storage-daemon\$(EXESUF) $tools"
   fi
-  if [ "$curl" = "yes" ]; then
-      tools="elf2dmp\$(EXESUF) $tools"
-  fi
 fi
 if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
diff --git a/contrib/elf2dmp/Makefile.objs b/contrib/elf2dmp/Makefile.objs
deleted file mode 100644
index 1505716916..0000000000
--- a/contrib/elf2dmp/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-elf2dmp-obj-y = main.o addrspace.o download.o pdb.o qemu_elf.o
-
-download.o-cflags := $(CURL_CFLAGS)
-download.o-libs   := $(CURL_LIBS)
diff --git a/contrib/elf2dmp/meson.build b/contrib/elf2dmp/meson.build
new file mode 100644
index 0000000000..b3de173316
--- /dev/null
+++ b/contrib/elf2dmp/meson.build
@@ -0,0 +1,5 @@
+if 'CONFIG_CURL' in config_host
+  executable('elf2dmp', files('main.c', 'addrspace.c', 'download.c', 'pdb.c', 'qemu_elf.c'),
+             dependencies: [glib, curl],
+             install: true)
+endif
diff --git a/meson.build b/meson.build
index 0814ec3e62..661f1bb4f5 100644
--- a/meson.build
+++ b/meson.build
@@ -106,6 +106,11 @@ if 'CONFIG_VIRGL' in config_host
   virgl = declare_dependency(compile_args: config_host['VIRGL_CFLAGS'].split(),
                              link_args: config_host['VIRGL_LIBS'].split())
 endif
+curl = not_found
+if 'CONFIG_CURL' in config_host
+  curl = declare_dependency(compile_args: config_host['CURL_CFLAGS'].split(),
+                            link_args: config_host['CURL_LIBS'].split())
+endif
 
 target_dirs = config_host['TARGET_DIRS'].split()
 have_user = false
@@ -270,6 +275,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 
 if have_tools
   subdir('contrib/rdmacm-mux')
+  subdir('contrib/elf2dmp')
 
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
-- 
2.26.2



