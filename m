Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6716C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91F926A06
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLq6dWbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91F926A06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44133 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWiA9-0007Th-W3
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:05:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhp0-0007ga-TF
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhoz-0000eW-Gw
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:50 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWhoz-0000e4-BU
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:49 -0400
Received: by mail-ot1-x342.google.com with SMTP id c3so9219666otr.3
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=VuLtbljmtAHf6MYsP7hDNZ9QyK490zrsemLZHTPIf9I=;
	b=RLq6dWbd2W44Nj8AkXt2M7/D/Z9L+MJ0Mfl+33VA1RF6gx4UzlZSr37aAemABvRRrK
	JDwOkn4G6gWhwO0L4iODGmdUFmAPn4/YmBhEvHRPxoQYrBbP8qSy970QpQljP/QQrzDR
	SFs2a+yA/Qqk0tIkytRuCijNroSNPIZT6dyUIbVWZkNSSRw8BaIoSJ0rD5Fy2HkRPRrg
	mjgPBEYIyuF97UaZuUACKMdjmmQ11A63svI7fL8T3SrCjh1ptWOX2mRSPbWsftaD2H+D
	N+4eeivgX8EwgnYMyXkiBFrXygem1zJyyGXSjwpg9J4QxTw+3yDh4aWaZpURNL3IFlKf
	HlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=VuLtbljmtAHf6MYsP7hDNZ9QyK490zrsemLZHTPIf9I=;
	b=atqnOxN6SS1N2mcUd7QDTaoaIOz4FXz4wGWa6qSEPUqsTOIr6I6Eic7P3Ndn4KAZGU
	U4PoIIXbxW3lZAdhLVG2YqS1m/pdpmLRhfSMliMeroUFo4zNmTiGUN5c5XPGbL+nELWc
	GXtSqIrOZGnJEXY/fysl5SL8for7ARgHm0e+zgTycxMYvWASr3FD1PAAc5h2Sq2OWvtY
	m8mPfmeQ0qOMp+H1H1EsUrSJNDIw25pUm4MZmSW3OJOitovL8TYqz8P7y9aAWu34dCO/
	Z05fgTSB2vp6qh2mmkK+99YZwTYF0fERNIpDzQM4pa8YiuMGe/6PDiewbjhostoh5WLk
	0GUQ==
X-Gm-Message-State: APjAAAXXYTuDh9FzK+gAinH/FB8hd7wxChJJFVVRU5bv4g723tpMNyso
	qDrOmldUxYxZhWcrLsRt20+JVNL6crbTeg==
X-Google-Smtp-Source: APXvYqyyJ3TyFpkAhRLOhcan0Y66ar1J6i10RHv2rO4dinl8k+qaPNDKmihr5ai1hNhObYJmvFveww==
X-Received: by 2002:a9d:5787:: with SMTP id q7mr1974171oth.230.1559310228556; 
	Fri, 31 May 2019 06:43:48 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r23sm2391176otg.49.2019.05.31.06.43.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 06:43:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 08:43:13 -0500
