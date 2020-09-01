Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16552C28E83
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E3852064B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ohypDc/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3852064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8Yt-000091-O8
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83n-0008Qk-Ch
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83l-0006Ep-Bq
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id m6so2003503wrn.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=PmeOYcAvC6VtCxfms298ylKFKv4w1tXwUMe/SRV1NTk=;
 b=ohypDc/ZIs1qyF4qyFFoU13k8/n0xwoQGvfN108c9Xh63XpyautojlHXIxyixdKz+0
 zReoTc/lbTmldpvNIyoNVzHsqCDmZ1gfY3qjxhFEh9vLi/Zi1A+crv4LMUBESuhZoJxf
 mJ1+uVXV4fOp9ymYskOxxXjCrmxgUsnNUe4pSVuQMNbBBdeud7Xa+Jdm9jyHc9ZSuMn9
 v39+SWf1wZEg5C5ss6VjNXAN9RsPsPsH8pC6FNJdixCFirxutSnRBdMQeVT3AgQ4cQZN
 1EAnxFXM7Llixdo4zo6aNZw3ZczWioqQ20Cq1sN4DdNyefNb7WVihMIzfThDAbxjz8g4
 acuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PmeOYcAvC6VtCxfms298ylKFKv4w1tXwUMe/SRV1NTk=;
 b=I0wXYzhgZwcbDnVm9sg3WbTHH2Us9QrO03h48C7lDuv7V52K778c5Z1S54B21MepGw
 r4TIiyid+UGdQRS25H8bKGaPbrYU1utlbh+mPh2WpT/HA4WSV9GidEO8r5NjvGSnQHpN
 y5CDK7rufCq+u+l4W+9+jVBEqXonD6DriNxQk1RjVsdEaVqI6zByuja0qSLwKZ2+rUuQ
 CDabcpLk0hOp7UlPAsAYfvz1Ck+3+Mj/D4ta2WzAQRuoO7taLfu8x8XI+WhnSDDhUnNR
 LmcZAi02HKu/2DbkFyAhpzPwVDjkJVvsVM4aji4Co9WPy4kP4zsXgn3+P6mX1zdTI2q4
 rr4A==
X-Gm-Message-State: AOAM53187soOJr4iM0n5fWeo3kFzyz7U3DpsDjAMVu0gIiYQYJS4Pq2m
 5zzVzfbDztxhYBWXxbwhttMRwTAZDAopDdRU
X-Google-Smtp-Source: ABdhPJwpJWzrOdG5JXqTb6sz3t3C5MTRFagdrc9z5ZTsleyEhYgbyHjmD4ELrd30eGyzNMTWU7cmwQ==
X-Received: by 2002:a5d:4109:: with SMTP id l9mr2509135wrp.398.1598973535723; 
 Tue, 01 Sep 2020 08:18:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/47] target/arm: Implement fp16 for Neon VRECPE,
 VRSQRTE using gvec
Date: Tue,  1 Sep 2020 16:17:59 +0100
Message-Id: <20200901151823.29785-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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

We already have gvec helpers for floating point VRECPE and
VRQSRTE, so convert the Neon decoder to use them and
add the fp16 support.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-25-peter.maydell@linaro.org
---
 target/arm/translate-neon.c.inc | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 9d0959517fa..0a96245e962 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -3857,13 +3857,40 @@ static bool do_2misc_fp(DisasContext *s, arg_2misc *a,
         return do_2misc_fp(s, a, FUNC);                         \
     }
 
-DO_2MISC_FP(VRECPE_F, gen_helper_recpe_f32)
-DO_2MISC_FP(VRSQRTE_F, gen_helper_rsqrte_f32)
 DO_2MISC_FP(VCVT_FS, gen_helper_vfp_sitos)
 DO_2MISC_FP(VCVT_FU, gen_helper_vfp_uitos)
 DO_2MISC_FP(VCVT_SF, gen_helper_vfp_tosizs)
 DO_2MISC_FP(VCVT_UF, gen_helper_vfp_touizs)
 
+#define DO_2MISC_FP_VEC(INSN, HFUNC, SFUNC)                             \
+    static void gen_##INSN(unsigned vece, uint32_t rd_ofs,              \
+                           uint32_t rm_ofs,                             \
+                           uint32_t oprsz, uint32_t maxsz)              \
+    {                                                                   \
+        static gen_helper_gvec_2_ptr * const fns[4] = {                 \
+            NULL, HFUNC, SFUNC, NULL,                                   \
+        };                                                              \
+        TCGv_ptr fpst;                                                  \
+        fpst = fpstatus_ptr(vece == MO_16 ? FPST_STD_F16 : FPST_STD);   \
+        tcg_gen_gvec_2_ptr(rd_ofs, rm_ofs, fpst, oprsz, maxsz, 0,       \
+                           fns[vece]);                                  \
+        tcg_temp_free_ptr(fpst);                                        \
+    }                                                                   \
+    static bool trans_##INSN(DisasContext *s, arg_2misc *a)             \
+    {                                                                   \
+        if (a->size == MO_16) {                                         \
+            if (!dc_isar_feature(aa32_fp16_arith, s)) {                 \
+                return false;                                           \
+            }                                                           \
+        } else if (a->size != MO_32) {                                  \
+            return false;                                               \
+        }                                                               \
+        return do_2misc_vec(s, a, gen_##INSN);                          \
+    }
+
+DO_2MISC_FP_VEC(VRECPE_F, gen_helper_gvec_frecpe_h, gen_helper_gvec_frecpe_s)
+DO_2MISC_FP_VEC(VRSQRTE_F, gen_helper_gvec_frsqrte_h, gen_helper_gvec_frsqrte_s)
+
 static bool trans_VRINTX(DisasContext *s, arg_2misc *a)
 {
     if (!arm_dc_feature(s, ARM_FEATURE_V8)) {
-- 
2.20.1


