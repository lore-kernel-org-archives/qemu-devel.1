Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2CEC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A8A21841
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zrlzAy2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A8A21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4x8-0000Fq-Bd
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lR-0006Bh-HC
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:14 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lL-00031U-UZ
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:13 -0400
Received: by mail-pl1-x641.google.com with SMTP id s10so856563plr.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4sAorkUkIPV8aMP4L4OrLvn2nsQGAPk9jrtYSWUqYLI=;
 b=zrlzAy2oDknXRel68oh5VzK5K5leCnKxUil+OHxqnHNEI3ZAnWot1FyU3KHwDRm8I6
 8Fecv230+YVpzYmC5dUg/9l9dptJOJVZ0sj/NlCr3rNbwNdm2wVnHWr2FSpGBEMx4MhT
 U+U5j3vgyQO1Gn54lwTETwpVi1NHKOSR0pbFifNhaV9O66VXhNW/dHxovizZScS6KRpG
 TP6tnttAjyL5cGBkDddGdP/dpkXz6P7Jt3hHiAFGXOqjRCFd19eaiNzaziTzaFknw87t
 d0s5fMb4VkIso3X0dLExbghxki9Zq8bZG4a7nwldBeCuP2lnriDAZA/ESpAYUDkFlp7/
 cTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4sAorkUkIPV8aMP4L4OrLvn2nsQGAPk9jrtYSWUqYLI=;
 b=fCPaanymoMEO9SmQNiG6p4fEDAyLigo6x1WUQV8QL8Y0ktrpOXsbJQniHEUKmsce0K
 WjtUhVCUjLC3ivTPC17Es1cRsOLCc6XEpOd6G7hiCriMs2aU6S5/F6VgjaEZ1kNRigfw
 q3TZaI7DFyY37wkqfdK1XaK7fRS9c3/UNRu2s2EDsXT2n41hNfoXGq2iZaoJ7AoSeHvZ
 QEyUMN9/SwkkuyxO8b/ocNB/7eYNTke3yqAf7qgtmrf50oL+aAKKCY/T7Ip28jFPppfc
 wDRbU7gy2IXVq+vqQOmXx9ysjR+rgsWGPf2pNyiBdYtdvaw0yDopfTW1GhSklIWVOczG
 JUZA==
X-Gm-Message-State: AGi0Pua4i55WEfXLIDL/YHsQPTqyBTCd/vsaiug8w/6n1KWuFtHRz79r
 t8F5NPf0Mqm+by5rkQ2X/J4h+KGBFA8=
X-Google-Smtp-Source: APiQypK4oyfVRCOInkjCCSX2FgSqZ4szeRHaB7/5HKMuLTcKYb+jJbZai6fu5Z3b+P5pWuBkh3suVQ==
X-Received: by 2002:a17:90b:3444:: with SMTP id
 lj4mr6486227pjb.37.1588951086171; 
 Fri, 08 May 2020 08:18:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b5sm2125933pfb.190.2020.05.08.08.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:18:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/19] tcg: Remove movi and dupi opcodes
Date: Fri,  8 May 2020 08:17:42 -0700
Message-Id: <20200508151747.6166-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508151747.6166-1-richard.henderson@linaro.org>
References: <20200508151747.6166-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are now completely covered by mov from a
TYPE_CONST temporary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h        |  3 ---
 tcg/aarch64/tcg-target.inc.c |  3 ---
 tcg/arm/tcg-target.inc.c     |  1 -
 tcg/i386/tcg-target.inc.c    |  3 ---
 tcg/mips/tcg-target.inc.c    |  2 --
 tcg/optimize.c               |  4 ----
 tcg/ppc/tcg-target.inc.c     |  3 ---
 tcg/riscv/tcg-target.inc.c   |  2 --
 tcg/s390/tcg-target.inc.c    |  2 --
 tcg/sparc/tcg-target.inc.c   |  2 --
 tcg/tcg-op-vec.c             |  1 -
 tcg/tcg.c                    | 18 +-----------------
 tcg/tci/tcg-target.inc.c     |  2 --
 13 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 5a941eaa07..d63c6bcb3d 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -45,7 +45,6 @@ DEF(br, 0, 0, 1, TCG_OPF_BB_END)
 DEF(mb, 0, 0, 1, 0)
 
 DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
-DEF(movi_i32, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(movcond_i32, 1, 4, 1, IMPL(TCG_TARGET_HAS_movcond_i32))
 /* load/store */
@@ -110,7 +109,6 @@ DEF(ctz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_ctz_i32))
 DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop_i32))
 
 DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
