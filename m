Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2C4C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64DD21479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9VSKeJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64DD21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38319 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkpc-0008BB-6H
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:54:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXI-0000ks-8I
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXD-0000Ix-Sk
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:42 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXB-0008S7-Sn
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:38 -0400
Received: by mail-pf1-x443.google.com with SMTP id y13so3457282pfm.11
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=l9h7+bEChm8+9kEmXTq3lryUpPorB+hViRmREKufQQg=;
	b=B9VSKeJM5LnOPVPo+ZA8NsQ0lHQ+j1NVAHQECvtOMVbo15cUc+h0QV9vcRMfA282rB
	gGHxE/kujNWcCdJCiZLi5deID4dI218HVELp9Sl6nlrU39ffhHFSZYiWle7FNX2CQLNA
	gZHV1iTQzmfrwtkHqCoowMgrrZTQtaacPXRwYOqazjGBTdbiEq+N2BuovzVKFd26XE5I
	mlkX1FtJoiF6oPGkE7oOMXcSAiRgQDImwPNNKuLLTnyiTUFtKHQT+tVUrpgBZ/uwqFbw
	wV/cxGJOG6ACYPxipaH+D0V01VCWhE46FkWkb4PdOdaMccWMVwpGMQqWJr2VoJN+6Pkg
	QGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=l9h7+bEChm8+9kEmXTq3lryUpPorB+hViRmREKufQQg=;
	b=NEVbfXCenUoC3kw0rVzJl14ezhetiSLTSYPFQFQOM6kS/mGmgHvaUOJX0OJwMa/dCU
	ozCkDdhTPVytEPpkeZv6ypGwPzI6MX+u6wvcg3iYDgIpSKji/WdsCRFjLDLAsxA7osdD
	a3z4UDV8HI0ccXxi9j1yxpdwZ+inT+eiwtGgHwlNSQZM+X417bpt8KgfTUumLht2gczg
	Yo6nsE5TelhKsg1fXm4GFlEnosAHaNScQ7WPzj7ccPK9ljwfsLgNa5qR4bCd+ckSiQ1j
	9BRs0342Tf0BObOx9cTjjsXkyGFi6IAeS4jWPCvaUQtDQrpbROQXcmIm+G84tUTElG2c
	6ndg==
X-Gm-Message-State: APjAAAXM4WSSxBgztTw05UFlFBNx1+2P/jvXP7kdmfmbnK6wxVGmJsbH
	lZJQjSXNdmSrrQHhZo2bBSJSg92AEJg=
X-Google-Smtp-Source: APXvYqwRb90uu1jS9CCFQzmVygD2W/VozG126pmwq36wKnhI1QyY2LYoYJw8KQXGFiZPhz+/PaVn5g==
X-Received: by 2002:a62:424f:: with SMTP id p76mr8423430pfa.141.1555745720293; 
	Sat, 20 Apr 2019 00:35:20 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:25 -1000
Message-Id: <20190420073442.7488-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 21/38] target/arm: Use tcg_gen_abs_i64 and
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073425.PSCHH4VxdlzoVmH2-E8IzFNsehDdHvAPRauGihqxK9M@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  2 --
 target/arm/neon_helper.c   |  5 -----
 target/arm/translate-a64.c | 41 +++++---------------------------------
 target/arm/translate.c     | 11 +++-------
 4 files changed, 8 insertions(+), 51 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index a09566f795..3d90b5be66 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -347,8 +347,6 @@ DEF_HELPER_2(neon_ceq_u8, i32, i32, i32)
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
index dcdeb80176..fd8921565e 100644
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
index 721171794d..911ad0bdab 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8031,6 +8031,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VNEG:
                     tcg_gen_gvec_neg(size, rd_ofs, rm_ofs, vec_size, vec_size);
                     break;
+                case NEON_2RM_VABS:
+                    tcg_gen_gvec_abs(size, rd_ofs, rm_ofs, vec_size, vec_size);
+                    break;
 
                 default:
                 elementwise:
@@ -8136,14 +8139,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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


