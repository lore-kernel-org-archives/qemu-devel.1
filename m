Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BC8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBBA20767
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYFxa8Nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBBA20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofPg-0001Tj-NU
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6Y-0001FP-7j
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:42 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:51881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6W-00026S-Ei
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:41 -0400
Received: by mail-pj1-x1042.google.com with SMTP id l6so1327641pjq.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zleS2QR+lFAdTaTiZt51fC/IOMo1sfVsNhWWJdJDQys=;
 b=gYFxa8NuB2mYtUFTWDBAVaIz6bOCh6uFZoM2ePNF4ua8IT/81vvxe44MKjuBWqBDR4
 qHTLhNM2Et6I3FICmaBJEDclG6zr9gL0gZFHaqsI8gp3P9il8iuXLLQ4eGr6/96KvhTD
 tKy+tsKsjklxKBESDlhVUDVtgn+GhYIgkUId3fxqAPLoPV//+ux5KPxCLuEGkmflUxzs
 LavZyXA6vDDEJCVGNTkzX/o1IDqKtuAnOgVUPOLF9b8W7ZM3IZVjkmsaxIOTFVRmpT+E
 nXvcX5kHJ5RmLLxPqUC/TnE7aDK4V5tFmoFCMej2mUJabtqVQtVqTCO2WCrfYprnU2x6
 s+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zleS2QR+lFAdTaTiZt51fC/IOMo1sfVsNhWWJdJDQys=;
 b=untqzEV98MPWY+/NpMMtej5E03qfAVh99DSrmAp23ONHvq8gkd8hxrwdCw0toU3QHM
 UJhXgTITaAiOiGTBRl1yUUetRJsRwvVpTGcT0LNlYU1QKo8Ds4oBnedhaTSG+s+3gUtL
 iCCi0vD2CtER2G0fRN8JLBcLOGiPB6WGxcXEW+/fHOgQ0UwkeoHl0L4o6c4z3ZEaHwOU
 VeX3yOP5/mzNfrY8jZiRGXh5b3cxSxtr8w0phXIE//psyqkkyTrFsTKTOiO8SpPqCOj1
 NM7pcZJnWk4JsDoArfy/171h+D62VmF5nCWlv2TYtrnH7O58kJ/IRWah4bQVSJqjlLju
 o8+g==
X-Gm-Message-State: AOAM530gjFkbTFjbsJKN3Notz7yc+uaCg5+eN1nvJxETt/rA3KId/Rmw
 KgAgq1UGStfXuDJXv6DnJPRsaqgrCHk=
X-Google-Smtp-Source: ABdhPJyJeTadIcKspDiGrUT24TAEgve4dHjdLuidDO6tUtIlKpGTQ7FHhg7Ks4SKmnv76CVokfPepg==
X-Received: by 2002:a17:90a:fe0c:: with SMTP id
 ck12mr1206712pjb.209.1593142358824; 
 Thu, 25 Jun 2020 20:32:38 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 39/46] target/arm: Implement data cache set allocation tags
Date: Thu, 25 Jun 2020 20:31:37 -0700
Message-Id: <20200626033144.790098-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is DC GVA and DC GZVA, and the tag check for DC ZVA.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 3bf0518ca4..513c38970c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2360,7 +2360,9 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
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
index 44a3f9fb48..23cf44fcf4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6998,6 +6998,22 @@ static const ARMCPRegInfo mte_el0_cacheop_reginfo[] = {
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
index c20af6ee9d..73d753f11f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1874,6 +1874,45 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
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
2.25.1


