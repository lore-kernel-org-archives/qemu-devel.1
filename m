Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5609C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9FE22500
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mieC1GDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9FE22500
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2Zh-0003C8-5i
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2BC-00050M-43
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2BA-0005pW-SF
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:57 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2BA-0005p9-MX
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:56 -0400
Received: by mail-pf1-x443.google.com with SMTP id h195so6232119pfe.5
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BGOdnUQ7n88wshKpceGoTB4ILfGRgsQjpAICNmjMH9Y=;
 b=mieC1GDejv/UZEP3ApfvREDw5Bmg/f7WChqK9wp2Dqhm/fSkuwefySH+bVl1dIpvT7
 5jeHSy5LNuxd1R24thDVO8ukY3Bjui5XYXduOATSrCCv5SPOqMyDOe7sokYlj1OLDlnw
 V+q2HJWQziD90WnGhdC79KxhizabEnUm2wK6BKbThWpYNdnm5QsZrjDmnHHD9NMThMYj
 UzlKsCybinoq5vDiH2TAx7q9VUlKYsGWl2Nn3UZssJsrOz4+TpxAb97T9XXDRmA1SIJq
 e3CK3RRZaUGgI7dBk8WybvIVVT1EM+Ehu7kpScgYcYxDynIpenG8l9gpyJqK3BOw4AjZ
 fSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BGOdnUQ7n88wshKpceGoTB4ILfGRgsQjpAICNmjMH9Y=;
 b=a8C62K5Z3qA0uS4xtTUzTS9xu4XM1jZuSmkyUOwaXJflk+b97tPFIpgFlku3hoYnB5
 w0wuVxwgT3RrydthGKHoCShtuJtudvhOlMrMVNhlyrP+IA89uxWCXD3b9nNULh98oqQq
 iPgQJWms+jNONHwBgMYnBtpQtVLz4BvQNtXpslp9Oo9uLsHRVxjRhCmXFFj8kxr1vldt
 AxEXwiD3VO/FQGt/G5yQ5fE9lPL3sfz8QuP+PzsRUuRNCJTAv5rtSO/JtzgG12VOedsI
 XbXZh0in7w9do30T1+nKpllo1gmL7TnbRET15toCW6pG8KCAMLYTELegLvq70LbSVPEB
 4Hkw==
X-Gm-Message-State: APjAAAUcsdODnH8CUgm+NWVJTSKaRYGdiLvMzoVr7auy9WrId6We69y7
 hb+uyOhbsRnYhG0wF53Q4xnJFMp2sxg=
X-Google-Smtp-Source: APXvYqyao1mwnDBuz0kXimarnkqAgAAxi0vvirb8CZmni874A1EQOv5NakBFwC4FGZZmg41BBBl1Rw==
X-Received: by 2002:a17:90a:2687:: with SMTP id
 m7mr1135371pje.25.1569874915433; 
 Mon, 30 Sep 2019 13:21:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 22/22] tcg/ppc: Update vector support for v3.00 dup/dupi
Date: Mon, 30 Sep 2019 13:21:25 -0700
Message-Id: <20190930202125.21064-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These new instructions are conditional on MSR.VEC for TX=1,
so we can consider these Altivec instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 5b7d1bd2dc..d308d69aba 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -596,11 +596,14 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 
 #define XXPERMDI   (OPCD(60) | (10 << 3) | 7)  /* v2.06, force ax=bx=tx=1 */
 #define XXSEL      (OPCD(60) | (3 << 4) | 0xf) /* v2.06, force ax=bx=cx=tx=1 */
+#define XXSPLTIB   (OPCD(60) | (360 << 1) | 1) /* v3.00, force tx=1 */
 
 #define MFVSRD     (XO31(51) | 1)   /* v2.07, force sx=1 */
 #define MFVSRWZ    (XO31(115) | 1)  /* v2.07, force sx=1 */
 #define MTVSRD     (XO31(179) | 1)  /* v2.07, force tx=1 */
 #define MTVSRWZ    (XO31(243) | 1)  /* v2.07, force tx=1 */
+#define MTVSRDD    (XO31(435) | 1)  /* v3.00, force tx=1 */
+#define MTVSRWS    (XO31(403) | 1)  /* v3.00, force tx=1 */
 
 #define RT(r) ((r)<<21)
 #define RS(r) ((r)<<21)
@@ -931,6 +934,10 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
             return;
         }
     }
+    if (have_isa_3_00 && val == (tcg_target_long)dup_const(MO_8, val)) {
+        tcg_out32(s, XXSPLTIB | VRT(ret) | ((val & 0xff) << 11));
+        return;
+    }
 
     /*
      * Otherwise we must load the value from the constant pool.
@@ -3021,7 +3028,22 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src)
 {
     tcg_debug_assert(dst >= TCG_REG_V0);
-    tcg_debug_assert(src >= TCG_REG_V0);
+
+    /* Splat from integer reg allowed via constraints for v3.00.  */
+    if (src < TCG_REG_V0) {
+        tcg_debug_assert(have_isa_3_00);
+        switch (vece) {
+        case MO_64:
+            tcg_out32(s, MTVSRDD | VRT(dst) | RA(src) | RB(src));
+            return true;
+        case MO_32:
+            tcg_out32(s, MTVSRWS | VRT(dst) | RA(src));
+            return true;
+        default:
+            /* Fail, so that we fall back on either dupm or mov+dup.  */
+            return false;
+        }
+    }
 
     /*
      * Recall we use (or emulate) VSX integer loads, so the integer is
@@ -3482,6 +3504,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef sub2
         = { .args_ct_str = { "r", "r", "rI", "rZM", "r", "r" } };
     static const TCGTargetOpDef v_r = { .args_ct_str = { "v", "r" } };
+    static const TCGTargetOpDef v_vr = { .args_ct_str = { "v", "vr" } };
     static const TCGTargetOpDef v_v = { .args_ct_str = { "v", "v" } };
     static const TCGTargetOpDef v_v_v = { .args_ct_str = { "v", "v", "v" } };
     static const TCGTargetOpDef v_v_v_v
@@ -3651,8 +3674,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &v_v_v;
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
-    case INDEX_op_dup_vec:
         return &v_v;
+    case INDEX_op_dup_vec:
+        return have_isa_3_00 ? &v_vr : &v_v;
     case INDEX_op_ld_vec:
     case INDEX_op_st_vec:
     case INDEX_op_dupm_vec:
-- 
2.17.1


