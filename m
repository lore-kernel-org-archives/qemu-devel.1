Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A15EC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 03:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4E420732
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 03:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4E420732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEmAQ-0004IU-Gh
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 23:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEm9I-0002pm-BZ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 23:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEm9F-0002Qv-Mi
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 23:47:11 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jEm9D-00025u-MX; Wed, 18 Mar 2020 23:47:09 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436849|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.120115-0.00154986-0.878335;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03278; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H1nPPHp_1584589615; 
Received: from 172.16.31.150(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H1nPPHp_1584589615)
 by smtp.aliyun-inc.com(10.147.42.22); Thu, 19 Mar 2020 11:46:55 +0800
Subject: Re: [PATCH v6 25/61] target/riscv: vector single-width averaging add
 and subtract
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-26-zhiwei_liu@c-sky.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <0cdf21fd-b1f1-36bf-f156-5a673199fa1f@c-sky.com>
Date: Thu, 19 Mar 2020 11:46:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317150653.9008-26-zhiwei_liu@c-sky.com>
Content-Type: multipart/alternative;
 boundary="------------AA80C2260A9958F4DBBA9BAA"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------AA80C2260A9958F4DBBA9BAA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/3/17 23:06, LIU Zhiwei wrote:

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
  target/riscv/helper.h                   |  17 ++++
  target/riscv/insn32.decode              |   5 ++
  target/riscv/insn_trans/trans_rvv.inc.c |   7 ++
  target/riscv/vector_helper.c            | 100 ++++++++++++++++++++++++
  4 files changed, 129 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index fd1c184852..311ce1322c 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -715,3 +715,20 @@ DEF_HELPER_6(vssub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
  DEF_HELPER_6(vssub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
  DEF_HELPER_6(vssub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
  DEF_HELPER_6(vssub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vaadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vaadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vaadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vaadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c9a4050adc..e617d7bd60 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -417,6 +417,11 @@ vssubu_vv       100010 . ..... ..... 000 ..... 1010111 @r_vm
  vssubu_vx       100010 . ..... ..... 100 ..... 1010111 @r_vm
  vssub_vv        100011 . ..... ..... 000 ..... 1010111 @r_vm
  vssub_vx        100011 . ..... ..... 100 ..... 1010111 @r_vm
+vaadd_vv        100100 . ..... ..... 000 ..... 1010111 @r_vm
+vaadd_vx        100100 . ..... ..... 100 ..... 1010111 @r_vm
+vaadd_vi        100100 . ..... ..... 011 ..... 1010111 @r_vm
+vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
+vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
  
  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index dd1a508a51..ba2e7d56f4 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1636,3 +1636,10 @@ GEN_OPIVX_TRANS(vssubu_vx,  opivx_check)
  GEN_OPIVX_TRANS(vssub_vx,  opivx_check)
  GEN_OPIVI_TRANS(vsaddu_vi, 1, vsaddu_vx, opivx_check)
  GEN_OPIVI_TRANS(vsadd_vi, 0, vsadd_vx, opivx_check)
+
+/* Vector Single-Width Averaging Add and Subtract */
+GEN_OPIVV_TRANS(vaadd_vv, opivv_check)
+GEN_OPIVV_TRANS(vasub_vv, opivv_check)
+GEN_OPIVX_TRANS(vaadd_vx,  opivx_check)
+GEN_OPIVX_TRANS(vasub_vx,  opivx_check)
+GEN_OPIVI_TRANS(vaadd_vi, 0, vaadd_vx, opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index b17cac7fd4..984a8e260f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2488,3 +2488,103 @@ GEN_VEXT_VX_RM(vssub_vx_b, 1, 1, clearb)
  GEN_VEXT_VX_RM(vssub_vx_h, 2, 2, clearh)
  GEN_VEXT_VX_RM(vssub_vx_w, 4, 4, clearl)
  GEN_VEXT_VX_RM(vssub_vx_d, 8, 8, clearq)
+
+/* Vector Single-Width Averaging Add and Subtract */
+static inline uint8_t get_round(int vxrm, uint64_t v, uint8_t shift)
+{
+    uint8_t d = extract64(v, shift, 1);
+    uint8_t d1;
+    uint64_t D1, D2;
+
+    if (shift == 0 || shift > 64) {
+        return 0;
+    }
+
+    d1 = extract64(v, shift - 1, 1);
+    D1 = extract64(v, 0, shift);
+    if (vxrm == 0) { /* round-to-nearest-up (add +0.5 LSB) */
+        return d1;
+    } else if (vxrm == 1) { /* round-to-nearest-even */
+        if (shift > 1) {
+            D2 = extract64(v, 0, shift - 1);
+            return d1 & ((D2 != 0) | d);
+        } else {
+            return d1 & d;
+        }
+    } else if (vxrm == 3) { /* round-to-odd (OR bits into LSB, aka "jam") */
+        return !d & (D1 != 0);
+    }
+    return 0; /* round-down (truncate) */
+}
+
+static inline int32_t aadd32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+{
+    int64_t res = (int64_t)a + b;
+    uint8_t round = get_round(vxrm, res, 1);
+
+    return (res >> 1) + round;
+}
+
+static inline int64_t aadd64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
+{
+    int64_t res = a + b;
+    uint8_t round = get_round(vxrm, res, 1);
+    int64_t over = (res ^ a) & (res ^ b) & INT64_MIN;
+
+    /* With signed overflow, bit 64 is inverse of bit 63. */
+    return ((res >> 1) ^ over) + round;
+}
+
+RVVCALL(OPIVV2_RM, vaadd_vv_b, OP_SSS_B, H1, H1, H1, aadd32)
+RVVCALL(OPIVV2_RM, vaadd_vv_h, OP_SSS_H, H2, H2, H2, aadd32)
+RVVCALL(OPIVV2_RM, vaadd_vv_w, OP_SSS_W, H4, H4, H4, aadd32)
+RVVCALL(OPIVV2_RM, vaadd_vv_d, OP_SSS_D, H8, H8, H8, aadd64)
+GEN_VEXT_VV_RM(vaadd_vv_b, 1, 1, clearb)
+GEN_VEXT_VV_RM(vaadd_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_RM(vaadd_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_RM(vaadd_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2_RM, vaadd_vx_b, OP_SSS_B, H1, H1, aadd32)
+RVVCALL(OPIVX2_RM, vaadd_vx_h, OP_SSS_H, H2, H2, aadd32)
+RVVCALL(OPIVX2_RM, vaadd_vx_w, OP_SSS_W, H4, H4, aadd32)
+RVVCALL(OPIVX2_RM, vaadd_vx_d, OP_SSS_D, H8, H8, aadd64)
+GEN_VEXT_VX_RM(vaadd_vx_b, 1, 1, clearb)
+GEN_VEXT_VX_RM(vaadd_vx_h, 2, 2, clearh)
+GEN_VEXT_VX_RM(vaadd_vx_w, 4, 4, clearl)
+GEN_VEXT_VX_RM(vaadd_vx_d, 8, 8, clearq)
+
+static inline int32_t asub32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+{
+    int64_t res = (int64_t)a - b;
+    uint8_t round = get_round(vxrm, res, 1);
+
+    return (res >> 1) + round;
+}
+

I find a corner case here.  As the spec said in Section 13.2

   "There can be no overflow in the result".

If the a is 0x7fffffff,  b is 0x80000000, and the round mode is round to 
up(rnu),
then the result is (0x7fffffff - 0x80000000 + 1) >> 1, equals 
0x80000000, according the v0.7.1

    # Averaging subtract

    # result = (src1 - src2 + round) >> 1;

The result is also overflow, according to v0.8. It will be calculated 
that like here,

    roundoff_signed(vs2[i] - vs1[i], 1)

    roundoff_signed(v, d) = (signed(v) >> d) + r

Should I check do a saturation here?

Zhiwei



> +static inline int64_t asub64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
> +{
> +    int64_t res = (int64_t)a - b;
> +    uint8_t round = get_round(vxrm, res, 1);
> +    int64_t over = (res ^ a) & (a ^ b) & INT64_MIN;
> +
> +    /* With signed overflow, bit 64 is inverse of bit 63. */
> +    return ((res >> 1) ^ over) + round;
> +}
> +
> +RVVCALL(OPIVV2_RM, vasub_vv_b, OP_SSS_B, H1, H1, H1, asub32)
> +RVVCALL(OPIVV2_RM, vasub_vv_h, OP_SSS_H, H2, H2, H2, asub32)
> +RVVCALL(OPIVV2_RM, vasub_vv_w, OP_SSS_W, H4, H4, H4, asub32)
> +RVVCALL(OPIVV2_RM, vasub_vv_d, OP_SSS_D, H8, H8, H8, asub64)
> +GEN_VEXT_VV_RM(vasub_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV_RM(vasub_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_RM(vasub_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_RM(vasub_vv_d, 8, 8, clearq)
> +
> +RVVCALL(OPIVX2_RM, vasub_vx_b, OP_SSS_B, H1, H1, asub32)
> +RVVCALL(OPIVX2_RM, vasub_vx_h, OP_SSS_H, H2, H2, asub32)
> +RVVCALL(OPIVX2_RM, vasub_vx_w, OP_SSS_W, H4, H4, asub32)
> +RVVCALL(OPIVX2_RM, vasub_vx_d, OP_SSS_D, H8, H8, asub64)
> +GEN_VEXT_VX_RM(vasub_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX_RM(vasub_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX_RM(vasub_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX_RM(vasub_vx_d, 8, 8, clearq)


--------------AA80C2260A9958F4DBBA9BAA
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/3/17 23:06, LIU Zhiwei wrote:<br>
    </div>
    <pre class="moz-quote-pre" wrap="">Signed-off-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@c-sky.com">&lt;zhiwei_liu@c-sky.com&gt;</a>
---
 target/riscv/helper.h                   |  17 ++++
 target/riscv/insn32.decode              |   5 ++
 target/riscv/insn_trans/trans_rvv.inc.c |   7 ++
 target/riscv/vector_helper.c            | 100 ++++++++++++++++++++++++
 4 files changed, 129 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index fd1c184852..311ce1322c 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -715,3 +715,20 @@ DEF_HELPER_6(vssub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vssub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vssub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vssub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vaadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vaadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vaadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vaadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c9a4050adc..e617d7bd60 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -417,6 +417,11 @@ vssubu_vv       100010 . ..... ..... 000 ..... 1010111 @r_vm
 vssubu_vx       100010 . ..... ..... 100 ..... 1010111 @r_vm
 vssub_vv        100011 . ..... ..... 000 ..... 1010111 @r_vm
 vssub_vx        100011 . ..... ..... 100 ..... 1010111 @r_vm
+vaadd_vv        100100 . ..... ..... 000 ..... 1010111 @r_vm
+vaadd_vx        100100 . ..... ..... 100 ..... 1010111 @r_vm
+vaadd_vi        100100 . ..... ..... 011 ..... 1010111 @r_vm
+vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
+vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index dd1a508a51..ba2e7d56f4 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1636,3 +1636,10 @@ GEN_OPIVX_TRANS(vssubu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssub_vx,  opivx_check)
 GEN_OPIVI_TRANS(vsaddu_vi, 1, vsaddu_vx, opivx_check)
 GEN_OPIVI_TRANS(vsadd_vi, 0, vsadd_vx, opivx_check)
+
+/* Vector Single-Width Averaging Add and Subtract */
+GEN_OPIVV_TRANS(vaadd_vv, opivv_check)
+GEN_OPIVV_TRANS(vasub_vv, opivv_check)
+GEN_OPIVX_TRANS(vaadd_vx,  opivx_check)
+GEN_OPIVX_TRANS(vasub_vx,  opivx_check)
+GEN_OPIVI_TRANS(vaadd_vi, 0, vaadd_vx, opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index b17cac7fd4..984a8e260f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2488,3 +2488,103 @@ GEN_VEXT_VX_RM(vssub_vx_b, 1, 1, clearb)
 GEN_VEXT_VX_RM(vssub_vx_h, 2, 2, clearh)
 GEN_VEXT_VX_RM(vssub_vx_w, 4, 4, clearl)
 GEN_VEXT_VX_RM(vssub_vx_d, 8, 8, clearq)
+
+/* Vector Single-Width Averaging Add and Subtract */
+static inline uint8_t get_round(int vxrm, uint64_t v, uint8_t shift)
+{
+    uint8_t d = extract64(v, shift, 1);
+    uint8_t d1;
+    uint64_t D1, D2;
+
+    if (shift == 0 || shift &gt; 64) {
+        return 0;
+    }
+
+    d1 = extract64(v, shift - 1, 1);
+    D1 = extract64(v, 0, shift);
+    if (vxrm == 0) { /* round-to-nearest-up (add +0.5 LSB) */
+        return d1;
+    } else if (vxrm == 1) { /* round-to-nearest-even */
+        if (shift &gt; 1) {
+            D2 = extract64(v, 0, shift - 1);
+            return d1 &amp; ((D2 != 0) | d);
+        } else {
+            return d1 &amp; d;
+        }
+    } else if (vxrm == 3) { /* round-to-odd (OR bits into LSB, aka "jam") */
+        return !d &amp; (D1 != 0);
+    }
+    return 0; /* round-down (truncate) */
+}
+
+static inline int32_t aadd32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+{
+    int64_t res = (int64_t)a + b;
+    uint8_t round = get_round(vxrm, res, 1);
+
+    return (res &gt;&gt; 1) + round;
+}
+
+static inline int64_t aadd64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
+{
+    int64_t res = a + b;
+    uint8_t round = get_round(vxrm, res, 1);
+    int64_t over = (res ^ a) &amp; (res ^ b) &amp; INT64_MIN;
+
+    /* With signed overflow, bit 64 is inverse of bit 63. */
+    return ((res &gt;&gt; 1) ^ over) + round;
+}
+
+RVVCALL(OPIVV2_RM, vaadd_vv_b, OP_SSS_B, H1, H1, H1, aadd32)
+RVVCALL(OPIVV2_RM, vaadd_vv_h, OP_SSS_H, H2, H2, H2, aadd32)
+RVVCALL(OPIVV2_RM, vaadd_vv_w, OP_SSS_W, H4, H4, H4, aadd32)
+RVVCALL(OPIVV2_RM, vaadd_vv_d, OP_SSS_D, H8, H8, H8, aadd64)
+GEN_VEXT_VV_RM(vaadd_vv_b, 1, 1, clearb)
+GEN_VEXT_VV_RM(vaadd_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_RM(vaadd_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_RM(vaadd_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2_RM, vaadd_vx_b, OP_SSS_B, H1, H1, aadd32)
+RVVCALL(OPIVX2_RM, vaadd_vx_h, OP_SSS_H, H2, H2, aadd32)
+RVVCALL(OPIVX2_RM, vaadd_vx_w, OP_SSS_W, H4, H4, aadd32)
+RVVCALL(OPIVX2_RM, vaadd_vx_d, OP_SSS_D, H8, H8, aadd64)
+GEN_VEXT_VX_RM(vaadd_vx_b, 1, 1, clearb)
+GEN_VEXT_VX_RM(vaadd_vx_h, 2, 2, clearh)
+GEN_VEXT_VX_RM(vaadd_vx_w, 4, 4, clearl)
+GEN_VEXT_VX_RM(vaadd_vx_d, 8, 8, clearq)
+
+static inline int32_t asub32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+{
+    int64_t res = (int64_t)a - b;
+    uint8_t round = get_round(vxrm, res, 1);
+
+    return (res &gt;&gt; 1) + round;
+}
+</pre>
    I find a corner case here.  As the spec said in Section 13.2<br>
    <pre>  "There can be no overflow in the result".</pre>
    If the a is 0x7fffffff,  b is 0x80000000, and the round mode is
    round to up(rnu),<br>
    then the result is (0x7fffffff - 0x80000000 + 1) &gt;&gt; 1, equals
    0x80000000, according the v0.7.1<br>
    <blockquote>
      <pre># Averaging subtract</pre>
      <pre># result = (src1 - src2 + round) &gt;&gt; 1;

</pre>
    </blockquote>
    The result is also overflow, according to v0.8. It will be
    calculated that like here,<br>
    <blockquote>
      <pre>roundoff_signed(vs2[i] - vs1[i], 1)

roundoff_signed(v, d) = (signed(v) &gt;&gt; d) + r

</pre>
    </blockquote>
    Should I check do a saturation here?<br>
    <br>
    Zhiwei<br>
    <br>
    <br>
    <br>
    <pre>
</pre>
    <blockquote type="cite"
      cite="mid:20200317150653.9008-26-zhiwei_liu@c-sky.com">
      <pre class="moz-quote-pre" wrap="">
+static inline int64_t asub64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
+{
+    int64_t res = (int64_t)a - b;
+    uint8_t round = get_round(vxrm, res, 1);
+    int64_t over = (res ^ a) &amp; (a ^ b) &amp; INT64_MIN;
+
+    /* With signed overflow, bit 64 is inverse of bit 63. */
+    return ((res &gt;&gt; 1) ^ over) + round;
+}
+
+RVVCALL(OPIVV2_RM, vasub_vv_b, OP_SSS_B, H1, H1, H1, asub32)
+RVVCALL(OPIVV2_RM, vasub_vv_h, OP_SSS_H, H2, H2, H2, asub32)
+RVVCALL(OPIVV2_RM, vasub_vv_w, OP_SSS_W, H4, H4, H4, asub32)
+RVVCALL(OPIVV2_RM, vasub_vv_d, OP_SSS_D, H8, H8, H8, asub64)
+GEN_VEXT_VV_RM(vasub_vv_b, 1, 1, clearb)
+GEN_VEXT_VV_RM(vasub_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_RM(vasub_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_RM(vasub_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2_RM, vasub_vx_b, OP_SSS_B, H1, H1, asub32)
+RVVCALL(OPIVX2_RM, vasub_vx_h, OP_SSS_H, H2, H2, asub32)
+RVVCALL(OPIVX2_RM, vasub_vx_w, OP_SSS_W, H4, H4, asub32)
+RVVCALL(OPIVX2_RM, vasub_vx_d, OP_SSS_D, H8, H8, asub64)
+GEN_VEXT_VX_RM(vasub_vx_b, 1, 1, clearb)
+GEN_VEXT_VX_RM(vasub_vx_h, 2, 2, clearh)
+GEN_VEXT_VX_RM(vasub_vx_w, 4, 4, clearl)
+GEN_VEXT_VX_RM(vasub_vx_d, 8, 8, clearq)
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------AA80C2260A9958F4DBBA9BAA--

