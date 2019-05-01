Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A86DC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F75B2081C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kg37+qqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F75B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36453 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhht-0003YU-5q
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:23:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRi-0006i3-Vl
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRf-000338-BO
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:18 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:35203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRf-00031w-5J
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:15 -0400
Received: by mail-pl1-x635.google.com with SMTP id w24so7779410plp.2
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=GK5T8TUAA6xMhA0uujHB1WR5ozdMZ1Gai/FihBIFRjU=;
	b=Kg37+qqwt23sxxLC25Jlm/8oz42sO90MVD6E1GHCAgXl9sO1mRgIWVC1xMv8VNu7N7
	/cSRxfCml9FK08vib+Y1jKhMFsoxkwdIQhWfQ9eTrSwBkbPcm1m4SRG0+jiev+Jyuib9
	O+hIsZE2zdNMWJyRGiUqIZICS0peybP1BfyQaCpmfaCgmvoK9dTWX5Pyq3CW5xi6n0Cj
	lAMhFtktPvnRLetC5kv2/b8wE3leb2SxnQv1ZQtJFr9VUuij9FP0E6WZp1D9asLfCKu+
	Be++Y1rKc8jHfAoOiQaqVrVTdoQ+rKuQQQ/fiBl42R2qJ3hyw1r/A/xCd4Q8dvyuTppr
	Nuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=GK5T8TUAA6xMhA0uujHB1WR5ozdMZ1Gai/FihBIFRjU=;
	b=eLlQev22D8WPfM5lC5GQ/+0vu0vr2bySnngLLzxL2g6iauEHU3y7pOb3gYy7CYZXC6
	PBf4UJsmoPRtvEyz48nuBvTu8brXxAu/Ug+1gXhzLxQ2hqcoP5DLzXeN9FP/vW3W6atU
	7YU8Plrb6L9a1sz2fuvYxMktQ0iryatorS7WrK2Wl2NRBnkkcZFIyEjnsCde0HFZTWyz
	W/hJPq+OZB5cib6iJ1m83DiV14Mgh4zwRomBkc80n9GcVW1wP2PjXt6/grxnfHdS3a+E
	o/QgBDZe7UwCk0ozwQMPzIzVGxgJRFqXAEa+gKuno7jxq+hXnvjnN0QU0sOM9iUVCuJM
	TTWg==
X-Gm-Message-State: APjAAAW5spYuZj8P1L/YcGhTe9KytZw1eYTXD0bq4coUUSlFUSQvKh8G
	tTz5sWppzgfACIDpXQVdyjmjWjNs2PQ=
X-Google-Smtp-Source: APXvYqy4ZxNNbDqacl3TUVt6zKfIeH++Rqf9QOGXV8pR5Z+AJJnu+2FrKRdgxqD+eNimQaaM+tKK3A==
X-Received: by 2002:a17:902:6bc2:: with SMTP id
	m2mr75115231plt.194.1556687172721; 
	Tue, 30 Apr 2019 22:06:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.06.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:06:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:30 -0700
Message-Id: <20190501050536.15580-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::635
Subject: [Qemu-devel] [PATCH v2 23/29] target/arm: Use tcg_gen_abs_i64 and
 tcg_gen_gvec_abs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501050530.yWor5582txQHnyAjjjfF3OzSPaQj46OGHkAHnr0-j34@z>

Cc: qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  2 --
 target/arm/neon_helper.c   |  5 -----
 target/arm/translate-a64.c | 41 +++++---------------------------------
 target/arm/translate.c     | 11 +++-------
 4 files changed, 8 insertions(+), 51 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 50cb036378..132aa1682e 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -352,8 +352,6 @@ DEF_HELPER_2(neon_ceq_u8, i32, i32, i32)
 DEF_HELPER_2(neon_ceq_u16, i32, i32, i32)
 DEF_HELPER_2(neon_ceq_u32, i32, i32, i32)
 
-DEF_HELPER_1(neon_abs_s8, i32, i32)
-DEF_HELPER_1(neon_abs_s16, i32, i32)
 DEF_HELPER_1(neon_clz_u8, i32, i32)
 DEF_HELPER_1(neon_clz_u16, i32, i32)
 DEF_HELPER_1(neon_cls_s8, i32, i32)
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index ed1c6fc41c..4259056723 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -1228,11 +1228,6 @@ NEON_VOP(ceq_u16, neon_u16, 2)
 NEON_VOP(ceq_u32, neon_u32, 1)
 #undef NEON_FN
 
