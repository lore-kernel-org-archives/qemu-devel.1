Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12709C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A850A20881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmIZP62u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A850A20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52679 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZuz-0003tI-0D
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:41:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZj4-00039y-KG
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZj3-0007Ra-MV
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:46 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:40216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZj3-0007OH-Gt
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:45 -0400
Received: by mail-yw1-xc43.google.com with SMTP id 18so1484108ywe.7
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=5pgxUU1cRl5UBw70ixoMtifwIrAs5XS+sRdx95+Fg/g=;
	b=ZmIZP62uRC6Ro4Hjl4+oNmfrfolZ2tbnvAyoqcrnhf7UpIYjiB5V41dTdBcvTK8U52
	ADxdBPTPWBCy6+fy4wPbBTZVQg8V37ey10GzwufBT7VKJensWHWpa0si10K/JO0erTHT
	2FXuPF/IW4OPxG/KzH6705938yLQaWG/Atg5/KB5ZIMsROvtCzDklRp79cJiH3Ee72bQ
	NzTwIiMbesKF57rK+D6Gb7Wl4gJVKRmeqvYHjpeNNqpNV+W1OpgbSQ/PMpfMqeiDCew3
	cuWWlUOJF/drjqGM0qYj5KJpMAGQQkudbsWPjaPzpxJuVJZ8sCt7BfMSGXurz0dyMjkm
	eFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=5pgxUU1cRl5UBw70ixoMtifwIrAs5XS+sRdx95+Fg/g=;
	b=GJkgaiyBdxqJJliUap6lyljHnXn2/q8aViDFRwGk3kcOF01BksNBREoXDlUhEjA524
	7BP729+L8twAP1l3ST+kktxQ3h6PKuSRm3HDiWQHjbpPUm/mf/BIZeNMr1ivKlQmYF4N
	oIeRUHBU2SjzwFaY5qB41TdynY/93z2mfYmihPtjj1QhFfwO8vTVyEpXfw6i3VvZqNk1
	napQVXQWFJjwte90Lf10EmLOJbuz/g8SF+1ZPQ8m02DhEZBEeu6BJqR4A9lasaY0OMId
	kaOGaFh5FxBqu6V5xRhEWTrvWf+G3r0A1VPFlYc+UnAV6r2LONjhnl4/CM9f3AM7Zchh
	GVpA==
X-Gm-Message-State: APjAAAXv9aMu5N5gsFF+w85TFSCRu+5ZUj3DJQ7YZNAzanHPlZ9L60eZ
	TBXiyM5vnxNkuZHFQFidYuNdDT8D4Bg=
X-Google-Smtp-Source: APXvYqzGTzLtrOD80PO68a7Ida1V91gM8+u9WjANAFt2Nj1p+8SkKqikbnKiMwNaqBHE1ZMwi+QJEw==
X-Received: by 2002:a81:3acb:: with SMTP id
	h194mr42063623ywa.303.1558564117990; 
	Wed, 22 May 2019 15:28:37 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:18 -0400
Message-Id: <20190522222821.23850-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [PULL 13/16] tcg/aarch64: Use MVNI in tcg_out_dupi_vec
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The compliment of a subset of immediates can be computed
with a single instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 1422dfebe2..0b8b733805 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -494,6 +494,7 @@ typedef enum {
 
     /* AdvSIMD modified immediate */
     I3606_MOVI      = 0x0f000400,
+    I3606_MVNI      = 0x2f000400,
 
     /* AdvSIMD shift by immediate */
     I3614_SSHR      = 0x0f000400,
@@ -838,8 +839,13 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
             tcg_out_insn(s, 3606, MOVI, q, rd, 0, cmode, imm8);
             return;
         }
+        if (is_shimm16(~v16, &cmode, &imm8)) {
+            tcg_out_insn(s, 3606, MVNI, q, rd, 0, cmode, imm8);
+            return;
+        }
     } else if (v64 == dup_const(MO_32, v64)) {
         uint32_t v32 = v64;
+        uint32_t n32 = ~v32;
 
         if (is_shimm32(v32, &cmode, &imm8) ||
             is_soimm32(v32, &cmode, &imm8) ||
@@ -847,6 +853,11 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
             tcg_out_insn(s, 3606, MOVI, q, rd, 0, cmode, imm8);
             return;
         }
+        if (is_shimm32(n32, &cmode, &imm8) ||
+            is_soimm32(n32, &cmode, &imm8)) {
+            tcg_out_insn(s, 3606, MVNI, q, rd, 0, cmode, imm8);
+            return;
+        }
     } else if (is_fimm64(v64, &cmode, &imm8)) {
         tcg_out_insn(s, 3606, MOVI, q, rd, 1, cmode, imm8);
         return;
-- 
2.17.1


