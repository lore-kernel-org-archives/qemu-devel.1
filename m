Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C598C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B02820659
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZBRaFRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B02820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvQZ-0003je-Bu
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60816)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMi-0004Kn-Rh
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMh-0003Py-Pe
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:28 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMh-0003Of-KQ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:27 -0400
Received: by mail-pf1-x442.google.com with SMTP id u14so32533404pfn.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eXztB5+CPZYWvtJqCXCkkbobp/U8zAPLQueishTnE64=;
 b=YZBRaFRDeE/C9WJ9U7ACwGnFPRCpOoJFuqnM2lVJHxJ0dLtO/g5G9LOwwLdcIbIcVq
 V0rn35vxniVdiuN2orhSR+g/A51rIlfJQxrH2C+F0ec487jADOIrW8coX6bWTtSwK5A9
 JJzFNRq1UfvEegm/Dsv/AB5WGHpwQb/anWBWBftgcNJqUOYjg5kZgCwxiXNG5aHQEqfq
 Pnd1W3VvS8+EwAkWdnsou3RCh9ARY3I/9XC92W8nltPmIvsz40pIu9Vr6cWtbRVdQDiu
 NzPpstQyYFlYi/xNxdXVpKyvlHir50JZGov4d7SJDjjmCb3giNYSQ79sxQBinKPqQ+H2
 brqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eXztB5+CPZYWvtJqCXCkkbobp/U8zAPLQueishTnE64=;
 b=XtOwnYS5ixCWQFiQzUt6ki+BsVog1lu0TtG4CT1WUsoPX1ysrf/ENKKK2X+YdrnqhG
 GWU9F/fGh370B9FgyNLPrkoL0RQWgfupPaf275irMYYuBVjSZb4bGrIRr08SZXPItQ89
 oTTRKAjDW5YKD1yHvlEnBO01Gow9Ryfa4PWa5wOQ7IHfVNflQ9DjsR6wiPuKFmQSRINd
 cr0SpoDiJaI9TG3Xkf6v1OEKb8FJLij+g9o487ZiMLr8HgXsCC6qkITL0lWS6R+RIWxM
 toCsPvTjGskva+bJYwnuAXKohaYk+4ZGF5rNkmFnypaKJKw0tVSvv2k4F2bLdtTSs65N
 Crpg==
X-Gm-Message-State: APjAAAU3LofUTmTZqxa3KSxquXvC+bugqkwtDD9FYFYut7ZFkgh1F304
 VxPGbxHxpF36oDbqbksltBizcc+/L5c=
X-Google-Smtp-Source: APXvYqydtT5ieHPuIhGsR9m+t2LPyIs+SxOF/gV8J0m2blMmbEMchISfMm4lgQHzmpzAPb0gxwebcQ==
X-Received: by 2002:a17:90a:3086:: with SMTP id
 h6mr4877113pjb.14.1564605506348; 
 Wed, 31 Jul 2019 13:38:26 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:37:50 -0700
Message-Id: <20190731203813.30765-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v2 09/32] target/arm: Add TTBR1_EL2
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the same time, add writefn to TTBR0_EL2 and TCR_EL2.
A later patch will update any ASID therein.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8baeb3f319..8d8b3cc40e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3449,6 +3449,12 @@ static void vmsa_ttbr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    raw_write(env, ri, value);
+}
+
 static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
@@ -4844,10 +4850,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .resetvalue = 0 },
     { .name = "TCR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 2,
-      .access = PL2_RW,
-      /* no .writefn needed as this can't cause an ASID change;
-       * no .raw_writefn or .resetfn needed as we never use mask/base_mask
-       */
+      .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
+      /* no .raw_writefn or .resetfn needed as we never use mask/base_mask */
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[2]) },
     { .name = "VTCR", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
@@ -4881,7 +4885,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.tpidr_el[2]) },
     { .name = "TTBR0_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL2_RW, .resetvalue = 0,
+      .access = PL2_RW, .resetvalue = 0, .writefn = vmsa_tcr_ttbr_el2_write,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
     { .name = "HTTBR", .cp = 15, .opc1 = 4, .crm = 2,
       .access = PL2_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
@@ -6807,6 +6811,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 4, .crn = 13, .crm = 0, .opc2 = 1,
               .access = PL2_RW,
               .fieldoffset = offsetof(CPUARMState, cp15.contextidr_el[2]) },
+            { .name = "TTBR1_EL2", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 1,
+              .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
+              .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]) },
             REGINFO_SENTINEL
         };
         define_arm_cp_regs(cpu, vhe_reginfo);
-- 
2.17.1


