Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460CFC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1B620717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fRtQOXtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1B620717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihhzZ-0008J1-6b
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 17:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhuE-0001bk-I0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhuD-0003zN-4j
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:58 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihhuC-0003ym-Vo
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:57 -0500
Received: by mail-pg1-x541.google.com with SMTP id 6so2041056pgk.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 14:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Nnco/E+zVxOFsFP+larGarLDAJ4rkyQI0DmqW8gT1oM=;
 b=fRtQOXtLhs0VgWrs+S4Iee2qIsHgt5aAmTMs8RsT+f5CKpf/HpmMgjpDej9XGvcTJB
 3kAMDVjWi6hlqxDp6NKyd2DiI8edfiYi9xYpSnhEQLIwvNepuIixkzhgIQfp2cd8VsaS
 mkslfX6kP56fpCxnyzNW/udiAwAmhla0Mgt+cAQ5fNgdTMastz7hfBP3NHqoxMN045Zk
 +P6xYuvDyWoImrSWwGRSBjxXzYuMze993meqy7JGJJ1ecyDm5rsPccv/ZTn7Z6EJYAJ2
 SMO/JzLGm+cLSfpvBci3kLao0DOug6R1BB9vzpY7PtrQR9fXbb2E/CE8cAYRVLtf558w
 THAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nnco/E+zVxOFsFP+larGarLDAJ4rkyQI0DmqW8gT1oM=;
 b=Z5Mr6j14MMD+iXxPMYaJyp86xcIUgS1PzXGA1vqfdy7aC5Zf9U63xHfPgpWGoePYPQ
 LX/BBwGnNxqUfFEz2rtuC3+hEcHy+9/U4eiah29+48RHkXsmYYWD6lxg1CiGxlPA+6Uo
 cmWuO9pMp+xt9VmlfDQJcTSy+gIGxZtxN23Q3xDYE5EgpvDGBivLtOeijxo9zvoxHx9b
 KXYJB/keo5RU6sodPTX2LUb/mC6JwmK2I/PNwldrlKPT9EQ5GQzdhESAchxYtAQDElql
 QHgboRb8hoGX+Nn9w5LanzT6o/SSXwUu5AEPaRGbEemXA1dUypc4NpBeNUhG9ry+6Ug6
 CHlQ==
X-Gm-Message-State: APjAAAXxuNGvF8/jPV9nFRDR8/McgXrR2wq4Ht9Klq8hWTeu0pdTev+1
 yWvcBPr+LVnDXLS+Sn+f+IZ83qP4Rhc=
X-Google-Smtp-Source: APXvYqwu57euMEZ0CBAVXUohUCUm0MYS99yL+zXBlbq2CpsdyNBLEcXFHgGMhUuURVEBx58jIgSANQ==
X-Received: by 2002:a63:214f:: with SMTP id s15mr5894774pgm.238.1576708495723; 
 Wed, 18 Dec 2019 14:34:55 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id j1sm4627779pff.107.2019.12.18.14.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 14:34:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/7] configure: Support -static-pie if requested
Date: Wed, 18 Dec 2019 12:34:41 -1000
Message-Id: <20191218223441.23852-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218223441.23852-1-richard.henderson@linaro.org>
References: <20191218223441.23852-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: philmd@redhat.com, i@maskray.me, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent toolchains support static and pie at the same time.

As with normal dynamic builds, allow --static to default to PIE
if supported by the toolchain.  Allow --enable/--disable-pie to
override the default.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Fix --disable-pie --static
---
 configure | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index f6ff079fab..55586c5498 100755
--- a/configure
+++ b/configure
@@ -1024,7 +1024,6 @@ for opt do
   ;;
   --static)
     static="yes"
-    LDFLAGS="-static $LDFLAGS"
     QEMU_PKG_CONFIG_FLAGS="--static $QEMU_PKG_CONFIG_FLAGS"
   ;;
   --mandir=*) mandir="$optarg"
@@ -2000,11 +1999,6 @@ if test "$static" = "yes" ; then
   if test "$modules" = "yes" ; then
     error_exit "static and modules are mutually incompatible"
   fi
-  if test "$pie" = "yes" ; then
-    error_exit "static and pie are mutually incompatible"
-  else
-    pie="no"
-  fi
 fi
 
 # Unconditional check for compiler __thread support
@@ -2035,7 +2029,18 @@ if compile_prog "-Werror -fno-pie" "-no-pie"; then
   LDFLAGS_NOPIE="-no-pie"
 fi
 
-if test "$pie" = "no"; then
+if test "$static" = "yes"; then
+  if test "$pie" != "no" && compile_prog "-fPIE -DPIE" "-static-pie"; then
+    QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
+    LDFLAGS="-static-pie $LDFLAGS"
+    pie="yes"
+  elif test "$pie" = "yes"; then
+    error_exit "-static-pie not available due to missing toolchain support"
+  else
+    LDFLAGS="-static $LDFLAGS"
+    pie="no"
+  fi
+elif test "$pie" = "no"; then
   QEMU_CFLAGS="$CFLAGS_NOPIE $QEMU_CFLAGS"
   LDFLAGS="$LDFLAGS_NOPIE $LDFLAGS"
 elif compile_prog "-fPIE -DPIE" "-pie"; then
-- 
2.20.1


