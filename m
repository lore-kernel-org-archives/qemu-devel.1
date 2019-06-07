Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7535C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 822152083D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822152083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49578 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZI7e-0008I7-Vk
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53315)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZGzs-0003U0-Co
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZGxo-0002yZ-IO
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:39:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZGxn-0002tR-Td
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:39:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C8FC3086204;
 Fri,  7 Jun 2019 15:39:25 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA3CF80881;
 Fri,  7 Jun 2019 15:39:20 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Jun 2019 17:37:19 +0200
Message-Id: <20190607153725.18055-24-philmd@redhat.com>
In-Reply-To: <20190607153725.18055-1-philmd@redhat.com>
References: <20190607153725.18055-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 07 Jun 2019 15:39:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v18 23/29] target/rx: Emit all disassembly in
 one prt()
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Many of the multi-part prints have been eliminated by previous
patches.  Eliminate the rest of them.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20190607091116.49044-22-ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/disas.c | 75 ++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index db10385fd0..ebc1a44249 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -228,24 +228,21 @@ static bool trans_MOV_ra(DisasContext *ctx, arg_MOV=
_ra *a)
 /* mov.[bwl] rs,rd */
 static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
 {
-    char dspd[8], dsps[8];
+    char dspd[8], dsps[8], szc =3D size[a->sz];
=20
-    prt("mov.%c\t", size[a->sz]);
     if (a->lds =3D=3D 3 && a->ldd =3D=3D 3) {
         /* mov.[bwl] rs,rd */
-        prt("r%d, r%d", a->rs, a->rd);
-        return true;
-    }
-    if (a->lds =3D=3D 3) {
+        prt("mov.%c\tr%d, r%d", szc, a->rs, a->rd);
+    } else if (a->lds =3D=3D 3) {
         rx_index_addr(ctx, dspd, a->ldd, a->sz);
-        prt("r%d, %s[r%d]", a->rs, dspd, a->rd);
+        prt("mov.%c\tr%d, %s[r%d]", szc, a->rs, dspd, a->rd);
     } else if (a->ldd =3D=3D 3) {
         rx_index_addr(ctx, dsps, a->lds, a->sz);
-        prt("%s[r%d], r%d", dsps, a->rs, a->rd);
+        prt("mov.%c\t%s[r%d], r%d", szc, dsps, a->rs, a->rd);
     } else {
         rx_index_addr(ctx, dsps, a->lds, a->sz);
         rx_index_addr(ctx, dspd, a->ldd, a->sz);
-        prt("%s[r%d], %s[r%d]", dsps, a->rs, dspd, a->rd);
+        prt("mov.%c\t%s[r%d], %s[r%d]", szc, dsps, a->rs, dspd, a->rd);
     }
     return true;
 }
@@ -254,8 +251,11 @@ static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_=
mm *a)
 /* mov.[bwl] rs,[-rd] */
 static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
 {
-    prt("mov.%c\tr%d, ", size[a->sz], a->rs);
-    prt((a->ad =3D=3D 0) ? "[r%d+]" : "[-r%d]", a->rd);
+    if (a->ad) {
+        prt("mov.%c\tr%d, [-r%d]", size[a->sz], a->rs, a->rd);
+    } else {
+        prt("mov.%c\tr%d, [r%d+]", size[a->sz], a->rs, a->rd);
+    }
     return true;
 }
=20
@@ -263,9 +263,11 @@ static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_=
rp *a)
 /* mov.[bwl] [-rd],rs */
 static bool trans_MOV_pr(DisasContext *ctx, arg_MOV_pr *a)
 {
-    prt("mov.%c\t", size[a->sz]);
-    prt((a->ad =3D=3D 0) ? "[r%d+]" : "[-r%d]", a->rd);
-    prt(", r%d", a->rs);
+    if (a->ad) {
+        prt("mov.%c\t[-r%d], r%d", size[a->sz], a->rd, a->rs);
+    } else {
+        prt("mov.%c\t[r%d+], r%d", size[a->sz], a->rd, a->rs);
+    }
     return true;
 }
