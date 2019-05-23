Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE2C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75D020856
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+vwYCL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75D020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38516 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpMB-0000EV-ST
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:10:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpKI-0007Rr-S7
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpKH-0001sE-MJ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:14 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:38292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTpKH-0001rv-HQ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:13 -0400
Received: by mail-vs1-xe44.google.com with SMTP id x184so3795169vsb.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=VUnrLOQYFBFf1yK5o5x1yC4115MKE2b9Zzti/sU0+aI=;
	b=F+vwYCL7+G0w1xK+WgTSnRu1c6OwzJrYwWL0yp/TVohjbsK69GyIwEMY8YY1E7NiVs
	dG13iJz5uBC/Di/uMZteaYXCfhBVNAQqPWN0rq/8NDbmSB18RQJhZAvBdoYi6s3noePc
	ZsIWt7ASGojpp+vXo4Oq3DLdGFiv6nhkp+CMt6JO33csmjblGSCado7ci9aS0tzwzQla
	q/U8WB2wY/1TdtMn4n9ig9VDOquIFWQATzxkGCrM/h+4TIPC68ZA1cVPnZf4C6LCueA2
	rH21MvB1YfzW190W5Aoa2yuMfJBc6NK7oEZizlVhv2p6U/+ITFEtrcnXQYunEFIkTXrX
	lSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=VUnrLOQYFBFf1yK5o5x1yC4115MKE2b9Zzti/sU0+aI=;
	b=Rq7U7G3cgvZt9ThswoSW6CKuKrkgXJzhelE1gXDbWTZfvhIqKr5Q7ZHVVp9uIVQa0o
	2q0rC+OmrSXl1KPyk0ViOZbeBNgdeyorPxDIyQ8Y9d6WPRwfaEp8gECqIW5X12l6a9Qi
	/KZcKn6RVH3tsA2AXrfluv3V4dhaih0OWZjpVihpbejfdvp/fVYgrkUdulmKe/0Mo6SN
	SpsRRQec9/g6odgc2oJoioAwbFXAWc+Lbrw5gOJrIzW7tnEYcL2YtBR5j8Yk5d/GTe3k
	vUZgKS+LpB2XBG3zxepCTL2VPuH9Q1L3CMwSUzb94aeWCz0alH7xLloARRRs4oyfskd3
	rWdA==
X-Gm-Message-State: APjAAAX+5tdiNA9+5C+7HfJ6Vnm3mKIlSBiB+1H9vFwJT0j3KQVVxWeF
	UjjEJ7mYMxrNNou5uTaJJNygaD2d2BI=
X-Google-Smtp-Source: APXvYqyXcRzjiKmveCSk73Yl84GPGLZw8GoTnpOlczI7lQsDb7mtqTZu/t8EAzG3nwEeyOQ6H8D05A==
X-Received: by 2002:a67:e250:: with SMTP id w16mr8597924vse.110.1558624092423; 
	Thu, 23 May 2019 08:08:12 -0700 (PDT)
Received: from localhost.localdomain (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	p70sm4227462vsd.25.2019.05.23.08.08.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 08:08:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:08:01 -0400
Message-Id: <20190523150803.31504-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523150803.31504-1-richard.henderson@linaro.org>
References: <20190523150803.31504-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e44
Subject: [Qemu-devel] [PATCH 4/6] target/rx: Emit all disassembly in one
 prt()
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

Many of the multi-part prints have been eliminated by previous
patches.  Eliminate the rest of them.

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


