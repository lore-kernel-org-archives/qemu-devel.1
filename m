Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AAEC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE79F204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOCKcND+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE79F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38571 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpOZ-0002at-Tl
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:12:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpKE-0007Og-Oh
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpKD-0001oc-B9
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:10 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:41740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTpKD-0001oP-60
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:09 -0400
Received: by mail-ua1-x942.google.com with SMTP id l14so2294504uah.8
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=pbfDs442BAd/I+oAZpTGln0e5aK1o/cuCpLJVKNslr4=;
	b=MOCKcND+pVFTWIEX5aL5wPNaOKK5vdCiY2mzXKxLnCsW+6atuxmEdb+M+L90AeuZ3M
	tyQ1B0hIt2UMDcBjj/RLL/CH5XDY7G5GGs5AVDSVJK7YitFk4ShjCyP2SIPUaKK52M3S
	FHHBkyzsSZr9IpQP4Ko6BGsT48WOam9xjm1j0e4I2fvKft7Kx9FjKaqHeE/+SnCJDvO9
	Z/wLsXmCqmSslPyRoFR7Ei40gMIp5is5dmoUi0Ytzkixe3V3bCFWYEFiRiliMP79pPAN
	hV2FMqvRrGl/xdnMhI4+oIP82+cbDXxZnUYOYak6Ce15My1P626hbcWA0486kzVuqDH5
	XddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=pbfDs442BAd/I+oAZpTGln0e5aK1o/cuCpLJVKNslr4=;
	b=NeokEM2eEpflJDz9F0Csd7zq3yciCON3kaBFFxUtWb1Gh3MXhM+/WBoIL0ZAcrAoS0
	KM8YcVy3JEvSpf67KxmaKbhFBt7Viobwd7XzA+BJAbap4CSjkv24ceTraNBvBk2etVig
	eNOr5BX92B4xHTzJx+Rh8Iyw7P4BYGmXF4Xnj/6xww77m5zuVrOub6Rkn6waOK0+0mcG
	8fr/FglmY8xrQuRY5oHRODJAXeL5AGl7zMy51wkwvJN9g657THIjzT4PYPo82Q1UEtyV
	iV49FZS4bERMCxkb30vsmgLJt60jse3O69YrV3e3lWbmq10+sqtPfEe+RuF1qlxU80Tu
	UPYg==
X-Gm-Message-State: APjAAAXb15dY7I7h+UtubkEpzcdXW5tdkGbtTMzaf6MWxgHxEvLx6QYw
	vtx6q8e/Vap2buHOgKCD7hW5fZ/rHYI=
X-Google-Smtp-Source: APXvYqw21BD5QQl/+leuxFyxq/YGFumvZvZjsvbMo8ae3f8af7FFbfQ4XtKL0P8pFvy1Gmu4jxDkjw==
X-Received: by 2002:ab0:240b:: with SMTP id f11mr17434851uan.118.1558624088000;
	Thu, 23 May 2019 08:08:08 -0700 (PDT)
