Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E77FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E6E2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZt6qDGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E6E2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ80a-0006fq-EO
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 23:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zb-0004lp-Mp
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7za-0008GY-GE
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:11 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:34967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJ7za-0008GE-9p
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:10 -0400
Received: by mail-pj1-x102a.google.com with SMTP id g9so520988pjp.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 20:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UgUHjWUCMpFSJAz+Az/IeJleYSOaGK+TNCsM8YWgUmI=;
 b=IZt6qDGz2zABDbH/Cvh2zniiofyquCkU6n66Y8Jz8qQPrbWBFUDwwXjhRZGmJUEOPk
 xB89NLsO9HkksXtD0CF2tMRny6VOV6K0HVv5c8BksAFG4e8MYdD5g44oOT70fm1aFihK
 NThfwPKm0JwnHffLsKFij8+vy11l3xRhVBLiE9QmH3ooExsbvKWCpSHk39p3j9fgERcg
 hp3D/Y62lp6u6CzBtNEiab8a0c4gRMM+D7RxogJxVKs9hUzn12Nxd1NMktTiX2dZHz+y
 n263VDZHHjlg28Sfz+3/D5EWotkbcgQAuiODxbjqEN4sNbU3xSLawWd52lVAfcLP40J0
 yrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UgUHjWUCMpFSJAz+Az/IeJleYSOaGK+TNCsM8YWgUmI=;
 b=NX3YFA8iLijtPwirSoq4XpRFq01uSMnvxQ/s2M5rJJhf9vJTnKbj95Y3GbIalSm0Nh
 fJkENjygO0d36nOTrLoXdf+fMzBKGd1LCc0hGmoUlMLaUn09TA9iSb1NwD3TNO2kAMYY
 AHiCiq9FogDObTEMyHLxt7jEgkyuIg2WCA1gmusLknstW5rliG8rgaudz4FOeREj4ft2
 4XHzc+vw4BV2LuQpTGN+FOAdo85x4Ft4Anq4OzYElF+KABbqJ9Roe+mblLdp+jovnXF+
 nVKji9ce6XbLcItsyGtm1MNVyRXUnQGOmdimSSfR56k8DE1hicfi3Bw71c50av5mYVNK
 Si3Q==
X-Gm-Message-State: AGi0Puan8TgK/Tqoi7TZiAHvTbNGhuKWdWHwMeO0aF2Oc8gDIgQKBEYH
 Tpnv1NbJ66jV5GEfo+8OUgsDHaqrt6U=
X-Google-Smtp-Source: APiQypK9AFq2jONhp5MRi7Ps+AYvCDTM1tcIXtytTndwN+V49XPyTcjFKJsiQn7ELNRfrYoEmYj8hg==
X-Received: by 2002:a17:90b:1b05:: with SMTP id
 nu5mr1557197pjb.110.1585626908932; 
 Mon, 30 Mar 2020 20:55:08 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h11sm11386174pfq.56.2020.03.30.20.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 20:55:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 07/10] configure: Support -static-pie if requested
Date: Mon, 30 Mar 2020 20:54:53 -0700
Message-Id: <20200331035456.6494-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331035456.6494-1-richard.henderson@linaro.org>
References: <20200331035456.6494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102a
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
index 481d5077f7..22870f3867 100755
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