Message-Id: <20190531134315.4109-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531134315.4109-1-richard.henderson@linaro.org>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: [Qemu-devel] [PATCH v16 21/23] target/rx: Emit all disassembly in
 one prt()
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
Cc: philmd@redhat.com, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Many of the multi-part prints have been eliminated by previous
patches.  Eliminate the rest of them.

Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/disas.c | 75 ++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index db10385fd0..ebc1a44249 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -228,24 +228,21 @@ static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_ra *a)
 /* mov.[bwl] rs,rd */
 static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
 {
-    char dspd[8], dsps[8];
+    char dspd[8], dsps[8], szc = size[a->sz];
 
-    prt("mov.%c\t", size[a->sz]);
     if (a->lds == 3 && a->ldd == 3) {
         /* mov.[bwl] rs,rd */
-        prt("r%d, r%d", a->rs, a->rd);
-        return true;
-    }
-    if (a->lds == 3) {
+        prt("mov.%c\tr%d, r%d", szc, a->rs, a->rd);
+    } else if (a->lds == 3) {
         rx_index_addr(ctx, dspd, a->ldd, a->sz);
-        prt("r%d, %s[r%d]", a->rs, dspd, a->rd);
+        prt("mov.%c\tr%d, %s[r%d]", szc, a->rs, dspd, a->rd);
     } else if (a->ldd == 3) {
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
@@ -254,8 +251,11 @@ static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
 /* mov.[bwl] rs,[-rd] */
 static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
 {
-    prt("mov.%c\tr%d, ", size[a->sz], a->rs);
-    prt((a->ad == 0) ? "[r%d+]" : "[-r%d]", a->rd);
+    if (a->ad) {
+        prt("mov.%c\tr%d, [-r%d]", size[a->sz], a->rs, a->rd);
+    } else {
+        prt("mov.%c\tr%d, [r%d+]", size[a->sz], a->rs, a->rd);
+    }
     return true;
 }
 
@@ -263,9 +263,11 @@ static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
 /* mov.[bwl] [-rd],rs */
 static bool trans_MOV_pr(DisasContext *ctx, arg_MOV_pr *a)
 {
-    prt("mov.%c\t", size[a->sz]);
-    prt((a->ad == 0) ? "[r%d+]" : "[-r%d]", a->rd);
-    prt(", r%d", a->rs);
+    if (a->ad) {
+        prt("mov.%c\t[-r%d], r%d", size[a->sz], a->rd, a->rs);
+    } else {
+        prt("mov.%c\t[r%d+], r%d", size[a->sz], a->rd, a->rs);
+    }
     return true;
 }
 
@@ -299,9 +301,11 @@ static bool trans_MOVU_ar(DisasContext *ctx, arg_MOVU_ar *a)
 /* movu.[bw] [-rs],rd */
 static bool trans_MOVU_pr(DisasContext *ctx, arg_MOVU_pr *a)
 {
-    prt("movu.%c\t", size[a->sz]);
-    prt((a->ad == 0) ? "[r%d+]" : "[-r%d]", a->rd);
-    prt(", r%d", a->rs);
+    if (a->ad) {
+        prt("movu.%c\t[-r%d], r%d", size[a->sz], a->rd, a->rs);
+    } else {
+        prt("movu.%c\t[r%d+], r%d", size[a->sz], a->rd, a->rs);
+    }
     return true;
 }
 
@@ -478,11 +482,11 @@ static bool trans_TST_mr(DisasContext *ctx, arg_TST_mr *a)
 /* not rs, rd */
 static bool trans_NOT_rr(DisasContext *ctx, arg_NOT_rr *a)
 {
-    prt("not\t");
     if (a->rs != a->rd) {
-        prt("r%d, ", a->rs);
+        prt("not\tr%d, r%d", a->rs, a->rd);
+    } else {
+        prt("not\tr%d", a->rs);
     }
-    prt("r%d", a->rd);
     return true;
 }
 
@@ -490,11 +494,11 @@ static bool trans_NOT_rr(DisasContext *ctx, arg_NOT_rr *a)
 /* neg rs, rd */
 static bool trans_NEG_rr(DisasContext *ctx, arg_NEG_rr *a)
 {
-    prt("neg\t");
     if (a->rs != a->rd) {
-        prt("r%d, ", a->rs);
+        prt("neg\tr%d, r%d", a->rs, a->rd);
+    } else {
+        prt("neg\tr%d", a->rs);
     }
-    prt("r%d", a->rd);
     return true;
 }
 
@@ -606,11 +610,10 @@ static bool trans_SBB_mr(DisasContext *ctx, arg_SBB_mr *a)
 /* abs rs, rd */
 static bool trans_ABS_rr(DisasContext *ctx, arg_ABS_rr *a)
 {
-    prt("abs\t");
-    if (a->rs == a->rd) {
-        prt("r%d", a->rd);
+    if (a->rs != a->rd) {
+        prt("abs\tr%d, r%d", a->rs, a->rd);
     } else {
-        prt("r%d, r%d", a->rs, a->rd);
+        prt("abs\tr%d", a->rs);
     }
     return true;
 }
@@ -733,11 +736,11 @@ static bool trans_DIVU_mr(DisasContext *ctx, arg_DIVU_mr *a)
 /* shll #imm:5, rs, rd */
 static bool trans_SHLL_irr(DisasContext *ctx, arg_SHLL_irr *a)
 {
-    prt("shll\t#%d, ", a->imm);
     if (a->rs2 != a->rd) {
-        prt("r%d, ", a->rs2);
+        prt("shll\t#%d, r%d, r%d", a->imm, a->rs2, a->rd);
+    } else {
+        prt("shll\t#%d, r%d", a->imm, a->rd);
     }
-    prt("r%d", a->rd);
     return true;
 }
 
@@ -752,11 +755,11 @@ static bool trans_SHLL_rr(DisasContext *ctx, arg_SHLL_rr *a)
 /* shar #imm:5, rs, rd */
 static bool trans_SHAR_irr(DisasContext *ctx, arg_SHAR_irr *a)
 {
-    prt("shar\t#%d,", a->imm);
     if (a->rs2 != a->rd) {
-        prt("r%d, ", a->rs2);
+        prt("shar\t#%d, r%d, r%d", a->imm, a->rs2, a->rd);
+    } else {
+        prt("shar\t#%d, r%d", a->imm, a->rd);
     }
-    prt("r%d", a->rd);
     return true;
 }
 
@@ -771,11 +774,11 @@ static bool trans_SHAR_rr(DisasContext *ctx, arg_SHAR_rr *a)
 /* shlr #imm:5, rs, rd */
 static bool trans_SHLR_irr(DisasContext *ctx, arg_SHLR_irr *a)
 {
-    prt("shlr\t#%d, ", a->imm);
     if (a->rs2 != a->rd) {
-        prt("r%d, ", a->rs2);
+        prt("shlr\t#%d, r%d, r%d", a->imm, a->rs2, a->rd);
+    } else {
+        prt("shlr\t#%d, r%d", a->imm, a->rd);
     }
-    prt("r%d", a->rd);
     return true;
 }
 
-- 
2.17.1


