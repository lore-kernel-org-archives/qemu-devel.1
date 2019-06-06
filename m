Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0E9C28EB4
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB9C20665
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ykq12WR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB9C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36224 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwnh-0007lf-I1
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:07:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwUA-0004ZE-Kg
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU7-0004CK-Dw
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:34 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwU7-0003ES-3e
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:31 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so3351152wrs.3
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=kCydqH+FEckzIy4SdO9TgeD3fKBJOY8MRSuCPKdNzwE=;
	b=ykq12WR9buJhLcv13TZUE5HdDi0v/cQdfbOouc+Mm+VaJNsmGmLzr+H6hbVUNm7Yxq
	B/ZiPTA0lEJ4KX2C/vTuwBJ2oWs3MJuhdqw9D+59/3OcMHKTKr9dJHQoPynCHpXI8euA
	vSC7t0lurG7BplozEm5FGamQ82UZ/qWIWiqpV6RLgWWMpSNQ9AC2sLxdPfvyDyrL6CgA
	Xd8hqG2itTgWIeYFIEDlJ66O1Jk8KnTUvASeAmUSBVd+2vHgCUgwIaZaXJR4TyD6oFb1
	erupPwuyAxIlCXC1U1qwVOQ9L2KO3jxDmB3sZhek01EeqmdE8QHGOsZHqTm+TjafVWZy
	ot+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=kCydqH+FEckzIy4SdO9TgeD3fKBJOY8MRSuCPKdNzwE=;
	b=odQiwdetq4/WjT1OtIx3LeZSbDWCqMDhYVsWpKodxG6grXb9kyIVC1daC5ERF5qRJk
	+RgsaZYH+YUevLUYDuIqCut9fbt6FH9ekWwGaZaq0mCghRrR7NQM6P64fBiGCgeZ0HW5
	bHPU5iKXLuDTafKiNGZHIw6gyKbYi0tP47lMcMJZP+VyhaHVRd6RYJ2xAaZPb8meoOoa
	nlaotastpJuXU97UYJ6C8kyDxbssHFdcOL1e903xw22AnntiayJb+oRFTwxdUmEsNq1f
	COIkd8T6pCo6q4fEn5L9ThfeBbO4J9J7kkd9EuOdWfQP81Un6g/3TjeZiC1Mz2i1sH8q
	7sHg==
X-Gm-Message-State: APjAAAWe9w2Fv52rm2j3Mf+Z1snhMV2FLPzxTY6DJOeJFvQ5CJhpsStq
	M9F5xRMVkruZ5Q0aSOSq5J+qFhU/mXmipQ==
X-Google-Smtp-Source: APXvYqzUFKgRUW0HVU1mESlLHoyIT6eGangEybkNYM8CA0t/vpCZrIOQBKPGD3igN7X+x9cSp3KgMA==
X-Received: by 2002:adf:db12:: with SMTP id s18mr6006866wri.335.1559843205858; 
	Thu, 06 Jun 2019 10:46:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:58 +0100
Message-Id: <20190606174609.20487-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 31/42] target/arm: Convert VSQRT to decodetree
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

Convert the VSQRT instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 20 ++++++++++++++++++++
 target/arm/translate.c         | 14 +-------------
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 6e06b2a130a..ae2f77a873b 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1908,3 +1908,23 @@ static bool trans_VNEG_dp(DisasContext *s, arg_VNEG_dp *a)
 {
     return do_vfp_2op_dp(s, gen_helper_vfp_negd, a->vd, a->vm);
 }
+
+static void gen_VSQRT_sp(TCGv_i32 vd, TCGv_i32 vm)
+{
+    gen_helper_vfp_sqrts(vd, vm, cpu_env);
+}
+
+static bool trans_VSQRT_sp(DisasContext *s, arg_VSQRT_sp *a)
+{
+    return do_vfp_2op_sp(s, gen_VSQRT_sp, a->vd, a->vm);
+}
+
+static void gen_VSQRT_dp(TCGv_i64 vd, TCGv_i64 vm)
+{
+    gen_helper_vfp_sqrtd(vd, vm, cpu_env);
+}
+
+static bool trans_VSQRT_dp(DisasContext *s, arg_VSQRT_dp *a)
+{
+    return do_vfp_2op_dp(s, gen_VSQRT_dp, a->vd, a->vm);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index cc67ab069bc..fda0962761f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1390,14 +1390,6 @@ static inline void gen_vfp_neg(int dp)
         gen_helper_vfp_negs(cpu_F0s, cpu_F0s);
 }
 
-static inline void gen_vfp_sqrt(int dp)
-{
-    if (dp)
-        gen_helper_vfp_sqrtd(cpu_F0d, cpu_F0d, cpu_env);
-    else
-        gen_helper_vfp_sqrts(cpu_F0s, cpu_F0s, cpu_env);
-}
-
 static inline void gen_vfp_cmp(int dp)
 {
     if (dp)
@@ -3098,7 +3090,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 1 ... 2:
+                case 1 ... 3:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3112,7 +3104,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
                 case 0x00: /* vmov */
-                case 0x03: /* vsqrt */
                     break;
 
                 case 0x04: /* vcvtb.f64.f16, vcvtb.f32.f16 */
@@ -3290,9 +3281,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     case 0: /* cpy */
                         /* no-op */
                         break;
-                    case 3: /* sqrt */
-                        gen_vfp_sqrt(dp);
-                        break;
                     case 4: /* vcvtb.f32.f16, vcvtb.f64.f16 */
                     {
                         TCGv_ptr fpst = get_fpstatus_ptr(false);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 79e41963be4..2780e1ed9ea 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -166,3 +166,8 @@ VNEG_sp      ---- 1110 1.11 0001 .... 1010 01.0 .... \
              vd=%vd_sp vm=%vm_sp
 VNEG_dp      ---- 1110 1.11 0001 .... 1011 01.0 .... \
              vd=%vd_dp vm=%vm_dp
+
+VSQRT_sp     ---- 1110 1.11 0001 .... 1010 11.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VSQRT_dp     ---- 1110 1.11 0001 .... 1011 11.0 .... \
+             vd=%vd_dp vm=%vm_dp
-- 
2.20.1


