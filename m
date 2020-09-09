Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1474C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0C02145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZpxMCaG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0C02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnyW-0001Ew-GR
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnp-0000X3-1k
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:33 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnn-0002Ja-8B
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:32 -0400
Received: by mail-pg1-x544.google.com with SMTP id e33so753711pgm.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BMREvoHjj8f1EBfCvu7SAC5TIkS0aPkGQG5Rh07Q5oA=;
 b=ZpxMCaG8wjJxmbdxj4VeD3QaUkzX+KW0qxu1LMlSbD2JcdGP+DSF76g4gMu6HQHRUd
 8F9mL2HayGWWc5QoYvzjj03biCnPylKdX0byO+2lnORkqcEuBVGZozwtCR8CdEi5I3UR
 5hsP6q+KDi/ducnvYgPQzLHt5cAbsccGFd3cMdg8IWhu832Ho9+KVpueHA8P+Q7AHQhn
 VCKc+P8QdGKINzs6uTjhgJzJ3+wswWioQOjOJ9HuaS2P6xBwjEfcPQkK20r2uVx3vHpU
 GQy8S5/uHkqxXWWwy+iY/8nJi7lwH6CHMfp3XKqBxSdt4yfQ3gfd9wCx81UIZsed2Shv
 FOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BMREvoHjj8f1EBfCvu7SAC5TIkS0aPkGQG5Rh07Q5oA=;
 b=UFASN2Gir06Flbzr5IRyaw43hNdBKmjnGehOJIxXboo9iCbryc8xloOT3v256mCf/O
 0O6PiMumt9cTw06k/FFlngdoBk80KpvJsoyZuRbgr7g4ovcHlbS00SbbWvzFplLIKK7j
 Zpc6vTwxufsmLB34XM/poKrwtv9lll8bWRiVGVdJ3S4EmxTmyUzwNf4M5Co/LfzZ2+Bo
 G2qx2ybgMqOmPqna4TUuD5GiD8iunSydSRADvLIKf/e7Nid60SxgwASYwLHzwrSbvCi3
 AJ/C3hs96EqyG7bQ7Z9xmjtADGB5kVZ5h/biRx40uifdilrk0Dz8iCt99RDeQclpdCHa
 rwRQ==
X-Gm-Message-State: AOAM532abnHYIjtxnH2JG7PlV3yzgL0g5xQW1mx/EVJS7DLFZrlVmErA
 lDBTSUSleeJOxkF9rN0y4Cj2+q3Pb5No4Q==
X-Google-Smtp-Source: ABdhPJyTA5E48G9Gtzgz7uhxJQ4tOK5DlLrwOwU7Nixp7+OkfE7N4CrTN3t4sq8b7rkw8xmnNF6ttw==
X-Received: by 2002:a63:fe06:: with SMTP id p6mr926551pgh.337.1599610649495;
 Tue, 08 Sep 2020 17:17:29 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/43] tcg/ppc: Use tcg_constant_vec with tcg vec expanders
Date: Tue,  8 Sep 2020 17:16:36 -0700
Message-Id: <20200909001647.532249-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improve expand_vec_shi to use sign-extraction for MO_32.
This allows a single VSPLTISB instruction to load all of
the valid shift constants.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 44 ++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 3d23a6b226..155c42ed24 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3332,13 +3332,22 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 static void expand_vec_shi(TCGType type, unsigned vece, TCGv_vec v0,
                            TCGv_vec v1, TCGArg imm, TCGOpcode opci)
 {
-    TCGv_vec t1 = tcg_temp_new_vec(type);
+    TCGv_vec t1;
 
-    /* Splat w/bytes for xxspltib.  */
-    tcg_gen_dupi_vec(MO_8, t1, imm & ((8 << vece) - 1));
+    if (vece == MO_32) {
+        /*
+         * Only 5 bits are significant, and VSPLTISB can represent -16..15.
+         * So using negative numbers gets us the 4th bit easily.
+         */
+        imm = sextract32(imm, 0, 5);
+    } else {
+        imm &= (8 << vece) - 1;
+    }
+
+    /* Splat w/bytes for xxspltib when 2.07 allows MO_64. */
+    t1 = tcg_constant_vec(type, MO_8, imm);
     vec_gen_3(opci, type, vece, tcgv_vec_arg(v0),
               tcgv_vec_arg(v1), tcgv_vec_arg(t1));
-    tcg_temp_free_vec(t1);
 }
 
 static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
@@ -3396,7 +3405,7 @@ static void expand_vec_mul(TCGType type, unsigned vece, TCGv_vec v0,
 {
     TCGv_vec t1 = tcg_temp_new_vec(type);
     TCGv_vec t2 = tcg_temp_new_vec(type);
-    TCGv_vec t3, t4;
+    TCGv_vec c0, c16;
 
     switch (vece) {
     case MO_8:
@@ -3415,21 +3424,22 @@ static void expand_vec_mul(TCGType type, unsigned vece, TCGv_vec v0,
 
     case MO_32:
         tcg_debug_assert(!have_isa_2_07);
-        t3 = tcg_temp_new_vec(type);
-        t4 = tcg_temp_new_vec(type);
-        tcg_gen_dupi_vec(MO_8, t4, -16);
+        /*
+         * Only 5 bits are significant, and VSPLTISB can represent -16..15.
+         * So using -16 is a quick way to represent 16.
+         */
+        c16 = tcg_constant_vec(type, MO_8, -16);
+        c0 = tcg_constant_vec(type, MO_8, 0);
+
         vec_gen_3(INDEX_op_rotlv_vec, type, MO_32, tcgv_vec_arg(t1),
-                  tcgv_vec_arg(v2), tcgv_vec_arg(t4));
+                  tcgv_vec_arg(v2), tcgv_vec_arg(c16));
         vec_gen_3(INDEX_op_ppc_mulou_vec, type, MO_16, tcgv_vec_arg(t2),
                   tcgv_vec_arg(v1), tcgv_vec_arg(v2));
-        tcg_gen_dupi_vec(MO_8, t3, 0);
-        vec_gen_4(INDEX_op_ppc_msum_vec, type, MO_16, tcgv_vec_arg(t3),
-                  tcgv_vec_arg(v1), tcgv_vec_arg(t1), tcgv_vec_arg(t3));
-        vec_gen_3(INDEX_op_shlv_vec, type, MO_32, tcgv_vec_arg(t3),
-                  tcgv_vec_arg(t3), tcgv_vec_arg(t4));
-        tcg_gen_add_vec(MO_32, v0, t2, t3);
-        tcg_temp_free_vec(t3);
-        tcg_temp_free_vec(t4);
+        vec_gen_4(INDEX_op_ppc_msum_vec, type, MO_16, tcgv_vec_arg(t1),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(t1), tcgv_vec_arg(c0));
+        vec_gen_3(INDEX_op_shlv_vec, type, MO_32, tcgv_vec_arg(t1),
+                  tcgv_vec_arg(t1), tcgv_vec_arg(c16));
+        tcg_gen_add_vec(MO_32, v0, t1, t2);
         break;
 
     default:
-- 
2.25.1


