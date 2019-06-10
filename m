Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198F1C28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 11:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9E0206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 11:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbkNzMgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9E0206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haINO-00048x-5N
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 07:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43119)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1haIGg-0007BV-II
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1haIGf-0000bM-79
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:15:14 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1haIGe-0000aG-Vb
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:15:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id s3so8077279wms.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 04:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=5QNa1qywltOY6IhhPyZZnFVHJhPrjIri5Xi1Vm0lVkk=;
 b=tbkNzMgZvlmIF2ql8mCeTLatUCDgwBJMugxDqS9+v7duU8xmgmwIFXx+VMtjiRk48s
 55+REGzJR8GKzxUr5ydLQfRwH4j7+TLBmTy8oI4rknKQttNnKyrjhng7jUQB2ITWFEy5
 CDQ0qSQi2CxWWM58YsO/gxPKjFIDz/vCEGSmAka8INu6UjXzuV6EB5n63Ky87kEKRy1C
 S4pj4eATdqWUFCoxQ2975atQILYdgDRrXk30dHNzoR36DVkQgTnW+6LDXDmN1SeZ+VPY
 S0BjEA6HbKAQgl7huWwqVmwG0dIGbnQzy3NPYl5bYiXROSUoZXFPDVEjPPmiSaQLqU6M
 qkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=5QNa1qywltOY6IhhPyZZnFVHJhPrjIri5Xi1Vm0lVkk=;
 b=mnDwQLciX5fcxouoVfct4kIqlDYeKwv7WRpkwjipVP05mu1MBkLwcggeagXZq4SD2K
 xj+FY8m/tNGMENvyucFqIrvd9GAq31PmIBxpD29gNqsi6003rJes5iEcymkE95+zq/zS
 BEu0DGM3X2/mgPd+BfJROCbATB2EPQzBWtpt/xHEjunGk++VeJ+7MNSP0843C2mU1emQ
 0J0l7WORzTo0fFMsmTQUG/KHetUii1I272aUUCRDBrh1C4dL8XJkYlDimXCIIZLj4r1B
 1lz/DqM/+iTep+aA0xpMKTpYNVKWq2CnNNzkDLxqU6njX55DbkehKLiB7aHbut4wY2Lm
 YwjQ==
X-Gm-Message-State: APjAAAW/n1edD0QwLr8RGqzfRK0+OyyJmS3jYZAl1w4h2XJBwT9fdIHP
 XiXIe3acHZe9/e/q3s7X5Vax9MIS
X-Google-Smtp-Source: APXvYqwXycJSjS0AoXaUh8Z0Ig0CGIEQY3cHg/3+0ZunE1t+2yNZxZgqR6l1Ge6UbNzn9U7zyZ0dPw==
X-Received: by 2002:a1c:2082:: with SMTP id g124mr12614993wmg.71.1560165311604; 
 Mon, 10 Jun 2019 04:15:11 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id u13sm11934414wrq.62.2019.06.10.04.15.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 04:15:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 13:15:01 +0200
Message-Id: <1560165301-39026-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 7/7] rdmacm-mux: convert to Meson
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

We can use config-host.mak to decide whether the tool has to be built,
apart from that the conversion is straightforward.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore                       | 1 +
 Makefile                         | 5 -----
 Makefile.objs                    | 1 -
 contrib/rdmacm-mux/Makefile.objs | 3 ---
 contrib/rdmacm-mux/meson.build   | 6 ++++++
 meson.build                      | 2 ++
 6 files changed, 9 insertions(+), 9 deletions(-)
 delete mode 100644 contrib/rdmacm-mux/Makefile.objs
 create mode 100644 contrib/rdmacm-mux/meson.build

diff --git a/.gitignore b/.gitignore
index 3934eff..b8d38a8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -63,6 +63,7 @@
 /qemu-version.h.tmp
 /module_block.h
 /scsi/qemu-pr-helper
+/contrib/rdmacm-mux/rdmacm-mux
 /contrib/vhost-user-scsi/vhost-user-scsi
 /contrib/vhost-user-blk/vhost-user-blk
 /fsdev/virtfs-proxy-helper
diff --git a/Makefile b/Makefile
index bff097c..713f301 100644
--- a/Makefile
+++ b/Makefile
@@ -425,7 +425,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                rdmacm-mux-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -629,10 +628,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
 
-rdmacm-mux$(EXESUF): LIBS += "-libumad"
-rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-
 vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a
 	$(call LINK, $^)
 
diff --git a/Makefile.objs b/Makefile.objs
index adf2f92..cf02f63 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -116,7 +116,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
 
diff --git a/contrib/rdmacm-mux/Makefile.objs b/contrib/rdmacm-mux/Makefile.objs
deleted file mode 100644
index 3df744a..0000000
--- a/contrib/rdmacm-mux/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-ifdef CONFIG_PVRDMA
-rdmacm-mux-obj-y = main.o
-endif
diff --git a/contrib/rdmacm-mux/meson.build b/contrib/rdmacm-mux/meson.build
new file mode 100644
index 0000000..8451756
--- /dev/null
+++ b/contrib/rdmacm-mux/meson.build
@@ -0,0 +1,6 @@
+if config_host['CONFIG_PVRDMA'] == 'y'
+  # if not found, CONFIG_PVRDMA should not be set
+  libumad = cc.find_library('ibumad', required: true)
+  executable('rdmacm-mux', files('main.c'),
+             dependencies: [glib, libumad])
+endif
diff --git a/meson.build b/meson.build
index bc7fbea..2fc6111 100644
--- a/meson.build
+++ b/meson.build
@@ -1,4 +1,5 @@
 project('qemu', 'c', meson_version: '>=0.50.999')
+cc = meson.get_compiler('c')
 
 kconfig = import('unstable-kconfig')
 config_host = kconfig.load(meson.current_build_dir() / 'config-host.mak')
@@ -14,5 +15,6 @@ libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split
                           link_args: config_host['LIBISCSI_LIBS'].split())
 
 subdir('contrib/libvhost-user')
+subdir('contrib/rdmacm-mux')
 subdir('contrib/vhost-user-blk')
 subdir('contrib/vhost-user-scsi')
-- 
1.8.3.1


