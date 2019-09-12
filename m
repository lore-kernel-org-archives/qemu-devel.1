Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147ADC5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAB620830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAB620830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ITJ-0007ZH-V7
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 02:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1i8IGC-0002Mz-KN
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1i8IG8-00088N-98
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:07:16 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:44433)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1i8IG7-00086E-OB
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:07:12 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail03.asahi-net.or.jp (Postfix) with ESMTPA id 2499C67B0C;
 Thu, 12 Sep 2019 15:07:09 +0900 (JST)
Received: from yo-satoh-debian.localdomain
 (ae227063.dynamic.ppp.asahi-net.or.jp [14.3.227.63])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id D5DC0240085;
 Thu, 12 Sep 2019 15:07:08 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 15:06:47 +0900
Message-Id: <20190912060701.4642-9-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190912060701.4642-1-ysato@users.sourceforge.jp>
References: <20190912060701.4642-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.15
Subject: [Qemu-devel] [PATCH v24 08/22] target/rx: Disassemble rx_index_addr
 into a string
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
Cc: peter.maydell@linaro.org, imammedo@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We were eliding all zero indexes.  It is only ld=3D=3D0 that does
not have an index in the instruction.  This also allows us to
avoid breaking the final print into multiple pieces.

Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20190607091116.49044-19-ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/disas.c | 154 +++++++++++++++++-----------------------------
 1 file changed, 55 insertions(+), 99 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 8cada4825d..64342537ee 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -107,49 +107,42 @@ static const char psw[] =3D {
     'i', 'u', 0, 0, 0, 0, 0, 0,
 };
=20
-static uint32_t rx_index_addr(int ld, int size, DisasContext *ctx)
+static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi=
)
 {
-    bfd_byte buf[2];
+    uint32_t addr =3D ctx->addr;
+    uint8_t buf[2];
+    uint16_t dsp;
+
     switch (ld) {
     case 0:
-        return 0;
+        /* No index; return empty string.  */
+        out[0] =3D '\0';
+        return;
     case 1:
-        ctx->dis->read_memory_func(ctx->addr, buf, 1, ctx->dis);
         ctx->addr +=3D 1;
-        return ((uint8_t)buf[0]) << size;
+        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
+        dsp =3D buf[0];
+        break;
     case 2:
-        ctx->dis->read_memory_func(ctx->addr, buf, 2, ctx->dis);
         ctx->addr +=3D 2;
-        return lduw_le_p(buf) << size;
+        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
+        dsp =3D lduw_le_p(buf);
+        break;
+    default:
+        g_assert_not_reached();
     }
-    g_assert_not_reached();
+
+    sprintf(out, "%u", dsp << (mi < 3 ? mi : 4 - mi));
 }
