Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF0AC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589492075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzxs8SKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589492075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBasz-0001gy-MO
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBad1-0005Xs-Te
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:33117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBad0-0004PT-3H
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:59 -0400
Received: by mail-wm1-x32f.google.com with SMTP id y8so442366wma.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=V+iLdYVtMr1yrYJY986jy6BRQ42Z4ZUupWGqaHXkinI=;
 b=bzxs8SKf0TlcX9SbM9yNtpWDo4shWWi6qePWBPyiM22n/O8RNErFW5VaYy4l09yYeG
 cOQD/gVSCDqX5ZimIl0j9TbPCFh9TV0pKmNfOLoVZr6Lfcu+UeOy3Lee8mahNvhVjdI9
 7/uFzUEaWh5wSGhQAqUdivh72kdQ/BT3b/debE4HuM1PaRBolfDfQvq9SMCaU8iFIEDl
 uAyrvg5TDzT9Td5G1x+a+KZv0GOlPL+qO4/o4F6QxNTOWSIet9iSE6UXo/JoedajHDiG
 q42MMQ185McftrTOQAmNkF1lY63vrigclrBZ+sEqSALt9c+QfkpKX5SyflmftcVwNSRw
 x/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V+iLdYVtMr1yrYJY986jy6BRQ42Z4ZUupWGqaHXkinI=;
 b=oTXwNkj3tBcCfsBAEQmSQW6PYGqzQ6ax7EbPgZqdX8U64Xi/uP4X52a1MMg9Zl8FlB
 JyLF2Jhb/0XYLzfhPQOYJSvkTXQvzw+8IwXZxDyfo65xLOY0zMJuiUwrK3VkY73I6SRx
 lDTG3JutHyA0yGewfz/AD7aQbzsTSGuqeLNgvNwpHnmzVPJCSJo7I9qpIGC5OOpQnJCu
 acar4OnJf8XBJ2XFqsF82HeDKFBj117FpCVoDf41XfZmaotdwQmdw5fnypKegeYbM4dn
 6dO86MB/krWHde8Pdu5nBA+tfAIKjTb1v7UxtrsBXFENv7lvtxm7lKbiXijGlTxg2NB/
 NKTg==
X-Gm-Message-State: AOAM533QkQ+IgjzCrxcy987nU7JWorxJgwRr4hBNO41QvGEJRglwKcMN
 ZzuEz4gjywPBvVqPmFY3ZzkagbTPTJrIkvNW
X-Google-Smtp-Source: ABdhPJyEVGgbSBnIxjEzHQ0sCyFmBUWHRhnfgAL1sNDnS5SVZfPDag4rOqsk4cDNV+YG83LA4r6AEQ==
X-Received: by 2002:a1c:740c:: with SMTP id p12mr686845wmc.53.1598606696369;
 Fri, 28 Aug 2020 02:24:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/35] target/arm: Convert integer multiply-add (indexed) to
 gvec for aa64 advsimd
Date: Fri, 28 Aug 2020 10:24:12 +0100
Message-Id: <20200828092413.22206-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-20-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        | 14 ++++++++++++++
 target/arm/translate-a64.c | 34 ++++++++++++++++++++++++++++++++++
 target/arm/vec_helper.c    | 25 +++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index d0573a53c80..378bb1898be 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -762,6 +762,20 @@ DEF_HELPER_FLAGS_4(gvec_mul_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_mla_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mla_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mla_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_mls_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mls_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mls_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index abbd6421a28..a50b2f0cb13 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13504,6 +13504,40 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             return;
         }
         break;
+
+    case 0x10: /* MLA */
+        if (!is_long && !is_scalar) {
+            static gen_helper_gvec_4 * const fns[3] = {
+                gen_helper_gvec_mla_idx_h,
+                gen_helper_gvec_mla_idx_s,
+                gen_helper_gvec_mla_idx_d,
+            };
+            tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
+                               vec_full_reg_offset(s, rn),
+                               vec_full_reg_offset(s, rm),
+                               vec_full_reg_offset(s, rd),
+                               is_q ? 16 : 8, vec_full_reg_size(s),
+                               index, fns[size - 1]);
+            return;
+        }
+        break;
+
+    case 0x14: /* MLS */
+        if (!is_long && !is_scalar) {
+            static gen_helper_gvec_4 * const fns[3] = {
+                gen_helper_gvec_mls_idx_h,
+                gen_helper_gvec_mls_idx_s,
+                gen_helper_gvec_mls_idx_d,
+            };
+            tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
+                               vec_full_reg_offset(s, rn),
+                               vec_full_reg_offset(s, rm),
+                               vec_full_reg_offset(s, rd),
+                               is_q ? 16 : 8, vec_full_reg_size(s),
+                               index, fns[size - 1]);
+            return;
+        }
+        break;
     }
 
     if (size == 3) {
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 155b6368cb3..9e93a8a154d 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -731,6 +731,31 @@ DO_MUL_IDX(gvec_mul_idx_d, uint64_t, )
 
 #undef DO_MUL_IDX
 
+#define DO_MLA_IDX(NAME, TYPE, OP, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)   \
+{                                                                          \
+    intptr_t i, j, oprsz = simd_oprsz(desc), segment = 16 / sizeof(TYPE);  \
+    intptr_t idx = simd_data(desc);                                        \
+    TYPE *d = vd, *n = vn, *m = vm, *a = va;                               \
+    for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
+        TYPE mm = m[H(i + idx)];                                           \
+        for (j = 0; j < segment; j++) {                                    \
+            d[i + j] = a[i + j] OP n[i + j] * mm;                          \
+        }                                                                  \
+    }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
+}
+
+DO_MLA_IDX(gvec_mla_idx_h, uint16_t, +, H2)
+DO_MLA_IDX(gvec_mla_idx_s, uint32_t, +, H4)
+DO_MLA_IDX(gvec_mla_idx_d, uint64_t, +,   )
+
+DO_MLA_IDX(gvec_mls_idx_h, uint16_t, -, H2)
+DO_MLA_IDX(gvec_mls_idx_s, uint32_t, -, H4)
+DO_MLA_IDX(gvec_mls_idx_d, uint64_t, -,   )
+
+#undef DO_MLA_IDX
+
 #define DO_FMUL_IDX(NAME, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
-- 
2.20.1


