Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD7FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA082075B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbn2VoBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA082075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9CQ-0002pw-Nf
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95f-0005A4-9N
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:35 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95c-0004o5-6e
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:34 -0400
Received: by mail-wm1-x341.google.com with SMTP id a65so4085549wme.5
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ENPtwkyypi5he8g9f/1mEPuk6rEdLo6yuawroe2Xk4k=;
 b=xbn2VoBYCVxWm5yx1MMTM96JTInDji+JjG8grJOLkMWlv4g0hnGONfupP9DeVW1bIN
 yxjVFdAwzotzGONnekQWwXVXRox6uuVMVaLSp+6Wu48TfXGt1ikgYJIu3ud1NGKBWpZS
 emJRSbU8lVXdXXwtdz38ZOZtKp19fbSLRHsEV74Zr5GAZpxiRATgKE18cUpv83KktOZv
 ybbM2a0XR4fPU5kViJgVPfctHYN1mohHRDDGmtos6CBr3J3X065fzaWtmGeQ76eB5INA
 xW2os708+Wnp2WbsAq0/Zia6DFuA6eTtsl96A62zhbdV+RIXkSxvIRHuYIvdPYNi+sdT
 DsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ENPtwkyypi5he8g9f/1mEPuk6rEdLo6yuawroe2Xk4k=;
 b=dakbNIa3tm0gIimITZz9EFAnedR9pHuZGh8tvOgHHqvFS/LzK7yPrRbGiUGe0pOYh+
 zKeK378IZY8swIDm9NwSWKEmvc34HCZrJS81QwfpIj/XXkSqy8rjwiiWH6fNXF3t2VOi
 jxhhvHJemiVtOg4VicevSZTiNYAqikE61ykiNWq+RxIPdCtXMaRHB3gdJfkUBxXo/MQW
 UwadGMjWlCm2vnnhMDFUvD1BcDsiqfkjja/P9kBSxRTqG4zm06wdXf276nLICU135KoT
 gjoVzgdydVjJTI4U6Q3ghW16g0GVg0dtiAfhuOuJM9OrYmpW9E3xw8Mr4mjUJTGoIROJ
 7JJQ==
X-Gm-Message-State: AOAM531vhHCS2DZmJq7a8bk5McdkOhxd87oz2AIFvWwGKbvl1/1MjbPS
 gi0mQHXc4m6sJUl+I6uSBJr4bw9Vp5c+pDIa
X-Google-Smtp-Source: ABdhPJzlQtpYTjfhrEad08FmCjj7F5AeaNYurLTSpGbILNUSW10oGEcGihVnpTDN4Dp7f41RD5dPjw==
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr4819145wmf.21.1598262510480;
 Mon, 24 Aug 2020 02:48:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/27] target/arm: Pull handling of XScale insns out of
 disas_coproc_insn()
Date: Mon, 24 Aug 2020 10:47:58 +0100
Message-Id: <20200824094811.15439-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

At the moment we check for XScale/iwMMXt insns inside
disas_coproc_insn(): for CPUs with ARM_FEATURE_XSCALE all copro insns
with cp 0 or 1 are handled specially.  This works, but is an odd
place for this check, because disas_coproc_insn() is called from both
the Arm and Thumb decoders but the XScale case never applies for
Thumb (all the XScale CPUs were ARMv5, which has only Thumb1, not
Thumb2 with the 32-bit coprocessor insn encodings).  It also makes it
awkward to convert the real copro access insns to decodetree.

Move the identification of XScale out to its own function
which is only called from disas_arm_insn().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200803111849.13368-2-peter.maydell@linaro.org
---
 target/arm/translate.c | 44 ++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 556588d92fe..99663236aa9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4551,20 +4551,6 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 
     cpnum = (insn >> 8) & 0xf;
 
-    /* First check for coprocessor space used for XScale/iwMMXt insns */
-    if (arm_dc_feature(s, ARM_FEATURE_XSCALE) && (cpnum < 2)) {
-        if (extract32(s->c15_cpar, cpnum, 1) == 0) {
-            return 1;
-        }
-        if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
-            return disas_iwmmxt_insn(s, insn);
-        } else if (arm_dc_feature(s, ARM_FEATURE_XSCALE)) {
-            return disas_dsp_insn(s, insn);
-        }
-        return 1;
-    }
-
-    /* Otherwise treat as a generic register access */
     is64 = (insn & (1 << 25)) == 0;
     if (!is64 && ((insn & (1 << 4)) == 0)) {
         /* cdp */
@@ -4823,6 +4809,23 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
     return 1;
 }
 
+/* Decode XScale DSP or iWMMXt insn (in the copro space, cp=0 or 1) */
+static void disas_xscale_insn(DisasContext *s, uint32_t insn)
+{
+    int cpnum = (insn >> 8) & 0xf;
+
+    if (extract32(s->c15_cpar, cpnum, 1) == 0) {
+        unallocated_encoding(s);
+    } else if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
+        if (disas_iwmmxt_insn(s, insn)) {
+            unallocated_encoding(s);
+        }
+    } else if (arm_dc_feature(s, ARM_FEATURE_XSCALE)) {
+        if (disas_dsp_insn(s, insn)) {
+            unallocated_encoding(s);
+        }
+    }
+}
 
 /* Store a 64-bit value to a register pair.  Clobbers val.  */
 static void gen_storeq_reg(DisasContext *s, int rlow, int rhigh, TCGv_i64 val)
@@ -8270,15 +8273,26 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
     case 0xc:
     case 0xd:
     case 0xe:
-        if (((insn >> 8) & 0xe) == 10) {
+    {
+        /* First check for coprocessor space used for XScale/iwMMXt insns */
+        int cpnum = (insn >> 8) & 0xf;
+
+        if (arm_dc_feature(s, ARM_FEATURE_XSCALE) && (cpnum < 2)) {
+            disas_xscale_insn(s, insn);
+            break;
+        }
+
+        if ((cpnum & 0xe) == 10) {
             /* VFP, but failed disas_vfp.  */
             goto illegal_op;
         }
+
         if (disas_coproc_insn(s, insn)) {
             /* Coprocessor.  */
             goto illegal_op;
         }
         break;
+    }
     default:
     illegal_op:
         unallocated_encoding(s);
-- 
2.20.1


