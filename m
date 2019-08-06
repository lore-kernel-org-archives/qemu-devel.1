Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A88EC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559182147A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJIQpgzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559182147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hutdg-0007PW-L8
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 03:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39707)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hutcu-00064U-NQ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hutct-0002Mt-CZ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:11:20 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hutct-0002MY-6Y
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:11:19 -0400
Received: by mail-wm1-x341.google.com with SMTP id l2so75256180wmg.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 00:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=tno4fXYT35ehLgDjYVWzgn0Y8l88An91Jzi5a/0s+24=;
 b=KJIQpgzjdFVKQNE6HQVnxDnukTDhY5M+78jTEOIkSp9s9l03J3xtvsBmxrV38FXKIl
 QoUYwd7xhcblvb6aAXAQwkVWqkrkYOAZ0/pXFpjzvUbwGhSOkuvXY5mH4Jcwo3hQc8Xo
 X/G5WSSxTIFPZSJJNsKWN2Qt4KxbsRH0fa0EhVXaltKn2dDoEqdxEg8NDpnibNd5bXm0
 4numxwfDY26bIzvfemnjlrpRLJzVHqldnkSFgqB76UEQyFBtGd3+HnB9O8r+L2ybtc9T
 SLyBeAMcH2KAsWitmQ95H/kkymFAYIatGcmCa+DizgYdwEgrVbfQIBnRkMbXvV09DcQS
 l21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=tno4fXYT35ehLgDjYVWzgn0Y8l88An91Jzi5a/0s+24=;
 b=AgEf2VIeBUZK2Yp3cAbhubRcPhPxajcfS+ONkRjs+HHrKOfnPCcjZFJ3dSxGJVlbyE
 5wlumvXjgNApv/efn384tjIbxrKtDPLITeUUi2inO4TmrROXHrICtcPqIR8b7fHz6mhB
 WVewvL01Qu+jyB/UXOsoHB5YDVTgl20LWY2lWl3DFOFWDHJ9rnW09DdqJ5GBo+aygFvS
 3NB+URuxGf0H0cUTbccy3mWLEZrZUuAF66ItfI0sMM/JWtmbRh6EMc+xq38B88vA6ZSQ
 Mr67CsXwF3nSrEsWP/uG9i9B0JoWjKOMaapXn4mAFkF1WkzqKBwfqGkDcAsKQe8TxmHJ
 ye/w==
X-Gm-Message-State: APjAAAWTcIFN/39tk5TT+8FZpzZ5PxSFGsFrSZf5f1goGgotqA7YvpMs
 KhoDlUsjBZ33LmVhTlIBo69m5ubt
X-Google-Smtp-Source: APXvYqyj9T755yenE1q+7pJvluJVHWs5StpnXW4sQWszhtKmh9x/j6Lzo8qUee2CzdlWzEtcqipNWw==
X-Received: by 2002:a05:600c:2189:: with SMTP id
 e9mr2699916wme.56.1565075478004; 
 Tue, 06 Aug 2019 00:11:18 -0700 (PDT)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s10sm112652132wmf.8.2019.08.06.00.11.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 00:11:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 09:11:15 +0200
Message-Id: <1565075475-15313-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH] crypto: move common bits for all emulators to
 libqemuutil
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qcrypto_random_*, AES and qcrypto_init do not need to be linked as a whole
and are the only parts that are used by user-mode emulation.  Place them
in libqemuutil, so that whatever needs them will pick them up automatically.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                         | 3 +++
 Makefile                            | 4 +---
 Makefile.objs                       | 1 -
 Makefile.target                     | 2 --
 crypto/Makefile.objs                | 7 -------
 util/Makefile.objs                  | 5 +++++
 {crypto => util}/aes.c              | 0
 crypto/init.c => util/crypto-init.c | 0
 {crypto => util}/random-gcrypt.c    | 0
 {crypto => util}/random-gnutls.c    | 0
 {crypto => util}/random-platform.c  | 0
 11 files changed, 9 insertions(+), 13 deletions(-)
 rename {crypto => util}/aes.c (100%)
 rename crypto/init.c => util/crypto-init.c (100%)
 rename {crypto => util}/random-gcrypt.c (100%)
 rename {crypto => util}/random-gnutls.c (100%)
 rename {crypto => util}/random-platform.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cad58b9..c8feaeb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2141,6 +2141,9 @@ F: tests/test-crypto-*
 F: tests/benchmark-crypto-*
 F: tests/crypto-tls-*
 F: tests/pkix_asn1_tab.c
