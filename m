Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CF1C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEEFA206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9CVE4OX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEFA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43183 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmS5-0007BM-Po
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJQ-0006qB-50
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJO-0000vP-Ty
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:03 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:39858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJN-0000tw-DW
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:01 -0400
Received: by mail-pg1-x531.google.com with SMTP id e1so8937551pgj.6
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=oQgyY0q4tGN1HeWPOTFfa3ocMl6lXl7njB6OKQDxYM4=;
 b=V9CVE4OX1C/HQ9Dfhhp53LU2LV9oZZDLjxpw3rAoGHqWaXLRy9JwL8fuPQTVnfsyRp
 LGcMVDApJbVBVZvISC2TuL3+cTppSpzxlXLoT1OL9iR8OfKEOUM6127Gwccst37qHbXK
 XnDq7+XZij2kDuCqEjNcjOarAGU2PKYv44Q/nvzltxSd8NRp77UWgZa3wB5ZFzs5SjEa
 Qs/b8ohuo4AaiTMNsb+J6GGhtAJy29USwbS43jwZW4a6K/I6sDhbCT2zn/t0tDmjM08S
 NMci1XsVSrbkB+jXG6ylExjagkJQH0aSfZglXR/4Oh1M3UmkugVHQ69HeJ4oEhAd7Usr
 YCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=oQgyY0q4tGN1HeWPOTFfa3ocMl6lXl7njB6OKQDxYM4=;
 b=IkxIbRfVgiCkhe9pjlEhLJLgm8MEiZk7MtvcxM18v9kDDmUjmp9A/vB0mbYS0qU3WT
 tRz0Exof36KXtkVGMc4s63VtAmdh3SzRBdtVgUSh4rwqBzU5onl1sXoOB1Xs2QnWSGNP
 CglgxfwSMqC6gMVmqed+Gr2HoWPQcvLLEdTIN4aJI2Z95Bs74jlmvLm2QtLv/3yE/mXT
 7pX4WqsZ9z0yc2P26w0FGSxUWHH71cMmkLgVXm77shuqO8Rw+hFUM+bgDKRO+K5xcR+I
 /rEn05tzg7PpHuD+JXnmiZ8Cot47V7d28JeLqsfK5vz7xfm1Bv5S+dU90y5M1uvZGzyv
 pMVA==
X-Gm-Message-State: APjAAAVoLfSGm8FtKwNP9xSSp/kJMRXpjKBdlwq9sQVV1v+u42EgpPW6
 9x5nHbbFyKxVgsaG2Byin8jaGclCnuU=
X-Google-Smtp-Source: APXvYqznr0BkffrwXCnHsdec60it0xYc5SUzZlVp+u6BYA2bS7Ob2bOADkCWBQOpialBiPLZnPHEvg==
X-Received: by 2002:a62:1b43:: with SMTP id b64mr28680358pfb.56.1571005560024; 
 Sun, 13 Oct 2019 15:26:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:25:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/23] tcg/ppc: Add support for vector add/subtract
Date: Sun, 13 Oct 2019 15:25:31 -0700
Message-Id: <20191013222544.3679-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::531
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

Add support for vector add/subtract using Altivec instructions:
VADDUBM, VADDUHM, VADDUWM, VSUBUBM, VSUBUHM, VSUBUWM.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.inc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 6879be6f80..6cfc78bb59 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -471,6 +471,14 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define STVX       XO31(231)
 #define STVEWX     XO31(199)
 
+#define VADDUBM    VX4(0)
+#define VADDUHM    VX4(64)
+#define VADDUWM    VX4(128)
+
+#define VSUBUBM    VX4(1024)
+#define VSUBUHM    VX4(1088)
+#define VSUBUWM    VX4(1152)
+
 #define VMAXSB     VX4(258)
 #define VMAXSH     VX4(322)
 #define VMAXSW     VX4(386)
@@ -2830,6 +2838,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_andc_vec:
     case INDEX_op_not_vec:
         return 1;
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
     case INDEX_op_smax_vec:
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
@@ -2930,6 +2940,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            const TCGArg *args, const int *const_args)
 {
     static const uint32_t
+        add_op[4] = { VADDUBM, VADDUHM, VADDUWM, 0 },
+        sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, 0 },
         eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, 0 },
         gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, 0 },
         gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, 0 },
@@ -2953,6 +2965,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         return;
 
+    case INDEX_op_add_vec:
+        insn = add_op[vece];
+        break;
+    case INDEX_op_sub_vec:
+        insn = sub_op[vece];
+        break;
     case INDEX_op_smin_vec:
         insn = smin_op[vece];
         break;
@@ -3251,6 +3269,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return (TCG_TARGET_REG_BITS == 64 ? &S_S
                 : TARGET_LONG_BITS == 32 ? &S_S_S : &S_S_S_S);
 
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
     case INDEX_op_and_vec:
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
-- 
2.17.1


