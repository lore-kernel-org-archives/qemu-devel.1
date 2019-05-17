Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B19C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F230E205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pmpj2pAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F230E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40124 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSoJ-0006mD-4Q
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:41:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmR-0005Mg-M5
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmQ-0001xZ-62
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:31 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmP-0001w2-L8
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:30 -0400
Received: by mail-pl1-x642.google.com with SMTP id y3so2604729plp.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=SGUkafzowNhGfO198gJSyccXFDaCJeH5m43hyisADpc=;
	b=Pmpj2pAxM5WczWEg8KtWkhrIds55/JPA7ZsnxUQCX5yCTljybBFBePbvTE4Qt9TzYa
	GlPLaW44l7ESDs9txelHlOvmRImXpC6teecA51/tQEEVAC9d9BXpleBcUcKFFmcJryq5
	IKzagA/RZh62GGlToc5DHlQUdpiFd7SHZ2e+oIlhc7yVB0Jeu3aMrLr3PX6z8KOTUbQ2
	SGKBs8h0BG6wAjGCyGhI0bcXwPHmwJKwXEzXMJMhothTVPIbm+0aiflPKmljbkdSydLq
	VcJX76lhdOgmIR8d2JaD3zRlXermRBzpiD8wPGHFeWtXa3sZczDVZb/EEOOtfMsDss5i
	/cYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=SGUkafzowNhGfO198gJSyccXFDaCJeH5m43hyisADpc=;
	b=f63azmVYQbsO8N4ptP/21MY6UhExId1EnyHCpYZ7KhnQjKGApBNQzUnsaxxxmS/pXr
	EDRnVE7N8gtPHWsGlg+UqvLuuHJ+KqmUebzfU2FyiQWuBVcywJxoh9OKF+g79twvbq5S
	ieMIr5ylVycJ43McFmZNHik3FuJa/m+ROgenBOGG6lgx+s4SXaW82PkJ0nFTghZgK4yD
	1uSnV0fBoNtV3cSK6VRxXkdeSFgvNd13q0JPbEVqah+PP4Q7hKPOGfxK+ncy0wHet8K0
	I2hFdEyWBuSJNCTdsXPJhm0oi3ZPaRBRz8xXE2un76PoyCqDTU7ZmZlC8iGyBFFa3W1S
	SZ+g==
X-Gm-Message-State: APjAAAW3ogYvbxRF8fGfhicuW4nXwPrP/dOTVZL9onJnDFfuu/k5+d2Q
	atAAOrCNo74yVOSuD9da/YGDSNqBACI=
X-Google-Smtp-Source: APXvYqzP7rMm9/kUhfkfUPsKbsNF+CLHj+FhTr8DlNfOc0KNw+YMCUEk5fPPQTxAa+f5HNHHSlsxjw==
X-Received: by 2002:a17:902:24e:: with SMTP id
	72mr7945996plc.168.1558060768225; 
	Thu, 16 May 2019 19:39:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:00 -0700
Message-Id: <20190517023924.1686-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v8 01/25] configure: Link test before
 auto-enabling crypto libraries
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

At least ubuntu 18.04 does not package static gnutls libraries.
At least Fedora 30 does not ship static nettle and gcrypt libraries.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Tested-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20190510012458.22706-2-richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 72 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/configure b/configure
index 8999698bc2..f8345368bf 100755
--- a/configure
+++ b/configure
@@ -2784,17 +2784,24 @@ fi
 # GNUTLS probe
 
 if test "$gnutls" != "no"; then
+    pass="no"
     if $pkg_config --exists "gnutls >= 3.1.18"; then
         gnutls_cflags=$($pkg_config --cflags gnutls)
         gnutls_libs=$($pkg_config --libs gnutls)
