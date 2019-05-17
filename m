Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C155C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6DC20848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVRE1jVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6DC20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40147 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSr9-0000tn-Vo
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:44:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmS-0005Mp-Tj
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmR-0001zE-Mh
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:32 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmR-0001y1-5Y
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:31 -0400
Received: by mail-pf1-x443.google.com with SMTP id g9so2857480pfo.11
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=w67dNgvn9kqojlns7NF9r0Y8A8UDA9sA3tpOmEXRHUw=;
	b=GVRE1jVMxZUSaTuKh16/e8qpCCMaq9j5IU+rFXulHjV9VorD4/My5JGV01E/ujhxMm
	pY4QH3/fG3U1rx96zpxjUx2c6UwK9rxppAvrrZPbWJVJctReaLtCjSvOLgOWAhORlhPY
	QnYaTd8gDiEFKHEj5tQVOI63HNZtqArRWUPwW4EkULld5MS/ynR2RQAv1f19GbEqAcZS
	gP4NL7sLk/UFsgMZwopUvVJmtAnSXTrQ6lkUaioETHptpFuMry4gTzOnn/tS0vTfnGK6
	WdCeCnSYfJyFnzELzXhCRalX2D+WmLk4+BpMHfRqYgSBFcNbWGNlIBTpKaNUedUXahFi
	apyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=w67dNgvn9kqojlns7NF9r0Y8A8UDA9sA3tpOmEXRHUw=;
	b=fuNBESvfd7bPPHBhW6babcGbajIKtQleMJ/VvCssCRbH3f8WHDP1+Mt9JvgxauBCBJ
	ON4Tu5uOyXZ05ExJtYFBiF+64hR98bM6FKSc/56Q81HGzRsvSbeR8/SyJyuM5NtfZeer
	o+HC6nJWh/OJqo9Ufx0dF4K3t233uO+B1z/n4P8zX8napL9ZSQDTtS8vQisu4evUkav1
	e8P0/gUtxiXMNabmE/f3VAf3f602E3k/LaxDzQN16tIIqnDQFe/bKxAGxnpMnT+qqFbP
	BKtWB6XyER1APaxqtMMo5NxOnNDYo00pQG55FAfX/f2wO4iOpt3bmQoj0QS0sZt0rav/
	Thpg==
X-Gm-Message-State: APjAAAWtFRCKKy+6DeEvQuhmCUzPVeLRsop8Qy3Tw8UE6IMIt4wxmkPM
	QdPlgMu8QZiKQO/Vh72ksRiDwmhEoe4=
X-Google-Smtp-Source: APXvYqya0lLKUCznzQaPwsEhw9RZWDQowJFU/1jmONtmTm+wDkDPwJXe4HNHhKWdfFRvsrD3jlRIHw==
X-Received: by 2002:a63:2d87:: with SMTP id
	t129mr54072650pgt.451.1558060769734; 
	Thu, 16 May 2019 19:39:29 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:01 -0700
Message-Id: <20190517023924.1686-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v8 02/25] build: Link user-only with crypto
 random number objects
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For user-only, we require only the random number bits of the
crypto subsystem.  Rename crypto-aes-obj-y to crypto-user-obj-y,
and add the random number objects, plus init.o to handle any
extra stuff the crypto library requires.

Move the crypto libraries from libs_softmmu and libs_tools to
LIBS, so that they are universally used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile             |  4 ++--
 Makefile.objs        |  2 +-
 Makefile.target      |  4 ++--
 configure            |  9 +++------
 crypto/Makefile.objs | 11 ++++++-----
 5 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 66d5c65156..8419d759e0 100644
