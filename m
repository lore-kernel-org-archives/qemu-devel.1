Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C40C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 06:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EAFE2086A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 06:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LcN1CWte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAFE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39967 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQQcj-0001Zw-Ki
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 02:09:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQQbt-0001IT-QY
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQQbs-00061F-OA
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:08:21 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:44557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKx6-0002xw-RC
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:05:54 -0400
Received: by mail-pl1-x633.google.com with SMTP id d3so7261676plj.11
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=JF2bKE9XmhoHbt9KR1NJ6aVBR5o9hUq7Nq5BVGZIG24=;
	b=LcN1CWtejXlR4vPyIVND7D+/ad9xERF+38DPtvt1fWZ9u+6yhisaiq+OT9dfkUb7d0
	P+5v23BgYWG1N57AWYPOr/A6yQxvFMQY9tVirHSHBPZe02nyAkyHamb0UUlHL7xZrHOo
	q9WWif05Q6upWGi84sAHzMkMeXkcEpJbAPhkaX08wMP+zey+f0nnHqPpDdKMJHg26Ua7
	6VIa1ins50U4KpmUuoEYGhWpIZMERoxp8okUO3RkKgTtUdY+CuulqfOmdg6EVngKP3Gi
	38/Pv+B3ntzaw/d8ZS5+XQklQGe/G7tnBIXOIc/D9qR7dyVzZumRA6hy0vbCODHMHMRk
	lkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=JF2bKE9XmhoHbt9KR1NJ6aVBR5o9hUq7Nq5BVGZIG24=;
	b=X6KNZnAQHducFE2RXsMFOhu6OvX0b5OafnUwx2PI/p85lbzl0d0fJEw12MZNyStf7f
	hI38hPN2gO99islSiyknYZeydNyFB1uBoJYdiO5YU64cA6HaAG9kAYX1P/Aie5G47AaI
	0hING2fFupm+yJWn9rbsghFFYVELgRNncfIJt+CcRD+UvQ4uGOD/CA7RtzgvSVI6nVKu
	a0ENql1+ou3eel0X/JkKGpMydzP3Kr1XJ1Kn/abC8LqDNlKn7J31sX+bxO3AQ+cc51kY
	lWB31VL2UXMDIjX9FaS4BIVWA6zyNxTzo80uIMXuFQq/YtN48FHKdinoTMbou7MI4iYy
	UiHw==
X-Gm-Message-State: APjAAAUlF1Kxh4NSFfF8VZoXb+1GCTSbc6wcp8TWg+cey7kzvOEpwFXJ
	PZZ9a7iWTTTtI4ADf1/HyIH/NE4f5Dg=
X-Google-Smtp-Source: APXvYqw2rnB7qwBXw/6aYDbeeZtK5VszDP+Ks0t68+Dbpl6bp/PhADdzXOzn3OtQ51H3HunckOnjdA==
X-Received: by 2002:a17:902:2f:: with SMTP id
	44mr34503984pla.137.1557792346948; 
	Mon, 13 May 2019 17:05:46 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.05.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:05:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:12 -0700
Message-Id: <20190514000540.4313-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::633
Subject: [Qemu-devel] [PULL 03/31] tcg: Allow add_vec, sub_vec, neg_vec,
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PowerPC Altivec does not support add and subtract of 64-bit elements.
Prepare for that configuration by not assuming the operation is
universally supported.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
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


