Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95D5C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EEC20936
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d04X5wX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EEC20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBijp-00039W-DD
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBiiC-0001QT-QE
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:02:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:47019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBiiB-0002Ic-1p
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:02:52 -0400
Received: by mail-pl1-x632.google.com with SMTP id k13so9659plk.13
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=al4HxnT9REeNzlCVwjlrJn8dPB8N3tcD/YiO2+sLUwI=;
 b=d04X5wX9rCdT+fojg5bMJ5ellBegC4ckJKn9ZhNbyavThE3HeIkgkuAMDiklcnJrPs
 awPPHcaIxN3+lqKLOTFs1RFxYaKi7iIbUOtNLFF8Ms7SdyraBl4TRXTmkabiqGxBlccl
 vs38iLCq+4JRk8HygSx5ObgJkxAD2X2ZwekPFhJT9ywRwVMmTWq8za74J+SkFs8ylLga
 7eB3vboSiWYZtvTR4RmTslOHz2Jph5vnE86J2u739P+9p6qQKtNpqFnjcVmp3Gbv7ZSX
 mTVEpKacIj+U+LwwPl3fYRTJhxLxVZ0HAblxb0xEoo8BYjxhZzazUEbaMstm/UdkhGAB
 I9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=al4HxnT9REeNzlCVwjlrJn8dPB8N3tcD/YiO2+sLUwI=;
 b=RV8zlctH77MIL1N3X9MXnHQzRRrsDYgy2N+1Zs7Dke6MH89p+bcxE0YLJRop3gfYxL
 oZ1XO6Bov6aYDmzUhPXIdNAmEWANQK6Zcl1r+ULBub+xR0hGxTUwgcSzVGxrRPdlfYcU
 LSU8X20bBjiQPSTkSN3MAZAShRknbohTXTGPtty2o6fshqTtnPp2HdCjLvn5fmRAohLE
 Ycb2GD60Bk33W9CwffLicaYWaju+5ADA0DGVMq32E5lNYN0ImMPXkOeuZ8L3VLGcujoL
 47QitZRd6PMNLDAo+1B5+CJ4yvpbtnsBGILX3fQa9/ac+AHod/ZQ/5HNiYMIZUsZ7cLv
 7O5w==
X-Gm-Message-State: AOAM530cRyMRRzoIHuwegYmMJlPf46y1X5bzE3RHSMiBZ54k2eSu//d7
 c2XsioJjzlWID93hjxtXWID9bqAopXUa0g==
X-Google-Smtp-Source: ABdhPJz7FaEE5EgbQ4jn/TAXnXcelBGTGQIOEoWfKk19ut4uPZdhP5+K1qSgWyK+cgzeitPV5DHhmg==
X-Received: by 2002:a17:90a:1992:: with SMTP id
 18mr170930pji.135.1598637769136; 
 Fri, 28 Aug 2020 11:02:49 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w14sm41656pfi.211.2020.08.28.11.02.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:02:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] tcg: Implement 256-bit dup for tcg_gen_gvec_dup_mem
Date: Fri, 28 Aug 2020 11:02:43 -0700
Message-Id: <20200828180243.443016-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828180243.443016-1-richard.henderson@linaro.org>
References: <20200828180243.443016-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

We already support duplication of 128-bit blocks.  This extends
that support to 256-bit blocks.  This will be needed by SVE2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 52 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index fcc25b04e6..7ebd9e8298 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1570,12 +1570,10 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);
             tcg_temp_free_i64(in);
         }
-    } else {
+    } else if (vece == 4) {
         /* 128-bit duplicate.  */
-        /* ??? Dup to 256-bit vector.  */
         int i;
 
-        tcg_debug_assert(vece == 4);
         tcg_debug_assert(oprsz >= 16);
         if (TCG_TARGET_HAS_v128) {
             TCGv_vec in = tcg_temp_new_vec(TCG_TYPE_V128);
@@ -1601,6 +1599,54 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
         if (oprsz < maxsz) {
             expand_clr(dofs + oprsz, maxsz - oprsz);
         }
+    } else if (vece == 5) {
+        /* 256-bit duplicate.  */
+        int i;
+
+        tcg_debug_assert(oprsz >= 32);
+        tcg_debug_assert(oprsz % 32 == 0);
+        if (TCG_TARGET_HAS_v256) {
+            TCGv_vec in = tcg_temp_new_vec(TCG_TYPE_V256);
+
+            tcg_gen_ld_vec(in, cpu_env, aofs);
+            for (i = (aofs == dofs) * 32; i < oprsz; i += 32) {
+                tcg_gen_st_vec(in, cpu_env, dofs + i);
+            }
+            tcg_temp_free_vec(in);
+        } else if (TCG_TARGET_HAS_v128) {
+            TCGv_vec in0 = tcg_temp_new_vec(TCG_TYPE_V128);
+            TCGv_vec in1 = tcg_temp_new_vec(TCG_TYPE_V128);
+
+            tcg_gen_ld_vec(in0, cpu_env, aofs);
+            tcg_gen_ld_vec(in1, cpu_env, aofs + 16);
+            for (i = (aofs == dofs) * 32; i < oprsz; i += 32) {
+                tcg_gen_st_vec(in0, cpu_env, dofs + i);
+                tcg_gen_st_vec(in1, cpu_env, dofs + i + 16);
+            }
+            tcg_temp_free_vec(in0);
+            tcg_temp_free_vec(in1);
+        } else {
+            TCGv_i64 in[4];
+            int j;
+
+            for (j = 0; j < 4; ++j) {
+                in[j] = tcg_temp_new_i64();
+                tcg_gen_ld_i64(in[j], cpu_env, aofs + j * 8);
+            }
+            for (i = (aofs == dofs) * 32; i < oprsz; i += 32) {
+                for (j = 0; j < 4; ++j) {
+                    tcg_gen_st_i64(in[j], cpu_env, dofs + i + j * 8);
+                }
+            }
+            for (j = 0; j < 4; ++j) {
+                tcg_temp_free_i64(in[j]);
+            }
+        }
+        if (oprsz < maxsz) {
+            expand_clr(dofs + oprsz, maxsz - oprsz);
+        }
+    } else {
+        g_assert_not_reached();
     }
 }
 
-- 
2.25.1


