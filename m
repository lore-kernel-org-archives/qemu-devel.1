Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA60C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 08:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBB42087F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 08:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEyK3olj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBB42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38444 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkwe-0006EM-1v
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 04:01:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXX-00011Q-8W
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXV-0000mF-V1
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:59 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXU-0000Mw-AD
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:56 -0400
Received: by mail-pl1-x644.google.com with SMTP id f36so3539289plb.5
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=lRGQ2wNmavOUPa4H3gsQKIdLCd5xhIibGFq5wA+mFqQ=;
	b=eEyK3olj9pgynR5TsnKROTz1B68RnDbqagojfxN7iUkdy4rws/aE7WVVKHbudPeCF/
	yHmO5C3IBVDeT5gndOlpTnr0fonX9PfseZqbJtoDAT0/Oojpjh7xBQP63jDDQubBae6+
	6ZBRdKtRPfjRCvvuhqiwFX56DLFBCQvYNi7eoJWLVN1CLmYEOHjLlWlF7UFGCOmajcqu
	3J1AQ7GbUScp5qX+FL+bWUVS5XfV5Bt9KuGPIPzSgnqc80TSJUPJfBMSB6PuZmKiowBf
	G9PPcbWR558Tbi1wEsPmUOnoTE5IJ5u1AFhwtIfPbFP9qdJIIYhAE9Q+S4MDxKLtPY+g
	yeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=lRGQ2wNmavOUPa4H3gsQKIdLCd5xhIibGFq5wA+mFqQ=;
	b=BzjYEFlmWw+uQx+gfLTgajQ32EmLlP70M2/aJrX9NZ1WtYSZsbGZnfEvNhYQCeiPcF
	OeNMGwtCHs/nqE5I+/pjUQ3ayF1DkZTObVj3VjGufV7sTTYkltqJ6KVx4rpo4Easv2yh
	/ql8+qeM+7tGziaTgdMwiiBCxxaxxZ3pk96y/an3Kp+UDia217ET3DEYdPJxN69lJ26A
	gNB0glutsqi/5VW1pCAu646EiYrJr7zQSgB1OMLGy2NA9JSTAfLpUSLBy8dZIxFhc6+H
	S6x7+LNHLL/oSV9Xhszfu+cWe9N5n2vOeQBeKxX/S1QakESlsHod8dtlDCcx/+g7KJMd
	GwxA==
X-Gm-Message-State: APjAAAWN5IYHaJl5d639jzJDQJNwajIliP5eApPXrgFQLjnPyC+KPFfd
	RW3oE+bXTngGv2W7YkzHQA9WgyJhFts=
X-Google-Smtp-Source: APXvYqz+gnFlO6NLLKsZVUMjmtlIGsEfkRDTQdH282Hgz2ToA50mR3fzjUgFon343Teb2q8QEB005A==
X-Received: by 2002:a17:902:2b88:: with SMTP id
	l8mr8225061plb.262.1555745741032; 
	Sat, 20 Apr 2019 00:35:41 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:39 -1000
Message-Id: <20190420073442.7488-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 35/38] tcg: Introduce do_op3_nofail for vector
 expansion
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
Message-ID: <20190420073439.mq8FOEtH-p18QT3QCspJG6V4Upzpt2eMzUnSt1KvEbA@z>

This makes do_op3 match do_op2 in allowing for failure,
and thus fall back expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 7d8f7b490a..5868a51270 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -450,7 +450,7 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
     }
 }
 
-static void do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
+static bool do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
                    TCGv_vec b, TCGOpcode opc)
 {
     TCGTemp *rt = tcgv_vec_temp(r);
@@ -468,82 +468,91 @@ static void do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
     can = tcg_can_emit_vec_op(opc, type, vece);
     if (can > 0) {
         vec_gen_3(opc, type, vece, ri, ai, bi);
-    } else {
+    } else if (can < 0) {
         const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
-        tcg_debug_assert(can < 0);
         tcg_expand_vec_op(opc, type, vece, ri, ai, bi);
         tcg_swap_vecop_list(hold_list);
+    } else {
+        return false;
     }
+    return true;
+}
+
+static void do_op3_nofail(unsigned vece, TCGv_vec r, TCGv_vec a,
+                          TCGv_vec b, TCGOpcode opc)
+{
+    bool ok = do_op3(vece, r, a, b, opc);
+    tcg_debug_assert(ok);
 }
 
 void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_add_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_add_vec);
 }
 
 void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_sub_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_sub_vec);
 }
 
 void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_mul_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_mul_vec);
 }
 
 void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_ssadd_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_ssadd_vec);
 }
 
 void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_usadd_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_usadd_vec);
 }
 
 void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_sssub_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_sssub_vec);
 }
 
 void tcg_gen_ussub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_ussub_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_ussub_vec);
 }
 
 void tcg_gen_smin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_smin_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_smin_vec);
 }
 
 void tcg_gen_umin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_umin_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_umin_vec);
 }
 
 void tcg_gen_smax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_smax_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_smax_vec);
 }
 
 void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_umax_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_umax_vec);
 }
 
 void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_shlv_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_shlv_vec);
 }
 
 void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_shrv_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_shrv_vec);
 }
 
 void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_sarv_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_sarv_vec);
 }
 
 static void do_shifts(unsigned vece, TCGv_vec r, TCGv_vec a,
@@ -579,7 +588,7 @@ static void do_shifts(unsigned vece, TCGv_vec r, TCGv_vec a,
         } else {
             tcg_gen_dup_i32_vec(vece, vec_s, s);
         }
-        do_op3(vece, r, a, vec_s, opc_v);
+        do_op3_nofail(vece, r, a, vec_s, opc_v);
         tcg_temp_free_vec(vec_s);
     }
     tcg_swap_vecop_list(hold_list);
-- 
2.17.1


