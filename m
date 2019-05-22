Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D737CC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9574C20868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EY20sgin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9574C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49839 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWdi-0005Pn-PY
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:11:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOt-00086f-5x
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWC7-00080s-5L
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:32 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:42439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWC7-00080m-11
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:31 -0400
Received: by mail-yw1-xc41.google.com with SMTP id s5so1236491ywd.9
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=i3KWRWimQh5hv++1F1wzio+dP9yFcGqKmqdoYeXPACQ=;
	b=EY20sginGSANyyQGWpVnz88xzaVI8p1N/CE5IO6cvsAohKVfSeLPJnUf2AwbrLFGJ+
	2rJNjlxwswchdn05UCtFM+of1bthCMjgAkfX7jiQWv+RbapxPopt2g/OXtaRCPzcQtZx
	u6SFCqWVYHv9HaxUzVvOXoX8JX8vL/P/61/EPpEql+GYO3XIFfjW8RzeRVfjFEFVOlUS
	v/g/2AJHg3SK7HSeYYevEgRmHAmtSzlwgp8NNYajLxtxeyoTTM/Wshd/Txs38Mwl6nf3
	t6Zon2ZhyVca6yuRJApDQ9PyZWCZT0WITOgOYT+akJ8eDDyAy0b5DZZeA4mMeV91fdun
	mmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=i3KWRWimQh5hv++1F1wzio+dP9yFcGqKmqdoYeXPACQ=;
	b=grSVbW0nrl6lfQIlLbVHClOchKLCdcKPOxhAjScRZzh2bUQn9/dhMTqj0K3RrfceIz
	Miot5zEIgVwh1rEwHN3tM+QWQ8lTFnpCdhSvVo4CVRWA/U4JyJlsQNFlyXx7AMEa3m/m
	lv1ilkjeoLEGRvu0y8n9/VKUr6svnCSFDw7P+fcDcFehmaDmJ1Dpol1Y6xB+Xz+eg3XA
	9zWJ/dVziQwtfTEfwWroM/6xTksd5vP3eaatYHToZJrVuqcUXho3+GJR0gjVWef4K1gl
	WeHKzkq3JEfhFJtjTdKBRq0fcnQcQdl3YFglQU3KQYISnDQMeBDuxE+RH8vr30J4r3hz
	TyHQ==
X-Gm-Message-State: APjAAAXtZ586Gvq7zoxSxlhZaLM88hCC4fP4DZDxIBlA++xm9/IFVTib
	M5dbRUnjX/nsDFxsRtO+FrO36lTldwQ=
X-Google-Smtp-Source: APXvYqz0hye9RW6bhvMLd6CU6i31pKQd7Vr+uKlBjKUzRVR0puwjqUdvJI8US/8cyEkpSc7m7gzZyg==
X-Received: by 2002:a0d:c707:: with SMTP id j7mr40724434ywd.250.1558550550226; 
	Wed, 22 May 2019 11:42:30 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:03 -0400
Message-Id: <20190522184226.17871-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [PULL 02/25] build: Link user-only with crypto random
 number objects
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For user-only, we require only the random number bits of the
crypto subsystem.  Rename crypto-aes-obj-y to crypto-user-obj-y,
and add the random number objects, plus init.o to handle any
extra stuff the crypto library requires.

Move the crypto libraries from libs_softmmu and libs_tools to
LIBS, so that they are universally used.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile             |  4 ++--
 Makefile.objs        |  2 +-
 Makefile.target      |  4 ++--
 configure            |  9 +++------
 crypto/Makefile.objs | 11 ++++++-----
 5 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 155f066a20..3dbe82a9e4 100644
--- a/Makefile
+++ b/Makefile
@@ -412,7 +412,7 @@ dummy := $(call unnest-vars,, \
                 block-obj-y \
                 block-obj-m \
                 crypto-obj-y \
-                crypto-aes-obj-y \
+                crypto-user-obj-y \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
@@ -486,7 +486,7 @@ subdir-slirp: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
 
 $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) \
-	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
+	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
 
 ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
 # Only keep -O and -g cflags
diff --git a/Makefile.objs b/Makefile.objs
index 2b0793ecc9..dcba4429c8 100644
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
index fdbe7c89f4..4ef4ce5996 100644
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
index 571dd94ee2..54fa78c4dc 100755
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


