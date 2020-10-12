Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F83BC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3550020735
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSrlsBno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3550020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS09X-0000Dy-CK
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqq-0007LX-7x
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:35:04 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqe-0007NU-D8
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:35:03 -0400
Received: by mail-wm1-x342.google.com with SMTP id k18so17961294wmj.5
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y1ekWK8CJLvHrVxfCc2kYGCDX3fGw6jKhM4D+UOMVQU=;
 b=YSrlsBnoQCz/hCGSqfuYdXKXQhZ80JQPJ4j/lDZO+r7fA8pu9fNnuzbEY1wyT/7zTI
 QCU0qnRZmG64mcm98xhV04Hkw8DVouadiIE10n6+m238GqtUBxpeoqWS8HHhtJF4wrn0
 kNBoyZj++YUv7m3S6h7HSzxjUHhA4yZ1iG69g3sb3wkw/M49RAS6jehxazLP2p+t9Sv/
 V8MvxuxrOWoHxHNxSfDZDP+Td7yc2v+714iZkgEpa8W/seVaWX356rYfU93xgpLOF3Ai
 eQu06ZqEWcJ0R9mXix/14P52wwSkmmCh8SR6zNHpASRWF2+M6x6Tqz5bud66x2RkXQL7
 6nFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y1ekWK8CJLvHrVxfCc2kYGCDX3fGw6jKhM4D+UOMVQU=;
 b=b77jMKC2ucyBdMhb2CRYtd1cHGzLUnziZEGeXpxb+fMujI3qtxDZzKoV1BjJzIdUDh
 cNBrPIsi0MKJkg4psDdWiUU4BkdoH9uutnqb2me6Dc6j4yagMlg75gGSoLG6ACL6PI35
 6SzMRC9UzCof0/L8VwFKGwuUcHF3LFehl2XjiqwfQhyKBlduMntW73p9dayTUmhKdQ2X
 O0R8i5naWwMZYx1nEfP7Zcn8q3T6a9uSKjAB8M3QPJqdz03PgWurziZzAzJzjA5DrCrf
 k/M82LYBZwqSnbWnL3Iao0OtIY71XI1i/hWuYxR8DH2uTi1Hg6m7BkOYyXWW9J96QeMY
 JoaQ==
X-Gm-Message-State: AOAM533rG5UOIvr9uOx9BQPsbyAZ0k8TFYlTavpBqMsQJhsdLMP89j/A
 hpTMvMvmnD8i89yUrbyXB/f28w==
X-Google-Smtp-Source: ABdhPJxojrk73BbaSQUuBxPDXxPMXwA4r3go3bXwSx1oHzOrS9uy+qgdLtNFDy+WCsiG8/+yWP20Ug==
X-Received: by 2002:a1c:a541:: with SMTP id o62mr11362675wme.90.1602516885118; 
 Mon, 12 Oct 2020 08:34:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Delete unused VFP_DREG macros
Date: Mon, 12 Oct 2020 16:33:53 +0100
Message-Id: <20201012153408.9747-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As part of the Neon decodetree conversion we removed all
the uses of the VFP_DREG macros, but forgot to remove the
macro definitions. Do so now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c39a929b938..27bf6cd8b51 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2471,21 +2471,6 @@ static int disas_dsp_insn(DisasContext *s, uint32_t insn)
     return 1;
 }
 
-#define VFP_REG_SHR(x, n) (((n) > 0) ? (x) >> (n) : (x) << -(n))
-#define VFP_DREG(reg, insn, bigbit, smallbit) do { \
-    if (dc_isar_feature(aa32_simd_r32, s)) { \
-        reg = (((insn) >> (bigbit)) & 0x0f) \
-              | (((insn) >> ((smallbit) - 4)) & 0x10); \
-    } else { \
-        if (insn & (1 << (smallbit))) \
-            return 1; \
-        reg = ((insn) >> (bigbit)) & 0x0f; \
-    }} while (0)
-
-#define VFP_DREG_D(reg, insn) VFP_DREG(reg, insn, 12, 22)
-#define VFP_DREG_N(reg, insn) VFP_DREG(reg, insn, 16,  7)
-#define VFP_DREG_M(reg, insn) VFP_DREG(reg, insn,  0,  5)
-
 static inline bool use_goto_tb(DisasContext *s, target_ulong dest)
 {
 #ifndef CONFIG_USER_ONLY
-- 
2.20.1


