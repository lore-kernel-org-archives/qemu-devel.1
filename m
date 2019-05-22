Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D07CC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64F020881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUBBJxmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64F020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52631 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZt9-0002Ok-1y
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:39:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZj4-00039v-J4
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZj3-0007RF-FV
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:46 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:41249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZiz-0007Mp-Np
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:43 -0400
Received: by mail-yw1-xc43.google.com with SMTP id o65so1483056ywd.8
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=OLftcOa71o3SDWkHEvzuYmmBM81jvFAhtQKjy7MXc3g=;
	b=uUBBJxmvsqRHbMy8XSdo6r5vF5HvwD48/t4WfqRF0g2PV7vA2RF2BKGARd+3PLeRAD
	4JzeUXHypr+jbcec2ca4yxa9VNCu5NrZJSk2IVbYNLTCPi++5yE3D4//d+BrlaSM312+
	UhdqRWPIH1Rwa1T1OkhEO9t6NLetYVY592p5CCgJPGnnO4hJIXdPXK2SUvM4DwvXLarz
	fOo8dNksT6NFut81D5N066dGNKvIX0C7XtZrzcjMPj+0/2WcYDb6QLKZUJ+mBKHKjqE/
	xpSdFH4i9YjNep2b6ZBLIcvaOr4ObusdfgLDPraa3rJiHAKJd3DXrZtgCpRR4Ukfhitc
	fR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=OLftcOa71o3SDWkHEvzuYmmBM81jvFAhtQKjy7MXc3g=;
	b=a0aYa6NUUGd0R3UFPkL96JlYEeiyFB3WD/RftvXgX5aD1zj+AMiDBvLtYpikhWmwL9
	L0RcWWi8UeQ3Tmu1KOx+ixhLGDqwOYaZPJljmgj/1cR7al8aCTDRc/MSTWTmzdZeruli
	rWCT9NcYKRex5nrii/opib1oGnHbuGhG5yCKl3ei5YgyUzJrNzL/otQ8IBR+I4t8DADn
	58mL6WtCtX8XBTEgZ8eVP3QZ88bUnCSkqbM/27yrUHrx1V60ROfeHRCxahUzwXN23mzY
	mfAc5JzSCtqNe2+2YhiHfT6URD4bqO4Z0TTFi+8MGsdRPb0t8/fVJpHF9JSSobLXkWWe
	hAww==
X-Gm-Message-State: APjAAAW6la42w027q2Fb1rRNs0/IZITvWh8P6ljNyOGaJxfl1mW3+yWe
	Dd15Wg7rBbKUkt9+JrKXEg3O5AO0JH4=
X-Google-Smtp-Source: APXvYqwnVFFk/LIWzXbUfC7yy1mlo6A/35o/Gp3RT3FWqk39mZGfGHgAToBjGJJ09PBp8fJrcpFw6g==
X-Received: by 2002:a0d:ea4c:: with SMTP id t73mr42896537ywe.472.1558564114807;
	Wed, 22 May 2019 15:28:34 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:15 -0400
Message-Id: <20190522222821.23850-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [PULL 10/16] tcg/i386: Use umin/umax in expanding
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
Cc: peter.maydell@linaro.org
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


