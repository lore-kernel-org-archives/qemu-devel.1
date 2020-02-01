Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535C5C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232B6205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gla7s8qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232B6205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyl9-0004FD-AT
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySh-0007es-TO
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySg-0006tZ-RG
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:47 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySg-0006t6-La
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:46 -0500
Received: by mail-pg1-x541.google.com with SMTP id z124so5463965pgb.13
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jMzpsQB0pS3SDomXtbYrmrRRLdb/Rnlv6gkmO2VOo+M=;
 b=Gla7s8qwMa3uLBHCzJuEPEIDR+33F2tawlP55oVkNWuwqdjEjHuLqEPv1K7u2fjNCe
 dpBcc4Dy2plQ1x++hiAW+g1X004gkWQbNyI3FtGxXOihw9n5Mx1wvGUAwKEQxrdwYh1W
 w9+A9871dDMHJh5g9g8hWQygPA8SIiw5gDtldACT9CM3jySKZcV1fQcs/JsAVkBBQUZO
 5lYlJiIyML1/SWgjexpd3FkeosveY3i0nMeK/tl9SDlJf1yV2gTXv9yYlGcfOGzh4FjG
 nmGSyTrZJ7/o6i+gJbM8JUtFuCOqUKVaqz/mfj0pZ+E3z5khu4vEPwWiy+bpm9PRoxuX
 CmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jMzpsQB0pS3SDomXtbYrmrRRLdb/Rnlv6gkmO2VOo+M=;
 b=a+4oSUGFkR8jpNt5SGiKDgSowgB3LWWwfT4pTHuSajie+p2eUBuqGtugq+FWQfwEgl
 haDQjHHSvWU8NmGWW3rgWXF4NlwnuqBHN2VG6lVou1qbXd4iem02mm2TyKwvmNgGVdrW
 Y1Gm6hjbhn5QVIERyGee5D2i1IYYJydjAKNlKNshZQSBqGn9KjH2CON5utizwku15The
 Vd7lSTVmkOLN+aBtCRcvCrpiCJaPSgwntVwaAFH9yPDkvrWRvwWOhbGcbOuvnTAq9rTM
 Ec1eyW/hn7g3d4SrhKljOvrEbQF+L0idaBzI3EH1AYG8FFoMEIpq3+nptUYTu8BzeYrZ
 YSYw==
X-Gm-Message-State: APjAAAVlDkvazGJxKubglBXnphmAdDGSk0dR1KoF+qoQGp7vyiOmpxkt
 qAkhAJ5z0xKhNlH3AUErhMJ7cac+qf8=
X-Google-Smtp-Source: APXvYqyV/GD3Htzc0T4c7ZZz+73G+lpKbPnGjqGeddCKtsMKdVpWd/fohy5IeqoikQqgRktxahxZ2w==
X-Received: by 2002:a63:ce4b:: with SMTP id r11mr17524118pgi.419.1580585385487; 
 Sat, 01 Feb 2020 11:29:45 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 23/41] target/arm: Update aa64_zva_access for EL2
Date: Sat,  1 Feb 2020 11:28:58 -0800
Message-Id: <20200201192916.31796-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The comment that we don't support EL2 is somewhat out of date.
Update to include checks against HCR_EL2.TDZ.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e4f368d96b..e41bece6b5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4159,11 +4159,27 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                       bool isread)
 {
-    /* We don't implement EL2, so the only control on DC ZVA is the
-     * bit in the SCTLR which can prohibit access for EL0.
-     */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_DZE)) {
-        return CP_ACCESS_TRAP;
+    int cur_el = arm_current_el(env);
+
+    if (cur_el < 2) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+
+        if (cur_el == 0) {
+            if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                if (!(env->cp15.sctlr_el[2] & SCTLR_DZE)) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            } else {
+                if (!(env->cp15.sctlr_el[1] & SCTLR_DZE)) {
+                    return CP_ACCESS_TRAP;
+                }
+                if (hcr & HCR_TDZ) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            }
+        } else if (hcr & HCR_TDZ) {
+            return CP_ACCESS_TRAP_EL2;
+        }
     }
     return CP_ACCESS_OK;
 }
-- 
2.20.1


