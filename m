Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DE9C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A51E2054F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dzD7hcQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A51E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhDAm-0000mV-NY
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 09:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41346)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCyE-0007zf-A8
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy9-0003ei-QK
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:44 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:33229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhCy9-0003QA-D8
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id h19so11120454wme.0
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=871nlNIrerWA7xXH+sKAPLsVP79x4GHg+G0XuAdLS1c=;
 b=dzD7hcQ59w+bVuGhv+JD9NkbfOceut6a6tRrAbUucc1FZyZ3ZeQLghH8SWByXLCAxy
 QFIA2Nsf+LzejVo20Rk9m7+RSdwh/KdXOjnR7FYPm7csWCQBqQIYnSB3PIsmDOQJyDge
 uMJYFtoQf0pgg3cJTyINJYcMFJhG/+6ylG7lV8bVdZvMqraMYuYnJeM05prdNxRVB/0D
 gS5R6/u6onZ90U/yCkcgaxpjvWHui1/1JQfJOCMShR1BGGJcX0hHJTPRFn4riGecsnB4
 yYXNFmA1YtBnoXUD9O7HZuXnhhaGl0NGFZa3MH3c2eJf6WFEIPllSXwbDV3Q2Ghq/NMB
 dLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=871nlNIrerWA7xXH+sKAPLsVP79x4GHg+G0XuAdLS1c=;
 b=Zjr8iS5NRPNipzPylO9aJCauhIVHAdec3OBKwC3WdOlwWuwZgK1PmQyNuQdubHIXYO
 iDxVa1YBh3CGe6JSW+a1OrGqP+u2MmvUzubt0FnbAc/dQkutzgO4MaR7mfzRaWDP04Uq
 dlHe7LwGrYZRMw5uuX7VtL2KWly677MlqclN/cshj7fyGsTIhBp0e4SKXZxhEEA6EI+2
 5qvT/k2RYqiK1mvW1oLH/rO2H6adhF9Hwv1oafFEtJWyv7bGSok6EDPLBvhpvlUga7es
 tsyjKFhFabWdfhrI2G94jS8fEGXLYbxqzS51+H8sdRg7ni6DGuoOMdOjK6aer2nu6RwL
 CJSA==
X-Gm-Message-State: APjAAAXu3Y10JMo/ssjvngs/VILa9UEbyEmUfaJfWGvMAvEr/j26DrJ3
 Jr0anNrZuTSGowFe/J8YjCzSCxYEHFsjtg==
X-Google-Smtp-Source: APXvYqxfL+G+1UkFwpX25/spjauRFgYQcBGreVkSQirPNTAbH2wr9dVj996T+bTpqySteJsAFBokiQ==
X-Received: by 2002:a1c:3886:: with SMTP id
 f128mr10548202wma.151.1561813227301; 
 Sat, 29 Jun 2019 06:00:27 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id d10sm4937676wro.18.2019.06.29.06.00.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 06:00:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 15:00:09 +0200
Message-Id: <20190629130017.2973-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629130017.2973-1-richard.henderson@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PATCH v6 08/16] tcg/ppc: Add support for vector
 saturated add/subtract
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

Add support for vector saturated add/subtract using Altivec
instructions:
VADDSBS, VADDSHS, VADDSWS, VADDUBS, VADDUHS, VADDUWS, and
VSUBSBS, VSUBSHS, VSUBSWS, VSUBUBS, VSUBUHS, VSUBUWS.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     |  2 +-
 tcg/ppc/tcg-target.inc.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index a86ed57303..368c250c6a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -155,7 +155,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          0
-#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       0
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index c31694cc78..307e809fad 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -474,12 +474,24 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define STVX       XO31(231)
 #define STVEWX     XO31(199)
 
+#define VADDSBS    VX4(768)
+#define VADDUBS    VX4(512)
 #define VADDUBM    VX4(0)
+#define VADDSHS    VX4(832)
+#define VADDUHS    VX4(576)
 #define VADDUHM    VX4(64)
+#define VADDSWS    VX4(896)
+#define VADDUWS    VX4(640)
 #define VADDUWM    VX4(128)
 
+#define VSUBSBS    VX4(1792)
+#define VSUBUBS    VX4(1536)
 #define VSUBUBM    VX4(1024)
+#define VSUBSHS    VX4(1856)
+#define VSUBUHS    VX4(1600)
 #define VSUBUHM    VX4(1088)
+#define VSUBSWS    VX4(1920)
+#define VSUBUWS    VX4(1664)
 #define VSUBUWM    VX4(1152)
 
 #define VMAXSB     VX4(258)
@@ -2847,6 +2859,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
     case INDEX_op_umin_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
         return vece <= MO_32;
     case INDEX_op_cmp_vec:
         return vece <= MO_32 ? -1 : 0;
@@ -2948,6 +2964,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, 0 },
         gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, 0 },
         gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, 0 },
+        ssadd_op[4] = { VADDSBS, VADDSHS, VADDSWS, 0 },
+        usadd_op[4] = { VADDUBS, VADDUHS, VADDUWS, 0 },
+        sssub_op[4] = { VSUBSBS, VSUBSHS, VSUBSWS, 0 },
+        ussub_op[4] = { VSUBUBS, VSUBUHS, VSUBUWS, 0 },
         umin_op[4] = { VMINUB, VMINUH, VMINUW, 0 },
         smin_op[4] = { VMINSB, VMINSH, VMINSW, 0 },
         umax_op[4] = { VMAXUB, VMAXUH, VMAXUW, 0 },
@@ -2974,6 +2994,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sub_vec:
         insn = sub_op[vece];
         break;
+    case INDEX_op_ssadd_vec:
+        insn = ssadd_op[vece];
+        break;
+    case INDEX_op_sssub_vec:
+        insn = sssub_op[vece];
+        break;
+    case INDEX_op_usadd_vec:
+        insn = usadd_op[vece];
+        break;
+    case INDEX_op_ussub_vec:
+        insn = ussub_op[vece];
+        break;
     case INDEX_op_smin_vec:
         insn = smin_op[vece];
         break;
@@ -3280,6 +3312,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_andc_vec:
     case INDEX_op_orc_vec:
     case INDEX_op_cmp_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
     case INDEX_op_smax_vec:
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
-- 
2.17.1


