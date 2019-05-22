Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3FEC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990642089E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3PiTJIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990642089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52559 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZnx-00071C-So
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:33:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZiv-00031X-PC
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZir-0007M3-Ve
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:35 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b]:46056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZiq-0007KH-1X
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:33 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id e128so1480127ybc.12
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=IHzD/cFhgds3vlWGOoqI0eCnewZUJpWI1Gh0PD14SRs=;
	b=r3PiTJIYGw6Qs7AjLyAsPGTd64/vPXH9IOtnr5MlPytOjoetK9dxpS3cgnAzqP+nZp
	imN36oAEOka/Ld0rteneJ81sNTxmgnQfnjlbcX3U4GeD2PIPmVVpUo4Iv2iumpBiy8VK
	vjMbnYTCY+JzY6vYjU/HIE2AjGDAhCPxjHzHcSjYfq//3AC8MPmunp5tdTq7tkiAC/F2
	NT3U5y97EDAeB+QxGELztQ95aIGyTYE/lOgvroc4MEDKdNGa9E7FM8+73n9YkQ63Pc4U
	6bT7n3KnS5lp+UDtATlcHcwg4AsnTEyiBekXUvaGsPqql68UOpMqm/GDpT+OFQzr9qdm
	cR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=IHzD/cFhgds3vlWGOoqI0eCnewZUJpWI1Gh0PD14SRs=;
	b=YS8g7zKvyX/gmPcoaJyKRf4q31lO36p+1dbT1J/CZhcJYUFUGIUB39FHKFhAZpJ/G7
	e/nzJVQau8GCCHIvfpNC9qKoHdNQeZU3C+owv6SJ5xe/IDBAlS7UV4WoDKROsAKQjD65
	qdOHdffQwhc7V4o+CekFV5MBpXXtOI16LOsSf+s1pORhHIyeGQ/QxM8XUV5TkQfMwTfx
	CkpbnMSkXH0n0ILRGX9UjZGbB9hbghlPg7YGk9JDOZTyubmFZ5LqfAhMShb3fi0KO/Mo
	uYIRdFiZg05eaztGu0ufYMEuyLc1zWFJxYCp9PYgTt7+TDjwhEFRU1eWUIEitzRCN24E
	7nhA==
X-Gm-Message-State: APjAAAXQ2PPKk6hO9lj130bBylq7CZJA9ttLYHgakU41KaD7KO+u8Y8v
	dWK8VenHMnJ/DIK+ikpjrkWY0rNDC/M=
X-Google-Smtp-Source: APXvYqyo1JoapNx8fGfnh7o8tjUFsrIafCKZLsVaxbvsjeYfyP0i1+j8wrr/x2LCzX5jj/1H44Wxug==
X-Received: by 2002:a25:f20e:: with SMTP id i14mr41568617ybe.122.1558564109512;
	Wed, 22 May 2019 15:28:29 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:10 -0400
Message-Id: <20190522222821.23850-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b2b
Subject: [Qemu-devel] [PULL 05/16] tcg: Introduce do_op3_nofail for vector
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes do_op3 match do_op2 in allowing for failure,
and thus fall back expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index a888c02df8..004a34935b 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -562,7 +562,7 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
     }
 }
 
-static void do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
+static bool do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
                    TCGv_vec b, TCGOpcode opc)
 {
     TCGTemp *rt = tcgv_vec_temp(r);
@@ -580,82 +580,91 @@ static void do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
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
@@ -691,7 +700,7 @@ static void do_shifts(unsigned vece, TCGv_vec r, TCGv_vec a,
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


