Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D7CC74A2B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F772086D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enMWWHMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F772086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlFMc-0003Gu-U4
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 12:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55410)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlFF4-00068T-6l
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlFEy-0007b5-0b
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:46 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hlFEv-0007SF-4O
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id a15so2890765wmj.5
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jIw3wGu90O5VPci/xvcIGXIfoKSHop6LUOoGJt7ZTWc=;
 b=enMWWHMhdGScWeiH9/8UKECqgmTSu17wDmSjJK72LOxDFdTgOvdgz7yQ3ijCMvLbrB
 rOQkuXzS4XyCuv+ZC5yT3e3CJqSl/tyTcW8isk2BNnHz76fOqus50Ddl93eh7/F7DiUF
 W3X90JXamLEaiCgM+BuDlk9qE/IowstDZ9yrMBxJR175DUmOtmcNqfWPfV40iN1mMBak
 xOklGzeevOBCYfjDguSoc8DMqwvhIbdpnhDr7ROgNCsEHB1lu8UMP3WymzP15QqyMRvg
 Zzi2alBWuNNiqFlQlQAWcPqXHPRkOEj9TOvOu2TucpYjSeFMvJjQba6PuorTnSozrKTY
 6W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=jIw3wGu90O5VPci/xvcIGXIfoKSHop6LUOoGJt7ZTWc=;
 b=KgULuhHvZwex8bLL3Zw9GxsSl72i6/0hOnVc8rAvO0o3fdOyvaC25XZf2mKFrzgZsL
 sqf1rhIWkq3OEkEf9gpcjEkomw/N1gsdifFvgYrGg2EI2WSXLsdSJgQ6TriJrxbxbict
 OuwNXnEzOkjOspxi5XorqQLTe/24DeNaFM7kvkze2tbqeuqR3FS+lRKe1h7J9QUIax2Z
 OqLk5qa+XeTQ1vsn/Kj5XYXYJj1jtFNBIou7yEreWctUxdntiiUnGZTvHIZf92rgzrgf
 kPSFXOPlaireUP79dq1m8F6rqDyH91V1ulgEG7e6B7KQ88W9mMDFv8OHPXaANndw9guh
 vcLw==
X-Gm-Message-State: APjAAAUr+oiC5K7h3serJY7zZ37YE2k/7S0YwQrcB4gzys87HY7OSYQ+
 0naE3ToPRvr43dxVWozKo1jF8zVDODw=
X-Google-Smtp-Source: APXvYqwvunjfBK2yqOmf+RskOpwp/guTdq7v7TXbm2tasfOLXWevCHT/RI4yABOZwq+Oz/CmxL0hrw==
X-Received: by 2002:a7b:cb08:: with SMTP id u8mr5916598wmj.167.1562775275945; 
 Wed, 10 Jul 2019 09:14:35 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id w14sm2573747wrk.44.2019.07.10.09.14.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 09:14:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Jul 2019 18:14:24 +0200
Message-Id: <1562775267-1222-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 5/8] libvhost-user: convert to Meson
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since libqemuutil.a has been converted to Meson, the conversion is
straightforward.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                            | 14 ++++----------
 Makefile.objs                       |  1 -
 contrib/libvhost-user/Makefile.objs |  1 -
 contrib/libvhost-user/meson.build   |  2 ++
 meson.build                         |  4 ++++
 5 files changed, 10 insertions(+), 12 deletions(-)
 delete mode 100644 contrib/libvhost-user/Makefile.objs
 create mode 100644 contrib/libvhost-user/meson.build

diff --git a/Makefile b/Makefile
index ddc7d27..3763d8c 100644
--- a/Makefile
+++ b/Makefile
@@ -323,7 +323,6 @@ dummy := $(call unnest-vars,, \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
                 rdmacm-mux-obj-y \
-                libvhost-user-obj-y \
                 vhost-user-scsi-obj-y \
                 vhost-user-blk-obj-y \
                 vhost-user-input-obj-y \
@@ -422,11 +421,6 @@ $(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
 Makefile: $(version-obj-y)
 
 ######################################################################
-# Build libraries
-
-libvhost-user.a: $(libvhost-user-obj-y)
-
-######################################################################
 
 COMMON_LDADDS = libqemuutil.a
 
@@ -517,21 +511,21 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
 ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
-vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a $(COMMON_LDADDS)
+vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
-vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a $(COMMON_LDADDS)
+vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 
-vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) $(COMMON_LDADDS)
+vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 ifdef CONFIG_VHOST_USER_INPUT
 ifdef CONFIG_LINUX
-vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) libvhost-user.a $(COMMON_LDADDS)
+vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 # build by default, do not install
diff --git a/Makefile.objs b/Makefile.objs
index 29ffaa3..0bcba93 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -114,7 +114,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-libvhost-user-obj-y = contrib/libvhost-user/
 vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
diff --git a/contrib/libvhost-user/Makefile.objs b/contrib/libvhost-user/Makefile.objs
deleted file mode 100644
index ef3778e..0000000
--- a/contrib/libvhost-user/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-libvhost-user-obj-y += libvhost-user.o libvhost-user-glib.o
diff --git a/contrib/libvhost-user/meson.build b/contrib/libvhost-user/meson.build
new file mode 100644
index 0000000..03ba2af
--- /dev/null
+++ b/contrib/libvhost-user/meson.build
@@ -0,0 +1,2 @@
+libvhost_user = static_library('vhost-user',
+                               [files('libvhost-user.c', 'libvhost-user-glib.c')])
diff --git a/meson.build b/meson.build
index c625547..a0a8554 100644
--- a/meson.build
+++ b/meson.build
@@ -140,3 +140,7 @@ util_obj = util_obj.apply(config_host, strict: false)
 libqemuutil = static_library('qemuutil',
                              sources: util_obj.sources(),
                              dependencies: util_obj.dependencies())
+
+# Other build targets
+
+subdir('contrib/libvhost-user')
-- 
1.8.3.1



