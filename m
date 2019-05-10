Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B10BC04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EF3217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jlw2BOZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EF3217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35229 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuXG-0003ic-O0
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:41:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHk-0006Iw-K5
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHj-00014L-6x
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:16 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHj-0000tH-04
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:15 -0400
Received: by mail-pf1-x444.google.com with SMTP id l132so2251967pfc.8
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=5jZKWwQgoaRofSd9MpX36fg/EnNSkz9sJL+VHY1E4dI=;
	b=Jlw2BOZlKaGi4oH9ckPffXjBPBWonfzGjuoLuJCXqBKIfZo1izQxjfnMkEUDtp2eqe
	sNODli5s71TxhSrvKmTWjD1HB08x7h1IrNQkDfmFEQymsvdzubDehDiSiIn++6NptVwU
	CCS/Dz4S+pKOJUDPMhnrBVtiJHNivHUKt908SKDe9rOC7hlvsD4JfFJUillV24psR4zj
	d+AgUynHsDNpamr4I+Mnb0z5h40LeWLosjNr/cr/qUi7EDejRx0wWCArI440gvqlZmK3
	LcxHhRrG992xIZgAvXugzILeT9vbbH50j1dq6mbJLrP/s8vA96nZ2k9ntn/e+QZIVhcQ
	wQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=5jZKWwQgoaRofSd9MpX36fg/EnNSkz9sJL+VHY1E4dI=;
	b=hSu5S39RR+6GU1hECNcpUfuwV6kVRvX9PK0xP7seU2VLLyUlpt9y1FFsAhx4HF1rz4
	pkB53UakX4pGakBIiRgfKJWspX+N2ssk2vKt70NkWk9jdayLSI25s7Irg0akDvyPx0IP
	NVLt04C92UPArKPENqAHyK7oWST179lX3+bmin/SS3AIuBH7GCN+jwmMFVoY9tEUoI8s
	1qGoD5xaY6H9+AxG6J8M+zNtfLXJ38HfYDspXaWuSr5SvZBRFrgy18FcPQS+9mWrsaCc
	NCEj24DcVQuXt/tzyNzdkmOZdQPAnAr1w7lPoRS2Ndi4ixUlFU+Aakh15RMpBuiLVzU5
	zagw==
X-Gm-Message-State: APjAAAUlkEYdBWAyB+/k7+G1rZKKXE6GqoJrNiPTQaH/Meib9E8CuVOn
	H0ScnfJexY71QNJVTmqwvWfkI9I6pAA=
X-Google-Smtp-Source: APXvYqyhmQH8QbpGJVycUlEjGb/NQnnmJVCjjY/iiyANrl8s/KQ/JQ3ku44IgqBYilCTMjWaHy3erQ==
X-Received: by 2002:a63:682:: with SMTP id 124mr10106503pgg.243.1557451501382; 
	Thu, 09 May 2019 18:25:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.00 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:35 -0700
Message-Id: <20190510012458.22706-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v5 01/24] configure: Link test before
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At least ubuntu 18.04 does not package static gnutls libraries.
At least Fedora 30 does not ship static nettle and gcrypt libraries.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v5: Include nettle, gcrypt.
---
 configure | 72 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/configure b/configure
index 63f312bd1f..c4f27ed453 100755
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


