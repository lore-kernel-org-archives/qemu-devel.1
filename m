Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8277AC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360C1206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nGvOrO9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360C1206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51860 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnsv-0005NR-Dy
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:10:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc6-000845-0b
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc4-0004Yb-PK
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:33 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:45099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnc4-0004XD-JI
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:32 -0400
Received: by mail-pf1-x42b.google.com with SMTP id e24so3956593pfi.12
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=aOq8R9O0JYe2vR4wE14TCH6+yK72ddx4w9niulf5glk=;
	b=nGvOrO9oB3UkPDpmgBzSWrHM+u9KKFatM+TWLiY/+ybybRbKECJ9xSHDqN9Wo1k+HQ
	qK4I6mVURQ1eorIah3m4YXb6uQcr8PbsivYlPCABpvLeQAIrYAO7kkMQS8B/SNT50LBk
	MfdVkHXU+/nyuwrXeIpIRb2WdVVZXcQJuBKSRPinRdCOpxR+Pq6ugrryxVKKOToIFJuW
	b1pGCfeZ4WYVwXT/ecdrSWAkLsP0V9MObNssdN7yPhHdXTT8GALDVf/8VfkhK+Nm5lCU
	fsuDz2zIM8aixkdk/FmgQB/jA3gFOOeEqRZMpNaNS4rM8Rci9IW2pwZffH5/HUFW3nQy
	kgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=aOq8R9O0JYe2vR4wE14TCH6+yK72ddx4w9niulf5glk=;
	b=cPzKTp2R7GOGAiZV/9gRA07pTYqmNZy3OKh4Z8vGcCgAQ66wBeBuxSPSweIJPX4uU8
	g6UfyHEVCJykQnIpvRu+iMJxAmVuSOF3usi5WcjTN19UuIIXVLcv+QnnLFg5k95jSeeZ
	WAJVjat/fYsWgbBDM2M810dJRoT69nUwqWy4fOiXGqKMyEEeC9Aue7KLNknC21wPOJLS
	u7jtzNpur/kehO8WXl/VYN9CHkISmda8lTT0e+vBRfFXM8ApMm+0Rxa47m30oMcpRaVp
	4GOsywren7aqceq+iEKYcQeFvpjJrOtHh8Lubhz9EU9ca3wVATiD5e4xZ8nY+oO9AV+4
	H7Ww==
X-Gm-Message-State: APjAAAUtKrIP4A9kSXVkjMPaE88MupiMY1aypDV3LUDRkKbEt7DkTrTN
	dzUrEL9UNb+l+cM4hvw2CRgocj9oaps=
X-Google-Smtp-Source: APXvYqywmXeLgRudjZUZobs48amjUNQmUD8UoxZlJi6UimIQD8kdMzYGanvgs8sPIMzddbu/CdfmWw==
X-Received: by 2002:a62:2687:: with SMTP id
	m129mr17312979pfm.204.1556949211292; 
	Fri, 03 May 2019 22:53:31 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:53 -0700
Message-Id: <20190504055300.18426-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42b
Subject: [Qemu-devel] [PATCH v3 24/31] target/arm: Use tcg_gen_abs_i64 and
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504055253.hy4ebDzcD-XPvm0G-QbLh7KSKpQxdzBenc0Zela6BG0@z>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