=20
 static void operand(DisasContext *ctx, int ld, int mi, int rs, int rd)
 {
-    int dsp;
     static const char sizes[][4] =3D {".b", ".w", ".l", ".uw", ".ub"};
+    char dsp[8];
+
     if (ld < 3) {
-        switch (mi) {
-        case 4:
-            /* dsp[rs].ub */
-            dsp =3D rx_index_addr(ld, RX_MEMORY_BYTE, ctx);
-            break;
-        case 3:
-            /* dsp[rs].uw */
-            dsp =3D rx_index_addr(ld, RX_MEMORY_WORD, ctx);
-            break;
-        default:
-            /* dsp[rs].b */
-            /* dsp[rs].w */
-            /* dsp[rs].l */
-            dsp =3D rx_index_addr(ld, mi, ctx);
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
@@ -235,7 +228,7 @@ static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_r=
a *a)
 /* mov.[bwl] rs,rd */
 static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
 {
-    int dsp;
+    char dspd[8], dsps[8];
=20
     prt("mov.%c\t", size[a->sz]);
     if (a->lds =3D=3D 3 && a->ldd =3D=3D 3) {
@@ -244,29 +237,15 @@ static bool trans_MOV_mm(DisasContext *ctx, arg_MOV=
_mm *a)
         return true;
     }
     if (a->lds =3D=3D 3) {
-        prt("r%d, ", a->rd);
-        dsp =3D rx_index_addr(a->ldd, a->sz, ctx);
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d]", a->rs);
+        rx_index_addr(ctx, dspd, a->ldd, a->sz);
+        prt("r%d, %s[r%d]", a->rs, dspd, a->rd);
     } else if (a->ldd =3D=3D 3) {
-        dsp =3D rx_index_addr(a->lds, a->sz, ctx);
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d], r%d", a->rs, a->rd);
+        rx_index_addr(ctx, dsps, a->lds, a->sz);
+        prt("%s[r%d], r%d", dsps, a->rs, a->rd);
     } else {
-        dsp =3D rx_index_addr(a->lds, a->sz, ctx);
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d], ", a->rs);
-        dsp =3D rx_index_addr(a->ldd, a->sz, ctx);
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
@@ -357,12 +336,10 @@ static bool trans_PUSH_r(DisasContext *ctx, arg_PUS=
H_r *a)
 /* push dsp[rs] */
 static bool trans_PUSH_m(DisasContext *ctx, arg_PUSH_m *a)
 {
-    prt("push\t");
-    int dsp =3D rx_index_addr(a->ld, a->sz, ctx);
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
=20
@@ -389,17 +366,13 @@ static bool trans_XCHG_rr(DisasContext *ctx, arg_XC=
HG_rr *a)
 /* xchg dsp[rs].<mi>,rd */
 static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
 {
-    int dsp;
     static const char msize[][4] =3D {
         "b", "w", "l", "ub", "uw",
     };
+    char dsp[8];
=20
-    prt("xchg\t");
-    dsp =3D rx_index_addr(a->ld, a->mi, ctx);
-    if (dsp > 0) {
-        prt("%d", dsp);
-    }
-    prt("[r%d].%s, r%d", a->rs, msize[a->mi], a->rd);
+    rx_index_addr(ctx, dsp, a->ld, a->mi);
+    prt("xchg\t%s[r%d].%s, r%d", dsp, a->rs, msize[a->mi], a->rd);
     return true;
 }
=20
@@ -552,13 +525,10 @@ static bool trans_ADC_rr(DisasContext *ctx, arg_ADC=
_rr *a)
 /* adc dsp[rs], rd */
 static bool trans_ADC_mr(DisasContext *ctx, arg_ADC_mr *a)
 {
-    int dsp;
-    prt("adc\t");
-    dsp =3D rx_index_addr(a->ld, 2, ctx);
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
=20
@@ -1217,25 +1187,17 @@ static bool trans_ITOF(DisasContext *ctx, arg_ITO=
F *a)
=20
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
-        int dsp;                                                \
-        prt("b%s\t#%d, ", #name, a->imm);                       \
-        dsp =3D rx_index_addr(a->ld, RX_MEMORY_BYTE, ctx);        \
-        if (dsp > 0) {                                          \
-            prt("%d", dsp);                                     \
-        }                                                       \
-        prt("[r%d]", reg);                                      \
+        char dsp[8];                                            \
+        rx_index_addr(ctx, dsp, a->ld, RX_MEMORY_BYTE);         \
+        prt("b%s\t#%d, %s[r%d]", #name, a->imm, dsp, reg);      \
         return true;                                            \
     } while (0)
=20
 #define BOP_RM(name)                                            \
     do {                                                        \
-        int dsp;                                                \
-        prt("b%s\tr%d, ", #name, a->rd);                        \
-        dsp =3D rx_index_addr(a->ld, RX_MEMORY_BYTE, ctx);        \
-        if (dsp > 0) {                                          \
-            prt("%d", dsp);                                     \
-        }                                                       \
-        prt("[r%d]", a->rs);                                    \
+        char dsp[8];                                            \
+        rx_index_addr(ctx, dsp, a->ld, RX_MEMORY_BYTE);         \
+        prt("b%s\tr%d, %s[r%d]", #name, a->rd, dsp, a->rs);     \
         return true;                                            \
     } while (0)
=20
@@ -1346,12 +1308,10 @@ static bool trans_BNOT_ir(DisasContext *ctx, arg_=
BNOT_ir *a)
 /* bmcond #imm, dsp[rd] */
 static bool trans_BMCnd_im(DisasContext *ctx, arg_BMCnd_im *a)
 {
-    int dsp =3D rx_index_addr(a->ld, RX_MEMORY_BYTE, ctx);
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
=20
@@ -1443,16 +1403,12 @@ static bool trans_WAIT(DisasContext *ctx, arg_WAI=
T *a)
 /* sccnd.[bwl] dsp:[rd] */
 static bool trans_SCCnd(DisasContext *ctx, arg_SCCnd *a)
 {
-    int dsp;
-    prt("sc%s.%c\t", cond[a->cd], size[a->sz]);
     if (a->ld < 3) {
-        dsp =3D rx_index_addr(a->sz, a->ld, ctx);
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
--=20
2.20.1


