Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C6DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B971720737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dbfd0rZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B971720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3S2-0008VT-2h
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr3RS-00082N-Im
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:56:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr3RQ-0002WE-TF
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:56:10 -0400
Received: by mail-pf1-x443.google.com with SMTP id u185so10815555pfu.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rQZd24S5VU+V/cof+qwhVwm+IKJe+Jz5EkBoSd9tflA=;
 b=dbfd0rZbLdOFvQpl1MnVp3uvOqNiTGA04gMF6x8GUUkOi7XVnrQwde2UDEE1LYP3x9
 HSpBTW3p6gY5vYAlkoGASUr3Wbjcs7q0YspVPMSOfnrIqHhN/7UAszlK1TJVg1wYz8RV
 fIgQcL9rKuenBRdsE3Q4w6fm9Y3CwhAYOsyv8NAYOTgSiCthprXgW5GIgQUWJA0VtwNz
 viie7vNoW+wMQAZKTdo3XgfSOJEqZa6lQfkXzCJuA5lvCT/JJLSBm+YinT1VCOQZwwym
 nMyOWRG2MsvwO5+CBDlH4VTtuV1zeC13zVB7UrCvTgKN/w0NZCcGPy+rRu/xrD7SI6sB
 womA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rQZd24S5VU+V/cof+qwhVwm+IKJe+Jz5EkBoSd9tflA=;
 b=nXeFsHyDl0FdQwuy4AeyiL+v/ZAOgdCqxBsQgsuN4d6LRc/0gEZNL9QaULrbaDTi+b
 5W+LBoi5AfCCupK9tgEMAlJXnCRVRTOVeeKbsfmIJ9BAFvLiEh6IWoJ9w2cJJgOihdCW
 UDxZZsKoT/t3k25ggWgfCqf4EhYWTrXg9hSqkC5dDoAyoeueDzZ5Q6K924EUuG46dxjO
 OILhr56EvywGJ+rr8m+A/OZMb1dMbvATurFt474XDCY7xmB3vqMGVnG/YUE6XTtz28hR
 schyQXiROvcUjEIFdONmxWRj6IQJE1/IYcuPD3FMrw8LVETq5/wpPtU/Yq6NSvcKz4qE
 tcJQ==
X-Gm-Message-State: AOAM531MnJP6WD8Sl3djkeZnOPebbGnKIXjmeZ7cL/9bNgvI9Ed4krVQ
 9dOtvKkb0WKojAeYlWhbLfc1F4WD2FQ=
X-Google-Smtp-Source: ABdhPJz2rwdrVxBPrIMxGpsZrnyoZmOgiefcMUI9cQMNQnBr7WpcRc2n7ZJdBH/KZ4N9NVFCKQgCkA==
X-Received: by 2002:a62:8688:: with SMTP id
 x130mr29868613pfd.280.1593712566758; 
 Thu, 02 Jul 2020 10:56:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id ji2sm8141392pjb.1.2020.07.02.10.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:56:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Fix temp double-free in sve ldr/str
Date: Thu,  2 Jul 2020 10:56:05 -0700
Message-Id: <20200702175605.1987125-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The temp that gets assigned to clean_addr has been allocated with
new_tmp_a64, which means that it will be freed at the end of the
instruction.  Freeing it earlier leads to assertion failure.

The loop creates a complication, in which we allocate a new local
temp, which does need freeing, and the final code path is shared
between the loop and non-loop.

Fix this complication by adding new_tmp_a64_local so that the new
local temp is freed at the end, and can be treated exactly like
the non-loop path.

Fixes: bba87d0a0f4
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.h | 1 +
 target/arm/translate-a64.c | 6 ++++++
 target/arm/translate-sve.c | 8 ++------
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 49e4865918..647f0c74f6 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -30,6 +30,7 @@ void unallocated_encoding(DisasContext *s);
     } while (0)
 
 TCGv_i64 new_tmp_a64(DisasContext *s);
+TCGv_i64 new_tmp_a64_local(DisasContext *s);
 TCGv_i64 new_tmp_a64_zero(DisasContext *s);
 TCGv_i64 cpu_reg(DisasContext *s, int reg);
 TCGv_i64 cpu_reg_sp(DisasContext *s, int reg);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 73d753f11f..8c0764957c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -461,6 +461,12 @@ TCGv_i64 new_tmp_a64(DisasContext *s)
     return s->tmp_a64[s->tmp_a64_count++] = tcg_temp_new_i64();
 }
 
+TCGv_i64 new_tmp_a64_local(DisasContext *s)
+{
+    assert(s->tmp_a64_count < TMP_A64_MAX);
+    return s->tmp_a64[s->tmp_a64_count++] = tcg_temp_local_new_i64();
+}
+
 TCGv_i64 new_tmp_a64_zero(DisasContext *s)
 {
     TCGv_i64 t = new_tmp_a64(s);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f318ca265f..08f0fd15b2 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4372,9 +4372,8 @@ static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
 
         /* Copy the clean address into a local temp, live across the loop. */
         t0 = clean_addr;
-        clean_addr = tcg_temp_local_new_i64();
+        clean_addr = new_tmp_a64_local(s);
         tcg_gen_mov_i64(clean_addr, t0);
-        tcg_temp_free_i64(t0);
 
         gen_set_label(loop);
 
@@ -4422,7 +4421,6 @@ static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
         tcg_gen_st_i64(t0, cpu_env, vofs + len_align);
         tcg_temp_free_i64(t0);
     }
-    tcg_temp_free_i64(clean_addr);
 }
 
 /* Similarly for stores.  */
@@ -4463,9 +4461,8 @@ static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
 
         /* Copy the clean address into a local temp, live across the loop. */
         t0 = clean_addr;
-        clean_addr = tcg_temp_local_new_i64();
+        clean_addr = new_tmp_a64_local(s);
         tcg_gen_mov_i64(clean_addr, t0);
-        tcg_temp_free_i64(t0);
 
         gen_set_label(loop);
 
@@ -4509,7 +4506,6 @@ static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
         }
         tcg_temp_free_i64(t0);
     }
-    tcg_temp_free_i64(clean_addr);
 }
 
 static bool trans_LDR_zri(DisasContext *s, arg_rri *a)
-- 
2.25.1


