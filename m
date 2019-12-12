Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC65C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2902521655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqnZxR+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2902521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOBF-00028o-Rp
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy1-0002w1-1p
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxz-00061c-N7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:16 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:40438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNxz-0005zu-G4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:15 -0500
Received: by mail-wr1-x434.google.com with SMTP id c14so2605893wrn.7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nrT9Ux8tVmOPoPyFcJzKXYTYdTxa8xjOI37YxzzLgC8=;
 b=YqnZxR+Bi0Sv7NLpCtfpJWfZaLDnEJFbOBjFuyNK1h/BaGGLC3Tv1g690sLGISQ9kj
 6vx1+31DK4fmaSr+mLjGXgw+wj/qzG09erf037CKE1iZGkqglJkI9UxhR3r2YXpNitL3
 hu0Zw2PwN7/FxGT0eFEnCIwpe8BqAr+04BoZGyYNFUlrVAAvmlzSEVumx3cUWYPV9Pb9
 cf0FX4ucl3fHvVa7qp1uU+ON10gyknVA+2eiQqCXz0u6Tz1+z52mVBB6/V5+9Bwyfxo1
 QlxIgO/D3HrnyYLP1s7RK1uABV1UfUSOoz9K6M1UBDirzSf/VkQdBT/1OwmUZMzrrGkb
 M0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nrT9Ux8tVmOPoPyFcJzKXYTYdTxa8xjOI37YxzzLgC8=;
 b=O5CxYM93d7Ao6CRkqBceZ4uVBogYwd1Zp91rKHfAuWJwtAKor+Btfu5ragdlSzdaRJ
 4KI1zx0PVGBbTX5wNhYIpc22ed/08JjYwybVP36P7Bi2zJvuAjNAOsy7LqJydnyndIK2
 pErQKea68yQxQGlh18b6APTh0eE7+dRYIe7lOzkiQVt5gB9B7ow6dbpUJa3LF9NGFIfN
 d88JTAnGUO1Bc3eQ9R4LdTZhERvvSKEkw1D6syDW1O2aDidNkS7jnRwU7VTy3AVYaU09
 j70hcKAECnfFltZQKxraHF/E50BnUq7xTK4PGDlPX+Lm0kj7jBnH5ZEpzTy3zyyaEJaG
 afWw==
X-Gm-Message-State: APjAAAUcXLvmDfLvN1N0ZempuW5qLgZBECO2j2V3fl4DfS+b+N6X7SKs
 KuH6fkigrI2VteNvSu9ZkueKQvMh
X-Google-Smtp-Source: APXvYqx8xp3bWqVb7RIhNKnDBx6U53nWhtEWnPTKP+gPikmxKN4NBEHJb/8j3wfofJ2jedqIDF8VkQ==
X-Received: by 2002:adf:f802:: with SMTP id s2mr6201558wrp.201.1576155194239; 
 Thu, 12 Dec 2019 04:53:14 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 016/132] contrib/vhost-user-input: convert to meson
Date: Thu, 12 Dec 2019 13:51:00 +0100
Message-Id: <1576155176-2464-17-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
 Makefile                               | 11 -----------
 Makefile.objs                          |  1 -
 contrib/vhost-user-input/Makefile.objs |  1 -
 contrib/vhost-user-input/meson.build   |  3 +++
 meson.build                            |  1 +
 5 files changed, 4 insertions(+), 13 deletions(-)
 delete mode 100644 contrib/vhost-user-input/Makefile.objs
 create mode 100644 contrib/vhost-user-input/meson.build

diff --git a/Makefile b/Makefile
index 5845a50..9528391 100644
--- a/Makefile
+++ b/Makefile
@@ -266,7 +266,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
@@ -466,16 +465,6 @@ endif
 vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
-ifdef CONFIG_VHOST_USER_INPUT
-ifdef CONFIG_LINUX
-vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
-
-# build by default, do not install
-all: vhost-user-input$(EXESUF)
-endif
-endif
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/Makefile.objs b/Makefile.objs
index f2e8864..c7f7637 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -109,7 +109,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
 
 ######################################################################
diff --git a/contrib/vhost-user-input/Makefile.objs b/contrib/vhost-user-input/Makefile.objs
deleted file mode 100644
index b1fad90..0000000
--- a/contrib/vhost-user-input/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-vhost-user-input-obj-y = main.o
diff --git a/contrib/vhost-user-input/meson.build b/contrib/vhost-user-input/meson.build
new file mode 100644
index 0000000..6f79679
--- /dev/null
+++ b/contrib/vhost-user-input/meson.build
@@ -0,0 +1,3 @@
+executable('vhost-user-input', files('main.c'),
+           link_with: libvhost_user,
+           dependencies: qemuutil)
diff --git a/meson.build b/meson.build
index 119fcd4..e38c8a9 100644
--- a/meson.build
+++ b/meson.build
@@ -199,6 +199,7 @@ if have_tools
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
+    subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
   endif
 endif
-- 
1.8.3.1



