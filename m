Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475C9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1852120716
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0EPXG7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1852120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35083 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVUy-0000vx-72
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4T-0006vt-Vd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4S-0000Bp-J1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:41 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:32902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4R-00007T-Bb
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:40 -0500
Received: by mail-wm1-x32e.google.com with SMTP id m10so2318392wmc.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vjxWiHfp9R8uoYrXtWkwPCReUpRGn/3mP0mNebyf0EI=;
 b=n0EPXG7NF59ZR/0EGHoOiIwKxkwsoQKmM3XD0rnJak3qnW1DX6BqH/WZa2MeATT4DJ
 JUs8hUEP5E00MYkdAR6MpAILlyC0xvxqgjpyhmSd+vqWWq79nNXtUpO/8idr4l4PdlZ0
 obDA7A17yf/0IMMdavV0OfvYysi1ik3BOBtrnipgT+rAtxV6UdO15rueNL9esmSvVsSz
 vNUe04M0zUuFw0AsuIwPR29fGbZ7T11XFlMFXviQB/gue+xcwFOTIh7qhtMoQvc7QsS+
 aMHM8qSJy1zoF9TP+HOxB1t2CPHhanYgoXkMpCT+HWSnFWBBWajYmCZHxbKqFh/Fsbgp
 F+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vjxWiHfp9R8uoYrXtWkwPCReUpRGn/3mP0mNebyf0EI=;
 b=KhQ60MYad9j+3/XbsHJ79DBWBAENHkA/J+4KCH0zG6gtFTwgmnrIuMfHGm5kPDGdWE
 IuvDfY1YwTIY5r06Qff0dp0l8IXgv56rqYJLNgdRKIjyGUYx0d7K+XsloHLVC1P9H21m
 iRBf26nWAblU1fYEGM/Pdsw5btLL7uaVeA+mOn+eQsCfQ8u0fA9jzqkSUg6Fn5EU9oEZ
 LLbwLMV+DK/EC83h1upwc1L/3+ArApkPh2C2Brw+fNdu1ClEVoocZfhORxcK8Now71dF
 W2K0+rC8JpyvfHNW3WjI50+4BzKu+mEieHx7v6cQSPyozYLD9PZoJpSow6qR+/AKBH8e
 vmtg==
X-Gm-Message-State: APjAAAWdEj+yLYuuaqPMWpsKSV13XYmYj0ORMGikaOGhqf2+4JoFCKWq
 F08drBJqjL7HbOZxm/nGPl5KhI4e
X-Google-Smtp-Source: APXvYqwLgg2NWBDBrl2YSR3kRBF+8sMOs+NhzkKGHuZAHtDy2683E1GfBxzLCnK9wPmttJU/12AUWw==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr5981821wmg.147.1580234078098; 
 Tue, 28 Jan 2020 09:54:38 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 021/142] contrib/vhost-user-gpu: convert to meson
Date: Tue, 28 Jan 2020 18:51:41 +0100
Message-Id: <20200128175342.9066-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
 Makefile                             |  5 -----
 Makefile.objs                        |  1 -
 contrib/vhost-user-gpu/Makefile.objs | 10 ----------
 contrib/vhost-user-gpu/meson.build   |  5 +++++
 meson.build                          | 15 +++++++++++++++
 5 files changed, 20 insertions(+), 16 deletions(-)
 delete mode 100644 contrib/vhost-user-gpu/Makefile.objs
 create mode 100644 contrib/vhost-user-gpu/meson.build

diff --git a/Makefile b/Makefile
index 8b999e7f42..5c000b2a2f 100644
--- a/Makefile
+++ b/Makefile
@@ -186,7 +186,6 @@ HELPERS-y =
 HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = qemu-bridge-helper$(EXESUF)
 
 ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
-HELPERS-y += vhost-user-gpu$(EXESUF)
 vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
 
@@ -289,7 +288,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -497,9 +495,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
 
-vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/Makefile.objs b/Makefile.objs
index aa5ca99c28..2f375be444 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -108,6 +108,5 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
 
 ######################################################################
diff --git a/contrib/vhost-user-gpu/Makefile.objs b/contrib/vhost-user-gpu/Makefile.objs
deleted file mode 100644
index 6170c919e4..0000000000
--- a/contrib/vhost-user-gpu/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-vhost-user-gpu-obj-y = main.o virgl.o vugbm.o
-
-main.o-cflags := $(PIXMAN_CFLAGS) $(GBM_CFLAGS)
-main.o-libs := $(PIXMAN_LIBS)
-
-virgl.o-cflags := $(VIRGL_CFLAGS) $(GBM_CFLAGS)
-virgl.o-libs := $(VIRGL_LIBS)
-
-vugbm.o-cflags := $(GBM_CFLAGS)
-vugbm.o-libs := $(GBM_LIBS)
diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gpu/meson.build
new file mode 100644
index 0000000000..8778aa79de
--- /dev/null
+++ b/contrib/vhost-user-gpu/meson.build
@@ -0,0 +1,5 @@
+if 'CONFIG_VIRGL' in config_host and 'CONFIG_GBM' in config_host
+  executable('vhost-user-gpu', files('main.c', 'virgl.c', 'vugbm.c'),
+             link_with: libvhost_user,
+             dependencies: [qemuutil, pixman, gbm, virgl])
+endif
diff --git a/meson.build b/meson.build
index f56f8b3897..6613eae7e2 100644
--- a/meson.build
+++ b/meson.build
@@ -52,11 +52,23 @@ if 'CONFIG_GNUTLS' in config_host
   gnutls = declare_dependency(compile_args: config_host['GNUTLS_CFLAGS'].split(),
                               link_args: config_host['GNUTLS_LIBS'].split())
 endif
+pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
+                            link_args: config_host['PIXMAN_LIBS'].split())
 libiscsi = declare_dependency()
 if 'CONFIG_LIBISCSI' in config_host
   libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
                                 link_args: config_host['LIBISCSI_LIBS'].split())
 endif
+gbm = declare_dependency()
+if 'CONFIG_GBM' in config_host
+  gbm = declare_dependency(compile_args: config_host['GBM_CFLAGS'].split(),
+                           link_args: config_host['GBM_LIBS'].split())
+endif
+virgl = declare_dependency()
+if 'CONFIG_VIRGL' in config_host
+  virgl = declare_dependency(compile_args: config_host['VIRGL_CFLAGS'].split(),
+                             link_args: config_host['VIRGL_LIBS'].split())
+endif
 
 target_dirs = config_host['TARGET_DIRS'].split()
 have_user = false
@@ -201,6 +213,9 @@ if have_tools
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
+    if 'CONFIG_LINUX' in config_host
+      subdir('contrib/vhost-user-gpu')
+    endif
     subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
   endif
-- 
2.21.0



