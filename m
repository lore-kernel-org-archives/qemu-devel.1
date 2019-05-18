Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E09C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595B020578
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVuQsC8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595B020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37683 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4kr-00017y-Gl
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:12:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4dT-0002qF-3f
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4au-0002cY-ON
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:09 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4au-0002c3-Ic
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:08 -0400
Received: by mail-pl1-x641.google.com with SMTP id d21so4845499plr.3
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=IHzD/cFhgds3vlWGOoqI0eCnewZUJpWI1Gh0PD14SRs=;
	b=HVuQsC8XioIdkqzl++KY5DDIhwSzp0gt2VFiod5/uuzQwlO/KSs8XXQMt5KQ8/LLQG
	e+29egElL+VfsYpq/jFghEae7CcYDtHHsBt+f2/JvfmJjWtKn+s4Pomxt3YqIxptnQ+N
	nEBAU9kdlni+5SDdbfD2u6AOOoSH63HivAKleDvSW+JmQqQfUd0jEDY5G/rl+PBKdstw
	maKzy2rsarxG6RTY1U2eMl7yMzJoJos/waik5OLOszwl9pwOfCGAUaaIJol0qn5kGte2
	QOJx8qzuwzj231McQB0VvaKDbb1HfPz9Vpu7/ALTNxsz5K1bbutpTPjU1VSpwoihNa2B
	FoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=IHzD/cFhgds3vlWGOoqI0eCnewZUJpWI1Gh0PD14SRs=;
	b=gJF+qwr5Z/kmhhyx9vFOLy7Kj5nefykdoE5aVp3EsrXmX7x/L11cidJe1LJHXfiVvO
	/gD3o1UrCygCJIeYMfzs/ZjbjeqVpWoSiGIXwm9cQvZCxNzQaGh9Gd21KfsmQooWeVC9
	hCC2tz6Ci7xNUMaDalFOBnmpHw5GSW1kjkP80P4USPzUQqyKstuS1WeBcXitV11+srCe
	C6z83yDunDWdfEqM1S2U3tGGK3ORki+dFFLgt8rzBY8UXD49VlIXRww5341IK+bpCofF
	K4NZkYfD2EMus275P9YaOGWP6QAnW+DR13XcMMKetRFRilBSxjoiW5/LkK/P0sQXTDRE
	jYPQ==
X-Gm-Message-State: APjAAAWFTDManvDSkl/aLkqEkG7HjSgaMvvohUNvhVJy/4vH9vjdQ1CR
	3DKLctGkY5zqO1kPLccykTYChxEKkUg=
X-Google-Smtp-Source: APXvYqy8XIHDrNflYwZwJ0yQBtb1boyGHMd5/1K4V5qvcvhXKRLP+lsi8tpYKRmpA/TzkuhQqRF8yQ==
X-Received: by 2002:a17:902:d917:: with SMTP id
	c23mr63258017plz.14.1558206127251; 
	Sat, 18 May 2019 12:02:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m9sm2751274pgd.23.2019.05.18.12.02.06
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:02:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:01:46 -0700
Message-Id: <20190518190157.21255-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518190157.21255-1-richard.henderson@linaro.org>
References: <20190518190157.21255-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH 05/16] tcg: Introduce do_op3_nofail for vector
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


