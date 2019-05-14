Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89378C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4156B21655
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+fJ4279"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4156B21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36737 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQL8a-00031P-A7
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:17:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKyF-0001fL-Kj
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxc-0003nx-B3
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:59 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:43862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxX-0003fj-Tn
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:22 -0400
Received: by mail-pg1-x533.google.com with SMTP id t22so7591511pgi.10
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=aOq8R9O0JYe2vR4wE14TCH6+yK72ddx4w9niulf5glk=;
	b=I+fJ42790lAr0n58eQiZSGrwV1sgcAdugkuWGyVDs0aP69M0OjoAh1k9DfWSf1pHVD
	AlixIUjm09Vt4hHEA65lwEjn19ElhQhOpJCNuBqjqaTk5v7ca9TIj7qWxC5EE0ErtwL5
	fAJyikSmlmvlTAyMPk8/Txxa4NNqRoHNeY0KPzyikzZdjx9MeZpEBIuhCBNXca3GZOLv
	zH6jQFi7aD5lrAfVcfRJEXcuhZGEMR3oQoDMnMaOXOR4oletVoeOqlZBfCl+1IHyDElE
	t4UDoOJr/EHJTr/ASA/RbJ3sQ8ezRWaNKRvtrVx757vXi457EgzkcV9NVy1DTLz051NO
	jNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=aOq8R9O0JYe2vR4wE14TCH6+yK72ddx4w9niulf5glk=;
	b=JBP6lcfctY8vdv8VIqUZR+vAg71JqWDjzFJ4IXgWKh1D+ejDzw8soSHW7pZWds7kdl
	KGVvLoklvAJk/RDNh9+19duoKwGJDAxN0cHKBr+i++sLF54+9OMPsM6YAx3oEN4ukmUM
	+uVuIdWtwJtZG6Ufk9eCaLp1y7tgXJ4TaHFv3IS9yf+KQAZmrgi7qBDJo++i4awH5s8l
	PsTksSCQZ+yTeJ27tjOHhOsRSp3uLEPmdAikF8t3UZEL8bAToG37czL8sJh4oLikuz0d
	w0HoxFkBBQ6k9ZIrv+taUN8XVIbcMjJk6jpSrTqsOdj8isOuZRoljEQ2E6NNX6v1RF/c
	2gtA==
X-Gm-Message-State: APjAAAVMOwz7KU6nFOnuUtxaF2jnNtEcKPDt+USwVBSGCEkIOCZU/S9u
	7E6lw0SiF+Hd0P8gA/Zjr+P2h6hGU78=
X-Google-Smtp-Source: APXvYqz0XCcpbh47IH0dgtZExgDc0rXnM3CCnQ4LVRr5BYfsuliB2s5tXkd/lqw1NLR9z+ANkWIDBQ==
X-Received: by 2002:a63:a18:: with SMTP id 24mr34122390pgk.332.1557792374254; 
	Mon, 13 May 2019 17:06:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.06.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:06:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:33 -0700
Message-Id: <20190514000540.4313-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::533
Subject: [Qemu-devel] [PULL 24/31] target/arm: Use tcg_gen_abs_i64 and
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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


