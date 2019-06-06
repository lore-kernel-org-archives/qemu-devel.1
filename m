Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FB7C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9902083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bN/xsLRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9902083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36439 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwym-0002Df-LN
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:19:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwUK-0004lL-Ff
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwUE-0004VP-O0
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:44 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwUE-0003Ft-Do
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id b17so2237403wrq.11
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=tJUsST+aGlhOT8pqIZXKH+UcDOpMGU+FNgpH8UqWdjI=;
	b=bN/xsLRzT8Q84/gf511fQfvi31EeHwKExgk767yOQlU8rI8utj7kWWk8Prx5bBTCFe
	bqxp8zuGngk5WDInm13pyrOagQT9xOaMapl1GMJSql/AhXgly34CjJNrEb/5oQsPeJgK
	1OyYle+Ehn4nu+h3Kt+hQWvYe+95rRZ1eSonlrJpvJyE8uS6EmSzRuFOBsM5vBPRrmye
	nT7RKx/nw6y47GOZFPndFvm0C969LpiMMNyW+DxgOZVmkxwIDCQHLEjHqHsBVQUnCubl
	gX9Oq2qTQu2TdMp5ULOXsS/LPeMTiLNCKX941Qg05TrY1LlEp20Fx8dfwWb+OVNrOFOe
	ApTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=tJUsST+aGlhOT8pqIZXKH+UcDOpMGU+FNgpH8UqWdjI=;
	b=eZ4O4N4X7h7Gp4+UQYZl+QxB3VjyyYQbKSlJg3eWZps25HQxUwyhHDiSwrAaJqb7K4
	wBCtUknB9CpcMYqdv2ONmbRSKiU0nwfTSwR/6xncnUsJhSy6jQdDvzoeTW8QWUmy9LM0
	8xJ01AHDiuS+zpF7d7c6uBK6v53zJXRH0/e0KOa9HL8QGYLkw/opWKhP8/cBkqj0f5Zo
	mp3ZlEHtYgnn4KAlpC5icVTOgslUnJ9v0SWHM95m3V9YFlTqUcPAmiktZDSwnc8htraW
	5XQ2e7vSoKN1qmJYACHE9vbBsp6dQxQUXZwxmlwcoYdZR00EazceiGVqKl83GTmq2Z3h
	OZ9A==
X-Gm-Message-State: APjAAAXCn2/pOsbhjXsiqmibotzke6jcF79TkQu/r6jW7iMTnn5UMBFo
	OsJm8Op6fV2/iCX9Mip+krXB8w==
X-Google-Smtp-Source: APXvYqyGY5/i6QRBuA/py8ffunh6piU7AYVExNp7vxZigcM/By4154AEfJtkQcjdDI2cMA/qy613vQ==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr15941360wrr.5.1559843206924;
	Thu, 06 Jun 2019 10:46:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:59 +0100
Message-Id: <20190606174609.20487-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 32/42] target/arm: Convert VMOV (register) to
 decodetree
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index fda0962761f..639e0f5f91e 100644
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


