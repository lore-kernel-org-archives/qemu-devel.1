Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E3BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0520A20748
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWx4D72O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0520A20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gY5-0004ZK-7C
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGr-00041N-F8
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:57 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGp-00065C-O9
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id c15so15227738wrs.11
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8dZzY9VXvh43Ekdfsl0mj5O/wna2bcmAq+4iHeKQ4jE=;
 b=rWx4D72OhKLEVEyLgYhGFrkfb+SDOyWy8DmiTrg16YhfhFaMvAYah5rJNJ+HY+d4pA
 ahips8+VSzZR++hyaCDd/zHFICrzxVhvb8U4jmD6d57C22P7fJHAEu9GF2vFAvMsr98m
 FU3QdHvuEiW2emv6KS8QXi04ynHeAv6C34Q2+3g52p1pFExrmv4Qa0hXhhr5euu1gcBs
 KT+Apnb3Ozb+mHfUQxZ4BIAeoA3VnB5NN8Aebi9z4CVQAvVrEmB7lySL6JsQna7C3eNa
 4/M0ha7lKv423sMhJSANRjTIZSb1rE0iHXbyN30nSGJ0TycwQ3vpDb3dVX1mzMiZ1EFZ
 NG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8dZzY9VXvh43Ekdfsl0mj5O/wna2bcmAq+4iHeKQ4jE=;
 b=ZM0Wnl+6jjf2gb2puYkTmbTS2jeuUHg+t8Ogi5yXf6YJwWdMwEsgm9zqks/hLuKPmT
 S1mzyYSRzQPhJI6aOZ75QCyKgTrru2lO30jYUjnCQ8rXLTRcwMcNEsPDe+Zfgu7S6sgb
 /FuYY+y8UvlFiGnKaIYRwbPTVH/SYCFGh7gfw8yN8jAqD4CYg6BIjctbVeuvU7Eb7TMv
 xbQqYrrDqQu+V0nC8aSGbMKXN0rSvwm7OM+ufkeJyYisa/igzOWRyGx2D+U/c7aN8kpW
 6lClsceSPzezAQBzaK7YlbDB9pArDtavZQGm2SW2FdaED4Hwd9gttjUHdTkKXeU2A9Iz
 pxww==
X-Gm-Message-State: AOAM532fULCGH8Z5T6kCr4T/YrtByJMkGoNhXl6O4GRv5jbNScCum8bJ
 S+n+t7YmX6yvCuUN+HOG8l1Lt3H0QdI=
X-Google-Smtp-Source: ABdhPJyqOwvPlp/vfHXFPulMx8A2+IIFNwT25L2NEJrq8EBcbpJWZcXvlDxG3fgdwPuwBgaFsd1yQg==
X-Received: by 2002:a5d:544a:: with SMTP id w10mr16076702wrv.317.1597675074088; 
 Mon, 17 Aug 2020 07:37:54 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.53 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 027/150] contrib/libvhost-user: convert to Meson
Date: Mon, 17 Aug 2020 16:35:20 +0200
Message-Id: <20200817143723.343284-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x442.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since libqemuutil.a has been converted to Meson, the conversion is
straightforward.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                            | 16 +++++-----------
 Makefile.objs                       |  1 -
 contrib/libvhost-user/Makefile.objs |  1 -
 contrib/libvhost-user/meson.build   |  3 +++
 meson.build                         |  8 ++++++++
 5 files changed, 16 insertions(+), 13 deletions(-)
 delete mode 100644 contrib/libvhost-user/Makefile.objs
 create mode 100644 contrib/libvhost-user/meson.build

diff --git a/Makefile b/Makefile
index 973e932869..2dee3e89a4 100644
--- a/Makefile
+++ b/Makefile
@@ -307,7 +307,6 @@ dummy := $(call unnest-vars,, \
                 ivshmem-server-obj-y \
                 virtiofsd-obj-y \
                 rdmacm-mux-obj-y \
-                libvhost-user-obj-y \
                 vhost-user-scsi-obj-y \
                 vhost-user-blk-obj-y \
                 vhost-user-input-obj-y \
@@ -432,11 +431,6 @@ $(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
 
 Makefile: $(version-obj-y)
 
-######################################################################
-# Build libraries
-
-libvhost-user.a: $(libvhost-user-obj-y)
-
 ######################################################################
 
 COMMON_LDADDS = libqemuutil.a
@@ -535,9 +529,9 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
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
@@ -546,16 +540,16 @@ rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
 
 # relies on Linux-specific syscalls
 ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
-virtiofsd$(EXESUF): $(virtiofsd-obj-y) libvhost-user.a $(COMMON_LDADDS)
+virtiofsd$(EXESUF): $(virtiofsd-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
 
-vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) libvhost-user.a $(COMMON_LDADDS)
+vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 ifdef CONFIG_VHOST_USER_INPUT
 ifdef CONFIG_LINUX
-vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) libvhost-user.a $(COMMON_LDADDS)
+vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 # build by default, do not install
diff --git a/Makefile.objs b/Makefile.objs
index e5c9077517..9489864967 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -106,7 +106,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-libvhost-user-obj-y = contrib/libvhost-user/
 vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
diff --git a/contrib/libvhost-user/Makefile.objs b/contrib/libvhost-user/Makefile.objs
deleted file mode 100644
index ef3778edd4..0000000000
--- a/contrib/libvhost-user/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-libvhost-user-obj-y += libvhost-user.o libvhost-user-glib.o
diff --git a/contrib/libvhost-user/meson.build b/contrib/libvhost-user/meson.build
new file mode 100644
index 0000000000..e68dd1a581
--- /dev/null
+++ b/contrib/libvhost-user/meson.build
@@ -0,0 +1,3 @@
+libvhost_user = static_library('vhost-user',
+                               files('libvhost-user.c', 'libvhost-user-glib.c'),
+                               build_by_default: false)
diff --git a/meson.build b/meson.build
index d70c98bd9c..00a519edc6 100644
--- a/meson.build
+++ b/meson.build
@@ -239,6 +239,14 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
+# Other build targets
+
+if have_tools
+  if 'CONFIG_VHOST_USER' in config_host
+    subdir('contrib/libvhost-user')
+  endif
+endif
+
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
 summary_info += {'BIOS directory':    config_host['qemu_datadir']}
-- 
2.26.2



