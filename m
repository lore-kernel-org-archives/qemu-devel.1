Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C116CC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6C420896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+Zd42k1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6C420896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hafNX-0003cB-SY
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39927)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQb-0007sH-M5
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQV-00083S-Mp
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:57 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haeQV-0007h7-4i
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id h19so1658467wme.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OdD7ugR/BLvUdOtU43yNG5jqeDwBZd2sqvJMrpioEU0=;
 b=Y+Zd42k13VSc4UQ12TONhB2KWeELhzVPKxx7wJ74+r2TQ2UqNKsLcUq/FePrO6InZC
 x5+SlDtddq4Drbg06sOlTbxg1DJNgOBxft2Op4nEf2t///pwdrTNVJdn53D9Pt2fCAbu
 r/9NuFhkIa5NWqKH9toW9mnW2BxTpQd5/UcYpvmkT3zbixLIj7Tm3U0mnv6cREeCAROz
 8WM8ZPVVwbZPTuqoVlg9YSG1jJ0C1Vfm4jWP50W/DlhHRApGQWiq7G6Qom5bYIvQ+XYa
 SOBSs4h8oOk9hqTWuv4Jv45zOeVNOMZ8EiQsQH3fte7U4HeD+kAiSS9Ab3lhapI7sjYM
 b5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OdD7ugR/BLvUdOtU43yNG5jqeDwBZd2sqvJMrpioEU0=;
 b=rQftt8WOucjXSWo+0ClbE48ChA/1d4ehctUExZbpoEY3yxu/GD14rzhPyHqQZxPAaJ
 Ar0yVHjveJ/BoH9cvG8htDJRvb7V8DwW3B7G85hloywcPeEg9P8pxDXnGWtOwzNFb0J2
 4of+z/AsM/3wE+eWFSVVUqcoj/T2bKuQqCsaVKrz0n/+SDF4Z9PBmGUpkye5uXPwrBBP
 UqCQDuM4Ic+SyxU2I3l1Xc5YpiwL9OzG4L0NZLMJF9kmoVxc6EGTrsduBrHDLL2BQbW8
 Vr2xDSJs2NShg/WUhR/roJ3GiUzgg9eEEJ1dw4+uJMkIgZkzbl7pCcGAcQWs0srTqTBy
 ksAA==
X-Gm-Message-State: APjAAAX3uMCVAdSjVycPMM7a1av3UQ14tqGcO9WRbf18hIxApruY9/xf
 XuS8/2FT9lWn5s0CMIXw4NehQg==
X-Google-Smtp-Source: APXvYqw2DpE+WI2DTbg6v7HWowD2UFiXw8Te7dHBXuudSuxkJKWWoNgBa8HznAznXwFgCmbtvl00ug==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr18329492wmb.130.1560250468231; 
 Tue, 11 Jun 2019 03:54:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:41 +0100
Message-Id: <20190611105351.9871-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 32/42] target/arm: Convert VMOV (register)
 to decodetree
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 10 ++++++++++
 target/arm/translate.c         |  8 +-------
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index ae2f77a873b..a7e4ae31985 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1889,6 +1889,16 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
     return true;
 }
 
+static bool trans_VMOV_reg_sp(DisasContext *s, arg_VMOV_reg_sp *a)
+{
+    return do_vfp_2op_sp(s, tcg_gen_mov_i32, a->vd, a->vm);
+}
+
+static bool trans_VMOV_reg_dp(DisasContext *s, arg_VMOV_reg_dp *a)
+{
+    return do_vfp_2op_dp(s, tcg_gen_mov_i64, a->vd, a->vm);
+}
+
 static bool trans_VABS_sp(DisasContext *s, arg_VABS_sp *a)
 {
     return do_vfp_2op_sp(s, gen_helper_vfp_abss, a->vd, a->vm);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ce805f0ab28..ad723466b18 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3090,7 +3090,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 1 ... 3:
+                case 0 ... 3:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3103,9 +3103,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             if (op == 15) {
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
-                case 0x00: /* vmov */
-                    break;
-
                 case 0x04: /* vcvtb.f64.f16, vcvtb.f32.f16 */
                 case 0x05: /* vcvtt.f64.f16, vcvtt.f32.f16 */
                     /*
@@ -3278,9 +3275,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 0: /* cpy */
-                        /* no-op */
-                        break;
                     case 4: /* vcvtb.f32.f16, vcvtb.f64.f16 */
                     {
                         TCGv_ptr fpst = get_fpstatus_ptr(false);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 2780e1ed9ea..b72ab8b8067 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -157,6 +157,11 @@ VMOV_imm_sp  ---- 1110 1.11 imm4h:4 .... 1010 0000 imm4l:4 \
 VMOV_imm_dp  ---- 1110 1.11 imm4h:4 .... 1011 0000 imm4l:4 \
              vd=%vd_dp
 
+VMOV_reg_sp  ---- 1110 1.11 0000 .... 1010 01.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VMOV_reg_dp  ---- 1110 1.11 0000 .... 1011 01.0 .... \
+             vd=%vd_dp vm=%vm_dp
+
 VABS_sp      ---- 1110 1.11 0000 .... 1010 11.0 .... \
              vd=%vd_sp vm=%vm_sp
 VABS_dp      ---- 1110 1.11 0000 .... 1011 11.0 .... \
-- 
2.20.1