Received: from localhost.localdomain (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	p70sm4227462vsd.25.2019.05.23.08.08.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 08:08:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:07:58 -0400
Message-Id: <20190523150803.31504-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523150803.31504-1-richard.henderson@linaro.org>
References: <20190523150803.31504-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::942
Subject: [Qemu-devel] [PATCH 1/6] target/rx: Disassemble rx_index_addr into
 a string
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
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We were eliding all zero indexes.  It is only ld==0 that does
not have an index in the instruction.  This also allows us to
avoid breaking the final print into multiple pieces.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/disas.c | 154 +++++++++++++++++-----------------------------
 1 file changed, 55 insertions(+), 99 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 8cada4825d..64342537ee 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -107,49 +107,42 @@ static const char psw[] = {
     'i', 'u', 0, 0, 0, 0, 0, 0,
 };
 
-static uint32_t rx_index_addr(int ld, int size, DisasContext *ctx)
+static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi)
 {
-    bfd_byte buf[2];
+    uint32_t addr = ctx->addr;
+    uint8_t buf[2];
+    uint16_t dsp;
+
     switch (ld) {
     case 0:
-        return 0;
+        /* No index; return empty string.  */
+        out[0] = '\0';
+        return;
     case 1:
-        ctx->dis->read_memory_func(ctx->addr, buf, 1, ctx->dis);
         ctx->addr += 1;
-        return ((uint8_t)buf[0]) << size;
+        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
+        dsp = buf[0];
+        break;
     case 2:
-        ctx->dis->read_memory_func(ctx->addr, buf, 2, ctx->dis);
         ctx->addr += 2;
-        return lduw_le_p(buf) << size;
+        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
+        dsp = lduw_le_p(buf);
+        break;
+    default:
+        g_assert_not_reached();
     }
-    g_assert_not_reached();
+
+    sprintf(out, "%u", dsp << (mi < 3 ? mi : 4 - mi));
 }
 
 static void operand(DisasContext *ctx, int ld, int mi, int rs, int rd)
 {
-    int dsp;
     static const char sizes[][4] = {".b", ".w", ".l", ".uw", ".ub"};
+    char dsp[8];
+
     if (ld < 3) {
-        switch (mi) {
-        case 4:
-            /* dsp[rs].ub */
-            dsp = rx_index_addr(ld, RX_MEMORY_BYTE, ctx);
-            break;
-        case 3:
-            /* dsp[rs].uw */
-            dsp = rx_index_addr(ld, RX_MEMORY_WORD, ctx);
-            break;
-        default:
-            /* dsp[rs].b */
-            /* dsp[rs].w */
-            /* dsp[rs].l */
-            dsp = rx_index_addr(ld, mi, ctx);
-            break;
-        }
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d]%s", rs, sizes[mi]);
+        rx_index_addr(ctx, dsp, ld, mi);
+        prt("%s[r%d]%s", dsp, rs, sizes[mi]);
     } else {
         prt("r%d", rs);
     }
@@ -235,7 +228,7 @@ static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_ra *a)
 /* mov.[bwl] rs,rd */
 static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
 {
-    int dsp;
+    char dspd[8], dsps[8];
 
     prt("mov.%c\t", size[a->sz]);
     if (a->lds == 3 && a->ldd == 3) {
@@ -244,29 +237,15 @@ static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
         return true;
     }
     if (a->lds == 3) {
-        prt("r%d, ", a->rd);
-        dsp = rx_index_addr(a->ldd, a->sz, ctx);
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d]", a->rs);
+        rx_index_addr(ctx, dspd, a->ldd, a->sz);
+        prt("r%d, %s[r%d]", a->rs, dspd, a->rd);
     } else if (a->ldd == 3) {
-        dsp = rx_index_addr(a->lds, a->sz, ctx);
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d], r%d", a->rs, a->rd);
+        rx_index_addr(ctx, dsps, a->lds, a->sz);
+        prt("%s[r%d], r%d", dsps, a->rs, a->rd);
     } else {
-        dsp = rx_index_addr(a->lds, a->sz, ctx);
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d], ", a->rs);
-        dsp = rx_index_addr(a->ldd, a->sz, ctx);
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d]", a->rd);
+        rx_index_addr(ctx, dsps, a->lds, a->sz);
+        rx_index_addr(ctx, dspd, a->ldd, a->sz);
+        prt("%s[r%d], %s[r%d]", dsps, a->rs, dspd, a->rd);
     }
     return true;
 }
@@ -357,12 +336,10 @@ static bool trans_PUSH_r(DisasContext *ctx, arg_PUSH_r *a)
 /* push dsp[rs] */
 static bool trans_PUSH_m(DisasContext *ctx, arg_PUSH_m *a)
 {
-    prt("push\t");
-    int dsp = rx_index_addr(a->ld, a->sz, ctx);
-    if (dsp > 0) {
-        prt("%d", dsp);
-    }
-    prt("[r%d]", a->rs);
+    char dsp[8];
+
+    rx_index_addr(ctx, dsp, a->ld, a->sz);
+    prt("push\t%s[r%d]", dsp, a->rs);
     return true;
 }
 
@@ -389,17 +366,13 @@ static bool trans_XCHG_rr(DisasContext *ctx, arg_XCHG_rr *a)
 /* xchg dsp[rs].<mi>,rd */
 static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
 {
-    int dsp;
     static const char msize[][4] = {
         "b", "w", "l", "ub", "uw",
     };
+    char dsp[8];
 
-    prt("xchg\t");
-    dsp = rx_index_addr(a->ld, a->mi, ctx);
-    if (dsp > 0) {
-        prt("%d", dsp);
-    }
-    prt("[r%d].%s, r%d", a->rs, msize[a->mi], a->rd);
+    rx_index_addr(ctx, dsp, a->ld, a->mi);
+    prt("xchg\t%s[r%d].%s, r%d", dsp, a->rs, msize[a->mi], a->rd);
     return true;
 }
 
