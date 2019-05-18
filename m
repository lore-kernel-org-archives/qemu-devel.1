Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52D4C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A240920873
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/RQnUV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A240920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37679 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4kU-0000qe-QR
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:12:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4dP-0002lS-9E
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4b1-0002i6-JQ
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:17 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4b0-0002hS-Bm
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:14 -0400
Received: by mail-pf1-x443.google.com with SMTP id n19so5269639pfa.1
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=OLftcOa71o3SDWkHEvzuYmmBM81jvFAhtQKjy7MXc3g=;
	b=p/RQnUV5OvLoa08tg1eiYyRAFDHUcJ9wsisxXqmYbKQxz3Ro3VtXEpwq92DYEnyjFa
	0jC1GTaD8xdDI4CHDwDqhPLwjBQsNtoHF7DLz8vQYRmIBbw7j9zTTCZnJODd/rOnc+Ea
	0DPub1POc9Ie7g4+FC2130BiQU3skP845wCYJjxxlrP+ZuvMYQ01U2iFfTpVw4xuaX+8
	pHOJXgW87ZF/vzTu5utNFA13disk+Y9Pg5ZCZ9UnTzJgnKkVyG+O/trZW/CmIiQVGBKs
	yr8FdfbDo5teXICWo4PzsgP+sOzco3YmWzFl8mQQvcKDxdQtFjkT2IpZ6+7kdJyVGNeU
	t1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=OLftcOa71o3SDWkHEvzuYmmBM81jvFAhtQKjy7MXc3g=;
	b=RaYm79eS00mTizjqjJ3Ppz8Yl2pKLbluum6jGsSyS2B5dJN/yr59zXw85x3cBnN8/I
	gqBVdoYr+qglHD5pt7chAVrA6hfo6SfKpe/5RyggBQCiU7ZsNFKe8yHlACTGxVBAjmG9
	uko3ExSx4B0KZBuylj0TqjO9pSaqfZATB4/Ih8qIdWq9qjscIs3IQuzKkClfFEkJ7Uh8
	C5Kptd6dnurFsYDtqs2A0s8rfAe3bpYiwHeqA4Z/f3qSmN/7SIaEFYMyiIl7MIYuJEa7
	yqn5m9mz3t2sjrhu3heDMWUPXmFQJeGWTmGNbB1K44j4umgz8Wkx4kGST5nEPvynF5PT
	XtAQ==
X-Gm-Message-State: APjAAAUj1cNrLKfNq1oYg2BC87/2GFqjC/WT8csLIPn0IZFLiHgMD5Tv
	P8SmFVHUdalvPEcf7tDSOYeJGOIf1HE=
X-Google-Smtp-Source: APXvYqwN2HnM/CD1gHQM9OWHU6RDZyAGSTuy6UVEcbbghCyN1Nxj8Ifoh2wcL000x8fq6M3344P26g==
X-Received: by 2002:a63:1c4:: with SMTP id 187mr38120757pgb.317.1558206133167; 
	Sat, 18 May 2019 12:02:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m9sm2751274pgd.23.2019.05.18.12.02.11
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:02:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:01:51 -0700
Message-Id: <20190518190157.21255-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518190157.21255-1-richard.henderson@linaro.org>
References: <20190518190157.21255-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 10/16] tcg/i386: Use umin/umax in expanding
 unsigned compare
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

Using umin(a, b) == a as an expansion for TCG_COND_LEU is a
better alternative to (a - INT_MIN) <= (b - INT_MIN).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 80 +++++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 19 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 569a2c2120..6ec5e60448 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3468,28 +3468,61 @@ static bool expand_vec_cmp_noinv(TCGType type, unsigned vece, TCGv_vec v0,
                                  TCGv_vec v1, TCGv_vec v2, TCGCond cond)
 {
     enum {
-        NEED_SWAP = 1,
-        NEED_INV  = 2,
-        NEED_BIAS = 4
-    };
-    static const uint8_t fixups[16] = {
-        [0 ... 15] = -1,
-        [TCG_COND_EQ] = 0,
-        [TCG_COND_NE] = NEED_INV,
-        [TCG_COND_GT] = 0,
-        [TCG_COND_LT] = NEED_SWAP,
-        [TCG_COND_LE] = NEED_INV,
-        [TCG_COND_GE] = NEED_SWAP | NEED_INV,
-        [TCG_COND_GTU] = NEED_BIAS,
-        [TCG_COND_LTU] = NEED_BIAS | NEED_SWAP,
-        [TCG_COND_LEU] = NEED_BIAS | NEED_INV,
-        [TCG_COND_GEU] = NEED_BIAS | NEED_SWAP | NEED_INV,
+        NEED_INV  = 1,
+        NEED_SWAP = 2,
+        NEED_BIAS = 4,
+        NEED_UMIN = 8,
+        NEED_UMAX = 16,
     };
     TCGv_vec t1, t2;
     uint8_t fixup;
 
-    fixup = fixups[cond & 15];
-    tcg_debug_assert(fixup != 0xff);
+    switch (cond) {
+    case TCG_COND_EQ:
+    case TCG_COND_GT:
+        fixup = 0;
+        break;
+    case TCG_COND_NE:
+    case TCG_COND_LE:
+        fixup = NEED_INV;
+        break;
+    case TCG_COND_LT:
+        fixup = NEED_SWAP;
+        break;
+    case TCG_COND_GE:
+        fixup = NEED_SWAP | NEED_INV;
+        break;
+    case TCG_COND_LEU:
+        if (vece <= MO_32) {
+            fixup = NEED_UMIN;
+        } else {
+            fixup = NEED_BIAS | NEED_INV;
+        }
+        break;
+    case TCG_COND_GTU:
+        if (vece <= MO_32) {
+            fixup = NEED_UMIN | NEED_INV;
+        } else {
+            fixup = NEED_BIAS;
+        }
+        break;
+    case TCG_COND_GEU:
+        if (vece <= MO_32) {
+            fixup = NEED_UMAX;
+        } else {
+            fixup = NEED_BIAS | NEED_SWAP | NEED_INV;
+        }
+        break;
+    case TCG_COND_LTU:
+        if (vece <= MO_32) {
+            fixup = NEED_UMAX | NEED_INV;
+        } else {
+            fixup = NEED_BIAS | NEED_SWAP;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
 
     if (fixup & NEED_INV) {
         cond = tcg_invert_cond(cond);
@@ -3500,7 +3533,16 @@ static bool expand_vec_cmp_noinv(TCGType type, unsigned vece, TCGv_vec v0,
     }
 
     t1 = t2 = NULL;
-    if (fixup & NEED_BIAS) {
+    if (fixup & (NEED_UMIN | NEED_UMAX)) {
+        t1 = tcg_temp_new_vec(type);
+        if (fixup & NEED_UMIN) {
+            tcg_gen_umin_vec(vece, t1, v1, v2);
+        } else {
+            tcg_gen_umax_vec(vece, t1, v1, v2);
+        }
+        v2 = t1;
+        cond = TCG_COND_EQ;
+    } else if (fixup & NEED_BIAS) {
         t1 = tcg_temp_new_vec(type);
         t2 = tcg_temp_new_vec(type);
         tcg_gen_dupi_vec(vece, t2, 1ull << ((8 << vece) - 1));
-- 
2.17.1


