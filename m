Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12E2C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBDA2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/arva38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBDA2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sOI-0008EF-Bf
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnP-0004XH-KA
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnM-0006xs-R4
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:03 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rnM-0006x4-GW
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id l3so16350688wru.7
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hdx0vcwYVj6aCkAtZySo243cmoqBWwiTTxoZ3UM3eNY=;
 b=m/arva38FITJPOTEd1+Ic3jYq1nQfefJevnvJ7dNKScoegz3YqC+yK6HDG3Hb7Rkzd
 /p0wze2EK1k6elFu/ew9w0GXAaBEA+YdTzTXg05U0wTsydna2EOyPz6VMJ2vFAmF5MFH
 jhyn7IWbxdx612/OOsBZCANrqJap4LuWC9kToVh6pCE8VNRteVhltskRmVtg3C2+v4Ew
 FUQTbX1qU9LfbJ3y3GlKDMdJwf94PSlnWR3ZhknCNYEQ5XgdhivG3DyKCJgK1lvCzn1q
 np5RSAiaHKJQB1soTq2KiziL+tw1r7I9porHGbACM2o3aRIDcd4aobe6BeCWY3LL3XsA
 hoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hdx0vcwYVj6aCkAtZySo243cmoqBWwiTTxoZ3UM3eNY=;
 b=ahcHyefHYcal53WZJBMHAaKfc9OTKTtt2M0QtmKdcT0RWftbp04Jwse6/gDC8+d0Mb
 xubZJG8s0SdvhM/r65A3eIgJWoJBj4dC1RGK4/ah2bZwzkk9zisQvIg+0GEftJ8huGsz
 rmsrRrDZOOk57h3jTncYu9E8GWofr+4EGNnzCAlQPO0RWyHIPRt767eYR0ibfcGznMX1
 3aEB7t/yTBC/F69FEQWNE39/j8sPc2OgBghSUsGkNcORJkl9qYF96ps72/xH8u3kxKuQ
 uf6GOV5fS1KDdzq8p9syL1bcx2QrEaNrb/p/92NmPYQOgWKowHfZXcP2/3m57LLkeI9a
 xgNA==
X-Gm-Message-State: APjAAAU0qZ+98zi/BybcsVzxsRQbrGCDqJ2ZYITC5Ewwo7hNJ9wWmg3J
 JQrCl9uRg9gjUTKbIzNPd18/4oTYkcFzPw==
X-Google-Smtp-Source: APXvYqw0kAdbnSQ+zqyxmG6qprWn237V2XIS7sgBpQvKszHmllWC7b/8Ye3aMUYQ7a3zo8Lmx+g0xA==
X-Received: by 2002:a5d:548d:: with SMTP id h13mr12544924wrv.215.1568643359201; 
 Mon, 16 Sep 2019 07:15:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s9sm15185884wme.36.2019.09.16.07.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 07:15:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:15:39 +0100
Message-Id: <20190916141544.17540-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916141544.17540-1-peter.maydell@linaro.org>
References: <20190916141544.17540-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2 10/15] target/arm/arm-semi: Factor out
 implementation of SYS_ISTTY
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Factor out the implementation of SYS_ISTTY via the new function
tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 958083a105c..ecd51338fd3 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -388,6 +388,7 @@ typedef uint32_t sys_writefn(ARMCPU *cpu, GuestFD *gf,
                              target_ulong buf, uint32_t len);
 typedef uint32_t sys_readfn(ARMCPU *cpu, GuestFD *gf,
                             target_ulong buf, uint32_t len);
+typedef uint32_t sys_isattyfn(ARMCPU *cpu, GuestFD *gf);
 
 static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
 {
@@ -436,6 +437,11 @@ static uint32_t host_readfn(ARMCPU *cpu, GuestFD *gf,
     return len - ret;
 }
 
+static uint32_t host_isattyfn(ARMCPU *cpu, GuestFD *gf)
+{
+    return isatty(gf->hostfd);
+}
+
 static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
 {
     return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
@@ -457,10 +463,16 @@ static uint32_t gdb_readfn(ARMCPU *cpu, GuestFD *gf,
                            gf->hostfd, buf, len);
 }
 
+static uint32_t gdb_isattyfn(ARMCPU *cpu, GuestFD *gf)
+{
+    return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", gf->hostfd);
+}
+
 typedef struct GuestFDFunctions {
     sys_closefn *closefn;
     sys_writefn *writefn;
     sys_readfn *readfn;
+    sys_isattyfn *isattyfn;
 } GuestFDFunctions;
 
 static const GuestFDFunctions guestfd_fns[] = {
@@ -468,11 +480,13 @@ static const GuestFDFunctions guestfd_fns[] = {
         .closefn = host_closefn,
         .writefn = host_writefn,
         .readfn = host_readfn,
+        .isattyfn = host_isattyfn,
     },
     [GuestFDGDB] = {
         .closefn = gdb_closefn,
         .writefn = gdb_writefn,
         .readfn = gdb_readfn,
+        .isattyfn = gdb_isattyfn,
     },
 };
 
@@ -631,11 +645,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(env, -1);
         }
 
-        if (use_gdb_syscalls()) {
-            return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", gf->hostfd);
-        } else {
-            return isatty(gf->hostfd);
-        }
+        return guestfd_fns[gf->type].isattyfn(cpu, gf);
     case TARGET_SYS_SEEK:
         GET_ARG(0);
         GET_ARG(1);
-- 
2.20.1


