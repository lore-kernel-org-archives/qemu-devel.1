Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BF5C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED78D206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivrr+fZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED78D206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjxw-00061t-SW
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuO-0008PN-JO
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:43:48 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:40888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuI-0003rU-7H
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:43:48 -0400
Received: by mail-pj1-x1033.google.com with SMTP id gf14so1055423pjb.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C/EyLnqbTRYUDf3q8ozzHANSrPdMQW7zxrYW8UbFQvQ=;
 b=ivrr+fZ2f+4fPFHHGondaB90DGboNLqXX4Be5PpDJsGMK14P60XYtRUYfyCx9jEbNe
 QYq8JyR4yR0HxSEgOFVnfzuiXFd/c2o1ih9Mn6Kd8GMeDwVovXnpAW2i2v6i3HIvH67p
 m+0q6azpf59oCCpbhNVnN49p+XSnJ0yrFMTskUl4N3ydkNS7Vb7kPU8jNDhvHQ5glt9/
 NqMcI6huLo84OHzuzaik9VEqAhmZ2RcMrNJiVzZTbbTrVGhR//s5iaayGnSbPQoLbW2d
 r/E72ytO+MthE9uOl8z9CxqAUBiNHVtbII2e8Qw4iWxP0aXT1hZV4CJCzmncVHUUJxDq
 QCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C/EyLnqbTRYUDf3q8ozzHANSrPdMQW7zxrYW8UbFQvQ=;
 b=qspne+HaCqrGD7lGc10uCX63k0bzD+Hq0wAnTTA0pEgBW7fAqzD0HAriOFHp1/w91W
 fO5HhDhG8DYK9+H6aZqcyPB5gDqEInYVZJd0gCkDiIh06qfKuvxNVqiep2X3iw7wyTsh
 b3Lba0CrBWinCQjpdfJvjYp0IA3zBJhol+hW8V/dBZXcF0r2SG9LVcatmJoeixX9o0fn
 2FQupA2P45LFNsoe6x8jVT4KXTqOm3uTajwM5SHOZ6EIbeQoCB0pgg99AId0nObSfLP4
 enyxX+uzUnslGRXtNjwqIscNdFffLTP6x44kvzT5DeFYxQaSRe0r4xLTbyNy1vYJbbFq
 42rQ==
X-Gm-Message-State: AOAM532XAYo9mK6Af9mzX5cyH9nBCwNyrV28pEo+UG9KmEmtuFTUUQVh
 RVN7zD2lt4QbWxaeW1h+sWOa6sJmKIwag/D/
X-Google-Smtp-Source: ABdhPJx9PZ1Q+kOTkcya6yOSGVTMrMpo7vZZKlji2d2EGEIF6a6cAa83H2VObwu49YSlYCBahmvP0Q==
X-Received: by 2002:a17:90a:a60c:: with SMTP id
 c12mr1933617pjq.1.1599119017281; 
 Thu, 03 Sep 2020 00:43:37 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id o6sm1512472pju.25.2020.09.03.00.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:43:36 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/12] tcg: Fixes dup_const link error
Date: Thu,  3 Sep 2020 15:43:04 +0800
Message-Id: <20200903074313.1498-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903074313.1498-1-luoyonggang@gmail.com>
References: <20200903074313.1498-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1033.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename function dup_const to dup_const_eval for avoid confliction with macr=
o dup_const

The link error on msys2

Linking target qemu-system-alpha.exe
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe: libqemu-alpha-softmmu.fa.p/tcg_optimize=
.c.obj: in function `tcg_optimize':
E:\CI-Cor-Ready\xemu\qemu-build/../qemu.org/tcg/optimize.c:1106: undefined =
reference to `dup_const'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe: libqemu-alpha-softmmu.fa.p/tcg_tcg-op-v=
ec.c.obj: in function `tcg_gen_dupi_vec':
E:\CI-Cor-Ready\xemu\qemu-build/../qemu.org/tcg/tcg-op-vec.c:283: undefined=
 reference to `dup_const'
collect2.exe: error: ld returned 1 exit status

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/tcg/tcg.h | 2898 +++++++++----------
 tcg/tcg-op-gvec.c | 7012 ++++++++++++++++++++++-----------------------
 2 files changed, 4955 insertions(+), 4955 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 53ce94c2c5..7f6fe8454b 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1,1449 +1,1449 @@
-/*
- * Tiny Code Generator for QEMU
- *
- * Copyright (c) 2008 Fabrice Bellard
- *
- * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
- * of this software and associated documentation files (the "Software"), t=
o deal
- * in the Software without restriction, including without limitation the r=
ights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included=
 in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
- * THE SOFTWARE.
- */
-
-#ifndef TCG_H
-#define TCG_H
-
-#include "cpu.h"
-#include "exec/memop.h"
-#include "exec/tb-context.h"
-#include "qemu/bitops.h"
-#include "qemu/plugin.h"
-#include "qemu/queue.h"
-#include "tcg/tcg-mo.h"
-#include "tcg-target.h"
-#include "qemu/int128.h"
-
-/* XXX: make safe guess about sizes */
-#define MAX_OP_PER_INSTR 266
-
-#if HOST_LONG_BITS =3D=3D 32
-#define MAX_OPC_PARAM_PER_ARG 2
-#else
-#define MAX_OPC_PARAM_PER_ARG 1
-#endif
-#define MAX_OPC_PARAM_IARGS 6
-#define MAX_OPC_PARAM_OARGS 1
-#define MAX_OPC_PARAM_ARGS (MAX_OPC_PARAM_IARGS + MAX_OPC_PARAM_OARGS)
-
-/* A Call op needs up to 4 + 2N parameters on 32-bit archs,
- * and up to 4 + N parameters on 64-bit archs
- * (N =3D number of input arguments + output arguments).  */
-#define MAX_OPC_PARAM (4 + (MAX_OPC_PARAM_PER_ARG * MAX_OPC_PARAM_ARGS))
-
-#define CPU_TEMP_BUF_NLONGS 128
-
-/* Default target word size to pointer size.  */
-#ifndef TCG_TARGET_REG_BITS
-# if UINTPTR_MAX =3D=3D UINT32_MAX
-#  define TCG_TARGET_REG_BITS 32
-# elif UINTPTR_MAX =3D=3D UINT64_MAX
-#  define TCG_TARGET_REG_BITS 64
-# else
-#  error Unknown pointer size for tcg target
-# endif
-#endif
-
-#if TCG_TARGET_REG_BITS =3D=3D 32
-typedef int32_t tcg_target_long;
-typedef uint32_t tcg_target_ulong;
-#define TCG_PRIlx PRIx32
-#define TCG_PRIld PRId32
-#elif TCG_TARGET_REG_BITS =3D=3D 64
-typedef int64_t tcg_target_long;
-typedef uint64_t tcg_target_ulong;
-#define TCG_PRIlx PRIx64
-#define TCG_PRIld PRId64
-#else
-#error unsupported
-#endif
-
-/* Oversized TCG guests make things like MTTCG hard
- * as we can't use atomics for cputlb updates.
- */
-#if TARGET_LONG_BITS > TCG_TARGET_REG_BITS
-#define TCG_OVERSIZED_GUEST 1
-#else
-#define TCG_OVERSIZED_GUEST 0
-#endif
-
-#if TCG_TARGET_NB_REGS <=3D 32
-typedef uint32_t TCGRegSet;
-#elif TCG_TARGET_NB_REGS <=3D 64
-typedef uint64_t TCGRegSet;
-#else
-#error unsupported
-#endif
-
-#if TCG_TARGET_REG_BITS =3D=3D 32
-/* Turn some undef macros into false macros.  */
-#define TCG_TARGET_HAS_extrl_i64_i32    0
-#define TCG_TARGET_HAS_extrh_i64_i32    0
-#define TCG_TARGET_HAS_div_i64          0
-#define TCG_TARGET_HAS_rem_i64          0
-#define TCG_TARGET_HAS_div2_i64         0
-#define TCG_TARGET_HAS_rot_i64          0
-#define TCG_TARGET_HAS_ext8s_i64        0
-#define TCG_TARGET_HAS_ext16s_i64       0
-#define TCG_TARGET_HAS_ext32s_i64       0
-#define TCG_TARGET_HAS_ext8u_i64        0
-#define TCG_TARGET_HAS_ext16u_i64       0
-#define TCG_TARGET_HAS_ext32u_i64       0
-#define TCG_TARGET_HAS_bswap16_i64      0
-#define TCG_TARGET_HAS_bswap32_i64      0
-#define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_neg_i64          0
-#define TCG_TARGET_HAS_not_i64          0
-#define TCG_TARGET_HAS_andc_i64         0
-#define TCG_TARGET_HAS_orc_i64          0
-#define TCG_TARGET_HAS_eqv_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          0
-#define TCG_TARGET_HAS_clz_i64          0
-#define TCG_TARGET_HAS_ctz_i64          0
-#define TCG_TARGET_HAS_ctpop_i64        0
-#define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      0
-#define TCG_TARGET_HAS_sextract_i64     0
-#define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_movcond_i64      0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        0
-/* Turn some undef macros into true macros.  */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
-#endif
-
-#ifndef TCG_TARGET_deposit_i32_valid
-#define TCG_TARGET_deposit_i32_valid(ofs, len) 1
-#endif
-#ifndef TCG_TARGET_deposit_i64_valid
-#define TCG_TARGET_deposit_i64_valid(ofs, len) 1
-#endif
-#ifndef TCG_TARGET_extract_i32_valid
-#define TCG_TARGET_extract_i32_valid(ofs, len) 1
-#endif
-#ifndef TCG_TARGET_extract_i64_valid
-#define TCG_TARGET_extract_i64_valid(ofs, len) 1
-#endif
-
-/* Only one of DIV or DIV2 should be defined.  */
-#if defined(TCG_TARGET_HAS_div_i32)
-#define TCG_TARGET_HAS_div2_i32         0
-#elif defined(TCG_TARGET_HAS_div2_i32)
-#define TCG_TARGET_HAS_div_i32          0
-#define TCG_TARGET_HAS_rem_i32          0
-#endif
-#if defined(TCG_TARGET_HAS_div_i64)
-#define TCG_TARGET_HAS_div2_i64         0
-#elif defined(TCG_TARGET_HAS_div2_i64)
-#define TCG_TARGET_HAS_div_i64          0
-#define TCG_TARGET_HAS_rem_i64          0
-#endif
-
-/* For 32-bit targets, some sort of unsigned widening multiply is required=
.  */
-#if TCG_TARGET_REG_BITS =3D=3D 32 \
-    && !(defined(TCG_TARGET_HAS_mulu2_i32) \
-         || defined(TCG_TARGET_HAS_muluh_i32))
-# error "Missing unsigned widening multiply"
-#endif
-
-#if !defined(TCG_TARGET_HAS_v64) \
-    && !defined(TCG_TARGET_HAS_v128) \
-    && !defined(TCG_TARGET_HAS_v256)
-#define TCG_TARGET_MAYBE_vec            0
-#define TCG_TARGET_HAS_abs_vec          0
-#define TCG_TARGET_HAS_neg_vec          0
-#define TCG_TARGET_HAS_not_vec          0
-#define TCG_TARGET_HAS_andc_vec         0
-#define TCG_TARGET_HAS_orc_vec          0
-#define TCG_TARGET_HAS_roti_vec         0
-#define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         0
-#define TCG_TARGET_HAS_shi_vec          0
-#define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
-#define TCG_TARGET_HAS_mul_vec          0
-#define TCG_TARGET_HAS_sat_vec          0
-#define TCG_TARGET_HAS_minmax_vec       0
-#define TCG_TARGET_HAS_bitsel_vec       0
-#define TCG_TARGET_HAS_cmpsel_vec       0
-#else
-#define TCG_TARGET_MAYBE_vec            1
-#endif
-#ifndef TCG_TARGET_HAS_v64
-#define TCG_TARGET_HAS_v64              0
-#endif
-#ifndef TCG_TARGET_HAS_v128
-#define TCG_TARGET_HAS_v128             0
-#endif
-#ifndef TCG_TARGET_HAS_v256
-#define TCG_TARGET_HAS_v256             0
-#endif
-
-#ifndef TARGET_INSN_START_EXTRA_WORDS
-# define TARGET_INSN_START_WORDS 1
-#else
-# define TARGET_INSN_START_WORDS (1 + TARGET_INSN_START_EXTRA_WORDS)
-#endif
-
-typedef enum TCGOpcode {
-#define DEF(name, oargs, iargs, cargs, flags) INDEX_op_ ## name,
-#include "tcg/tcg-opc.h"
-#undef DEF
-    NB_OPS,
-} TCGOpcode;
-
-#define tcg_regset_set_reg(d, r)   ((d) |=3D (TCGRegSet)1 << (r))
-#define tcg_regset_reset_reg(d, r) ((d) &=3D ~((TCGRegSet)1 << (r)))
-#define tcg_regset_test_reg(d, r)  (((d) >> (r)) & 1)
-
-#ifndef TCG_TARGET_INSN_UNIT_SIZE
-# error "Missing TCG_TARGET_INSN_UNIT_SIZE"
-#elif TCG_TARGET_INSN_UNIT_SIZE =3D=3D 1
-typedef uint8_t tcg_insn_unit;
-#elif TCG_TARGET_INSN_UNIT_SIZE =3D=3D 2
-typedef uint16_t tcg_insn_unit;
-#elif TCG_TARGET_INSN_UNIT_SIZE =3D=3D 4
-typedef uint32_t tcg_insn_unit;
-#elif TCG_TARGET_INSN_UNIT_SIZE =3D=3D 8
-typedef uint64_t tcg_insn_unit;
-#else
-/* The port better have done this.  */
-#endif
-
-
-#if defined CONFIG_DEBUG_TCG || defined QEMU_STATIC_ANALYSIS
-# define tcg_debug_assert(X) do { assert(X); } while (0)
-#else
-# define tcg_debug_assert(X) \
-    do { if (!(X)) { __builtin_unreachable(); } } while (0)
-#endif
-
-typedef struct TCGRelocation TCGRelocation;
-struct TCGRelocation {
-    QSIMPLEQ_ENTRY(TCGRelocation) next;
-    tcg_insn_unit *ptr;
-    intptr_t addend;
-    int type;
-};
-
-typedef struct TCGLabel TCGLabel;
-struct TCGLabel {
-    unsigned present : 1;
-    unsigned has_value : 1;
-    unsigned id : 14;
-    unsigned refs : 16;
-    union {
-        uintptr_t value;
-        tcg_insn_unit *value_ptr;
-    } u;
-    QSIMPLEQ_HEAD(, TCGRelocation) relocs;
-    QSIMPLEQ_ENTRY(TCGLabel) next;
-};
-
-typedef struct TCGPool {
-    struct TCGPool *next;
-    int size;
-    uint8_t data[] __attribute__ ((aligned));
-} TCGPool;
-
-#define TCG_POOL_CHUNK_SIZE 32768
-
-#define TCG_MAX_TEMPS 512
-#define TCG_MAX_INSNS 512
-
-/* when the size of the arguments of a called function is smaller than
-   this value, they are statically allocated in the TB stack frame */
-#define TCG_STATIC_CALL_ARGS_SIZE 128
-
-typedef enum TCGType {
-    TCG_TYPE_I32,
-    TCG_TYPE_I64,
-
-    TCG_TYPE_V64,
-    TCG_TYPE_V128,
-    TCG_TYPE_V256,
-
-    TCG_TYPE_COUNT, /* number of different types */
-
-    /* An alias for the size of the host register.  */
-#if TCG_TARGET_REG_BITS =3D=3D 32
-    TCG_TYPE_REG =3D TCG_TYPE_I32,
-#else
-    TCG_TYPE_REG =3D TCG_TYPE_I64,
-#endif
-
-    /* An alias for the size of the native pointer.  */
-#if UINTPTR_MAX =3D=3D UINT32_MAX
-    TCG_TYPE_PTR =3D TCG_TYPE_I32,
-#else
-    TCG_TYPE_PTR =3D TCG_TYPE_I64,
-#endif
-
-    /* An alias for the size of the target "long", aka register.  */
-#if TARGET_LONG_BITS =3D=3D 64
-    TCG_TYPE_TL =3D TCG_TYPE_I64,
-#else
-    TCG_TYPE_TL =3D TCG_TYPE_I32,
-#endif
-} TCGType;
-
-/**
- * get_alignment_bits
- * @memop: MemOp value
- *
- * Extract the alignment size from the memop.
- */
-static inline unsigned get_alignment_bits(MemOp memop)
-{
-    unsigned a =3D memop & MO_AMASK;
-
-    if (a =3D=3D MO_UNALN) {
-        /* No alignment required.  */
-        a =3D 0;
-    } else if (a =3D=3D MO_ALIGN) {
-        /* A natural alignment requirement.  */
-        a =3D memop & MO_SIZE;
-    } else {
-        /* A specific alignment requirement.  */
-        a =3D a >> MO_ASHIFT;
-    }
-#if defined(CONFIG_SOFTMMU)
-    /* The requested alignment cannot overlap the TLB flags.  */
-    tcg_debug_assert((TLB_FLAGS_MASK & ((1 << a) - 1)) =3D=3D 0);
-#endif
-    return a;
-}
-
-typedef tcg_target_ulong TCGArg;
-
-/* Define type and accessor macros for TCG variables.
-
-   TCG variables are the inputs and outputs of TCG ops, as described
-   in tcg/README. Target CPU front-end code uses these types to deal
-   with TCG variables as it emits TCG code via the tcg_gen_* functions.
-   They come in several flavours:
-    * TCGv_i32 : 32 bit integer type
-    * TCGv_i64 : 64 bit integer type
-    * TCGv_ptr : a host pointer type
-    * TCGv_vec : a host vector type; the exact size is not exposed
-                 to the CPU front-end code.
-    * TCGv : an integer type the same size as target_ulong
-             (an alias for either TCGv_i32 or TCGv_i64)
-   The compiler's type checking will complain if you mix them
-   up and pass the wrong sized TCGv to a function.
-
-   Users of tcg_gen_* don't need to know about any of the internal
-   details of these, and should treat them as opaque types.
-   You won't be able to look inside them in a debugger either.
-
-   Internal implementation details follow:
-
-   Note that there is no definition of the structs TCGv_i32_d etc anywhere.
-   This is deliberate, because the values we store in variables of type
-   TCGv_i32 are not really pointers-to-structures. They're just small
-   integers, but keeping them in pointer types like this means that the
-   compiler will complain if you accidentally pass a TCGv_i32 to a
-   function which takes a TCGv_i64, and so on. Only the internals of
-   TCG need to care about the actual contents of the types.  */
-
-typedef struct TCGv_i32_d *TCGv_i32;
-typedef struct TCGv_i64_d *TCGv_i64;
-typedef struct TCGv_ptr_d *TCGv_ptr;
-typedef struct TCGv_vec_d *TCGv_vec;
-typedef TCGv_ptr TCGv_env;
-#if TARGET_LONG_BITS =3D=3D 32
-#define TCGv TCGv_i32
-#elif TARGET_LONG_BITS =3D=3D 64
-#define TCGv TCGv_i64
-#else
-#error Unhandled TARGET_LONG_BITS value
-#endif
-
-/* call flags */
-/* Helper does not read globals (either directly or through an exception).=
 It
-   implies TCG_CALL_NO_WRITE_GLOBALS. */
-#define TCG_CALL_NO_READ_GLOBALS    0x0001
-/* Helper does not write globals */
-#define TCG_CALL_NO_WRITE_GLOBALS   0x0002
-/* Helper can be safely suppressed if the return value is not used. */
-#define TCG_CALL_NO_SIDE_EFFECTS    0x0004
-/* Helper is QEMU_NORETURN.  */
-#define TCG_CALL_NO_RETURN          0x0008
-
-/* convenience version of most used call flags */
-#define TCG_CALL_NO_RWG         TCG_CALL_NO_READ_GLOBALS
-#define TCG_CALL_NO_WG          TCG_CALL_NO_WRITE_GLOBALS
-#define TCG_CALL_NO_SE          TCG_CALL_NO_SIDE_EFFECTS
-#define TCG_CALL_NO_RWG_SE      (TCG_CALL_NO_RWG | TCG_CALL_NO_SE)
-#define TCG_CALL_NO_WG_SE       (TCG_CALL_NO_WG | TCG_CALL_NO_SE)
-
-/* Used to align parameters.  See the comment before tcgv_i32_temp.  */
-#define TCG_CALL_DUMMY_ARG      ((TCGArg)0)
-
-/* Conditions.  Note that these are laid out for easy manipulation by
-   the functions below:
-     bit 0 is used for inverting;
-     bit 1 is signed,
-     bit 2 is unsigned,
-     bit 3 is used with bit 0 for swapping signed/unsigned.  */
-typedef enum {
-    /* non-signed */
-    TCG_COND_NEVER  =3D 0 | 0 | 0 | 0,
-    TCG_COND_ALWAYS =3D 0 | 0 | 0 | 1,
-    TCG_COND_EQ     =3D 8 | 0 | 0 | 0,
-    TCG_COND_NE     =3D 8 | 0 | 0 | 1,
-    /* signed */
-    TCG_COND_LT     =3D 0 | 0 | 2 | 0,
-    TCG_COND_GE     =3D 0 | 0 | 2 | 1,
-    TCG_COND_LE     =3D 8 | 0 | 2 | 0,
-    TCG_COND_GT     =3D 8 | 0 | 2 | 1,
-    /* unsigned */
-    TCG_COND_LTU    =3D 0 | 4 | 0 | 0,
-    TCG_COND_GEU    =3D 0 | 4 | 0 | 1,
-    TCG_COND_LEU    =3D 8 | 4 | 0 | 0,
-    TCG_COND_GTU    =3D 8 | 4 | 0 | 1,
-} TCGCond;
-
-/* Invert the sense of the comparison.  */
-static inline TCGCond tcg_invert_cond(TCGCond c)
-{
-    return (TCGCond)(c ^ 1);
-}
-
-/* Swap the operands in a comparison.  */
-static inline TCGCond tcg_swap_cond(TCGCond c)
-{
-    return c & 6 ? (TCGCond)(c ^ 9) : c;
-}
-
-/* Create an "unsigned" version of a "signed" comparison.  */
-static inline TCGCond tcg_unsigned_cond(TCGCond c)
-{
-    return c & 2 ? (TCGCond)(c ^ 6) : c;
-}
-
-/* Create a "signed" version of an "unsigned" comparison.  */
-static inline TCGCond tcg_signed_cond(TCGCond c)
-{
-    return c & 4 ? (TCGCond)(c ^ 6) : c;
-}
-
-/* Must a comparison be considered unsigned?  */
-static inline bool is_unsigned_cond(TCGCond c)
-{
-    return (c & 4) !=3D 0;
-}
-
-/* Create a "high" version of a double-word comparison.
-   This removes equality from a LTE or GTE comparison.  */
-static inline TCGCond tcg_high_cond(TCGCond c)
-{
-    switch (c) {
-    case TCG_COND_GE:
-    case TCG_COND_LE:
-    case TCG_COND_GEU:
-    case TCG_COND_LEU:
-        return (TCGCond)(c ^ 8);
-    default:
-        return c;
-    }
-}
-
-typedef enum TCGTempVal {
-    TEMP_VAL_DEAD,
-    TEMP_VAL_REG,
-    TEMP_VAL_MEM,
-    TEMP_VAL_CONST,
-} TCGTempVal;
-
-typedef struct TCGTemp {
-    TCGReg reg:8;
-    TCGTempVal val_type:8;
-    TCGType base_type:8;
-    TCGType type:8;
-    unsigned int fixed_reg:1;
-    unsigned int indirect_reg:1;
-    unsigned int indirect_base:1;
-    unsigned int mem_coherent:1;
-    unsigned int mem_allocated:1;
-    /* If true, the temp is saved across both basic blocks and
-       translation blocks.  */
-    unsigned int temp_global:1;
-    /* If true, the temp is saved across basic blocks but dead
-       at the end of translation blocks.  If false, the temp is
-       dead at the end of basic blocks.  */
-    unsigned int temp_local:1;
-    unsigned int temp_allocated:1;
-
-    tcg_target_long val;
-    struct TCGTemp *mem_base;
-    intptr_t mem_offset;
-    const char *name;
-
-    /* Pass-specific information that can be stored for a temporary.
-       One word worth of integer data, and one pointer to data
-       allocated separately.  */
-    uintptr_t state;
-    void *state_ptr;
-} TCGTemp;
-
-typedef struct TCGContext TCGContext;
-
-typedef struct TCGTempSet {
-    unsigned long l[BITS_TO_LONGS(TCG_MAX_TEMPS)];
-} TCGTempSet;
-
-/* While we limit helpers to 6 arguments, for 32-bit hosts, with padding,
-   this imples a max of 6*2 (64-bit in) + 2 (64-bit out) =3D 14 operands.
-   There are never more than 2 outputs, which means that we can store all
-   dead + sync data within 16 bits.  */
-#define DEAD_ARG  4
-#define SYNC_ARG  1
-typedef uint16_t TCGLifeData;
-
-/* The layout here is designed to avoid a bitfield crossing of
-   a 32-bit boundary, which would cause GCC to add extra padding.  */
-typedef struct TCGOp {
-    TCGOpcode opc   : 8;        /*  8 */
-
-    /* Parameters for this opcode.  See below.  */
-    unsigned param1 : 4;        /* 12 */
-    unsigned param2 : 4;        /* 16 */
-
-    /* Lifetime data of the operands.  */
-    unsigned life   : 16;       /* 32 */
-
-    /* Next and previous opcodes.  */
-    QTAILQ_ENTRY(TCGOp) link;
-#ifdef CONFIG_PLUGIN
-    QSIMPLEQ_ENTRY(TCGOp) plugin_link;
-#endif
-
-    /* Arguments for the opcode.  */
-    TCGArg args[MAX_OPC_PARAM];
-
-    /* Register preferences for the output(s).  */
-    TCGRegSet output_pref[2];
-} TCGOp;
-
-#define TCGOP_CALLI(X)    (X)->param1
-#define TCGOP_CALLO(X)    (X)->param2
-
-#define TCGOP_VECL(X)     (X)->param1
-#define TCGOP_VECE(X)     (X)->param2
-
-/* Make sure operands fit in the bitfields above.  */
-QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
-
-typedef struct TCGProfile {
-    int64_t cpu_exec_time;
-    int64_t tb_count1;
-    int64_t tb_count;
-    int64_t op_count; /* total insn count */
-    int op_count_max; /* max insn per TB */
-    int temp_count_max;
-    int64_t temp_count;
-    int64_t del_op_count;
-    int64_t code_in_len;
-    int64_t code_out_len;
-    int64_t search_out_len;
-    int64_t interm_time;
-    int64_t code_time;
-    int64_t la_time;
-    int64_t opt_time;
-    int64_t restore_count;
-    int64_t restore_time;
-    int64_t table_op_count[NB_OPS];
-} TCGProfile;
-
-struct TCGContext {
-    uint8_t *pool_cur, *pool_end;
-    TCGPool *pool_first, *pool_current, *pool_first_large;
-    int nb_labels;
-    int nb_globals;
-    int nb_temps;
-    int nb_indirects;
-    int nb_ops;
-
-    /* goto_tb support */
-    tcg_insn_unit *code_buf;
-    uint16_t *tb_jmp_reset_offset; /* tb->jmp_reset_offset */
-    uintptr_t *tb_jmp_insn_offset; /* tb->jmp_target_arg if direct_jump */
-    uintptr_t *tb_jmp_target_addr; /* tb->jmp_target_arg if !direct_jump */
-
-    TCGRegSet reserved_regs;
-    uint32_t tb_cflags; /* cflags of the current TB */
-    intptr_t current_frame_offset;
-    intptr_t frame_start;
-    intptr_t frame_end;
-    TCGTemp *frame_temp;
-
-    tcg_insn_unit *code_ptr;
-
-#ifdef CONFIG_PROFILER
-    TCGProfile prof;
-#endif
-
-#ifdef CONFIG_DEBUG_TCG
-    int temps_in_use;
-    int goto_tb_issue_mask;
-    const TCGOpcode *vecop_list;
-#endif
-
-    /* Code generation.  Note that we specifically do not use tcg_insn_unit
-       here, because there's too much arithmetic throughout that relies
-       on addition and subtraction working on bytes.  Rely on the GCC
-       extension that allows arithmetic on void*.  */
-    void *code_gen_prologue;
-    void *code_gen_epilogue;
-    void *code_gen_buffer;
-    size_t code_gen_buffer_size;
-    void *code_gen_ptr;
-    void *data_gen_ptr;
-
-    /* Threshold to flush the translated code buffer.  */
-    void *code_gen_highwater;
-
-    size_t tb_phys_invalidate_count;
-
-    /* Track which vCPU triggers events */
-    CPUState *cpu;                      /* *_trans */
-
-    /* These structures are private to tcg-target.c.inc.  */
-#ifdef TCG_TARGET_NEED_LDST_LABELS
-    QSIMPLEQ_HEAD(, TCGLabelQemuLdst) ldst_labels;
-#endif
-#ifdef TCG_TARGET_NEED_POOL_LABELS
-    struct TCGLabelPoolData *pool_labels;
-#endif
-
-    TCGLabel *exitreq_label;
-
-#ifdef CONFIG_PLUGIN
-    /*
-     * We keep one plugin_tb struct per TCGContext. Note that on every TB
-     * translation we clear but do not free its contents; this way we
-     * avoid a lot of malloc/free churn, since after a few TB's it's
-     * unlikely that we'll need to allocate either more instructions or mo=
re
-     * space for instructions (for variable-instruction-length ISAs).
-     */
-    struct qemu_plugin_tb *plugin_tb;
-
-    /* descriptor of the instruction being translated */
-    struct qemu_plugin_insn *plugin_insn;
-
-    /* list to quickly access the injected ops */
-    QSIMPLEQ_HEAD(, TCGOp) plugin_ops;
-#endif
-
-    TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
-    TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
-
-    QTAILQ_HEAD(, TCGOp) ops, free_ops;
-    QSIMPLEQ_HEAD(, TCGLabel) labels;
-
-    /* Tells which temporary holds a given register.
-       It does not take into account fixed registers */
-    TCGTemp *reg_to_temp[TCG_TARGET_NB_REGS];
-
-    uint16_t gen_insn_end_off[TCG_MAX_INSNS];
-    target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
-};
-
-extern TCGContext tcg_init_ctx;
-extern __thread TCGContext *tcg_ctx;
-extern TCGv_env cpu_env;
-
-static inline size_t temp_idx(TCGTemp *ts)
-{
-    ptrdiff_t n =3D ts - tcg_ctx->temps;
-    tcg_debug_assert(n >=3D 0 && n < tcg_ctx->nb_temps);
-    return n;
-}
-
-static inline TCGArg temp_arg(TCGTemp *ts)
-{
-    return (uintptr_t)ts;
-}
-
-static inline TCGTemp *arg_temp(TCGArg a)
-{
-    return (TCGTemp *)(uintptr_t)a;
-}
-
-/* Using the offset of a temporary, relative to TCGContext, rather than
-   its index means that we don't use 0.  That leaves offset 0 free for
-   a NULL representation without having to leave index 0 unused.  */
-static inline TCGTemp *tcgv_i32_temp(TCGv_i32 v)
-{
-    uintptr_t o =3D (uintptr_t)v;
-    TCGTemp *t =3D (void *)tcg_ctx + o;
-    tcg_debug_assert(offsetof(TCGContext, temps[temp_idx(t)]) =3D=3D o);
-    return t;
-}
-
-static inline TCGTemp *tcgv_i64_temp(TCGv_i64 v)
-{
-    return tcgv_i32_temp((TCGv_i32)v);
-}
-
-static inline TCGTemp *tcgv_ptr_temp(TCGv_ptr v)
-{
-    return tcgv_i32_temp((TCGv_i32)v);
-}
-
-static inline TCGTemp *tcgv_vec_temp(TCGv_vec v)
-{
-    return tcgv_i32_temp((TCGv_i32)v);
-}
-
-static inline TCGArg tcgv_i32_arg(TCGv_i32 v)
-{
-    return temp_arg(tcgv_i32_temp(v));
-}
-
-static inline TCGArg tcgv_i64_arg(TCGv_i64 v)
-{
-    return temp_arg(tcgv_i64_temp(v));
-}
-
-static inline TCGArg tcgv_ptr_arg(TCGv_ptr v)
-{
-    return temp_arg(tcgv_ptr_temp(v));
-}
-
-static inline TCGArg tcgv_vec_arg(TCGv_vec v)
-{
-    return temp_arg(tcgv_vec_temp(v));
-}
-
-static inline TCGv_i32 temp_tcgv_i32(TCGTemp *t)
-{
-    (void)temp_idx(t); /* trigger embedded assert */
-    return (TCGv_i32)((void *)t - (void *)tcg_ctx);
-}
-
-static inline TCGv_i64 temp_tcgv_i64(TCGTemp *t)
-{
-    return (TCGv_i64)temp_tcgv_i32(t);
-}
-
-static inline TCGv_ptr temp_tcgv_ptr(TCGTemp *t)
-{
-    return (TCGv_ptr)temp_tcgv_i32(t);
-}
-
-static inline TCGv_vec temp_tcgv_vec(TCGTemp *t)
-{
-    return (TCGv_vec)temp_tcgv_i32(t);
-}
-
-#if TCG_TARGET_REG_BITS =3D=3D 32
-static inline TCGv_i32 TCGV_LOW(TCGv_i64 t)
-{
-    return temp_tcgv_i32(tcgv_i64_temp(t));
-}
-
-static inline TCGv_i32 TCGV_HIGH(TCGv_i64 t)
-{
-    return temp_tcgv_i32(tcgv_i64_temp(t) + 1);
-}
-#endif
-
-static inline TCGArg tcg_get_insn_param(TCGOp *op, int arg)
-{
-    return op->args[arg];
-}
-
-static inline void tcg_set_insn_param(TCGOp *op, int arg, TCGArg v)
-{
-    op->args[arg] =3D v;
-}
-
-static inline target_ulong tcg_get_insn_start_param(TCGOp *op, int arg)
-{
-#if TARGET_LONG_BITS <=3D TCG_TARGET_REG_BITS
-    return tcg_get_insn_param(op, arg);
-#else
-    return tcg_get_insn_param(op, arg * 2) |
-           ((uint64_t)tcg_get_insn_param(op, arg * 2 + 1) << 32);
-#endif
-}
-
-static inline void tcg_set_insn_start_param(TCGOp *op, int arg, target_ulo=
ng v)
-{
-#if TARGET_LONG_BITS <=3D TCG_TARGET_REG_BITS
-    tcg_set_insn_param(op, arg, v);
-#else
-    tcg_set_insn_param(op, arg * 2, v);
-    tcg_set_insn_param(op, arg * 2 + 1, v >> 32);
-#endif
-}
-
-/* The last op that was emitted.  */
-static inline TCGOp *tcg_last_op(void)
-{
-    return QTAILQ_LAST(&tcg_ctx->ops);
-}
-
-/* Test for whether to terminate the TB for using too many opcodes.  */
-static inline bool tcg_op_buf_full(void)
-{
-    /* This is not a hard limit, it merely stops translation when
-     * we have produced "enough" opcodes.  We want to limit TB size
-     * such that a RISC host can reasonably use a 16-bit signed
-     * branch within the TB.  We also need to be mindful of the
-     * 16-bit unsigned offsets, TranslationBlock.jmp_reset_offset[]
-     * and TCGContext.gen_insn_end_off[].
-     */
-    return tcg_ctx->nb_ops >=3D 4000;
-}
-
-/* pool based memory allocation */
-
-/* user-mode: mmap_lock must be held for tcg_malloc_internal. */
-void *tcg_malloc_internal(TCGContext *s, int size);
-void tcg_pool_reset(TCGContext *s);
-TranslationBlock *tcg_tb_alloc(TCGContext *s);
-
-void tcg_region_init(void);
-void tb_destroy(TranslationBlock *tb);
-void tcg_region_reset_all(void);
-
-size_t tcg_code_size(void);
-size_t tcg_code_capacity(void);
-
-void tcg_tb_insert(TranslationBlock *tb);
-void tcg_tb_remove(TranslationBlock *tb);
-size_t tcg_tb_phys_invalidate_count(void);
-TranslationBlock *tcg_tb_lookup(uintptr_t tc_ptr);
-void tcg_tb_foreach(GTraverseFunc func, gpointer user_data);
-size_t tcg_nb_tbs(void);
-
-/* user-mode: Called with mmap_lock held.  */
-static inline void *tcg_malloc(int size)
-{
-    TCGContext *s =3D tcg_ctx;
-    uint8_t *ptr, *ptr_end;
-
-    /* ??? This is a weak placeholder for minimum malloc alignment.  */
-    size =3D QEMU_ALIGN_UP(size, 8);
-
-    ptr =3D s->pool_cur;
-    ptr_end =3D ptr + size;
-    if (unlikely(ptr_end > s->pool_end)) {
-        return tcg_malloc_internal(tcg_ctx, size);
-    } else {
-        s->pool_cur =3D ptr_end;
-        return ptr;
-    }
-}
-
-void tcg_context_init(TCGContext *s);
-void tcg_register_thread(void);
-void tcg_prologue_init(TCGContext *s);
-void tcg_func_start(TCGContext *s);
-
-int tcg_gen_code(TCGContext *s, TranslationBlock *tb);
-
-void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t siz=
e);
-
-TCGTemp *tcg_global_mem_new_internal(TCGType, TCGv_ptr,
-                                     intptr_t, const char *);
-TCGTemp *tcg_temp_new_internal(TCGType, bool);
-void tcg_temp_free_internal(TCGTemp *);
-TCGv_vec tcg_temp_new_vec(TCGType type);
-TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
-
-static inline void tcg_temp_free_i32(TCGv_i32 arg)
-{
-    tcg_temp_free_internal(tcgv_i32_temp(arg));
-}
-
-static inline void tcg_temp_free_i64(TCGv_i64 arg)
-{
-    tcg_temp_free_internal(tcgv_i64_temp(arg));
-}
-
-static inline void tcg_temp_free_ptr(TCGv_ptr arg)
-{
-    tcg_temp_free_internal(tcgv_ptr_temp(arg));
-}
-
-static inline void tcg_temp_free_vec(TCGv_vec arg)
-{
-    tcg_temp_free_internal(tcgv_vec_temp(arg));
-}
-
-static inline TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t offse=
t,
-                                              const char *name)
-{
-    TCGTemp *t =3D tcg_global_mem_new_internal(TCG_TYPE_I32, reg, offset, =
name);
-    return temp_tcgv_i32(t);
-}
-
-static inline TCGv_i32 tcg_temp_new_i32(void)
-{
-    TCGTemp *t =3D tcg_temp_new_internal(TCG_TYPE_I32, false);
-    return temp_tcgv_i32(t);
-}
-
-static inline TCGv_i32 tcg_temp_local_new_i32(void)
-{
-    TCGTemp *t =3D tcg_temp_new_internal(TCG_TYPE_I32, true);
-    return temp_tcgv_i32(t);
-}
-
-static inline TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t offse=
t,
-                                              const char *name)
-{
-    TCGTemp *t =3D tcg_global_mem_new_internal(TCG_TYPE_I64, reg, offset, =
name);
-    return temp_tcgv_i64(t);
-}
-
-static inline TCGv_i64 tcg_temp_new_i64(void)
-{
-    TCGTemp *t =3D tcg_temp_new_internal(TCG_TYPE_I64, false);
-    return temp_tcgv_i64(t);
-}
-
-static inline TCGv_i64 tcg_temp_local_new_i64(void)
-{
-    TCGTemp *t =3D tcg_temp_new_internal(TCG_TYPE_I64, true);
-    return temp_tcgv_i64(t);
-}
-
-static inline TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t offse=
t,
-                                              const char *name)
-{
-    TCGTemp *t =3D tcg_global_mem_new_internal(TCG_TYPE_PTR, reg, offset, =
name);
-    return temp_tcgv_ptr(t);
-}
-
-static inline TCGv_ptr tcg_temp_new_ptr(void)
-{
-    TCGTemp *t =3D tcg_temp_new_internal(TCG_TYPE_PTR, false);
-    return temp_tcgv_ptr(t);
-}
-
-static inline TCGv_ptr tcg_temp_local_new_ptr(void)
-{
-    TCGTemp *t =3D tcg_temp_new_internal(TCG_TYPE_PTR, true);
-    return temp_tcgv_ptr(t);
-}
-
-#if defined(CONFIG_DEBUG_TCG)
-/* If you call tcg_clear_temp_count() at the start of a section of
- * code which is not supposed to leak any TCG temporaries, then
- * calling tcg_check_temp_count() at the end of the section will
- * return 1 if the section did in fact leak a temporary.
- */
-void tcg_clear_temp_count(void);
-int tcg_check_temp_count(void);
-#else
-#define tcg_clear_temp_count() do { } while (0)
-#define tcg_check_temp_count() 0
-#endif
-
-int64_t tcg_cpu_exec_time(void);
-void tcg_dump_info(void);
-void tcg_dump_op_count(void);
-
-#define TCG_CT_ALIAS  0x80
-#define TCG_CT_IALIAS 0x40
-#define TCG_CT_NEWREG 0x20 /* output requires a new register */
-#define TCG_CT_REG    0x01
-#define TCG_CT_CONST  0x02 /* any constant of register size */
-
-typedef struct TCGArgConstraint {
-    uint16_t ct;
-    uint8_t alias_index;
-    union {
-        TCGRegSet regs;
-    } u;
-} TCGArgConstraint;
-
-#define TCG_MAX_OP_ARGS 16
-
-/* Bits for TCGOpDef->flags, 8 bits available.  */
-enum {
-    /* Instruction exits the translation block.  */
-    TCG_OPF_BB_EXIT      =3D 0x01,
-    /* Instruction defines the end of a basic block.  */
-    TCG_OPF_BB_END       =3D 0x02,
-    /* Instruction clobbers call registers and potentially update globals.=
  */
-    TCG_OPF_CALL_CLOBBER =3D 0x04,
-    /* Instruction has side effects: it cannot be removed if its outputs
-       are not used, and might trigger exceptions.  */
-    TCG_OPF_SIDE_EFFECTS =3D 0x08,
-    /* Instruction operands are 64-bits (otherwise 32-bits).  */
-    TCG_OPF_64BIT        =3D 0x10,
-    /* Instruction is optional and not implemented by the host, or insn
-       is generic and should not be implemened by the host.  */
-    TCG_OPF_NOT_PRESENT  =3D 0x20,
-    /* Instruction operands are vectors.  */
-    TCG_OPF_VECTOR       =3D 0x40,
-};
-
-typedef struct TCGOpDef {
-    const char *name;
-    uint8_t nb_oargs, nb_iargs, nb_cargs, nb_args;
-    uint8_t flags;
-    TCGArgConstraint *args_ct;
-    int *sorted_args;
-#if defined(CONFIG_DEBUG_TCG)
-    int used;
-#endif
-} TCGOpDef;
-
-extern TCGOpDef tcg_op_defs[];
-extern const size_t tcg_op_defs_max;
-
-typedef struct TCGTargetOpDef {
-    TCGOpcode op;
-    const char *args_ct_str[TCG_MAX_OP_ARGS];
-} TCGTargetOpDef;
-
-#define tcg_abort() \
-do {\
-    fprintf(stderr, "%s:%d: tcg fatal error\n", __FILE__, __LINE__);\
-    abort();\
-} while (0)
-
-bool tcg_op_supported(TCGOpcode op);
-
-void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args);
-
-TCGOp *tcg_emit_op(TCGOpcode opc);
-void tcg_op_remove(TCGContext *s, TCGOp *op);
-TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op, TCGOpcode opc);
-TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op, TCGOpcode opc);
-
-void tcg_optimize(TCGContext *s);
-
-TCGv_i32 tcg_const_i32(int32_t val);
-TCGv_i64 tcg_const_i64(int64_t val);
-TCGv_i32 tcg_const_local_i32(int32_t val);
-TCGv_i64 tcg_const_local_i64(int64_t val);
-TCGv_vec tcg_const_zeros_vec(TCGType);
-TCGv_vec tcg_const_ones_vec(TCGType);
-TCGv_vec tcg_const_zeros_vec_matching(TCGv_vec);
-TCGv_vec tcg_const_ones_vec_matching(TCGv_vec);
-
-#if UINTPTR_MAX =3D=3D UINT32_MAX
-# define tcg_const_ptr(x)        ((TCGv_ptr)tcg_const_i32((intptr_t)(x)))
-# define tcg_const_local_ptr(x)  ((TCGv_ptr)tcg_const_local_i32((intptr_t)=
(x)))
-#else
-# define tcg_const_ptr(x)        ((TCGv_ptr)tcg_const_i64((intptr_t)(x)))
-# define tcg_const_local_ptr(x)  ((TCGv_ptr)tcg_const_local_i64((intptr_t)=
(x)))
-#endif
-
-TCGLabel *gen_new_label(void);
-
-/**
- * label_arg
- * @l: label
- *
- * Encode a label for storage in the TCG opcode stream.
- */
-
-static inline TCGArg label_arg(TCGLabel *l)
-{
-    return (uintptr_t)l;
-}
-
-/**
- * arg_label
- * @i: value
- *
- * The opposite of label_arg.  Retrieve a label from the
- * encoding of the TCG opcode stream.
- */
-
-static inline TCGLabel *arg_label(TCGArg i)
-{
-    return (TCGLabel *)(uintptr_t)i;
-}
-
-/**
- * tcg_ptr_byte_diff
- * @a, @b: addresses to be differenced
- *
- * There are many places within the TCG backends where we need a byte
- * difference between two pointers.  While this can be accomplished
- * with local casting, it's easy to get wrong -- especially if one is
- * concerned with the signedness of the result.
- *
- * This version relies on GCC's void pointer arithmetic to get the
- * correct result.
- */
-
-static inline ptrdiff_t tcg_ptr_byte_diff(void *a, void *b)
-{
-    return a - b;
-}
-
-/**
- * tcg_pcrel_diff
- * @s: the tcg context
- * @target: address of the target
- *
- * Produce a pc-relative difference, from the current code_ptr
- * to the destination address.
- */
-
-static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, void *target)
-{
-    return tcg_ptr_byte_diff(target, s->code_ptr);
-}
-
-/**
- * tcg_current_code_size
- * @s: the tcg context
- *
- * Compute the current code size within the translation block.
- * This is used to fill in qemu's data structures for goto_tb.
- */
-
-static inline size_t tcg_current_code_size(TCGContext *s)
-{
-    return tcg_ptr_byte_diff(s->code_ptr, s->code_buf);
-}
-
-/* Combine the MemOp and mmu_idx parameters into a single value.  */
-typedef uint32_t TCGMemOpIdx;
-
-/**
- * make_memop_idx
- * @op: memory operation
- * @idx: mmu index
- *
- * Encode these values into a single parameter.
- */
-static inline TCGMemOpIdx make_memop_idx(MemOp op, unsigned idx)
-{
-    tcg_debug_assert(idx <=3D 15);
-    return (op << 4) | idx;
-}
-
-/**
- * get_memop
- * @oi: combined op/idx parameter
- *
- * Extract the memory operation from the combined value.
- */
-static inline MemOp get_memop(TCGMemOpIdx oi)
-{
-    return oi >> 4;
-}
-
-/**
- * get_mmuidx
- * @oi: combined op/idx parameter
- *
- * Extract the mmu index from the combined value.
- */
-static inline unsigned get_mmuidx(TCGMemOpIdx oi)
-{
-    return oi & 15;
-}
-
-/**
- * tcg_qemu_tb_exec:
- * @env: pointer to CPUArchState for the CPU
- * @tb_ptr: address of generated code for the TB to execute
- *
- * Start executing code from a given translation block.
- * Where translation blocks have been linked, execution
- * may proceed from the given TB into successive ones.
- * Control eventually returns only when some action is needed
- * from the top-level loop: either control must pass to a TB
- * which has not yet been directly linked, or an asynchronous
- * event such as an interrupt needs handling.
- *
- * Return: The return value is the value passed to the corresponding
- * tcg_gen_exit_tb() at translation time of the last TB attempted to execu=
te.
- * The value is either zero or a 4-byte aligned pointer to that TB combined
- * with additional information in its two least significant bits. The
- * additional information is encoded as follows:
- *  0, 1: the link between this TB and the next is via the specified
- *        TB index (0 or 1). That is, we left the TB via (the equivalent
- *        of) "goto_tb <index>". The main loop uses this to determine
- *        how to link the TB just executed to the next.
- *  2:    we are using instruction counting code generation, and we
- *        did not start executing this TB because the instruction counter
- *        would hit zero midway through it. In this case the pointer
- *        returned is the TB we were about to execute, and the caller must
- *        arrange to execute the remaining count of instructions.
- *  3:    we stopped because the CPU's exit_request flag was set
- *        (usually meaning that there is an interrupt that needs to be
- *        handled). The pointer returned is the TB we were about to execute
- *        when we noticed the pending exit request.
- *
- * If the bottom two bits indicate an exit-via-index then the CPU
- * state is correctly synchronised and ready for execution of the next
- * TB (and in particular the guest PC is the address to execute next).
- * Otherwise, we gave up on execution of this TB before it started, and
- * the caller must fix up the CPU state by calling the CPU's
- * synchronize_from_tb() method with the TB pointer we return (falling
- * back to calling the CPU's set_pc method with tb->pb if no
- * synchronize_from_tb() method exists).
- *
- * Note that TCG targets may use a different definition of tcg_qemu_tb_exec
- * to this default (which just calls the prologue.code emitted by
- * tcg_target_qemu_prologue()).
- */
-#define TB_EXIT_MASK      3
-#define TB_EXIT_IDX0      0
-#define TB_EXIT_IDX1      1
-#define TB_EXIT_IDXMAX    1
-#define TB_EXIT_REQUESTED 3
-
-#ifdef HAVE_TCG_QEMU_TB_EXEC
-uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr);
-#else
-# define tcg_qemu_tb_exec(env, tb_ptr) \
-    ((uintptr_t (*)(void *, void *))tcg_ctx->code_gen_prologue)(env, tb_pt=
r)
-#endif
-
-void tcg_register_jit(void *buf, size_t buf_size);
-
-#if TCG_TARGET_MAYBE_vec
-/* Return zero if the tuple (opc, type, vece) is unsupportable;
-   return > 0 if it is directly supportable;
-   return < 0 if we must call tcg_expand_vec_op.  */
-int tcg_can_emit_vec_op(TCGOpcode, TCGType, unsigned);
-#else
-static inline int tcg_can_emit_vec_op(TCGOpcode o, TCGType t, unsigned ve)
-{
-    return 0;
-}
-#endif
-
-/* Expand the tuple (opc, type, vece) on the given arguments.  */
-void tcg_expand_vec_op(TCGOpcode, TCGType, unsigned, TCGArg, ...);
-
-/* Replicate a constant C accoring to the log2 of the element size.  */
-uint64_t dup_const(unsigned vece, uint64_t c);
-
-#define dup_const(VECE, C)                                         \
-    (__builtin_constant_p(VECE)                                    \
-     ? (  (VECE) =3D=3D MO_8  ? 0x0101010101010101ull * (uint8_t)(C)   \
-        : (VECE) =3D=3D MO_16 ? 0x0001000100010001ull * (uint16_t)(C)  \
-        : (VECE) =3D=3D MO_32 ? 0x0000000100000001ull * (uint32_t)(C)  \
-        : dup_const(VECE, C))                                      \
-     : dup_const(VECE, C))
-
-
-/*
- * Memory helpers that will be used by TCG generated code.
- */
-#ifdef CONFIG_SOFTMMU
-/* Value zero-extended to tcg register size.  */
-tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
-                                     TCGMemOpIdx oi, uintptr_t retaddr);
-tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,
-                                    TCGMemOpIdx oi, uintptr_t retaddr);
-tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
-                                    TCGMemOpIdx oi, uintptr_t retaddr);
-uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr,
-                           TCGMemOpIdx oi, uintptr_t retaddr);
-tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,
-                                    TCGMemOpIdx oi, uintptr_t retaddr);
-tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
-                                    TCGMemOpIdx oi, uintptr_t retaddr);
-uint64_t helper_be_ldq_mmu(CPUArchState *env, target_ulong addr,
-                           TCGMemOpIdx oi, uintptr_t retaddr);
-
-/* Value sign-extended to tcg register size.  */
-tcg_target_ulong helper_ret_ldsb_mmu(CPUArchState *env, target_ulong addr,
-                                     TCGMemOpIdx oi, uintptr_t retaddr);
-tcg_target_ulong helper_le_ldsw_mmu(CPUArchState *env, target_ulong addr,
-                                    TCGMemOpIdx oi, uintptr_t retaddr);
-tcg_target_ulong helper_le_ldsl_mmu(CPUArchState *env, target_ulong addr,
-                                    TCGMemOpIdx oi, uintptr_t retaddr);
-tcg_target_ulong helper_be_ldsw_mmu(CPUArchState *env, target_ulong addr,
-                                    TCGMemOpIdx oi, uintptr_t retaddr);
-tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
-                                    TCGMemOpIdx oi, uintptr_t retaddr);
-
-void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
-                        TCGMemOpIdx oi, uintptr_t retaddr);
-void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
-                       TCGMemOpIdx oi, uintptr_t retaddr);
-void helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
-                       TCGMemOpIdx oi, uintptr_t retaddr);
-void helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
-                       TCGMemOpIdx oi, uintptr_t retaddr);
-void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
-                       TCGMemOpIdx oi, uintptr_t retaddr);
-void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
-                       TCGMemOpIdx oi, uintptr_t retaddr);
-void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
-                       TCGMemOpIdx oi, uintptr_t retaddr);
-
-/* Temporary aliases until backends are converted.  */
-#ifdef TARGET_WORDS_BIGENDIAN
-# define helper_ret_ldsw_mmu  helper_be_ldsw_mmu
-# define helper_ret_lduw_mmu  helper_be_lduw_mmu
-# define helper_ret_ldsl_mmu  helper_be_ldsl_mmu
-# define helper_ret_ldul_mmu  helper_be_ldul_mmu
-# define helper_ret_ldl_mmu   helper_be_ldul_mmu
-# define helper_ret_ldq_mmu   helper_be_ldq_mmu
-# define helper_ret_stw_mmu   helper_be_stw_mmu
-# define helper_ret_stl_mmu   helper_be_stl_mmu
-# define helper_ret_stq_mmu   helper_be_stq_mmu
-#else
-# define helper_ret_ldsw_mmu  helper_le_ldsw_mmu
-# define helper_ret_lduw_mmu  helper_le_lduw_mmu
-# define helper_ret_ldsl_mmu  helper_le_ldsl_mmu
-# define helper_ret_ldul_mmu  helper_le_ldul_mmu
-# define helper_ret_ldl_mmu   helper_le_ldul_mmu
-# define helper_ret_ldq_mmu   helper_le_ldq_mmu
-# define helper_ret_stw_mmu   helper_le_stw_mmu
-# define helper_ret_stl_mmu   helper_le_stl_mmu
-# define helper_ret_stq_mmu   helper_le_stq_mmu
-#endif
-
-uint32_t helper_atomic_cmpxchgb_mmu(CPUArchState *env, target_ulong addr,
-                                    uint32_t cmpv, uint32_t newv,
-                                    TCGMemOpIdx oi, uintptr_t retaddr);
-uint32_t helper_atomic_cmpxchgw_le_mmu(CPUArchState *env, target_ulong add=
r,
-                                       uint32_t cmpv, uint32_t newv,
-                                       TCGMemOpIdx oi, uintptr_t retaddr);
-uint32_t helper_atomic_cmpxchgl_le_mmu(CPUArchState *env, target_ulong add=
r,
-                                       uint32_t cmpv, uint32_t newv,
-                                       TCGMemOpIdx oi, uintptr_t retaddr);
-uint64_t helper_atomic_cmpxchgq_le_mmu(CPUArchState *env, target_ulong add=
r,
-                                       uint64_t cmpv, uint64_t newv,
-                                       TCGMemOpIdx oi, uintptr_t retaddr);
-uint32_t helper_atomic_cmpxchgw_be_mmu(CPUArchState *env, target_ulong add=
r,
-                                       uint32_t cmpv, uint32_t newv,
-                                       TCGMemOpIdx oi, uintptr_t retaddr);
-uint32_t helper_atomic_cmpxchgl_be_mmu(CPUArchState *env, target_ulong add=
r,
-                                       uint32_t cmpv, uint32_t newv,
-                                       TCGMemOpIdx oi, uintptr_t retaddr);
-uint64_t helper_atomic_cmpxchgq_be_mmu(CPUArchState *env, target_ulong add=
r,
-                                       uint64_t cmpv, uint64_t newv,
-                                       TCGMemOpIdx oi, uintptr_t retaddr);
-
-#define GEN_ATOMIC_HELPER(NAME, TYPE, SUFFIX)         \
-TYPE helper_atomic_ ## NAME ## SUFFIX ## _mmu         \
-    (CPUArchState *env, target_ulong addr, TYPE val,  \
-     TCGMemOpIdx oi, uintptr_t retaddr);
-
-#ifdef CONFIG_ATOMIC64
-#define GEN_ATOMIC_HELPER_ALL(NAME)          \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)  \
-    GEN_ATOMIC_HELPER(NAME, uint64_t, q_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint64_t, q_be)
-#else
-#define GEN_ATOMIC_HELPER_ALL(NAME)          \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)
-#endif
-
-GEN_ATOMIC_HELPER_ALL(fetch_add)
-GEN_ATOMIC_HELPER_ALL(fetch_sub)
-GEN_ATOMIC_HELPER_ALL(fetch_and)
-GEN_ATOMIC_HELPER_ALL(fetch_or)
-GEN_ATOMIC_HELPER_ALL(fetch_xor)
-GEN_ATOMIC_HELPER_ALL(fetch_smin)
-GEN_ATOMIC_HELPER_ALL(fetch_umin)
-GEN_ATOMIC_HELPER_ALL(fetch_smax)
-GEN_ATOMIC_HELPER_ALL(fetch_umax)
-
-GEN_ATOMIC_HELPER_ALL(add_fetch)
-GEN_ATOMIC_HELPER_ALL(sub_fetch)
-GEN_ATOMIC_HELPER_ALL(and_fetch)
-GEN_ATOMIC_HELPER_ALL(or_fetch)
-GEN_ATOMIC_HELPER_ALL(xor_fetch)
-GEN_ATOMIC_HELPER_ALL(smin_fetch)
-GEN_ATOMIC_HELPER_ALL(umin_fetch)
-GEN_ATOMIC_HELPER_ALL(smax_fetch)
-GEN_ATOMIC_HELPER_ALL(umax_fetch)
-
-GEN_ATOMIC_HELPER_ALL(xchg)
-
-#undef GEN_ATOMIC_HELPER_ALL
-#undef GEN_ATOMIC_HELPER
-#endif /* CONFIG_SOFTMMU */
-
-/*
- * These aren't really a "proper" helpers because TCG cannot manage Int128.
- * However, use the same format as the others, for use by the backends.
- *
- * The cmpxchg functions are only defined if HAVE_CMPXCHG128;
- * the ld/st functions are only defined if HAVE_ATOMIC128,
- * as defined by <qemu/atomic128.h>.
- */
-Int128 helper_atomic_cmpxchgo_le_mmu(CPUArchState *env, target_ulong addr,
-                                     Int128 cmpv, Int128 newv,
-                                     TCGMemOpIdx oi, uintptr_t retaddr);
-Int128 helper_atomic_cmpxchgo_be_mmu(CPUArchState *env, target_ulong addr,
-                                     Int128 cmpv, Int128 newv,
-                                     TCGMemOpIdx oi, uintptr_t retaddr);
-
-Int128 helper_atomic_ldo_le_mmu(CPUArchState *env, target_ulong addr,
-                                TCGMemOpIdx oi, uintptr_t retaddr);
-Int128 helper_atomic_ldo_be_mmu(CPUArchState *env, target_ulong addr,
-                                TCGMemOpIdx oi, uintptr_t retaddr);
-void helper_atomic_sto_le_mmu(CPUArchState *env, target_ulong addr, Int128=
 val,
-                              TCGMemOpIdx oi, uintptr_t retaddr);
-void helper_atomic_sto_be_mmu(CPUArchState *env, target_ulong addr, Int128=
 val,
-                              TCGMemOpIdx oi, uintptr_t retaddr);
-
-#ifdef CONFIG_DEBUG_TCG
-void tcg_assert_listed_vecop(TCGOpcode);
-#else
-static inline void tcg_assert_listed_vecop(TCGOpcode op) { }
-#endif
-
-static inline const TCGOpcode *tcg_swap_vecop_list(const TCGOpcode *n)
-{
-#ifdef CONFIG_DEBUG_TCG
-    const TCGOpcode *o =3D tcg_ctx->vecop_list;
-    tcg_ctx->vecop_list =3D n;
-    return o;
-#else
-    return NULL;
-#endif
-}
-
-bool tcg_can_emit_vecop_list(const TCGOpcode *, TCGType, unsigned);
-
-#endif /* TCG_H */
+/*=0D
+ * Tiny Code Generator for QEMU=0D
+ *=0D
+ * Copyright (c) 2008 Fabrice Bellard=0D
+ *=0D
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy=0D
+ * of this software and associated documentation files (the "Software"), t=
o deal=0D
+ * in the Software without restriction, including without limitation the r=
ights=0D
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll=0D
+ * copies of the Software, and to permit persons to whom the Software is=0D
+ * furnished to do so, subject to the following conditions:=0D
+ *=0D
+ * The above copyright notice and this permission notice shall be included=
 in=0D
+ * all copies or substantial portions of the Software.=0D
+ *=0D
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR=0D
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,=0D
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
=0D
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER=0D
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,=0D
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN=0D
+ * THE SOFTWARE.=0D
+ */=0D
+=0D
+#ifndef TCG_H=0D
+#define TCG_H=0D
+=0D
+#include "cpu.h"=0D
+#include "exec/memop.h"=0D
+#include "exec/tb-context.h"=0D
+#include "qemu/bitops.h"=0D
+#include "qemu/plugin.h"=0D
+#include "qemu/queue.h"=0D
+#include "tcg/tcg-mo.h"=0D
+#include "tcg-target.h"=0D
+#include "qemu/int128.h"=0D
+=0D
+/* XXX: make safe guess about sizes */=0D
+#define MAX_OP_PER_INSTR 266=0D
+=0D
+#if HOST_LONG_BITS =3D=3D 32=0D
+#define MAX_OPC_PARAM_PER_ARG 2=0D
+#else=0D
+#define MAX_OPC_PARAM_PER_ARG 1=0D
+#endif=0D
+#define MAX_OPC_PARAM_IARGS 6=0D
+#define MAX_OPC_PARAM_OARGS 1=0D
+#define MAX_OPC_PARAM_ARGS (MAX_OPC_PARAM_IARGS + MAX_OPC_PARAM_OARGS)=0D
+=0D
+/* A Call op needs up to 4 + 2N parameters on 32-bit archs,=0D
+ * and up to 4 + N parameters on 64-bit archs=0D
+ * (N =3D number of input arguments + output arguments).  */=0D
+#define MAX_OPC_PARAM (4 + (MAX_OPC_PARAM_PER_ARG * MAX_OPC_PARAM_ARGS))=0D
+=0D
+#define CPU_TEMP_BUF_NLONGS 128=0D
+=0D
+/* Default target word size to pointer size.  */=0D
+#ifndef TCG_TARGET_REG_BITS=0D
+# if UINTPTR_MAX =3D=3D UINT32_MAX=0D
+#  define TCG_TARGET_REG_BITS 32=0D
+# elif UINTPTR_MAX =3D=3D UINT64_MAX=0D
+#  define TCG_TARGET_REG_BITS 64=0D
+# else=0D
+#  error Unknown pointer size for tcg target=0D
+# endif=0D
+#endif=0D
+=0D
+#if TCG_TARGET_REG_BITS =3D=3D 32=0D
+typedef int32_t tcg_target_long;=0D
+typedef uint32_t tcg_target_ulong;=0D
+#define TCG_PRIlx PRIx32=0D
+#define TCG_PRIld PRId32=0D
+#elif TCG_TARGET_REG_BITS =3D=3D 64=0D
+typedef int64_t tcg_target_long;=0D
+typedef uint64_t tcg_target_ulong;=0D
+#define TCG_PRIlx PRIx64=0D
+#define TCG_PRIld PRId64=0D
+#else=0D
+#error unsupported=0D
+#endif=0D
+=0D
+/* Oversized TCG guests make things like MTTCG hard=0D
+ * as we can't use atomics for cputlb updates.=0D
+ */=0D
+#if TARGET_LONG_BITS > TCG_TARGET_REG_BITS=0D
+#define TCG_OVERSIZED_GUEST 1=0D
+#else=0D
+#define TCG_OVERSIZED_GUEST 0=0D
+#endif=0D
+=0D
+#if TCG_TARGET_NB_REGS <=3D 32=0D
+typedef uint32_t TCGRegSet;=0D
+#elif TCG_TARGET_NB_REGS <=3D 64=0D
+typedef uint64_t TCGRegSet;=0D
+#else=0D
+#error unsupported=0D
+#endif=0D
+=0D
+#if TCG_TARGET_REG_BITS =3D=3D 32=0D
+/* Turn some undef macros into false macros.  */=0D
+#define TCG_TARGET_HAS_extrl_i64_i32    0=0D
+#define TCG_TARGET_HAS_extrh_i64_i32    0=0D
+#define TCG_TARGET_HAS_div_i64          0=0D
+#define TCG_TARGET_HAS_rem_i64          0=0D
+#define TCG_TARGET_HAS_div2_i64         0=0D
+#define TCG_TARGET_HAS_rot_i64          0=0D
+#define TCG_TARGET_HAS_ext8s_i64        0=0D
+#define TCG_TARGET_HAS_ext16s_i64       0=0D
+#define TCG_TARGET_HAS_ext32s_i64       0=0D
+#define TCG_TARGET_HAS_ext8u_i64        0=0D
+#define TCG_TARGET_HAS_ext16u_i64       0=0D
+#define TCG_TARGET_HAS_ext32u_i64       0=0D
+#define TCG_TARGET_HAS_bswap16_i64      0=0D
+#define TCG_TARGET_HAS_bswap32_i64      0=0D
+#define TCG_TARGET_HAS_bswap64_i64      0=0D
+#define TCG_TARGET_HAS_neg_i64          0=0D
+#define TCG_TARGET_HAS_not_i64          0=0D
+#define TCG_TARGET_HAS_andc_i64         0=0D
+#define TCG_TARGET_HAS_orc_i64          0=0D
+#define TCG_TARGET_HAS_eqv_i64          0=0D
+#define TCG_TARGET_HAS_nand_i64         0=0D
+#define TCG_TARGET_HAS_nor_i64          0=0D
+#define TCG_TARGET_HAS_clz_i64          0=0D
+#define TCG_TARGET_HAS_ctz_i64          0=0D
+#define TCG_TARGET_HAS_ctpop_i64        0=0D
+#define TCG_TARGET_HAS_deposit_i64      0=0D
+#define TCG_TARGET_HAS_extract_i64      0=0D
+#define TCG_TARGET_HAS_sextract_i64     0=0D
+#define TCG_TARGET_HAS_extract2_i64     0=0D
+#define TCG_TARGET_HAS_movcond_i64      0=0D
+#define TCG_TARGET_HAS_add2_i64         0=0D
+#define TCG_TARGET_HAS_sub2_i64         0=0D
+#define TCG_TARGET_HAS_mulu2_i64        0=0D
+#define TCG_TARGET_HAS_muls2_i64        0=0D
+#define TCG_TARGET_HAS_muluh_i64        0=0D
+#define TCG_TARGET_HAS_mulsh_i64        0=0D
+/* Turn some undef macros into true macros.  */=0D
+#define TCG_TARGET_HAS_add2_i32         1=0D
+#define TCG_TARGET_HAS_sub2_i32         1=0D
+#endif=0D
+=0D
+#ifndef TCG_TARGET_deposit_i32_valid=0D
+#define TCG_TARGET_deposit_i32_valid(ofs, len) 1=0D
+#endif=0D
+#ifndef TCG_TARGET_deposit_i64_valid=0D
+#define TCG_TARGET_deposit_i64_valid(ofs, len) 1=0D
+#endif=0D
+#ifndef TCG_TARGET_extract_i32_valid=0D
+#define TCG_TARGET_extract_i32_valid(ofs, len) 1=0D
+#endif=0D
+#ifndef TCG_TARGET_extract_i64_valid=0D
+#define TCG_TARGET_extract_i64_valid(ofs, len) 1=0D
+#endif=0D
+=0D
+/* Only one of DIV or DIV2 should be defined.  */=0D
+#if defined(TCG_TARGET_HAS_div_i32)=0D
+#define TCG_TARGET_HAS_div2_i32         0=0D
+#elif defined(TCG_TARGET_HAS_div2_i32)=0D
+#define TCG_TARGET_HAS_div_i32          0=0D
+#define TCG_TARGET_HAS_rem_i32          0=0D
+#endif=0D
+#if defined(TCG_TARGET_HAS_div_i64)=0D
+#define TCG_TARGET_HAS_div2_i64         0=0D
+#elif defined(TCG_TARGET_HAS_div2_i64)=0D
+#define TCG_TARGET_HAS_div_i64          0=0D
+#define TCG_TARGET_HAS_rem_i64          0=0D
+#endif=0D
+=0D
+/* For 32-bit targets, some sort of unsigned widening multiply is required=
.  */=0D
+#if TCG_TARGET_REG_BITS =3D=3D 32 \=0D
+    && !(defined(TCG_TARGET_HAS_mulu2_i32) \=0D
+         || defined(TCG_TARGET_HAS_muluh_i32))=0D
+# error "Missing unsigned widening multiply"=0D
+#endif=0D
+=0D
+#if !defined(TCG_TARGET_HAS_v64) \=0D
+    && !defined(TCG_TARGET_HAS_v128) \=0D
+    && !defined(TCG_TARGET_HAS_v256)=0D
+#define TCG_TARGET_MAYBE_vec            0=0D
+#define TCG_TARGET_HAS_abs_vec          0=0D
+#define TCG_TARGET_HAS_neg_vec          0=0D
+#define TCG_TARGET_HAS_not_vec          0=0D
+#define TCG_TARGET_HAS_andc_vec         0=0D
+#define TCG_TARGET_HAS_orc_vec          0=0D
+#define TCG_TARGET_HAS_roti_vec         0=0D
+#define TCG_TARGET_HAS_rots_vec         0=0D
+#define TCG_TARGET_HAS_rotv_vec         0=0D
+#define TCG_TARGET_HAS_shi_vec          0=0D
+#define TCG_TARGET_HAS_shs_vec          0=0D
+#define TCG_TARGET_HAS_shv_vec          0=0D
+#define TCG_TARGET_HAS_mul_vec          0=0D
+#define TCG_TARGET_HAS_sat_vec          0=0D
+#define TCG_TARGET_HAS_minmax_vec       0=0D
+#define TCG_TARGET_HAS_bitsel_vec       0=0D
+#define TCG_TARGET_HAS_cmpsel_vec       0=0D
+#else=0D
+#define TCG_TARGET_MAYBE_vec            1=0D
+#endif=0D
+#ifndef TCG_TARGET_HAS_v64=0D
+#define TCG_TARGET_HAS_v64              0=0D
+#endif=0D
+#ifndef TCG_TARGET_HAS_v128=0D
+#define TCG_TARGET_HAS_v128             0=0D
+#endif=0D
+#ifndef TCG_TARGET_HAS_v256=0D
+#define TCG_TARGET_HAS_v256             0=0D
+#endif=0D
+=0D
+#ifndef TARGET_INSN_START_EXTRA_WORDS=0D
+# define TARGET_INSN_START_WORDS 1=0D
+#else=0D
+# define TARGET_INSN_START_WORDS (1 + TARGET_INSN_START_EXTRA_WORDS)=0D
+#endif=0D
+=0D
+typedef enum TCGOpcode {=0D
+#define DEF(name, oargs, iargs, cargs, flags) INDEX_op_ ## name,=0D
+#include "tcg/tcg-opc.h"=0D
+#undef DEF=0D
+    NB_OPS,=0D
+} TCGOpcode;=0D
+=0D
+#define tcg_regset_set_reg(d, r)   ((d) |=3D (TCGRegSet)1 << (r))=0D
+#define tcg_regset_reset_reg(d, r) ((d) &=3D ~((TCGRegSet)1 << (r)))=0D
+#define tcg_regset_test_reg(d, r)  (((d) >> (r)) & 1)=0D
+=0D
+#ifndef TCG_TARGET_INSN_UNIT_SIZE=0D
+# error "Missing TCG_TARGET_INSN_UNIT_SIZE"=0D
+#elif TCG_TARGET_INSN_UNIT_SIZE =3D=3D 1=0D
+typedef uint8_t tcg_insn_unit;=0D
+#elif TCG_TARGET_INSN_UNIT_SIZE =3D=3D 2=0D
+typedef uint16_t tcg_insn_unit;=0D
+#elif TCG_TARGET_INSN_UNIT_SIZE =3D=3D 4=0D
+typedef uint32_t tcg_insn_unit;=0D
+#elif TCG_TARGET_INSN_UNIT_SIZE =3D=3D 8=0D
+typedef uint64_t tcg_insn_unit;=0D
+#else=0D
+/* The port better have done this.  */=0D
+#endif=0D
+=0D
+=0D
+#if defined CONFIG_DEBUG_TCG || defined QEMU_STATIC_ANALYSIS=0D
+# define tcg_debug_assert(X) do { assert(X); } while (0)=0D
+#else=0D
+# define tcg_debug_assert(X) \=0D
+    do { if (!(X)) { __builtin_unreachable(); } } while (0)=0D
+#endif=0D
+=0D
+typedef struct TCGRelocation TCGRelocation;=0D
+struct TCGRelocation {=0D
+    QSIMPLEQ_ENTRY(TCGRelocation) next;=0D
+    tcg_insn_unit *ptr;=0D
+    intptr_t addend;=0D
+    int type;=0D
+};=0D
+=0D
+typedef struct TCGLabel TCGLabel;=0D
+struct TCGLabel {=0D
+    unsigned present : 1;=0D
+    unsigned has_value : 1;=0D
+    unsigned id : 14;=0D
+    unsigned refs : 16;=0D
+    union {=0D
+        uintptr_t value;=0D
+        tcg_insn_unit *value_ptr;=0D
+    } u;=0D
+    QSIMPLEQ_HEAD(, TCGRelocation) relocs;=0D
+    QSIMPLEQ_ENTRY(TCGLabel) next;=0D
+};=0D
+=0D
+typedef struct TCGPool {=0D
+    struct TCGPool *next;=0D
+    int size;=0D
+    uint8_t data[] __attribute__ ((aligned));=0D
+} TCGPool;=0D
+=0D
+#define TCG_POOL_CHUNK_SIZE 32768=0D
+=0D
+#define TCG_MAX_TEMPS 512=0D
+#define TCG_MAX_INSNS 512=0D
+=0D
+/* when the size of the arguments of a called function is smaller than=0D
+   this value, they are statically allocated in the TB stack frame */=0D
+#define TCG_STATIC_CALL_ARGS_SIZE 128=0D
+=0D
+typedef enum TCGType {=0D
+    TCG_TYPE_I32,=0D
+    TCG_TYPE_I64,=0D
+=0D
+    TCG_TYPE_V64,=0D
+    TCG_TYPE_V128,=0D
+    TCG_TYPE_V256,=0D
+=0D
+    TCG_TYPE_COUNT, /* number of different types */=0D
+=0D
+    /* An alias for the size of the host register.  */=0D
+#if TCG_TARGET_REG_BITS =3D=3D 32=0D
+    TCG_TYPE_REG =3D TCG_TYPE_I32,=0D
+#else=0D
+    TCG_TYPE_REG =3D TCG_TYPE_I64,=0D
+#endif=0D
+=0D
+    /* An alias for the size of the native pointer.  */=0D
+#if UINTPTR_MAX =3D=3D UINT32_MAX=0D
+    TCG_TYPE_PTR =3D TCG_TYPE_I32,=0D
+#else=0D
+    TCG_TYPE_PTR =3D TCG_TYPE_I64,=0D
+#endif=0D
+=0D
+    /* An alias for the size of the target "long", aka register.  */=0D
+#if TARGET_LONG_BITS =3D=3D 64=0D
+    TCG_TYPE_TL =3D TCG_TYPE_I64,=0D
+#else=0D
+    TCG_TYPE_TL =3D TCG_TYPE_I32,=0D
+#endif=0D
+} TCGType;=0D
+=0D
+/**=0D
+ * get_alignment_bits=0D
+ * @memop: MemOp value=0D
+ *=0D
+ * Extract the alignment size from the memop.=0D
+ */=0D
+static inline unsigned get_alignment_bits(MemOp memop)=0D
+{=0D
+    unsigned a =3D memop & MO_AMASK;=0D
+=0D
+    if (a =3D=3D MO_UNALN) {=0D
+        /* No alignment required.  */=0D
+        a =3D 0;=0D
+    } else if (a =3D=3D MO_ALIGN) {=0D
+        /* A natural alignment requirement.  */=0D
+        a =3D memop & MO_SIZE;=0D
+    } else {=0D
+        /* A specific alignment requirement.  */=0D
+        a =3D a >> MO_ASHIFT;=0D
+    }=0D
+#if defined(CONFIG_SOFTMMU)=0D
+    /* The requested alignment cannot overlap the TLB flags.  */=0D
+    tcg_debug_assert((TLB_FLAGS_MASK & ((1 << a) - 1)) =3D=3D 0);=0D
+#endif=0D
+    return a;=0D
+}=0D
+=0D
+typedef tcg_target_ulong TCGArg;=0D
+=0D
+/* Define type and accessor macros for TCG variables.=0D
+=0D
+   TCG variables are the inputs and outputs of TCG ops, as described=0D
+   in tcg/README. Target CPU front-end code uses these types to deal=0D
+   with TCG variables as it emits TCG code via the tcg_gen_* functions.=0D
+   They come in several flavours:=0D
+    * TCGv_i32 : 32 bit integer type=0D
+    * TCGv_i64 : 64 bit integer type=0D
+    * TCGv_ptr : a host pointer type=0D
+    * TCGv_vec : a host vector type; the exact size is not exposed=0D
+                 to the CPU front-end code.=0D
+    * TCGv : an integer type the same size as target_ulong=0D
+             (an alias for either TCGv_i32 or TCGv_i64)=0D
+   The compiler's type checking will complain if you mix them=0D
+   up and pass the wrong sized TCGv to a function.=0D
+=0D
+   Users of tcg_gen_* don't need to know about any of the internal=0D
+   details of these, and should treat them as opaque types.=0D
+   You won't be able to look inside them in a debugger either.=0D
+=0D
+   Internal implementation details follow:=0D
+=0D
+   Note that there is no definition of the structs TCGv_i32_d etc anywhere=
.=0D
+   This is deliberate, because the values we store in variables of type=0D
+   TCGv_i32 are not really pointers-to-structures. They're just small=0D
+   integers, but keeping them in pointer types like this means that the=0D
+   compiler will complain if you accidentally pass a TCGv_i32 to a=0D
+   function which takes a TCGv_i64, and so on. Only the internals of=0D
+   TCG need to care about the actual contents of the types.  */=0D
+=0D
+typedef struct TCGv_i32_d *TCGv_i32;=0D
+typedef struct TCGv_i64_d *TCGv_i64;=0D
+typedef struct TCGv_ptr_d *TCGv_ptr;=0D
+typedef struct TCGv_vec_d *TCGv_vec;=0D
+typedef TCGv_ptr TCGv_env;=0D
+#if TARGET_LONG_BITS =3D=3D 32=0D
+#define TCGv TCGv_i32=0D
+#elif TARGET_LONG_BITS =3D=3D 64=0D
+#define TCGv TCGv_i64=0D
+#else=0D
+#error Unhandled TARGET_LONG_BITS value=0D
+#endif=0D
+=0D
+/* call flags */=0D
+/* Helper does not read globals (either directly or through an exception).=
 It=0D
+   implies TCG_CALL_NO_WRITE_GLOBALS. */=0D
+#define TCG_CALL_NO_READ_GLOBALS    0x0001=0D
+/* Helper does not write globals */=0D
+#define TCG_CALL_NO_WRITE_GLOBALS   0x0002=0D
+/* Helper can be safely suppressed if the return value is not used. */=0D
+#define TCG_CALL_NO_SIDE_EFFECTS    0x0004=0D
+/* Helper is QEMU_NORETURN.  */=0D
+#define TCG_CALL_NO_RETURN          0x0008=0D
+=0D
+/* convenience version of most used call flags */=0D
+#define TCG_CALL_NO_RWG         TCG_CALL_NO_READ_GLOBALS=0D
+#define TCG_CALL_NO_WG          TCG_CALL_NO_WRITE_GLOBALS=0D
+#define TCG_CALL_NO_SE          TCG_CALL_NO_SIDE_EFFECTS=0D
+#define TCG_CALL_NO_RWG_SE      (TCG_CALL_NO_RWG | TCG_CALL_NO_SE)=0D
+#define TCG_CALL_NO_WG_SE       (TCG_CALL_NO_WG | TCG_CALL_NO_SE)=0D
+=0D
+/* Used to align parameters.  See the comment before tcgv_i32_temp.  */=0D
+#define TCG_CALL_DUMMY_ARG      ((TCGArg)0)=0D
+=0D
+/* Conditions.  Note that these are laid out for easy manipulation by=0D
+   the functions below:=0D
+     bit 0 is used for inverting;=0D
+     bit 1 is signed,=0D
+     bit 2 is unsigned,=0D
+     bit 3 is used with bit 0 for swapping signed/unsigned.  */=0D
+typedef enum {=0D
+    /* non-signed */=0D
+    TCG_COND_NEVER  =3D 0 | 0 | 0 | 0,=0D
+    TCG_COND_ALWAYS =3D 0 | 0 | 0 | 1,=0D
+    TCG_COND_EQ     =3D 8 | 0 | 0 | 0,=0D
+    TCG_COND_NE     =3D 8 | 0 | 0 | 1,=0D
+    /* signed */=0D
+    TCG_COND_LT     =3D 0 | 0 | 2 | 0,=0D
+    TCG_COND_GE     =3D 0 | 0 | 2 | 1,=0D
+    TCG_COND_LE     =3D 8 | 0 | 2 | 0,=0D
+    TCG_COND_GT     =3D 8 | 0 | 2 | 1,=0D
+    /* unsigned */=0D
+    TCG_COND_LTU    =3D 0 | 4 | 0 | 0,=0D
+    TCG_COND_GEU    =3D 0 | 4 | 0 | 1,=0D
+    TCG_COND_LEU    =3D 8 | 4 | 0 | 0,=0D
+    TCG_COND_GTU    =3D 8 | 4 | 0 | 1,=0D
+} TCGCond;=0D
+=0D
+/* Invert the sense of the comparison.  */=0D
+static inline TCGCond tcg_invert_cond(TCGCond c)=0D
+{=0D
+    return (TCGCond)(c ^ 1);=0D
+}=0D
+=0D
+/* Swap the operands in a comparison.  */=0D
+static inline TCGCond tcg_swap_cond(TCGCond c)=0D
+{=0D
+    return c & 6 ? (TCGCond)(c ^ 9) : c;=0D
+}=0D
+=0D
+/* Create an "unsigned" version of a "signed" comparison.  */=0D
+static inline TCGCond tcg_unsigned_cond(TCGCond c)=0D
+{=0D
+    return c & 2 ? (TCGCond)(c ^ 6) : c;=0D
+}=0D
+=0D
+/* Create a "signed" version of an "unsigned" comparison.  */=0D
+static inline TCGCond tcg_signed_cond(TCGCond c)=0D
+{=0D
+    return c & 4 ? (TCGCond)(c ^ 6) : c;=0D
+}=0D
+=0D
+/* Must a comparison be considered unsigned?  */=0D
+static inline bool is_unsigned_cond(TCGCond c)=0D
+{=0D
+    return (c & 4) !=3D 0;=0D
+}=0D
+=0D
+/* Create a "high" version of a double-word comparison.=0D
+   This removes equality from a LTE or GTE comparison.  */=0D
+static inline TCGCond tcg_high_cond(TCGCond c)=0D
+{=0D
+    switch (c) {=0D
+    case TCG_COND_GE:=0D
+    case TCG_COND_LE:=0D
+    case TCG_COND_GEU:=0D
+    case TCG_COND_LEU:=0D
+        return (TCGCond)(c ^ 8);=0D
+    default:=0D
+        return c;=0D
+    }=0D
+}=0D
+=0D
+typedef enum TCGTempVal {=0D
+    TEMP_VAL_DEAD,=0D
+    TEMP_VAL_REG,=0D
+    TEMP_VAL_MEM,=0D
+    TEMP_VAL_CONST,=0D
+} TCGTempVal;=0D
+=0D
+typedef struct TCGTemp {=0D
+    TCGReg reg:8;=0D
+    TCGTempVal val_type:8;=0D
+    TCGType base_type:8;=0D
+    TCGType type:8;=0D
+    unsigned int fixed_reg:1;=0D
+    unsigned int indirect_reg:1;=0D
+    unsigned int indirect_base:1;=0D
+    unsigned int mem_coherent:1;=0D
+    unsigned int mem_allocated:1;=0D
+    /* If true, the temp is saved across both basic blocks and=0D
+       translation blocks.  */=0D
+    unsigned int temp_global:1;=0D
+    /* If true, the temp is saved across basic blocks but dead=0D
+       at the end of translation blocks.  If false, the temp is=0D
+       dead at the end of basic blocks.  */=0D
+    unsigned int temp_local:1;=0D
+    unsigned int temp_allocated:1;=0D
+=0D
+    tcg_target_long val;=0D
+    struct TCGTemp *mem_base;=0D
+    intptr_t mem_offset;=0D
+    const char *name;=0D
+=0D
+    /* Pass-specific information that can be stored for a temporary.=0D
+       One word worth of integer data, and one pointer to data=0D
+       allocated separately.  */=0D
+    uintptr_t state;=0D
+    void *state_ptr;=0D
+} TCGTemp;=0D
+=0D
+typedef struct TCGContext TCGContext;=0D
+=0D
+typedef struct TCGTempSet {=0D
+    unsigned long l[BITS_TO_LONGS(TCG_MAX_TEMPS)];=0D
+} TCGTempSet;=0D
+=0D
+/* While we limit helpers to 6 arguments, for 32-bit hosts, with padding,=
=0D
+   this imples a max of 6*2 (64-bit in) + 2 (64-bit out) =3D 14 operands.=
=0D
+   There are never more than 2 outputs, which means that we can store all=
=0D
+   dead + sync data within 16 bits.  */=0D
+#define DEAD_ARG  4=0D
+#define SYNC_ARG  1=0D
+typedef uint16_t TCGLifeData;=0D
+=0D
+/* The layout here is designed to avoid a bitfield crossing of=0D
+   a 32-bit boundary, which would cause GCC to add extra padding.  */=0D
+typedef struct TCGOp {=0D
+    TCGOpcode opc   : 8;        /*  8 */=0D
+=0D
+    /* Parameters for this opcode.  See below.  */=0D
+    unsigned param1 : 4;        /* 12 */=0D
+    unsigned param2 : 4;        /* 16 */=0D
+=0D
+    /* Lifetime data of the operands.  */=0D
+    unsigned life   : 16;       /* 32 */=0D
+=0D
+    /* Next and previous opcodes.  */=0D
+    QTAILQ_ENTRY(TCGOp) link;=0D
+#ifdef CONFIG_PLUGIN=0D
+    QSIMPLEQ_ENTRY(TCGOp) plugin_link;=0D
+#endif=0D
+=0D
+    /* Arguments for the opcode.  */=0D
+    TCGArg args[MAX_OPC_PARAM];=0D
+=0D
+    /* Register preferences for the output(s).  */=0D
+    TCGRegSet output_pref[2];=0D
+} TCGOp;=0D
+=0D
+#define TCGOP_CALLI(X)    (X)->param1=0D
+#define TCGOP_CALLO(X)    (X)->param2=0D
+=0D
+#define TCGOP_VECL(X)     (X)->param1=0D
+#define TCGOP_VECE(X)     (X)->param2=0D
+=0D
+/* Make sure operands fit in the bitfields above.  */=0D
+QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));=0D
+=0D
+typedef struct TCGProfile {=0D
+    int64_t cpu_exec_time;=0D
+    int64_t tb_count1;=0D
+    int64_t tb_count;=0D
+    int64_t op_count; /* total insn count */=0D
+    int op_count_max; /* max insn per TB */=0D
+    int temp_count_max;=0D
+    int64_t temp_count;=0D
+    int64_t del_op_count;=0D
+    int64_t code_in_len;=0D
+    int64_t code_out_len;=0D
+    int64_t search_out_len;=0D
+    int64_t interm_time;=0D
+    int64_t code_time;=0D
+    int64_t la_time;=0D
+    int64_t opt_time;=0D
+    int64_t restore_count;=0D
+    int64_t restore_time;=0D
+    int64_t table_op_count[NB_OPS];=0D
+} TCGProfile;=0D
+=0D
+struct TCGContext {=0D
+    uint8_t *pool_cur, *pool_end;=0D
+    TCGPool *pool_first, *pool_current, *pool_first_large;=0D
+    int nb_labels;=0D
+    int nb_globals;=0D
+    int nb_temps;=0D
+    int nb_indirects;=0D
+    int nb_ops;=0D
+=0D
+    /* goto_tb support */=0D
+    tcg_insn_unit *code_buf;=0D
+    uint16_t *tb_jmp_reset_offset; /* tb->jmp_reset_offset */=0D
+    uintptr_t *tb_jmp_insn_offset; /* tb->jmp_target_arg if direct_jump */=
=0D
+    uintptr_t *tb_jmp_target_addr; /* tb->jmp_target_arg if !direct_jump *=
/=0D
+=0D
+    TCGRegSet reserved_regs;=0D
+    uint32_t tb_cflags; /* cflags of the current TB */=0D
+    intptr_t current_frame_offset;=0D
+    intptr_t frame_start;=0D
+    intptr_t frame_end;=0D
+    TCGTemp *frame_temp;=0D
+=0D
+    tcg_insn_unit *code_ptr;=0D
+=0D
+#ifdef CONFIG_PROFILER=0D
+    TCGProfile prof;=0D
+#endif=0D
+=0D
+#ifdef CONFIG_DEBUG_TCG=0D
+    int temps_in_use;=0D
+    int goto_tb_issue_mask;=0D
+    const TCGOpcode *vecop_list;=0D
+#endif=0D
+=0D
+    /* Code generation.  Note that we specifically do not use tcg_insn_uni=
t=0D
+       here, because there's too much arithmetic throughout that relies=0D
+       on addition and subtraction working on bytes.  Rely on the GCC=0D
+       extension that allows arithmetic on void*.  */=0D
+    void *code_gen_prologue;=0D
+    void *code_gen_epilogue;=0D
+    void *code_gen_buffer;=0D
+    size_t code_gen_buffer_size;=0D
+    void *code_gen_ptr;=0D
+    void *data_gen_ptr;=0D
+=0D
+    /* Threshold to flush the translated code buffer.  */=0D
+    void *code_gen_highwater;=0D
+=0D
+    size_t tb_phys_invalidate_count;=0D
+=0D
+    /* Track which vCPU triggers events */=0D
+    CPUState *cpu;                      /* *_trans */=0D
+=0D
+    /* These structures are private to tcg-target.c.inc.  */=0D
+#ifdef TCG_TARGET_NEED_LDST_LABELS=0D
+    QSIMPLEQ_HEAD(, TCGLabelQemuLdst) ldst_labels;=0D
+#endif=0D
+#ifdef TCG_TARGET_NEED_POOL_LABELS=0D
+    struct TCGLabelPoolData *pool_labels;=0D
+#endif=0D
+=0D
+    TCGLabel *exitreq_label;=0D
+=0D
+#ifdef CONFIG_PLUGIN=0D
+    /*=0D
+     * We keep one plugin_tb struct per TCGContext. Note that on every TB=
=0D
+     * translation we clear but do not free its contents; this way we=0D
+     * avoid a lot of malloc/free churn, since after a few TB's it's=0D
+     * unlikely that we'll need to allocate either more instructions or mo=
re=0D
+     * space for instructions (for variable-instruction-length ISAs).=0D
+     */=0D
+    struct qemu_plugin_tb *plugin_tb;=0D
+=0D
+    /* descriptor of the instruction being translated */=0D
+    struct qemu_plugin_insn *plugin_insn;=0D
+=0D
+    /* list to quickly access the injected ops */=0D
+    QSIMPLEQ_HEAD(, TCGOp) plugin_ops;=0D
+#endif=0D
+=0D
+    TCGTempSet free_temps[TCG_TYPE_COUNT * 2];=0D
+    TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */=0D
+=0D
+    QTAILQ_HEAD(, TCGOp) ops, free_ops;=0D
+    QSIMPLEQ_HEAD(, TCGLabel) labels;=0D
+=0D
+    /* Tells which temporary holds a given register.=0D
+       It does not take into account fixed registers */=0D
+    TCGTemp *reg_to_temp[TCG_TARGET_NB_REGS];=0D
+=0D
+    uint16_t gen_insn_end_off[TCG_MAX_INSNS];=0D
+    target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];=0D
+};=0D
+=0D
+extern TCGContext tcg_init_ctx;=0D
+extern __thread TCGContext *tcg_ctx;=0D
+extern TCGv_env cpu_env;=0D
+=0D
+static inline size_t temp_idx(TCGTemp *ts)=0D
+{=0D
+    ptrdiff_t n =3D ts - tcg_ctx->temps;=0D
+    tcg_debug_assert(n >=3D 0 && n < tcg_ctx->nb_temps);=0D
+    return n;=0D
+}=0D
+=0D
+static inline TCGArg temp_arg(TCGTemp *ts)=0D
+{=0D
+    return (uintptr_t)ts;=0D
+}=0D
+=0D
+static inline TCGTemp *arg_temp(TCGArg a)=0D
+{=0D
+    return (TCGTemp *)(uintptr_t)a;=0D
+}=0D
+=0D
+/* Using the offset of a temporary, relative to TCGContext, rather than=0D
+   its index means that we don't use 0.  That leaves offset 0 free for=0D
+   a NULL representation without having to leave index 0 unused.  */=0D
+static inline TCGTemp *tcgv_i32_temp(TCGv_i32 v)=0D
+{=0D
+    uintptr_t o =3D (uintptr_t)v;=0D
+    TCGTemp *t =3D (void *)tcg_ctx + o;=0D
+    tcg_debug_assert(offsetof(TCGContext, temps[temp_idx(t)]) =3D=3D o);=0D
+    return t;=0D
+}=0D
+=0D
+static inline TCGTemp *tcgv_i64_temp(TCGv_i64 v)=0D
+{=0D
+    return tcgv_i32_temp((TCGv_i32)v);=0D
+}=0D
+=0D
+static inline TCGTemp *tcgv_ptr_temp(TCGv_ptr v)=0D
+{=0D
+    return tcgv_i32_temp((TCGv_i32)v);=0D
+}=0D
+=0D
+static inline TCGTemp *tcgv_vec_temp(TCGv_vec v)=0D
+{=0D
+    return tcgv_i32_temp((TCGv_i32)v);=0D
+}=0D
+=0D
+static inline TCGArg tcgv_i32_arg(TCGv_i32 v)=0D
+{=0D
+    return temp_arg(tcgv_i32_temp(v));=0D
+}=0D
+=0D
+static inline TCGArg tcgv_i64_arg(TCGv_i64 v)=0D
+{=0D
+    return temp_arg(tcgv_i64_temp(v));=0D
+}=0D
+=0D
+static inline TCGArg tcgv_ptr_arg(TCGv_ptr v)=0D
+{=0D
+    return temp_arg(tcgv_ptr_temp(v));=0D
+}=0D
+=0D
+static inline TCGArg tcgv_vec_arg(TCGv_vec v)=0D
+{=0D
+    return temp_arg(tcgv_vec_temp(v));=0D
+}=0D
+=0D
+static inline TCGv_i32 temp_tcgv_i32(TCGTemp *t)=0D
+{=0D
+    (void)temp_idx(t); /* trigger embedded assert */=0D
+    return (TCGv_i32)((void *)t - (void *)tcg_ctx);=0D
+}=0D
+=0D
+static inline TCGv_i64 temp_tcgv_i64(TCGTemp *t)=0D
+{=0D
+    return (TCGv_i64)temp_tcgv_i32(t);=0D
+}=0D
+=0D
+static inline TCGv_ptr temp_tcgv_ptr(TCGTemp *t)=0D
+{=0D
+    return (TCGv_ptr)temp_tcgv_i32(t);=0D
+}=0D
+=0D
+static inline TCGv_vec temp_tcgv_vec(TCGTemp *t)=0D
+{=0D
+    return (TCGv_vec)temp_tcgv_i32(t);=0D
+}=0D
+=0D
+#if TCG_TARGET_REG_BITS =3D=3D 32=0D
+static inline TCGv_i32 TCGV_LOW(TCGv_i64 t)=0D
+{=0D
+    return temp_tcgv_i32(tcgv_i64_temp(t));=0D
+}=0D
+=0D
+static inline TCGv_i32 TCGV_HIGH(TCGv_i64 t)=0D
+{=0D
+    return temp_tcgv_i32(tcgv_i64_temp(t) + 1);=0D
+}=0D
+#endif=0D
+=0D
+static inline TCGArg tcg_get_insn_param(TCGOp *op, int arg)=0D
+{=0D
+    return op->args[arg];=0D
+}=0D
+=0D
+static inline void tcg_set_insn_param(TCGOp *op, int arg, TCGArg v)=0D
+{=0D
+    op->args[arg] =3D v;=0D
+}=0D
+=0D
+static inline target_ulong tcg_get_insn_start_param(TCGOp *op, int arg)=0D
+{=0D
+#if TARGET_LONG_BITS <=3D TCG_TARGET_REG_BITS=0D
+    return tcg_get_insn_param(op, arg);=0D
+#else=0D
+    return tcg_get_insn_param(op, arg * 2) |=0D
+           ((uint64_t)tcg_get_insn_param(op, arg * 2 + 1) << 32);=0D
+#endif=0D
+}=0D
+=0D
+static inline void tcg_set_insn_start_param(TCGOp *op, int arg, target_ulo=
ng v)=0D
+{=0D
+#if TARGET_LONG_BITS <=3D TCG_TARGET_REG_BITS=0D
+    tcg_set_insn_param(op, arg, v);=0D
+#else=0D
+    tcg_set_insn_param(op, arg * 2, v);=0D
+    tcg_set_insn_param(op, arg * 2 + 1, v >> 32);=0D
+#endif=0D
+}=0D
+=0D
+/* The last op that was emitted.  */=0D
+static inline TCGOp *tcg_last_op(void)=0D
+{=0D
+    return QTAILQ_LAST(&tcg_ctx->ops);=0D
+}=0D
+=0D
+/* Test for whether to terminate the TB for using too many opcodes.  */=0D
+static inline bool tcg_op_buf_full(void)=0D
+{=0D
+    /* This is not a hard limit, it merely stops translation when=0D
+     * we have produced "enough" opcodes.  We want to limit TB size=0D
+     * such that a RISC host can reasonably use a 16-bit signed=0D
+     * branch within the TB.  We also need to be mindful of the=0D
+     * 16-bit unsigned offsets, TranslationBlock.jmp_reset_offset[]=0D
+     * and TCGContext.gen_insn_end_off[].=0D
+     */=0D
+    return tcg_ctx->nb_ops >=3D 4000;=0D
+}=0D
+=0D
+/* pool based memory allocation */=0D
+=0D
+/* user-mode: mmap_lock must be held for tcg_malloc_internal. */=0D
+void *tcg_malloc_internal(TCGContext *s, int size);=0D
+void tcg_pool_reset(TCGContext *s);=0D
+TranslationBlock *tcg_tb_alloc(TCGContext *s);=0D
+=0D
+void tcg_region_init(void);=0D
+void tb_destroy(TranslationBlock *tb);=0D
+void tcg_region_reset_all(void);=0D
+=0D
+size_t tcg_code_size(void);=0D
+size_t tcg_code_capacity(void);=0D
+=0D
+void tcg_tb_insert(TranslationBlock *tb);=0D
+void tcg_tb_remove(TranslationBlock *tb);=0D
+size_t tcg_tb_phys_invalidate_count(void);=0D
+TranslationBlock *tcg_tb_lookup(uintptr_t tc_ptr);=0D
+void tcg_tb_foreach(GTraverseFunc func, gpointer user_data);=0D
+size_t tcg_nb_tbs(void);=0D
+=0D
+/* user-mode: Called with mmap_lock held.  */=0D
+static inline void *tcg_malloc(int size)=0D
+{=0D
+    TCGContext *s =3D tcg_ctx;=0D
+    uint8_t *ptr, *ptr_end;=0D
+=0D
+    /* ??? This is a weak placeholder for minimum malloc alignment.  */=0D
+    size =3D QEMU_ALIGN_UP(size, 8);=0D
+=0D
+    ptr =3D s->pool_cur;=0D
+    ptr_end =3D ptr + size;=0D
+    if (unlikely(ptr_end > s->pool_end)) {=0D
+        return tcg_malloc_internal(tcg_ctx, size);=0D
+    } else {=0D
+        s->pool_cur =3D ptr_end;=0D
+        return ptr;=0D
+    }=0D
+}=0D
+=0D
+void tcg_context_init(TCGContext *s);=0D
+void tcg_register_thread(void);=0D
+void tcg_prologue_init(TCGContext *s);=0D
+void tcg_func_start(TCGContext *s);=0D
+=0D
+int tcg_gen_code(TCGContext *s, TranslationBlock *tb);=0D
+=0D
+void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t siz=
e);=0D
+=0D
+TCGTemp *tcg_global_mem_new_internal(TCGType, TCGv_ptr,=0D
+                                     intptr_t, const char *);=0D
+TCGTemp *tcg_temp_new_internal(TCGType, bool);=0D
+void tcg_temp_free_internal(TCGTemp *);=0D
+TCGv_vec tcg_temp_new_vec(TCGType type);=0D
+TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);=0D
+=0D
+static inline void tcg_temp_free_i32(TCGv_i32 arg)=0D
+{=0D
+    tcg_temp_free_internal(tcgv_i32_temp(arg));=0D
+}=0D
+=0D
+static inline void tcg_temp_free_i64(TCGv_i64 arg)=0D
+{=0D
+    tcg_temp_free_internal(tcgv_i64_temp(arg));=0D
+}=0D
+=0D
+static inline void tcg_temp_free_ptr(TCGv_ptr arg)=0D
+{=0D
+    tcg_temp_free_internal(tcgv_ptr_temp(arg));=0D
+}=0D
+=0D
+static inline void tcg_temp_free_vec(TCGv_vec arg)=0D
+{=0D
+    tcg_temp_free_internal(tcgv_vec_temp(arg));=0D
+}=0D
+=0D
+static inline TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t offse=
t,=0D
+                                              const char *name)=0D
+{=0D
+    TCGTemp *t =3D tcg_global_mem_new_internal(TCG_TYPE_I32, reg, offset, =
name);=0D
+    return temp_tcgv_i32(t);=0D
+}=0D
+=0D
+static inline TCGv_i32 tcg_temp_new_i32(void)=0D
+{=0D
+    TCGTemp *t =3D tcg_temp_new_internal(TCG_TYPE_I32, false);=0D
+    return temp_tcgv_i32(t);=0D
+}=0D
+=0D
+static inline TCGv_i32 tcg_temp_local_new_i32(void)=0D
+{=0D
+    TCGTemp *t =3D tcg_temp_new_internal(TCG_TYPE_I32, true);=0D
+    return temp_tcgv_i32(t);=0D
+}=0D
+=0D
+static inline TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t offse=
t,=0D
+                                              const char *name)=0D
+{=0D
+    TCGTemp *t =3D tcg_global_mem_new_internal(TCG_TYPE_I64, reg, offset, =
name);=0D
+    return temp_tcgv_i64(t);=0D
+}=0D
+=0D
+static inline TCGv_i64 tcg_temp_new_i64(void)=0D
+{=0D
+    TCGTemp *t =3D tcg_temp_new_internal(TCG_TYPE_I64, false);=0D
+    return temp_tcgv_i64(t);=0D
+}=0D
+=0D
+static inline TCGv_i64 tcg_temp_local_new_i64(void)=0D
+{=0D
+    TCGTemp *t =3D tcg_temp_new_internal(TCG_TYPE_I64, true);=0D
+    return temp_tcgv_i64(t);=0D
+}=0D
+=0D
+static inline TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t offse=
t,=0D
+                                              const char *name)=0D
+{=0D
+    TCGTemp *t =3D tcg_global_mem_new_internal(TCG_TYPE_PTR, reg, offset, =
name);=0D
+    return temp_tcgv_ptr(t);=0D
+}=0D
+=0D
+static inline TCGv_ptr tcg_temp_new_ptr(void)=0D
+{=0D
+    TCGTemp *t =3D tcg_temp_new_internal(TCG_TYPE_PTR, false);=0D
+    return temp_tcgv_ptr(t);=0D
+}=0D
+=0D
+static inline TCGv_ptr tcg_temp_local_new_ptr(void)=0D
+{=0D
+    TCGTemp *t =3D tcg_temp_new_internal(TCG_TYPE_PTR, true);=0D
+    return temp_tcgv_ptr(t);=0D
+}=0D
+=0D
+#if defined(CONFIG_DEBUG_TCG)=0D
+/* If you call tcg_clear_temp_count() at the start of a section of=0D
+ * code which is not supposed to leak any TCG temporaries, then=0D
+ * calling tcg_check_temp_count() at the end of the section will=0D
+ * return 1 if the section did in fact leak a temporary.=0D
+ */=0D
+void tcg_clear_temp_count(void);=0D
+int tcg_check_temp_count(void);=0D
+#else=0D
+#define tcg_clear_temp_count() do { } while (0)=0D
+#define tcg_check_temp_count() 0=0D
+#endif=0D
+=0D
+int64_t tcg_cpu_exec_time(void);=0D
+void tcg_dump_info(void);=0D
+void tcg_dump_op_count(void);=0D
+=0D
+#define TCG_CT_ALIAS  0x80=0D
+#define TCG_CT_IALIAS 0x40=0D
+#define TCG_CT_NEWREG 0x20 /* output requires a new register */=0D
+#define TCG_CT_REG    0x01=0D
+#define TCG_CT_CONST  0x02 /* any constant of register size */=0D
+=0D
+typedef struct TCGArgConstraint {=0D
+    uint16_t ct;=0D
+    uint8_t alias_index;=0D
+    union {=0D
+        TCGRegSet regs;=0D
+    } u;=0D
+} TCGArgConstraint;=0D
+=0D
+#define TCG_MAX_OP_ARGS 16=0D
+=0D
+/* Bits for TCGOpDef->flags, 8 bits available.  */=0D
+enum {=0D
+    /* Instruction exits the translation block.  */=0D
+    TCG_OPF_BB_EXIT      =3D 0x01,=0D
+    /* Instruction defines the end of a basic block.  */=0D
+    TCG_OPF_BB_END       =3D 0x02,=0D
+    /* Instruction clobbers call registers and potentially update globals.=
  */=0D
+    TCG_OPF_CALL_CLOBBER =3D 0x04,=0D
+    /* Instruction has side effects: it cannot be removed if its outputs=0D
+       are not used, and might trigger exceptions.  */=0D
+    TCG_OPF_SIDE_EFFECTS =3D 0x08,=0D
+    /* Instruction operands are 64-bits (otherwise 32-bits).  */=0D
+    TCG_OPF_64BIT        =3D 0x10,=0D
+    /* Instruction is optional and not implemented by the host, or insn=0D
+       is generic and should not be implemened by the host.  */=0D
+    TCG_OPF_NOT_PRESENT  =3D 0x20,=0D
+    /* Instruction operands are vectors.  */=0D
+    TCG_OPF_VECTOR       =3D 0x40,=0D
+};=0D
+=0D
+typedef struct TCGOpDef {=0D
+    const char *name;=0D
+    uint8_t nb_oargs, nb_iargs, nb_cargs, nb_args;=0D
+    uint8_t flags;=0D
+    TCGArgConstraint *args_ct;=0D
+    int *sorted_args;=0D
+#if defined(CONFIG_DEBUG_TCG)=0D
+    int used;=0D
+#endif=0D
+} TCGOpDef;=0D
+=0D
+extern TCGOpDef tcg_op_defs[];=0D
+extern const size_t tcg_op_defs_max;=0D
+=0D
+typedef struct TCGTargetOpDef {=0D
+    TCGOpcode op;=0D
+    const char *args_ct_str[TCG_MAX_OP_ARGS];=0D
+} TCGTargetOpDef;=0D
+=0D
+#define tcg_abort() \=0D
+do {\=0D
+    fprintf(stderr, "%s:%d: tcg fatal error\n", __FILE__, __LINE__);\=0D
+    abort();\=0D
+} while (0)=0D
+=0D
+bool tcg_op_supported(TCGOpcode op);=0D
+=0D
+void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args);=0D
+=0D
+TCGOp *tcg_emit_op(TCGOpcode opc);=0D
+void tcg_op_remove(TCGContext *s, TCGOp *op);=0D
+TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op, TCGOpcode opc);=0D
+TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op, TCGOpcode opc);=0D
+=0D
+void tcg_optimize(TCGContext *s);=0D
+=0D
+TCGv_i32 tcg_const_i32(int32_t val);=0D
+TCGv_i64 tcg_const_i64(int64_t val);=0D
+TCGv_i32 tcg_const_local_i32(int32_t val);=0D
+TCGv_i64 tcg_const_local_i64(int64_t val);=0D
+TCGv_vec tcg_const_zeros_vec(TCGType);=0D
+TCGv_vec tcg_const_ones_vec(TCGType);=0D
+TCGv_vec tcg_const_zeros_vec_matching(TCGv_vec);=0D
+TCGv_vec tcg_const_ones_vec_matching(TCGv_vec);=0D
+=0D
+#if UINTPTR_MAX =3D=3D UINT32_MAX=0D
+# define tcg_const_ptr(x)        ((TCGv_ptr)tcg_const_i32((intptr_t)(x)))=
=0D
+# define tcg_const_local_ptr(x)  ((TCGv_ptr)tcg_const_local_i32((intptr_t)=
(x)))=0D
+#else=0D
+# define tcg_const_ptr(x)        ((TCGv_ptr)tcg_const_i64((intptr_t)(x)))=
=0D
+# define tcg_const_local_ptr(x)  ((TCGv_ptr)tcg_const_local_i64((intptr_t)=
(x)))=0D
+#endif=0D
+=0D
+TCGLabel *gen_new_label(void);=0D
+=0D
+/**=0D
+ * label_arg=0D
+ * @l: label=0D
+ *=0D
+ * Encode a label for storage in the TCG opcode stream.=0D
+ */=0D
+=0D
+static inline TCGArg label_arg(TCGLabel *l)=0D
+{=0D
+    return (uintptr_t)l;=0D
+}=0D
+=0D
+/**=0D
+ * arg_label=0D
+ * @i: value=0D
+ *=0D
+ * The opposite of label_arg.  Retrieve a label from the=0D
+ * encoding of the TCG opcode stream.=0D
+ */=0D
+=0D
+static inline TCGLabel *arg_label(TCGArg i)=0D
+{=0D
+    return (TCGLabel *)(uintptr_t)i;=0D
+}=0D
+=0D
+/**=0D
+ * tcg_ptr_byte_diff=0D
+ * @a, @b: addresses to be differenced=0D
+ *=0D
+ * There are many places within the TCG backends where we need a byte=0D
+ * difference between two pointers.  While this can be accomplished=0D
+ * with local casting, it's easy to get wrong -- especially if one is=0D
+ * concerned with the signedness of the result.=0D
+ *=0D
+ * This version relies on GCC's void pointer arithmetic to get the=0D
+ * correct result.=0D
+ */=0D
+=0D
+static inline ptrdiff_t tcg_ptr_byte_diff(void *a, void *b)=0D
+{=0D
+    return a - b;=0D
+}=0D
+=0D
+/**=0D
+ * tcg_pcrel_diff=0D
+ * @s: the tcg context=0D
+ * @target: address of the target=0D
+ *=0D
+ * Produce a pc-relative difference, from the current code_ptr=0D
+ * to the destination address.=0D
+ */=0D
+=0D
+static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, void *target)=0D
+{=0D
+    return tcg_ptr_byte_diff(target, s->code_ptr);=0D
+}=0D
+=0D
+/**=0D
+ * tcg_current_code_size=0D
+ * @s: the tcg context=0D
+ *=0D
+ * Compute the current code size within the translation block.=0D
+ * This is used to fill in qemu's data structures for goto_tb.=0D
+ */=0D
+=0D
+static inline size_t tcg_current_code_size(TCGContext *s)=0D
+{=0D
+    return tcg_ptr_byte_diff(s->code_ptr, s->code_buf);=0D
+}=0D
+=0D
+/* Combine the MemOp and mmu_idx parameters into a single value.  */=0D
+typedef uint32_t TCGMemOpIdx;=0D
+=0D
+/**=0D
+ * make_memop_idx=0D
+ * @op: memory operation=0D
+ * @idx: mmu index=0D
+ *=0D
+ * Encode these values into a single parameter.=0D
+ */=0D
+static inline TCGMemOpIdx make_memop_idx(MemOp op, unsigned idx)=0D
+{=0D
+    tcg_debug_assert(idx <=3D 15);=0D
+    return (op << 4) | idx;=0D
+}=0D
+=0D
+/**=0D
+ * get_memop=0D
+ * @oi: combined op/idx parameter=0D
+ *=0D
+ * Extract the memory operation from the combined value.=0D
+ */=0D
+static inline MemOp get_memop(TCGMemOpIdx oi)=0D
+{=0D
+    return oi >> 4;=0D
+}=0D
+=0D
+/**=0D
+ * get_mmuidx=0D
+ * @oi: combined op/idx parameter=0D
+ *=0D
+ * Extract the mmu index from the combined value.=0D
+ */=0D
+static inline unsigned get_mmuidx(TCGMemOpIdx oi)=0D
+{=0D
+    return oi & 15;=0D
+}=0D
+=0D
+/**=0D
+ * tcg_qemu_tb_exec:=0D
+ * @env: pointer to CPUArchState for the CPU=0D
+ * @tb_ptr: address of generated code for the TB to execute=0D
+ *=0D
+ * Start executing code from a given translation block.=0D
+ * Where translation blocks have been linked, execution=0D
+ * may proceed from the given TB into successive ones.=0D
+ * Control eventually returns only when some action is needed=0D
+ * from the top-level loop: either control must pass to a TB=0D
+ * which has not yet been directly linked, or an asynchronous=0D
+ * event such as an interrupt needs handling.=0D
+ *=0D
+ * Return: The return value is the value passed to the corresponding=0D
+ * tcg_gen_exit_tb() at translation time of the last TB attempted to execu=
te.=0D
+ * The value is either zero or a 4-byte aligned pointer to that TB combine=
d=0D
+ * with additional information in its two least significant bits. The=0D
+ * additional information is encoded as follows:=0D
+ *  0, 1: the link between this TB and the next is via the specified=0D
+ *        TB index (0 or 1). That is, we left the TB via (the equivalent=0D
+ *        of) "goto_tb <index>". The main loop uses this to determine=0D
+ *        how to link the TB just executed to the next.=0D
+ *  2:    we are using instruction counting code generation, and we=0D
+ *        did not start executing this TB because the instruction counter=
=0D
+ *        would hit zero midway through it. In this case the pointer=0D
+ *        returned is the TB we were about to execute, and the caller must=
=0D
+ *        arrange to execute the remaining count of instructions.=0D
+ *  3:    we stopped because the CPU's exit_request flag was set=0D
+ *        (usually meaning that there is an interrupt that needs to be=0D
+ *        handled). The pointer returned is the TB we were about to execut=
e=0D
+ *        when we noticed the pending exit request.=0D
+ *=0D
+ * If the bottom two bits indicate an exit-via-index then the CPU=0D
+ * state is correctly synchronised and ready for execution of the next=0D
+ * TB (and in particular the guest PC is the address to execute next).=0D
+ * Otherwise, we gave up on execution of this TB before it started, and=0D
+ * the caller must fix up the CPU state by calling the CPU's=0D
+ * synchronize_from_tb() method with the TB pointer we return (falling=0D
+ * back to calling the CPU's set_pc method with tb->pb if no=0D
+ * synchronize_from_tb() method exists).=0D
+ *=0D
+ * Note that TCG targets may use a different definition of tcg_qemu_tb_exe=
c=0D
+ * to this default (which just calls the prologue.code emitted by=0D
+ * tcg_target_qemu_prologue()).=0D
+ */=0D
+#define TB_EXIT_MASK      3=0D
+#define TB_EXIT_IDX0      0=0D
+#define TB_EXIT_IDX1      1=0D
+#define TB_EXIT_IDXMAX    1=0D
+#define TB_EXIT_REQUESTED 3=0D
+=0D
+#ifdef HAVE_TCG_QEMU_TB_EXEC=0D
+uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr);=0D
+#else=0D
+# define tcg_qemu_tb_exec(env, tb_ptr) \=0D
+    ((uintptr_t (*)(void *, void *))tcg_ctx->code_gen_prologue)(env, tb_pt=
r)=0D
+#endif=0D
+=0D
+void tcg_register_jit(void *buf, size_t buf_size);=0D
+=0D
+#if TCG_TARGET_MAYBE_vec=0D
+/* Return zero if the tuple (opc, type, vece) is unsupportable;=0D
+   return > 0 if it is directly supportable;=0D
+   return < 0 if we must call tcg_expand_vec_op.  */=0D
+int tcg_can_emit_vec_op(TCGOpcode, TCGType, unsigned);=0D
+#else=0D
+static inline int tcg_can_emit_vec_op(TCGOpcode o, TCGType t, unsigned ve)=
=0D
+{=0D
+    return 0;=0D
+}=0D
+#endif=0D
+=0D
+/* Expand the tuple (opc, type, vece) on the given arguments.  */=0D
+void tcg_expand_vec_op(TCGOpcode, TCGType, unsigned, TCGArg, ...);=0D
+=0D
+/* Replicate a constant C accoring to the log2 of the element size.  */=0D
+uint64_t dup_const_eval(unsigned vece, uint64_t c);=0D
+=0D
+#define dup_const(VECE, C)                                         \=0D
+    (__builtin_constant_p(VECE)                                    \=0D
+     ? (  (VECE) =3D=3D MO_8  ? 0x0101010101010101ull * (uint8_t)(C)   \=0D
+        : (VECE) =3D=3D MO_16 ? 0x0001000100010001ull * (uint16_t)(C)  \=0D
+        : (VECE) =3D=3D MO_32 ? 0x0000000100000001ull * (uint32_t)(C)  \=0D
+        : dup_const_eval(VECE, C))                                      \=
=0D
+     : dup_const_eval(VECE, C))=0D
+=0D
+=0D
+/*=0D
+ * Memory helpers that will be used by TCG generated code.=0D
+ */=0D
+#ifdef CONFIG_SOFTMMU=0D
+/* Value zero-extended to tcg register size.  */=0D
+tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,=
=0D
+                                     TCGMemOpIdx oi, uintptr_t retaddr);=0D
+tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,=
=0D
+                                    TCGMemOpIdx oi, uintptr_t retaddr);=0D
+tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,=
=0D
+                                    TCGMemOpIdx oi, uintptr_t retaddr);=0D
+uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr,=0D
+                           TCGMemOpIdx oi, uintptr_t retaddr);=0D
+tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,=
=0D
+                                    TCGMemOpIdx oi, uintptr_t retaddr);=0D
+tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,=
=0D
+                                    TCGMemOpIdx oi, uintptr_t retaddr);=0D
+uint64_t helper_be_ldq_mmu(CPUArchState *env, target_ulong addr,=0D
+                           TCGMemOpIdx oi, uintptr_t retaddr);=0D
+=0D
+/* Value sign-extended to tcg register size.  */=0D
+tcg_target_ulong helper_ret_ldsb_mmu(CPUArchState *env, target_ulong addr,=
=0D
+                                     TCGMemOpIdx oi, uintptr_t retaddr);=0D
+tcg_target_ulong helper_le_ldsw_mmu(CPUArchState *env, target_ulong addr,=
=0D
+                                    TCGMemOpIdx oi, uintptr_t retaddr);=0D
+tcg_target_ulong helper_le_ldsl_mmu(CPUArchState *env, target_ulong addr,=
=0D
+                                    TCGMemOpIdx oi, uintptr_t retaddr);=0D
+tcg_target_ulong helper_be_ldsw_mmu(CPUArchState *env, target_ulong addr,=
=0D
+                                    TCGMemOpIdx oi, uintptr_t retaddr);=0D
+tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,=
=0D
+                                    TCGMemOpIdx oi, uintptr_t retaddr);=0D
+=0D
+void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,=
=0D
+                        TCGMemOpIdx oi, uintptr_t retaddr);=0D
+void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,=
=0D
+                       TCGMemOpIdx oi, uintptr_t retaddr);=0D
+void helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,=
=0D
+                       TCGMemOpIdx oi, uintptr_t retaddr);=0D
+void helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,=
=0D
+                       TCGMemOpIdx oi, uintptr_t retaddr);=0D
+void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,=
=0D
+                       TCGMemOpIdx oi, uintptr_t retaddr);=0D
+void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,=
=0D
+                       TCGMemOpIdx oi, uintptr_t retaddr);=0D
+void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,=
=0D
+                       TCGMemOpIdx oi, uintptr_t retaddr);=0D
+=0D
+/* Temporary aliases until backends are converted.  */=0D
+#ifdef TARGET_WORDS_BIGENDIAN=0D
+# define helper_ret_ldsw_mmu  helper_be_ldsw_mmu=0D
+# define helper_ret_lduw_mmu  helper_be_lduw_mmu=0D
+# define helper_ret_ldsl_mmu  helper_be_ldsl_mmu=0D
+# define helper_ret_ldul_mmu  helper_be_ldul_mmu=0D
+# define helper_ret_ldl_mmu   helper_be_ldul_mmu=0D
+# define helper_ret_ldq_mmu   helper_be_ldq_mmu=0D
+# define helper_ret_stw_mmu   helper_be_stw_mmu=0D
+# define helper_ret_stl_mmu   helper_be_stl_mmu=0D
+# define helper_ret_stq_mmu   helper_be_stq_mmu=0D
+#else=0D
+# define helper_ret_ldsw_mmu  helper_le_ldsw_mmu=0D
+# define helper_ret_lduw_mmu  helper_le_lduw_mmu=0D
+# define helper_ret_ldsl_mmu  helper_le_ldsl_mmu=0D
+# define helper_ret_ldul_mmu  helper_le_ldul_mmu=0D
+# define helper_ret_ldl_mmu   helper_le_ldul_mmu=0D
+# define helper_ret_ldq_mmu   helper_le_ldq_mmu=0D
+# define helper_ret_stw_mmu   helper_le_stw_mmu=0D
+# define helper_ret_stl_mmu   helper_le_stl_mmu=0D
+# define helper_ret_stq_mmu   helper_le_stq_mmu=0D
+#endif=0D
+=0D
+uint32_t helper_atomic_cmpxchgb_mmu(CPUArchState *env, target_ulong addr,=
=0D
+                                    uint32_t cmpv, uint32_t newv,=0D
+                                    TCGMemOpIdx oi, uintptr_t retaddr);=0D
+uint32_t helper_atomic_cmpxchgw_le_mmu(CPUArchState *env, target_ulong add=
r,=0D
+                                       uint32_t cmpv, uint32_t newv,=0D
+                                       TCGMemOpIdx oi, uintptr_t retaddr);=
=0D
+uint32_t helper_atomic_cmpxchgl_le_mmu(CPUArchState *env, target_ulong add=
r,=0D
+                                       uint32_t cmpv, uint32_t newv,=0D
+                                       TCGMemOpIdx oi, uintptr_t retaddr);=
=0D
+uint64_t helper_atomic_cmpxchgq_le_mmu(CPUArchState *env, target_ulong add=
r,=0D
+                                       uint64_t cmpv, uint64_t newv,=0D
+                                       TCGMemOpIdx oi, uintptr_t retaddr);=
=0D
+uint32_t helper_atomic_cmpxchgw_be_mmu(CPUArchState *env, target_ulong add=
r,=0D
+                                       uint32_t cmpv, uint32_t newv,=0D
+                                       TCGMemOpIdx oi, uintptr_t retaddr);=
=0D
+uint32_t helper_atomic_cmpxchgl_be_mmu(CPUArchState *env, target_ulong add=
r,=0D
+                                       uint32_t cmpv, uint32_t newv,=0D
+                                       TCGMemOpIdx oi, uintptr_t retaddr);=
=0D
+uint64_t helper_atomic_cmpxchgq_be_mmu(CPUArchState *env, target_ulong add=
r,=0D
+                                       uint64_t cmpv, uint64_t newv,=0D
+                                       TCGMemOpIdx oi, uintptr_t retaddr);=
=0D
+=0D
+#define GEN_ATOMIC_HELPER(NAME, TYPE, SUFFIX)         \=0D
+TYPE helper_atomic_ ## NAME ## SUFFIX ## _mmu         \=0D
+    (CPUArchState *env, target_ulong addr, TYPE val,  \=0D
+     TCGMemOpIdx oi, uintptr_t retaddr);=0D
+=0D
+#ifdef CONFIG_ATOMIC64=0D
+#define GEN_ATOMIC_HELPER_ALL(NAME)          \=0D
+    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \=0D
+    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \=0D
+    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \=0D
+    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \=0D
+    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)  \=0D
+    GEN_ATOMIC_HELPER(NAME, uint64_t, q_le)  \=0D
+    GEN_ATOMIC_HELPER(NAME, uint64_t, q_be)=0D
+#else=0D
+#define GEN_ATOMIC_HELPER_ALL(NAME)          \=0D
+    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \=0D
+    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \=0D
+    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \=0D
+    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \=0D
+    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)=0D
+#endif=0D
+=0D
+GEN_ATOMIC_HELPER_ALL(fetch_add)=0D
+GEN_ATOMIC_HELPER_ALL(fetch_sub)=0D
+GEN_ATOMIC_HELPER_ALL(fetch_and)=0D
+GEN_ATOMIC_HELPER_ALL(fetch_or)=0D
+GEN_ATOMIC_HELPER_ALL(fetch_xor)=0D
+GEN_ATOMIC_HELPER_ALL(fetch_smin)=0D
+GEN_ATOMIC_HELPER_ALL(fetch_umin)=0D
+GEN_ATOMIC_HELPER_ALL(fetch_smax)=0D
+GEN_ATOMIC_HELPER_ALL(fetch_umax)=0D
+=0D
+GEN_ATOMIC_HELPER_ALL(add_fetch)=0D
+GEN_ATOMIC_HELPER_ALL(sub_fetch)=0D
+GEN_ATOMIC_HELPER_ALL(and_fetch)=0D
+GEN_ATOMIC_HELPER_ALL(or_fetch)=0D
+GEN_ATOMIC_HELPER_ALL(xor_fetch)=0D
+GEN_ATOMIC_HELPER_ALL(smin_fetch)=0D
+GEN_ATOMIC_HELPER_ALL(umin_fetch)=0D
+GEN_ATOMIC_HELPER_ALL(smax_fetch)=0D
+GEN_ATOMIC_HELPER_ALL(umax_fetch)=0D
+=0D
+GEN_ATOMIC_HELPER_ALL(xchg)=0D
+=0D
+#undef GEN_ATOMIC_HELPER_ALL=0D
+#undef GEN_ATOMIC_HELPER=0D
+#endif /* CONFIG_SOFTMMU */=0D
+=0D
+/*=0D
+ * These aren't really a "proper" helpers because TCG cannot manage Int128=
.=0D
+ * However, use the same format as the others, for use by the backends.=0D
+ *=0D
+ * The cmpxchg functions are only defined if HAVE_CMPXCHG128;=0D
+ * the ld/st functions are only defined if HAVE_ATOMIC128,=0D
+ * as defined by <qemu/atomic128.h>.=0D
+ */=0D
+Int128 helper_atomic_cmpxchgo_le_mmu(CPUArchState *env, target_ulong addr,=
=0D
+                                     Int128 cmpv, Int128 newv,=0D
+                                     TCGMemOpIdx oi, uintptr_t retaddr);=0D
+Int128 helper_atomic_cmpxchgo_be_mmu(CPUArchState *env, target_ulong addr,=
=0D
+                                     Int128 cmpv, Int128 newv,=0D
+                                     TCGMemOpIdx oi, uintptr_t retaddr);=0D
+=0D
+Int128 helper_atomic_ldo_le_mmu(CPUArchState *env, target_ulong addr,=0D
+                                TCGMemOpIdx oi, uintptr_t retaddr);=0D
+Int128 helper_atomic_ldo_be_mmu(CPUArchState *env, target_ulong addr,=0D
+                                TCGMemOpIdx oi, uintptr_t retaddr);=0D
+void helper_atomic_sto_le_mmu(CPUArchState *env, target_ulong addr, Int128=
 val,=0D
+                              TCGMemOpIdx oi, uintptr_t retaddr);=0D
+void helper_atomic_sto_be_mmu(CPUArchState *env, target_ulong addr, Int128=
 val,=0D
+                              TCGMemOpIdx oi, uintptr_t retaddr);=0D
+=0D
+#ifdef CONFIG_DEBUG_TCG=0D
+void tcg_assert_listed_vecop(TCGOpcode);=0D
+#else=0D
+static inline void tcg_assert_listed_vecop(TCGOpcode op) { }=0D
+#endif=0D
+=0D
+static inline const TCGOpcode *tcg_swap_vecop_list(const TCGOpcode *n)=0D
+{=0D
+#ifdef CONFIG_DEBUG_TCG=0D
+    const TCGOpcode *o =3D tcg_ctx->vecop_list;=0D
+    tcg_ctx->vecop_list =3D n;=0D
+    return o;=0D
+#else=0D
+    return NULL;=0D
+#endif=0D
+}=0D
+=0D
+bool tcg_can_emit_vecop_list(const TCGOpcode *, TCGType, unsigned);=0D
+=0D
+#endif /* TCG_H */=0D
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 3707c0effb..cbb6cd04bc 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1,3506 +1,3506 @@
-/*
- * Generic vector operation expansion
- *
- * Copyright (c) 2018 Linaro
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
- */
-
-#include "qemu/osdep.h"
-#include "tcg/tcg.h"
-#include "tcg/tcg-op.h"
-#include "tcg/tcg-op-gvec.h"
-#include "qemu/main-loop.h"
-#include "tcg/tcg-gvec-desc.h"
-
-#define MAX_UNROLL  4
-
-#ifdef CONFIG_DEBUG_TCG
-static const TCGOpcode vecop_list_empty[1] =3D { 0 };
-#else
-#define vecop_list_empty NULL
-#endif
-
-
-/* Verify vector size and alignment rules.  OFS should be the OR of all
-   of the operand offsets so that we can check them all at once.  */
-static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t ofs)
-{
-    uint32_t opr_align =3D oprsz >=3D 16 ? 15 : 7;
-    uint32_t max_align =3D maxsz >=3D 16 || oprsz >=3D 16 ? 15 : 7;
-    tcg_debug_assert(oprsz > 0);
-    tcg_debug_assert(oprsz <=3D maxsz);
-    tcg_debug_assert((oprsz & opr_align) =3D=3D 0);
-    tcg_debug_assert((maxsz & max_align) =3D=3D 0);
-    tcg_debug_assert((ofs & max_align) =3D=3D 0);
-}
-
-/* Verify vector overlap rules for two operands.  */
-static void check_overlap_2(uint32_t d, uint32_t a, uint32_t s)
-{
-    tcg_debug_assert(d =3D=3D a || d + s <=3D a || a + s <=3D d);
-}
-
-/* Verify vector overlap rules for three operands.  */
-static void check_overlap_3(uint32_t d, uint32_t a, uint32_t b, uint32_t s)
-{
-    check_overlap_2(d, a, s);
-    check_overlap_2(d, b, s);
-    check_overlap_2(a, b, s);
-}
-
-/* Verify vector overlap rules for four operands.  */
-static void check_overlap_4(uint32_t d, uint32_t a, uint32_t b,
-                            uint32_t c, uint32_t s)
-{
-    check_overlap_2(d, a, s);
-    check_overlap_2(d, b, s);
-    check_overlap_2(d, c, s);
-    check_overlap_2(a, b, s);
-    check_overlap_2(a, c, s);
-    check_overlap_2(b, c, s);
-}
-
-/* Create a descriptor from components.  */
-uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
-{
-    uint32_t desc =3D 0;
-
-    assert(oprsz % 8 =3D=3D 0 && oprsz <=3D (8 << SIMD_OPRSZ_BITS));
-    assert(maxsz % 8 =3D=3D 0 && maxsz <=3D (8 << SIMD_MAXSZ_BITS));
-    assert(data =3D=3D sextract32(data, 0, SIMD_DATA_BITS));
-
-    oprsz =3D (oprsz / 8) - 1;
-    maxsz =3D (maxsz / 8) - 1;
-    desc =3D deposit32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS, oprsz);
-    desc =3D deposit32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS, maxsz);
-    desc =3D deposit32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BITS, data);
-
-    return desc;
-}
-
-/* Generate a call to a gvec-style helper with two vector operands.  */
-void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
-                        uint32_t oprsz, uint32_t maxsz, int32_t data,
-                        gen_helper_gvec_2 *fn)
-{
-    TCGv_ptr a0, a1;
-    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
-
-    a0 =3D tcg_temp_new_ptr();
-    a1 =3D tcg_temp_new_ptr();
-
-    tcg_gen_addi_ptr(a0, cpu_env, dofs);
-    tcg_gen_addi_ptr(a1, cpu_env, aofs);
-
-    fn(a0, a1, desc);
-
-    tcg_temp_free_ptr(a0);
-    tcg_temp_free_ptr(a1);
-    tcg_temp_free_i32(desc);
-}
-
-/* Generate a call to a gvec-style helper with two vector operands
-   and one scalar operand.  */
-void tcg_gen_gvec_2i_ool(uint32_t dofs, uint32_t aofs, TCGv_i64 c,
-                         uint32_t oprsz, uint32_t maxsz, int32_t data,
-                         gen_helper_gvec_2i *fn)
-{
-    TCGv_ptr a0, a1;
-    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
-
-    a0 =3D tcg_temp_new_ptr();
-    a1 =3D tcg_temp_new_ptr();
-
-    tcg_gen_addi_ptr(a0, cpu_env, dofs);
-    tcg_gen_addi_ptr(a1, cpu_env, aofs);
-
-    fn(a0, a1, c, desc);
-
-    tcg_temp_free_ptr(a0);
-    tcg_temp_free_ptr(a1);
-    tcg_temp_free_i32(desc);
-}
-
-/* Generate a call to a gvec-style helper with three vector operands.  */
-void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                        uint32_t oprsz, uint32_t maxsz, int32_t data,
-                        gen_helper_gvec_3 *fn)
-{
-    TCGv_ptr a0, a1, a2;
-    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
-
-    a0 =3D tcg_temp_new_ptr();
-    a1 =3D tcg_temp_new_ptr();
-    a2 =3D tcg_temp_new_ptr();
-
-    tcg_gen_addi_ptr(a0, cpu_env, dofs);
-    tcg_gen_addi_ptr(a1, cpu_env, aofs);
-    tcg_gen_addi_ptr(a2, cpu_env, bofs);
-
-    fn(a0, a1, a2, desc);
-
-    tcg_temp_free_ptr(a0);
-    tcg_temp_free_ptr(a1);
-    tcg_temp_free_ptr(a2);
-    tcg_temp_free_i32(desc);
-}
-
-/* Generate a call to a gvec-style helper with four vector operands.  */
-void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                        uint32_t cofs, uint32_t oprsz, uint32_t maxsz,
-                        int32_t data, gen_helper_gvec_4 *fn)
-{
-    TCGv_ptr a0, a1, a2, a3;
-    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
-
-    a0 =3D tcg_temp_new_ptr();
-    a1 =3D tcg_temp_new_ptr();
-    a2 =3D tcg_temp_new_ptr();
-    a3 =3D tcg_temp_new_ptr();
-
-    tcg_gen_addi_ptr(a0, cpu_env, dofs);
-    tcg_gen_addi_ptr(a1, cpu_env, aofs);
-    tcg_gen_addi_ptr(a2, cpu_env, bofs);
-    tcg_gen_addi_ptr(a3, cpu_env, cofs);
-
-    fn(a0, a1, a2, a3, desc);
-
-    tcg_temp_free_ptr(a0);
-    tcg_temp_free_ptr(a1);
-    tcg_temp_free_ptr(a2);
-    tcg_temp_free_ptr(a3);
-    tcg_temp_free_i32(desc);
-}
-
-/* Generate a call to a gvec-style helper with five vector operands.  */
-void tcg_gen_gvec_5_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                        uint32_t cofs, uint32_t xofs, uint32_t oprsz,
-                        uint32_t maxsz, int32_t data, gen_helper_gvec_5 *f=
n)
-{
-    TCGv_ptr a0, a1, a2, a3, a4;
-    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
-
-    a0 =3D tcg_temp_new_ptr();
-    a1 =3D tcg_temp_new_ptr();
-    a2 =3D tcg_temp_new_ptr();
-    a3 =3D tcg_temp_new_ptr();
-    a4 =3D tcg_temp_new_ptr();
-
-    tcg_gen_addi_ptr(a0, cpu_env, dofs);
-    tcg_gen_addi_ptr(a1, cpu_env, aofs);
-    tcg_gen_addi_ptr(a2, cpu_env, bofs);
-    tcg_gen_addi_ptr(a3, cpu_env, cofs);
-    tcg_gen_addi_ptr(a4, cpu_env, xofs);
-
-    fn(a0, a1, a2, a3, a4, desc);
-
-    tcg_temp_free_ptr(a0);
-    tcg_temp_free_ptr(a1);
-    tcg_temp_free_ptr(a2);
-    tcg_temp_free_ptr(a3);
-    tcg_temp_free_ptr(a4);
-    tcg_temp_free_i32(desc);
-}
-
-/* Generate a call to a gvec-style helper with three vector operands
-   and an extra pointer operand.  */
-void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,
-                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
-                        int32_t data, gen_helper_gvec_2_ptr *fn)
-{
-    TCGv_ptr a0, a1;
-    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
-
-    a0 =3D tcg_temp_new_ptr();
-    a1 =3D tcg_temp_new_ptr();
-
-    tcg_gen_addi_ptr(a0, cpu_env, dofs);
-    tcg_gen_addi_ptr(a1, cpu_env, aofs);
-
-    fn(a0, a1, ptr, desc);
-
-    tcg_temp_free_ptr(a0);
-    tcg_temp_free_ptr(a1);
-    tcg_temp_free_i32(desc);
-}
-
-/* Generate a call to a gvec-style helper with three vector operands
-   and an extra pointer operand.  */
-void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
-                        int32_t data, gen_helper_gvec_3_ptr *fn)
-{
-    TCGv_ptr a0, a1, a2;
-    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
-
-    a0 =3D tcg_temp_new_ptr();
-    a1 =3D tcg_temp_new_ptr();
-    a2 =3D tcg_temp_new_ptr();
-
-    tcg_gen_addi_ptr(a0, cpu_env, dofs);
-    tcg_gen_addi_ptr(a1, cpu_env, aofs);
-    tcg_gen_addi_ptr(a2, cpu_env, bofs);
-
-    fn(a0, a1, a2, ptr, desc);
-
-    tcg_temp_free_ptr(a0);
-    tcg_temp_free_ptr(a1);
-    tcg_temp_free_ptr(a2);
-    tcg_temp_free_i32(desc);
-}
-
-/* Generate a call to a gvec-style helper with four vector operands
-   and an extra pointer operand.  */
-void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                        uint32_t cofs, TCGv_ptr ptr, uint32_t oprsz,
-                        uint32_t maxsz, int32_t data,
-                        gen_helper_gvec_4_ptr *fn)
-{
-    TCGv_ptr a0, a1, a2, a3;
-    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
-
-    a0 =3D tcg_temp_new_ptr();
-    a1 =3D tcg_temp_new_ptr();
-    a2 =3D tcg_temp_new_ptr();
-    a3 =3D tcg_temp_new_ptr();
-
-    tcg_gen_addi_ptr(a0, cpu_env, dofs);
-    tcg_gen_addi_ptr(a1, cpu_env, aofs);
-    tcg_gen_addi_ptr(a2, cpu_env, bofs);
-    tcg_gen_addi_ptr(a3, cpu_env, cofs);
-
-    fn(a0, a1, a2, a3, ptr, desc);
-
-    tcg_temp_free_ptr(a0);
-    tcg_temp_free_ptr(a1);
-    tcg_temp_free_ptr(a2);
-    tcg_temp_free_ptr(a3);
-    tcg_temp_free_i32(desc);
-}
-
-/* Generate a call to a gvec-style helper with five vector operands
-   and an extra pointer operand.  */
-void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                        uint32_t cofs, uint32_t eofs, TCGv_ptr ptr,
-                        uint32_t oprsz, uint32_t maxsz, int32_t data,
-                        gen_helper_gvec_5_ptr *fn)
-{
-    TCGv_ptr a0, a1, a2, a3, a4;
-    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
-
-    a0 =3D tcg_temp_new_ptr();
-    a1 =3D tcg_temp_new_ptr();
-    a2 =3D tcg_temp_new_ptr();
-    a3 =3D tcg_temp_new_ptr();
-    a4 =3D tcg_temp_new_ptr();
-
-    tcg_gen_addi_ptr(a0, cpu_env, dofs);
-    tcg_gen_addi_ptr(a1, cpu_env, aofs);
-    tcg_gen_addi_ptr(a2, cpu_env, bofs);
-    tcg_gen_addi_ptr(a3, cpu_env, cofs);
-    tcg_gen_addi_ptr(a4, cpu_env, eofs);
-
-    fn(a0, a1, a2, a3, a4, ptr, desc);
-
-    tcg_temp_free_ptr(a0);
-    tcg_temp_free_ptr(a1);
-    tcg_temp_free_ptr(a2);
-    tcg_temp_free_ptr(a3);
-    tcg_temp_free_ptr(a4);
-    tcg_temp_free_i32(desc);
-}
-
-/* Return true if we want to implement something of OPRSZ bytes
-   in units of LNSZ.  This limits the expansion of inline code.  */
-static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
-{
-    uint32_t q, r;
-
-    if (oprsz < lnsz) {
-        return false;
-    }
-
-    q =3D oprsz / lnsz;
-    r =3D oprsz % lnsz;
-    tcg_debug_assert((r & 7) =3D=3D 0);
-
-    if (lnsz < 16) {
-        /* For sizes below 16, accept no remainder. */
-        if (r !=3D 0) {
-            return false;
-        }
-    } else {
-        /*
-         * Recall that ARM SVE allows vector sizes that are not a
-         * power of 2, but always a multiple of 16.  The intent is
-         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
-         * In addition, expand_clr needs to handle a multiple of 8.
-         * Thus we can handle the tail with one more operation per
-         * diminishing power of 2.
-         */
-        q +=3D ctpop32(r);
-    }
-
-    return q <=3D MAX_UNROLL;
-}
-
-static void expand_clr(uint32_t dofs, uint32_t maxsz);
-
-/* Duplicate C as per VECE.  */
-uint64_t (dup_const)(unsigned vece, uint64_t c)
-{
-    switch (vece) {
-    case MO_8:
-        return 0x0101010101010101ull * (uint8_t)c;
-    case MO_16:
-        return 0x0001000100010001ull * (uint16_t)c;
-    case MO_32:
-        return 0x0000000100000001ull * (uint32_t)c;
-    case MO_64:
-        return c;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-/* Duplicate IN into OUT as per VECE.  */
-static void gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in)
-{
-    switch (vece) {
-    case MO_8:
-        tcg_gen_ext8u_i32(out, in);
-        tcg_gen_muli_i32(out, out, 0x01010101);
-        break;
-    case MO_16:
-        tcg_gen_deposit_i32(out, in, in, 16, 16);
-        break;
-    case MO_32:
-        tcg_gen_mov_i32(out, in);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-static void gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in)
-{
-    switch (vece) {
-    case MO_8:
-        tcg_gen_ext8u_i64(out, in);
-        tcg_gen_muli_i64(out, out, 0x0101010101010101ull);
-        break;
-    case MO_16:
-        tcg_gen_ext16u_i64(out, in);
-        tcg_gen_muli_i64(out, out, 0x0001000100010001ull);
-        break;
-    case MO_32:
-        tcg_gen_deposit_i64(out, in, in, 32, 32);
-        break;
-    case MO_64:
-        tcg_gen_mov_i64(out, in);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-/* Select a supported vector type for implementing an operation on SIZE
- * bytes.  If OP is 0, assume that the real operation to be performed is
- * required by all backends.  Otherwise, make sure than OP can be performed
- * on elements of size VECE in the selected type.  Do not select V64 if
- * PREFER_I64 is true.  Return 0 if no vector type is selected.
- */
-static TCGType choose_vector_type(const TCGOpcode *list, unsigned vece,
-                                  uint32_t size, bool prefer_i64)
-{
-    /*
-     * Recall that ARM SVE allows vector sizes that are not a
-     * power of 2, but always a multiple of 16.  The intent is
-     * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
-     * It is hard to imagine a case in which v256 is supported
-     * but v128 is not, but check anyway.
-     * In addition, expand_clr needs to handle a multiple of 8.
-     */
-    if (TCG_TARGET_HAS_v256 &&
-        check_size_impl(size, 32) &&
-        tcg_can_emit_vecop_list(list, TCG_TYPE_V256, vece) &&
-        (!(size & 16) ||
-         (TCG_TARGET_HAS_v128 &&
-          tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece))) &&
-        (!(size & 8) ||
-         (TCG_TARGET_HAS_v64 &&
-          tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)))) {
-        return TCG_TYPE_V256;
-    }
-    if (TCG_TARGET_HAS_v128 &&
-        check_size_impl(size, 16) &&
-        tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece) &&
-        (!(size & 8) ||
-         (TCG_TARGET_HAS_v64 &&
-          tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)))) {
-        return TCG_TYPE_V128;
-    }
-    if (TCG_TARGET_HAS_v64 && !prefer_i64 && check_size_impl(size, 8)
-        && tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)) {
-        return TCG_TYPE_V64;
-    }
-    return 0;
-}
-
-static void do_dup_store(TCGType type, uint32_t dofs, uint32_t oprsz,
-                         uint32_t maxsz, TCGv_vec t_vec)
-{
-    uint32_t i =3D 0;
-
-    tcg_debug_assert(oprsz >=3D 8);
-
-    /*
-     * This may be expand_clr for the tail of an operation, e.g.
-     * oprsz =3D=3D 8 && maxsz =3D=3D 64.  The first 8 bytes of this store
-     * are misaligned wrt the maximum vector size, so do that first.
-     */
-    if (dofs & 8) {
-        tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V64);
-        i +=3D 8;
-    }
-
-    switch (type) {
-    case TCG_TYPE_V256:
-        /*
-         * Recall that ARM SVE allows vector sizes that are not a
-         * power of 2, but always a multiple of 16.  The intent is
-         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
-         */
-        for (; i + 32 <=3D oprsz; i +=3D 32) {
-            tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V256);
-        }
-        /* fallthru */
-    case TCG_TYPE_V128:
-        for (; i + 16 <=3D oprsz; i +=3D 16) {
-            tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V128);
-        }
-        break;
-    case TCG_TYPE_V64:
-        for (; i < oprsz; i +=3D 8) {
-            tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V64);
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
-    }
-}
-
-/* Set OPRSZ bytes at DOFS to replications of IN_32, IN_64 or IN_C.
- * Only one of IN_32 or IN_64 may be set;
- * IN_C is used if IN_32 and IN_64 are unset.
- */
-static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
-                   uint32_t maxsz, TCGv_i32 in_32, TCGv_i64 in_64,
-                   uint64_t in_c)
-{
-    TCGType type;
-    TCGv_i64 t_64;
-    TCGv_i32 t_32, t_desc;
-    TCGv_ptr t_ptr;
-    uint32_t i;
-
-    assert(vece <=3D (in_32 ? MO_32 : MO_64));
-    assert(in_32 =3D=3D NULL || in_64 =3D=3D NULL);
-
-    /* If we're storing 0, expand oprsz to maxsz.  */
-    if (in_32 =3D=3D NULL && in_64 =3D=3D NULL) {
-        in_c =3D dup_const(vece, in_c);
-        if (in_c =3D=3D 0) {
-            oprsz =3D maxsz;
-        }
-    }
-
-    /* Implement inline with a vector type, if possible.
-     * Prefer integer when 64-bit host and no variable dup.
-     */
-    type =3D choose_vector_type(NULL, vece, oprsz,
-                              (TCG_TARGET_REG_BITS =3D=3D 64 && in_32 =3D=
=3D NULL
-                               && (in_64 =3D=3D NULL || vece =3D=3D MO_64)=
));
-    if (type !=3D 0) {
-        TCGv_vec t_vec =3D tcg_temp_new_vec(type);
-
-        if (in_32) {
-            tcg_gen_dup_i32_vec(vece, t_vec, in_32);
-        } else if (in_64) {
-            tcg_gen_dup_i64_vec(vece, t_vec, in_64);
-        } else {
-            tcg_gen_dupi_vec(vece, t_vec, in_c);
-        }
-        do_dup_store(type, dofs, oprsz, maxsz, t_vec);
-        tcg_temp_free_vec(t_vec);
-        return;
-    }
-
-    /* Otherwise, inline with an integer type, unless "large".  */
-    if (check_size_impl(oprsz, TCG_TARGET_REG_BITS / 8)) {
-        t_64 =3D NULL;
-        t_32 =3D NULL;
-
-        if (in_32) {
-            /* We are given a 32-bit variable input.  For a 64-bit host,
-               use a 64-bit operation unless the 32-bit operation would
-               be simple enough.  */
-            if (TCG_TARGET_REG_BITS =3D=3D 64
-                && (vece !=3D MO_32 || !check_size_impl(oprsz, 4))) {
-                t_64 =3D tcg_temp_new_i64();
-                tcg_gen_extu_i32_i64(t_64, in_32);
-                gen_dup_i64(vece, t_64, t_64);
-            } else {
-                t_32 =3D tcg_temp_new_i32();
-                gen_dup_i32(vece, t_32, in_32);
-            }
-        } else if (in_64) {
-            /* We are given a 64-bit variable input.  */
-            t_64 =3D tcg_temp_new_i64();
-            gen_dup_i64(vece, t_64, in_64);
-        } else {
-            /* We are given a constant input.  */
-            /* For 64-bit hosts, use 64-bit constants for "simple" constan=
ts
-               or when we'd need too many 32-bit stores, or when a 64-bit
-               constant is really required.  */
-            if (vece =3D=3D MO_64
-                || (TCG_TARGET_REG_BITS =3D=3D 64
-                    && (in_c =3D=3D 0 || in_c =3D=3D -1
-                        || !check_size_impl(oprsz, 4)))) {
-                t_64 =3D tcg_const_i64(in_c);
-            } else {
-                t_32 =3D tcg_const_i32(in_c);
-            }
-        }
-
-        /* Implement inline if we picked an implementation size above.  */
-        if (t_32) {
-            for (i =3D 0; i < oprsz; i +=3D 4) {
-                tcg_gen_st_i32(t_32, cpu_env, dofs + i);
-            }
-            tcg_temp_free_i32(t_32);
-            goto done;
-        }
-        if (t_64) {
-            for (i =3D 0; i < oprsz; i +=3D 8) {
-                tcg_gen_st_i64(t_64, cpu_env, dofs + i);
-            }
-            tcg_temp_free_i64(t_64);
-            goto done;
-        }
-    }
-
-    /* Otherwise implement out of line.  */
-    t_ptr =3D tcg_temp_new_ptr();
-    tcg_gen_addi_ptr(t_ptr, cpu_env, dofs);
-    t_desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, 0));
-
-    if (vece =3D=3D MO_64) {
-        if (in_64) {
-            gen_helper_gvec_dup64(t_ptr, t_desc, in_64);
-        } else {
-            t_64 =3D tcg_const_i64(in_c);
-            gen_helper_gvec_dup64(t_ptr, t_desc, t_64);
-            tcg_temp_free_i64(t_64);
-        }
-    } else {
-        typedef void dup_fn(TCGv_ptr, TCGv_i32, TCGv_i32);
-        static dup_fn * const fns[3] =3D {
-            gen_helper_gvec_dup8,
-            gen_helper_gvec_dup16,
-            gen_helper_gvec_dup32
-        };
-
-        if (in_32) {
-            fns[vece](t_ptr, t_desc, in_32);
-        } else {
-            t_32 =3D tcg_temp_new_i32();
-            if (in_64) {
-                tcg_gen_extrl_i64_i32(t_32, in_64);
-            } else if (vece =3D=3D MO_8) {
-                tcg_gen_movi_i32(t_32, in_c & 0xff);
-            } else if (vece =3D=3D MO_16) {
-                tcg_gen_movi_i32(t_32, in_c & 0xffff);
-            } else {
-                tcg_gen_movi_i32(t_32, in_c);
-            }
-            fns[vece](t_ptr, t_desc, t_32);
-            tcg_temp_free_i32(t_32);
-        }
-    }
-
-    tcg_temp_free_ptr(t_ptr);
-    tcg_temp_free_i32(t_desc);
-    return;
-
- done:
-    if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
-    }
-}
-
-/* Likewise, but with zero.  */
-static void expand_clr(uint32_t dofs, uint32_t maxsz)
-{
-    do_dup(MO_8, dofs, maxsz, maxsz, NULL, NULL, 0);
-}
-
-/* Expand OPSZ bytes worth of two-operand operations using i32 elements.  =
*/
-static void expand_2_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                         bool load_dest, void (*fni)(TCGv_i32, TCGv_i32))
-{
-    TCGv_i32 t0 =3D tcg_temp_new_i32();
-    TCGv_i32 t1 =3D tcg_temp_new_i32();
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D 4) {
-        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
-        if (load_dest) {
-            tcg_gen_ld_i32(t1, cpu_env, dofs + i);
-        }
-        fni(t1, t0);
-        tcg_gen_st_i32(t1, cpu_env, dofs + i);
-    }
-    tcg_temp_free_i32(t0);
-    tcg_temp_free_i32(t1);
-}
-
-static void expand_2i_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                          int32_t c, bool load_dest,
-                          void (*fni)(TCGv_i32, TCGv_i32, int32_t))
-{
-    TCGv_i32 t0 =3D tcg_temp_new_i32();
-    TCGv_i32 t1 =3D tcg_temp_new_i32();
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D 4) {
-        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
-        if (load_dest) {
-            tcg_gen_ld_i32(t1, cpu_env, dofs + i);
-        }
-        fni(t1, t0, c);
-        tcg_gen_st_i32(t1, cpu_env, dofs + i);
-    }
-    tcg_temp_free_i32(t0);
-    tcg_temp_free_i32(t1);
-}
-
-static void expand_2s_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                          TCGv_i32 c, bool scalar_first,
-                          void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32))
-{
-    TCGv_i32 t0 =3D tcg_temp_new_i32();
-    TCGv_i32 t1 =3D tcg_temp_new_i32();
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D 4) {
-        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
-        if (scalar_first) {
-            fni(t1, c, t0);
-        } else {
-            fni(t1, t0, c);
-        }
-        tcg_gen_st_i32(t1, cpu_env, dofs + i);
-    }
-    tcg_temp_free_i32(t0);
-    tcg_temp_free_i32(t1);
-}
-
-/* Expand OPSZ bytes worth of three-operand operations using i32 elements.=
  */
-static void expand_3_i32(uint32_t dofs, uint32_t aofs,
-                         uint32_t bofs, uint32_t oprsz, bool load_dest,
-                         void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32))
-{
-    TCGv_i32 t0 =3D tcg_temp_new_i32();
-    TCGv_i32 t1 =3D tcg_temp_new_i32();
-    TCGv_i32 t2 =3D tcg_temp_new_i32();
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D 4) {
-        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
-        tcg_gen_ld_i32(t1, cpu_env, bofs + i);
-        if (load_dest) {
-            tcg_gen_ld_i32(t2, cpu_env, dofs + i);
-        }
-        fni(t2, t0, t1);
-        tcg_gen_st_i32(t2, cpu_env, dofs + i);
-    }
-    tcg_temp_free_i32(t2);
-    tcg_temp_free_i32(t1);
-    tcg_temp_free_i32(t0);
-}
-
-static void expand_3i_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                          uint32_t oprsz, int32_t c, bool load_dest,
-                          void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32, int32_=
t))
-{
-    TCGv_i32 t0 =3D tcg_temp_new_i32();
-    TCGv_i32 t1 =3D tcg_temp_new_i32();
-    TCGv_i32 t2 =3D tcg_temp_new_i32();
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D 4) {
-        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
-        tcg_gen_ld_i32(t1, cpu_env, bofs + i);
-        if (load_dest) {
-            tcg_gen_ld_i32(t2, cpu_env, dofs + i);
-        }
-        fni(t2, t0, t1, c);
-        tcg_gen_st_i32(t2, cpu_env, dofs + i);
-    }
-    tcg_temp_free_i32(t0);
-    tcg_temp_free_i32(t1);
-    tcg_temp_free_i32(t2);
-}
-
-/* Expand OPSZ bytes worth of three-operand operations using i32 elements.=
  */
-static void expand_4_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                         uint32_t cofs, uint32_t oprsz, bool write_aofs,
-                         void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i3=
2))
-{
-    TCGv_i32 t0 =3D tcg_temp_new_i32();
-    TCGv_i32 t1 =3D tcg_temp_new_i32();
-    TCGv_i32 t2 =3D tcg_temp_new_i32();
-    TCGv_i32 t3 =3D tcg_temp_new_i32();
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D 4) {
-        tcg_gen_ld_i32(t1, cpu_env, aofs + i);
-        tcg_gen_ld_i32(t2, cpu_env, bofs + i);
-        tcg_gen_ld_i32(t3, cpu_env, cofs + i);
-        fni(t0, t1, t2, t3);
-        tcg_gen_st_i32(t0, cpu_env, dofs + i);
-        if (write_aofs) {
-            tcg_gen_st_i32(t1, cpu_env, aofs + i);
-        }
-    }
-    tcg_temp_free_i32(t3);
-    tcg_temp_free_i32(t2);
-    tcg_temp_free_i32(t1);
-    tcg_temp_free_i32(t0);
-}
-
-/* Expand OPSZ bytes worth of two-operand operations using i64 elements.  =
*/
-static void expand_2_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                         bool load_dest, void (*fni)(TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 t0 =3D tcg_temp_new_i64();
-    TCGv_i64 t1 =3D tcg_temp_new_i64();
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D 8) {
-        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
-        if (load_dest) {
-            tcg_gen_ld_i64(t1, cpu_env, dofs + i);
-        }
-        fni(t1, t0);
-        tcg_gen_st_i64(t1, cpu_env, dofs + i);
-    }
-    tcg_temp_free_i64(t0);
-    tcg_temp_free_i64(t1);
-}
-
-static void expand_2i_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                          int64_t c, bool load_dest,
-                          void (*fni)(TCGv_i64, TCGv_i64, int64_t))
-{
-    TCGv_i64 t0 =3D tcg_temp_new_i64();
-    TCGv_i64 t1 =3D tcg_temp_new_i64();
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D 8) {
-        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
-        if (load_dest) {
-            tcg_gen_ld_i64(t1, cpu_env, dofs + i);
-        }
-        fni(t1, t0, c);
-        tcg_gen_st_i64(t1, cpu_env, dofs + i);
-    }
-    tcg_temp_free_i64(t0);
-    tcg_temp_free_i64(t1);
-}
-
-static void expand_2s_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                          TCGv_i64 c, bool scalar_first,
-                          void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 t0 =3D tcg_temp_new_i64();
-    TCGv_i64 t1 =3D tcg_temp_new_i64();
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D 8) {
-        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
-        if (scalar_first) {
-            fni(t1, c, t0);
-        } else {
-            fni(t1, t0, c);
-        }
-        tcg_gen_st_i64(t1, cpu_env, dofs + i);
-    }
-    tcg_temp_free_i64(t0);
-    tcg_temp_free_i64(t1);
-}
-
-/* Expand OPSZ bytes worth of three-operand operations using i64 elements.=
  */
-static void expand_3_i64(uint32_t dofs, uint32_t aofs,
-                         uint32_t bofs, uint32_t oprsz, bool load_dest,
-                         void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 t0 =3D tcg_temp_new_i64();
-    TCGv_i64 t1 =3D tcg_temp_new_i64();
-    TCGv_i64 t2 =3D tcg_temp_new_i64();
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D 8) {
-        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
-        tcg_gen_ld_i64(t1, cpu_env, bofs + i);
-        if (load_dest) {
-            tcg_gen_ld_i64(t2, cpu_env, dofs + i);
-        }
-        fni(t2, t0, t1);
-        tcg_gen_st_i64(t2, cpu_env, dofs + i);
-    }
-    tcg_temp_free_i64(t2);
-    tcg_temp_free_i64(t1);
-    tcg_temp_free_i64(t0);
-}
-
-static void expand_3i_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                          uint32_t oprsz, int64_t c, bool load_dest,
-                          void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64, int64_=
t))
-{
-    TCGv_i64 t0 =3D tcg_temp_new_i64();
-    TCGv_i64 t1 =3D tcg_temp_new_i64();
-    TCGv_i64 t2 =3D tcg_temp_new_i64();
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D 8) {
-        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
-        tcg_gen_ld_i64(t1, cpu_env, bofs + i);
-        if (load_dest) {
-            tcg_gen_ld_i64(t2, cpu_env, dofs + i);
-        }
-        fni(t2, t0, t1, c);
-        tcg_gen_st_i64(t2, cpu_env, dofs + i);
-    }
-    tcg_temp_free_i64(t0);
-    tcg_temp_free_i64(t1);
-    tcg_temp_free_i64(t2);
-}
-
-/* Expand OPSZ bytes worth of three-operand operations using i64 elements.=
  */
-static void expand_4_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                         uint32_t cofs, uint32_t oprsz, bool write_aofs,
-                         void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i6=
4))
-{
-    TCGv_i64 t0 =3D tcg_temp_new_i64();
-    TCGv_i64 t1 =3D tcg_temp_new_i64();
-    TCGv_i64 t2 =3D tcg_temp_new_i64();
-    TCGv_i64 t3 =3D tcg_temp_new_i64();
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D 8) {
-        tcg_gen_ld_i64(t1, cpu_env, aofs + i);
-        tcg_gen_ld_i64(t2, cpu_env, bofs + i);
-        tcg_gen_ld_i64(t3, cpu_env, cofs + i);
-        fni(t0, t1, t2, t3);
-        tcg_gen_st_i64(t0, cpu_env, dofs + i);
-        if (write_aofs) {
-            tcg_gen_st_i64(t1, cpu_env, aofs + i);
-        }
-    }
-    tcg_temp_free_i64(t3);
-    tcg_temp_free_i64(t2);
-    tcg_temp_free_i64(t1);
-    tcg_temp_free_i64(t0);
-}
-
-/* Expand OPSZ bytes worth of two-operand operations using host vectors.  =
*/
-static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
-                         uint32_t oprsz, uint32_t tysz, TCGType type,
-                         bool load_dest,
-                         void (*fni)(unsigned, TCGv_vec, TCGv_vec))
-{
-    TCGv_vec t0 =3D tcg_temp_new_vec(type);
-    TCGv_vec t1 =3D tcg_temp_new_vec(type);
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D tysz) {
-        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
-        if (load_dest) {
-            tcg_gen_ld_vec(t1, cpu_env, dofs + i);
-        }
-        fni(vece, t1, t0);
-        tcg_gen_st_vec(t1, cpu_env, dofs + i);
-    }
-    tcg_temp_free_vec(t0);
-    tcg_temp_free_vec(t1);
-}
-
-/* Expand OPSZ bytes worth of two-vector operands and an immediate operand
-   using host vectors.  */
-static void expand_2i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
-                          uint32_t oprsz, uint32_t tysz, TCGType type,
-                          int64_t c, bool load_dest,
-                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, int64_=
t))
-{
-    TCGv_vec t0 =3D tcg_temp_new_vec(type);
-    TCGv_vec t1 =3D tcg_temp_new_vec(type);
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D tysz) {
-        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
-        if (load_dest) {
-            tcg_gen_ld_vec(t1, cpu_env, dofs + i);
-        }
-        fni(vece, t1, t0, c);
-        tcg_gen_st_vec(t1, cpu_env, dofs + i);
-    }
-    tcg_temp_free_vec(t0);
-    tcg_temp_free_vec(t1);
-}
-
-static void expand_2s_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
-                          uint32_t oprsz, uint32_t tysz, TCGType type,
-                          TCGv_vec c, bool scalar_first,
-                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_v=
ec))
-{
-    TCGv_vec t0 =3D tcg_temp_new_vec(type);
-    TCGv_vec t1 =3D tcg_temp_new_vec(type);
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D tysz) {
-        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
-        if (scalar_first) {
-            fni(vece, t1, c, t0);
-        } else {
-            fni(vece, t1, t0, c);
-        }
-        tcg_gen_st_vec(t1, cpu_env, dofs + i);
-    }
-    tcg_temp_free_vec(t0);
-    tcg_temp_free_vec(t1);
-}
-
-/* Expand OPSZ bytes worth of three-operand operations using host vectors.=
  */
-static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
-                         uint32_t bofs, uint32_t oprsz,
-                         uint32_t tysz, TCGType type, bool load_dest,
-                         void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_ve=
c))
-{
-    TCGv_vec t0 =3D tcg_temp_new_vec(type);
-    TCGv_vec t1 =3D tcg_temp_new_vec(type);
-    TCGv_vec t2 =3D tcg_temp_new_vec(type);
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D tysz) {
-        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
-        tcg_gen_ld_vec(t1, cpu_env, bofs + i);
-        if (load_dest) {
-            tcg_gen_ld_vec(t2, cpu_env, dofs + i);
-        }
-        fni(vece, t2, t0, t1);
-        tcg_gen_st_vec(t2, cpu_env, dofs + i);
-    }
-    tcg_temp_free_vec(t2);
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t0);
-}
-
-/*
- * Expand OPSZ bytes worth of three-vector operands and an immediate opera=
nd
- * using host vectors.
- */
-static void expand_3i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
-                          uint32_t bofs, uint32_t oprsz, uint32_t tysz,
-                          TCGType type, int64_t c, bool load_dest,
-                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_v=
ec,
-                                      int64_t))
-{
-    TCGv_vec t0 =3D tcg_temp_new_vec(type);
-    TCGv_vec t1 =3D tcg_temp_new_vec(type);
-    TCGv_vec t2 =3D tcg_temp_new_vec(type);
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D tysz) {
-        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
-        tcg_gen_ld_vec(t1, cpu_env, bofs + i);
-        if (load_dest) {
-            tcg_gen_ld_vec(t2, cpu_env, dofs + i);
-        }
-        fni(vece, t2, t0, t1, c);
-        tcg_gen_st_vec(t2, cpu_env, dofs + i);
-    }
-    tcg_temp_free_vec(t0);
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t2);
-}
-
-/* Expand OPSZ bytes worth of four-operand operations using host vectors. =
 */
-static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
-                         uint32_t bofs, uint32_t cofs, uint32_t oprsz,
-                         uint32_t tysz, TCGType type, bool write_aofs,
-                         void (*fni)(unsigned, TCGv_vec, TCGv_vec,
-                                     TCGv_vec, TCGv_vec))
-{
-    TCGv_vec t0 =3D tcg_temp_new_vec(type);
-    TCGv_vec t1 =3D tcg_temp_new_vec(type);
-    TCGv_vec t2 =3D tcg_temp_new_vec(type);
-    TCGv_vec t3 =3D tcg_temp_new_vec(type);
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D tysz) {
-        tcg_gen_ld_vec(t1, cpu_env, aofs + i);
-        tcg_gen_ld_vec(t2, cpu_env, bofs + i);
-        tcg_gen_ld_vec(t3, cpu_env, cofs + i);
-        fni(vece, t0, t1, t2, t3);
-        tcg_gen_st_vec(t0, cpu_env, dofs + i);
-        if (write_aofs) {
-            tcg_gen_st_vec(t1, cpu_env, aofs + i);
-        }
-    }
-    tcg_temp_free_vec(t3);
-    tcg_temp_free_vec(t2);
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t0);
-}
-
-/* Expand a vector two-operand operation.  */
-void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
-                    uint32_t oprsz, uint32_t maxsz, const GVecGen2 *g)
-{
-    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;
-    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);
-    TCGType type;
-    uint32_t some;
-
-    check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(dofs, aofs, maxsz);
-
-    type =3D 0;
-    if (g->fniv) {
-        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_=
i64);
-    }
-    switch (type) {
-    case TCG_TYPE_V256:
-        /* Recall that ARM SVE allows vector sizes that are not a
-         * power of 2, but always a multiple of 16.  The intent is
-         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
-         */
-        some =3D QEMU_ALIGN_DOWN(oprsz, 32);
-        expand_2_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,
-                     g->load_dest, g->fniv);
-        if (some =3D=3D oprsz) {
-            break;
-        }
-        dofs +=3D some;
-        aofs +=3D some;
-        oprsz -=3D some;
-        maxsz -=3D some;
-        /* fallthru */
-    case TCG_TYPE_V128:
-        expand_2_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
-                     g->load_dest, g->fniv);
-        break;
-    case TCG_TYPE_V64:
-        expand_2_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
-                     g->load_dest, g->fniv);
-        break;
-
-    case 0:
-        if (g->fni8 && check_size_impl(oprsz, 8)) {
-            expand_2_i64(dofs, aofs, oprsz, g->load_dest, g->fni8);
-        } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-            expand_2_i32(dofs, aofs, oprsz, g->load_dest, g->fni4);
-        } else {
-            assert(g->fno !=3D NULL);
-            tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, g->data, g->fno);
-            oprsz =3D maxsz;
-        }
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-    tcg_swap_vecop_list(hold_list);
-
-    if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
-    }
-}
-
-/* Expand a vector operation with two vectors and an immediate.  */
-void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                     uint32_t maxsz, int64_t c, const GVecGen2i *g)
-{
-    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;
-    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);
-    TCGType type;
-    uint32_t some;
-
-    check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(dofs, aofs, maxsz);
-
-    type =3D 0;
-    if (g->fniv) {
-        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_=
i64);
-    }
-    switch (type) {
-    case TCG_TYPE_V256:
-        /* Recall that ARM SVE allows vector sizes that are not a
-         * power of 2, but always a multiple of 16.  The intent is
-         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
-         */
-        some =3D QEMU_ALIGN_DOWN(oprsz, 32);
-        expand_2i_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,
-                      c, g->load_dest, g->fniv);
-        if (some =3D=3D oprsz) {
-            break;
-        }
-        dofs +=3D some;
-        aofs +=3D some;
-        oprsz -=3D some;
-        maxsz -=3D some;
-        /* fallthru */
-    case TCG_TYPE_V128:
-        expand_2i_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
-                      c, g->load_dest, g->fniv);
-        break;
-    case TCG_TYPE_V64:
-        expand_2i_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
-                      c, g->load_dest, g->fniv);
-        break;
-
-    case 0:
-        if (g->fni8 && check_size_impl(oprsz, 8)) {
-            expand_2i_i64(dofs, aofs, oprsz, c, g->load_dest, g->fni8);
-        } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-            expand_2i_i32(dofs, aofs, oprsz, c, g->load_dest, g->fni4);
-        } else {
-            if (g->fno) {
-                tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, c, g->fno);
-            } else {
-                TCGv_i64 tcg_c =3D tcg_const_i64(c);
-                tcg_gen_gvec_2i_ool(dofs, aofs, tcg_c, oprsz,
-                                    maxsz, c, g->fnoi);
-                tcg_temp_free_i64(tcg_c);
-            }
-            oprsz =3D maxsz;
-        }
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-    tcg_swap_vecop_list(hold_list);
-
-    if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
-    }
-}
-
-/* Expand a vector operation with two vectors and a scalar.  */
-void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                     uint32_t maxsz, TCGv_i64 c, const GVecGen2s *g)
-{
-    TCGType type;
-
-    check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(dofs, aofs, maxsz);
-
-    type =3D 0;
-    if (g->fniv) {
-        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_=
i64);
-    }
-    if (type !=3D 0) {
-        const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;
-        const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);
-        TCGv_vec t_vec =3D tcg_temp_new_vec(type);
-        uint32_t some;
-
-        tcg_gen_dup_i64_vec(g->vece, t_vec, c);
-
-        switch (type) {
-        case TCG_TYPE_V256:
-            /* Recall that ARM SVE allows vector sizes that are not a
-             * power of 2, but always a multiple of 16.  The intent is
-             * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
-             */
-            some =3D QEMU_ALIGN_DOWN(oprsz, 32);
-            expand_2s_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,
-                          t_vec, g->scalar_first, g->fniv);
-            if (some =3D=3D oprsz) {
-                break;
-            }
-            dofs +=3D some;
-            aofs +=3D some;
-            oprsz -=3D some;
-            maxsz -=3D some;
-            /* fallthru */
-
-        case TCG_TYPE_V128:
-            expand_2s_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
-                          t_vec, g->scalar_first, g->fniv);
-            break;
-
-        case TCG_TYPE_V64:
-            expand_2s_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
-                          t_vec, g->scalar_first, g->fniv);
-            break;
-
-        default:
-            g_assert_not_reached();
-        }
-        tcg_temp_free_vec(t_vec);
-        tcg_swap_vecop_list(hold_list);
-    } else if (g->fni8 && check_size_impl(oprsz, 8)) {
-        TCGv_i64 t64 =3D tcg_temp_new_i64();
-
-        gen_dup_i64(g->vece, t64, c);
-        expand_2s_i64(dofs, aofs, oprsz, t64, g->scalar_first, g->fni8);
-        tcg_temp_free_i64(t64);
-    } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-        TCGv_i32 t32 =3D tcg_temp_new_i32();
-
-        tcg_gen_extrl_i64_i32(t32, c);
-        gen_dup_i32(g->vece, t32, t32);
-        expand_2s_i32(dofs, aofs, oprsz, t32, g->scalar_first, g->fni4);
-        tcg_temp_free_i32(t32);
-    } else {
-        tcg_gen_gvec_2i_ool(dofs, aofs, c, oprsz, maxsz, 0, g->fno);
-        return;
-    }
-
-    if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
-    }
-}
-
-/* Expand a vector three-operand operation.  */
-void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                    uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
-{
-    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;
-    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);
-    TCGType type;
-    uint32_t some;
-
-    check_size_align(oprsz, maxsz, dofs | aofs | bofs);
-    check_overlap_3(dofs, aofs, bofs, maxsz);
-
-    type =3D 0;
-    if (g->fniv) {
-        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_=
i64);
-    }
-    switch (type) {
-    case TCG_TYPE_V256:
-        /* Recall that ARM SVE allows vector sizes that are not a
-         * power of 2, but always a multiple of 16.  The intent is
-         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
-         */
-        some =3D QEMU_ALIGN_DOWN(oprsz, 32);
-        expand_3_vec(g->vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256,
-                     g->load_dest, g->fniv);
-        if (some =3D=3D oprsz) {
-            break;
-        }
-        dofs +=3D some;
-        aofs +=3D some;
-        bofs +=3D some;
-        oprsz -=3D some;
-        maxsz -=3D some;
-        /* fallthru */
-    case TCG_TYPE_V128:
-        expand_3_vec(g->vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128,
-                     g->load_dest, g->fniv);
-        break;
-    case TCG_TYPE_V64:
-        expand_3_vec(g->vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64,
-                     g->load_dest, g->fniv);
-        break;
-
-    case 0:
-        if (g->fni8 && check_size_impl(oprsz, 8)) {
-            expand_3_i64(dofs, aofs, bofs, oprsz, g->load_dest, g->fni8);
-        } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-            expand_3_i32(dofs, aofs, bofs, oprsz, g->load_dest, g->fni4);
-        } else {
-            assert(g->fno !=3D NULL);
-            tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz,
-                               maxsz, g->data, g->fno);
-            oprsz =3D maxsz;
-        }
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-    tcg_swap_vecop_list(hold_list);
-
-    if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
-    }
-}
-
-/* Expand a vector operation with three vectors and an immediate.  */
-void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                     uint32_t oprsz, uint32_t maxsz, int64_t c,
-                     const GVecGen3i *g)
-{
-    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;
-    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);
-    TCGType type;
-    uint32_t some;
-
-    check_size_align(oprsz, maxsz, dofs | aofs | bofs);
-    check_overlap_3(dofs, aofs, bofs, maxsz);
-
-    type =3D 0;
-    if (g->fniv) {
-        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_=
i64);
-    }
-    switch (type) {
-    case TCG_TYPE_V256:
-        /*
-         * Recall that ARM SVE allows vector sizes that are not a
-         * power of 2, but always a multiple of 16.  The intent is
-         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
-         */
-        some =3D QEMU_ALIGN_DOWN(oprsz, 32);
-        expand_3i_vec(g->vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256,
-                      c, g->load_dest, g->fniv);
-        if (some =3D=3D oprsz) {
-            break;
-        }
-        dofs +=3D some;
-        aofs +=3D some;
-        bofs +=3D some;
-        oprsz -=3D some;
-        maxsz -=3D some;
-        /* fallthru */
-    case TCG_TYPE_V128:
-        expand_3i_vec(g->vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128,
-                      c, g->load_dest, g->fniv);
-        break;
-    case TCG_TYPE_V64:
-        expand_3i_vec(g->vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64,
-                      c, g->load_dest, g->fniv);
-        break;
-
-    case 0:
-        if (g->fni8 && check_size_impl(oprsz, 8)) {
-            expand_3i_i64(dofs, aofs, bofs, oprsz, c, g->load_dest, g->fni=
8);
-        } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-            expand_3i_i32(dofs, aofs, bofs, oprsz, c, g->load_dest, g->fni=
4);
-        } else {
-            assert(g->fno !=3D NULL);
-            tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, c, g->fno);
-            oprsz =3D maxsz;
-        }
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-    tcg_swap_vecop_list(hold_list);
-
-    if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
-    }
-}
-
-/* Expand a vector four-operand operation.  */
-void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t =
cofs,
-                    uint32_t oprsz, uint32_t maxsz, const GVecGen4 *g)
-{
-    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;
-    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);
-    TCGType type;
-    uint32_t some;
-
-    check_size_align(oprsz, maxsz, dofs | aofs | bofs | cofs);
-    check_overlap_4(dofs, aofs, bofs, cofs, maxsz);
-
-    type =3D 0;
-    if (g->fniv) {
-        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_=
i64);
-    }
-    switch (type) {
-    case TCG_TYPE_V256:
-        /* Recall that ARM SVE allows vector sizes that are not a
-         * power of 2, but always a multiple of 16.  The intent is
-         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
-         */
-        some =3D QEMU_ALIGN_DOWN(oprsz, 32);
-        expand_4_vec(g->vece, dofs, aofs, bofs, cofs, some,
-                     32, TCG_TYPE_V256, g->write_aofs, g->fniv);
-        if (some =3D=3D oprsz) {
-            break;
-        }
-        dofs +=3D some;
-        aofs +=3D some;
-        bofs +=3D some;
-        cofs +=3D some;
-        oprsz -=3D some;
-        maxsz -=3D some;
-        /* fallthru */
-    case TCG_TYPE_V128:
-        expand_4_vec(g->vece, dofs, aofs, bofs, cofs, oprsz,
-                     16, TCG_TYPE_V128, g->write_aofs, g->fniv);
-        break;
-    case TCG_TYPE_V64:
-        expand_4_vec(g->vece, dofs, aofs, bofs, cofs, oprsz,
-                     8, TCG_TYPE_V64, g->write_aofs, g->fniv);
-        break;
-
-    case 0:
-        if (g->fni8 && check_size_impl(oprsz, 8)) {
-            expand_4_i64(dofs, aofs, bofs, cofs, oprsz,
-                         g->write_aofs, g->fni8);
-        } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-            expand_4_i32(dofs, aofs, bofs, cofs, oprsz,
-                         g->write_aofs, g->fni4);
-        } else {
-            assert(g->fno !=3D NULL);
-            tcg_gen_gvec_4_ool(dofs, aofs, bofs, cofs,
-                               oprsz, maxsz, g->data, g->fno);
-            oprsz =3D maxsz;
-        }
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-    tcg_swap_vecop_list(hold_list);
-
-    if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
-    }
-}
-
-/*
- * Expand specific vector operations.
- */
-
-static void vec_mov2(unsigned vece, TCGv_vec a, TCGv_vec b)
-{
-    tcg_gen_mov_vec(a, b);
-}
-
-void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen2 g =3D {
-        .fni8 =3D tcg_gen_mov_i64,
-        .fniv =3D vec_mov2,
-        .fno =3D gen_helper_gvec_mov,
-        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    };
-    if (dofs !=3D aofs) {
-        tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g);
-    } else {
-        check_size_align(oprsz, maxsz, dofs);
-        if (oprsz < maxsz) {
-            expand_clr(dofs + oprsz, maxsz - oprsz);
-        }
-    }
-}
-
-void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t oprsz,
-                          uint32_t maxsz, TCGv_i32 in)
-{
-    check_size_align(oprsz, maxsz, dofs);
-    tcg_debug_assert(vece <=3D MO_32);
-    do_dup(vece, dofs, oprsz, maxsz, in, NULL, 0);
-}
-
-void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t oprsz,
-                          uint32_t maxsz, TCGv_i64 in)
-{
-    check_size_align(oprsz, maxsz, dofs);
-    tcg_debug_assert(vece <=3D MO_64);
-    do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);
-}
-
-void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
-                          uint32_t oprsz, uint32_t maxsz)
-{
-    check_size_align(oprsz, maxsz, dofs);
-    if (vece <=3D MO_64) {
-        TCGType type =3D choose_vector_type(NULL, vece, oprsz, 0);
-        if (type !=3D 0) {
-            TCGv_vec t_vec =3D tcg_temp_new_vec(type);
-            tcg_gen_dup_mem_vec(vece, t_vec, cpu_env, aofs);
-            do_dup_store(type, dofs, oprsz, maxsz, t_vec);
-            tcg_temp_free_vec(t_vec);
-        } else if (vece <=3D MO_32) {
-            TCGv_i32 in =3D tcg_temp_new_i32();
-            switch (vece) {
-            case MO_8:
-                tcg_gen_ld8u_i32(in, cpu_env, aofs);
-                break;
-            case MO_16:
-                tcg_gen_ld16u_i32(in, cpu_env, aofs);
-                break;
-            default:
-                tcg_gen_ld_i32(in, cpu_env, aofs);
-                break;
-            }
-            do_dup(vece, dofs, oprsz, maxsz, in, NULL, 0);
-            tcg_temp_free_i32(in);
-        } else {
-            TCGv_i64 in =3D tcg_temp_new_i64();
-            tcg_gen_ld_i64(in, cpu_env, aofs);
-            do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);
-            tcg_temp_free_i64(in);
-        }
-    } else {
-        /* 128-bit duplicate.  */
-        /* ??? Dup to 256-bit vector.  */
-        int i;
-
-        tcg_debug_assert(vece =3D=3D 4);
-        tcg_debug_assert(oprsz >=3D 16);
-        if (TCG_TARGET_HAS_v128) {
-            TCGv_vec in =3D tcg_temp_new_vec(TCG_TYPE_V128);
-
-            tcg_gen_ld_vec(in, cpu_env, aofs);
-            for (i =3D 0; i < oprsz; i +=3D 16) {
-                tcg_gen_st_vec(in, cpu_env, dofs + i);
-            }
-            tcg_temp_free_vec(in);
-        } else {
-            TCGv_i64 in0 =3D tcg_temp_new_i64();
-            TCGv_i64 in1 =3D tcg_temp_new_i64();
-
-            tcg_gen_ld_i64(in0, cpu_env, aofs);
-            tcg_gen_ld_i64(in1, cpu_env, aofs + 8);
-            for (i =3D 0; i < oprsz; i +=3D 16) {
-                tcg_gen_st_i64(in0, cpu_env, dofs + i);
-                tcg_gen_st_i64(in1, cpu_env, dofs + i + 8);
-            }
-            tcg_temp_free_i64(in0);
-            tcg_temp_free_i64(in1);
-        }
-        if (oprsz < maxsz) {
-            expand_clr(dofs + oprsz, maxsz - oprsz);
-        }
-    }
-}
-
-void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
-                          uint32_t maxsz, uint64_t x)
-{
-    check_size_align(oprsz, maxsz, dofs);
-    do_dup(vece, dofs, oprsz, maxsz, NULL, NULL, x);
-}
-
-void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen2 g =3D {
-        .fni8 =3D tcg_gen_not_i64,
-        .fniv =3D tcg_gen_not_vec,
-        .fno =3D gen_helper_gvec_not,
-        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    };
-    tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g);
-}
-
-/* Perform a vector addition using normal addition and a mask.  The mask
-   should be the sign bit of each lane.  This 6-operation form is more
-   efficient than separate additions when there are 4 or more lanes in
-   the 64-bit operation.  */
-static void gen_addv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
-{
-    TCGv_i64 t1 =3D tcg_temp_new_i64();
-    TCGv_i64 t2 =3D tcg_temp_new_i64();
-    TCGv_i64 t3 =3D tcg_temp_new_i64();
-
-    tcg_gen_andc_i64(t1, a, m);
-    tcg_gen_andc_i64(t2, b, m);
-    tcg_gen_xor_i64(t3, a, b);
-    tcg_gen_add_i64(d, t1, t2);
-    tcg_gen_and_i64(t3, t3, m);
-    tcg_gen_xor_i64(d, d, t3);
-
-    tcg_temp_free_i64(t1);
-    tcg_temp_free_i64(t2);
-    tcg_temp_free_i64(t3);
-}
-
-void tcg_gen_vec_add8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_8, 0x80));
-    gen_addv_mask(d, a, b, m);
-    tcg_temp_free_i64(m);
-}
-
-void tcg_gen_vec_add16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_16, 0x8000));
-    gen_addv_mask(d, a, b, m);
-    tcg_temp_free_i64(m);
-}
-
-void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t1 =3D tcg_temp_new_i64();
-    TCGv_i64 t2 =3D tcg_temp_new_i64();
-
-    tcg_gen_andi_i64(t1, a, ~0xffffffffull);
-    tcg_gen_add_i64(t2, a, b);
-    tcg_gen_add_i64(t1, t1, b);
-    tcg_gen_deposit_i64(d, t1, t2, 0, 32);
-
-    tcg_temp_free_i64(t1);
-    tcg_temp_free_i64(t2);
-}
-
-static const TCGOpcode vecop_list_add[] =3D { INDEX_op_add_vec, 0 };
-
-void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen3 g[4] =3D {
-        { .fni8 =3D tcg_gen_vec_add8_i64,
-          .fniv =3D tcg_gen_add_vec,
-          .fno =3D gen_helper_gvec_add8,
-          .opt_opc =3D vecop_list_add,
-          .vece =3D MO_8 },
-        { .fni8 =3D tcg_gen_vec_add16_i64,
-          .fniv =3D tcg_gen_add_vec,
-          .fno =3D gen_helper_gvec_add16,
-          .opt_opc =3D vecop_list_add,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_add_i32,
-          .fniv =3D tcg_gen_add_vec,
-          .fno =3D gen_helper_gvec_add32,
-          .opt_opc =3D vecop_list_add,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_add_i64,
-          .fniv =3D tcg_gen_add_vec,
-          .fno =3D gen_helper_gvec_add64,
-          .opt_opc =3D vecop_list_add,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen2s g[4] =3D {
-        { .fni8 =3D tcg_gen_vec_add8_i64,
-          .fniv =3D tcg_gen_add_vec,
-          .fno =3D gen_helper_gvec_adds8,
-          .opt_opc =3D vecop_list_add,
-          .vece =3D MO_8 },
-        { .fni8 =3D tcg_gen_vec_add16_i64,
-          .fniv =3D tcg_gen_add_vec,
-          .fno =3D gen_helper_gvec_adds16,
-          .opt_opc =3D vecop_list_add,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_add_i32,
-          .fniv =3D tcg_gen_add_vec,
-          .fno =3D gen_helper_gvec_adds32,
-          .opt_opc =3D vecop_list_add,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_add_i64,
-          .fniv =3D tcg_gen_add_vec,
-          .fno =3D gen_helper_gvec_adds64,
-          .opt_opc =3D vecop_list_add,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g[vece]);
-}
-
-void tcg_gen_gvec_addi(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       int64_t c, uint32_t oprsz, uint32_t maxsz)
-{
-    TCGv_i64 tmp =3D tcg_const_i64(c);
-    tcg_gen_gvec_adds(vece, dofs, aofs, tmp, oprsz, maxsz);
-    tcg_temp_free_i64(tmp);
-}
-
-static const TCGOpcode vecop_list_sub[] =3D { INDEX_op_sub_vec, 0 };
-
-void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen2s g[4] =3D {
-        { .fni8 =3D tcg_gen_vec_sub8_i64,
-          .fniv =3D tcg_gen_sub_vec,
-          .fno =3D gen_helper_gvec_subs8,
-          .opt_opc =3D vecop_list_sub,
-          .vece =3D MO_8 },
-        { .fni8 =3D tcg_gen_vec_sub16_i64,
-          .fniv =3D tcg_gen_sub_vec,
-          .fno =3D gen_helper_gvec_subs16,
-          .opt_opc =3D vecop_list_sub,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_sub_i32,
-          .fniv =3D tcg_gen_sub_vec,
-          .fno =3D gen_helper_gvec_subs32,
-          .opt_opc =3D vecop_list_sub,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_sub_i64,
-          .fniv =3D tcg_gen_sub_vec,
-          .fno =3D gen_helper_gvec_subs64,
-          .opt_opc =3D vecop_list_sub,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g[vece]);
-}
-
-/* Perform a vector subtraction using normal subtraction and a mask.
-   Compare gen_addv_mask above.  */
-static void gen_subv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
-{
-    TCGv_i64 t1 =3D tcg_temp_new_i64();
-    TCGv_i64 t2 =3D tcg_temp_new_i64();
-    TCGv_i64 t3 =3D tcg_temp_new_i64();
-
-    tcg_gen_or_i64(t1, a, m);
-    tcg_gen_andc_i64(t2, b, m);
-    tcg_gen_eqv_i64(t3, a, b);
-    tcg_gen_sub_i64(d, t1, t2);
-    tcg_gen_and_i64(t3, t3, m);
-    tcg_gen_xor_i64(d, d, t3);
-
-    tcg_temp_free_i64(t1);
-    tcg_temp_free_i64(t2);
-    tcg_temp_free_i64(t3);
-}
-
-void tcg_gen_vec_sub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_8, 0x80));
-    gen_subv_mask(d, a, b, m);
-    tcg_temp_free_i64(m);
-}
-
-void tcg_gen_vec_sub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_16, 0x8000));
-    gen_subv_mask(d, a, b, m);
-    tcg_temp_free_i64(m);
-}
-
-void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t1 =3D tcg_temp_new_i64();
-    TCGv_i64 t2 =3D tcg_temp_new_i64();
-
-    tcg_gen_andi_i64(t1, b, ~0xffffffffull);
-    tcg_gen_sub_i64(t2, a, b);
-    tcg_gen_sub_i64(t1, a, t1);
-    tcg_gen_deposit_i64(d, t1, t2, 0, 32);
-
-    tcg_temp_free_i64(t1);
-    tcg_temp_free_i64(t2);
-}
-
-void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen3 g[4] =3D {
-        { .fni8 =3D tcg_gen_vec_sub8_i64,
-          .fniv =3D tcg_gen_sub_vec,
-          .fno =3D gen_helper_gvec_sub8,
-          .opt_opc =3D vecop_list_sub,
-          .vece =3D MO_8 },
-        { .fni8 =3D tcg_gen_vec_sub16_i64,
-          .fniv =3D tcg_gen_sub_vec,
-          .fno =3D gen_helper_gvec_sub16,
-          .opt_opc =3D vecop_list_sub,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_sub_i32,
-          .fniv =3D tcg_gen_sub_vec,
-          .fno =3D gen_helper_gvec_sub32,
-          .opt_opc =3D vecop_list_sub,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_sub_i64,
-          .fniv =3D tcg_gen_sub_vec,
-          .fno =3D gen_helper_gvec_sub64,
-          .opt_opc =3D vecop_list_sub,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-static const TCGOpcode vecop_list_mul[] =3D { INDEX_op_mul_vec, 0 };
-
-void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen3 g[4] =3D {
-        { .fniv =3D tcg_gen_mul_vec,
-          .fno =3D gen_helper_gvec_mul8,
-          .opt_opc =3D vecop_list_mul,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_mul_vec,
-          .fno =3D gen_helper_gvec_mul16,
-          .opt_opc =3D vecop_list_mul,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_mul_i32,
-          .fniv =3D tcg_gen_mul_vec,
-          .fno =3D gen_helper_gvec_mul32,
-          .opt_opc =3D vecop_list_mul,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_mul_i64,
-          .fniv =3D tcg_gen_mul_vec,
-          .fno =3D gen_helper_gvec_mul64,
-          .opt_opc =3D vecop_list_mul,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-void tcg_gen_gvec_muls(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen2s g[4] =3D {
-        { .fniv =3D tcg_gen_mul_vec,
-          .fno =3D gen_helper_gvec_muls8,
-          .opt_opc =3D vecop_list_mul,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_mul_vec,
-          .fno =3D gen_helper_gvec_muls16,
-          .opt_opc =3D vecop_list_mul,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_mul_i32,
-          .fniv =3D tcg_gen_mul_vec,
-          .fno =3D gen_helper_gvec_muls32,
-          .opt_opc =3D vecop_list_mul,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_mul_i64,
-          .fniv =3D tcg_gen_mul_vec,
-          .fno =3D gen_helper_gvec_muls64,
-          .opt_opc =3D vecop_list_mul,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g[vece]);
-}
-
-void tcg_gen_gvec_muli(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       int64_t c, uint32_t oprsz, uint32_t maxsz)
-{
-    TCGv_i64 tmp =3D tcg_const_i64(c);
-    tcg_gen_gvec_muls(vece, dofs, aofs, tmp, oprsz, maxsz);
-    tcg_temp_free_i64(tmp);
-}
-
-void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_ssadd_vec, 0 };
-    static const GVecGen3 g[4] =3D {
-        { .fniv =3D tcg_gen_ssadd_vec,
-          .fno =3D gen_helper_gvec_ssadd8,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_ssadd_vec,
-          .fno =3D gen_helper_gvec_ssadd16,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fniv =3D tcg_gen_ssadd_vec,
-          .fno =3D gen_helper_gvec_ssadd32,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fniv =3D tcg_gen_ssadd_vec,
-          .fno =3D gen_helper_gvec_ssadd64,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_64 },
-    };
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_sssub_vec, 0 };
-    static const GVecGen3 g[4] =3D {
-        { .fniv =3D tcg_gen_sssub_vec,
-          .fno =3D gen_helper_gvec_sssub8,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_sssub_vec,
-          .fno =3D gen_helper_gvec_sssub16,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fniv =3D tcg_gen_sssub_vec,
-          .fno =3D gen_helper_gvec_sssub32,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fniv =3D tcg_gen_sssub_vec,
-          .fno =3D gen_helper_gvec_sssub64,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_64 },
-    };
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-static void tcg_gen_usadd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 max =3D tcg_const_i32(-1);
-    tcg_gen_add_i32(d, a, b);
-    tcg_gen_movcond_i32(TCG_COND_LTU, d, d, a, max, d);
-    tcg_temp_free_i32(max);
-}
-
-static void tcg_gen_usadd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 max =3D tcg_const_i64(-1);
-    tcg_gen_add_i64(d, a, b);
-    tcg_gen_movcond_i64(TCG_COND_LTU, d, d, a, max, d);
-    tcg_temp_free_i64(max);
-}
-
-void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_usadd_vec, 0 };
-    static const GVecGen3 g[4] =3D {
-        { .fniv =3D tcg_gen_usadd_vec,
-          .fno =3D gen_helper_gvec_usadd8,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_usadd_vec,
-          .fno =3D gen_helper_gvec_usadd16,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_usadd_i32,
-          .fniv =3D tcg_gen_usadd_vec,
-          .fno =3D gen_helper_gvec_usadd32,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_usadd_i64,
-          .fniv =3D tcg_gen_usadd_vec,
-          .fno =3D gen_helper_gvec_usadd64,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_64 }
-    };
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-static void tcg_gen_ussub_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 min =3D tcg_const_i32(0);
-    tcg_gen_sub_i32(d, a, b);
-    tcg_gen_movcond_i32(TCG_COND_LTU, d, a, b, min, d);
-    tcg_temp_free_i32(min);
-}
-
-static void tcg_gen_ussub_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 min =3D tcg_const_i64(0);
-    tcg_gen_sub_i64(d, a, b);
-    tcg_gen_movcond_i64(TCG_COND_LTU, d, a, b, min, d);
-    tcg_temp_free_i64(min);
-}
-
-void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_ussub_vec, 0 };
-    static const GVecGen3 g[4] =3D {
-        { .fniv =3D tcg_gen_ussub_vec,
-          .fno =3D gen_helper_gvec_ussub8,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_ussub_vec,
-          .fno =3D gen_helper_gvec_ussub16,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_ussub_i32,
-          .fniv =3D tcg_gen_ussub_vec,
-          .fno =3D gen_helper_gvec_ussub32,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_ussub_i64,
-          .fniv =3D tcg_gen_ussub_vec,
-          .fno =3D gen_helper_gvec_ussub64,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_64 }
-    };
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_smin_vec, 0 };
-    static const GVecGen3 g[4] =3D {
-        { .fniv =3D tcg_gen_smin_vec,
-          .fno =3D gen_helper_gvec_smin8,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_smin_vec,
-          .fno =3D gen_helper_gvec_smin16,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_smin_i32,
-          .fniv =3D tcg_gen_smin_vec,
-          .fno =3D gen_helper_gvec_smin32,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_smin_i64,
-          .fniv =3D tcg_gen_smin_vec,
-          .fno =3D gen_helper_gvec_smin64,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_64 }
-    };
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_umin_vec, 0 };
-    static const GVecGen3 g[4] =3D {
-        { .fniv =3D tcg_gen_umin_vec,
-          .fno =3D gen_helper_gvec_umin8,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_umin_vec,
-          .fno =3D gen_helper_gvec_umin16,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_umin_i32,
-          .fniv =3D tcg_gen_umin_vec,
-          .fno =3D gen_helper_gvec_umin32,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_umin_i64,
-          .fniv =3D tcg_gen_umin_vec,
-          .fno =3D gen_helper_gvec_umin64,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_64 }
-    };
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_smax_vec, 0 };
-    static const GVecGen3 g[4] =3D {
-        { .fniv =3D tcg_gen_smax_vec,
-          .fno =3D gen_helper_gvec_smax8,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_smax_vec,
-          .fno =3D gen_helper_gvec_smax16,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_smax_i32,
-          .fniv =3D tcg_gen_smax_vec,
-          .fno =3D gen_helper_gvec_smax32,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_smax_i64,
-          .fniv =3D tcg_gen_smax_vec,
-          .fno =3D gen_helper_gvec_smax64,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_64 }
-    };
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_umax_vec, 0 };
-    static const GVecGen3 g[4] =3D {
-        { .fniv =3D tcg_gen_umax_vec,
-          .fno =3D gen_helper_gvec_umax8,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_umax_vec,
-          .fno =3D gen_helper_gvec_umax16,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_umax_i32,
-          .fniv =3D tcg_gen_umax_vec,
-          .fno =3D gen_helper_gvec_umax32,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_umax_i64,
-          .fniv =3D tcg_gen_umax_vec,
-          .fno =3D gen_helper_gvec_umax64,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_64 }
-    };
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-/* Perform a vector negation using normal negation and a mask.
-   Compare gen_subv_mask above.  */
-static void gen_negv_mask(TCGv_i64 d, TCGv_i64 b, TCGv_i64 m)
-{
-    TCGv_i64 t2 =3D tcg_temp_new_i64();
-    TCGv_i64 t3 =3D tcg_temp_new_i64();
-
-    tcg_gen_andc_i64(t3, m, b);
-    tcg_gen_andc_i64(t2, b, m);
-    tcg_gen_sub_i64(d, m, t2);
-    tcg_gen_xor_i64(d, d, t3);
-
-    tcg_temp_free_i64(t2);
-    tcg_temp_free_i64(t3);
-}
-
-void tcg_gen_vec_neg8_i64(TCGv_i64 d, TCGv_i64 b)
-{
-    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_8, 0x80));
-    gen_negv_mask(d, b, m);
-    tcg_temp_free_i64(m);
-}
-
-void tcg_gen_vec_neg16_i64(TCGv_i64 d, TCGv_i64 b)
-{
-    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_16, 0x8000));
-    gen_negv_mask(d, b, m);
-    tcg_temp_free_i64(m);
-}
-
-void tcg_gen_vec_neg32_i64(TCGv_i64 d, TCGv_i64 b)
-{
-    TCGv_i64 t1 =3D tcg_temp_new_i64();
-    TCGv_i64 t2 =3D tcg_temp_new_i64();
-
-    tcg_gen_andi_i64(t1, b, ~0xffffffffull);
-    tcg_gen_neg_i64(t2, b);
-    tcg_gen_neg_i64(t1, t1);
-    tcg_gen_deposit_i64(d, t1, t2, 0, 32);
-
-    tcg_temp_free_i64(t1);
-    tcg_temp_free_i64(t2);
-}
-
-void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_neg_vec, 0 };
-    static const GVecGen2 g[4] =3D {
-        { .fni8 =3D tcg_gen_vec_neg8_i64,
-          .fniv =3D tcg_gen_neg_vec,
-          .fno =3D gen_helper_gvec_neg8,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fni8 =3D tcg_gen_vec_neg16_i64,
-          .fniv =3D tcg_gen_neg_vec,
-          .fno =3D gen_helper_gvec_neg16,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_neg_i32,
-          .fniv =3D tcg_gen_neg_vec,
-          .fno =3D gen_helper_gvec_neg32,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_neg_i64,
-          .fniv =3D tcg_gen_neg_vec,
-          .fno =3D gen_helper_gvec_neg64,
-          .opt_opc =3D vecop_list,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g[vece]);
-}
-
-static void gen_absv_mask(TCGv_i64 d, TCGv_i64 b, unsigned vece)
-{
-    TCGv_i64 t =3D tcg_temp_new_i64();
-    int nbit =3D 8 << vece;
-
-    /* Create -1 for each negative element.  */
-    tcg_gen_shri_i64(t, b, nbit - 1);
-    tcg_gen_andi_i64(t, t, dup_const(vece, 1));
-    tcg_gen_muli_i64(t, t, (1 << nbit) - 1);
-
-    /*
-     * Invert (via xor -1) and add one (via sub -1).
-     * Because of the ordering the msb is cleared,
-     * so we never have carry into the next element.
-     */
-    tcg_gen_xor_i64(d, b, t);
-    tcg_gen_sub_i64(d, d, t);
-
-    tcg_temp_free_i64(t);
-}
-
-static void tcg_gen_vec_abs8_i64(TCGv_i64 d, TCGv_i64 b)
-{
-    gen_absv_mask(d, b, MO_8);
-}
-
-static void tcg_gen_vec_abs16_i64(TCGv_i64 d, TCGv_i64 b)
-{
-    gen_absv_mask(d, b, MO_16);
-}
-
-void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_abs_vec, 0 };
-    static const GVecGen2 g[4] =3D {
-        { .fni8 =3D tcg_gen_vec_abs8_i64,
-          .fniv =3D tcg_gen_abs_vec,
-          .fno =3D gen_helper_gvec_abs8,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fni8 =3D tcg_gen_vec_abs16_i64,
-          .fniv =3D tcg_gen_abs_vec,
-          .fno =3D gen_helper_gvec_abs16,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_abs_i32,
-          .fniv =3D tcg_gen_abs_vec,
-          .fno =3D gen_helper_gvec_abs32,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_abs_i64,
-          .fniv =3D tcg_gen_abs_vec,
-          .fno =3D gen_helper_gvec_abs64,
-          .opt_opc =3D vecop_list,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g[vece]);
-}
-
-void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen3 g =3D {
-        .fni8 =3D tcg_gen_and_i64,
-        .fniv =3D tcg_gen_and_vec,
-        .fno =3D gen_helper_gvec_and,
-        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    };
-
-    if (aofs =3D=3D bofs) {
-        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
-    } else {
-        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
-    }
-}
-
-void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,
-                     uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen3 g =3D {
-        .fni8 =3D tcg_gen_or_i64,
-        .fniv =3D tcg_gen_or_vec,
-        .fno =3D gen_helper_gvec_or,
-        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    };
-
-    if (aofs =3D=3D bofs) {
-        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
-    } else {
-        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
-    }
-}
-
-void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen3 g =3D {
-        .fni8 =3D tcg_gen_xor_i64,
-        .fniv =3D tcg_gen_xor_vec,
-        .fno =3D gen_helper_gvec_xor,
-        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    };
-
-    if (aofs =3D=3D bofs) {
-        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, 0);
-    } else {
-        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
-    }
-}
-
-void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen3 g =3D {
-        .fni8 =3D tcg_gen_andc_i64,
-        .fniv =3D tcg_gen_andc_vec,
-        .fno =3D gen_helper_gvec_andc,
-        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    };
-
-    if (aofs =3D=3D bofs) {
-        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, 0);
-    } else {
-        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
-    }
-}
-
-void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen3 g =3D {
-        .fni8 =3D tcg_gen_orc_i64,
-        .fniv =3D tcg_gen_orc_vec,
-        .fno =3D gen_helper_gvec_orc,
-        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    };
-
-    if (aofs =3D=3D bofs) {
-        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, -1);
-    } else {
-        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
-    }
-}
-
-void tcg_gen_gvec_nand(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen3 g =3D {
-        .fni8 =3D tcg_gen_nand_i64,
-        .fniv =3D tcg_gen_nand_vec,
-        .fno =3D gen_helper_gvec_nand,
-        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    };
-
-    if (aofs =3D=3D bofs) {
-        tcg_gen_gvec_not(vece, dofs, aofs, oprsz, maxsz);
-    } else {
-        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
-    }
-}
-
-void tcg_gen_gvec_nor(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen3 g =3D {
-        .fni8 =3D tcg_gen_nor_i64,
-        .fniv =3D tcg_gen_nor_vec,
-        .fno =3D gen_helper_gvec_nor,
-        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    };
-
-    if (aofs =3D=3D bofs) {
-        tcg_gen_gvec_not(vece, dofs, aofs, oprsz, maxsz);
-    } else {
-        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
-    }
-}
-
-void tcg_gen_gvec_eqv(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen3 g =3D {
-        .fni8 =3D tcg_gen_eqv_i64,
-        .fniv =3D tcg_gen_eqv_vec,
-        .fno =3D gen_helper_gvec_eqv,
-        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    };
-
-    if (aofs =3D=3D bofs) {
-        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, -1);
-    } else {
-        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
-    }
-}
-
-static const GVecGen2s gop_ands =3D {
-    .fni8 =3D tcg_gen_and_i64,
-    .fniv =3D tcg_gen_and_vec,
-    .fno =3D gen_helper_gvec_ands,
-    .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    .vece =3D MO_64
-};
-
-void tcg_gen_gvec_ands(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)
-{
-    TCGv_i64 tmp =3D tcg_temp_new_i64();
-    gen_dup_i64(vece, tmp, c);
-    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_ands);
-    tcg_temp_free_i64(tmp);
-}
-
-void tcg_gen_gvec_andi(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       int64_t c, uint32_t oprsz, uint32_t maxsz)
-{
-    TCGv_i64 tmp =3D tcg_const_i64(dup_const(vece, c));
-    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_ands);
-    tcg_temp_free_i64(tmp);
-}
-
-static const GVecGen2s gop_xors =3D {
-    .fni8 =3D tcg_gen_xor_i64,
-    .fniv =3D tcg_gen_xor_vec,
-    .fno =3D gen_helper_gvec_xors,
-    .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    .vece =3D MO_64
-};
-
-void tcg_gen_gvec_xors(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)
-{
-    TCGv_i64 tmp =3D tcg_temp_new_i64();
-    gen_dup_i64(vece, tmp, c);
-    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_xors);
-    tcg_temp_free_i64(tmp);
-}
-
-void tcg_gen_gvec_xori(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       int64_t c, uint32_t oprsz, uint32_t maxsz)
-{
-    TCGv_i64 tmp =3D tcg_const_i64(dup_const(vece, c));
-    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_xors);
-    tcg_temp_free_i64(tmp);
-}
-
-static const GVecGen2s gop_ors =3D {
-    .fni8 =3D tcg_gen_or_i64,
-    .fniv =3D tcg_gen_or_vec,
-    .fno =3D gen_helper_gvec_ors,
-    .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    .vece =3D MO_64
-};
-
-void tcg_gen_gvec_ors(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)
-{
-    TCGv_i64 tmp =3D tcg_temp_new_i64();
-    gen_dup_i64(vece, tmp, c);
-    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_ors);
-    tcg_temp_free_i64(tmp);
-}
-
-void tcg_gen_gvec_ori(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      int64_t c, uint32_t oprsz, uint32_t maxsz)
-{
-    TCGv_i64 tmp =3D tcg_const_i64(dup_const(vece, c));
-    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_ors);
-    tcg_temp_free_i64(tmp);
-}
-
-void tcg_gen_vec_shl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
-{
-    uint64_t mask =3D dup_const(MO_8, 0xff << c);
-    tcg_gen_shli_i64(d, a, c);
-    tcg_gen_andi_i64(d, d, mask);
-}
-
-void tcg_gen_vec_shl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
-{
-    uint64_t mask =3D dup_const(MO_16, 0xffff << c);
-    tcg_gen_shli_i64(d, a, c);
-    tcg_gen_andi_i64(d, d, mask);
-}
-
-void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       int64_t shift, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_shli_vec, 0 };
-    static const GVecGen2i g[4] =3D {
-        { .fni8 =3D tcg_gen_vec_shl8i_i64,
-          .fniv =3D tcg_gen_shli_vec,
-          .fno =3D gen_helper_gvec_shl8i,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fni8 =3D tcg_gen_vec_shl16i_i64,
-          .fniv =3D tcg_gen_shli_vec,
-          .fno =3D gen_helper_gvec_shl16i,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_shli_i32,
-          .fniv =3D tcg_gen_shli_vec,
-          .fno =3D gen_helper_gvec_shl32i,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_shli_i64,
-          .fniv =3D tcg_gen_shli_vec,
-          .fno =3D gen_helper_gvec_shl64i,
-          .opt_opc =3D vecop_list,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));
-    if (shift =3D=3D 0) {
-        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
-    } else {
-        tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, shift, &g[vece]);
-    }
-}
-
-void tcg_gen_vec_shr8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
-{
-    uint64_t mask =3D dup_const(MO_8, 0xff >> c);
-    tcg_gen_shri_i64(d, a, c);
-    tcg_gen_andi_i64(d, d, mask);
-}
-
-void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
-{
-    uint64_t mask =3D dup_const(MO_16, 0xffff >> c);
-    tcg_gen_shri_i64(d, a, c);
-    tcg_gen_andi_i64(d, d, mask);
-}
-
-void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       int64_t shift, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_shri_vec, 0 };
-    static const GVecGen2i g[4] =3D {
-        { .fni8 =3D tcg_gen_vec_shr8i_i64,
-          .fniv =3D tcg_gen_shri_vec,
-          .fno =3D gen_helper_gvec_shr8i,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fni8 =3D tcg_gen_vec_shr16i_i64,
-          .fniv =3D tcg_gen_shri_vec,
-          .fno =3D gen_helper_gvec_shr16i,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_shri_i32,
-          .fniv =3D tcg_gen_shri_vec,
-          .fno =3D gen_helper_gvec_shr32i,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_shri_i64,
-          .fniv =3D tcg_gen_shri_vec,
-          .fno =3D gen_helper_gvec_shr64i,
-          .opt_opc =3D vecop_list,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));
-    if (shift =3D=3D 0) {
-        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
-    } else {
-        tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, shift, &g[vece]);
-    }
-}
-
-void tcg_gen_vec_sar8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
-{
-    uint64_t s_mask =3D dup_const(MO_8, 0x80 >> c);
-    uint64_t c_mask =3D dup_const(MO_8, 0xff >> c);
-    TCGv_i64 s =3D tcg_temp_new_i64();
-
-    tcg_gen_shri_i64(d, a, c);
-    tcg_gen_andi_i64(s, d, s_mask);  /* isolate (shifted) sign bit */
-    tcg_gen_muli_i64(s, s, (2 << c) - 2); /* replicate isolated signs */
-    tcg_gen_andi_i64(d, d, c_mask);  /* clear out bits above sign  */
-    tcg_gen_or_i64(d, d, s);         /* include sign extension */
-    tcg_temp_free_i64(s);
-}
-
-void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
-{
-    uint64_t s_mask =3D dup_const(MO_16, 0x8000 >> c);
-    uint64_t c_mask =3D dup_const(MO_16, 0xffff >> c);
-    TCGv_i64 s =3D tcg_temp_new_i64();
-
-    tcg_gen_shri_i64(d, a, c);
-    tcg_gen_andi_i64(s, d, s_mask);  /* isolate (shifted) sign bit */
-    tcg_gen_andi_i64(d, d, c_mask);  /* clear out bits above sign  */
-    tcg_gen_muli_i64(s, s, (2 << c) - 2); /* replicate isolated signs */
-    tcg_gen_or_i64(d, d, s);         /* include sign extension */
-    tcg_temp_free_i64(s);
-}
-
-void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       int64_t shift, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_sari_vec, 0 };
-    static const GVecGen2i g[4] =3D {
-        { .fni8 =3D tcg_gen_vec_sar8i_i64,
-          .fniv =3D tcg_gen_sari_vec,
-          .fno =3D gen_helper_gvec_sar8i,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fni8 =3D tcg_gen_vec_sar16i_i64,
-          .fniv =3D tcg_gen_sari_vec,
-          .fno =3D gen_helper_gvec_sar16i,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_sari_i32,
-          .fniv =3D tcg_gen_sari_vec,
-          .fno =3D gen_helper_gvec_sar32i,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_sari_i64,
-          .fniv =3D tcg_gen_sari_vec,
-          .fno =3D gen_helper_gvec_sar64i,
-          .opt_opc =3D vecop_list,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));
-    if (shift =3D=3D 0) {
-        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
-    } else {
-        tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, shift, &g[vece]);
-    }
-}
-
-void tcg_gen_vec_rotl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
-{
-    uint64_t mask =3D dup_const(MO_8, 0xff << c);
-
-    tcg_gen_shli_i64(d, a, c);
-    tcg_gen_shri_i64(a, a, 8 - c);
-    tcg_gen_andi_i64(d, d, mask);
-    tcg_gen_andi_i64(a, a, ~mask);
-    tcg_gen_or_i64(d, d, a);
-}
-
-void tcg_gen_vec_rotl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
-{
-    uint64_t mask =3D dup_const(MO_16, 0xffff << c);
-
-    tcg_gen_shli_i64(d, a, c);
-    tcg_gen_shri_i64(a, a, 16 - c);
-    tcg_gen_andi_i64(d, d, mask);
-    tcg_gen_andi_i64(a, a, ~mask);
-    tcg_gen_or_i64(d, d, a);
-}
-
-void tcg_gen_gvec_rotli(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        int64_t shift, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_rotli_vec, 0 };
-    static const GVecGen2i g[4] =3D {
-        { .fni8 =3D tcg_gen_vec_rotl8i_i64,
-          .fniv =3D tcg_gen_rotli_vec,
-          .fno =3D gen_helper_gvec_rotl8i,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fni8 =3D tcg_gen_vec_rotl16i_i64,
-          .fniv =3D tcg_gen_rotli_vec,
-          .fno =3D gen_helper_gvec_rotl16i,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_rotli_i32,
-          .fniv =3D tcg_gen_rotli_vec,
-          .fno =3D gen_helper_gvec_rotl32i,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_rotli_i64,
-          .fniv =3D tcg_gen_rotli_vec,
-          .fno =3D gen_helper_gvec_rotl64i,
-          .opt_opc =3D vecop_list,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));
-    if (shift =3D=3D 0) {
-        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
-    } else {
-        tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, shift, &g[vece]);
-    }
-}
-
-void tcg_gen_gvec_rotri(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        int64_t shift, uint32_t oprsz, uint32_t maxsz)
-{
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));
-    tcg_gen_gvec_rotli(vece, dofs, aofs, -shift & ((8 << vece) - 1),
-                       oprsz, maxsz);
-}
-
-/*
- * Specialized generation vector shifts by a non-constant scalar.
- */
-
-typedef struct {
-    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32);
-    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64);
-    void (*fniv_s)(unsigned, TCGv_vec, TCGv_vec, TCGv_i32);
-    void (*fniv_v)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);
-    gen_helper_gvec_2 *fno[4];
-    TCGOpcode s_list[2];
-    TCGOpcode v_list[2];
-} GVecGen2sh;
-
-static void expand_2sh_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
-                           uint32_t oprsz, uint32_t tysz, TCGType type,
-                           TCGv_i32 shift,
-                           void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_=
i32))
-{
-    TCGv_vec t0 =3D tcg_temp_new_vec(type);
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D tysz) {
-        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
-        fni(vece, t0, t0, shift);
-        tcg_gen_st_vec(t0, cpu_env, dofs + i);
-    }
-    tcg_temp_free_vec(t0);
-}
-
-static void
-do_gvec_shifts(unsigned vece, uint32_t dofs, uint32_t aofs, TCGv_i32 shift,
-               uint32_t oprsz, uint32_t maxsz, const GVecGen2sh *g)
-{
-    TCGType type;
-    uint32_t some;
-
-    check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(dofs, aofs, maxsz);
-
-    /* If the backend has a scalar expansion, great.  */
-    type =3D choose_vector_type(g->s_list, vece, oprsz, vece =3D=3D MO_64);
-    if (type) {
-        const TCGOpcode *hold_list =3D tcg_swap_vecop_list(NULL);
-        switch (type) {
-        case TCG_TYPE_V256:
-            some =3D QEMU_ALIGN_DOWN(oprsz, 32);
-            expand_2sh_vec(vece, dofs, aofs, some, 32,
-                           TCG_TYPE_V256, shift, g->fniv_s);
-            if (some =3D=3D oprsz) {
-                break;
-            }
-            dofs +=3D some;
-            aofs +=3D some;
-            oprsz -=3D some;
-            maxsz -=3D some;
-            /* fallthru */
-        case TCG_TYPE_V128:
-            expand_2sh_vec(vece, dofs, aofs, oprsz, 16,
-                           TCG_TYPE_V128, shift, g->fniv_s);
-            break;
-        case TCG_TYPE_V64:
-            expand_2sh_vec(vece, dofs, aofs, oprsz, 8,
-                           TCG_TYPE_V64, shift, g->fniv_s);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        tcg_swap_vecop_list(hold_list);
-        goto clear_tail;
-    }
-
-    /* If the backend supports variable vector shifts, also cool.  */
-    type =3D choose_vector_type(g->v_list, vece, oprsz, vece =3D=3D MO_64);
-    if (type) {
-        const TCGOpcode *hold_list =3D tcg_swap_vecop_list(NULL);
-        TCGv_vec v_shift =3D tcg_temp_new_vec(type);
-
-        if (vece =3D=3D MO_64) {
-            TCGv_i64 sh64 =3D tcg_temp_new_i64();
-            tcg_gen_extu_i32_i64(sh64, shift);
-            tcg_gen_dup_i64_vec(MO_64, v_shift, sh64);
-            tcg_temp_free_i64(sh64);
-        } else {
-            tcg_gen_dup_i32_vec(vece, v_shift, shift);
-        }
-
-        switch (type) {
-        case TCG_TYPE_V256:
-            some =3D QEMU_ALIGN_DOWN(oprsz, 32);
-            expand_2s_vec(vece, dofs, aofs, some, 32, TCG_TYPE_V256,
-                          v_shift, false, g->fniv_v);
-            if (some =3D=3D oprsz) {
-                break;
-            }
-            dofs +=3D some;
-            aofs +=3D some;
-            oprsz -=3D some;
-            maxsz -=3D some;
-            /* fallthru */
-        case TCG_TYPE_V128:
-            expand_2s_vec(vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
-                          v_shift, false, g->fniv_v);
-            break;
-        case TCG_TYPE_V64:
-            expand_2s_vec(vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
-                          v_shift, false, g->fniv_v);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        tcg_temp_free_vec(v_shift);
-        tcg_swap_vecop_list(hold_list);
-        goto clear_tail;
-    }
-
-    /* Otherwise fall back to integral... */
-    if (vece =3D=3D MO_32 && check_size_impl(oprsz, 4)) {
-        expand_2s_i32(dofs, aofs, oprsz, shift, false, g->fni4);
-    } else if (vece =3D=3D MO_64 && check_size_impl(oprsz, 8)) {
-        TCGv_i64 sh64 =3D tcg_temp_new_i64();
-        tcg_gen_extu_i32_i64(sh64, shift);
-        expand_2s_i64(dofs, aofs, oprsz, sh64, false, g->fni8);
-        tcg_temp_free_i64(sh64);
-    } else {
-        TCGv_ptr a0 =3D tcg_temp_new_ptr();
-        TCGv_ptr a1 =3D tcg_temp_new_ptr();
-        TCGv_i32 desc =3D tcg_temp_new_i32();
-
-        tcg_gen_shli_i32(desc, shift, SIMD_DATA_SHIFT);
-        tcg_gen_ori_i32(desc, desc, simd_desc(oprsz, maxsz, 0));
-        tcg_gen_addi_ptr(a0, cpu_env, dofs);
-        tcg_gen_addi_ptr(a1, cpu_env, aofs);
-
-        g->fno[vece](a0, a1, desc);
-
-        tcg_temp_free_ptr(a0);
-        tcg_temp_free_ptr(a1);
-        tcg_temp_free_i32(desc);
-        return;
-    }
-
- clear_tail:
-    if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
-    }
-}
-
-void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen2sh g =3D {
-        .fni4 =3D tcg_gen_shl_i32,
-        .fni8 =3D tcg_gen_shl_i64,
-        .fniv_s =3D tcg_gen_shls_vec,
-        .fniv_v =3D tcg_gen_shlv_vec,
-        .fno =3D {
-            gen_helper_gvec_shl8i,
-            gen_helper_gvec_shl16i,
-            gen_helper_gvec_shl32i,
-            gen_helper_gvec_shl64i,
-        },
-        .s_list =3D { INDEX_op_shls_vec, 0 },
-        .v_list =3D { INDEX_op_shlv_vec, 0 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);
-}
-
-void tcg_gen_gvec_shrs(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen2sh g =3D {
-        .fni4 =3D tcg_gen_shr_i32,
-        .fni8 =3D tcg_gen_shr_i64,
-        .fniv_s =3D tcg_gen_shrs_vec,
-        .fniv_v =3D tcg_gen_shrv_vec,
-        .fno =3D {
-            gen_helper_gvec_shr8i,
-            gen_helper_gvec_shr16i,
-            gen_helper_gvec_shr32i,
-            gen_helper_gvec_shr64i,
-        },
-        .s_list =3D { INDEX_op_shrs_vec, 0 },
-        .v_list =3D { INDEX_op_shrv_vec, 0 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);
-}
-
-void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen2sh g =3D {
-        .fni4 =3D tcg_gen_sar_i32,
-        .fni8 =3D tcg_gen_sar_i64,
-        .fniv_s =3D tcg_gen_sars_vec,
-        .fniv_v =3D tcg_gen_sarv_vec,
-        .fno =3D {
-            gen_helper_gvec_sar8i,
-            gen_helper_gvec_sar16i,
-            gen_helper_gvec_sar32i,
-            gen_helper_gvec_sar64i,
-        },
-        .s_list =3D { INDEX_op_sars_vec, 0 },
-        .v_list =3D { INDEX_op_sarv_vec, 0 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);
-}
-
-void tcg_gen_gvec_rotls(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen2sh g =3D {
-        .fni4 =3D tcg_gen_rotl_i32,
-        .fni8 =3D tcg_gen_rotl_i64,
-        .fniv_s =3D tcg_gen_rotls_vec,
-        .fniv_v =3D tcg_gen_rotlv_vec,
-        .fno =3D {
-            gen_helper_gvec_rotl8i,
-            gen_helper_gvec_rotl16i,
-            gen_helper_gvec_rotl32i,
-            gen_helper_gvec_rotl64i,
-        },
-        .s_list =3D { INDEX_op_rotls_vec, 0 },
-        .v_list =3D { INDEX_op_rotlv_vec, 0 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);
-}
-
-/*
- * Expand D =3D A << (B % element bits)
- *
- * Unlike scalar shifts, where it is easy for the target front end
- * to include the modulo as part of the expansion.  If the target
- * naturally includes the modulo as part of the operation, great!
- * If the target has some other behaviour from out-of-range shifts,
- * then it could not use this function anyway, and would need to
- * do it's own expansion with custom functions.
- */
-static void tcg_gen_shlv_mod_vec(unsigned vece, TCGv_vec d,
-                                 TCGv_vec a, TCGv_vec b)
-{
-    TCGv_vec t =3D tcg_temp_new_vec_matching(d);
-
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
-    tcg_gen_shlv_vec(vece, d, a, t);
-    tcg_temp_free_vec(t);
-}
-
-static void tcg_gen_shl_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t =3D tcg_temp_new_i32();
-
-    tcg_gen_andi_i32(t, b, 31);
-    tcg_gen_shl_i32(d, a, t);
-    tcg_temp_free_i32(t);
-}
-
-static void tcg_gen_shl_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t =3D tcg_temp_new_i64();
-
-    tcg_gen_andi_i64(t, b, 63);
-    tcg_gen_shl_i64(d, a, t);
-    tcg_temp_free_i64(t);
-}
-
-void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_shlv_vec, 0 };
-    static const GVecGen3 g[4] =3D {
-        { .fniv =3D tcg_gen_shlv_mod_vec,
-          .fno =3D gen_helper_gvec_shl8v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_shlv_mod_vec,
-          .fno =3D gen_helper_gvec_shl16v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_shl_mod_i32,
-          .fniv =3D tcg_gen_shlv_mod_vec,
-          .fno =3D gen_helper_gvec_shl32v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_shl_mod_i64,
-          .fniv =3D tcg_gen_shlv_mod_vec,
-          .fno =3D gen_helper_gvec_shl64v,
-          .opt_opc =3D vecop_list,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-/*
- * Similarly for logical right shifts.
- */
-
-static void tcg_gen_shrv_mod_vec(unsigned vece, TCGv_vec d,
-                                 TCGv_vec a, TCGv_vec b)
-{
-    TCGv_vec t =3D tcg_temp_new_vec_matching(d);
-
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
-    tcg_gen_shrv_vec(vece, d, a, t);
-    tcg_temp_free_vec(t);
-}
-
-static void tcg_gen_shr_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t =3D tcg_temp_new_i32();
-
-    tcg_gen_andi_i32(t, b, 31);
-    tcg_gen_shr_i32(d, a, t);
-    tcg_temp_free_i32(t);
-}
-
-static void tcg_gen_shr_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t =3D tcg_temp_new_i64();
-
-    tcg_gen_andi_i64(t, b, 63);
-    tcg_gen_shr_i64(d, a, t);
-    tcg_temp_free_i64(t);
-}
-
-void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_shrv_vec, 0 };
-    static const GVecGen3 g[4] =3D {
-        { .fniv =3D tcg_gen_shrv_mod_vec,
-          .fno =3D gen_helper_gvec_shr8v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_shrv_mod_vec,
-          .fno =3D gen_helper_gvec_shr16v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_shr_mod_i32,
-          .fniv =3D tcg_gen_shrv_mod_vec,
-          .fno =3D gen_helper_gvec_shr32v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_shr_mod_i64,
-          .fniv =3D tcg_gen_shrv_mod_vec,
-          .fno =3D gen_helper_gvec_shr64v,
-          .opt_opc =3D vecop_list,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-/*
- * Similarly for arithmetic right shifts.
- */
-
-static void tcg_gen_sarv_mod_vec(unsigned vece, TCGv_vec d,
-                                 TCGv_vec a, TCGv_vec b)
-{
-    TCGv_vec t =3D tcg_temp_new_vec_matching(d);
-
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
-    tcg_gen_sarv_vec(vece, d, a, t);
-    tcg_temp_free_vec(t);
-}
-
-static void tcg_gen_sar_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t =3D tcg_temp_new_i32();
-
-    tcg_gen_andi_i32(t, b, 31);
-    tcg_gen_sar_i32(d, a, t);
-    tcg_temp_free_i32(t);
-}
-
-static void tcg_gen_sar_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t =3D tcg_temp_new_i64();
-
-    tcg_gen_andi_i64(t, b, 63);
-    tcg_gen_sar_i64(d, a, t);
-    tcg_temp_free_i64(t);
-}
-
-void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_sarv_vec, 0 };
-    static const GVecGen3 g[4] =3D {
-        { .fniv =3D tcg_gen_sarv_mod_vec,
-          .fno =3D gen_helper_gvec_sar8v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_sarv_mod_vec,
-          .fno =3D gen_helper_gvec_sar16v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_sar_mod_i32,
-          .fniv =3D tcg_gen_sarv_mod_vec,
-          .fno =3D gen_helper_gvec_sar32v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_sar_mod_i64,
-          .fniv =3D tcg_gen_sarv_mod_vec,
-          .fno =3D gen_helper_gvec_sar64v,
-          .opt_opc =3D vecop_list,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-/*
- * Similarly for rotates.
- */
-
-static void tcg_gen_rotlv_mod_vec(unsigned vece, TCGv_vec d,
-                                  TCGv_vec a, TCGv_vec b)
-{
-    TCGv_vec t =3D tcg_temp_new_vec_matching(d);
-
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
-    tcg_gen_rotlv_vec(vece, d, a, t);
-    tcg_temp_free_vec(t);
-}
-
-static void tcg_gen_rotl_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t =3D tcg_temp_new_i32();
-
-    tcg_gen_andi_i32(t, b, 31);
-    tcg_gen_rotl_i32(d, a, t);
-    tcg_temp_free_i32(t);
-}
-
-static void tcg_gen_rotl_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t =3D tcg_temp_new_i64();
-
-    tcg_gen_andi_i64(t, b, 63);
-    tcg_gen_rotl_i64(d, a, t);
-    tcg_temp_free_i64(t);
-}
-
-void tcg_gen_gvec_rotlv(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_rotlv_vec, 0 };
-    static const GVecGen3 g[4] =3D {
-        { .fniv =3D tcg_gen_rotlv_mod_vec,
-          .fno =3D gen_helper_gvec_rotl8v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_rotlv_mod_vec,
-          .fno =3D gen_helper_gvec_rotl16v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_rotl_mod_i32,
-          .fniv =3D tcg_gen_rotlv_mod_vec,
-          .fno =3D gen_helper_gvec_rotl32v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_rotl_mod_i64,
-          .fniv =3D tcg_gen_rotlv_mod_vec,
-          .fno =3D gen_helper_gvec_rotl64v,
-          .opt_opc =3D vecop_list,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-static void tcg_gen_rotrv_mod_vec(unsigned vece, TCGv_vec d,
-                                  TCGv_vec a, TCGv_vec b)
-{
-    TCGv_vec t =3D tcg_temp_new_vec_matching(d);
-
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
-    tcg_gen_rotrv_vec(vece, d, a, t);
-    tcg_temp_free_vec(t);
-}
-
-static void tcg_gen_rotr_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t =3D tcg_temp_new_i32();
-
-    tcg_gen_andi_i32(t, b, 31);
-    tcg_gen_rotr_i32(d, a, t);
-    tcg_temp_free_i32(t);
-}
-
-static void tcg_gen_rotr_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t =3D tcg_temp_new_i64();
-
-    tcg_gen_andi_i64(t, b, 63);
-    tcg_gen_rotr_i64(d, a, t);
-    tcg_temp_free_i64(t);
-}
-
-void tcg_gen_gvec_rotrv(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode vecop_list[] =3D { INDEX_op_rotrv_vec, 0 };
-    static const GVecGen3 g[4] =3D {
-        { .fniv =3D tcg_gen_rotrv_mod_vec,
-          .fno =3D gen_helper_gvec_rotr8v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
-        { .fniv =3D tcg_gen_rotrv_mod_vec,
-          .fno =3D gen_helper_gvec_rotr16v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
-        { .fni4 =3D tcg_gen_rotr_mod_i32,
-          .fniv =3D tcg_gen_rotrv_mod_vec,
-          .fno =3D gen_helper_gvec_rotr32v,
-          .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
-        { .fni8 =3D tcg_gen_rotr_mod_i64,
-          .fniv =3D tcg_gen_rotrv_mod_vec,
-          .fno =3D gen_helper_gvec_rotr64v,
-          .opt_opc =3D vecop_list,
-          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
-    };
-
-    tcg_debug_assert(vece <=3D MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
-}
-
-/* Expand OPSZ bytes worth of three-operand operations using i32 elements.=
  */
-static void expand_cmp_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                           uint32_t oprsz, TCGCond cond)
-{
-    TCGv_i32 t0 =3D tcg_temp_new_i32();
-    TCGv_i32 t1 =3D tcg_temp_new_i32();
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D 4) {
-        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
-        tcg_gen_ld_i32(t1, cpu_env, bofs + i);
-        tcg_gen_setcond_i32(cond, t0, t0, t1);
-        tcg_gen_neg_i32(t0, t0);
-        tcg_gen_st_i32(t0, cpu_env, dofs + i);
-    }
-    tcg_temp_free_i32(t1);
-    tcg_temp_free_i32(t0);
-}
-
-static void expand_cmp_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                           uint32_t oprsz, TCGCond cond)
-{
-    TCGv_i64 t0 =3D tcg_temp_new_i64();
-    TCGv_i64 t1 =3D tcg_temp_new_i64();
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D 8) {
-        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
-        tcg_gen_ld_i64(t1, cpu_env, bofs + i);
-        tcg_gen_setcond_i64(cond, t0, t0, t1);
-        tcg_gen_neg_i64(t0, t0);
-        tcg_gen_st_i64(t0, cpu_env, dofs + i);
-    }
-    tcg_temp_free_i64(t1);
-    tcg_temp_free_i64(t0);
-}
-
-static void expand_cmp_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
-                           uint32_t bofs, uint32_t oprsz, uint32_t tysz,
-                           TCGType type, TCGCond cond)
-{
-    TCGv_vec t0 =3D tcg_temp_new_vec(type);
-    TCGv_vec t1 =3D tcg_temp_new_vec(type);
-    uint32_t i;
-
-    for (i =3D 0; i < oprsz; i +=3D tysz) {
-        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
-        tcg_gen_ld_vec(t1, cpu_env, bofs + i);
-        tcg_gen_cmp_vec(cond, vece, t0, t0, t1);
-        tcg_gen_st_vec(t0, cpu_env, dofs + i);
-    }
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t0);
-}
-
-void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
-                      uint32_t aofs, uint32_t bofs,
-                      uint32_t oprsz, uint32_t maxsz)
-{
-    static const TCGOpcode cmp_list[] =3D { INDEX_op_cmp_vec, 0 };
-    static gen_helper_gvec_3 * const eq_fn[4] =3D {
-        gen_helper_gvec_eq8, gen_helper_gvec_eq16,
-        gen_helper_gvec_eq32, gen_helper_gvec_eq64
-    };
-    static gen_helper_gvec_3 * const ne_fn[4] =3D {
-        gen_helper_gvec_ne8, gen_helper_gvec_ne16,
-        gen_helper_gvec_ne32, gen_helper_gvec_ne64
-    };
-    static gen_helper_gvec_3 * const lt_fn[4] =3D {
-        gen_helper_gvec_lt8, gen_helper_gvec_lt16,
-        gen_helper_gvec_lt32, gen_helper_gvec_lt64
-    };
-    static gen_helper_gvec_3 * const le_fn[4] =3D {
-        gen_helper_gvec_le8, gen_helper_gvec_le16,
-        gen_helper_gvec_le32, gen_helper_gvec_le64
-    };
-    static gen_helper_gvec_3 * const ltu_fn[4] =3D {
-        gen_helper_gvec_ltu8, gen_helper_gvec_ltu16,
-        gen_helper_gvec_ltu32, gen_helper_gvec_ltu64
-    };
-    static gen_helper_gvec_3 * const leu_fn[4] =3D {
-        gen_helper_gvec_leu8, gen_helper_gvec_leu16,
-        gen_helper_gvec_leu32, gen_helper_gvec_leu64
-    };
-    static gen_helper_gvec_3 * const * const fns[16] =3D {
-        [TCG_COND_EQ] =3D eq_fn,
-        [TCG_COND_NE] =3D ne_fn,
-        [TCG_COND_LT] =3D lt_fn,
-        [TCG_COND_LE] =3D le_fn,
-        [TCG_COND_LTU] =3D ltu_fn,
-        [TCG_COND_LEU] =3D leu_fn,
-    };
-
-    const TCGOpcode *hold_list;
-    TCGType type;
-    uint32_t some;
-
-    check_size_align(oprsz, maxsz, dofs | aofs | bofs);
-    check_overlap_3(dofs, aofs, bofs, maxsz);
-
-    if (cond =3D=3D TCG_COND_NEVER || cond =3D=3D TCG_COND_ALWAYS) {
-        do_dup(MO_8, dofs, oprsz, maxsz,
-               NULL, NULL, -(cond =3D=3D TCG_COND_ALWAYS));
-        return;
-    }
-
-    /*
-     * Implement inline with a vector type, if possible.
-     * Prefer integer when 64-bit host and 64-bit comparison.
-     */
-    hold_list =3D tcg_swap_vecop_list(cmp_list);
-    type =3D choose_vector_type(cmp_list, vece, oprsz,
-                              TCG_TARGET_REG_BITS =3D=3D 64 && vece =3D=3D=
 MO_64);
-    switch (type) {
-    case TCG_TYPE_V256:
-        /* Recall that ARM SVE allows vector sizes that are not a
-         * power of 2, but always a multiple of 16.  The intent is
-         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
-         */
-        some =3D QEMU_ALIGN_DOWN(oprsz, 32);
-        expand_cmp_vec(vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256, co=
nd);
-        if (some =3D=3D oprsz) {
-            break;
-        }
-        dofs +=3D some;
-        aofs +=3D some;
-        bofs +=3D some;
-        oprsz -=3D some;
-        maxsz -=3D some;
-        /* fallthru */
-    case TCG_TYPE_V128:
-        expand_cmp_vec(vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128, c=
ond);
-        break;
-    case TCG_TYPE_V64:
-        expand_cmp_vec(vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64, con=
d);
-        break;
-
-    case 0:
-        if (vece =3D=3D MO_64 && check_size_impl(oprsz, 8)) {
-            expand_cmp_i64(dofs, aofs, bofs, oprsz, cond);
-        } else if (vece =3D=3D MO_32 && check_size_impl(oprsz, 4)) {
-            expand_cmp_i32(dofs, aofs, bofs, oprsz, cond);
-        } else {
-            gen_helper_gvec_3 * const *fn =3D fns[cond];
-
-            if (fn =3D=3D NULL) {
-                uint32_t tmp;
-                tmp =3D aofs, aofs =3D bofs, bofs =3D tmp;
-                cond =3D tcg_swap_cond(cond);
-                fn =3D fns[cond];
-                assert(fn !=3D NULL);
-            }
-            tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, 0, fn[vece]=
);
-            oprsz =3D maxsz;
-        }
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-    tcg_swap_vecop_list(hold_list);
-
-    if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
-    }
-}
-
-static void tcg_gen_bitsel_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i6=
4 c)
-{
-    TCGv_i64 t =3D tcg_temp_new_i64();
-
-    tcg_gen_and_i64(t, b, a);
-    tcg_gen_andc_i64(d, c, a);
-    tcg_gen_or_i64(d, d, t);
-    tcg_temp_free_i64(t);
-}
-
-void tcg_gen_gvec_bitsel(unsigned vece, uint32_t dofs, uint32_t aofs,
-                         uint32_t bofs, uint32_t cofs,
-                         uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen4 g =3D {
-        .fni8 =3D tcg_gen_bitsel_i64,
-        .fniv =3D tcg_gen_bitsel_vec,
-        .fno =3D gen_helper_gvec_bitsel,
-    };
-
-    tcg_gen_gvec_4(dofs, aofs, bofs, cofs, oprsz, maxsz, &g);
-}
+/*=0D
+ * Generic vector operation expansion=0D
+ *=0D
+ * Copyright (c) 2018 Linaro=0D
+ *=0D
+ * This library is free software; you can redistribute it and/or=0D
+ * modify it under the terms of the GNU Lesser General Public=0D
+ * License as published by the Free Software Foundation; either=0D
+ * version 2.1 of the License, or (at your option) any later version.=0D
+ *=0D
+ * This library is distributed in the hope that it will be useful,=0D
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of=0D
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0D
+ * Lesser General Public License for more details.=0D
+ *=0D
+ * You should have received a copy of the GNU Lesser General Public=0D
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.=0D
+ */=0D
+=0D
+#include "qemu/osdep.h"=0D
+#include "tcg/tcg.h"=0D
+#include "tcg/tcg-op.h"=0D
+#include "tcg/tcg-op-gvec.h"=0D
+#include "qemu/main-loop.h"=0D
+#include "tcg/tcg-gvec-desc.h"=0D
+=0D
+#define MAX_UNROLL  4=0D
+=0D
+#ifdef CONFIG_DEBUG_TCG=0D
+static const TCGOpcode vecop_list_empty[1] =3D { 0 };=0D
+#else=0D
+#define vecop_list_empty NULL=0D
+#endif=0D
+=0D
+=0D
+/* Verify vector size and alignment rules.  OFS should be the OR of all=0D
+   of the operand offsets so that we can check them all at once.  */=0D
+static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t ofs)=
=0D
+{=0D
+    uint32_t opr_align =3D oprsz >=3D 16 ? 15 : 7;=0D
+    uint32_t max_align =3D maxsz >=3D 16 || oprsz >=3D 16 ? 15 : 7;=0D
+    tcg_debug_assert(oprsz > 0);=0D
+    tcg_debug_assert(oprsz <=3D maxsz);=0D
+    tcg_debug_assert((oprsz & opr_align) =3D=3D 0);=0D
+    tcg_debug_assert((maxsz & max_align) =3D=3D 0);=0D
+    tcg_debug_assert((ofs & max_align) =3D=3D 0);=0D
+}=0D
+=0D
+/* Verify vector overlap rules for two operands.  */=0D
+static void check_overlap_2(uint32_t d, uint32_t a, uint32_t s)=0D
+{=0D
+    tcg_debug_assert(d =3D=3D a || d + s <=3D a || a + s <=3D d);=0D
+}=0D
+=0D
+/* Verify vector overlap rules for three operands.  */=0D
+static void check_overlap_3(uint32_t d, uint32_t a, uint32_t b, uint32_t s=
)=0D
+{=0D
+    check_overlap_2(d, a, s);=0D
+    check_overlap_2(d, b, s);=0D
+    check_overlap_2(a, b, s);=0D
+}=0D
+=0D
+/* Verify vector overlap rules for four operands.  */=0D
+static void check_overlap_4(uint32_t d, uint32_t a, uint32_t b,=0D
+                            uint32_t c, uint32_t s)=0D
+{=0D
+    check_overlap_2(d, a, s);=0D
+    check_overlap_2(d, b, s);=0D
+    check_overlap_2(d, c, s);=0D
+    check_overlap_2(a, b, s);=0D
+    check_overlap_2(a, c, s);=0D
+    check_overlap_2(b, c, s);=0D
+}=0D
+=0D
+/* Create a descriptor from components.  */=0D
+uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)=0D
+{=0D
+    uint32_t desc =3D 0;=0D
+=0D
+    assert(oprsz % 8 =3D=3D 0 && oprsz <=3D (8 << SIMD_OPRSZ_BITS));=0D
+    assert(maxsz % 8 =3D=3D 0 && maxsz <=3D (8 << SIMD_MAXSZ_BITS));=0D
+    assert(data =3D=3D sextract32(data, 0, SIMD_DATA_BITS));=0D
+=0D
+    oprsz =3D (oprsz / 8) - 1;=0D
+    maxsz =3D (maxsz / 8) - 1;=0D
+    desc =3D deposit32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS, oprsz);=0D
+    desc =3D deposit32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS, maxsz);=0D
+    desc =3D deposit32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BITS, data);=0D
+=0D
+    return desc;=0D
+}=0D
+=0D
+/* Generate a call to a gvec-style helper with two vector operands.  */=0D
+void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,=0D
+                        uint32_t oprsz, uint32_t maxsz, int32_t data,=0D
+                        gen_helper_gvec_2 *fn)=0D
+{=0D
+    TCGv_ptr a0, a1;=0D
+    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));=0D
+=0D
+    a0 =3D tcg_temp_new_ptr();=0D
+    a1 =3D tcg_temp_new_ptr();=0D
+=0D
+    tcg_gen_addi_ptr(a0, cpu_env, dofs);=0D
+    tcg_gen_addi_ptr(a1, cpu_env, aofs);=0D
+=0D
+    fn(a0, a1, desc);=0D
+=0D
+    tcg_temp_free_ptr(a0);=0D
+    tcg_temp_free_ptr(a1);=0D
+    tcg_temp_free_i32(desc);=0D
+}=0D
+=0D
+/* Generate a call to a gvec-style helper with two vector operands=0D
+   and one scalar operand.  */=0D
+void tcg_gen_gvec_2i_ool(uint32_t dofs, uint32_t aofs, TCGv_i64 c,=0D
+                         uint32_t oprsz, uint32_t maxsz, int32_t data,=0D
+                         gen_helper_gvec_2i *fn)=0D
+{=0D
+    TCGv_ptr a0, a1;=0D
+    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));=0D
+=0D
+    a0 =3D tcg_temp_new_ptr();=0D
+    a1 =3D tcg_temp_new_ptr();=0D
+=0D
+    tcg_gen_addi_ptr(a0, cpu_env, dofs);=0D
+    tcg_gen_addi_ptr(a1, cpu_env, aofs);=0D
+=0D
+    fn(a0, a1, c, desc);=0D
+=0D
+    tcg_temp_free_ptr(a0);=0D
+    tcg_temp_free_ptr(a1);=0D
+    tcg_temp_free_i32(desc);=0D
+}=0D
+=0D
+/* Generate a call to a gvec-style helper with three vector operands.  */=
=0D
+void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,=0D
+                        uint32_t oprsz, uint32_t maxsz, int32_t data,=0D
+                        gen_helper_gvec_3 *fn)=0D
+{=0D
+    TCGv_ptr a0, a1, a2;=0D
+    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));=0D
+=0D
+    a0 =3D tcg_temp_new_ptr();=0D
+    a1 =3D tcg_temp_new_ptr();=0D
+    a2 =3D tcg_temp_new_ptr();=0D
+=0D
+    tcg_gen_addi_ptr(a0, cpu_env, dofs);=0D
+    tcg_gen_addi_ptr(a1, cpu_env, aofs);=0D
+    tcg_gen_addi_ptr(a2, cpu_env, bofs);=0D
+=0D
+    fn(a0, a1, a2, desc);=0D
+=0D
+    tcg_temp_free_ptr(a0);=0D
+    tcg_temp_free_ptr(a1);=0D
+    tcg_temp_free_ptr(a2);=0D
+    tcg_temp_free_i32(desc);=0D
+}=0D
+=0D
+/* Generate a call to a gvec-style helper with four vector operands.  */=0D
+void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,=0D
+                        uint32_t cofs, uint32_t oprsz, uint32_t maxsz,=0D
+                        int32_t data, gen_helper_gvec_4 *fn)=0D
+{=0D
+    TCGv_ptr a0, a1, a2, a3;=0D
+    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));=0D
+=0D
+    a0 =3D tcg_temp_new_ptr();=0D
+    a1 =3D tcg_temp_new_ptr();=0D
+    a2 =3D tcg_temp_new_ptr();=0D
+    a3 =3D tcg_temp_new_ptr();=0D
+=0D
+    tcg_gen_addi_ptr(a0, cpu_env, dofs);=0D
+    tcg_gen_addi_ptr(a1, cpu_env, aofs);=0D
+    tcg_gen_addi_ptr(a2, cpu_env, bofs);=0D
+    tcg_gen_addi_ptr(a3, cpu_env, cofs);=0D
+=0D
+    fn(a0, a1, a2, a3, desc);=0D
+=0D
+    tcg_temp_free_ptr(a0);=0D
+    tcg_temp_free_ptr(a1);=0D
+    tcg_temp_free_ptr(a2);=0D
+    tcg_temp_free_ptr(a3);=0D
+    tcg_temp_free_i32(desc);=0D
+}=0D
+=0D
+/* Generate a call to a gvec-style helper with five vector operands.  */=0D
+void tcg_gen_gvec_5_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,=0D
+                        uint32_t cofs, uint32_t xofs, uint32_t oprsz,=0D
+                        uint32_t maxsz, int32_t data, gen_helper_gvec_5 *f=
n)=0D
+{=0D
+    TCGv_ptr a0, a1, a2, a3, a4;=0D
+    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));=0D
+=0D
+    a0 =3D tcg_temp_new_ptr();=0D
+    a1 =3D tcg_temp_new_ptr();=0D
+    a2 =3D tcg_temp_new_ptr();=0D
+    a3 =3D tcg_temp_new_ptr();=0D
+    a4 =3D tcg_temp_new_ptr();=0D
+=0D
+    tcg_gen_addi_ptr(a0, cpu_env, dofs);=0D
+    tcg_gen_addi_ptr(a1, cpu_env, aofs);=0D
+    tcg_gen_addi_ptr(a2, cpu_env, bofs);=0D
+    tcg_gen_addi_ptr(a3, cpu_env, cofs);=0D
+    tcg_gen_addi_ptr(a4, cpu_env, xofs);=0D
+=0D
+    fn(a0, a1, a2, a3, a4, desc);=0D
+=0D
+    tcg_temp_free_ptr(a0);=0D
+    tcg_temp_free_ptr(a1);=0D
+    tcg_temp_free_ptr(a2);=0D
+    tcg_temp_free_ptr(a3);=0D
+    tcg_temp_free_ptr(a4);=0D
+    tcg_temp_free_i32(desc);=0D
+}=0D
+=0D
+/* Generate a call to a gvec-style helper with three vector operands=0D
+   and an extra pointer operand.  */=0D
+void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,=0D
+                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,=0D
+                        int32_t data, gen_helper_gvec_2_ptr *fn)=0D
+{=0D
+    TCGv_ptr a0, a1;=0D
+    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));=0D
+=0D
+    a0 =3D tcg_temp_new_ptr();=0D
+    a1 =3D tcg_temp_new_ptr();=0D
+=0D
+    tcg_gen_addi_ptr(a0, cpu_env, dofs);=0D
+    tcg_gen_addi_ptr(a1, cpu_env, aofs);=0D
+=0D
+    fn(a0, a1, ptr, desc);=0D
+=0D
+    tcg_temp_free_ptr(a0);=0D
+    tcg_temp_free_ptr(a1);=0D
+    tcg_temp_free_i32(desc);=0D
+}=0D
+=0D
+/* Generate a call to a gvec-style helper with three vector operands=0D
+   and an extra pointer operand.  */=0D
+void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,=0D
+                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,=0D
+                        int32_t data, gen_helper_gvec_3_ptr *fn)=0D
+{=0D
+    TCGv_ptr a0, a1, a2;=0D
+    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));=0D
+=0D
+    a0 =3D tcg_temp_new_ptr();=0D
+    a1 =3D tcg_temp_new_ptr();=0D
+    a2 =3D tcg_temp_new_ptr();=0D
+=0D
+    tcg_gen_addi_ptr(a0, cpu_env, dofs);=0D
+    tcg_gen_addi_ptr(a1, cpu_env, aofs);=0D
+    tcg_gen_addi_ptr(a2, cpu_env, bofs);=0D
+=0D
+    fn(a0, a1, a2, ptr, desc);=0D
+=0D
+    tcg_temp_free_ptr(a0);=0D
+    tcg_temp_free_ptr(a1);=0D
+    tcg_temp_free_ptr(a2);=0D
+    tcg_temp_free_i32(desc);=0D
+}=0D
+=0D
+/* Generate a call to a gvec-style helper with four vector operands=0D
+   and an extra pointer operand.  */=0D
+void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,=0D
+                        uint32_t cofs, TCGv_ptr ptr, uint32_t oprsz,=0D
+                        uint32_t maxsz, int32_t data,=0D
+                        gen_helper_gvec_4_ptr *fn)=0D
+{=0D
+    TCGv_ptr a0, a1, a2, a3;=0D
+    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));=0D
+=0D
+    a0 =3D tcg_temp_new_ptr();=0D
+    a1 =3D tcg_temp_new_ptr();=0D
+    a2 =3D tcg_temp_new_ptr();=0D
+    a3 =3D tcg_temp_new_ptr();=0D
+=0D
+    tcg_gen_addi_ptr(a0, cpu_env, dofs);=0D
+    tcg_gen_addi_ptr(a1, cpu_env, aofs);=0D
+    tcg_gen_addi_ptr(a2, cpu_env, bofs);=0D
+    tcg_gen_addi_ptr(a3, cpu_env, cofs);=0D
+=0D
+    fn(a0, a1, a2, a3, ptr, desc);=0D
+=0D
+    tcg_temp_free_ptr(a0);=0D
+    tcg_temp_free_ptr(a1);=0D
+    tcg_temp_free_ptr(a2);=0D
+    tcg_temp_free_ptr(a3);=0D
+    tcg_temp_free_i32(desc);=0D
+}=0D
+=0D
+/* Generate a call to a gvec-style helper with five vector operands=0D
+   and an extra pointer operand.  */=0D
+void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,=0D
+                        uint32_t cofs, uint32_t eofs, TCGv_ptr ptr,=0D
+                        uint32_t oprsz, uint32_t maxsz, int32_t data,=0D
+                        gen_helper_gvec_5_ptr *fn)=0D
+{=0D
+    TCGv_ptr a0, a1, a2, a3, a4;=0D
+    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));=0D
+=0D
+    a0 =3D tcg_temp_new_ptr();=0D
+    a1 =3D tcg_temp_new_ptr();=0D
+    a2 =3D tcg_temp_new_ptr();=0D
+    a3 =3D tcg_temp_new_ptr();=0D
+    a4 =3D tcg_temp_new_ptr();=0D
+=0D
+    tcg_gen_addi_ptr(a0, cpu_env, dofs);=0D
+    tcg_gen_addi_ptr(a1, cpu_env, aofs);=0D
+    tcg_gen_addi_ptr(a2, cpu_env, bofs);=0D
+    tcg_gen_addi_ptr(a3, cpu_env, cofs);=0D
+    tcg_gen_addi_ptr(a4, cpu_env, eofs);=0D
+=0D
+    fn(a0, a1, a2, a3, a4, ptr, desc);=0D
+=0D
+    tcg_temp_free_ptr(a0);=0D
+    tcg_temp_free_ptr(a1);=0D
+    tcg_temp_free_ptr(a2);=0D
+    tcg_temp_free_ptr(a3);=0D
+    tcg_temp_free_ptr(a4);=0D
+    tcg_temp_free_i32(desc);=0D
+}=0D
+=0D
+/* Return true if we want to implement something of OPRSZ bytes=0D
+   in units of LNSZ.  This limits the expansion of inline code.  */=0D
+static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)=0D
+{=0D
+    uint32_t q, r;=0D
+=0D
+    if (oprsz < lnsz) {=0D
+        return false;=0D
+    }=0D
+=0D
+    q =3D oprsz / lnsz;=0D
+    r =3D oprsz % lnsz;=0D
+    tcg_debug_assert((r & 7) =3D=3D 0);=0D
+=0D
+    if (lnsz < 16) {=0D
+        /* For sizes below 16, accept no remainder. */=0D
+        if (r !=3D 0) {=0D
+            return false;=0D
+        }=0D
+    } else {=0D
+        /*=0D
+         * Recall that ARM SVE allows vector sizes that are not a=0D
+         * power of 2, but always a multiple of 16.  The intent is=0D
+         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.=0D
+         * In addition, expand_clr needs to handle a multiple of 8.=0D
+         * Thus we can handle the tail with one more operation per=0D
+         * diminishing power of 2.=0D
+         */=0D
+        q +=3D ctpop32(r);=0D
+    }=0D
+=0D
+    return q <=3D MAX_UNROLL;=0D
+}=0D
+=0D
+static void expand_clr(uint32_t dofs, uint32_t maxsz);=0D
+=0D
+/* Duplicate C as per VECE.  */=0D
+uint64_t dup_const_eval(unsigned vece, uint64_t c)=0D
+{=0D
+    switch (vece) {=0D
+    case MO_8:=0D
+        return 0x0101010101010101ull * (uint8_t)c;=0D
+    case MO_16:=0D
+        return 0x0001000100010001ull * (uint16_t)c;=0D
+    case MO_32:=0D
+        return 0x0000000100000001ull * (uint32_t)c;=0D
+    case MO_64:=0D
+        return c;=0D
+    default:=0D
+        g_assert_not_reached();=0D
+    }=0D
+}=0D
+=0D
+/* Duplicate IN into OUT as per VECE.  */=0D
+static void gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in)=0D
+{=0D
+    switch (vece) {=0D
+    case MO_8:=0D
+        tcg_gen_ext8u_i32(out, in);=0D
+        tcg_gen_muli_i32(out, out, 0x01010101);=0D
+        break;=0D
+    case MO_16:=0D
+        tcg_gen_deposit_i32(out, in, in, 16, 16);=0D
+        break;=0D
+    case MO_32:=0D
+        tcg_gen_mov_i32(out, in);=0D
+        break;=0D
+    default:=0D
+        g_assert_not_reached();=0D
+    }=0D
+}=0D
+=0D
+static void gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in)=0D
+{=0D
+    switch (vece) {=0D
+    case MO_8:=0D
+        tcg_gen_ext8u_i64(out, in);=0D
+        tcg_gen_muli_i64(out, out, 0x0101010101010101ull);=0D
+        break;=0D
+    case MO_16:=0D
+        tcg_gen_ext16u_i64(out, in);=0D
+        tcg_gen_muli_i64(out, out, 0x0001000100010001ull);=0D
+        break;=0D
+    case MO_32:=0D
+        tcg_gen_deposit_i64(out, in, in, 32, 32);=0D
+        break;=0D
+    case MO_64:=0D
+        tcg_gen_mov_i64(out, in);=0D
+        break;=0D
+    default:=0D
+        g_assert_not_reached();=0D
+    }=0D
+}=0D
+=0D
+/* Select a supported vector type for implementing an operation on SIZE=0D
+ * bytes.  If OP is 0, assume that the real operation to be performed is=0D
+ * required by all backends.  Otherwise, make sure than OP can be performe=
d=0D
+ * on elements of size VECE in the selected type.  Do not select V64 if=0D
+ * PREFER_I64 is true.  Return 0 if no vector type is selected.=0D
+ */=0D
+static TCGType choose_vector_type(const TCGOpcode *list, unsigned vece,=0D
+                                  uint32_t size, bool prefer_i64)=0D
+{=0D
+    /*=0D
+     * Recall that ARM SVE allows vector sizes that are not a=0D
+     * power of 2, but always a multiple of 16.  The intent is=0D
+     * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.=0D
+     * It is hard to imagine a case in which v256 is supported=0D
+     * but v128 is not, but check anyway.=0D
+     * In addition, expand_clr needs to handle a multiple of 8.=0D
+     */=0D
+    if (TCG_TARGET_HAS_v256 &&=0D
+        check_size_impl(size, 32) &&=0D
+        tcg_can_emit_vecop_list(list, TCG_TYPE_V256, vece) &&=0D
+        (!(size & 16) ||=0D
+         (TCG_TARGET_HAS_v128 &&=0D
+          tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece))) &&=0D
+        (!(size & 8) ||=0D
+         (TCG_TARGET_HAS_v64 &&=0D
+          tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)))) {=0D
+        return TCG_TYPE_V256;=0D
+    }=0D
+    if (TCG_TARGET_HAS_v128 &&=0D
+        check_size_impl(size, 16) &&=0D
+        tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece) &&=0D
+        (!(size & 8) ||=0D
+         (TCG_TARGET_HAS_v64 &&=0D
+          tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)))) {=0D
+        return TCG_TYPE_V128;=0D
+    }=0D
+    if (TCG_TARGET_HAS_v64 && !prefer_i64 && check_size_impl(size, 8)=0D
+        && tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)) {=0D
+        return TCG_TYPE_V64;=0D
+    }=0D
+    return 0;=0D
+}=0D
+=0D
+static void do_dup_store(TCGType type, uint32_t dofs, uint32_t oprsz,=0D
+                         uint32_t maxsz, TCGv_vec t_vec)=0D
+{=0D
+    uint32_t i =3D 0;=0D
+=0D
+    tcg_debug_assert(oprsz >=3D 8);=0D
+=0D
+    /*=0D
+     * This may be expand_clr for the tail of an operation, e.g.=0D
+     * oprsz =3D=3D 8 && maxsz =3D=3D 64.  The first 8 bytes of this store=
=0D
+     * are misaligned wrt the maximum vector size, so do that first.=0D
+     */=0D
+    if (dofs & 8) {=0D
+        tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V64);=0D
+        i +=3D 8;=0D
+    }=0D
+=0D
+    switch (type) {=0D
+    case TCG_TYPE_V256:=0D
+        /*=0D
+         * Recall that ARM SVE allows vector sizes that are not a=0D
+         * power of 2, but always a multiple of 16.  The intent is=0D
+         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.=0D
+         */=0D
+        for (; i + 32 <=3D oprsz; i +=3D 32) {=0D
+            tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V256);=0D
+        }=0D
+        /* fallthru */=0D
+    case TCG_TYPE_V128:=0D
+        for (; i + 16 <=3D oprsz; i +=3D 16) {=0D
+            tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V128);=0D
+        }=0D
+        break;=0D
+    case TCG_TYPE_V64:=0D
+        for (; i < oprsz; i +=3D 8) {=0D
+            tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V64);=0D
+        }=0D
+        break;=0D
+    default:=0D
+        g_assert_not_reached();=0D
+    }=0D
+=0D
+    if (oprsz < maxsz) {=0D
+        expand_clr(dofs + oprsz, maxsz - oprsz);=0D
+    }=0D
+}=0D
+=0D
+/* Set OPRSZ bytes at DOFS to replications of IN_32, IN_64 or IN_C.=0D
+ * Only one of IN_32 or IN_64 may be set;=0D
+ * IN_C is used if IN_32 and IN_64 are unset.=0D
+ */=0D
+static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,=0D
+                   uint32_t maxsz, TCGv_i32 in_32, TCGv_i64 in_64,=0D
+                   uint64_t in_c)=0D
+{=0D
+    TCGType type;=0D
+    TCGv_i64 t_64;=0D
+    TCGv_i32 t_32, t_desc;=0D
+    TCGv_ptr t_ptr;=0D
+    uint32_t i;=0D
+=0D
+    assert(vece <=3D (in_32 ? MO_32 : MO_64));=0D
+    assert(in_32 =3D=3D NULL || in_64 =3D=3D NULL);=0D
+=0D
+    /* If we're storing 0, expand oprsz to maxsz.  */=0D
+    if (in_32 =3D=3D NULL && in_64 =3D=3D NULL) {=0D
+        in_c =3D dup_const(vece, in_c);=0D
+        if (in_c =3D=3D 0) {=0D
+            oprsz =3D maxsz;=0D
+        }=0D
+    }=0D
+=0D
+    /* Implement inline with a vector type, if possible.=0D
+     * Prefer integer when 64-bit host and no variable dup.=0D
+     */=0D
+    type =3D choose_vector_type(NULL, vece, oprsz,=0D
+                              (TCG_TARGET_REG_BITS =3D=3D 64 && in_32 =3D=
=3D NULL=0D
+                               && (in_64 =3D=3D NULL || vece =3D=3D MO_64)=
));=0D
+    if (type !=3D 0) {=0D
+        TCGv_vec t_vec =3D tcg_temp_new_vec(type);=0D
+=0D
+        if (in_32) {=0D
+            tcg_gen_dup_i32_vec(vece, t_vec, in_32);=0D
+        } else if (in_64) {=0D
+            tcg_gen_dup_i64_vec(vece, t_vec, in_64);=0D
+        } else {=0D
+            tcg_gen_dupi_vec(vece, t_vec, in_c);=0D
+        }=0D
+        do_dup_store(type, dofs, oprsz, maxsz, t_vec);=0D
+        tcg_temp_free_vec(t_vec);=0D
+        return;=0D
+    }=0D
+=0D
+    /* Otherwise, inline with an integer type, unless "large".  */=0D
+    if (check_size_impl(oprsz, TCG_TARGET_REG_BITS / 8)) {=0D
+        t_64 =3D NULL;=0D
+        t_32 =3D NULL;=0D
+=0D
+        if (in_32) {=0D
+            /* We are given a 32-bit variable input.  For a 64-bit host,=0D
+               use a 64-bit operation unless the 32-bit operation would=0D
+               be simple enough.  */=0D
+            if (TCG_TARGET_REG_BITS =3D=3D 64=0D
+                && (vece !=3D MO_32 || !check_size_impl(oprsz, 4))) {=0D
+                t_64 =3D tcg_temp_new_i64();=0D
+                tcg_gen_extu_i32_i64(t_64, in_32);=0D
+                gen_dup_i64(vece, t_64, t_64);=0D
+            } else {=0D
+                t_32 =3D tcg_temp_new_i32();=0D
+                gen_dup_i32(vece, t_32, in_32);=0D
+            }=0D
+        } else if (in_64) {=0D
+            /* We are given a 64-bit variable input.  */=0D
+            t_64 =3D tcg_temp_new_i64();=0D
+            gen_dup_i64(vece, t_64, in_64);=0D
+        } else {=0D
+            /* We are given a constant input.  */=0D
+            /* For 64-bit hosts, use 64-bit constants for "simple" constan=
ts=0D
+               or when we'd need too many 32-bit stores, or when a 64-bit=
=0D
+               constant is really required.  */=0D
+            if (vece =3D=3D MO_64=0D
+                || (TCG_TARGET_REG_BITS =3D=3D 64=0D
+                    && (in_c =3D=3D 0 || in_c =3D=3D -1=0D
+                        || !check_size_impl(oprsz, 4)))) {=0D
+                t_64 =3D tcg_const_i64(in_c);=0D
+            } else {=0D
+                t_32 =3D tcg_const_i32(in_c);=0D
+            }=0D
+        }=0D
+=0D
+        /* Implement inline if we picked an implementation size above.  */=
=0D
+        if (t_32) {=0D
+            for (i =3D 0; i < oprsz; i +=3D 4) {=0D
+                tcg_gen_st_i32(t_32, cpu_env, dofs + i);=0D
+            }=0D
+            tcg_temp_free_i32(t_32);=0D
+            goto done;=0D
+        }=0D
+        if (t_64) {=0D
+            for (i =3D 0; i < oprsz; i +=3D 8) {=0D
+                tcg_gen_st_i64(t_64, cpu_env, dofs + i);=0D
+            }=0D
+            tcg_temp_free_i64(t_64);=0D
+            goto done;=0D
+        }=0D
+    }=0D
+=0D
+    /* Otherwise implement out of line.  */=0D
+    t_ptr =3D tcg_temp_new_ptr();=0D
+    tcg_gen_addi_ptr(t_ptr, cpu_env, dofs);=0D
+    t_desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, 0));=0D
+=0D
+    if (vece =3D=3D MO_64) {=0D
+        if (in_64) {=0D
+            gen_helper_gvec_dup64(t_ptr, t_desc, in_64);=0D
+        } else {=0D
+            t_64 =3D tcg_const_i64(in_c);=0D
+            gen_helper_gvec_dup64(t_ptr, t_desc, t_64);=0D
+            tcg_temp_free_i64(t_64);=0D
+        }=0D
+    } else {=0D
+        typedef void dup_fn(TCGv_ptr, TCGv_i32, TCGv_i32);=0D
+        static dup_fn * const fns[3] =3D {=0D
+            gen_helper_gvec_dup8,=0D
+            gen_helper_gvec_dup16,=0D
+            gen_helper_gvec_dup32=0D
+        };=0D
+=0D
+        if (in_32) {=0D
+            fns[vece](t_ptr, t_desc, in_32);=0D
+        } else {=0D
+            t_32 =3D tcg_temp_new_i32();=0D
+            if (in_64) {=0D
+                tcg_gen_extrl_i64_i32(t_32, in_64);=0D
+            } else if (vece =3D=3D MO_8) {=0D
+                tcg_gen_movi_i32(t_32, in_c & 0xff);=0D
+            } else if (vece =3D=3D MO_16) {=0D
+                tcg_gen_movi_i32(t_32, in_c & 0xffff);=0D
+            } else {=0D
+                tcg_gen_movi_i32(t_32, in_c);=0D
+            }=0D
+            fns[vece](t_ptr, t_desc, t_32);=0D
+            tcg_temp_free_i32(t_32);=0D
+        }=0D
+    }=0D
+=0D
+    tcg_temp_free_ptr(t_ptr);=0D
+    tcg_temp_free_i32(t_desc);=0D
+    return;=0D
+=0D
+ done:=0D
+    if (oprsz < maxsz) {=0D
+        expand_clr(dofs + oprsz, maxsz - oprsz);=0D
+    }=0D
+}=0D
+=0D
+/* Likewise, but with zero.  */=0D
+static void expand_clr(uint32_t dofs, uint32_t maxsz)=0D
+{=0D
+    do_dup(MO_8, dofs, maxsz, maxsz, NULL, NULL, 0);=0D
+}=0D
+=0D
+/* Expand OPSZ bytes worth of two-operand operations using i32 elements.  =
*/=0D
+static void expand_2_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,=0D
+                         bool load_dest, void (*fni)(TCGv_i32, TCGv_i32))=
=0D
+{=0D
+    TCGv_i32 t0 =3D tcg_temp_new_i32();=0D
+    TCGv_i32 t1 =3D tcg_temp_new_i32();=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D 4) {=0D
+        tcg_gen_ld_i32(t0, cpu_env, aofs + i);=0D
+        if (load_dest) {=0D
+            tcg_gen_ld_i32(t1, cpu_env, dofs + i);=0D
+        }=0D
+        fni(t1, t0);=0D
+        tcg_gen_st_i32(t1, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_i32(t0);=0D
+    tcg_temp_free_i32(t1);=0D
+}=0D
+=0D
+static void expand_2i_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,=0D
+                          int32_t c, bool load_dest,=0D
+                          void (*fni)(TCGv_i32, TCGv_i32, int32_t))=0D
+{=0D
+    TCGv_i32 t0 =3D tcg_temp_new_i32();=0D
+    TCGv_i32 t1 =3D tcg_temp_new_i32();=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D 4) {=0D
+        tcg_gen_ld_i32(t0, cpu_env, aofs + i);=0D
+        if (load_dest) {=0D
+            tcg_gen_ld_i32(t1, cpu_env, dofs + i);=0D
+        }=0D
+        fni(t1, t0, c);=0D
+        tcg_gen_st_i32(t1, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_i32(t0);=0D
+    tcg_temp_free_i32(t1);=0D
+}=0D
+=0D
+static void expand_2s_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,=0D
+                          TCGv_i32 c, bool scalar_first,=0D
+                          void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32))=0D
+{=0D
+    TCGv_i32 t0 =3D tcg_temp_new_i32();=0D
+    TCGv_i32 t1 =3D tcg_temp_new_i32();=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D 4) {=0D
+        tcg_gen_ld_i32(t0, cpu_env, aofs + i);=0D
+        if (scalar_first) {=0D
+            fni(t1, c, t0);=0D
+        } else {=0D
+            fni(t1, t0, c);=0D
+        }=0D
+        tcg_gen_st_i32(t1, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_i32(t0);=0D
+    tcg_temp_free_i32(t1);=0D
+}=0D
+=0D
+/* Expand OPSZ bytes worth of three-operand operations using i32 elements.=
  */=0D
+static void expand_3_i32(uint32_t dofs, uint32_t aofs,=0D
+                         uint32_t bofs, uint32_t oprsz, bool load_dest,=0D
+                         void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32))=0D
+{=0D
+    TCGv_i32 t0 =3D tcg_temp_new_i32();=0D
+    TCGv_i32 t1 =3D tcg_temp_new_i32();=0D
+    TCGv_i32 t2 =3D tcg_temp_new_i32();=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D 4) {=0D
+        tcg_gen_ld_i32(t0, cpu_env, aofs + i);=0D
+        tcg_gen_ld_i32(t1, cpu_env, bofs + i);=0D
+        if (load_dest) {=0D
+            tcg_gen_ld_i32(t2, cpu_env, dofs + i);=0D
+        }=0D
+        fni(t2, t0, t1);=0D
+        tcg_gen_st_i32(t2, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_i32(t2);=0D
+    tcg_temp_free_i32(t1);=0D
+    tcg_temp_free_i32(t0);=0D
+}=0D
+=0D
+static void expand_3i_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,=0D
+                          uint32_t oprsz, int32_t c, bool load_dest,=0D
+                          void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32, int32_=
t))=0D
+{=0D
+    TCGv_i32 t0 =3D tcg_temp_new_i32();=0D
+    TCGv_i32 t1 =3D tcg_temp_new_i32();=0D
+    TCGv_i32 t2 =3D tcg_temp_new_i32();=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D 4) {=0D
+        tcg_gen_ld_i32(t0, cpu_env, aofs + i);=0D
+        tcg_gen_ld_i32(t1, cpu_env, bofs + i);=0D
+        if (load_dest) {=0D
+            tcg_gen_ld_i32(t2, cpu_env, dofs + i);=0D
+        }=0D
+        fni(t2, t0, t1, c);=0D
+        tcg_gen_st_i32(t2, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_i32(t0);=0D
+    tcg_temp_free_i32(t1);=0D
+    tcg_temp_free_i32(t2);=0D
+}=0D
+=0D
+/* Expand OPSZ bytes worth of three-operand operations using i32 elements.=
  */=0D
+static void expand_4_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,=0D
+                         uint32_t cofs, uint32_t oprsz, bool write_aofs,=0D
+                         void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i3=
2))=0D
+{=0D
+    TCGv_i32 t0 =3D tcg_temp_new_i32();=0D
+    TCGv_i32 t1 =3D tcg_temp_new_i32();=0D
+    TCGv_i32 t2 =3D tcg_temp_new_i32();=0D
+    TCGv_i32 t3 =3D tcg_temp_new_i32();=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D 4) {=0D
+        tcg_gen_ld_i32(t1, cpu_env, aofs + i);=0D
+        tcg_gen_ld_i32(t2, cpu_env, bofs + i);=0D
+        tcg_gen_ld_i32(t3, cpu_env, cofs + i);=0D
+        fni(t0, t1, t2, t3);=0D
+        tcg_gen_st_i32(t0, cpu_env, dofs + i);=0D
+        if (write_aofs) {=0D
+            tcg_gen_st_i32(t1, cpu_env, aofs + i);=0D
+        }=0D
+    }=0D
+    tcg_temp_free_i32(t3);=0D
+    tcg_temp_free_i32(t2);=0D
+    tcg_temp_free_i32(t1);=0D
+    tcg_temp_free_i32(t0);=0D
+}=0D
+=0D
+/* Expand OPSZ bytes worth of two-operand operations using i64 elements.  =
*/=0D
+static void expand_2_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,=0D
+                         bool load_dest, void (*fni)(TCGv_i64, TCGv_i64))=
=0D
+{=0D
+    TCGv_i64 t0 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t1 =3D tcg_temp_new_i64();=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D 8) {=0D
+        tcg_gen_ld_i64(t0, cpu_env, aofs + i);=0D
+        if (load_dest) {=0D
+            tcg_gen_ld_i64(t1, cpu_env, dofs + i);=0D
+        }=0D
+        fni(t1, t0);=0D
+        tcg_gen_st_i64(t1, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_i64(t0);=0D
+    tcg_temp_free_i64(t1);=0D
+}=0D
+=0D
+static void expand_2i_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,=0D
+                          int64_t c, bool load_dest,=0D
+                          void (*fni)(TCGv_i64, TCGv_i64, int64_t))=0D
+{=0D
+    TCGv_i64 t0 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t1 =3D tcg_temp_new_i64();=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D 8) {=0D
+        tcg_gen_ld_i64(t0, cpu_env, aofs + i);=0D
+        if (load_dest) {=0D
+            tcg_gen_ld_i64(t1, cpu_env, dofs + i);=0D
+        }=0D
+        fni(t1, t0, c);=0D
+        tcg_gen_st_i64(t1, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_i64(t0);=0D
+    tcg_temp_free_i64(t1);=0D
+}=0D
+=0D
+static void expand_2s_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,=0D
+                          TCGv_i64 c, bool scalar_first,=0D
+                          void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64))=0D
+{=0D
+    TCGv_i64 t0 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t1 =3D tcg_temp_new_i64();=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D 8) {=0D
+        tcg_gen_ld_i64(t0, cpu_env, aofs + i);=0D
+        if (scalar_first) {=0D
+            fni(t1, c, t0);=0D
+        } else {=0D
+            fni(t1, t0, c);=0D
+        }=0D
+        tcg_gen_st_i64(t1, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_i64(t0);=0D
+    tcg_temp_free_i64(t1);=0D
+}=0D
+=0D
+/* Expand OPSZ bytes worth of three-operand operations using i64 elements.=
  */=0D
+static void expand_3_i64(uint32_t dofs, uint32_t aofs,=0D
+                         uint32_t bofs, uint32_t oprsz, bool load_dest,=0D
+                         void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64))=0D
+{=0D
+    TCGv_i64 t0 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t1 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t2 =3D tcg_temp_new_i64();=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D 8) {=0D
+        tcg_gen_ld_i64(t0, cpu_env, aofs + i);=0D
+        tcg_gen_ld_i64(t1, cpu_env, bofs + i);=0D
+        if (load_dest) {=0D
+            tcg_gen_ld_i64(t2, cpu_env, dofs + i);=0D
+        }=0D
+        fni(t2, t0, t1);=0D
+        tcg_gen_st_i64(t2, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_i64(t2);=0D
+    tcg_temp_free_i64(t1);=0D
+    tcg_temp_free_i64(t0);=0D
+}=0D
+=0D
+static void expand_3i_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,=0D
+                          uint32_t oprsz, int64_t c, bool load_dest,=0D
+                          void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64, int64_=
t))=0D
+{=0D
+    TCGv_i64 t0 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t1 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t2 =3D tcg_temp_new_i64();=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D 8) {=0D
+        tcg_gen_ld_i64(t0, cpu_env, aofs + i);=0D
+        tcg_gen_ld_i64(t1, cpu_env, bofs + i);=0D
+        if (load_dest) {=0D
+            tcg_gen_ld_i64(t2, cpu_env, dofs + i);=0D
+        }=0D
+        fni(t2, t0, t1, c);=0D
+        tcg_gen_st_i64(t2, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_i64(t0);=0D
+    tcg_temp_free_i64(t1);=0D
+    tcg_temp_free_i64(t2);=0D
+}=0D
+=0D
+/* Expand OPSZ bytes worth of three-operand operations using i64 elements.=
  */=0D
+static void expand_4_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,=0D
+                         uint32_t cofs, uint32_t oprsz, bool write_aofs,=0D
+                         void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i6=
4))=0D
+{=0D
+    TCGv_i64 t0 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t1 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t2 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t3 =3D tcg_temp_new_i64();=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D 8) {=0D
+        tcg_gen_ld_i64(t1, cpu_env, aofs + i);=0D
+        tcg_gen_ld_i64(t2, cpu_env, bofs + i);=0D
+        tcg_gen_ld_i64(t3, cpu_env, cofs + i);=0D
+        fni(t0, t1, t2, t3);=0D
+        tcg_gen_st_i64(t0, cpu_env, dofs + i);=0D
+        if (write_aofs) {=0D
+            tcg_gen_st_i64(t1, cpu_env, aofs + i);=0D
+        }=0D
+    }=0D
+    tcg_temp_free_i64(t3);=0D
+    tcg_temp_free_i64(t2);=0D
+    tcg_temp_free_i64(t1);=0D
+    tcg_temp_free_i64(t0);=0D
+}=0D
+=0D
+/* Expand OPSZ bytes worth of two-operand operations using host vectors.  =
*/=0D
+static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                         uint32_t oprsz, uint32_t tysz, TCGType type,=0D
+                         bool load_dest,=0D
+                         void (*fni)(unsigned, TCGv_vec, TCGv_vec))=0D
+{=0D
+    TCGv_vec t0 =3D tcg_temp_new_vec(type);=0D
+    TCGv_vec t1 =3D tcg_temp_new_vec(type);=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D tysz) {=0D
+        tcg_gen_ld_vec(t0, cpu_env, aofs + i);=0D
+        if (load_dest) {=0D
+            tcg_gen_ld_vec(t1, cpu_env, dofs + i);=0D
+        }=0D
+        fni(vece, t1, t0);=0D
+        tcg_gen_st_vec(t1, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_vec(t0);=0D
+    tcg_temp_free_vec(t1);=0D
+}=0D
+=0D
+/* Expand OPSZ bytes worth of two-vector operands and an immediate operand=
=0D
+   using host vectors.  */=0D
+static void expand_2i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                          uint32_t oprsz, uint32_t tysz, TCGType type,=0D
+                          int64_t c, bool load_dest,=0D
+                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, int64_=
t))=0D
+{=0D
+    TCGv_vec t0 =3D tcg_temp_new_vec(type);=0D
+    TCGv_vec t1 =3D tcg_temp_new_vec(type);=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D tysz) {=0D
+        tcg_gen_ld_vec(t0, cpu_env, aofs + i);=0D
+        if (load_dest) {=0D
+            tcg_gen_ld_vec(t1, cpu_env, dofs + i);=0D
+        }=0D
+        fni(vece, t1, t0, c);=0D
+        tcg_gen_st_vec(t1, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_vec(t0);=0D
+    tcg_temp_free_vec(t1);=0D
+}=0D
+=0D
+static void expand_2s_vec(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                          uint32_t oprsz, uint32_t tysz, TCGType type,=0D
+                          TCGv_vec c, bool scalar_first,=0D
+                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_v=
ec))=0D
+{=0D
+    TCGv_vec t0 =3D tcg_temp_new_vec(type);=0D
+    TCGv_vec t1 =3D tcg_temp_new_vec(type);=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D tysz) {=0D
+        tcg_gen_ld_vec(t0, cpu_env, aofs + i);=0D
+        if (scalar_first) {=0D
+            fni(vece, t1, c, t0);=0D
+        } else {=0D
+            fni(vece, t1, t0, c);=0D
+        }=0D
+        tcg_gen_st_vec(t1, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_vec(t0);=0D
+    tcg_temp_free_vec(t1);=0D
+}=0D
+=0D
+/* Expand OPSZ bytes worth of three-operand operations using host vectors.=
  */=0D
+static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                         uint32_t bofs, uint32_t oprsz,=0D
+                         uint32_t tysz, TCGType type, bool load_dest,=0D
+                         void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_ve=
c))=0D
+{=0D
+    TCGv_vec t0 =3D tcg_temp_new_vec(type);=0D
+    TCGv_vec t1 =3D tcg_temp_new_vec(type);=0D
+    TCGv_vec t2 =3D tcg_temp_new_vec(type);=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D tysz) {=0D
+        tcg_gen_ld_vec(t0, cpu_env, aofs + i);=0D
+        tcg_gen_ld_vec(t1, cpu_env, bofs + i);=0D
+        if (load_dest) {=0D
+            tcg_gen_ld_vec(t2, cpu_env, dofs + i);=0D
+        }=0D
+        fni(vece, t2, t0, t1);=0D
+        tcg_gen_st_vec(t2, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_vec(t2);=0D
+    tcg_temp_free_vec(t1);=0D
+    tcg_temp_free_vec(t0);=0D
+}=0D
+=0D
+/*=0D
+ * Expand OPSZ bytes worth of three-vector operands and an immediate opera=
nd=0D
+ * using host vectors.=0D
+ */=0D
+static void expand_3i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                          uint32_t bofs, uint32_t oprsz, uint32_t tysz,=0D
+                          TCGType type, int64_t c, bool load_dest,=0D
+                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_v=
ec,=0D
+                                      int64_t))=0D
+{=0D
+    TCGv_vec t0 =3D tcg_temp_new_vec(type);=0D
+    TCGv_vec t1 =3D tcg_temp_new_vec(type);=0D
+    TCGv_vec t2 =3D tcg_temp_new_vec(type);=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D tysz) {=0D
+        tcg_gen_ld_vec(t0, cpu_env, aofs + i);=0D
+        tcg_gen_ld_vec(t1, cpu_env, bofs + i);=0D
+        if (load_dest) {=0D
+            tcg_gen_ld_vec(t2, cpu_env, dofs + i);=0D
+        }=0D
+        fni(vece, t2, t0, t1, c);=0D
+        tcg_gen_st_vec(t2, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_vec(t0);=0D
+    tcg_temp_free_vec(t1);=0D
+    tcg_temp_free_vec(t2);=0D
+}=0D
+=0D
+/* Expand OPSZ bytes worth of four-operand operations using host vectors. =
 */=0D
+static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                         uint32_t bofs, uint32_t cofs, uint32_t oprsz,=0D
+                         uint32_t tysz, TCGType type, bool write_aofs,=0D
+                         void (*fni)(unsigned, TCGv_vec, TCGv_vec,=0D
+                                     TCGv_vec, TCGv_vec))=0D
+{=0D
+    TCGv_vec t0 =3D tcg_temp_new_vec(type);=0D
+    TCGv_vec t1 =3D tcg_temp_new_vec(type);=0D
+    TCGv_vec t2 =3D tcg_temp_new_vec(type);=0D
+    TCGv_vec t3 =3D tcg_temp_new_vec(type);=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D tysz) {=0D
+        tcg_gen_ld_vec(t1, cpu_env, aofs + i);=0D
+        tcg_gen_ld_vec(t2, cpu_env, bofs + i);=0D
+        tcg_gen_ld_vec(t3, cpu_env, cofs + i);=0D
+        fni(vece, t0, t1, t2, t3);=0D
+        tcg_gen_st_vec(t0, cpu_env, dofs + i);=0D
+        if (write_aofs) {=0D
+            tcg_gen_st_vec(t1, cpu_env, aofs + i);=0D
+        }=0D
+    }=0D
+    tcg_temp_free_vec(t3);=0D
+    tcg_temp_free_vec(t2);=0D
+    tcg_temp_free_vec(t1);=0D
+    tcg_temp_free_vec(t0);=0D
+}=0D
+=0D
+/* Expand a vector two-operand operation.  */=0D
+void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,=0D
+                    uint32_t oprsz, uint32_t maxsz, const GVecGen2 *g)=0D
+{=0D
+    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;=0D
+    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);=0D
+    TCGType type;=0D
+    uint32_t some;=0D
+=0D
+    check_size_align(oprsz, maxsz, dofs | aofs);=0D
+    check_overlap_2(dofs, aofs, maxsz);=0D
+=0D
+    type =3D 0;=0D
+    if (g->fniv) {=0D
+        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_=
i64);=0D
+    }=0D
+    switch (type) {=0D
+    case TCG_TYPE_V256:=0D
+        /* Recall that ARM SVE allows vector sizes that are not a=0D
+         * power of 2, but always a multiple of 16.  The intent is=0D
+         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.=0D
+         */=0D
+        some =3D QEMU_ALIGN_DOWN(oprsz, 32);=0D
+        expand_2_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,=0D
+                     g->load_dest, g->fniv);=0D
+        if (some =3D=3D oprsz) {=0D
+            break;=0D
+        }=0D
+        dofs +=3D some;=0D
+        aofs +=3D some;=0D
+        oprsz -=3D some;=0D
+        maxsz -=3D some;=0D
+        /* fallthru */=0D
+    case TCG_TYPE_V128:=0D
+        expand_2_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,=0D
+                     g->load_dest, g->fniv);=0D
+        break;=0D
+    case TCG_TYPE_V64:=0D
+        expand_2_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,=0D
+                     g->load_dest, g->fniv);=0D
+        break;=0D
+=0D
+    case 0:=0D
+        if (g->fni8 && check_size_impl(oprsz, 8)) {=0D
+            expand_2_i64(dofs, aofs, oprsz, g->load_dest, g->fni8);=0D
+        } else if (g->fni4 && check_size_impl(oprsz, 4)) {=0D
+            expand_2_i32(dofs, aofs, oprsz, g->load_dest, g->fni4);=0D
+        } else {=0D
+            assert(g->fno !=3D NULL);=0D
+            tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, g->data, g->fno);=
=0D
+            oprsz =3D maxsz;=0D
+        }=0D
+        break;=0D
+=0D
+    default:=0D
+        g_assert_not_reached();=0D
+    }=0D
+    tcg_swap_vecop_list(hold_list);=0D
+=0D
+    if (oprsz < maxsz) {=0D
+        expand_clr(dofs + oprsz, maxsz - oprsz);=0D
+    }=0D
+}=0D
+=0D
+/* Expand a vector operation with two vectors and an immediate.  */=0D
+void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,=0D
+                     uint32_t maxsz, int64_t c, const GVecGen2i *g)=0D
+{=0D
+    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;=0D
+    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);=0D
+    TCGType type;=0D
+    uint32_t some;=0D
+=0D
+    check_size_align(oprsz, maxsz, dofs | aofs);=0D
+    check_overlap_2(dofs, aofs, maxsz);=0D
+=0D
+    type =3D 0;=0D
+    if (g->fniv) {=0D
+        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_=
i64);=0D
+    }=0D
+    switch (type) {=0D
+    case TCG_TYPE_V256:=0D
+        /* Recall that ARM SVE allows vector sizes that are not a=0D
+         * power of 2, but always a multiple of 16.  The intent is=0D
+         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.=0D
+         */=0D
+        some =3D QEMU_ALIGN_DOWN(oprsz, 32);=0D
+        expand_2i_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,=0D
+                      c, g->load_dest, g->fniv);=0D
+        if (some =3D=3D oprsz) {=0D
+            break;=0D
+        }=0D
+        dofs +=3D some;=0D
+        aofs +=3D some;=0D
+        oprsz -=3D some;=0D
+        maxsz -=3D some;=0D
+        /* fallthru */=0D
+    case TCG_TYPE_V128:=0D
+        expand_2i_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,=0D
+                      c, g->load_dest, g->fniv);=0D
+        break;=0D
+    case TCG_TYPE_V64:=0D
+        expand_2i_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,=0D
+                      c, g->load_dest, g->fniv);=0D
+        break;=0D
+=0D
+    case 0:=0D
+        if (g->fni8 && check_size_impl(oprsz, 8)) {=0D
+            expand_2i_i64(dofs, aofs, oprsz, c, g->load_dest, g->fni8);=0D
+        } else if (g->fni4 && check_size_impl(oprsz, 4)) {=0D
+            expand_2i_i32(dofs, aofs, oprsz, c, g->load_dest, g->fni4);=0D
+        } else {=0D
+            if (g->fno) {=0D
+                tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, c, g->fno);=0D
+            } else {=0D
+                TCGv_i64 tcg_c =3D tcg_const_i64(c);=0D
+                tcg_gen_gvec_2i_ool(dofs, aofs, tcg_c, oprsz,=0D
+                                    maxsz, c, g->fnoi);=0D
+                tcg_temp_free_i64(tcg_c);=0D
+            }=0D
+            oprsz =3D maxsz;=0D
+        }=0D
+        break;=0D
+=0D
+    default:=0D
+        g_assert_not_reached();=0D
+    }=0D
+    tcg_swap_vecop_list(hold_list);=0D
+=0D
+    if (oprsz < maxsz) {=0D
+        expand_clr(dofs + oprsz, maxsz - oprsz);=0D
+    }=0D
+}=0D
+=0D
+/* Expand a vector operation with two vectors and a scalar.  */=0D
+void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,=0D
+                     uint32_t maxsz, TCGv_i64 c, const GVecGen2s *g)=0D
+{=0D
+    TCGType type;=0D
+=0D
+    check_size_align(oprsz, maxsz, dofs | aofs);=0D
+    check_overlap_2(dofs, aofs, maxsz);=0D
+=0D
+    type =3D 0;=0D
+    if (g->fniv) {=0D
+        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_=
i64);=0D
+    }=0D
+    if (type !=3D 0) {=0D
+        const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;=0D
+        const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);=0D
+        TCGv_vec t_vec =3D tcg_temp_new_vec(type);=0D
+        uint32_t some;=0D
+=0D
+        tcg_gen_dup_i64_vec(g->vece, t_vec, c);=0D
+=0D
+        switch (type) {=0D
+        case TCG_TYPE_V256:=0D
+            /* Recall that ARM SVE allows vector sizes that are not a=0D
+             * power of 2, but always a multiple of 16.  The intent is=0D
+             * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16=
.=0D
+             */=0D
+            some =3D QEMU_ALIGN_DOWN(oprsz, 32);=0D
+            expand_2s_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,=0D
+                          t_vec, g->scalar_first, g->fniv);=0D
+            if (some =3D=3D oprsz) {=0D
+                break;=0D
+            }=0D
+            dofs +=3D some;=0D
+            aofs +=3D some;=0D
+            oprsz -=3D some;=0D
+            maxsz -=3D some;=0D
+            /* fallthru */=0D
+=0D
+        case TCG_TYPE_V128:=0D
+            expand_2s_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,=0D
+                          t_vec, g->scalar_first, g->fniv);=0D
+            break;=0D
+=0D
+        case TCG_TYPE_V64:=0D
+            expand_2s_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,=0D
+                          t_vec, g->scalar_first, g->fniv);=0D
+            break;=0D
+=0D
+        default:=0D
+            g_assert_not_reached();=0D
+        }=0D
+        tcg_temp_free_vec(t_vec);=0D
+        tcg_swap_vecop_list(hold_list);=0D
+    } else if (g->fni8 && check_size_impl(oprsz, 8)) {=0D
+        TCGv_i64 t64 =3D tcg_temp_new_i64();=0D
+=0D
+        gen_dup_i64(g->vece, t64, c);=0D
+        expand_2s_i64(dofs, aofs, oprsz, t64, g->scalar_first, g->fni8);=0D
+        tcg_temp_free_i64(t64);=0D
+    } else if (g->fni4 && check_size_impl(oprsz, 4)) {=0D
+        TCGv_i32 t32 =3D tcg_temp_new_i32();=0D
+=0D
+        tcg_gen_extrl_i64_i32(t32, c);=0D
+        gen_dup_i32(g->vece, t32, t32);=0D
+        expand_2s_i32(dofs, aofs, oprsz, t32, g->scalar_first, g->fni4);=0D
+        tcg_temp_free_i32(t32);=0D
+    } else {=0D
+        tcg_gen_gvec_2i_ool(dofs, aofs, c, oprsz, maxsz, 0, g->fno);=0D
+        return;=0D
+    }=0D
+=0D
+    if (oprsz < maxsz) {=0D
+        expand_clr(dofs + oprsz, maxsz - oprsz);=0D
+    }=0D
+}=0D
+=0D
+/* Expand a vector three-operand operation.  */=0D
+void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,=0D
+                    uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)=0D
+{=0D
+    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;=0D
+    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);=0D
+    TCGType type;=0D
+    uint32_t some;=0D
+=0D
+    check_size_align(oprsz, maxsz, dofs | aofs | bofs);=0D
+    check_overlap_3(dofs, aofs, bofs, maxsz);=0D
+=0D
+    type =3D 0;=0D
+    if (g->fniv) {=0D
+        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_=
i64);=0D
+    }=0D
+    switch (type) {=0D
+    case TCG_TYPE_V256:=0D
+        /* Recall that ARM SVE allows vector sizes that are not a=0D
+         * power of 2, but always a multiple of 16.  The intent is=0D
+         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.=0D
+         */=0D
+        some =3D QEMU_ALIGN_DOWN(oprsz, 32);=0D
+        expand_3_vec(g->vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256,=0D
+                     g->load_dest, g->fniv);=0D
+        if (some =3D=3D oprsz) {=0D
+            break;=0D
+        }=0D
+        dofs +=3D some;=0D
+        aofs +=3D some;=0D
+        bofs +=3D some;=0D
+        oprsz -=3D some;=0D
+        maxsz -=3D some;=0D
+        /* fallthru */=0D
+    case TCG_TYPE_V128:=0D
+        expand_3_vec(g->vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128,=
=0D
+                     g->load_dest, g->fniv);=0D
+        break;=0D
+    case TCG_TYPE_V64:=0D
+        expand_3_vec(g->vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64,=0D
+                     g->load_dest, g->fniv);=0D
+        break;=0D
+=0D
+    case 0:=0D
+        if (g->fni8 && check_size_impl(oprsz, 8)) {=0D
+            expand_3_i64(dofs, aofs, bofs, oprsz, g->load_dest, g->fni8);=
=0D
+        } else if (g->fni4 && check_size_impl(oprsz, 4)) {=0D
+            expand_3_i32(dofs, aofs, bofs, oprsz, g->load_dest, g->fni4);=
=0D
+        } else {=0D
+            assert(g->fno !=3D NULL);=0D
+            tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz,=0D
+                               maxsz, g->data, g->fno);=0D
+            oprsz =3D maxsz;=0D
+        }=0D
+        break;=0D
+=0D
+    default:=0D
+        g_assert_not_reached();=0D
+    }=0D
+    tcg_swap_vecop_list(hold_list);=0D
+=0D
+    if (oprsz < maxsz) {=0D
+        expand_clr(dofs + oprsz, maxsz - oprsz);=0D
+    }=0D
+}=0D
+=0D
+/* Expand a vector operation with three vectors and an immediate.  */=0D
+void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,=0D
+                     uint32_t oprsz, uint32_t maxsz, int64_t c,=0D
+                     const GVecGen3i *g)=0D
+{=0D
+    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;=0D
+    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);=0D
+    TCGType type;=0D
+    uint32_t some;=0D
+=0D
+    check_size_align(oprsz, maxsz, dofs | aofs | bofs);=0D
+    check_overlap_3(dofs, aofs, bofs, maxsz);=0D
+=0D
+    type =3D 0;=0D
+    if (g->fniv) {=0D
+        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_=
i64);=0D
+    }=0D
+    switch (type) {=0D
+    case TCG_TYPE_V256:=0D
+        /*=0D
+         * Recall that ARM SVE allows vector sizes that are not a=0D
+         * power of 2, but always a multiple of 16.  The intent is=0D
+         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.=0D
+         */=0D
+        some =3D QEMU_ALIGN_DOWN(oprsz, 32);=0D
+        expand_3i_vec(g->vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256,=
=0D
+                      c, g->load_dest, g->fniv);=0D
+        if (some =3D=3D oprsz) {=0D
+            break;=0D
+        }=0D
+        dofs +=3D some;=0D
+        aofs +=3D some;=0D
+        bofs +=3D some;=0D
+        oprsz -=3D some;=0D
+        maxsz -=3D some;=0D
+        /* fallthru */=0D
+    case TCG_TYPE_V128:=0D
+        expand_3i_vec(g->vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128,=
=0D
+                      c, g->load_dest, g->fniv);=0D
+        break;=0D
+    case TCG_TYPE_V64:=0D
+        expand_3i_vec(g->vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64,=0D
+                      c, g->load_dest, g->fniv);=0D
+        break;=0D
+=0D
+    case 0:=0D
+        if (g->fni8 && check_size_impl(oprsz, 8)) {=0D
+            expand_3i_i64(dofs, aofs, bofs, oprsz, c, g->load_dest, g->fni=
8);=0D
+        } else if (g->fni4 && check_size_impl(oprsz, 4)) {=0D
+            expand_3i_i32(dofs, aofs, bofs, oprsz, c, g->load_dest, g->fni=
4);=0D
+        } else {=0D
+            assert(g->fno !=3D NULL);=0D
+            tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, c, g->fno);=
=0D
+            oprsz =3D maxsz;=0D
+        }=0D
+        break;=0D
+=0D
+    default:=0D
+        g_assert_not_reached();=0D
+    }=0D
+    tcg_swap_vecop_list(hold_list);=0D
+=0D
+    if (oprsz < maxsz) {=0D
+        expand_clr(dofs + oprsz, maxsz - oprsz);=0D
+    }=0D
+}=0D
+=0D
+/* Expand a vector four-operand operation.  */=0D
+void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t =
cofs,=0D
+                    uint32_t oprsz, uint32_t maxsz, const GVecGen4 *g)=0D
+{=0D
+    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;=0D
+    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);=0D
+    TCGType type;=0D
+    uint32_t some;=0D
+=0D
+    check_size_align(oprsz, maxsz, dofs | aofs | bofs | cofs);=0D
+    check_overlap_4(dofs, aofs, bofs, cofs, maxsz);=0D
+=0D
+    type =3D 0;=0D
+    if (g->fniv) {=0D
+        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_=
i64);=0D
+    }=0D
+    switch (type) {=0D
+    case TCG_TYPE_V256:=0D
+        /* Recall that ARM SVE allows vector sizes that are not a=0D
+         * power of 2, but always a multiple of 16.  The intent is=0D
+         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.=0D
+         */=0D
+        some =3D QEMU_ALIGN_DOWN(oprsz, 32);=0D
+        expand_4_vec(g->vece, dofs, aofs, bofs, cofs, some,=0D
+                     32, TCG_TYPE_V256, g->write_aofs, g->fniv);=0D
+        if (some =3D=3D oprsz) {=0D
+            break;=0D
+        }=0D
+        dofs +=3D some;=0D
+        aofs +=3D some;=0D
+        bofs +=3D some;=0D
+        cofs +=3D some;=0D
+        oprsz -=3D some;=0D
+        maxsz -=3D some;=0D
+        /* fallthru */=0D
+    case TCG_TYPE_V128:=0D
+        expand_4_vec(g->vece, dofs, aofs, bofs, cofs, oprsz,=0D
+                     16, TCG_TYPE_V128, g->write_aofs, g->fniv);=0D
+        break;=0D
+    case TCG_TYPE_V64:=0D
+        expand_4_vec(g->vece, dofs, aofs, bofs, cofs, oprsz,=0D
+                     8, TCG_TYPE_V64, g->write_aofs, g->fniv);=0D
+        break;=0D
+=0D
+    case 0:=0D
+        if (g->fni8 && check_size_impl(oprsz, 8)) {=0D
+            expand_4_i64(dofs, aofs, bofs, cofs, oprsz,=0D
+                         g->write_aofs, g->fni8);=0D
+        } else if (g->fni4 && check_size_impl(oprsz, 4)) {=0D
+            expand_4_i32(dofs, aofs, bofs, cofs, oprsz,=0D
+                         g->write_aofs, g->fni4);=0D
+        } else {=0D
+            assert(g->fno !=3D NULL);=0D
+            tcg_gen_gvec_4_ool(dofs, aofs, bofs, cofs,=0D
+                               oprsz, maxsz, g->data, g->fno);=0D
+            oprsz =3D maxsz;=0D
+        }=0D
+        break;=0D
+=0D
+    default:=0D
+        g_assert_not_reached();=0D
+    }=0D
+    tcg_swap_vecop_list(hold_list);=0D
+=0D
+    if (oprsz < maxsz) {=0D
+        expand_clr(dofs + oprsz, maxsz - oprsz);=0D
+    }=0D
+}=0D
+=0D
+/*=0D
+ * Expand specific vector operations.=0D
+ */=0D
+=0D
+static void vec_mov2(unsigned vece, TCGv_vec a, TCGv_vec b)=0D
+{=0D
+    tcg_gen_mov_vec(a, b);=0D
+}=0D
+=0D
+void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                      uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen2 g =3D {=0D
+        .fni8 =3D tcg_gen_mov_i64,=0D
+        .fniv =3D vec_mov2,=0D
+        .fno =3D gen_helper_gvec_mov,=0D
+        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+    };=0D
+    if (dofs !=3D aofs) {=0D
+        tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g);=0D
+    } else {=0D
+        check_size_align(oprsz, maxsz, dofs);=0D
+        if (oprsz < maxsz) {=0D
+            expand_clr(dofs + oprsz, maxsz - oprsz);=0D
+        }=0D
+    }=0D
+}=0D
+=0D
+void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t oprsz,=0D
+                          uint32_t maxsz, TCGv_i32 in)=0D
+{=0D
+    check_size_align(oprsz, maxsz, dofs);=0D
+    tcg_debug_assert(vece <=3D MO_32);=0D
+    do_dup(vece, dofs, oprsz, maxsz, in, NULL, 0);=0D
+}=0D
+=0D
+void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t oprsz,=0D
+                          uint32_t maxsz, TCGv_i64 in)=0D
+{=0D
+    check_size_align(oprsz, maxsz, dofs);=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);=0D
+}=0D
+=0D
+void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                          uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    check_size_align(oprsz, maxsz, dofs);=0D
+    if (vece <=3D MO_64) {=0D
+        TCGType type =3D choose_vector_type(NULL, vece, oprsz, 0);=0D
+        if (type !=3D 0) {=0D
+            TCGv_vec t_vec =3D tcg_temp_new_vec(type);=0D
+            tcg_gen_dup_mem_vec(vece, t_vec, cpu_env, aofs);=0D
+            do_dup_store(type, dofs, oprsz, maxsz, t_vec);=0D
+            tcg_temp_free_vec(t_vec);=0D
+        } else if (vece <=3D MO_32) {=0D
+            TCGv_i32 in =3D tcg_temp_new_i32();=0D
+            switch (vece) {=0D
+            case MO_8:=0D
+                tcg_gen_ld8u_i32(in, cpu_env, aofs);=0D
+                break;=0D
+            case MO_16:=0D
+                tcg_gen_ld16u_i32(in, cpu_env, aofs);=0D
+                break;=0D
+            default:=0D
+                tcg_gen_ld_i32(in, cpu_env, aofs);=0D
+                break;=0D
+            }=0D
+            do_dup(vece, dofs, oprsz, maxsz, in, NULL, 0);=0D
+            tcg_temp_free_i32(in);=0D
+        } else {=0D
+            TCGv_i64 in =3D tcg_temp_new_i64();=0D
+            tcg_gen_ld_i64(in, cpu_env, aofs);=0D
+            do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);=0D
+            tcg_temp_free_i64(in);=0D
+        }=0D
+    } else {=0D
+        /* 128-bit duplicate.  */=0D
+        /* ??? Dup to 256-bit vector.  */=0D
+        int i;=0D
+=0D
+        tcg_debug_assert(vece =3D=3D 4);=0D
+        tcg_debug_assert(oprsz >=3D 16);=0D
+        if (TCG_TARGET_HAS_v128) {=0D
+            TCGv_vec in =3D tcg_temp_new_vec(TCG_TYPE_V128);=0D
+=0D
+            tcg_gen_ld_vec(in, cpu_env, aofs);=0D
+            for (i =3D 0; i < oprsz; i +=3D 16) {=0D
+                tcg_gen_st_vec(in, cpu_env, dofs + i);=0D
+            }=0D
+            tcg_temp_free_vec(in);=0D
+        } else {=0D
+            TCGv_i64 in0 =3D tcg_temp_new_i64();=0D
+            TCGv_i64 in1 =3D tcg_temp_new_i64();=0D
+=0D
+            tcg_gen_ld_i64(in0, cpu_env, aofs);=0D
+            tcg_gen_ld_i64(in1, cpu_env, aofs + 8);=0D
+            for (i =3D 0; i < oprsz; i +=3D 16) {=0D
+                tcg_gen_st_i64(in0, cpu_env, dofs + i);=0D
+                tcg_gen_st_i64(in1, cpu_env, dofs + i + 8);=0D
+            }=0D
+            tcg_temp_free_i64(in0);=0D
+            tcg_temp_free_i64(in1);=0D
+        }=0D
+        if (oprsz < maxsz) {=0D
+            expand_clr(dofs + oprsz, maxsz - oprsz);=0D
+        }=0D
+    }=0D
+}=0D
+=0D
+void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,=0D
+                          uint32_t maxsz, uint64_t x)=0D
+{=0D
+    check_size_align(oprsz, maxsz, dofs);=0D
+    do_dup(vece, dofs, oprsz, maxsz, NULL, NULL, x);=0D
+}=0D
+=0D
+void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                      uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen2 g =3D {=0D
+        .fni8 =3D tcg_gen_not_i64,=0D
+        .fniv =3D tcg_gen_not_vec,=0D
+        .fno =3D gen_helper_gvec_not,=0D
+        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+    };=0D
+    tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g);=0D
+}=0D
+=0D
+/* Perform a vector addition using normal addition and a mask.  The mask=0D
+   should be the sign bit of each lane.  This 6-operation form is more=0D
+   efficient than separate additions when there are 4 or more lanes in=0D
+   the 64-bit operation.  */=0D
+static void gen_addv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)=
=0D
+{=0D
+    TCGv_i64 t1 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t2 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t3 =3D tcg_temp_new_i64();=0D
+=0D
+    tcg_gen_andc_i64(t1, a, m);=0D
+    tcg_gen_andc_i64(t2, b, m);=0D
+    tcg_gen_xor_i64(t3, a, b);=0D
+    tcg_gen_add_i64(d, t1, t2);=0D
+    tcg_gen_and_i64(t3, t3, m);=0D
+    tcg_gen_xor_i64(d, d, t3);=0D
+=0D
+    tcg_temp_free_i64(t1);=0D
+    tcg_temp_free_i64(t2);=0D
+    tcg_temp_free_i64(t3);=0D
+}=0D
+=0D
+void tcg_gen_vec_add8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_8, 0x80));=0D
+    gen_addv_mask(d, a, b, m);=0D
+    tcg_temp_free_i64(m);=0D
+}=0D
+=0D
+void tcg_gen_vec_add16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_16, 0x8000));=0D
+    gen_addv_mask(d, a, b, m);=0D
+    tcg_temp_free_i64(m);=0D
+}=0D
+=0D
+void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 t1 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t2 =3D tcg_temp_new_i64();=0D
+=0D
+    tcg_gen_andi_i64(t1, a, ~0xffffffffull);=0D
+    tcg_gen_add_i64(t2, a, b);=0D
+    tcg_gen_add_i64(t1, t1, b);=0D
+    tcg_gen_deposit_i64(d, t1, t2, 0, 32);=0D
+=0D
+    tcg_temp_free_i64(t1);=0D
+    tcg_temp_free_i64(t2);=0D
+}=0D
+=0D
+static const TCGOpcode vecop_list_add[] =3D { INDEX_op_add_vec, 0 };=0D
+=0D
+void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fni8 =3D tcg_gen_vec_add8_i64,=0D
+          .fniv =3D tcg_gen_add_vec,=0D
+          .fno =3D gen_helper_gvec_add8,=0D
+          .opt_opc =3D vecop_list_add,=0D
+          .vece =3D MO_8 },=0D
+        { .fni8 =3D tcg_gen_vec_add16_i64,=0D
+          .fniv =3D tcg_gen_add_vec,=0D
+          .fno =3D gen_helper_gvec_add16,=0D
+          .opt_opc =3D vecop_list_add,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_add_i32,=0D
+          .fniv =3D tcg_gen_add_vec,=0D
+          .fno =3D gen_helper_gvec_add32,=0D
+          .opt_opc =3D vecop_list_add,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_add_i64,=0D
+          .fniv =3D tcg_gen_add_vec,=0D
+          .fno =3D gen_helper_gvec_add64,=0D
+          .opt_opc =3D vecop_list_add,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen2s g[4] =3D {=0D
+        { .fni8 =3D tcg_gen_vec_add8_i64,=0D
+          .fniv =3D tcg_gen_add_vec,=0D
+          .fno =3D gen_helper_gvec_adds8,=0D
+          .opt_opc =3D vecop_list_add,=0D
+          .vece =3D MO_8 },=0D
+        { .fni8 =3D tcg_gen_vec_add16_i64,=0D
+          .fniv =3D tcg_gen_add_vec,=0D
+          .fno =3D gen_helper_gvec_adds16,=0D
+          .opt_opc =3D vecop_list_add,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_add_i32,=0D
+          .fniv =3D tcg_gen_add_vec,=0D
+          .fno =3D gen_helper_gvec_adds32,=0D
+          .opt_opc =3D vecop_list_add,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_add_i64,=0D
+          .fniv =3D tcg_gen_add_vec,=0D
+          .fno =3D gen_helper_gvec_adds64,=0D
+          .opt_opc =3D vecop_list_add,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g[vece]);=0D
+}=0D
+=0D
+void tcg_gen_gvec_addi(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       int64_t c, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    TCGv_i64 tmp =3D tcg_const_i64(c);=0D
+    tcg_gen_gvec_adds(vece, dofs, aofs, tmp, oprsz, maxsz);=0D
+    tcg_temp_free_i64(tmp);=0D
+}=0D
+=0D
+static const TCGOpcode vecop_list_sub[] =3D { INDEX_op_sub_vec, 0 };=0D
+=0D
+void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen2s g[4] =3D {=0D
+        { .fni8 =3D tcg_gen_vec_sub8_i64,=0D
+          .fniv =3D tcg_gen_sub_vec,=0D
+          .fno =3D gen_helper_gvec_subs8,=0D
+          .opt_opc =3D vecop_list_sub,=0D
+          .vece =3D MO_8 },=0D
+        { .fni8 =3D tcg_gen_vec_sub16_i64,=0D
+          .fniv =3D tcg_gen_sub_vec,=0D
+          .fno =3D gen_helper_gvec_subs16,=0D
+          .opt_opc =3D vecop_list_sub,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_sub_i32,=0D
+          .fniv =3D tcg_gen_sub_vec,=0D
+          .fno =3D gen_helper_gvec_subs32,=0D
+          .opt_opc =3D vecop_list_sub,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_sub_i64,=0D
+          .fniv =3D tcg_gen_sub_vec,=0D
+          .fno =3D gen_helper_gvec_subs64,=0D
+          .opt_opc =3D vecop_list_sub,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g[vece]);=0D
+}=0D
+=0D
+/* Perform a vector subtraction using normal subtraction and a mask.=0D
+   Compare gen_addv_mask above.  */=0D
+static void gen_subv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)=
=0D
+{=0D
+    TCGv_i64 t1 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t2 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t3 =3D tcg_temp_new_i64();=0D
+=0D
+    tcg_gen_or_i64(t1, a, m);=0D
+    tcg_gen_andc_i64(t2, b, m);=0D
+    tcg_gen_eqv_i64(t3, a, b);=0D
+    tcg_gen_sub_i64(d, t1, t2);=0D
+    tcg_gen_and_i64(t3, t3, m);=0D
+    tcg_gen_xor_i64(d, d, t3);=0D
+=0D
+    tcg_temp_free_i64(t1);=0D
+    tcg_temp_free_i64(t2);=0D
+    tcg_temp_free_i64(t3);=0D
+}=0D
+=0D
+void tcg_gen_vec_sub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_8, 0x80));=0D
+    gen_subv_mask(d, a, b, m);=0D
+    tcg_temp_free_i64(m);=0D
+}=0D
+=0D
+void tcg_gen_vec_sub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_16, 0x8000));=0D
+    gen_subv_mask(d, a, b, m);=0D
+    tcg_temp_free_i64(m);=0D
+}=0D
+=0D
+void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 t1 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t2 =3D tcg_temp_new_i64();=0D
+=0D
+    tcg_gen_andi_i64(t1, b, ~0xffffffffull);=0D
+    tcg_gen_sub_i64(t2, a, b);=0D
+    tcg_gen_sub_i64(t1, a, t1);=0D
+    tcg_gen_deposit_i64(d, t1, t2, 0, 32);=0D
+=0D
+    tcg_temp_free_i64(t1);=0D
+    tcg_temp_free_i64(t2);=0D
+}=0D
+=0D
+void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fni8 =3D tcg_gen_vec_sub8_i64,=0D
+          .fniv =3D tcg_gen_sub_vec,=0D
+          .fno =3D gen_helper_gvec_sub8,=0D
+          .opt_opc =3D vecop_list_sub,=0D
+          .vece =3D MO_8 },=0D
+        { .fni8 =3D tcg_gen_vec_sub16_i64,=0D
+          .fniv =3D tcg_gen_sub_vec,=0D
+          .fno =3D gen_helper_gvec_sub16,=0D
+          .opt_opc =3D vecop_list_sub,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_sub_i32,=0D
+          .fniv =3D tcg_gen_sub_vec,=0D
+          .fno =3D gen_helper_gvec_sub32,=0D
+          .opt_opc =3D vecop_list_sub,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_sub_i64,=0D
+          .fniv =3D tcg_gen_sub_vec,=0D
+          .fno =3D gen_helper_gvec_sub64,=0D
+          .opt_opc =3D vecop_list_sub,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+static const TCGOpcode vecop_list_mul[] =3D { INDEX_op_mul_vec, 0 };=0D
+=0D
+void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fniv =3D tcg_gen_mul_vec,=0D
+          .fno =3D gen_helper_gvec_mul8,=0D
+          .opt_opc =3D vecop_list_mul,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_mul_vec,=0D
+          .fno =3D gen_helper_gvec_mul16,=0D
+          .opt_opc =3D vecop_list_mul,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_mul_i32,=0D
+          .fniv =3D tcg_gen_mul_vec,=0D
+          .fno =3D gen_helper_gvec_mul32,=0D
+          .opt_opc =3D vecop_list_mul,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_mul_i64,=0D
+          .fniv =3D tcg_gen_mul_vec,=0D
+          .fno =3D gen_helper_gvec_mul64,=0D
+          .opt_opc =3D vecop_list_mul,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+void tcg_gen_gvec_muls(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen2s g[4] =3D {=0D
+        { .fniv =3D tcg_gen_mul_vec,=0D
+          .fno =3D gen_helper_gvec_muls8,=0D
+          .opt_opc =3D vecop_list_mul,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_mul_vec,=0D
+          .fno =3D gen_helper_gvec_muls16,=0D
+          .opt_opc =3D vecop_list_mul,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_mul_i32,=0D
+          .fniv =3D tcg_gen_mul_vec,=0D
+          .fno =3D gen_helper_gvec_muls32,=0D
+          .opt_opc =3D vecop_list_mul,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_mul_i64,=0D
+          .fniv =3D tcg_gen_mul_vec,=0D
+          .fno =3D gen_helper_gvec_muls64,=0D
+          .opt_opc =3D vecop_list_mul,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g[vece]);=0D
+}=0D
+=0D
+void tcg_gen_gvec_muli(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       int64_t c, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    TCGv_i64 tmp =3D tcg_const_i64(c);=0D
+    tcg_gen_gvec_muls(vece, dofs, aofs, tmp, oprsz, maxsz);=0D
+    tcg_temp_free_i64(tmp);=0D
+}=0D
+=0D
+void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_ssadd_vec, 0 };=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fniv =3D tcg_gen_ssadd_vec,=0D
+          .fno =3D gen_helper_gvec_ssadd8,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_ssadd_vec,=0D
+          .fno =3D gen_helper_gvec_ssadd16,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fniv =3D tcg_gen_ssadd_vec,=0D
+          .fno =3D gen_helper_gvec_ssadd32,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fniv =3D tcg_gen_ssadd_vec,=0D
+          .fno =3D gen_helper_gvec_ssadd64,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_sssub_vec, 0 };=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fniv =3D tcg_gen_sssub_vec,=0D
+          .fno =3D gen_helper_gvec_sssub8,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_sssub_vec,=0D
+          .fno =3D gen_helper_gvec_sssub16,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fniv =3D tcg_gen_sssub_vec,=0D
+          .fno =3D gen_helper_gvec_sssub32,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fniv =3D tcg_gen_sssub_vec,=0D
+          .fno =3D gen_helper_gvec_sssub64,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+static void tcg_gen_usadd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)=0D
+{=0D
+    TCGv_i32 max =3D tcg_const_i32(-1);=0D
+    tcg_gen_add_i32(d, a, b);=0D
+    tcg_gen_movcond_i32(TCG_COND_LTU, d, d, a, max, d);=0D
+    tcg_temp_free_i32(max);=0D
+}=0D
+=0D
+static void tcg_gen_usadd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 max =3D tcg_const_i64(-1);=0D
+    tcg_gen_add_i64(d, a, b);=0D
+    tcg_gen_movcond_i64(TCG_COND_LTU, d, d, a, max, d);=0D
+    tcg_temp_free_i64(max);=0D
+}=0D
+=0D
+void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_usadd_vec, 0 };=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fniv =3D tcg_gen_usadd_vec,=0D
+          .fno =3D gen_helper_gvec_usadd8,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_usadd_vec,=0D
+          .fno =3D gen_helper_gvec_usadd16,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_usadd_i32,=0D
+          .fniv =3D tcg_gen_usadd_vec,=0D
+          .fno =3D gen_helper_gvec_usadd32,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_usadd_i64,=0D
+          .fniv =3D tcg_gen_usadd_vec,=0D
+          .fno =3D gen_helper_gvec_usadd64,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_64 }=0D
+    };=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+static void tcg_gen_ussub_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)=0D
+{=0D
+    TCGv_i32 min =3D tcg_const_i32(0);=0D
+    tcg_gen_sub_i32(d, a, b);=0D
+    tcg_gen_movcond_i32(TCG_COND_LTU, d, a, b, min, d);=0D
+    tcg_temp_free_i32(min);=0D
+}=0D
+=0D
+static void tcg_gen_ussub_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 min =3D tcg_const_i64(0);=0D
+    tcg_gen_sub_i64(d, a, b);=0D
+    tcg_gen_movcond_i64(TCG_COND_LTU, d, a, b, min, d);=0D
+    tcg_temp_free_i64(min);=0D
+}=0D
+=0D
+void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_ussub_vec, 0 };=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fniv =3D tcg_gen_ussub_vec,=0D
+          .fno =3D gen_helper_gvec_ussub8,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_ussub_vec,=0D
+          .fno =3D gen_helper_gvec_ussub16,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_ussub_i32,=0D
+          .fniv =3D tcg_gen_ussub_vec,=0D
+          .fno =3D gen_helper_gvec_ussub32,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_ussub_i64,=0D
+          .fniv =3D tcg_gen_ussub_vec,=0D
+          .fno =3D gen_helper_gvec_ussub64,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_64 }=0D
+    };=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_smin_vec, 0 };=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fniv =3D tcg_gen_smin_vec,=0D
+          .fno =3D gen_helper_gvec_smin8,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_smin_vec,=0D
+          .fno =3D gen_helper_gvec_smin16,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_smin_i32,=0D
+          .fniv =3D tcg_gen_smin_vec,=0D
+          .fno =3D gen_helper_gvec_smin32,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_smin_i64,=0D
+          .fniv =3D tcg_gen_smin_vec,=0D
+          .fno =3D gen_helper_gvec_smin64,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_64 }=0D
+    };=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_umin_vec, 0 };=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fniv =3D tcg_gen_umin_vec,=0D
+          .fno =3D gen_helper_gvec_umin8,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_umin_vec,=0D
+          .fno =3D gen_helper_gvec_umin16,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_umin_i32,=0D
+          .fniv =3D tcg_gen_umin_vec,=0D
+          .fno =3D gen_helper_gvec_umin32,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_umin_i64,=0D
+          .fniv =3D tcg_gen_umin_vec,=0D
+          .fno =3D gen_helper_gvec_umin64,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_64 }=0D
+    };=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_smax_vec, 0 };=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fniv =3D tcg_gen_smax_vec,=0D
+          .fno =3D gen_helper_gvec_smax8,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_smax_vec,=0D
+          .fno =3D gen_helper_gvec_smax16,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_smax_i32,=0D
+          .fniv =3D tcg_gen_smax_vec,=0D
+          .fno =3D gen_helper_gvec_smax32,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_smax_i64,=0D
+          .fniv =3D tcg_gen_smax_vec,=0D
+          .fno =3D gen_helper_gvec_smax64,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_64 }=0D
+    };=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_umax_vec, 0 };=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fniv =3D tcg_gen_umax_vec,=0D
+          .fno =3D gen_helper_gvec_umax8,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_umax_vec,=0D
+          .fno =3D gen_helper_gvec_umax16,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_umax_i32,=0D
+          .fniv =3D tcg_gen_umax_vec,=0D
+          .fno =3D gen_helper_gvec_umax32,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_umax_i64,=0D
+          .fniv =3D tcg_gen_umax_vec,=0D
+          .fno =3D gen_helper_gvec_umax64,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_64 }=0D
+    };=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+/* Perform a vector negation using normal negation and a mask.=0D
+   Compare gen_subv_mask above.  */=0D
+static void gen_negv_mask(TCGv_i64 d, TCGv_i64 b, TCGv_i64 m)=0D
+{=0D
+    TCGv_i64 t2 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t3 =3D tcg_temp_new_i64();=0D
+=0D
+    tcg_gen_andc_i64(t3, m, b);=0D
+    tcg_gen_andc_i64(t2, b, m);=0D
+    tcg_gen_sub_i64(d, m, t2);=0D
+    tcg_gen_xor_i64(d, d, t3);=0D
+=0D
+    tcg_temp_free_i64(t2);=0D
+    tcg_temp_free_i64(t3);=0D
+}=0D
+=0D
+void tcg_gen_vec_neg8_i64(TCGv_i64 d, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_8, 0x80));=0D
+    gen_negv_mask(d, b, m);=0D
+    tcg_temp_free_i64(m);=0D
+}=0D
+=0D
+void tcg_gen_vec_neg16_i64(TCGv_i64 d, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_16, 0x8000));=0D
+    gen_negv_mask(d, b, m);=0D
+    tcg_temp_free_i64(m);=0D
+}=0D
+=0D
+void tcg_gen_vec_neg32_i64(TCGv_i64 d, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 t1 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t2 =3D tcg_temp_new_i64();=0D
+=0D
+    tcg_gen_andi_i64(t1, b, ~0xffffffffull);=0D
+    tcg_gen_neg_i64(t2, b);=0D
+    tcg_gen_neg_i64(t1, t1);=0D
+    tcg_gen_deposit_i64(d, t1, t2, 0, 32);=0D
+=0D
+    tcg_temp_free_i64(t1);=0D
+    tcg_temp_free_i64(t2);=0D
+}=0D
+=0D
+void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                      uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_neg_vec, 0 };=0D
+    static const GVecGen2 g[4] =3D {=0D
+        { .fni8 =3D tcg_gen_vec_neg8_i64,=0D
+          .fniv =3D tcg_gen_neg_vec,=0D
+          .fno =3D gen_helper_gvec_neg8,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fni8 =3D tcg_gen_vec_neg16_i64,=0D
+          .fniv =3D tcg_gen_neg_vec,=0D
+          .fno =3D gen_helper_gvec_neg16,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_neg_i32,=0D
+          .fniv =3D tcg_gen_neg_vec,=0D
+          .fno =3D gen_helper_gvec_neg32,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_neg_i64,=0D
+          .fniv =3D tcg_gen_neg_vec,=0D
+          .fno =3D gen_helper_gvec_neg64,=0D
+          .opt_opc =3D vecop_list,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+static void gen_absv_mask(TCGv_i64 d, TCGv_i64 b, unsigned vece)=0D
+{=0D
+    TCGv_i64 t =3D tcg_temp_new_i64();=0D
+    int nbit =3D 8 << vece;=0D
+=0D
+    /* Create -1 for each negative element.  */=0D
+    tcg_gen_shri_i64(t, b, nbit - 1);=0D
+    tcg_gen_andi_i64(t, t, dup_const(vece, 1));=0D
+    tcg_gen_muli_i64(t, t, (1 << nbit) - 1);=0D
+=0D
+    /*=0D
+     * Invert (via xor -1) and add one (via sub -1).=0D
+     * Because of the ordering the msb is cleared,=0D
+     * so we never have carry into the next element.=0D
+     */=0D
+    tcg_gen_xor_i64(d, b, t);=0D
+    tcg_gen_sub_i64(d, d, t);=0D
+=0D
+    tcg_temp_free_i64(t);=0D
+}=0D
+=0D
+static void tcg_gen_vec_abs8_i64(TCGv_i64 d, TCGv_i64 b)=0D
+{=0D
+    gen_absv_mask(d, b, MO_8);=0D
+}=0D
+=0D
+static void tcg_gen_vec_abs16_i64(TCGv_i64 d, TCGv_i64 b)=0D
+{=0D
+    gen_absv_mask(d, b, MO_16);=0D
+}=0D
+=0D
+void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                      uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_abs_vec, 0 };=0D
+    static const GVecGen2 g[4] =3D {=0D
+        { .fni8 =3D tcg_gen_vec_abs8_i64,=0D
+          .fniv =3D tcg_gen_abs_vec,=0D
+          .fno =3D gen_helper_gvec_abs8,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fni8 =3D tcg_gen_vec_abs16_i64,=0D
+          .fniv =3D tcg_gen_abs_vec,=0D
+          .fno =3D gen_helper_gvec_abs16,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_abs_i32,=0D
+          .fniv =3D tcg_gen_abs_vec,=0D
+          .fno =3D gen_helper_gvec_abs32,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_abs_i64,=0D
+          .fniv =3D tcg_gen_abs_vec,=0D
+          .fno =3D gen_helper_gvec_abs64,=0D
+          .opt_opc =3D vecop_list,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen3 g =3D {=0D
+        .fni8 =3D tcg_gen_and_i64,=0D
+        .fniv =3D tcg_gen_and_vec,=0D
+        .fno =3D gen_helper_gvec_and,=0D
+        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+    };=0D
+=0D
+    if (aofs =3D=3D bofs) {=0D
+        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);=0D
+    } else {=0D
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);=0D
+    }=0D
+}=0D
+=0D
+void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                     uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen3 g =3D {=0D
+        .fni8 =3D tcg_gen_or_i64,=0D
+        .fniv =3D tcg_gen_or_vec,=0D
+        .fno =3D gen_helper_gvec_or,=0D
+        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+    };=0D
+=0D
+    if (aofs =3D=3D bofs) {=0D
+        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);=0D
+    } else {=0D
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);=0D
+    }=0D
+}=0D
+=0D
+void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen3 g =3D {=0D
+        .fni8 =3D tcg_gen_xor_i64,=0D
+        .fniv =3D tcg_gen_xor_vec,=0D
+        .fno =3D gen_helper_gvec_xor,=0D
+        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+    };=0D
+=0D
+    if (aofs =3D=3D bofs) {=0D
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, 0);=0D
+    } else {=0D
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);=0D
+    }=0D
+}=0D
+=0D
+void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen3 g =3D {=0D
+        .fni8 =3D tcg_gen_andc_i64,=0D
+        .fniv =3D tcg_gen_andc_vec,=0D
+        .fno =3D gen_helper_gvec_andc,=0D
+        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+    };=0D
+=0D
+    if (aofs =3D=3D bofs) {=0D
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, 0);=0D
+    } else {=0D
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);=0D
+    }=0D
+}=0D
+=0D
+void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen3 g =3D {=0D
+        .fni8 =3D tcg_gen_orc_i64,=0D
+        .fniv =3D tcg_gen_orc_vec,=0D
+        .fno =3D gen_helper_gvec_orc,=0D
+        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+    };=0D
+=0D
+    if (aofs =3D=3D bofs) {=0D
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, -1);=0D
+    } else {=0D
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);=0D
+    }=0D
+}=0D
+=0D
+void tcg_gen_gvec_nand(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen3 g =3D {=0D
+        .fni8 =3D tcg_gen_nand_i64,=0D
+        .fniv =3D tcg_gen_nand_vec,=0D
+        .fno =3D gen_helper_gvec_nand,=0D
+        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+    };=0D
+=0D
+    if (aofs =3D=3D bofs) {=0D
+        tcg_gen_gvec_not(vece, dofs, aofs, oprsz, maxsz);=0D
+    } else {=0D
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);=0D
+    }=0D
+}=0D
+=0D
+void tcg_gen_gvec_nor(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen3 g =3D {=0D
+        .fni8 =3D tcg_gen_nor_i64,=0D
+        .fniv =3D tcg_gen_nor_vec,=0D
+        .fno =3D gen_helper_gvec_nor,=0D
+        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+    };=0D
+=0D
+    if (aofs =3D=3D bofs) {=0D
+        tcg_gen_gvec_not(vece, dofs, aofs, oprsz, maxsz);=0D
+    } else {=0D
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);=0D
+    }=0D
+}=0D
+=0D
+void tcg_gen_gvec_eqv(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen3 g =3D {=0D
+        .fni8 =3D tcg_gen_eqv_i64,=0D
+        .fniv =3D tcg_gen_eqv_vec,=0D
+        .fno =3D gen_helper_gvec_eqv,=0D
+        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+    };=0D
+=0D
+    if (aofs =3D=3D bofs) {=0D
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, -1);=0D
+    } else {=0D
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);=0D
+    }=0D
+}=0D
+=0D
+static const GVecGen2s gop_ands =3D {=0D
+    .fni8 =3D tcg_gen_and_i64,=0D
+    .fniv =3D tcg_gen_and_vec,=0D
+    .fno =3D gen_helper_gvec_ands,=0D
+    .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+    .vece =3D MO_64=0D
+};=0D
+=0D
+void tcg_gen_gvec_ands(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    TCGv_i64 tmp =3D tcg_temp_new_i64();=0D
+    gen_dup_i64(vece, tmp, c);=0D
+    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_ands);=0D
+    tcg_temp_free_i64(tmp);=0D
+}=0D
+=0D
+void tcg_gen_gvec_andi(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       int64_t c, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    TCGv_i64 tmp =3D tcg_const_i64(dup_const(vece, c));=0D
+    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_ands);=0D
+    tcg_temp_free_i64(tmp);=0D
+}=0D
+=0D
+static const GVecGen2s gop_xors =3D {=0D
+    .fni8 =3D tcg_gen_xor_i64,=0D
+    .fniv =3D tcg_gen_xor_vec,=0D
+    .fno =3D gen_helper_gvec_xors,=0D
+    .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+    .vece =3D MO_64=0D
+};=0D
+=0D
+void tcg_gen_gvec_xors(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    TCGv_i64 tmp =3D tcg_temp_new_i64();=0D
+    gen_dup_i64(vece, tmp, c);=0D
+    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_xors);=0D
+    tcg_temp_free_i64(tmp);=0D
+}=0D
+=0D
+void tcg_gen_gvec_xori(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       int64_t c, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    TCGv_i64 tmp =3D tcg_const_i64(dup_const(vece, c));=0D
+    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_xors);=0D
+    tcg_temp_free_i64(tmp);=0D
+}=0D
+=0D
+static const GVecGen2s gop_ors =3D {=0D
+    .fni8 =3D tcg_gen_or_i64,=0D
+    .fniv =3D tcg_gen_or_vec,=0D
+    .fno =3D gen_helper_gvec_ors,=0D
+    .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+    .vece =3D MO_64=0D
+};=0D
+=0D
+void tcg_gen_gvec_ors(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                      TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    TCGv_i64 tmp =3D tcg_temp_new_i64();=0D
+    gen_dup_i64(vece, tmp, c);=0D
+    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_ors);=0D
+    tcg_temp_free_i64(tmp);=0D
+}=0D
+=0D
+void tcg_gen_gvec_ori(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                      int64_t c, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    TCGv_i64 tmp =3D tcg_const_i64(dup_const(vece, c));=0D
+    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_ors);=0D
+    tcg_temp_free_i64(tmp);=0D
+}=0D
+=0D
+void tcg_gen_vec_shl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)=0D
+{=0D
+    uint64_t mask =3D dup_const(MO_8, 0xff << c);=0D
+    tcg_gen_shli_i64(d, a, c);=0D
+    tcg_gen_andi_i64(d, d, mask);=0D
+}=0D
+=0D
+void tcg_gen_vec_shl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)=0D
+{=0D
+    uint64_t mask =3D dup_const(MO_16, 0xffff << c);=0D
+    tcg_gen_shli_i64(d, a, c);=0D
+    tcg_gen_andi_i64(d, d, mask);=0D
+}=0D
+=0D
+void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       int64_t shift, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_shli_vec, 0 };=0D
+    static const GVecGen2i g[4] =3D {=0D
+        { .fni8 =3D tcg_gen_vec_shl8i_i64,=0D
+          .fniv =3D tcg_gen_shli_vec,=0D
+          .fno =3D gen_helper_gvec_shl8i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fni8 =3D tcg_gen_vec_shl16i_i64,=0D
+          .fniv =3D tcg_gen_shli_vec,=0D
+          .fno =3D gen_helper_gvec_shl16i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_shli_i32,=0D
+          .fniv =3D tcg_gen_shli_vec,=0D
+          .fno =3D gen_helper_gvec_shl32i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_shli_i64,=0D
+          .fniv =3D tcg_gen_shli_vec,=0D
+          .fno =3D gen_helper_gvec_shl64i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));=0D
+    if (shift =3D=3D 0) {=0D
+        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);=0D
+    } else {=0D
+        tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, shift, &g[vece]);=0D
+    }=0D
+}=0D
+=0D
+void tcg_gen_vec_shr8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)=0D
+{=0D
+    uint64_t mask =3D dup_const(MO_8, 0xff >> c);=0D
+    tcg_gen_shri_i64(d, a, c);=0D
+    tcg_gen_andi_i64(d, d, mask);=0D
+}=0D
+=0D
+void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)=0D
+{=0D
+    uint64_t mask =3D dup_const(MO_16, 0xffff >> c);=0D
+    tcg_gen_shri_i64(d, a, c);=0D
+    tcg_gen_andi_i64(d, d, mask);=0D
+}=0D
+=0D
+void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       int64_t shift, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_shri_vec, 0 };=0D
+    static const GVecGen2i g[4] =3D {=0D
+        { .fni8 =3D tcg_gen_vec_shr8i_i64,=0D
+          .fniv =3D tcg_gen_shri_vec,=0D
+          .fno =3D gen_helper_gvec_shr8i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fni8 =3D tcg_gen_vec_shr16i_i64,=0D
+          .fniv =3D tcg_gen_shri_vec,=0D
+          .fno =3D gen_helper_gvec_shr16i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_shri_i32,=0D
+          .fniv =3D tcg_gen_shri_vec,=0D
+          .fno =3D gen_helper_gvec_shr32i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_shri_i64,=0D
+          .fniv =3D tcg_gen_shri_vec,=0D
+          .fno =3D gen_helper_gvec_shr64i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));=0D
+    if (shift =3D=3D 0) {=0D
+        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);=0D
+    } else {=0D
+        tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, shift, &g[vece]);=0D
+    }=0D
+}=0D
+=0D
+void tcg_gen_vec_sar8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)=0D
+{=0D
+    uint64_t s_mask =3D dup_const(MO_8, 0x80 >> c);=0D
+    uint64_t c_mask =3D dup_const(MO_8, 0xff >> c);=0D
+    TCGv_i64 s =3D tcg_temp_new_i64();=0D
+=0D
+    tcg_gen_shri_i64(d, a, c);=0D
+    tcg_gen_andi_i64(s, d, s_mask);  /* isolate (shifted) sign bit */=0D
+    tcg_gen_muli_i64(s, s, (2 << c) - 2); /* replicate isolated signs */=0D
+    tcg_gen_andi_i64(d, d, c_mask);  /* clear out bits above sign  */=0D
+    tcg_gen_or_i64(d, d, s);         /* include sign extension */=0D
+    tcg_temp_free_i64(s);=0D
+}=0D
+=0D
+void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)=0D
+{=0D
+    uint64_t s_mask =3D dup_const(MO_16, 0x8000 >> c);=0D
+    uint64_t c_mask =3D dup_const(MO_16, 0xffff >> c);=0D
+    TCGv_i64 s =3D tcg_temp_new_i64();=0D
+=0D
+    tcg_gen_shri_i64(d, a, c);=0D
+    tcg_gen_andi_i64(s, d, s_mask);  /* isolate (shifted) sign bit */=0D
+    tcg_gen_andi_i64(d, d, c_mask);  /* clear out bits above sign  */=0D
+    tcg_gen_muli_i64(s, s, (2 << c) - 2); /* replicate isolated signs */=0D
+    tcg_gen_or_i64(d, d, s);         /* include sign extension */=0D
+    tcg_temp_free_i64(s);=0D
+}=0D
+=0D
+void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       int64_t shift, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_sari_vec, 0 };=0D
+    static const GVecGen2i g[4] =3D {=0D
+        { .fni8 =3D tcg_gen_vec_sar8i_i64,=0D
+          .fniv =3D tcg_gen_sari_vec,=0D
+          .fno =3D gen_helper_gvec_sar8i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fni8 =3D tcg_gen_vec_sar16i_i64,=0D
+          .fniv =3D tcg_gen_sari_vec,=0D
+          .fno =3D gen_helper_gvec_sar16i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_sari_i32,=0D
+          .fniv =3D tcg_gen_sari_vec,=0D
+          .fno =3D gen_helper_gvec_sar32i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_sari_i64,=0D
+          .fniv =3D tcg_gen_sari_vec,=0D
+          .fno =3D gen_helper_gvec_sar64i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));=0D
+    if (shift =3D=3D 0) {=0D
+        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);=0D
+    } else {=0D
+        tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, shift, &g[vece]);=0D
+    }=0D
+}=0D
+=0D
+void tcg_gen_vec_rotl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)=0D
+{=0D
+    uint64_t mask =3D dup_const(MO_8, 0xff << c);=0D
+=0D
+    tcg_gen_shli_i64(d, a, c);=0D
+    tcg_gen_shri_i64(a, a, 8 - c);=0D
+    tcg_gen_andi_i64(d, d, mask);=0D
+    tcg_gen_andi_i64(a, a, ~mask);=0D
+    tcg_gen_or_i64(d, d, a);=0D
+}=0D
+=0D
+void tcg_gen_vec_rotl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)=0D
+{=0D
+    uint64_t mask =3D dup_const(MO_16, 0xffff << c);=0D
+=0D
+    tcg_gen_shli_i64(d, a, c);=0D
+    tcg_gen_shri_i64(a, a, 16 - c);=0D
+    tcg_gen_andi_i64(d, d, mask);=0D
+    tcg_gen_andi_i64(a, a, ~mask);=0D
+    tcg_gen_or_i64(d, d, a);=0D
+}=0D
+=0D
+void tcg_gen_gvec_rotli(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                        int64_t shift, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_rotli_vec, 0 };=0D
+    static const GVecGen2i g[4] =3D {=0D
+        { .fni8 =3D tcg_gen_vec_rotl8i_i64,=0D
+          .fniv =3D tcg_gen_rotli_vec,=0D
+          .fno =3D gen_helper_gvec_rotl8i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fni8 =3D tcg_gen_vec_rotl16i_i64,=0D
+          .fniv =3D tcg_gen_rotli_vec,=0D
+          .fno =3D gen_helper_gvec_rotl16i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_rotli_i32,=0D
+          .fniv =3D tcg_gen_rotli_vec,=0D
+          .fno =3D gen_helper_gvec_rotl32i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_rotli_i64,=0D
+          .fniv =3D tcg_gen_rotli_vec,=0D
+          .fno =3D gen_helper_gvec_rotl64i,=0D
+          .opt_opc =3D vecop_list,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));=0D
+    if (shift =3D=3D 0) {=0D
+        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);=0D
+    } else {=0D
+        tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, shift, &g[vece]);=0D
+    }=0D
+}=0D
+=0D
+void tcg_gen_gvec_rotri(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                        int64_t shift, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));=0D
+    tcg_gen_gvec_rotli(vece, dofs, aofs, -shift & ((8 << vece) - 1),=0D
+                       oprsz, maxsz);=0D
+}=0D
+=0D
+/*=0D
+ * Specialized generation vector shifts by a non-constant scalar.=0D
+ */=0D
+=0D
+typedef struct {=0D
+    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32);=0D
+    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64);=0D
+    void (*fniv_s)(unsigned, TCGv_vec, TCGv_vec, TCGv_i32);=0D
+    void (*fniv_v)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);=0D
+    gen_helper_gvec_2 *fno[4];=0D
+    TCGOpcode s_list[2];=0D
+    TCGOpcode v_list[2];=0D
+} GVecGen2sh;=0D
+=0D
+static void expand_2sh_vec(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                           uint32_t oprsz, uint32_t tysz, TCGType type,=0D
+                           TCGv_i32 shift,=0D
+                           void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_=
i32))=0D
+{=0D
+    TCGv_vec t0 =3D tcg_temp_new_vec(type);=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D tysz) {=0D
+        tcg_gen_ld_vec(t0, cpu_env, aofs + i);=0D
+        fni(vece, t0, t0, shift);=0D
+        tcg_gen_st_vec(t0, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_vec(t0);=0D
+}=0D
+=0D
+static void=0D
+do_gvec_shifts(unsigned vece, uint32_t dofs, uint32_t aofs, TCGv_i32 shift=
,=0D
+               uint32_t oprsz, uint32_t maxsz, const GVecGen2sh *g)=0D
+{=0D
+    TCGType type;=0D
+    uint32_t some;=0D
+=0D
+    check_size_align(oprsz, maxsz, dofs | aofs);=0D
+    check_overlap_2(dofs, aofs, maxsz);=0D
+=0D
+    /* If the backend has a scalar expansion, great.  */=0D
+    type =3D choose_vector_type(g->s_list, vece, oprsz, vece =3D=3D MO_64)=
;=0D
+    if (type) {=0D
+        const TCGOpcode *hold_list =3D tcg_swap_vecop_list(NULL);=0D
+        switch (type) {=0D
+        case TCG_TYPE_V256:=0D
+            some =3D QEMU_ALIGN_DOWN(oprsz, 32);=0D
+            expand_2sh_vec(vece, dofs, aofs, some, 32,=0D
+                           TCG_TYPE_V256, shift, g->fniv_s);=0D
+            if (some =3D=3D oprsz) {=0D
+                break;=0D
+            }=0D
+            dofs +=3D some;=0D
+            aofs +=3D some;=0D
+            oprsz -=3D some;=0D
+            maxsz -=3D some;=0D
+            /* fallthru */=0D
+        case TCG_TYPE_V128:=0D
+            expand_2sh_vec(vece, dofs, aofs, oprsz, 16,=0D
+                           TCG_TYPE_V128, shift, g->fniv_s);=0D
+            break;=0D
+        case TCG_TYPE_V64:=0D
+            expand_2sh_vec(vece, dofs, aofs, oprsz, 8,=0D
+                           TCG_TYPE_V64, shift, g->fniv_s);=0D
+            break;=0D
+        default:=0D
+            g_assert_not_reached();=0D
+        }=0D
+        tcg_swap_vecop_list(hold_list);=0D
+        goto clear_tail;=0D
+    }=0D
+=0D
+    /* If the backend supports variable vector shifts, also cool.  */=0D
+    type =3D choose_vector_type(g->v_list, vece, oprsz, vece =3D=3D MO_64)=
;=0D
+    if (type) {=0D
+        const TCGOpcode *hold_list =3D tcg_swap_vecop_list(NULL);=0D
+        TCGv_vec v_shift =3D tcg_temp_new_vec(type);=0D
+=0D
+        if (vece =3D=3D MO_64) {=0D
+            TCGv_i64 sh64 =3D tcg_temp_new_i64();=0D
+            tcg_gen_extu_i32_i64(sh64, shift);=0D
+            tcg_gen_dup_i64_vec(MO_64, v_shift, sh64);=0D
+            tcg_temp_free_i64(sh64);=0D
+        } else {=0D
+            tcg_gen_dup_i32_vec(vece, v_shift, shift);=0D
+        }=0D
+=0D
+        switch (type) {=0D
+        case TCG_TYPE_V256:=0D
+            some =3D QEMU_ALIGN_DOWN(oprsz, 32);=0D
+            expand_2s_vec(vece, dofs, aofs, some, 32, TCG_TYPE_V256,=0D
+                          v_shift, false, g->fniv_v);=0D
+            if (some =3D=3D oprsz) {=0D
+                break;=0D
+            }=0D
+            dofs +=3D some;=0D
+            aofs +=3D some;=0D
+            oprsz -=3D some;=0D
+            maxsz -=3D some;=0D
+            /* fallthru */=0D
+        case TCG_TYPE_V128:=0D
+            expand_2s_vec(vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,=0D
+                          v_shift, false, g->fniv_v);=0D
+            break;=0D
+        case TCG_TYPE_V64:=0D
+            expand_2s_vec(vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,=0D
+                          v_shift, false, g->fniv_v);=0D
+            break;=0D
+        default:=0D
+            g_assert_not_reached();=0D
+        }=0D
+        tcg_temp_free_vec(v_shift);=0D
+        tcg_swap_vecop_list(hold_list);=0D
+        goto clear_tail;=0D
+    }=0D
+=0D
+    /* Otherwise fall back to integral... */=0D
+    if (vece =3D=3D MO_32 && check_size_impl(oprsz, 4)) {=0D
+        expand_2s_i32(dofs, aofs, oprsz, shift, false, g->fni4);=0D
+    } else if (vece =3D=3D MO_64 && check_size_impl(oprsz, 8)) {=0D
+        TCGv_i64 sh64 =3D tcg_temp_new_i64();=0D
+        tcg_gen_extu_i32_i64(sh64, shift);=0D
+        expand_2s_i64(dofs, aofs, oprsz, sh64, false, g->fni8);=0D
+        tcg_temp_free_i64(sh64);=0D
+    } else {=0D
+        TCGv_ptr a0 =3D tcg_temp_new_ptr();=0D
+        TCGv_ptr a1 =3D tcg_temp_new_ptr();=0D
+        TCGv_i32 desc =3D tcg_temp_new_i32();=0D
+=0D
+        tcg_gen_shli_i32(desc, shift, SIMD_DATA_SHIFT);=0D
+        tcg_gen_ori_i32(desc, desc, simd_desc(oprsz, maxsz, 0));=0D
+        tcg_gen_addi_ptr(a0, cpu_env, dofs);=0D
+        tcg_gen_addi_ptr(a1, cpu_env, aofs);=0D
+=0D
+        g->fno[vece](a0, a1, desc);=0D
+=0D
+        tcg_temp_free_ptr(a0);=0D
+        tcg_temp_free_ptr(a1);=0D
+        tcg_temp_free_i32(desc);=0D
+        return;=0D
+    }=0D
+=0D
+ clear_tail:=0D
+    if (oprsz < maxsz) {=0D
+        expand_clr(dofs + oprsz, maxsz - oprsz);=0D
+    }=0D
+}=0D
+=0D
+void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen2sh g =3D {=0D
+        .fni4 =3D tcg_gen_shl_i32,=0D
+        .fni8 =3D tcg_gen_shl_i64,=0D
+        .fniv_s =3D tcg_gen_shls_vec,=0D
+        .fniv_v =3D tcg_gen_shlv_vec,=0D
+        .fno =3D {=0D
+            gen_helper_gvec_shl8i,=0D
+            gen_helper_gvec_shl16i,=0D
+            gen_helper_gvec_shl32i,=0D
+            gen_helper_gvec_shl64i,=0D
+        },=0D
+        .s_list =3D { INDEX_op_shls_vec, 0 },=0D
+        .v_list =3D { INDEX_op_shlv_vec, 0 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);=0D
+}=0D
+=0D
+void tcg_gen_gvec_shrs(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen2sh g =3D {=0D
+        .fni4 =3D tcg_gen_shr_i32,=0D
+        .fni8 =3D tcg_gen_shr_i64,=0D
+        .fniv_s =3D tcg_gen_shrs_vec,=0D
+        .fniv_v =3D tcg_gen_shrv_vec,=0D
+        .fno =3D {=0D
+            gen_helper_gvec_shr8i,=0D
+            gen_helper_gvec_shr16i,=0D
+            gen_helper_gvec_shr32i,=0D
+            gen_helper_gvec_shr64i,=0D
+        },=0D
+        .s_list =3D { INDEX_op_shrs_vec, 0 },=0D
+        .v_list =3D { INDEX_op_shrv_vec, 0 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);=0D
+}=0D
+=0D
+void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen2sh g =3D {=0D
+        .fni4 =3D tcg_gen_sar_i32,=0D
+        .fni8 =3D tcg_gen_sar_i64,=0D
+        .fniv_s =3D tcg_gen_sars_vec,=0D
+        .fniv_v =3D tcg_gen_sarv_vec,=0D
+        .fno =3D {=0D
+            gen_helper_gvec_sar8i,=0D
+            gen_helper_gvec_sar16i,=0D
+            gen_helper_gvec_sar32i,=0D
+            gen_helper_gvec_sar64i,=0D
+        },=0D
+        .s_list =3D { INDEX_op_sars_vec, 0 },=0D
+        .v_list =3D { INDEX_op_sarv_vec, 0 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);=0D
+}=0D
+=0D
+void tcg_gen_gvec_rotls(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen2sh g =3D {=0D
+        .fni4 =3D tcg_gen_rotl_i32,=0D
+        .fni8 =3D tcg_gen_rotl_i64,=0D
+        .fniv_s =3D tcg_gen_rotls_vec,=0D
+        .fniv_v =3D tcg_gen_rotlv_vec,=0D
+        .fno =3D {=0D
+            gen_helper_gvec_rotl8i,=0D
+            gen_helper_gvec_rotl16i,=0D
+            gen_helper_gvec_rotl32i,=0D
+            gen_helper_gvec_rotl64i,=0D
+        },=0D
+        .s_list =3D { INDEX_op_rotls_vec, 0 },=0D
+        .v_list =3D { INDEX_op_rotlv_vec, 0 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);=0D
+}=0D
+=0D
+/*=0D
+ * Expand D =3D A << (B % element bits)=0D
+ *=0D
+ * Unlike scalar shifts, where it is easy for the target front end=0D
+ * to include the modulo as part of the expansion.  If the target=0D
+ * naturally includes the modulo as part of the operation, great!=0D
+ * If the target has some other behaviour from out-of-range shifts,=0D
+ * then it could not use this function anyway, and would need to=0D
+ * do it's own expansion with custom functions.=0D
+ */=0D
+static void tcg_gen_shlv_mod_vec(unsigned vece, TCGv_vec d,=0D
+                                 TCGv_vec a, TCGv_vec b)=0D
+{=0D
+    TCGv_vec t =3D tcg_temp_new_vec_matching(d);=0D
+=0D
+    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);=0D
+    tcg_gen_and_vec(vece, t, t, b);=0D
+    tcg_gen_shlv_vec(vece, d, a, t);=0D
+    tcg_temp_free_vec(t);=0D
+}=0D
+=0D
+static void tcg_gen_shl_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)=0D
+{=0D
+    TCGv_i32 t =3D tcg_temp_new_i32();=0D
+=0D
+    tcg_gen_andi_i32(t, b, 31);=0D
+    tcg_gen_shl_i32(d, a, t);=0D
+    tcg_temp_free_i32(t);=0D
+}=0D
+=0D
+static void tcg_gen_shl_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 t =3D tcg_temp_new_i64();=0D
+=0D
+    tcg_gen_andi_i64(t, b, 63);=0D
+    tcg_gen_shl_i64(d, a, t);=0D
+    tcg_temp_free_i64(t);=0D
+}=0D
+=0D
+void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_shlv_vec, 0 };=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fniv =3D tcg_gen_shlv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_shl8v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_shlv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_shl16v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_shl_mod_i32,=0D
+          .fniv =3D tcg_gen_shlv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_shl32v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_shl_mod_i64,=0D
+          .fniv =3D tcg_gen_shlv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_shl64v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+/*=0D
+ * Similarly for logical right shifts.=0D
+ */=0D
+=0D
+static void tcg_gen_shrv_mod_vec(unsigned vece, TCGv_vec d,=0D
+                                 TCGv_vec a, TCGv_vec b)=0D
+{=0D
+    TCGv_vec t =3D tcg_temp_new_vec_matching(d);=0D
+=0D
+    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);=0D
+    tcg_gen_and_vec(vece, t, t, b);=0D
+    tcg_gen_shrv_vec(vece, d, a, t);=0D
+    tcg_temp_free_vec(t);=0D
+}=0D
+=0D
+static void tcg_gen_shr_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)=0D
+{=0D
+    TCGv_i32 t =3D tcg_temp_new_i32();=0D
+=0D
+    tcg_gen_andi_i32(t, b, 31);=0D
+    tcg_gen_shr_i32(d, a, t);=0D
+    tcg_temp_free_i32(t);=0D
+}=0D
+=0D
+static void tcg_gen_shr_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 t =3D tcg_temp_new_i64();=0D
+=0D
+    tcg_gen_andi_i64(t, b, 63);=0D
+    tcg_gen_shr_i64(d, a, t);=0D
+    tcg_temp_free_i64(t);=0D
+}=0D
+=0D
+void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_shrv_vec, 0 };=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fniv =3D tcg_gen_shrv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_shr8v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_shrv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_shr16v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_shr_mod_i32,=0D
+          .fniv =3D tcg_gen_shrv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_shr32v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_shr_mod_i64,=0D
+          .fniv =3D tcg_gen_shrv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_shr64v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+/*=0D
+ * Similarly for arithmetic right shifts.=0D
+ */=0D
+=0D
+static void tcg_gen_sarv_mod_vec(unsigned vece, TCGv_vec d,=0D
+                                 TCGv_vec a, TCGv_vec b)=0D
+{=0D
+    TCGv_vec t =3D tcg_temp_new_vec_matching(d);=0D
+=0D
+    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);=0D
+    tcg_gen_and_vec(vece, t, t, b);=0D
+    tcg_gen_sarv_vec(vece, d, a, t);=0D
+    tcg_temp_free_vec(t);=0D
+}=0D
+=0D
+static void tcg_gen_sar_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)=0D
+{=0D
+    TCGv_i32 t =3D tcg_temp_new_i32();=0D
+=0D
+    tcg_gen_andi_i32(t, b, 31);=0D
+    tcg_gen_sar_i32(d, a, t);=0D
+    tcg_temp_free_i32(t);=0D
+}=0D
+=0D
+static void tcg_gen_sar_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 t =3D tcg_temp_new_i64();=0D
+=0D
+    tcg_gen_andi_i64(t, b, 63);=0D
+    tcg_gen_sar_i64(d, a, t);=0D
+    tcg_temp_free_i64(t);=0D
+}=0D
+=0D
+void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_sarv_vec, 0 };=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fniv =3D tcg_gen_sarv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_sar8v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_sarv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_sar16v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_sar_mod_i32,=0D
+          .fniv =3D tcg_gen_sarv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_sar32v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_sar_mod_i64,=0D
+          .fniv =3D tcg_gen_sarv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_sar64v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+/*=0D
+ * Similarly for rotates.=0D
+ */=0D
+=0D
+static void tcg_gen_rotlv_mod_vec(unsigned vece, TCGv_vec d,=0D
+                                  TCGv_vec a, TCGv_vec b)=0D
+{=0D
+    TCGv_vec t =3D tcg_temp_new_vec_matching(d);=0D
+=0D
+    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);=0D
+    tcg_gen_and_vec(vece, t, t, b);=0D
+    tcg_gen_rotlv_vec(vece, d, a, t);=0D
+    tcg_temp_free_vec(t);=0D
+}=0D
+=0D
+static void tcg_gen_rotl_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)=0D
+{=0D
+    TCGv_i32 t =3D tcg_temp_new_i32();=0D
+=0D
+    tcg_gen_andi_i32(t, b, 31);=0D
+    tcg_gen_rotl_i32(d, a, t);=0D
+    tcg_temp_free_i32(t);=0D
+}=0D
+=0D
+static void tcg_gen_rotl_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 t =3D tcg_temp_new_i64();=0D
+=0D
+    tcg_gen_andi_i64(t, b, 63);=0D
+    tcg_gen_rotl_i64(d, a, t);=0D
+    tcg_temp_free_i64(t);=0D
+}=0D
+=0D
+void tcg_gen_gvec_rotlv(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_rotlv_vec, 0 };=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fniv =3D tcg_gen_rotlv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_rotl8v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_rotlv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_rotl16v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_rotl_mod_i32,=0D
+          .fniv =3D tcg_gen_rotlv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_rotl32v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_rotl_mod_i64,=0D
+          .fniv =3D tcg_gen_rotlv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_rotl64v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+static void tcg_gen_rotrv_mod_vec(unsigned vece, TCGv_vec d,=0D
+                                  TCGv_vec a, TCGv_vec b)=0D
+{=0D
+    TCGv_vec t =3D tcg_temp_new_vec_matching(d);=0D
+=0D
+    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);=0D
+    tcg_gen_and_vec(vece, t, t, b);=0D
+    tcg_gen_rotrv_vec(vece, d, a, t);=0D
+    tcg_temp_free_vec(t);=0D
+}=0D
+=0D
+static void tcg_gen_rotr_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)=0D
+{=0D
+    TCGv_i32 t =3D tcg_temp_new_i32();=0D
+=0D
+    tcg_gen_andi_i32(t, b, 31);=0D
+    tcg_gen_rotr_i32(d, a, t);=0D
+    tcg_temp_free_i32(t);=0D
+}=0D
+=0D
+static void tcg_gen_rotr_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)=0D
+{=0D
+    TCGv_i64 t =3D tcg_temp_new_i64();=0D
+=0D
+    tcg_gen_andi_i64(t, b, 63);=0D
+    tcg_gen_rotr_i64(d, a, t);=0D
+    tcg_temp_free_i64(t);=0D
+}=0D
+=0D
+void tcg_gen_gvec_rotrv(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode vecop_list[] =3D { INDEX_op_rotrv_vec, 0 };=0D
+    static const GVecGen3 g[4] =3D {=0D
+        { .fniv =3D tcg_gen_rotrv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_rotr8v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_8 },=0D
+        { .fniv =3D tcg_gen_rotrv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_rotr16v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_16 },=0D
+        { .fni4 =3D tcg_gen_rotr_mod_i32,=0D
+          .fniv =3D tcg_gen_rotrv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_rotr32v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .vece =3D MO_32 },=0D
+        { .fni8 =3D tcg_gen_rotr_mod_i64,=0D
+          .fniv =3D tcg_gen_rotrv_mod_vec,=0D
+          .fno =3D gen_helper_gvec_rotr64v,=0D
+          .opt_opc =3D vecop_list,=0D
+          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,=0D
+          .vece =3D MO_64 },=0D
+    };=0D
+=0D
+    tcg_debug_assert(vece <=3D MO_64);=0D
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);=0D
+}=0D
+=0D
+/* Expand OPSZ bytes worth of three-operand operations using i32 elements.=
  */=0D
+static void expand_cmp_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,=0D
+                           uint32_t oprsz, TCGCond cond)=0D
+{=0D
+    TCGv_i32 t0 =3D tcg_temp_new_i32();=0D
+    TCGv_i32 t1 =3D tcg_temp_new_i32();=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D 4) {=0D
+        tcg_gen_ld_i32(t0, cpu_env, aofs + i);=0D
+        tcg_gen_ld_i32(t1, cpu_env, bofs + i);=0D
+        tcg_gen_setcond_i32(cond, t0, t0, t1);=0D
+        tcg_gen_neg_i32(t0, t0);=0D
+        tcg_gen_st_i32(t0, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_i32(t1);=0D
+    tcg_temp_free_i32(t0);=0D
+}=0D
+=0D
+static void expand_cmp_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,=0D
+                           uint32_t oprsz, TCGCond cond)=0D
+{=0D
+    TCGv_i64 t0 =3D tcg_temp_new_i64();=0D
+    TCGv_i64 t1 =3D tcg_temp_new_i64();=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D 8) {=0D
+        tcg_gen_ld_i64(t0, cpu_env, aofs + i);=0D
+        tcg_gen_ld_i64(t1, cpu_env, bofs + i);=0D
+        tcg_gen_setcond_i64(cond, t0, t0, t1);=0D
+        tcg_gen_neg_i64(t0, t0);=0D
+        tcg_gen_st_i64(t0, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_i64(t1);=0D
+    tcg_temp_free_i64(t0);=0D
+}=0D
+=0D
+static void expand_cmp_vec(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                           uint32_t bofs, uint32_t oprsz, uint32_t tysz,=0D
+                           TCGType type, TCGCond cond)=0D
+{=0D
+    TCGv_vec t0 =3D tcg_temp_new_vec(type);=0D
+    TCGv_vec t1 =3D tcg_temp_new_vec(type);=0D
+    uint32_t i;=0D
+=0D
+    for (i =3D 0; i < oprsz; i +=3D tysz) {=0D
+        tcg_gen_ld_vec(t0, cpu_env, aofs + i);=0D
+        tcg_gen_ld_vec(t1, cpu_env, bofs + i);=0D
+        tcg_gen_cmp_vec(cond, vece, t0, t0, t1);=0D
+        tcg_gen_st_vec(t0, cpu_env, dofs + i);=0D
+    }=0D
+    tcg_temp_free_vec(t1);=0D
+    tcg_temp_free_vec(t0);=0D
+}=0D
+=0D
+void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,=0D
+                      uint32_t aofs, uint32_t bofs,=0D
+                      uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const TCGOpcode cmp_list[] =3D { INDEX_op_cmp_vec, 0 };=0D
+    static gen_helper_gvec_3 * const eq_fn[4] =3D {=0D
+        gen_helper_gvec_eq8, gen_helper_gvec_eq16,=0D
+        gen_helper_gvec_eq32, gen_helper_gvec_eq64=0D
+    };=0D
+    static gen_helper_gvec_3 * const ne_fn[4] =3D {=0D
+        gen_helper_gvec_ne8, gen_helper_gvec_ne16,=0D
+        gen_helper_gvec_ne32, gen_helper_gvec_ne64=0D
+    };=0D
+    static gen_helper_gvec_3 * const lt_fn[4] =3D {=0D
+        gen_helper_gvec_lt8, gen_helper_gvec_lt16,=0D
+        gen_helper_gvec_lt32, gen_helper_gvec_lt64=0D
+    };=0D
+    static gen_helper_gvec_3 * const le_fn[4] =3D {=0D
+        gen_helper_gvec_le8, gen_helper_gvec_le16,=0D
+        gen_helper_gvec_le32, gen_helper_gvec_le64=0D
+    };=0D
+    static gen_helper_gvec_3 * const ltu_fn[4] =3D {=0D
+        gen_helper_gvec_ltu8, gen_helper_gvec_ltu16,=0D
+        gen_helper_gvec_ltu32, gen_helper_gvec_ltu64=0D
+    };=0D
+    static gen_helper_gvec_3 * const leu_fn[4] =3D {=0D
+        gen_helper_gvec_leu8, gen_helper_gvec_leu16,=0D
+        gen_helper_gvec_leu32, gen_helper_gvec_leu64=0D
+    };=0D
+    static gen_helper_gvec_3 * const * const fns[16] =3D {=0D
+        [TCG_COND_EQ] =3D eq_fn,=0D
+        [TCG_COND_NE] =3D ne_fn,=0D
+        [TCG_COND_LT] =3D lt_fn,=0D
+        [TCG_COND_LE] =3D le_fn,=0D
+        [TCG_COND_LTU] =3D ltu_fn,=0D
+        [TCG_COND_LEU] =3D leu_fn,=0D
+    };=0D
+=0D
+    const TCGOpcode *hold_list;=0D
+    TCGType type;=0D
+    uint32_t some;=0D
+=0D
+    check_size_align(oprsz, maxsz, dofs | aofs | bofs);=0D
+    check_overlap_3(dofs, aofs, bofs, maxsz);=0D
+=0D
+    if (cond =3D=3D TCG_COND_NEVER || cond =3D=3D TCG_COND_ALWAYS) {=0D
+        do_dup(MO_8, dofs, oprsz, maxsz,=0D
+               NULL, NULL, -(cond =3D=3D TCG_COND_ALWAYS));=0D
+        return;=0D
+    }=0D
+=0D
+    /*=0D
+     * Implement inline with a vector type, if possible.=0D
+     * Prefer integer when 64-bit host and 64-bit comparison.=0D
+     */=0D
+    hold_list =3D tcg_swap_vecop_list(cmp_list);=0D
+    type =3D choose_vector_type(cmp_list, vece, oprsz,=0D
+                              TCG_TARGET_REG_BITS =3D=3D 64 && vece =3D=3D=
 MO_64);=0D
+    switch (type) {=0D
+    case TCG_TYPE_V256:=0D
+        /* Recall that ARM SVE allows vector sizes that are not a=0D
+         * power of 2, but always a multiple of 16.  The intent is=0D
+         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.=0D
+         */=0D
+        some =3D QEMU_ALIGN_DOWN(oprsz, 32);=0D
+        expand_cmp_vec(vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256, co=
nd);=0D
+        if (some =3D=3D oprsz) {=0D
+            break;=0D
+        }=0D
+        dofs +=3D some;=0D
+        aofs +=3D some;=0D
+        bofs +=3D some;=0D
+        oprsz -=3D some;=0D
+        maxsz -=3D some;=0D
+        /* fallthru */=0D
+    case TCG_TYPE_V128:=0D
+        expand_cmp_vec(vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128, c=
ond);=0D
+        break;=0D
+    case TCG_TYPE_V64:=0D
+        expand_cmp_vec(vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64, con=
d);=0D
+        break;=0D
+=0D
+    case 0:=0D
+        if (vece =3D=3D MO_64 && check_size_impl(oprsz, 8)) {=0D
+            expand_cmp_i64(dofs, aofs, bofs, oprsz, cond);=0D
+        } else if (vece =3D=3D MO_32 && check_size_impl(oprsz, 4)) {=0D
+            expand_cmp_i32(dofs, aofs, bofs, oprsz, cond);=0D
+        } else {=0D
+            gen_helper_gvec_3 * const *fn =3D fns[cond];=0D
+=0D
+            if (fn =3D=3D NULL) {=0D
+                uint32_t tmp;=0D
+                tmp =3D aofs, aofs =3D bofs, bofs =3D tmp;=0D
+                cond =3D tcg_swap_cond(cond);=0D
+                fn =3D fns[cond];=0D
+                assert(fn !=3D NULL);=0D
+            }=0D
+            tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, 0, fn[vece]=
);=0D
+            oprsz =3D maxsz;=0D
+        }=0D
+        break;=0D
+=0D
+    default:=0D
+        g_assert_not_reached();=0D
+    }=0D
+    tcg_swap_vecop_list(hold_list);=0D
+=0D
+    if (oprsz < maxsz) {=0D
+        expand_clr(dofs + oprsz, maxsz - oprsz);=0D
+    }=0D
+}=0D
+=0D
+static void tcg_gen_bitsel_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i6=
4 c)=0D
+{=0D
+    TCGv_i64 t =3D tcg_temp_new_i64();=0D
+=0D
+    tcg_gen_and_i64(t, b, a);=0D
+    tcg_gen_andc_i64(d, c, a);=0D
+    tcg_gen_or_i64(d, d, t);=0D
+    tcg_temp_free_i64(t);=0D
+}=0D
+=0D
+void tcg_gen_gvec_bitsel(unsigned vece, uint32_t dofs, uint32_t aofs,=0D
+                         uint32_t bofs, uint32_t cofs,=0D
+                         uint32_t oprsz, uint32_t maxsz)=0D
+{=0D
+    static const GVecGen4 g =3D {=0D
+        .fni8 =3D tcg_gen_bitsel_i64,=0D
+        .fniv =3D tcg_gen_bitsel_vec,=0D
+        .fno =3D gen_helper_gvec_bitsel,=0D
+    };=0D
+=0D
+    tcg_gen_gvec_4(dofs, aofs, bofs, cofs, oprsz, maxsz, &g);=0D
+}=0D
--=20
2.28.0.windows.1


