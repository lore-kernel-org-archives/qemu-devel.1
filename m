Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8B3C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA70E22501
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tlrtg0ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA70E22501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2Fx-0001uf-Jh
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Aw-0004eK-AV
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Av-0005b1-1M
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:42 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:35826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2At-0005ad-S4
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:40 -0400
Received: by mail-pg1-x534.google.com with SMTP id a24so8009161pgj.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5ZDmbwz7v2egeojt/Bhecjq76qk07ezt/13exaG5QJI=;
 b=tlrtg0ot3m6rRgpp3jDQDonLvaUnDhBRpCZTYAnOkvuE9j973Ra5upu6f0OStiZRRu
 LBt+0D5p9RNL2ZMbRioHi58ax8dkNdFrxfPvYTA2WCklFpl1+pvQb7a89FUgW4CVXedP
 KEqTH1OZueQ/KhKrS6B4iMpcFFLuCAtIFjBxVtFu//GpClcQonBz+LadaBam7SxS/Rnl
 xT0g5KHk+YQOVHxOqqst8U3STSqHYOypx8AKslMkn9LF4vkp9VM24s1wpCaGq54V//Ec
 6xwU4tg1pGz7VRR9Mz4houyuQmMxMh9SRloUhXwkd+DTESJq+hCYCLAQMiNFQUc7jWhk
 fKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5ZDmbwz7v2egeojt/Bhecjq76qk07ezt/13exaG5QJI=;
 b=eErqtpDFNPPvp2ffOlfmSj/P0X5MpOuvDIrFI5ZqzmPaFm/44aJMZeCclP9zOJ2lku
 RTwSVUGtVQZlWHmlRGrzcL6yg1zWVbfRJPAamyIlwU+OAJ8wHn9Yc/zUq3Vfq5QGvs+4
 PacQFO5ukbNzJtKfmzT78k/6CzbeR3xp/xHYHXpZxVJEEhp5IMrTVVnUPTeFSviBKZXP
 9Sbj+NZ8IMP0uylj43TvGPXVY7WpQJTTrp2PsFGnDvEiR+vCjXsAD3DIlpLGiAEFV782
 EDtp3J4YV2vFPloFrbkcdUiTbPFOS7sRtkvVxayMiKqtN0f3DSK1WNvsclzqQctCATbr
 TRkA==
X-Gm-Message-State: APjAAAUmbKYKuejhB1i7OKmMO8qDRdGDdQAg6lEls9jFTY0LgPCvttC9
 qG7s/xzUOlrRG4I+fL/WN9gW/mkzUjQ=
X-Google-Smtp-Source: APXvYqzItHUPkRdf5afy43c40g8uNlqtHIXmTmykkan0WDWSR+mXwGG4eL+2+M5vXdsc/iuzVhvQcA==
X-Received: by 2002:a63:205:: with SMTP id 5mr25662922pgc.77.1569874898562;
 Mon, 30 Sep 2019 13:21:38 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 09/22] tcg/ppc: Add support for vector maximum/minimum
Date: Mon, 30 Sep 2019 13:21:12 -0700
Message-Id: <20190930202125.21064-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::534
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
index a0e59a5074..13699f1b63 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -164,7 +164,7 @@ extern bool have_altivec;
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          0
 #define TCG_TARGET_HAS_sat_vec          0
-#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 1a8d7dc925..6879be6f80 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -471,6 +471,19 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
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
@@ -2817,6 +2830,11 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
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
@@ -2914,7 +2932,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -2931,6 +2953,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -3223,6 +3257,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
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


