Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E142C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC052071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhfxSc4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC052071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHx7d-0006De-3r
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 18:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx5D-0003JB-Je
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx5C-0000qo-FK
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:07 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHx5C-0000nA-93
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:06 -0400
Received: by mail-pf1-x444.google.com with SMTP id z65so5139767pfz.8
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 15:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mH3MQlQn4EGVflqbnGe+eX+0IVEAf165mtEujy/8ZaU=;
 b=FhfxSc4Ambo3/Jk8hS6nlwoAUA3aFcFDYErO1tIkB698neIN3FSb7O1sjPkXZGHkS8
 M6slEwm50IkEtLS4F0zdyC3+NNijNf5sPFxT2uHCjBt5/4BaBjq3/8FLwBQSUAbQ6XhG
 9fiQ/AC4uEIUFt2w5nvbFJyYwdT06zkk2ua3yE38n5HFD61LScVtn+G6xh8UQLi5c7mQ
 GZDCBHYWyQkDgj1p6g12M5N4cYcoq8uvmzP2ba5STi3ed9Z4IAddcMbsyWaX2qfFwgAR
 AeB3XODOlhrqPfNdL6DW/kbV2k3QRdUvDjl0v+XtOwerfMKTZ1RbKLSzlFqY1YM/P0ER
 7muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mH3MQlQn4EGVflqbnGe+eX+0IVEAf165mtEujy/8ZaU=;
 b=ehFJUQhw8g3Owj7fYu1bldXzV6XspVyATOhRwFGoZQWiQK8he2ebDqAaFKLyTTz8XL
 gxIBpI9grV7EuFSUPQ8xhpLHUeEKdDklk5TaFvDFCV7lQlufDIdaj6ieGDwcoXsyb3Cf
 aVDHL+OAvv7vcnKoAqdtV3HotBxQOakxV4bn7o8KjA71xIwIhEBCPlONUDyDQxf1b/Bk
 IeHJLRZk6fjHSxYQIkLHRo5qh9KCOUBdrDl7U+ghRWzM1O/5cdqbyaJ+FCvkNOrB6K8L
 JIF+2yNxrNtGtXi1QJc3LSH+vQ61+gkOJG98/S4vaC0bclcAPdMiqtHUtjYFOd5zNY3l
 BHkg==
X-Gm-Message-State: ANhLgQ189Wd6lgNLj6ez0NjN1TyVGJKiVBEMxSf0db9h4LSHygU0azvj
 C78IFVv37BYcjFgd/KYq3N63vYqToFI=
X-Google-Smtp-Source: ADFU+vt42ukDlhBH76ag8n+5qZL6OrYHr3VjtA76CSYQgVp5+O1G8nqj5zacLhI+jXgej7/drbbtAA==
X-Received: by 2002:a63:6fc6:: with SMTP id k189mr1396085pgc.175.1585346644986; 
 Fri, 27 Mar 2020 15:04:04 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id y29sm4516929pge.22.2020.03.27.15.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 15:04:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v3 7/7] configure: Support -static-pie if requested
Date: Fri, 27 Mar 2020 15:03:53 -0700
Message-Id: <20200327220353.27233-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327220353.27233-1-richard.henderson@linaro.org>
References: <20200327220353.27233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: dim@FreeBSD.org, alex.bennee@linaro.org, roger.pau@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent toolchains support static and pie at the same time.

As with normal dynamic builds, allow --static to default to PIE
if supported by the toolchain.  Allow --enable/--disable-pie to
override the default.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Fix --disable-pie --static
v3: Update for QEMU_LDFLAGS.
---
 configure | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index b304bd0cf8..a16ae9a2be 100755
--- a/configure
+++ b/configure
@@ -1067,7 +1067,6 @@ for opt do
   ;;
   --static)
     static="yes"
-    QEMU_LDFLAGS="-static $QEMU_LDFLAGS"
     QEMU_PKG_CONFIG_FLAGS="--static $QEMU_PKG_CONFIG_FLAGS"
   ;;
   --mandir=*) mandir="$optarg"
@@ -2089,11 +2088,6 @@ if test "$static" = "yes" ; then
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
@@ -2124,7 +2118,18 @@ if compile_prog "-Werror -fno-pie" "-no-pie"; then
   LDFLAGS_NOPIE="-no-pie"
 fi
 
-if test "$pie" = "no"; then
+if test "$static" = "yes"; then
+  if test "$pie" != "no" && compile_prog "-fPIE -DPIE" "-static-pie"; then
+    QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
+    QEMU_LDFLAGS="-static-pie $QEMU_LDFLAGS"
+    pie="yes"
+  elif test "$pie" = "yes"; then
+    error_exit "-static-pie not available due to missing toolchain support"
+  else
+    QEMU_LDFLAGS="-static $QEMU_LDFLAGS"
+    pie="no"
+  fi
+elif test "$pie" = "no"; then
   QEMU_CFLAGS="$CFLAGS_NOPIE $QEMU_CFLAGS"
   QEMU_LDFLAGS="$LDFLAGS_NOPIE $QEMU_LDFLAGS"
 elif compile_prog "-fPIE -DPIE" "-pie"; then
-- 
2.20.1


