Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C19CC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A064206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZk9RW9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A064206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtem-0003h7-Uo
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFT-0005YS-0y
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFQ-0008IH-Ol
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:29 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFQ-0008GA-Hy
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:28 -0500
Received: by mail-wm1-x343.google.com with SMTP id b19so7422822wmj.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=l1KSd5++PafxRf9FJ4N/UJ/RdxW52LM0AVNPlxBCWg8=;
 b=RZk9RW9kk0wix0b+p2prn2bJselx2x/uIU23QvLGM54G7MdBKcABNwYdxx3V6E9Kjm
 HvHWDFhsuppM29cakx41QUNpu4EDQs/F31hdLGhXV4ivlGSyfS50E9NFGyqA4wsILJUU
 FGNfTarGwVqOftGrKT8EZm3S86IxQircBo4x3q8Giq6rQzrpYpOjva2ltDKyrrTzTTJY
 8GA4gv7HlHF5zF1MTuFFfh4ZVEKFEaUeCpgmxYMODcH+Gts67fKVVHHAqYtDxQd4e2Ok
 BBTrKNCRKWZ/6e98Ddt2xAoVr87tTADqoHZIDNLJzB3YlgU60Vhm6Opdro7mtHNi0APk
 QBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=l1KSd5++PafxRf9FJ4N/UJ/RdxW52LM0AVNPlxBCWg8=;
 b=RGmRmpF+Snk/yeXmGsTddbXk51J79mTHe5e4ywDk7AUAv3hdQfXAI0i4jQgG2VN6Pr
 wLz4ltwGDH4pGHYgstVjE5EZPTuOHJxBl+/5TOp63z6bcO1Nm90rmvaEBb2/i81u1LLY
 CWPkbFp5BJ34KfYgYDYwMuZmGkKrnxUM541AkuxwHqSTstPzCJ3Yb1lEqHSCOA2TkEVL
 WjunUtIR+cVSwXSqj1T7oZzz+VOJuWQ1uLWgSCyu8cl22nN6NQWaOkX5+A86qYBm4Jh4
 NUamndfjCfhvHfum2w7WRgxz466kmJDVRi0iRWplpEUef2po9ymUL59s+H/L5p5Smlsz
 KOEw==
X-Gm-Message-State: APjAAAUzoC8z5OAGvL6IuWoNJQMx5IUOPIDvcnBAMsy+g6PBv2v/X0PS
 r0m4yUUcSYbArvr3AKIN+jW5v+gk
X-Google-Smtp-Source: APXvYqwZmAkx6HEHZd0SbnF7kuhx0HjnRt+LC3cqRLA6G7dvBuc/s/9CdV1Qg0U3pS0D45WIpYt1lA==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr32500527wmh.22.1576513767366; 
 Mon, 16 Dec 2019 08:29:27 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/62] crypto: move common bits for all emulators to libqemuutil
Date: Mon, 16 Dec 2019 17:28:24 +0100
Message-Id: <1576513726-53700-41-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

qcrypto_random_*, AES and qcrypto_init do not need to be linked as a whole
and are the only parts that are used by user-mode emulation.  Place them
in libqemuutil, so that whatever needs them will pick them up automatically.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile             |  3 +--
 Makefile.objs        |  3 +--
 Makefile.target      |  2 --
 crypto/Makefile.objs | 12 +++++-------
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index bfd8ba3..fb1728e 100644
--- a/Makefile
+++ b/Makefile
@@ -436,7 +436,6 @@ dummy := $(call unnest-vars,, \
                 block-obj-y \
                 block-obj-m \
                 crypto-obj-y \
-                crypto-user-obj-y \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
@@ -524,7 +523,7 @@ subdir-capstone: capstone/all
 subdir-slirp: slirp/all
 
 $(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
-	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
+	$(qom-obj-y)
 
 ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
diff --git a/Makefile.objs b/Makefile.objs
index b6fcbac..e33e992 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,7 +1,7 @@
 #######################################################################
 # Common libraries for tools and emulators
 stub-obj-y = stubs/ util/ crypto/
-util-obj-y = util/ qobject/ qapi/
+util-obj-y = crypto/ util/ qobject/ qapi/
 
 chardev-obj-y = chardev/
 
@@ -25,7 +25,6 @@ block-obj-m = block/
 # crypto-obj-y is code used by both qemu system emulation and qemu-img
 
 crypto-obj-y = crypto/
-crypto-user-obj-y = crypto/
 
 #######################################################################
 # qom-obj-y is code used by both qemu system emulation and qemu-img
diff --git a/Makefile.target b/Makefile.target
index 24d79d2..6e61f60 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -184,7 +184,6 @@ dummy := $(call unnest-vars,.., \
                block-obj-m \
                chardev-obj-y \
                crypto-obj-y \
-               crypto-user-obj-y \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
@@ -193,7 +192,6 @@ all-obj-y += $(common-obj-y)
 all-obj-y += $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(block-obj-y) $(chardev-obj-y)
-all-obj-$(CONFIG_USER_ONLY) += $(crypto-user-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index cdb01f9..58014d1 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -19,10 +19,6 @@ crypto-obj-y += tlscredspsk.o
 crypto-obj-y += tlscredsx509.o
 crypto-obj-y += tlssession.o
 crypto-obj-y += secret.o
-crypto-rng-obj-$(CONFIG_GCRYPT) += random-gcrypt.o
-crypto-rng-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) += random-gnutls.o
-crypto-rng-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) += random-platform.o
-crypto-obj-y += $(crypto-rng-obj-y)
 crypto-obj-y += pbkdf.o
 crypto-obj-$(CONFIG_NETTLE) += pbkdf-nettle.o
 crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += pbkdf-gcrypt.o
@@ -36,7 +32,9 @@ crypto-obj-y += block.o
 crypto-obj-y += block-qcow.o
 crypto-obj-y += block-luks.o
 
-# Let the userspace emulators avoid linking stuff they won't use.
-crypto-user-obj-y = aes.o $(crypto-rng-obj-y) init.o
-
 stub-obj-y += pbkdf-stub.o
+
+util-obj-$(CONFIG_GCRYPT) += random-gcrypt.o
+util-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) += random-gnutls.o
+util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) += random-platform.o
+util-obj-y += aes.o init.o
-- 
1.8.3.1