-#define NEON_FN(dest, src, dummy) dest = (src < 0) ? -src : src
-NEON_VOP1(abs_s8, neon_s8, 4)
-NEON_VOP1(abs_s16, neon_s16, 2)
-#undef NEON_FN
-
 /* Count Leading Sign/Zero Bits.  */
 static inline int do_clz8(uint8_t x)
 {
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9dcc5ff3a3..b7c5a928b4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9468,11 +9468,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         if (u) {
             tcg_gen_neg_i64(tcg_rd, tcg_rn);
         } else {
-            TCGv_i64 tcg_zero = tcg_const_i64(0);
-            tcg_gen_neg_i64(tcg_rd, tcg_rn);
-            tcg_gen_movcond_i64(TCG_COND_GT, tcg_rd, tcg_rn, tcg_zero,
-                                tcg_rn, tcg_rd);
-            tcg_temp_free_i64(tcg_zero);
+            tcg_gen_abs_i64(tcg_rd, tcg_rn);
         }
         break;
     case 0x2f: /* FABS */
@@ -12366,11 +12362,12 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         }
         break;
     case 0xb:
-        if (u) { /* NEG */
+        if (u) { /* ABS, NEG */
             gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_neg, size);
-            return;
+        } else {
+            gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_abs, size);
         }
-        break;
+        return;
     }
 
     if (size == 3) {
@@ -12438,17 +12435,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                         gen_helper_neon_qabs_s32(tcg_res, cpu_env, tcg_op);
                     }
                     break;
-                case 0xb: /* ABS, NEG */
-                    if (u) {
-                        tcg_gen_neg_i32(tcg_res, tcg_op);
-                    } else {
-                        TCGv_i32 tcg_zero = tcg_const_i32(0);
-                        tcg_gen_neg_i32(tcg_res, tcg_op);
-                        tcg_gen_movcond_i32(TCG_COND_GT, tcg_res, tcg_op,
-                                            tcg_zero, tcg_op, tcg_res);
-                        tcg_temp_free_i32(tcg_zero);
-                    }
-                    break;
                 case 0x2f: /* FABS */
                     gen_helper_vfp_abss(tcg_res, tcg_op);
                     break;
@@ -12561,23 +12547,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     tcg_temp_free_i32(tcg_zero);
                     break;
                 }
-                case 0xb: /* ABS, NEG */
-                    if (u) {
-                        TCGv_i32 tcg_zero = tcg_const_i32(0);
-                        if (size) {
-                            gen_helper_neon_sub_u16(tcg_res, tcg_zero, tcg_op);
-                        } else {
-                            gen_helper_neon_sub_u8(tcg_res, tcg_zero, tcg_op);
-                        }
-                        tcg_temp_free_i32(tcg_zero);
-                    } else {
-                        if (size) {
-                            gen_helper_neon_abs_s16(tcg_res, tcg_op);
-                        } else {
-                            gen_helper_neon_abs_s8(tcg_res, tcg_op);
-                        }
-                    }
-                    break;
                 case 0x4: /* CLS, CLZ */
                     if (u) {
                         if (size == 0) {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b25781554f..dd053c80d6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8120,6 +8120,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VNEG:
                     tcg_gen_gvec_neg(size, rd_ofs, rm_ofs, vec_size, vec_size);
                     break;
+                case NEON_2RM_VABS:
+                    tcg_gen_gvec_abs(size, rd_ofs, rm_ofs, vec_size, vec_size);
+                    break;
 
                 default:
                 elementwise:
@@ -8225,14 +8228,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             }
                             tcg_temp_free_i32(tmp2);
                             break;
-                        case NEON_2RM_VABS:
-                            switch(size) {
-                            case 0: gen_helper_neon_abs_s8(tmp, tmp); break;
-                            case 1: gen_helper_neon_abs_s16(tmp, tmp); break;
-                            case 2: tcg_gen_abs_i32(tmp, tmp); break;
-                            default: abort();
-                            }
-                            break;
                         case NEON_2RM_VCGT0_F:
                         {
                             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-- 
2.17.1


