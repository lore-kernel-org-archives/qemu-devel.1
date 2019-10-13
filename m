Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F1EC4CECE
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C682620663
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Orl5U+SO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C682620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmXc-0006Dm-T7
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJP-0006lj-16
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJM-0000tP-8x
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:02 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:42464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJM-0000tC-2S
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:00 -0400
Received: by mail-pg1-x52d.google.com with SMTP id f14so3817977pgi.9
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5ZDmbwz7v2egeojt/Bhecjq76qk07ezt/13exaG5QJI=;
 b=Orl5U+SOcF0h8ZUzIsugmGwxryPFjloJuDDAFeQw/GgTI797hHWQ8gygIbNoJUhLYw
 obzvhLX/N/wEO5ZM5DP2uMuQQitTE56fri7arWrZgU4K8oolD2UG/A2oRkOnopJcFt91
 Z/vGy9s9MgqMSoVwFy1pKoxXA1IhUEqnVGP/aNlgeBpfqqeK6lggok+NG711I+vslBXX
 3hrUqDxG6ynSPV8OU7W3IuCHDP6QxrjaOypheJymjFWe6SNOd4tRD/boWg8yu3IhIxZ+
 sukhK7FvR/lCDxhB0+cAGDRTHxZuWXRtmVRIdtgfkFEbFa4G/nAiBYow2n2nyYATFkDt
 99Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5ZDmbwz7v2egeojt/Bhecjq76qk07ezt/13exaG5QJI=;
 b=QcVQq1R4s8V7XGD6UxTXVTVT4GTUyI/RuF73vWQloIf5vBvpKA4zH4dHvFpe4T7N7C
 V68I4ojdrsho3Lii07e/FXtnCaJ2uTvEfhlatuaULvoR+a/A5pIiKeryncwpN1F910jI
 5M7lbErNufDtg1lxJdO38Uh2ZlpSQdwjRJuHPQM06lVBAt3trpUWnQKmdvpsa8fiiNIv
 TtoFsugbUKC4F1R+53I1yRfmEGkQxsrHD4Tyfn5XBu6Y8np4E5CL5l6z1PbkGi9qV13z
 0TObUBZp0A63ReGPGhIMNQcmTNJosGj1ocgv0k++g854RnfYmobLrM5mbOUH4Wp8Q2dj
 JE/A==
X-Gm-Message-State: APjAAAXUEnxoqfJJ6wXZaXBiMFLgmLFL2xsnv30gRJ3Kb20Zl+upgLhX
 02kCnIEu1ebEF0cRuL1iTtrpStE8V1U=
X-Google-Smtp-Source: APXvYqyNqrSEiqAL6HFpTXAJvJCc4wOJaypHw9Z4RdQAoegkEGVvyctjAzZFCrHZkNx7NAuVCbT2oQ==
X-Received: by 2002:a63:d754:: with SMTP id w20mr11166502pgi.156.1571005558708; 
 Sun, 13 Oct 2019 15:25:58 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:25:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/23] tcg/ppc: Add support for vector maximum/minimum
Date: Sun, 13 Oct 2019 15:25:30 -0700
Message-Id: <20191013222544.3679-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
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
Cc: peter.maydell@linaro.org, Aleksandar Markovic <amarkovic@wavecomp.com>
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


