Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48403C74A21
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15CA4208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9UydPK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CA4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlFIN-00088N-Av
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 12:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlFF4-00068V-73
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlFEy-0007az-0L
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hlFEv-0007V1-6F
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:41 -0400
Received: by mail-wm1-x344.google.com with SMTP id v19so2871945wmj.5
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dX31/pShFtHDFUD8cp02Xwwr4WggC1YB603YwzepdnU=;
 b=b9UydPK/r5BSMWvuNIm/4K45jIz7h7bp+GUlbr4D6o60SxBa2Jy/k+jSU0EonhEZBJ
 K14BPjuLPxB61OhdkNzOMJG2hpWlVSvjIYOrSUEKCtEri7IFEidGkt+uYnBjXShgv8LM
 Sa5xPk2pe73NmN08aD9yY/Usht3UbxJx2Gljytf3DaLzQqARogq0ylgzrdzfIrNij2OQ
 OPSauLqDvcQMZwOmR4UbkiZ6pxi4x+GSTX1F+H2tidX0HPKRdV5W4sE+JzshzSpOH/iR
 fvZ3M0T0TbvWAbIHck7kK0Xj0XUXz41hwqMlrxdFI3f05Py010RkP5B/VgsISOVVDZc8
 qLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=dX31/pShFtHDFUD8cp02Xwwr4WggC1YB603YwzepdnU=;
 b=G1PTomeh+hanD8cLdhZajsxiMXph/pqx8HvAdSUHlHF9OjGV3kSmaq7n9iOpMpguR0
 3ESADdgS7o/t4/EZKvg3LUOh0uwoLGQEsCrWqHztwiIvjRobBUoBrcLF95hJPzvpbp2m
 RhHXdwXaAl0Jvtzibu9u9kcJePcimSbzsfz9yxbP/xEo7a/8SLjhm07rm7BfDsIl7663
 J+n5/UVb3Pf64t+dFXCPPd/Ybf9n9rx1ihI/4MXNPmDxZ1TrXNfwNeJ/YerK06zmBRmv
 mMbhlHq94KU7SPmKLRQOdA8JWPbG4bYTSaGuu14DoTzUO2cDoFUO+9veRCCNrTRbZoM+
 5AAA==
X-Gm-Message-State: APjAAAWBgCxUNDZMLKoAE/Txulpwp1ETUrl9RqZI65g5TKmGMU7Ajebe
 FujNGYpv3G2+Wiqm0Av2QN6m20zkQII=
X-Google-Smtp-Source: APXvYqyxiyKE8F6uM75BCSCklkAIr8h2+89qiI4YDUYWAGCiHQzsZGVsOCDFZKdMt5EaE2uKOPRRMw==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr6385347wmj.13.1562775278857;
 Wed, 10 Jul 2019 09:14:38 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id w14sm2573747wrk.44.2019.07.10.09.14.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 09:14:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Jul 2019 18:14:27 +0200
Message-Id: <1562775267-1222-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 8/8] rdmacm-mux: convert to Meson
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
index eff317c..656db05 100644
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
index dd88634..a11df79 100644
--- a/Makefile
+++ b/Makefile
@@ -322,7 +322,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                rdmacm-mux-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -510,10 +509,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
 
-rdmacm-mux$(EXESUF): LIBS += "-libumad"
-rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-
 vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
diff --git a/Makefile.objs b/Makefile.objs
index 1ea1d20..ca77ad1 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -114,7 +114,6 @@ qga-vss-dll-obj-y = qga/
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
index 2d29418..b778dda 100644
--- a/meson.build
+++ b/meson.build
@@ -1,4 +1,5 @@
 project('qemu', 'c', meson_version: '>=0.50.999')
+cc = meson.get_compiler('c')
 
 kconfig = import('unstable-kconfig')
 ss = import('sourceset')
@@ -148,5 +149,6 @@ libqemuutil = static_library('qemuutil',
 # Other build targets
 
 subdir('contrib/libvhost-user')
+subdir('contrib/rdmacm-mux')
 subdir('contrib/vhost-user-blk')
 subdir('contrib/vhost-user-scsi')
-- 
1.8.3.1


