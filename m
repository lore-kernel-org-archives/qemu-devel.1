Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC772C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 665C6217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ra9jDxTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665C6217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47546 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9Re-0003Yf-Hs
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:36:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MH-0007Ie-Ck
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MF-0005z5-MM
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:57 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MF-0005yQ-EL
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:55 -0400
Received: by mail-pg1-x543.google.com with SMTP id e6so3334537pgc.4
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=oNLcNEzx1AVg7pEqaHg2NYbCmOShRlwabHt9Wio1gps=;
	b=ra9jDxTLNuYDLE4J3yl9KdiHEBJGrDx7pjW0tLlJVVdcBLy5LZBEkAYeOSLF2wjnVy
	Y8kolHTu5n4okpuUwx/w1MflqCDGZi1xDb0LLba4RR62uygPHcFux/v974VByjgo+dgF
	IBwOlD8yTbr6EzaswuoxJOvSdu042Wir78Yn/s8jjo4QLhgT5sAofakRL6gNzKgSMEFM
	x7sknDvhDZgF06XQaEwtplmMW4VLe+0HGTHtcZ2P6YFTDu2mat08+ivsO1bCr8fi1LAg
	TP3jTvxST8GWGWqL/he32neiI5T6Ep1/HhnxDba9lPSFWJ1381Jl13NL2ZQ4YZlFt5qu
	RZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=oNLcNEzx1AVg7pEqaHg2NYbCmOShRlwabHt9Wio1gps=;
	b=J1XxxaZEogGN0rHcEJVv2wKSyDH7y4mvegO8wUVtwFjJHeDfOwUnjiAXVRd7oMDufd
	M+t3zZmVx1V1tl9uTKjhVf7VXlDfd8pRDkWTbh1/aXOxMN+lHK7j0YQb3EuGgGC7FIzD
	0Ua1qco7WgCjevZMa29WjMdfAURLTbuSF0EwnEiKeDVbE6kyDxRoqQlPBXcxPrEonWSP
	a23EIDpJv7FeszOSZfHXUnVbbDjdp9Qa227fdsrOF7q/6xe4Y6vQk+epeXX64s57o/+f
	fRd81gPQpXMFLaqw/3d4E5BG35+FHF4GfP96JUmosH+cyelM7KTc8H29j+fA7eRjWsXn
	NagQ==
X-Gm-Message-State: APjAAAUReWeXks2XCWPe+a8ayUrzvL/ItJ5MDRAYXv8PdpEaCxR0kuYk
	cv1cs70RB4AwzIzixIPqB19Kwzb5Stk=
X-Google-Smtp-Source: APXvYqxtiRCxaDnBdWjPoVGilxVzq6JeJnZgKCPrjWqD5nWFx+1i/0xi7C1ktF6CJN9VQOxYg4rzkg==
X-Received: by 2002:a65:448b:: with SMTP id l11mr15097201pgq.185.1557509453909;
	Fri, 10 May 2019 10:30:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.30.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:30:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:26 -0700
Message-Id: <20190510173049.28171-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v6 02/25] crypto: Merge crypto-obj-y into
 libqemuutil.a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will shortly need this in the user-only binaries, so drop the split
into system and tools binaries.  Remove crypto-obj-y and crypto-aes-obj-y,
moving the objects into util-obj-y.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Remove a stray crypto-aes-obj-$(COND) -- (lvivier)
    Remove crypto-obj-y entirely -- (berrange)
---
 Makefile               | 14 +++-----
 Makefile.objs          |  8 +----
 Makefile.target        |  4 ---
 configure              |  9 ++---
 crypto/Makefile.objs   | 77 ++++++++++++++++++++----------------------
 tests/Makefile.include |  3 +-
 6 files changed, 47 insertions(+), 68 deletions(-)

