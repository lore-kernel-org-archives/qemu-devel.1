Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E2EC74A21
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB432086D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLcCGdZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB432086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlFOX-0005vN-C8
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 12:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55414)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlFF4-00068W-72
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlFEy-0007bC-1W
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:46 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hlFEv-0007Td-8D
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id x15so2902731wmj.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FfGNZatfqO66RkDejyV8hgshvBe1I3Ln3kF+YP6swJs=;
 b=SLcCGdZzbPWXV69yeGCk0/GAFk2Wa4Zz37n3JIsEaRrHEk9qQO9mzgnVwTgw3DipyB
 PNm+YXnHnRX7VLUocHPd3RguNV4yYq3S3IDKib686YVO8fZkf5WVKL7jhfnin79Q6dq7
 FrmR+qmoDbCDFYcJfaWx+QQb6A9RpqSPIx9zdc5zTS5My+zhtnuf3Jb2nGlxT0wukMDV
 XbnwcMgGcsE6+Gse1Hfx0XbuHz6hmmGyTZdW0gJ0SGX2DawD0QM2LP63aLrZMCQipG3i
 wSsgsurHOJKbmWY2yFBSzQWm3JGKx857icDb+eaNYmA1G9TRPC0quEJ782khXUqlKe5c
 PH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=FfGNZatfqO66RkDejyV8hgshvBe1I3Ln3kF+YP6swJs=;
 b=lpo8Z5MRqW86BC3XLVWyIHvJf71vociAslrQaslDfE62i9dd2lQnaTtkk6/3twsXUK
 WPTYOdBN/JMMUPIjW0W3d2ZpeKacUGOeSRtJqu0RM9J1JZsoprx8xhToEKhPo7SyPxq4
 f6VPe+LyUr6Q1mBbaFDYiF0JtbLXqBNxwPqvXYWmo2xk/I2A5V+kbI8jCI5+xtUpCKTE
 Ni5E6siJNxJZPqc8Nb1t9wsFeRfKMUlEam0wd9Tcr/2zruN1bypBzSA+N2A0KF5rDR4r
 WWHB+1NVMULeRSXJ+0M9Zjn8dJ1532yRA98OZThe8eWklSf23uxp8+lUYMFAj1S+Mfo2
 y9Zg==
X-Gm-Message-State: APjAAAXqUfMDufQ6AnHnT3lQJad4cPrLzYYvZ2z1dqO6RwgYOVw2027B
 Ul8pHu941E2E9xpLvxfof1duaQVw3zk=
X-Google-Smtp-Source: APXvYqy+vBPuBq9AnANENvGjly1Vqdxu6kXwIozFpFsAj7llwWJGfHCKG5fXbEaAyCgtIk+hY8owFg==
X-Received: by 2002:a1c:407:: with SMTP id 7mr6401130wme.113.1562775277949;
 Wed, 10 Jul 2019 09:14:37 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id w14sm2573747wrk.44.2019.07.10.09.14.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 09:14:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Jul 2019 18:14:26 +0200
Message-Id: <1562775267-1222-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 7/8] vhost-user-scsi: convert to Meson
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

The libiscsi pkg-config information is extracted from config-host.mak and
used to link vhost-user-blk.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore                            | 2 +-
 Makefile                              | 3 ---
 Makefile.objs                         | 3 ---
 contrib/vhost-user-scsi/Makefile.objs | 1 -
 contrib/vhost-user-scsi/meson.build   | 3 +++
 meson.build                           | 3 +++
 6 files changed, 7 insertions(+), 8 deletions(-)
 delete mode 100644 contrib/vhost-user-scsi/Makefile.objs
 create mode 100644 contrib/vhost-user-scsi/meson.build

diff --git a/.gitignore b/.gitignore
index c39a02e..eff317c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -63,7 +63,7 @@
 /qemu-version.h.tmp
 /module_block.h
 /scsi/qemu-pr-helper
-/vhost-user-scsi
+/contrib/vhost-user-scsi/vhost-user-scsi
 /contrib/vhost-user-blk/vhost-user-blk
 /fsdev/virtfs-proxy-helper
 *.tmp
diff --git a/Makefile b/Makefile
index da60ec5..dd88634 100644
--- a/Makefile
+++ b/Makefile
@@ -323,7 +323,6 @@ dummy := $(call unnest-vars,, \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
                 rdmacm-mux-obj-y \
-                vhost-user-scsi-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -510,8 +509,6 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
 ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
-vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
 
 rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
diff --git a/Makefile.objs b/Makefile.objs
index b192250..1ea1d20 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -114,9 +114,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
-vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
-vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
 rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
diff --git a/contrib/vhost-user-scsi/Makefile.objs b/contrib/vhost-user-scsi/Makefile.objs
deleted file mode 100644
index e83a38a..0000000
--- a/contrib/vhost-user-scsi/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-vhost-user-scsi-obj-y = vhost-user-scsi.o
diff --git a/contrib/vhost-user-scsi/meson.build b/contrib/vhost-user-scsi/meson.build
new file mode 100644
index 0000000..6a91f0b
--- /dev/null
+++ b/contrib/vhost-user-scsi/meson.build
@@ -0,0 +1,3 @@
+executable('vhost-user-scsi', files('vhost-user-scsi.c'),
+           link_with: [libvhost_user, libqemuutil],
+           dependencies: [glib, libiscsi])
diff --git a/meson.build b/meson.build
index cee759b..2d29418 100644
--- a/meson.build
+++ b/meson.build
@@ -15,6 +15,8 @@ configure_file(input: files('scripts/ninjatool.py'),
 
 glib = declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split(),
                           link_args: config_host['GLIB_LIBS'].split())
+libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
+                          link_args: config_host['LIBISCSI_LIBS'].split())
 slirp = declare_dependency(compile_args: config_host['SLIRP_CFLAGS'].split(),
                            link_args: config_host['SLIRP_LIBS'].split())
 
@@ -147,3 +149,4 @@ libqemuutil = static_library('qemuutil',
 
 subdir('contrib/libvhost-user')
 subdir('contrib/vhost-user-blk')
+subdir('contrib/vhost-user-scsi')
-- 
1.8.3.1



