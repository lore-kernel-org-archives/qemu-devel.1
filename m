Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F40C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1BE206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYa5PPQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1BE206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWtS-0002ps-MC
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:27:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOt-0008Eq-7n
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWC6-00080U-97
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:31 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:43108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWC6-00080L-43
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:30 -0400
Received: by mail-yw1-xc41.google.com with SMTP id t5so1232445ywf.10
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=9dAwC0S3G/OFyRgp8E8i1RIZB4naA10HcRt0yDU2T20=;
	b=LYa5PPQMjqAQwlc9/adtwJJpve/N0/a8ZNAdtgKWrLFDagkdPwQrMxI6hY75aCkaaF
	z0HOpjZ9c1HQ+L6TXYfyGmJJi407J7R1pxpQ69mp0oL9Nl4urdzgsaKq5PnQ81BY9t+b
	x14XEvjY5L9YpUTd68XgawcXCwAWH8UQrlbNPIWcHiRVqCKetMmA/c4KC4Dw1P8xJxUn
	idGd4oPoWmdV0tncwe5lRICjyFkKSywsPZdtOyJt2JAp1gZbV6srbJgBNrCgymoTiY4K
	Kdm8CBp1ptBEgCRQ8CSr5oLLEAWONlNs6ZseTDWZwl/PnH+aAH7aTbN/voW5nG4BvwEu
	4G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=9dAwC0S3G/OFyRgp8E8i1RIZB4naA10HcRt0yDU2T20=;
	b=Al8MvI7nJcmNMDkLU5teuD2qM4nsJVG0YLGw9b+M4ksr1FjCdWDcN5R8QWyJFMzb0J
	9rUd7kjfJlUCRWkkw2ytlHgacytrirJq2ywIIF+ACZeO4OENJdSbiD+p2Krgywp3fN6+
	SGos9WWjRvO5CdB1T2/ybPdCqCCDfCHZbqxi87t99dTUiLJcBl1ZZFiP5+P1OnwMxGmE
	xKKSluztghZvTIGYGj+T/tR7xIBmP3hXffvAgQIUg2rhOgX1OnXRp+HSKijiO0f+nyB9
	PopnAs/I0DBR/LZFF69/jCbCrYW/xW2w2U7AwXK2CA9qKkq8DAC9PzHa8PDKLT6SduK1
	DNpA==
X-Gm-Message-State: APjAAAWWtBKOZcuuwS/VjvXrcG/WKNSXqacuQkt2E3wVtqHYFlEKOTom
	M7uWFB+7/41IJ398zzy6On+OD6jeCBI=
X-Google-Smtp-Source: APXvYqz9VjPXzuNCnHARFaSV36tXY9E9tSU6yPyjYjUW9o2Aeq/cmQuRC47ovZ49Ku0+6PkstO0itg==
X-Received: by 2002:a81:8606:: with SMTP id w6mr41845008ywf.344.1558550549179; 
	Wed, 22 May 2019 11:42:29 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:02 -0400
Message-Id: <20190522184226.17871-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [PULL 01/25] configure: Link test before auto-enabling
 crypto libraries
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
index d2fc346302..571dd94ee2 100755
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