diff --git a/Makefile b/Makefile
index 4a8ae0ef95..acf13f5eaa 100644
--- a/Makefile
+++ b/Makefile
@@ -409,8 +409,6 @@ dummy := $(call unnest-vars,, \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
-                crypto-obj-y \
-                crypto-aes-obj-y \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
@@ -446,7 +444,6 @@ SOFTMMU_SUBDIR_RULES=$(filter %-softmmu,$(SUBDIR_RULES))
 
 $(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
-$(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
 $(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
 $(SOFTMMU_SUBDIR_RULES): $(edk2-decompressed)
@@ -482,8 +479,7 @@ subdir-capstone: .git-submodule-status
 subdir-slirp: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
 
-$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
-	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
+$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) $(qom-obj-y)
 
 ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
 # Only keep -O and -g cflags
@@ -511,9 +507,9 @@ COMMON_LDADDS = libqemuutil.a
 
 qemu-img.o: qemu-img-cmds.h
 
-qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 
 qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
 
@@ -524,7 +520,7 @@ qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
 
-scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
 endif
diff --git a/Makefile.objs b/Makefile.objs
index cf065de5ed..4875b6f2e5 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,7 +1,7 @@
 #######################################################################
 # Common libraries for tools and emulators
 stub-obj-y = stubs/ util/ crypto/
-util-obj-y = util/ qobject/ qapi/
+util-obj-y = util/ crypto/ qobject/ qapi/
 
 chardev-obj-y = chardev/
 
@@ -21,12 +21,6 @@ block-obj-$(CONFIG_REPLICATION) += replication.o
 
 block-obj-m = block/
 
-#######################################################################
-# crypto-obj-y is code used by both qemu system emulation and qemu-img
-
-crypto-obj-y = crypto/
-crypto-aes-obj-y = crypto/
-
 #######################################################################
 # qom-obj-y is code used by both qemu system emulation and qemu-img
 
diff --git a/Makefile.target b/Makefile.target
index ae02495951..ce02924ffb 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -179,8 +179,6 @@ dummy := $(call unnest-vars,.., \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
-               crypto-obj-y \
-               crypto-aes-obj-y \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
@@ -189,8 +187,6 @@ all-obj-y += $(common-obj-y)
 all-obj-y += $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(block-obj-y) $(chardev-obj-y)
-all-obj-$(CONFIG_USER_ONLY) += $(crypto-aes-obj-y)
-all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 
 ifdef CONFIG_SOFTMMU
diff --git a/configure b/configure
index c4f27ed453..68b34a93eb 100755
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
index 256c9aca1f..8fafffb048 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -1,41 +1,38 @@
-crypto-obj-y = init.o
-crypto-obj-y += hash.o
-crypto-obj-$(CONFIG_NETTLE) += hash-nettle.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += hash-gcrypt.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT),n,y)) += hash-glib.o
-crypto-obj-y += hmac.o
-crypto-obj-$(CONFIG_NETTLE) += hmac-nettle.o
-crypto-obj-$(CONFIG_GCRYPT_HMAC) += hmac-gcrypt.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT_HMAC),n,y)) += hmac-glib.o
-crypto-obj-y += aes.o
-crypto-obj-y += desrfb.o
-crypto-obj-y += cipher.o
-crypto-obj-$(CONFIG_AF_ALG) += afalg.o
-crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
-crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
-crypto-obj-y += tlscreds.o
-crypto-obj-y += tlscredsanon.o
-crypto-obj-y += tlscredspsk.o
-crypto-obj-y += tlscredsx509.o
-crypto-obj-y += tlssession.o
-crypto-obj-y += secret.o
-crypto-obj-$(CONFIG_GCRYPT) += random-gcrypt.o
-crypto-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) += random-gnutls.o
-crypto-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) += random-platform.o
-crypto-obj-y += pbkdf.o
-crypto-obj-$(CONFIG_NETTLE) += pbkdf-nettle.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += pbkdf-gcrypt.o
-crypto-obj-y += ivgen.o
-crypto-obj-y += ivgen-essiv.o
-crypto-obj-y += ivgen-plain.o
-crypto-obj-y += ivgen-plain64.o
-crypto-obj-y += afsplit.o
-crypto-obj-y += xts.o
-crypto-obj-y += block.o
-crypto-obj-y += block-qcow.o
-crypto-obj-y += block-luks.o
-
-# Let the userspace emulators avoid linking gnutls/etc
-crypto-aes-obj-y = aes.o
-
+util-obj-y = init.o
+util-obj-y += hash.o
+util-obj-$(CONFIG_NETTLE) += hash-nettle.o
+util-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += hash-gcrypt.o
+util-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT),n,y)) += hash-glib.o
+util-obj-y += hmac.o
+util-obj-$(CONFIG_NETTLE) += hmac-nettle.o
+util-obj-$(CONFIG_GCRYPT_HMAC) += hmac-gcrypt.o
+util-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT_HMAC),n,y)) += hmac-glib.o
+util-obj-y += aes.o
+util-obj-y += desrfb.o
+util-obj-y += cipher.o
+util-obj-$(CONFIG_AF_ALG) += afalg.o
+util-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
+util-obj-$(CONFIG_AF_ALG) += hash-afalg.o
+util-obj-y += tlscreds.o
+util-obj-y += tlscredsanon.o
+util-obj-y += tlscredspsk.o
+util-obj-y += tlscredsx509.o
+util-obj-y += tlssession.o
+util-obj-y += secret.o
+util-obj-$(CONFIG_GCRYPT) += random-gcrypt.o
+util-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) += random-gnutls.o
+util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) += random-platform.o
+util-obj-y += pbkdf.o
+util-obj-$(CONFIG_NETTLE) += pbkdf-nettle.o
+util-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += pbkdf-gcrypt.o
+util-obj-y += ivgen.o
+util-obj-y += ivgen-essiv.o
+util-obj-y += ivgen-plain.o
+util-obj-y += ivgen-plain64.o
+util-obj-y += afsplit.o
+util-obj-y += xts.o
+util-obj-y += block.o
+util-obj-y += block-qcow.o
+util-obj-y += block-luks.o
+util-obj-y += aes.o
 stub-obj-y += pbkdf-stub.o
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 60de085ee1..96bf071992 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -496,8 +496,7 @@ test-qapi-obj-y = tests/test-qapi-types.o \
 	tests/test-qapi-visit-sub-sub-module.o \
 	tests/test-qapi-introspect.o \
 	$(test-qom-obj-y)
-benchmark-crypto-obj-y = $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj-y)
-test-crypto-obj-y = $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj-y)
+test-crypto-obj-y = $(authz-obj-y) $(test-qom-obj-y)
 test-io-obj-y = $(io-obj-y) $(test-crypto-obj-y)
 test-authz-obj-y = $(test-qom-obj-y) $(authz-obj-y)
 test-block-obj-y = $(block-obj-y) $(test-io-obj-y) tests/iothread.o
-- 
2.17.1


