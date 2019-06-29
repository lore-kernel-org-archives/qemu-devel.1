Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEB5C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824482054F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="puWa1sT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824482054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhDDt-0004hf-LH
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 09:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41294)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCyC-0007zS-3h
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy9-0003d5-9u
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:34310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhCy8-0003Ly-ND
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id w9so11100919wmd.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8c5PWY3kLWS20dN1HlPj3Yx2DCSMVh04T/gD6RTE3Dk=;
 b=puWa1sT5b2YYTerF5BXKmUC7LsmrdDQajpPA1R3JeWaare6MsGo4mx9ATWIMDIlVbu
 AhPmav82cEtS+1bC8Bxh2KsEnOReTw40Pt0m4lLVPflYs51WpP6CN3NJrhpyUSEEWzdo
 R9u9vTF4CxcMn0/50Of93UyBquc5bHBrVSvp9BBlE0qfM264f4NCmL30pqJTjUne0zlW
 LTDdIIw5mEGiaPvSR9D8kSoDqJPy/soPnP/6pRtxQHQSmhZQOYn8mbXHvtRr1An/S97S
 Nxoo+TBsMSCt2F6VvlrCI2S5MxpqQJoIvBzMMWwZ+ykLltwi4s2iedgfmeyOaBFYFpGt
 DekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8c5PWY3kLWS20dN1HlPj3Yx2DCSMVh04T/gD6RTE3Dk=;
 b=hl/U1Z3r5D5/NxiWRY1fkrLcEVwHF1TK3j0hvHSdzxoEv18dFauvAxn3lXKfHhzVak
 JN2fG7AFwyv/CP9xv0cOCoeJx12wkadqDV3Mt5ZN3nCDCvekvTPVbTdZJVSe7Edljkc0
 MqW/a80X60Duo8lTE6BkB3eU22goA1buy4NKRaHROk2AMjJtFMQyNDL4gWFJF2W44G8I
 X2DgizpY3dpD0AZKEdkEIvCNtcyK4hgiZEhQMBw+cRn0DULM2VzOIjzy3uzZD95oDPI3
 A+p2HNHzifqRRkGVTUL00TJEnSVOKtmBNpItSvxT2BhQ6Z6eVD/pVIAUet2DLc6pWmsH
 a5VQ==
X-Gm-Message-State: APjAAAX3sZgl5TWz3WTjn6Sk1z0eO1EM+wl1/AYwp2rtXofkkHnmI9xq
 xgua+RMDDsH+SfdTw89uf5VastuA0l2bmQ==
X-Google-Smtp-Source: APXvYqzY9XZfmw7mya38u39yL+A2HJoQI9x/jc4jJhJPnUYY3Ua0Hnrzxvcx1fckkHWN0BcAU87PJA==
X-Received: by 2002:a1c:7408:: with SMTP id p8mr10151054wmc.161.1561813225100; 
 Sat, 29 Jun 2019 06:00:25 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id d10sm4937676wro.18.2019.06.29.06.00.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 06:00:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 15:00:07 +0200
Message-Id: <20190629130017.2973-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629130017.2973-1-richard.henderson@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PATCH v6 06/16] tcg/ppc: Add support for vector
 maximum/minimum
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

Add support for vector maximum/minimum using Altivec instructions
VMAXSB, VMAXSH, VMAXSW, VMAXUB, VMAXUH, VMAXUW, and
VMINSB, VMINSH, VMINSW, VMINUB, VMINUH, VMINUW.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     |  2 +-
 tcg/ppc/tcg-target.inc.c | 40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index b66a808259..a86ed57303 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -156,7 +156,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          0
 #define TCG_TARGET_HAS_sat_vec          0
-#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 87c418ebf4..9c5630dc8a 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -474,6 +474,19 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define STVX       XO31(231)
 #define STVEWX     XO31(199)
 
+#define VMAXSB     VX4(258)
+#define VMAXSH     VX4(322)
+#define VMAXSW     VX4(386)
+#define VMAXUB     VX4(2)
+#define VMAXUH     VX4(66)
+#define VMAXUW     VX4(130)
+#define VMINSB     VX4(770)
+#define VMINSH     VX4(834)
+#define VMINSW     VX4(898)
+#define VMINUB     VX4(514)
+#define VMINUH     VX4(578)
+#define VMINUW     VX4(642)
+
 #define VCMPEQUB   VX4(6)
 #define VCMPEQUH   VX4(70)
 #define VCMPEQUW   VX4(134)
@@ -2820,6 +2833,11 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_andc_vec:
     case INDEX_op_not_vec:
         return 1;
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
+        return vece <= MO_32;
     case INDEX_op_cmp_vec:
         return vece <= MO_32 ? -1 : 0;
     default:
@@ -2917,7 +2935,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const uint32_t
         eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, 0 },
         gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, 0 },
-        gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, 0 };
+        gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, 0 },
+        umin_op[4] = { VMINUB, VMINUH, VMINUW, 0 },
+        smin_op[4] = { VMINSB, VMINSH, VMINSW, 0 },
+        umax_op[4] = { VMAXUB, VMAXUH, VMAXUW, 0 },
+        smax_op[4] = { VMAXSB, VMAXSH, VMAXSW, 0 };
 
     TCGType type = vecl + TCG_TYPE_V64;
     TCGArg a0 = args[0], a1 = args[1], a2 = args[2];
@@ -2934,6 +2956,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         return;
 
+    case INDEX_op_smin_vec:
+        insn = smin_op[vece];
+        break;
+    case INDEX_op_umin_vec:
+        insn = umin_op[vece];
+        break;
+    case INDEX_op_smax_vec:
+        insn = smax_op[vece];
+        break;
+    case INDEX_op_umax_vec:
+        insn = umax_op[vece];
+        break;
     case INDEX_op_and_vec:
         insn = VAND;
         break;
@@ -3226,6 +3260,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_andc_vec:
     case INDEX_op_orc_vec:
     case INDEX_op_cmp_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
         return &v_v_v;
     case INDEX_op_not_vec:
     case INDEX_op_dup_vec:
-- 
2.17.1