@@ -552,13 +525,10 @@ static bool trans_ADC_rr(DisasContext *ctx, arg_ADC_rr *a)
 /* adc dsp[rs], rd */
 static bool trans_ADC_mr(DisasContext *ctx, arg_ADC_mr *a)
 {
-    int dsp;
-    prt("adc\t");
-    dsp = rx_index_addr(a->ld, 2, ctx);
-    if (dsp > 0) {
-        prt("%d", dsp);
-    }
-    prt("[r%d], r%d", a->rs, a->rd);
+    char dsp[8];
+
+    rx_index_addr(ctx, dsp, a->ld, 2);
+    prt("adc\t%s[r%d], r%d", dsp, a->rs, a->rd);
     return true;
 }
 
@@ -1217,25 +1187,17 @@ static bool trans_ITOF(DisasContext *ctx, arg_ITOF *a)
 
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
-        int dsp;                                                \
-        prt("b%s\t#%d, ", #name, a->imm);                       \
-        dsp = rx_index_addr(a->ld, RX_MEMORY_BYTE, ctx);        \
-        if (dsp > 0) {                                          \
-            prt("%d", dsp);                                     \
-        }                                                       \
-        prt("[r%d]", reg);                                      \
+        char dsp[8];                                            \
+        rx_index_addr(ctx, dsp, a->ld, RX_MEMORY_BYTE);         \
+        prt("b%s\t#%d, %s[r%d]", #name, a->imm, dsp, reg);      \
         return true;                                            \
     } while (0)
 
 #define BOP_RM(name)                                            \
     do {                                                        \
-        int dsp;                                                \
-        prt("b%s\tr%d, ", #name, a->rd);                        \
-        dsp = rx_index_addr(a->ld, RX_MEMORY_BYTE, ctx);        \
-        if (dsp > 0) {                                          \
-            prt("%d", dsp);                                     \
-        }                                                       \
-        prt("[r%d]", a->rs);                                    \
+        char dsp[8];                                            \
+        rx_index_addr(ctx, dsp, a->ld, RX_MEMORY_BYTE);         \
+        prt("b%s\tr%d, %s[r%d]", #name, a->rd, dsp, a->rs);     \
         return true;                                            \
     } while (0)
 
@@ -1346,12 +1308,10 @@ static bool trans_BNOT_ir(DisasContext *ctx, arg_BNOT_ir *a)
 /* bmcond #imm, dsp[rd] */
 static bool trans_BMCnd_im(DisasContext *ctx, arg_BMCnd_im *a)
 {
-    int dsp = rx_index_addr(a->ld, RX_MEMORY_BYTE, ctx);
-    prt("bm%s\t#%d, ", cond[a->cd], a->imm);
-    if (dsp > 0) {
-        prt("%d", dsp);
-    }
-    prt("[%d]", a->rd);
+    char dsp[8];
+
+    rx_index_addr(ctx, dsp, a->ld, RX_MEMORY_BYTE);
+    prt("bm%s\t#%d, %s[r%d]", cond[a->cd], a->imm, dsp, a->rd);
     return true;
 }
 
@@ -1443,16 +1403,12 @@ static bool trans_WAIT(DisasContext *ctx, arg_WAIT *a)
 /* sccnd.[bwl] dsp:[rd] */
 static bool trans_SCCnd(DisasContext *ctx, arg_SCCnd *a)
 {
-    int dsp;
-    prt("sc%s.%c\t", cond[a->cd], size[a->sz]);
     if (a->ld < 3) {
-        dsp = rx_index_addr(a->sz, a->ld, ctx);
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d]", a->rd);
+        char dsp[8];
+        rx_index_addr(ctx, dsp, a->sz, a->ld);
+        prt("sc%s.%c\t%s[r%d]", cond[a->cd], size[a->sz], dsp, a->rd);
     } else {
-        prt("r%d", a->rd);
+        prt("sc%s.%c\tr%d", cond[a->cd], size[a->sz], a->rd);
     }
     return true;
 }
-- 
2.17.1


