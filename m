Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EB7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DAAF20706
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANWIGvau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAAF20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqX6-0005PR-Nm
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4i-0003Px-F9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:38043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4g-0006k6-FV
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id f18so9721207wml.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YHSAI+M5IEuzEQaVNFGEaurDNFpxI355l7zrjOZ1Ak0=;
 b=ANWIGvaue7AZ47hR7sNriXp/K53xsnf8bp9waIEulaBNR2DjbatLGa91enIC4z3TVS
 nCo1kaqYI60NA/+OOCKK3jouq0RZVApE1bg2IagV8fLmZMnkmRoDbCHJt+BBtgNXSrc4
 fFmp27a0Nvo/YByonAbLDlxP8k905ZgD34eKExmzLS/QYpyXak66tzlUSUKMHukUMrfm
 hHNeNiNTQijIeSLCiFf4EiAOkwsI5TXj6J03pKdfisZlRFd12hU0hSBh5MZJKDSiSJoX
 XE3ENZELWmQccEE7IsmTfwvYy9dPt1+2JBzpXl9dJrI4tFZxXQkSWkezqOvnRP31N2N0
 yGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YHSAI+M5IEuzEQaVNFGEaurDNFpxI355l7zrjOZ1Ak0=;
 b=CiBmjOx6dCU5FdDGTaRiFZ3xXpPNoaFd5nrYmNiL77Knjfm85YppJ4i5FoSt52ejPr
 axYTTQUXI1xeE4tXh27LTUUTDCxPM8UJHhyBT1/ucdxyydVIJPO6al1lbQVQ7SqDgr3z
 lwSDMsejV0tC4laqij03fFjbycBUDqtRNs4HzLYHG2ZlOt3yGtLz4CJs9ib201trRpC5
 cEUbmy/5SycZ6H1cwfFTUaVlfFOom/AQwpD6WPzxOHyaZuZZLGoOw7Zc5ANZkhkLzLbu
 7uVjRm6kjXDqdAr07Nq9pK1wp908wGnFwJBjGzgZehCo4Sz3INVeG2Bq9UUgvHzReknE
 PpCg==
X-Gm-Message-State: AOAM533Kto41djvGWy7BRtcSEFBaVD6IBWvylqoZCqVL7VYfZgX5mu/I
 AkD6swdxPol2KMxoMuEnFXpnJLiePqt2kQ==
X-Google-Smtp-Source: ABdhPJxdHMzRafuKFxGgGOK4BtDlRjfDP4F39S4JRukTqa+/DUOCQphcKs0hj4tj+WIYV7q8x0N1WQ==
X-Received: by 2002:a7b:c3c7:: with SMTP id t7mr3309338wmj.97.1593184528029;
 Fri, 26 Jun 2020 08:15:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/57] target/arm: Implement data cache set allocation tags
Date: Fri, 26 Jun 2020 16:14:18 +0100
Message-Id: <20200626151424.30117-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This is DC GVA and DC GZVA, and the tag check for DC ZVA.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-40-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  4 +++-
 target/arm/helper.c        | 16 ++++++++++++++++
 target/arm/translate-a64.c | 39 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3bf0518ca49..513c38970cc 100644
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
index 44a3f9fb480..23cf44fcf42 100644
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
index c20af6ee9d0..73d753f11fb 100644
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
2.20.1