-        libs_softmmu="$gnutls_libs $libs_softmmu"
-        libs_tools="$gnutls_libs $libs_tools"
-	QEMU_CFLAGS="$QEMU_CFLAGS $gnutls_cflags"
-        gnutls="yes"
-    elif test "$gnutls" = "yes"; then
+        # Packaging for the static libraries is not always correct.
+        # At least ubuntu 18.04 ships only shared libraries.
+        write_c_skeleton
+        if compile_prog "" "$gnutls_libs" ; then
+            libs_softmmu="$gnutls_libs $libs_softmmu"
+            libs_tools="$gnutls_libs $libs_tools"
+            QEMU_CFLAGS="$QEMU_CFLAGS $gnutls_cflags"
+            pass="yes"
+        fi
+    fi
+    if test "$pass" = "no" && test "$gnutls" = "yes"; then
 	feature_not_found "gnutls" "Install gnutls devel >= 3.1.18"
     else
-        gnutls="no"
+        gnutls="$pass"
     fi
 fi
 
@@ -2849,43 +2856,54 @@ has_libgcrypt() {
 
 
 if test "$nettle" != "no"; then
+    pass="no"
     if $pkg_config --exists "nettle >= 2.7.1"; then
         nettle_cflags=$($pkg_config --cflags nettle)
         nettle_libs=$($pkg_config --libs nettle)
         nettle_version=$($pkg_config --modversion nettle)
-        libs_softmmu="$nettle_libs $libs_softmmu"
-        libs_tools="$nettle_libs $libs_tools"
-        QEMU_CFLAGS="$QEMU_CFLAGS $nettle_cflags"
-        nettle="yes"
-
-        if test -z "$gcrypt"; then
-           gcrypt="no"
+        # Link test to make sure the given libraries work (e.g for static).
+        write_c_skeleton
+        if compile_prog "" "$nettle_libs" ; then
+            libs_softmmu="$nettle_libs $libs_softmmu"
+            libs_tools="$nettle_libs $libs_tools"
+            QEMU_CFLAGS="$QEMU_CFLAGS $nettle_cflags"
+            if test -z "$gcrypt"; then
+               gcrypt="no"
+            fi
+            pass="yes"
         fi
+    fi
+    if test "$pass" = "no" && test "$nettle" = "yes"; then
+        feature_not_found "nettle" "Install nettle devel >= 2.7.1"
     else
-        if test "$nettle" = "yes"; then
-            feature_not_found "nettle" "Install nettle devel >= 2.7.1"
-        else
-            nettle="no"
-        fi
+        nettle="$pass"
     fi
 fi
 
 if test "$gcrypt" != "no"; then
+    pass="no"
     if has_libgcrypt; then
         gcrypt_cflags=$(libgcrypt-config --cflags)
         gcrypt_libs=$(libgcrypt-config --libs)
-        # Debian has remove -lgpg-error from libgcrypt-config
+        # Debian has removed -lgpg-error from libgcrypt-config
         # as it "spreads unnecessary dependencies" which in
         # turn breaks static builds...
         if test "$static" = "yes"
         then
             gcrypt_libs="$gcrypt_libs -lgpg-error"
         fi
-        libs_softmmu="$gcrypt_libs $libs_softmmu"
-        libs_tools="$gcrypt_libs $libs_tools"
-        QEMU_CFLAGS="$QEMU_CFLAGS $gcrypt_cflags"
-        gcrypt="yes"
 
+        # Link test to make sure the given libraries work (e.g for static).
+        write_c_skeleton
+        if compile_prog "" "$gcrypt_libs" ; then
+            libs_softmmu="$gcrypt_libs $libs_softmmu"
+            libs_tools="$gcrypt_libs $libs_tools"
+            QEMU_CFLAGS="$QEMU_CFLAGS $gcrypt_cflags"
+            pass="yes"
+        fi
+    fi
+    if test "$pass" = "yes"; then
+        gcrypt="yes"
         cat > $TMPC << EOF
 #include <gcrypt.h>
 int main(void) {
@@ -2898,12 +2916,10 @@ EOF
         if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then
             gcrypt_hmac=yes
         fi
+    elif test "$gcrypt" = "yes"; then
+        feature_not_found "gcrypt" "Install gcrypt devel >= 1.5.0"
     else
-        if test "$gcrypt" = "yes"; then
-            feature_not_found "gcrypt" "Install gcrypt devel >= 1.5.0"
-        else
-            gcrypt="no"
-        fi
+        gcrypt="no"
     fi
 fi
 
-- 
2.17.1


