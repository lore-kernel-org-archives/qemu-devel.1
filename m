Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F78C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C3D2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLhc4rIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C3D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOHE-0000kr-FS
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy3-00030a-Sj
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy2-00066k-FI
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:19 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36275)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNy2-00065B-8G
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:18 -0500
Received: by mail-wr1-x436.google.com with SMTP id z3so2631951wru.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+4vOKydhbkSE6dPJsSB3/rLuVb5akkwee9HULvmXiDY=;
 b=sLhc4rImU8yaGMn6Ttqan4T8QlulRqsUcn4+wmy6fc0xeFdxOeqHHdGEl6Z18Ac8OY
 vU9q10zHaKYNFGbvk9IS+pEkaS6iKXx9qK++jVSjBfLMo8oskJo54NMoQ5hOX5/22ERY
 3fY8Yvo0ZX6meDc40ZVF1788MpY42eMC7w0NmY2t5rdFuJkuYUpplW3D97UC/cyt8hUw
 BgIeHs5e/sm7+mnwjpLJ8iPwRiOKWOiZ2lxFpR9glf8Wzl4BlrRaa6t+AcrSUkPdR/bu
 rR4RgwJL9PRMcR07cG/Vp/PZY/bQL10t4Qp8qHl0eg/y6j7YcgjzOvFnVb42alsYdwmO
 a/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+4vOKydhbkSE6dPJsSB3/rLuVb5akkwee9HULvmXiDY=;
 b=f7Jyvh4J2GrDkJtGE/PvaYozUNE4SoLyfGXHtGJbj5t8nojgpvchvtaF04ni79e8km
 sLzxpIZPkidZQnzMrAK6ObnZMfjRQCCMmoDffAC5l2MkOH5TW4TFScDOQIBuajZmNIUJ
 IpzP4LSgrcrrQg2UKHANOTkJ0E0fSHgeDdxeliotQriOrobzggw6TBV5+256bMXmYWyJ
 cKHMHCbN3avpSCErdb4MaD6DdTyuxIzltqcilXozsVRWJeZGncz16aJXapilaIuQl9Pu
 N+AEA+QlIcjY/d+CKLXQ0iG72R8g7RV0Y++511YDXGlJE0MDV0cIV/CvGa31uE/JoArN
 QKrw==
X-Gm-Message-State: APjAAAWjryvgEw8/VSclYyNKsq1rScLc2U1lgqf+ZOJeInWn1Zh9HNIM
 +lbJCERihMOwIbAbXmtnf8MqSbLr
X-Google-Smtp-Source: APXvYqwSMH4Dv1WKtaG8o3JHzlAKkH1In/WwYJUPRU/JKSKcb4fMvTvEMM+jxuyHRA0QpEk39y6x/w==
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr5999858wra.36.1576155196983;
 Thu, 12 Dec 2019 04:53:16 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 019/132] contrib/elf2dmp: convert to meson
Date: Thu, 12 Dec 2019 13:51:03 +0100
Message-Id: <1576155176-2464-20-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                      | 4 ----
 Makefile.objs                 | 6 ------
 configure                     | 3 ---
 contrib/elf2dmp/Makefile.objs | 4 ----
 contrib/elf2dmp/meson.build   | 4 ++++
 meson.build                   | 6 ++++++
 6 files changed, 10 insertions(+), 17 deletions(-)
 delete mode 100644 contrib/elf2dmp/Makefile.objs
 create mode 100644 contrib/elf2dmp/meson.build

diff --git a/Makefile b/Makefile
index d697aab..6f2141f 100644
--- a/Makefile
+++ b/Makefile
@@ -262,7 +262,6 @@ dummy := $(call unnest-vars,, \
                 authz-obj-y \
                 chardev-obj-y \
                 qga-obj-y \
-                elf2dmp-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -448,9 +447,6 @@ ifneq ($(EXESUF),)
 qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
-elf2dmp$(EXESUF): $(elf2dmp-obj-y)
-	$(call LINK, $^)
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/Makefile.objs b/Makefile.objs
index 919961f..e91cdb9 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -103,9 +103,3 @@ util-obj-y +=  trace/
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
index d59c831..b38da39 100755
--- a/configure
+++ b/configure
@@ -6065,9 +6065,6 @@ if test "$want_tools" = "yes" ; then
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) $tools"
   fi
-  if [ "$curl" = "yes" ]; then
-      tools="elf2dmp\$(EXESUF) $tools"
-  fi
 fi
 if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
diff --git a/contrib/elf2dmp/Makefile.objs b/contrib/elf2dmp/Makefile.objs
deleted file mode 100644
index 1505716..0000000
--- a/contrib/elf2dmp/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-elf2dmp-obj-y = main.o addrspace.o download.o pdb.o qemu_elf.o
-
-download.o-cflags := $(CURL_CFLAGS)
-download.o-libs   := $(CURL_LIBS)
diff --git a/contrib/elf2dmp/meson.build b/contrib/elf2dmp/meson.build
new file mode 100644
index 0000000..b9e5199
--- /dev/null
+++ b/contrib/elf2dmp/meson.build
@@ -0,0 +1,4 @@
+if 'CONFIG_CURL' in config_host
+  executable('elf2dmp', files('main.c', 'addrspace.c', 'download.c', 'pdb.c', 'qemu_elf.c'),
+             dependencies: [glib, curl])
+endif
diff --git a/meson.build b/meson.build
index e2eee80..25c3db9 100644
--- a/meson.build
+++ b/meson.build
@@ -70,6 +70,11 @@ if 'CONFIG_VIRGL' in config_host
   virgl = declare_dependency(compile_args: config_host['VIRGL_CFLAGS'].split(),
                              link_args: config_host['VIRGL_LIBS'].split())
 endif
+curl = declare_dependency()
+if 'CONFIG_CURL' in config_host
+  curl = declare_dependency(compile_args: config_host['CURL_CFLAGS'].split(),
+                            link_args: config_host['CURL_LIBS'].split())
+endif
 
 target_dirs = config_host['TARGET_DIRS'].split()
 have_user = false
@@ -208,6 +213,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 
 if have_tools
   subdir('contrib/rdmacm-mux')
+  subdir('contrib/elf2dmp')
 
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
-- 
1.8.3.1



