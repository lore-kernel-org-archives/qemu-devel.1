Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE10C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66982217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xv1QtOJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66982217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47492 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9OU-0000L8-Hx
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:33:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MF-0007IC-Ci
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9ME-0005y4-3Y
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:55 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MD-0005xX-Tu
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:54 -0400
Received: by mail-pl1-x642.google.com with SMTP id x15so3127194pln.9
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=p3cfnV5JbT6H/nwjKGY4Kezh5D3MhbPkpcQaspyBazo=;
	b=Xv1QtOJyGKmPVc5wOfKNqKuFiKfEoYGPwYdml96HohiJdk/ZKN2BjqJn2iT3b52BYg
	jADBwofGV5ksLI6TP4E1x1osCpftbDAX7ld9yK2znpfGwI+nvoXJm56iMcezni1w4zJE
	SFhtsHob0ooKXnH2uR5p0vb1G/NhtOXgk8WW044lvQOyRvQDdrsz65heiQIf2nHpKhD3
	tPKfzQZdRs6PBiPHb/755Pn5GGw9Mt1zVv/eYrgw+jTBnjw7I10U5M+xIc0X5ItoCMET
	h8H62b0S2Z1D5QdqMCfxdbZEZhvPqzeA92urnqUmBxLI7JbDJbRnkUXLIwOfmFyWbTf7
	CzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=p3cfnV5JbT6H/nwjKGY4Kezh5D3MhbPkpcQaspyBazo=;
	b=bvbMwOn9ZQHIak3ZEmsrTBkdnD2kQp/FtCBcmW7JfKAD8YQmixvwyNuReUsG1KXfWL
	hifDG73xXeRksOXlZwBgpsWem2YNFnTDA38nk8Bwd2HURGz1eOdlQJI3uvDsPx1nFWm2
	EhPDZzB4Eul+bAdeFG2BJqS7fd1j5WQAG0KBFquen34VfzVKzuPNwgr11+YHUpshbR3W
	eCwm9PU8o2f5tqLwl1SgQlAx5jPRtR8WAqK/mX5YqEExZKknugvSnBj3HZS74ljTrsAy
	mx11ZzOzk5TjoWfH8cL/jQ8lsiubHsKP00Wj9mqH5kHOgmNU+U0ptutj7j0pjHUXcS5h
	oZRw==
X-Gm-Message-State: APjAAAVFNK79vo9+ahMuX7m5f+l26fiUPVAQDsTRYGftciYA3B5vJ9lJ
	SPKp+T0+bZ5UV90+W1MmcE8nkK2Ufh0=
X-Google-Smtp-Source: APXvYqxTle9LPl167Ulwvb+qVEJxdh+zzfKwzOJoX+rSmbg/kXuC3A08qSrRUo4O5pifru1GEh6IGg==
X-Received: by 2002:a17:902:263:: with SMTP id
	90mr14917245plc.257.1557509452590; 
	Fri, 10 May 2019 10:30:52 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.30.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:30:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:25 -0700
Message-Id: <20190510173049.28171-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v6 01/25] configure: Link test before
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

Tested-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