=20
@@ -299,9 +301,11 @@ static bool trans_MOVU_ar(DisasContext *ctx, arg_MOV=
U_ar *a)
 /* movu.[bw] [-rs],rd */
 static bool trans_MOVU_pr(DisasContext *ctx, arg_MOVU_pr *a)
 {
-    prt("movu.%c\t", size[a->sz]);
-    prt((a->ad =3D=3D 0) ? "[r%d+]" : "[-r%d]", a->rd);
-    prt(", r%d", a->rs);
+    if (a->ad) {
+        prt("movu.%c\t[-r%d], r%d", size[a->sz], a->rd, a->rs);
+    } else {
+        prt("movu.%c\t[r%d+], r%d", size[a->sz], a->rd, a->rs);
+    }
     return true;
 }
=20
@@ -478,11 +482,11 @@ static bool trans_TST_mr(DisasContext *ctx, arg_TST=
_mr *a)
 /* not rs, rd */
 static bool trans_NOT_rr(DisasContext *ctx, arg_NOT_rr *a)
 {
-    prt("not\t");
     if (a->rs !=3D a->rd) {
-        prt("r%d, ", a->rs);
+        prt("not\tr%d, r%d", a->rs, a->rd);
+    } else {
+        prt("not\tr%d", a->rs);
     }
-    prt("r%d", a->rd);
     return true;
 }
=20
@@ -490,11 +494,11 @@ static bool trans_NOT_rr(DisasContext *ctx, arg_NOT=
_rr *a)
 /* neg rs, rd */
 static bool trans_NEG_rr(DisasContext *ctx, arg_NEG_rr *a)
 {
-    prt("neg\t");
     if (a->rs !=3D a->rd) {
-        prt("r%d, ", a->rs);
+        prt("neg\tr%d, r%d", a->rs, a->rd);
+    } else {
+        prt("neg\tr%d", a->rs);
     }
-    prt("r%d", a->rd);
     return true;
 }
=20
@@ -606,11 +610,10 @@ static bool trans_SBB_mr(DisasContext *ctx, arg_SBB=
_mr *a)
 /* abs rs, rd */
 static bool trans_ABS_rr(DisasContext *ctx, arg_ABS_rr *a)
 {
-    prt("abs\t");
-    if (a->rs =3D=3D a->rd) {
-        prt("r%d", a->rd);
+    if (a->rs !=3D a->rd) {
+        prt("abs\tr%d, r%d", a->rs, a->rd);
     } else {
-        prt("r%d, r%d", a->rs, a->rd);
+        prt("abs\tr%d", a->rs);
     }
     return true;
 }
@@ -733,11 +736,11 @@ static bool trans_DIVU_mr(DisasContext *ctx, arg_DI=
VU_mr *a)
 /* shll #imm:5, rs, rd */
 static bool trans_SHLL_irr(DisasContext *ctx, arg_SHLL_irr *a)
 {
-    prt("shll\t#%d, ", a->imm);
     if (a->rs2 !=3D a->rd) {
-        prt("r%d, ", a->rs2);
+        prt("shll\t#%d, r%d, r%d", a->imm, a->rs2, a->rd);
+    } else {
+        prt("shll\t#%d, r%d", a->imm, a->rd);
     }
-    prt("r%d", a->rd);
     return true;
 }
=20
@@ -752,11 +755,11 @@ static bool trans_SHLL_rr(DisasContext *ctx, arg_SH=
LL_rr *a)
 /* shar #imm:5, rs, rd */
 static bool trans_SHAR_irr(DisasContext *ctx, arg_SHAR_irr *a)
 {
-    prt("shar\t#%d,", a->imm);
     if (a->rs2 !=3D a->rd) {
-        prt("r%d, ", a->rs2);
+        prt("shar\t#%d, r%d, r%d", a->imm, a->rs2, a->rd);
+    } else {
+        prt("shar\t#%d, r%d", a->imm, a->rd);
     }
-    prt("r%d", a->rd);
     return true;
 }
=20
@@ -771,11 +774,11 @@ static bool trans_SHAR_rr(DisasContext *ctx, arg_SH=
AR_rr *a)
 /* shlr #imm:5, rs, rd */
 static bool trans_SHLR_irr(DisasContext *ctx, arg_SHLR_irr *a)
 {
-    prt("shlr\t#%d, ", a->imm);
     if (a->rs2 !=3D a->rd) {
-        prt("r%d, ", a->rs2);
+        prt("shlr\t#%d, r%d, r%d", a->imm, a->rs2, a->rd);
+    } else {
+        prt("shlr\t#%d, r%d", a->imm, a->rd);
     }
-    prt("r%d", a->rd);
     return true;
 }
=20
--=20
2.20.1


