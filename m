Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B6AC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DCB208C0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJfzaWwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DCB208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38079 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkYP-0001WZ-Di
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:36:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWW-0008Og-P6
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWV-0007mj-LP
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:56 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWV-0007kM-FN
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:55 -0400
Received: by mail-pl1-x642.google.com with SMTP id bf11so3528508plb.12
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=TM1gXfRu5rNa8H31jQ9LQek5zgysMvrWVqkLd98KzZU=;
	b=AJfzaWwT/c1toDadjaTeZ2pixHROHU4oc3oo4/BGxbvxkiyGuLmXOL0++OHt+hPyCb
	By3Lkz4pkSy2Y1ONCf8ssYxoILb8SXkqZG2iqMhYsAlYLhcWDK7ypWDHiAQsJf22/LXd
	XyC+NBZcPJymFFhTJo6peA2gCq/4FuxbnB0o4UovjM3W/ptssLVwdcekT4KWRJQSxDz2
	emLga+LETqVrGRy7610NoPOwTC8hb+phxZ/EnvOwVmbSg/U3YjJvD1l1/oSl5VDXy9Og
	fPRZz2RZCdLx8OWnKc6Fgjr5tzRHiFj4tA3pZmysfAEjSnAwc6cUc21jSCl4kc8+aeGQ
	W6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=TM1gXfRu5rNa8H31jQ9LQek5zgysMvrWVqkLd98KzZU=;
	b=gslMYHa2/W7KWNDswUAJsl7IMLdic+Nd+k0N37efbIxrLTvLbSRPrJtGTrjsTO9YnF
	xk28oKQ8BXisZaFL5SOY3IgSNu+M+tZrMCHWCqNSx+qPzPNYUZ8/RUkanawimwJow48a
	zhrbHS7qP/MJYUuu4wjembp5E4BHwE6/sHJWyHB9dZh6W2wvJXs5L7G/g3B0XsYAmr7P
	2NpWeVBIC/Yd/mB667IZWqnkCFYB/n+yei3NWCci8flemwGewY7i5BmXO2X66gHhM8Jh
	LgCEPf1f17OQDYq8IJ+BBHLFLvHdzzTlcllyGNM+0XXhzndTQl4456tbZ0toiWsjsGxJ
	heIA==
X-Gm-Message-State: APjAAAUcPNezzs37VSA8+TstEgPSi2otViBxfAWII4oxzyRH1sTwOLFA
	w1ymAs/hQRiE7gP1hA/rUUu0LL42B4Q=
X-Google-Smtp-Source: APXvYqzJu5wYCuPYM1LLXdhrBYhqAzGZPaeGWgx0JdF4jeOIhiCEU17hQybHbqqHTFkw7ai5sE18JA==
X-Received: by 2002:a17:902:3e5:: with SMTP id
	d92mr8124255pld.11.1555745694257; 
	Sat, 20 Apr 2019 00:34:54 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.34.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:34:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:09 -1000
Message-Id: <20190420073442.7488-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH 05/38] tcg: Allow add_vec, sub_vec, neg_vec,
 not_vec to be expanded
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
Message-ID: <20190420073409.cgxhoLimAvIdLxiqrOu5oDMSugyJRzUsPo5JVJ-d96Y@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 49 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 27f65600c3..cfb18682b1 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -226,16 +226,6 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr b, TCGArg o, TCGType low_type)
     vec_gen_3(INDEX_op_st_vec, low_type, 0, ri, bi, o);
 }
 
-void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
-{
-    vec_gen_op3(INDEX_op_add_vec, vece, r, a, b);
-}
-
-void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
-{
-    vec_gen_op3(INDEX_op_sub_vec, vece, r, a, b);
-}
-
 void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
     vec_gen_op3(INDEX_op_and_vec, 0, r, a, b);
@@ -296,11 +286,30 @@ void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
     tcg_gen_not_vec(0, r, r);
 }
 
+static bool do_op2(unsigned vece, TCGv_vec r, TCGv_vec a, TCGOpcode opc)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGTemp *at = tcgv_vec_temp(a);
+    TCGArg ri = temp_arg(rt);
+    TCGArg ai = temp_arg(at);
+    TCGType type = rt->base_type;
+    int can;
+
+    tcg_debug_assert(at->base_type >= type);
+    can = tcg_can_emit_vec_op(opc, type, vece);
+    if (can > 0) {
+        vec_gen_2(opc, type, vece, ri, ai);
+    } else if (can < 0) {
+        tcg_expand_vec_op(opc, type, vece, ri, ai);
+    } else {
+        return false;
+    }
+    return true;
+}
+
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 {
-    if (TCG_TARGET_HAS_not_vec) {
-        vec_gen_op2(INDEX_op_not_vec, 0, r, a);
-    } else {
+    if (!TCG_TARGET_HAS_not_vec || !do_op2(vece, r, a, INDEX_op_not_vec)) {
         TCGv_vec t = tcg_const_ones_vec_matching(r);
         tcg_gen_xor_vec(0, r, a, t);
         tcg_temp_free_vec(t);
@@ -309,9 +318,7 @@ void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 {
-    if (TCG_TARGET_HAS_neg_vec) {
-        vec_gen_op2(INDEX_op_neg_vec, vece, r, a);
-    } else {
+    if (!TCG_TARGET_HAS_neg_vec || !do_op2(vece, r, a, INDEX_op_neg_vec)) {
         TCGv_vec t = tcg_const_zeros_vec_matching(r);
         tcg_gen_sub_vec(vece, r, t, a);
         tcg_temp_free_vec(t);
@@ -409,6 +416,16 @@ static void do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
     }
 }
 
+void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_add_vec);
+}
+
+void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_sub_vec);
+}
+
 void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
     do_op3(vece, r, a, b, INDEX_op_mul_vec);
-- 
2.17.1


