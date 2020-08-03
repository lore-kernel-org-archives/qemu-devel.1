Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D536C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC5A20738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHOeXGR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC5A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Yc6-00059y-5S
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YUi-0003vd-LN
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:19:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YUg-0004tZ-QE
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:19:04 -0400
Received: by mail-wm1-x343.google.com with SMTP id p14so14003709wmg.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 04:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uE/zSzU3YCUj+8keAlvLyFX2oijQycTIyZcK1gVRSqY=;
 b=yHOeXGR2+tLrevmmLAQBc1pTlblM93sXH20O1UjYNdxnWNyqGEP01d+ghis5QepkBJ
 nnsaAljk5M7pebS127QbwK0ye2ORk6Y0D5JwiRaf4IZ6KdaA6gAU2+Qm3E9HKh9nlw/i
 wuetfjcJzJhZlo2DDK0RixvsaxMayGV6+1uemSdZOE08frskmF73uIjGzBttcmtHSQDw
 t67uCqqtvWejovQsEEgxLeASwbPCIPJIOnQ7/7CsaS/PAdlx3Ih3Uz+HOmnDgkBrDn5K
 Okv9Ttn7R+eWS2tttQhAYUIezFzJ8Yv6wWT40sldWq13FRzu5zHPbZkVygAoz5VtUyFt
 FIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uE/zSzU3YCUj+8keAlvLyFX2oijQycTIyZcK1gVRSqY=;
 b=V5Vqs5WAsSrJ9eYMpRQUplPCy0bwE8WczPHGf50V9EYZPH+Awe3pLBOMJo3XF+LqE/
 8CndRZOAX1evBY1VkNaqcWqGsPJViuGy43Gr4oVeEVjQe/WHHTgmQUR3tt5yFIo7AHNd
 CtBva+w766F2dlh/g/RpCUtEG1pJbRqYfcJSKz3g1vf3lKURIqTWYxaPtReULjnok1l+
 QruVsROU5rqt0iWGVVwPwjIHvteBXA5z0uiAduKmr/EMSoqIX485DSmYM6Qkp1bP/tko
 0Q2fRNrRYe7NdPCxZjh4UZtcO0xo6D55d/s/tF7ng6X6pkdlcVRE5WkGr/ucURi6Rzqj
 kEQQ==
X-Gm-Message-State: AOAM530pZrrtbbrqMydtuDUs0qYMse/eAsbnG8rDOabKCav++b6db2im
 VLvVIWa+w26rtgND0huPjqyFSD3MbeMeMA==
X-Google-Smtp-Source: ABdhPJwawNq9iOhdFOEY/zisDxsCZTbjPQ7zJOIeG8TGavX85l8wh0rGA3wcvo6NMUpskNGGIxexGg==
X-Received: by 2002:a7b:c765:: with SMTP id x5mr14994384wmk.14.1596453541230; 
 Mon, 03 Aug 2020 04:19:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g3sm28013170wrb.59.2020.08.03.04.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 04:19:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 6/7] target/arm: Convert T32 coprocessor insns to decodetree
Date: Mon,  3 Aug 2020 12:18:48 +0100
Message-Id: <20200803111849.13368-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803111849.13368-1-peter.maydell@linaro.org>
References: <20200803111849.13368-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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

Convert the T32 coprocessor instructions to decodetree.
As with the A32 conversion, this corrects an underdecoding
where we did not check that MRRC/MCRR [24:21] were 0b0010
and so treated some kinds of LDC/STC and MRRC/MCRR rather
than UNDEFing them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/t32.decode  | 19 +++++++++++++
 target/arm/translate.c | 64 ++----------------------------------------
 2 files changed, 21 insertions(+), 62 deletions(-)

diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index c21a988f971..7069d821fde 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -45,6 +45,8 @@
 &sat             !extern rd rn satimm imm sh
 &pkh             !extern rd rn rm imm tb
 &cps             !extern mode imod M A I F
+&mcr             !extern cp opc1 crn crm opc2 rt
+&mcrr            !extern cp opc1 crm rt rt2
 
 # Data-processing (register)
 
