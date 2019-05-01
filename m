Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A21C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8D120866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JtHBnm60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8D120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36305 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhYX-0003zh-4l
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:13:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRJ-0006L9-Ks
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRG-0002p9-Iy
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:53 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRG-0002oK-D4
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:50 -0400
Received: by mail-pg1-x543.google.com with SMTP id t22so4853901pgi.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=tE6uzAjTMyTfJHn+9O8Wl99P1LuOsbUfHnL5seHXmm4=;
	b=JtHBnm60A8xlwcfxVU6lpag4oCwZ7r4A8kowmdEna3MhBbwSUfgCrbmqfxd35zIIKj
	+dTlyxefKoZNUq+//44t06S5ExTDfDny9KZmbG0rUVuD+H/BgFJBHDZySzXWbzzSx8+V
	QYp2aj+bkrsOleWG/djZncL//U4z8j3JXzMeuhxlqypuS0KJ/73ES6zkuQnulXaWGnYM
	BINEHtkQTcXhRzWeZoVfuI7RNLsM/Ed6Ba4D6U+0lQf6zCBtLnMk7dq+8+9RjUgMrk5m
	P0Mgw1PfZOkDAlGNFcXZ5YsCt+livroZn+JgN8cxbTNGVmNOqWpT3MAhFs1rMVh4R07P
	UVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=tE6uzAjTMyTfJHn+9O8Wl99P1LuOsbUfHnL5seHXmm4=;
	b=MIP4rPDrf6jOlMIXxoHCoNN2P2+GIdEqEKyTpT03+lj7LsHOeX/ICd9k/VXsmYc6vT
	HzwO72jFdlCsPbxsdQELj9TcU7Il8GtgVsjrEBXfcANUaWeJFXArQjetkKG2YYsc9yUp
	zROfLrcYeRqBGJ88UBiWGgoMmP32sQUKdPh5oVD6Q/c2TKKGt8FDcqGgF5rLfxAziMqS
	xe2hse2LDStjLO22UGab8CKm/lGoRCSF60+yBEKs2w2LVeleGVr1IOBHAU45MdqBR0x4
	+4VEa/pphWyTfI4z5O894le4SbVF0WWfY9HIl+1pPy2UPOAEM60pIsLErF62dK517zbw
	2S+w==
X-Gm-Message-State: APjAAAWglVQ+LD34Au5BvQVRgmuMACNtCKXqOtK/z3sSKw+NgtvbyKCQ
	EZ2PWt1YDzvB4BXzZeYMf3fd1peS8/s=
X-Google-Smtp-Source: APXvYqzsqe4d1Oz90iw1k6CisRkpmalKv0aErPBRpU4ih4G+vZyXbGUU55XlcwLoezjZ3y/lg1LJZA==
X-Received: by 2002:a62:480d:: with SMTP id v13mr77874034pfa.125.1556687147454;
	Tue, 30 Apr 2019 22:05:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.05.46 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:05:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:10 -0700
Message-Id: <20190501050536.15580-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v2 03/29] tcg: Allow add_vec, sub_vec, neg_vec,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501050510.Qb6xdQ5zcJOYETfxrI68BGmDSVVZxkwPtutalyOLOcw@z>

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


