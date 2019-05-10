Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A15C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725AF2182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l/MAxEtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725AF2182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35018 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuJd-0007vC-KT
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:27:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHi-0006Ii-Sb
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHg-00012i-VH
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:14 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHZ-0000tr-E2
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id g9so2244262pfo.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Fwm1k5v3NRHCLn/Bn3EHiCpV8kVUpNoBlaYzJ8dxxt0=;
	b=l/MAxEtbYYxCF6JVXlX9X5JLnFHYh60XhUl//ffcjufrkLID03DBGv1I3gKaXQLLWB
	fetxxcF3LjTfPH1/6i80/BCbURKuCQUZy63lZBof30hnepXQzCZEPSCXHAqmKOrfNlGb
	isA/UQNb47tN5b2Pv92dHMK0h9w6EoWE0UJ7S5CpfgIGG3lMBmjvqPONBdK7jfu9WV/y
	qgHDAPR1RgNzY7Cd2QyT6V6+8TQOo/IwojVW6rYMeN+5NvMXg75v7qLEbQiBo9yn3XeU
	zaMtBpaeA7LHWaR1mK6LG9uk7ug1AcUlk65D9gaReKPReEwi0HCzSRkR7hVTdhjJhMAy
	fzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Fwm1k5v3NRHCLn/Bn3EHiCpV8kVUpNoBlaYzJ8dxxt0=;
	b=kuuDxHa7b/lOlmHEBLln6sM9BUxB8RElkHUdLES2SnzYA7ttn96ky4tgAFF+ciXIKu
	Osm6lhyve8Ga2BWhYaX1y1X687IO9CRcMVG2zc9fj8RsOiC8Peu/wfMnKRh3oJTOwQPj
	klmlVS5DuEXc+LvGvH+RCx+efM9Nld2692c2MtNsh3eIwNEnsLdeBaFYULTSqirRAjIb
	ArTwroHGzJZ9sAz914zsM/JcC9cQitsC9za6OMthka86p77qDtbh3Pu0S3n8cMeL8nEK
	e0JODx1o8riN2pWYAaG4GqUeIYl/9bF+eqcjar5a5n7AlbXugUB+uc6MuNgLioFzdg2E
	N9uw==
X-Gm-Message-State: APjAAAX5tvUX0fIHg4QKhaI/D4JJ37T7eVamrWxzovAkieu8KlVimpif
	05cwhiEEx5kIgwkR3kncy2dcKlEOaH0=
X-Google-Smtp-Source: APXvYqxuW7+44DHkLNDTBuxufYZBzWQZYGN0pFdRm+mscNuz59yYj4gskI0lfDB3u6bu8ysm2qfkmg==
X-Received: by 2002:a63:2b0d:: with SMTP id r13mr10039683pgr.400.1557451502591;
	Thu, 09 May 2019 18:25:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:36 -0700
Message-Id: <20190510012458.22706-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v5 02/24] crypto: Merge crypto-obj-y into
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
into system and tools binaries.  This also means that crypto-aes-obj-y
can be merged back into crypto-obj-y.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile             | 12 +++++-------
 Makefile.objs        |  8 ++------
 Makefile.target      |  4 ----
 configure            |  9 +++------
 crypto/Makefile.objs |  5 +----
 5 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/Makefile b/Makefile
index a971247cac..7c9c208207 100644
--- a/Makefile
+++ b/Makefile
@@ -410,7 +410,6 @@ dummy := $(call unnest-vars,, \
                 block-obj-y \
                 block-obj-m \
                 crypto-obj-y \
-                crypto-aes-obj-y \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
@@ -446,7 +445,6 @@ SOFTMMU_SUBDIR_RULES=$(filter %-softmmu,$(SUBDIR_RULES))
 
 $(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
-$(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
 $(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
 $(SOFTMMU_SUBDIR_RULES): $(edk2-decompressed)
@@ -502,7 +500,7 @@ Makefile: $(version-obj-y)
 ######################################################################
 # Build libraries
 
-libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
+libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y) $(crypto-obj-y)
 libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
 
 ######################################################################
@@ -511,9 +509,9 @@ COMMON_LDADDS = libqemuutil.a
 
 qemu-img.o: qemu-img-cmds.h
 
-qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 
 qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
 
@@ -524,7 +522,7 @@ qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
 
-scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
 endif
diff --git a/Makefile.objs b/Makefile.objs
index cf065de5ed..0ce429c1af 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -3,6 +3,8 @@
 stub-obj-y = stubs/ util/ crypto/
 util-obj-y = util/ qobject/ qapi/
 
+crypto-obj-y = crypto/
+
 chardev-obj-y = chardev/
 
 #######################################################################
@@ -21,12 +23,6 @@ block-obj-$(CONFIG_REPLICATION) += replication.o
 
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
index 256c9aca1f..a291bc5b9a 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -34,8 +34,5 @@ crypto-obj-y += xts.o
 crypto-obj-y += block.o
 crypto-obj-y += block-qcow.o
 crypto-obj-y += block-luks.o
-
-# Let the userspace emulators avoid linking gnutls/etc
-crypto-aes-obj-y = aes.o
-
+crypto-obj-y += aes.o
 stub-obj-y += pbkdf-stub.o
-- 
2.17.1