--- a/Makefile
+++ b/Makefile
@@ -410,7 +410,7 @@ dummy := $(call unnest-vars,, \
                 block-obj-y \
                 block-obj-m \
                 crypto-obj-y \
-                crypto-aes-obj-y \
+                crypto-user-obj-y \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
@@ -483,7 +483,7 @@ subdir-slirp: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
 
 $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
-	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
+	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
 
 ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
 # Only keep -O and -g cflags
diff --git a/Makefile.objs b/Makefile.objs
index cf065de5ed..84fa83ba21 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -25,7 +25,7 @@ block-obj-m = block/
 # crypto-obj-y is code used by both qemu system emulation and qemu-img
 
 crypto-obj-y = crypto/
-crypto-aes-obj-y = crypto/
+crypto-user-obj-y = crypto/
 
 #######################################################################
 # qom-obj-y is code used by both qemu system emulation and qemu-img
diff --git a/Makefile.target b/Makefile.target
index ae02495951..bde256436b 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -180,7 +180,7 @@ dummy := $(call unnest-vars,.., \
                block-obj-m \
                chardev-obj-y \
                crypto-obj-y \
-               crypto-aes-obj-y \
+               crypto-user-obj-y \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
@@ -189,7 +189,7 @@ all-obj-y += $(common-obj-y)
 all-obj-y += $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(block-obj-y) $(chardev-obj-y)
-all-obj-$(CONFIG_USER_ONLY) += $(crypto-aes-obj-y)
+all-obj-$(CONFIG_USER_ONLY) += $(crypto-user-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 
diff --git a/configure b/configure
index f8345368bf..03e71ef7b6 100755
--- a/configure
+++ b/configure
@@ -2792,8 +2792,7 @@ if test "$gnutls" != "no"; then
         # At least ubuntu 18.04 ships only shared libraries.
         write_c_skeleton
         if compile_prog "" "$gnutls_libs" ; then
-            libs_softmmu="$gnutls_libs $libs_softmmu"
-            libs_tools="$gnutls_libs $libs_tools"
+            LIBS="$gnutls_libs $LIBS"
             QEMU_CFLAGS="$QEMU_CFLAGS $gnutls_cflags"
             pass="yes"
         fi
@@ -2864,8 +2863,7 @@ if test "$nettle" != "no"; then
         # Link test to make sure the given libraries work (e.g for static).
         write_c_skeleton
         if compile_prog "" "$nettle_libs" ; then
-            libs_softmmu="$nettle_libs $libs_softmmu"
-            libs_tools="$nettle_libs $libs_tools"
+            LIBS="$nettle_libs $LIBS"
             QEMU_CFLAGS="$QEMU_CFLAGS $nettle_cflags"
             if test -z "$gcrypt"; then
                gcrypt="no"
@@ -2896,8 +2894,7 @@ if test "$gcrypt" != "no"; then
         # Link test to make sure the given libraries work (e.g for static).
         write_c_skeleton
         if compile_prog "" "$gcrypt_libs" ; then
-            libs_softmmu="$gcrypt_libs $libs_softmmu"
-            libs_tools="$gcrypt_libs $libs_tools"
+            LIBS="$gcrypt_libs $LIBS"
             QEMU_CFLAGS="$QEMU_CFLAGS $gcrypt_cflags"
             pass="yes"
         fi
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 256c9aca1f..7fe2fa9da2 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -19,9 +19,10 @@ crypto-obj-y += tlscredspsk.o
 crypto-obj-y += tlscredsx509.o
 crypto-obj-y += tlssession.o
 crypto-obj-y += secret.o
-crypto-obj-$(CONFIG_GCRYPT) += random-gcrypt.o
-crypto-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) += random-gnutls.o
-crypto-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) += random-platform.o
+crypto-rng-obj-$(CONFIG_GCRYPT) += random-gcrypt.o
+crypto-rng-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) += random-gnutls.o
+crypto-rng-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) += random-platform.o
+crypto-obj-y += $(crypto-rng-obj-y)
 crypto-obj-y += pbkdf.o
 crypto-obj-$(CONFIG_NETTLE) += pbkdf-nettle.o
 crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += pbkdf-gcrypt.o
@@ -35,7 +36,7 @@ crypto-obj-y += block.o
 crypto-obj-y += block-qcow.o
 crypto-obj-y += block-luks.o
 
-# Let the userspace emulators avoid linking gnutls/etc
-crypto-aes-obj-y = aes.o
+# Let the userspace emulators avoid linking stuff they won't use.
+crypto-user-obj-y = aes.o $(crypto-rng-obj-y) init.o
 
 stub-obj-y += pbkdf-stub.o
-- 
2.17.1


