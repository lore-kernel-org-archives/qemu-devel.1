Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDDEC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816F220873
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUb+JdKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816F220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37699 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4mt-0002rb-Pw
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:14:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4dQ-0002nw-9C
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4ay-0002f7-5U
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:13 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4ax-0002eY-VV
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:12 -0400
Received: by mail-pg1-x544.google.com with SMTP id z16so4815766pgv.11
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=oLTml3dhbqYDrgc3cYARBzaQje8i0Sq1y8nx8+B4Ie0=;
	b=QUb+JdKu7HycWq6KHVSmcsoDLZAe0PKy9uka/+4fuiVEGnZ1gwdncxTek2/SJeOIp3
	S9LoBlyeOv03b3g/kfwPeIH4m2CblmSImdsXxML7iqBht/lIywQW7PywXOaYEKnOQSv6
	n5oxxv2PAcJhGmG2Bl0YuYRKlQMTVYDKK2UXlVKBa1XdkTRX4fcY2hXcGyHTb0sQfKMH
	ZnueaCi5HytAtTwLJtui8UULppJas8sOrOzVSeSAoGfDL1D8GCDE9mjqdyt5gqnnUgz6
	rAOlPxQ3CM2/1AnVWPUGu+c095CCZUHC7hBd7IF3gSxNqEYOZ63s+5N8plq4BGVAnEBz
	kXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=oLTml3dhbqYDrgc3cYARBzaQje8i0Sq1y8nx8+B4Ie0=;
	b=s9WCZyFGiqgB/rSHwJPAydbQytMmJBJxVRJNMIz6fVXiFV6L03qFxAud0xjqrXvvpV
	+zvsv6XwUlceE8/mAnu5JRwtRMvFvrgloYs+9bP6xYLjtY+BDKAPOrKRgo35QIrkBSce
	i4lcu94r97mslXg1UKvbtrBOTi0v1ecmjGXPEpHxkvV2OpQ3qAK1PXPjaUjiWcscnTW/
	31vyME+oSrR5ApiEcId7XILowWOlqENTvv5pzdajNCb3WQt5tRINs5dS9m5ZwiAzdtmt
	RLe7QsK3V1V5gFubhxBUn/Q0UUFPUZeLohpmoqbnHhiDrSS1yhSZHoDOtOZIb5quXIOM
	+BPA==
X-Gm-Message-State: APjAAAXrzrChkxTmEH0llztaXG6pL6d001uVSggadkPsscQwE4C13UJU
	/CvN+16NAXnhp1xWw9o4bWTVM+b27c4=
X-Google-Smtp-Source: APXvYqytMY3WREBZsvIqM1b6GOl40B91MH/iA0JIHGna84ZBipoZHeCQP3FUUI/9uNa+DBad4dpQFg==
X-Received: by 2002:a63:6f0b:: with SMTP id k11mr64449614pgc.342.1558206130808;
	Sat, 18 May 2019 12:02:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m9sm2751274pgd.23.2019.05.18.12.02.09
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:02:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:01:49 -0700
Message-Id: <20190518190157.21255-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518190157.21255-1-richard.henderson@linaro.org>
References: <20190518190157.21255-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 08/16] tcg/i386: Support vector comparison
 select value
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

We already had backend support for this feature.  Expand the new
cmpsel opcode using vpblendb.  The combination allows us to avoid
an extra NOT for some comparison codes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.inc.c | 39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 16a83a7f7b..928e8b87bb 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -191,7 +191,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
-#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       -1
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index b3601446cd..ffcafb1e14 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3246,6 +3246,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_andc_vec:
         return 1;
     case INDEX_op_cmp_vec:
+    case INDEX_op_cmpsel_vec:
         return -1;
 
     case INDEX_op_shli_vec:
@@ -3464,8 +3465,8 @@ static void expand_vec_mul(TCGType type, unsigned vece,
     }
 }
 
-static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
-                           TCGv_vec v1, TCGv_vec v2, TCGCond cond)
+static bool expand_vec_cmp_noinv(TCGType type, unsigned vece, TCGv_vec v0,
+                                 TCGv_vec v1, TCGv_vec v2, TCGCond cond)
 {
     enum {
         NEED_SWAP = 1,
@@ -3522,11 +3523,34 @@ static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
             tcg_temp_free_vec(t2);
         }
     }
-    if (fixup & NEED_INV) {
+    return fixup & NEED_INV;
+}
+
+static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
+                           TCGv_vec v1, TCGv_vec v2, TCGCond cond)
+{
+    if (expand_vec_cmp_noinv(type, vece, v0, v1, v2, cond)) {
         tcg_gen_not_vec(vece, v0, v0);
     }
 }
 
+static void expand_vec_cmpsel(TCGType type, unsigned vece, TCGv_vec v0,
+                              TCGv_vec c1, TCGv_vec c2,
+                              TCGv_vec v3, TCGv_vec v4, TCGCond cond)
+{
+    TCGv_vec t = tcg_temp_new_vec(type);
+
+    if (expand_vec_cmp_noinv(type, vece, t, c1, c2, cond)) {
+        /* Invert the sense of the compare by swapping arguments.  */
+        TCGv_vec x;
+        x = v3, v3 = v4, v4 = x;
+    }
+    vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, vece,
+              tcgv_vec_arg(v0), tcgv_vec_arg(v4),
+              tcgv_vec_arg(v3), tcgv_vec_arg(t));
+    tcg_temp_free_vec(t);
+}
+
 static void expand_vec_minmax(TCGType type, unsigned vece,
                               TCGCond cond, bool min,
                               TCGv_vec v0, TCGv_vec v1, TCGv_vec v2)
@@ -3551,7 +3575,7 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 {
     va_list va;
     TCGArg a2;
-    TCGv_vec v0, v1, v2;
+    TCGv_vec v0, v1, v2, v3, v4;
 
     va_start(va, a0);
     v0 = temp_tcgv_vec(arg_temp(a0));
@@ -3578,6 +3602,13 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
         expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
         break;
 
+    case INDEX_op_cmpsel_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        v3 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+        v4 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+        expand_vec_cmpsel(type, vece, v0, v1, v2, v3, v4, va_arg(va, TCGArg));
+        break;
+
     case INDEX_op_smin_vec:
         v2 = temp_tcgv_vec(arg_temp(a2));
         expand_vec_minmax(type, vece, TCG_COND_GT, true, v0, v1, v2);
-- 
2.17.1


