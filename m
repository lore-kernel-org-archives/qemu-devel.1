Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27586C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF65B20868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eowGwb18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF65B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36161 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwko-0004l1-5x
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:04:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU5-0004Qu-6y
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU2-000429-HN
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTz-0003Dk-S7
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:25 -0400
Received: by mail-wr1-x442.google.com with SMTP id r18so3319700wrm.10
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=YjVm+cX22zoyuHU03fYipUHvsizBftG/iHWYkwVfhEA=;
	b=eowGwb18WGDo4xD8H0ZWgGRnw2MQw0JMlxUcH0N2k4p0QBmJAtpzDuaLw+M+g+3y4o
	+G2o/HzlMzwzZ9EgsBsvdt++8C2KxFZm7LTjLmII28dTsKvf5Oux2KbIyY11PW7qTwCp
	ZWM6yoXvtLgbgZX+0GjGcy37Sz82Vs9HhWfi5XZ7dQJK7YARlwRW1dWC4aIaLTG6kIHm
	gfw9IPEjtIhObnuuLTyIEwenGBKIuMhnN9LWOZto1dhAdeygnAOnhfFwX7gcv+B6f54v
	TvuiiMiXHJ66JL+Pra0QfN+elX4OgBmYzVot6HcZCA/xnggn5vB7Rul6BqHhEnx7qdu2
	Mplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=YjVm+cX22zoyuHU03fYipUHvsizBftG/iHWYkwVfhEA=;
	b=soHSkRgzmbms+Ca4zT/Uq5kn26p2mI/MbIOfacxdBnUTgLVC6hhbx0Is8UZdLf+JBM
	5BymI8BkzUUVaKsp750n+4svgd6VMnzox9L7fJvN4RPXZ1tJWoneyKFaJUAvkNPBCevu
	qiw7dSHjf5VjxjYjJBEYsq6BuuhuUmd34IVsNGCckTFWTyuuOfM0iUR83+seg2AiOLul
	TAOgTV/UD13wF+ExwurgI4ay/2PUaWmlSFGg0DKQOI8oUGkA5c/sV/AnfDhxfywi0hEP
	c2wTIdihSAPa9sMxArSI/kU+WNChdGnXkOLx6QZ4nrupiNYA+h4zeH+XElZPxDCBLmn9
	AWTQ==
X-Gm-Message-State: APjAAAVHUtjer90tlqKriX+Yp5aD2YreShFoFQu6mf+pJmcwQsqdfOVg
	Vc0MmToFJ2SLllWNv5c8ov0Xt5XqAICfTg==
X-Google-Smtp-Source: APXvYqwALLGDPtphcaCVv5Ve7CJ2hhdWViM1mwV+lorH3npXdDcxMxIBX2OFaDaSl22m6894AdNNAw==
X-Received: by 2002:adf:dd82:: with SMTP id x2mr6457026wrl.27.1559843204615;
	Thu, 06 Jun 2019 10:46:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:57 +0100
Message-Id: <20190606174609.20487-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 30/42] target/arm: Convert VNEG to decodetree
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

Convert the VNEG instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 10 ++++++++++
 target/arm/translate.c         |  6 +-----
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index d0282f1f921..6e06b2a130a 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1898,3 +1898,13 @@ static bool trans_VABS_dp(DisasContext *s, arg_VABS_dp *a)
 {
     return do_vfp_2op_dp(s, gen_helper_vfp_absd, a->vd, a->vm);
 }
+
+static bool trans_VNEG_sp(DisasContext *s, arg_VNEG_sp *a)
+{
+    return do_vfp_2op_sp(s, gen_helper_vfp_negs, a->vd, a->vm);
+}
+
+static bool trans_VNEG_dp(DisasContext *s, arg_VNEG_dp *a)
+{
+    return do_vfp_2op_dp(s, gen_helper_vfp_negd, a->vd, a->vm);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ace9f803ab7..cc67ab069bc 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3098,7 +3098,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 1:
+                case 1 ... 2:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3112,7 +3112,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
                 case 0x00: /* vmov */
-                case 0x02: /* vneg */
                 case 0x03: /* vsqrt */
                     break;
 
@@ -3291,9 +3290,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     case 0: /* cpy */
                         /* no-op */
                         break;
-                    case 2: /* neg */
-                        gen_vfp_neg(dp);
-                        break;
                     case 3: /* sqrt */
                         gen_vfp_sqrt(dp);
                         break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 7035861c270..79e41963be4 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -161,3 +161,8 @@ VABS_sp      ---- 1110 1.11 0000 .... 1010 11.0 .... \
              vd=%vd_sp vm=%vm_sp
 VABS_dp      ---- 1110 1.11 0000 .... 1011 11.0 .... \
              vd=%vd_dp vm=%vm_dp
+
+VNEG_sp      ---- 1110 1.11 0001 .... 1010 01.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VNEG_dp      ---- 1110 1.11 0001 .... 1011 01.0 .... \
+             vd=%vd_dp vm=%vm_dp
-- 
2.20.1


