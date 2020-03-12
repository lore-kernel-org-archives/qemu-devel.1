Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D90C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCBC206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZ3J9BIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCBC206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTsI-0007sS-9Y
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjd-0006iz-MA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjc-0002OA-Ca
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:13 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjc-0002Nh-5u
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:12 -0400
Received: by mail-pl1-x642.google.com with SMTP id f8so3064169plt.10
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7tXXL1aIZa+UtCbjnv5unnvpKSgUfOHdhgWj90HH058=;
 b=HZ3J9BIFMbH7FTKw2xECHChtcI/vfAPmLedYZgT7AaIastMiLWoLzpNsDA8DAdtjag
 yFAuH2ei1xRkSMGW2HDGnjXKLkquL9K4St1Ow5O0l9U8Z7Rf10ACMv6Zswy7W7Indbgf
 2yqm8EwQIWxAfFa+lIVEHcjJQDp04LTPkxgMxNQjCOqsMtz5Y/kydTGJ0UKiFqruaeNe
 D1swpVBdQyyVVGplkmmTnjb78/sWKdXltVBJvDDYEAfy+S3HQo5SLOJ9TWyDgDhPHiad
 1qHCmfug6qyasfyFxAsW6n1I6PLxPL5gcdKQHFUpvmnhMgJlrOwqJBH+uNrRTAyunbwD
 Wy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7tXXL1aIZa+UtCbjnv5unnvpKSgUfOHdhgWj90HH058=;
 b=DgOOx1PC2aRQOiM/aI2ByBUGYIDHd12LCRhxyvxuMqj+ayyLMglAsJtYln2wqH420Y
 qmZgn4XdVYzxBHNpC1Ik1JesKEr/nQUN5rt720/qJ05kUEjPTa62r7h4ml/54Qkqx0J3
 3s8ZXyeAb341YabZazaqfYM8Czf/cg3WNVrQI8fO6Lufll959ZmB0VJV11Yj4dYZM2ma
 DWaRbzE+JQAMY0hrhK37gwhMl+3EdnpQ/KnSUsVOZ8Dou6f5kie0HWyfkQXELCRoCenm
 gyC2oO0gboQKf6Pp9M0lYFrJaG50IEFvdiSwuf74T/5592V0+GO3aSXCeNL5+cAQGUUO
 2AyA==
X-Gm-Message-State: ANhLgQ06xKeS/TuaahlTiPVfFFEzJM1HVSJ2edMW9xaWm6WfWMtw1tc2
 TL53fh8EtBJo96OEGqtve4WhgtybRjM=
X-Google-Smtp-Source: ADFU+vuSgUUQzkGrrD8l/QTXUUUK3o1dEQ2IFGMXMGIop4GeZcgOdNNmzRqQPG1UGD9EYabTqjCQMA==
X-Received: by 2002:a17:902:694c:: with SMTP id
 k12mr9427834plt.329.1584042190805; 
 Thu, 12 Mar 2020 12:43:10 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:43:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 37/42] target/arm: Implement data cache set allocation tags
Date: Thu, 12 Mar 2020 12:42:14 -0700
Message-Id: <20200312194219.24406-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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

This is DC GVA and DC GZVA, and the tag check for DC ZVA.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use allocation_tag_mem + memset.
v3: Require pre-cleaned addresses.
v6: Move DCZ block size assert to cpu realize.
    Perform a tag check for DC ZVA.
---
 target/arm/cpu.h           |  4 +++-
 target/arm/helper.c        | 16 ++++++++++++++++
 target/arm/translate-a64.c | 39 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 67164d56a1..b78bf2be4a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2337,7 +2337,9 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
 #define ARM_CP_NZCV              (ARM_CP_SPECIAL | 0x0300)
 #define ARM_CP_CURRENTEL         (ARM_CP_SPECIAL | 0x0400)
 #define ARM_CP_DC_ZVA            (ARM_CP_SPECIAL | 0x0500)
-#define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
+#define ARM_CP_DC_GVA            (ARM_CP_SPECIAL | 0x0600)
+#define ARM_CP_DC_GZVA           (ARM_CP_SPECIAL | 0x0700)
+#define ARM_LAST_SPECIAL         ARM_CP_DC_GZVA
 #define ARM_CP_FPU               0x1000
 #define ARM_CP_SVE               0x2000
 #define ARM_CP_NO_GDB            0x4000
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e4b4366af7..44e7c0d19b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6983,6 +6983,22 @@ static const ARMCPRegInfo mte_el0_cacheop_reginfo[] = {
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 5,
       .type = ARM_CP_NOP, .access = PL0_W,
       .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_GVA", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 4, .opc2 = 3,
+      .access = PL0_W, .type = ARM_CP_DC_GVA,
+#ifndef CONFIG_USER_ONLY
+      /* Avoid overhead of an access check that always passes in user-mode */
+      .accessfn = aa64_zva_access,
+#endif
+    },
+    { .name = "DC_GZVA", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 4, .opc2 = 4,
+      .access = PL0_W, .type = ARM_CP_DC_GZVA,
+#ifndef CONFIG_USER_ONLY
+      /* Avoid overhead of an access check that always passes in user-mode */
+      .accessfn = aa64_zva_access,
+#endif
+    },
     REGINFO_SENTINEL
 };
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1314b200e0..f33f174584 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1919,6 +1919,45 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         }
         gen_helper_dc_zva(cpu_env, tcg_rt);
         return;
+    case ARM_CP_DC_GVA:
+        {
+            TCGv_i64 clean_addr, tag;
+
+            /*
+             * DC_GVA, like DC_ZVA, requires that we supply the original
+             * pointer for an invalid page.  Probe that address first.
+             */
+            tcg_rt = cpu_reg(s, rt);
+            clean_addr = clean_data_tbi(s, tcg_rt);
+            gen_probe_access(s, clean_addr, MMU_DATA_STORE, MO_8);
+
+            if (s->ata) {
+                /* Extract the tag from the register to match STZGM.  */
+                tag = tcg_temp_new_i64();
+                tcg_gen_shri_i64(tag, tcg_rt, 56);
+                gen_helper_stzgm_tags(cpu_env, clean_addr, tag);
+                tcg_temp_free_i64(tag);
+            }
+        }
+        return;
+    case ARM_CP_DC_GZVA:
+        {
+            TCGv_i64 clean_addr, tag;
+
+            /* For DC_GZVA, we can rely on DC_ZVA for the proper fault. */
+            tcg_rt = cpu_reg(s, rt);
+            clean_addr = clean_data_tbi(s, tcg_rt);
+            gen_helper_dc_zva(cpu_env, clean_addr);
+
+            if (s->ata) {
+                /* Extract the tag from the register to match STZGM.  */
+                tag = tcg_temp_new_i64();
+                tcg_gen_shri_i64(tag, tcg_rt, 56);
+                gen_helper_stzgm_tags(cpu_env, clean_addr, tag);
+                tcg_temp_free_i64(tag);
+            }
+        }
+        return;
     default:
         break;
     }
-- 
2.20.1