-DEF(movi_i64, 1, 0, 1, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
 DEF(setcond_i64, 1, 2, 1, IMPL64)
 DEF(movcond_i64, 1, 4, 1, IMPL64 | IMPL(TCG_TARGET_HAS_movcond_i64))
 /* load/store */
@@ -215,7 +213,6 @@ DEF(qemu_st_i64, 0, TLADDR_ARGS + DATA64_ARGS, 1,
 #define IMPLVEC  TCG_OPF_VECTOR | IMPL(TCG_TARGET_MAYBE_vec)
 
 DEF(mov_vec, 1, 1, 0, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
-DEF(dupi_vec, 1, 0, 1, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
 
 DEF(dup_vec, 1, 1, 0, IMPLVEC)
 DEF(dup2_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_REG_BITS == 32))
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 760b0e742d..d065fd600b 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2262,8 +2262,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         g_assert_not_reached();
@@ -2471,7 +2469,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
     default:
         g_assert_not_reached();
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 6aa7757aac..b967499fa4 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -2068,7 +2068,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index ae0228238b..bc957e7bed 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2678,8 +2678,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
@@ -2965,7 +2963,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
     default:
         g_assert_not_reached();
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 4d32ebc1df..09dc5a94fa 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -2155,8 +2155,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
diff --git a/tcg/optimize.c b/tcg/optimize.c
index dd5187be31..9a2c945dbe 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1099,10 +1099,6 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64_VEC(mov):
             tcg_opt_gen_mov(s, op, op->args[0], op->args[1]);
             break;
-        CASE_OP_32_64(movi):
-        case INDEX_op_dupi_vec:
-            tcg_opt_gen_movi(s, &temps_used, op, op->args[0], op->args[1]);
-            break;
 
         case INDEX_op_dup_vec:
             if (arg_is_const(op->args[1])) {
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 7da67086c6..c525439b62 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -2967,8 +2967,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 
     case INDEX_op_mov_i32:   /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32:  /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
@@ -3314,7 +3312,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         return;
 
     case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
     default:
         g_assert_not_reached();
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 2bc0ba71f2..ec609272ad 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1606,8 +1606,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         g_assert_not_reached();
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index b07e9ff7d6..f6b003a700 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -2310,8 +2310,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 65fddb310d..0808b79eee 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -1591,8 +1591,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 0e3e80a612..4681d26973 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -83,7 +83,6 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
         case INDEX_op_xor_vec:
         case INDEX_op_mov_vec:
         case INDEX_op_dup_vec:
-        case INDEX_op_dupi_vec:
         case INDEX_op_dup2_vec:
         case INDEX_op_ld_vec:
         case INDEX_op_st_vec:
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 94f7898317..7a23ccb017 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1463,7 +1463,6 @@ bool tcg_op_supported(TCGOpcode op)
         return TCG_TARGET_HAS_goto_ptr;
 
     case INDEX_op_mov_i32:
-    case INDEX_op_movi_i32:
     case INDEX_op_setcond_i32:
     case INDEX_op_brcond_i32:
     case INDEX_op_ld8u_i32:
@@ -1557,7 +1556,6 @@ bool tcg_op_supported(TCGOpcode op)
         return TCG_TARGET_REG_BITS == 32;
 
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i64:
     case INDEX_op_setcond_i64:
     case INDEX_op_brcond_i64:
     case INDEX_op_ld8u_i64:
@@ -1663,7 +1661,6 @@ bool tcg_op_supported(TCGOpcode op)
 
     case INDEX_op_mov_vec:
     case INDEX_op_dup_vec:
-    case INDEX_op_dupi_vec:
     case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
     case INDEX_op_st_vec:
@@ -3488,7 +3485,7 @@ static void tcg_reg_alloc_bb_end(TCGContext *s, TCGRegSet allocated_regs)
 }
 
 /*
- * Specialized code generation for INDEX_op_movi_*.
+ * Specialized code generation for INDEX_op_mov_* with a constant.
  */
 static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
                                   tcg_target_ulong val, TCGLifeData arg_life,
@@ -3511,14 +3508,6 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
     }
 }
 
-static void tcg_reg_alloc_movi(TCGContext *s, const TCGOp *op)
-{
-    TCGTemp *ots = arg_temp(op->args[0]);
-    tcg_target_ulong val = op->args[1];
-
-    tcg_reg_alloc_do_movi(s, ots, val, op->life, op->output_pref[0]);
-}
-
 /*
  * Specialized code generation for INDEX_op_mov_*.
  */
@@ -4301,11 +4290,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         case INDEX_op_mov_vec:
             tcg_reg_alloc_mov(s, op);
             break;
-        case INDEX_op_movi_i32:
-        case INDEX_op_movi_i64:
-        case INDEX_op_dupi_vec:
-            tcg_reg_alloc_movi(s, op);
-            break;
         case INDEX_op_dup_vec:
             tcg_reg_alloc_dup(s, op);
             break;
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index 1f1639df0d..b796f4fc19 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -815,8 +815,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
         break;
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
-- 
2.20.1