+F: util/aes.c
+F: util/crypto-init.c
+F: util/random-*.c
 F: qemu.sasl
 
 Coroutines
diff --git a/Makefile b/Makefile
index dfd158c..73fbba0 100644
--- a/Makefile
+++ b/Makefile
@@ -425,7 +425,6 @@ dummy := $(call unnest-vars,, \
                 block-obj-y \
                 block-obj-m \
                 crypto-obj-y \
-                crypto-user-obj-y \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
@@ -498,8 +497,7 @@ subdir-capstone: .git-submodule-status
 subdir-slirp: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
 
-$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) \
-	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
+$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(qom-obj-y)
 
 ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
 # Only keep -O and -g cflags
diff --git a/Makefile.objs b/Makefile.objs
index 658cfc9..4d7e49e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -25,7 +25,6 @@ block-obj-m = block/
 # crypto-obj-y is code used by both qemu system emulation and qemu-img
 
 crypto-obj-y = crypto/
-crypto-user-obj-y = crypto/
 
 #######################################################################
 # qom-obj-y is code used by both qemu system emulation and qemu-img
diff --git a/Makefile.target b/Makefile.target
index 72c267f..6737fea 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -181,7 +181,6 @@ dummy := $(call unnest-vars,.., \
                block-obj-m \
                chardev-obj-y \
                crypto-obj-y \
-               crypto-user-obj-y \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
@@ -190,7 +189,6 @@ all-obj-y += $(common-obj-y)
 all-obj-y += $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(block-obj-y) $(chardev-obj-y)
-all-obj-$(CONFIG_USER_ONLY) += $(crypto-user-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 7fe2fa9..e17f3fb 100644
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
@@ -36,7 +32,4 @@ crypto-obj-y += block.o
 crypto-obj-y += block-qcow.o
 crypto-obj-y += block-luks.o
 
-# Let the userspace emulators avoid linking stuff they won't use.
-crypto-user-obj-y = aes.o $(crypto-rng-obj-y) init.o
-
 stub-obj-y += pbkdf-stub.o
diff --git a/util/Makefile.objs b/util/Makefile.objs
index a817ced..5e80fd9 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -57,3 +57,8 @@ util-obj-$(CONFIG_POSIX) += drm.o
 util-obj-y += guest-random.o
 
 stub-obj-y += filemonitor-stub.o
+
+util-obj-$(CONFIG_GCRYPT) += random-gcrypt.o
+util-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) += random-gnutls.o
+util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) += random-platform.o
+util-obj-y += aes.o crypto-init.o
diff --git a/crypto/aes.c b/util/aes.c
similarity index 100%
rename from crypto/aes.c
rename to util/aes.c
diff --git a/crypto/init.c b/util/crypto-init.c
similarity index 100%
rename from crypto/init.c
rename to util/crypto-init.c
diff --git a/crypto/random-gcrypt.c b/util/random-gcrypt.c
similarity index 100%
rename from crypto/random-gcrypt.c
rename to util/random-gcrypt.c
diff --git a/crypto/random-gnutls.c b/util/random-gnutls.c
similarity index 100%
rename from crypto/random-gnutls.c
rename to util/random-gnutls.c
diff --git a/crypto/random-platform.c b/util/random-platform.c
similarity index 100%
rename from crypto/random-platform.c
rename to util/random-platform.c
-- 
1.8.3.1


