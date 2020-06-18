Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF07C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76ED321852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xD939vyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76ED321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmFT-0007HN-M1
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm9M-0003CS-OC
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:27:40 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm9F-0002Qr-TA
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:27:40 -0400
Received: by mail-pg1-x543.google.com with SMTP id l63so2314306pge.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CK2elIXOTHImMlsaoqCYUcyN3xToI2uVAuloYRoKKNU=;
 b=xD939vyXfZYH4ys3CkLFzVHUvh2tO662tbDdcZ1P4ZfLHGg+NwA1GXvP2gC/XN0B5m
 VeOTF+t98N7pEl41xhtfOOxuvX4kZFocX5iWsLAh0WfN3r7hC65uUolMocOv+qQLaD3c
 y4/8yXfqiUxD3JW0XARvcr9axxXvPt60mX9komdgg7g8jRRvfJLys1YXg9wKcCWEZj/C
 yBS9rXSv7i4TgvyqDxFWGGg4d8mZJ3f1VLPXVQlmU7+J98CeTEYKLCsny7h8e0gfdAdS
 2v1Fgwrb0qiQNVhCQUzTLzodNunUUP/g7rIhqyR0WQnZW4yWPn9G37JVps1OPqh/+aWX
 7Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CK2elIXOTHImMlsaoqCYUcyN3xToI2uVAuloYRoKKNU=;
 b=Zn9OvirLXTB1pXTY19RRvmPVioF1CP+BqHWKDz9eV3TcbE9geJds+7voFbHl9B9yI6
 yp8ksPN+IN2WL8s+86pVxEQi4UjK8SGeb6V4g20U4aPxUuz5SW0j8FfVDbw9T8iZjQO+
 XBNacCaKV15dpZiAfiHiWzj8mkN0vwU/uJmiE/qzhHShGogr5njsu2OfraYSiRGdFpUo
 dt1LvEWOYGALShtK3JLBkfn4edXXTvMpZSIJCRFL3lgG7YcKDVispFpdbCjyoI4HqSmQ
 Y194giRFodv3jZpy48RvOD8z5CAWee+8JldFVrHpJxPoX9B9BLvh4zb/BC36uxJYJEIo
 P8Og==
X-Gm-Message-State: AOAM531tSshXzflmA4GqHm0fpE0XvsvIuoxmb9YPDuQBiGoKqD0KeHiM
 tXlvt3y+CmIkPysxJvspdW6TZqtZUyw=
X-Google-Smtp-Source: ABdhPJyDXweJZuILISI3KzkK2V6sOoUvgjOUgpRbv9k86G31krRqlKAdD76/2d4tpcVkIEOYeLajvg==
X-Received: by 2002:a63:7c56:: with SMTP id l22mr1765420pgn.127.1592454452054; 
 Wed, 17 Jun 2020 21:27:32 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u61sm964897pjb.7.2020.06.17.21.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:27:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 011/100] target/arm: Split out gen_gvec_ool_zzp
Date: Wed, 17 Jun 2020 21:25:15 -0700
Message-Id: <20200618042644.1685561-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Model after gen_gvec_fn_zzz et al.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 9687606a93..3e9bbaca94 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -142,6 +142,17 @@ static int pred_gvec_reg_size(DisasContext *s)
     return size_for_gvec(pred_full_reg_size(s));
 }
 
+/* Invoke an out-of-line helper on 2 Zregs and a predicate. */
+static void gen_gvec_ool_zzp(DisasContext *s, gen_helper_gvec_3 *fn,
+                             int rd, int rn, int pg, int data)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       pred_full_reg_offset(s, pg),
+                       vsz, vsz, data, fn);
+}
+
 /* Invoke an out-of-line helper on 3 Zregs and a predicate. */
 static void gen_gvec_ool_zzzp(DisasContext *s, gen_helper_gvec_4 *fn,
                               int rd, int rn, int rm, int pg, int data)
@@ -415,11 +426,7 @@ static bool do_zpz_ool(DisasContext *s, arg_rpr_esz *a, gen_helper_gvec_3 *fn)
         return false;
     }
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           pred_full_reg_offset(s, a->pg),
-                           vsz, vsz, 0, fn);
+        gen_gvec_ool_zzp(s, fn, a->rd, a->rn, a->pg, 0);
     }
     return true;
 }
@@ -603,11 +610,7 @@ static bool do_movz_zpz(DisasContext *s, int rd, int rn, int pg,
     };
 
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
-                           vec_full_reg_offset(s, rn),
-                           pred_full_reg_offset(s, pg),
-                           vsz, vsz, invert, fns[esz]);
+        gen_gvec_ool_zzp(s, fns[esz], rd, rn, pg, invert);
     }
     return true;
 }
@@ -616,11 +619,7 @@ static bool do_zpzi_ool(DisasContext *s, arg_rpri_esz *a,
                         gen_helper_gvec_3 *fn)
 {
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           pred_full_reg_offset(s, a->pg),
-                           vsz, vsz, a->imm, fn);
+        gen_gvec_ool_zzp(s, fn, a->rd, a->rn, a->pg, a->imm);
     }
     return true;
 }
-- 
2.25.1


