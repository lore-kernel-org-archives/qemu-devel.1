Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CA1C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A4920675
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sc9EB6Uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A4920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51603 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMndd-0000Ud-Aw
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 01:55:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbj-0007fw-1h
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbh-00046d-4S
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:10 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbg-00041W-S7
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:09 -0400
Received: by mail-pl1-x641.google.com with SMTP id y3so3740134plp.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=70jMM7lEj32hF5MNi2aYGwLWujNJ8i43oE2DiyUoNSA=;
	b=sc9EB6UuNpkDpVrzrzpDZg7hMl7IV+9f4U4dOtk3xfkbCtSAA3HH9nrxhgiI/byQ/4
	a0REF/qt7EcANcn4/JV+m1gnF9zygmcqZahBEBt8/hGvNba6eL0Sn4WwbMt7g1iCb/lz
	0K7qdJJuwTMXCzLFLIuEI/WotvS5wXI5U9Wo4f3v/uPnCDdCAX4Ft9+tmOd09mns8l5j
	OQhUPVCnLFXnCJdk+jg4+k/Oa8Ps1y9+Er+9GCGuBKZUOCr7aOVaK6DTecIdR2Xq2aKW
	9T48wf/CmHiUT9hY74rR8LccMK3oZ+1BZi4MRujWwMe4TPqszSEhRF3NAd1jqjcLvOSy
	rvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=70jMM7lEj32hF5MNi2aYGwLWujNJ8i43oE2DiyUoNSA=;
	b=uQTz7M2yjY2V2Iwppc3E9XczLXGXc/TOuL/hJsx7l150orGgXhPyfAzp9XU2p0dpuH
	5mp6CVip1wM934j2pIimnH/CPyyOQ9aSp6cXBxNK03Q8TY5+jksQlXrVRC3RNiFnRdf0
	jT8lMaT/ymobBy47AgzZE3uf9RBjN1KqqFDUXH4exrojtDyEkxXEmczVTsk5mvNtMoyl
	NeDZcs+D0FgFjG8Q5rrCTinO7Huv7pmRIthBlCouh9I/VCsc22YwcT3JGk5jllzAm78C
	RbiPXmRAkMX0jMK0OFU9eihVvzZ8sYIEiHmBhhGMU5qsszCEzi98EPx02QHpZEYvMBjI
	49Dg==
X-Gm-Message-State: APjAAAVmC82AGPP0hkZBBDbXNVWtoLScyONk7ODsFHByq5JxnpvOsai8
	sNRKp6o+k0Jm706at7QxWpcR90H6hrA=
X-Google-Smtp-Source: APXvYqw0eWYkmI0YSBqpqSTdi4Em9L/MWvx4eQ0hNYtmWc67jfoXsH+ZHGIzuFtovacV/fSB+GSizg==
X-Received: by 2002:a17:902:b582:: with SMTP id
	a2mr7896788pls.287.1556949186211; 
	Fri, 03 May 2019 22:53:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:32 -0700
Message-Id: <20190504055300.18426-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v3 03/31] tcg: Allow add_vec, sub_vec, neg_vec,
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504055232.WXGKXlPm-Qg53k4LR0lvvIFanpP9irJrSDisZ8EgtCY@z>

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