@@ -621,6 +623,23 @@ RFE              1110 1001 10.1 .... 1100000000000000         @rfe pu=1
 SRS              1110 1000 00.0 1101 1100 0000 000. ....      @srs pu=2
 SRS              1110 1001 10.0 1101 1100 0000 000. ....      @srs pu=1
 
+# Coprocessor instructions
+
+# We decode MCR, MCR, MRRC and MCRR only, because for QEMU the
+# other coprocessor instructions always UNDEF.
+# The trans_ functions for these will ignore cp values 8..13 for v7 or
+# earlier, and 0..13 for v8 and later, because those areas of the
+# encoding space may be used for other things, such as VFP or Neon.
+
+@mcr             .... .... opc1:3 . crn:4 rt:4 cp:4 opc2:3 . crm:4
+@mcrr            .... .... .... rt2:4 rt:4 cp:4 opc1:4 crm:4
+
+MCRR             1110 1100 0100 .... .... .... .... .... @mcrr
+MRRC             1110 1100 0101 .... .... .... .... .... @mcrr
+
+MCR              1110 1110 ... 0 .... .... .... ... 1 .... @mcr
+MRC              1110 1110 ... 1 .... .... .... ... 1 .... @mcr
+
 # Branches
 
 %imm24           26:s1 13:1 11:1 16:10 0:11 !function=t32_branch24
diff --git a/target/arm/translate.c b/target/arm/translate.c
index adcd2127290..59d6e43611a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4791,37 +4791,6 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
     return;
 }
 
-static int disas_coproc_insn(DisasContext *s, uint32_t insn)
-{
-    int cpnum, is64, crn, crm, opc1, opc2, isread, rt, rt2;
-
-    cpnum = (insn >> 8) & 0xf;
-
-    is64 = (insn & (1 << 25)) == 0;
-    if (!is64 && ((insn & (1 << 4)) == 0)) {
-        /* cdp */
-        return 1;
-    }
-
-    crm = insn & 0xf;
-    if (is64) {
-        crn = 0;
-        opc1 = (insn >> 4) & 0xf;
-        opc2 = 0;
-        rt2 = (insn >> 16) & 0xf;
-    } else {
-        crn = (insn >> 16) & 0xf;
-        opc1 = (insn >> 21) & 7;
-        opc2 = (insn >> 5) & 7;
-        rt2 = 0;
-    }
-    isread = (insn >> 20) & 1;
-    rt = (insn >> 12) & 0xf;
-
-    do_coproc_insn(s, cpnum, is64, opc1, crn, crm, opc2, isread, rt, rt2);
-    return 0;
-}
-
 /* Decode XScale DSP or iWMMXt insn (in the copro space, cp=0 or 1) */
 static void disas_xscale_insn(DisasContext *s, uint32_t insn)
 {
@@ -8485,38 +8454,9 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         ((insn >> 28) == 0xe && disas_vfp(s, insn))) {
         return;
     }
-    /* fall back to legacy decoder */
 
-    switch ((insn >> 25) & 0xf) {
-    case 0: case 1: case 2: case 3:
-        /* 16-bit instructions.  Should never happen.  */
-        abort();
-    case 6: case 7: case 14: case 15:
-        /* Coprocessor.  */
-        if (arm_dc_feature(s, ARM_FEATURE_M)) {
-            /* 0b111x_11xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx */
-            goto illegal_op;
-        }
-        if (((insn >> 24) & 3) == 3) {
-            /* Neon DP, but failed disas_neon_dp() */
-            goto illegal_op;
-        } else if (((insn >> 8) & 0xe) == 10) {
-            /* VFP, but failed disas_vfp.  */
-            goto illegal_op;
-        } else {
-            if (insn & (1 << 28))
-                goto illegal_op;
-            if (disas_coproc_insn(s, insn)) {
-                goto illegal_op;
-            }
-        }
-        break;
-    case 12:
-        goto illegal_op;
-    default:
-    illegal_op:
-        unallocated_encoding(s);
-    }
+illegal_op:
+    unallocated_encoding(s);
 }
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
-- 
2.20.1


