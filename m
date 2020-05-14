Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F19AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A16206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xCJHISdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A16206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEty-00058q-5p
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkB-0002yY-OP
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkA-0005Ri-QZ
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id w7so4311455wre.13
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/ze7SlxiZm1YpHwCMh4oC1PqJxHGVnQf3G80tRt3gUE=;
 b=xCJHISdKkzEjk3YY7zcam7jitweW7CfYLIYeFCLfpGflFGPP5dw9fbiQklbSpJS06b
 ENyRv6yyhYptKiHqKslZSt2MExY13S4D+a3NO8L9HwX/g2v6iOj6PrazivDgMCbiDf+D
 9iNFpc0XF/8JgWrQp1Fx8E5DcTosEQG0+lZaxgi8y3EPEC8BhPciwwDJdu/9mW7QQ01P
 cJujLXNhR+zPgYw3f1QLC/Koo+TNwa+R0NKHn4UAJADEwunOy6FLpNobTwFQTR6n9huW
 gQ64clPT+Um9FbfuyGIwLZHYaggLePBJg6okZUjeRxW6BaSCShFbsISBZVHlQYpD3Khu
 5mSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/ze7SlxiZm1YpHwCMh4oC1PqJxHGVnQf3G80tRt3gUE=;
 b=RQItfYAtcSCOM9IP1RaXv55HTGZ4gtbbyb353riEDIfm1fJHReuAobmKMCRVzHGg5f
 +n9wtti2a8QNAmR25nBz6L4Gd/ISsDHNONBt6RsyeLS6LqVX8fEoMfTyPm8ZMudjpAVz
 E5zLEv7k4TcXPFfjQrky34FZw0lbNQdxCRe6FiTitmJHfZJjXvwxVudQXEzRpVPeFSq5
 0lSOVf+IQIDZ29/sj/WjPu0etH+/Br3pBOPwWx+KBK1CmAJzHNrY4Z3cur0HQgKzh4cY
 rL4o8j7TT2Z5zuQzQNA4jddsvklBQgS1DY99lUphVVQyHX4TETy3U1ynvQ+KMKIon9Pp
 bhmQ==
X-Gm-Message-State: AOAM530GT+kCcJRbPGfELgGc4mgVjqvaXQTZD7AVuVH4iQPbishXiw1B
 KKyxV4y54K0E+t1hpHczkIdv1/x0jJIMTw==
X-Google-Smtp-Source: ABdhPJxpj0mZ3WpmT32BK/NKCTG/jEyxvkM8f4MgMlEigm0DqjatjdPZv6hYnnGlbiiOeF2f8n0HUA==
X-Received: by 2002:adf:82b3:: with SMTP id 48mr5633472wrc.223.1589466109111; 
 Thu, 14 May 2020 07:21:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.21.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:21:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/45] target/arm: Tidy handle_vec_simd_shri
Date: Thu, 14 May 2020 15:20:59 +0100
Message-Id: <20200514142138.20875-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Now that we've converted all cases to gvec, there is quite a bit
of dead code at the end of the function.  Remove it.

Sink the call to gen_gvec_fn2i to the end, loading a function
pointer within the switch statement.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200513163245.17915-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 56 ++++++++++----------------------------
 1 file changed, 14 insertions(+), 42 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2d7dad6c3f2..d5e77f34a7c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10155,16 +10155,7 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
     int size = 32 - clz32(immh) - 1;
     int immhb = immh << 3 | immb;
     int shift = 2 * (8 << size) - immhb;
-    bool accumulate = false;
-    int dsize = is_q ? 128 : 64;
-    int esize = 8 << size;
-    int elements = dsize/esize;
-    MemOp memop = size | (is_u ? 0 : MO_SIGN);
-    TCGv_i64 tcg_rn = new_tmp_a64(s);
-    TCGv_i64 tcg_rd = new_tmp_a64(s);
-    TCGv_i64 tcg_round;
-    uint64_t round_const;
-    int i;
+    GVecGen2iFn *gvec_fn;
 
     if (extract32(immh, 3, 1) && !is_q) {
         unallocated_encoding(s);
@@ -10178,13 +10169,12 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
 
     switch (opcode) {
     case 0x02: /* SSRA / USRA (accumulate) */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift,
-                      is_u ? gen_gvec_usra : gen_gvec_ssra, size);
-        return;
+        gvec_fn = is_u ? gen_gvec_usra : gen_gvec_ssra;
+        break;
 
     case 0x08: /* SRI */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift, gen_gvec_sri, size);
-        return;
+        gvec_fn = gen_gvec_sri;
+        break;
 
     case 0x00: /* SSHR / USHR */
         if (is_u) {
@@ -10192,49 +10182,31 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
                 /* Shift count the same size as element size produces zero.  */
                 tcg_gen_gvec_dup_imm(size, vec_full_reg_offset(s, rd),
                                      is_q ? 16 : 8, vec_full_reg_size(s), 0);
-            } else {
-                gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_shri, size);
+                return;
             }
+            gvec_fn = tcg_gen_gvec_shri;
         } else {
             /* Shift count the same size as element size produces all sign.  */
             if (shift == 8 << size) {
                 shift -= 1;
             }
-            gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_sari, size);
+            gvec_fn = tcg_gen_gvec_sari;
         }
-        return;
+        break;
 
     case 0x04: /* SRSHR / URSHR (rounding) */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift,
-                      is_u ? gen_gvec_urshr : gen_gvec_srshr, size);
-        return;
+        gvec_fn = is_u ? gen_gvec_urshr : gen_gvec_srshr;
+        break;
 
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift,
-                      is_u ? gen_gvec_ursra : gen_gvec_srsra, size);
-        return;
+        gvec_fn = is_u ? gen_gvec_ursra : gen_gvec_srsra;
+        break;
 
     default:
         g_assert_not_reached();
     }
 
-    round_const = 1ULL << (shift - 1);
-    tcg_round = tcg_const_i64(round_const);
-
-    for (i = 0; i < elements; i++) {
-        read_vec_element(s, tcg_rn, rn, i, memop);
-        if (accumulate) {
-            read_vec_element(s, tcg_rd, rd, i, memop);
-        }
-
-        handle_shri_with_rndacc(tcg_rd, tcg_rn, tcg_round,
-                                accumulate, is_u, size, shift);
-
-        write_vec_element(s, tcg_rd, rd, i, size);
-    }
-    tcg_temp_free_i64(tcg_round);
-
-    clear_vec_high(s, is_q, rd);
+    gen_gvec_fn2i(s, is_q, rd, rn, shift, gvec_fn, size);
 }
 
 /* SHL/SLI - Vector shift left */
-- 
2.20.1


