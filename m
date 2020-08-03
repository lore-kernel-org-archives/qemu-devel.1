Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51A4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCB320678
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hR+x5ZYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCB320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ZuQ-0000RT-NW
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 08:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2Ztf-0008Jz-To
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:48:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2Ztd-0007Zi-8D
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:48:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id 3so15314609wmi.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 05:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y1ekWK8CJLvHrVxfCc2kYGCDX3fGw6jKhM4D+UOMVQU=;
 b=hR+x5ZYpgOfTj9hImkFq4ttlq2WAV+xBJSbajC/E7sa+oROv4i3j5JhVPv38hKOZrW
 0HLp58Lx13AEu2x3JFGiBAfWmcbaRU5S3kqb2vadt7hTBjujS/ZiTOqMXSIhYnkrjS0a
 eud0W/iHqZ3vsYnvY7/Et3EJmkk7bnDu2ZyS/4Bt85qBf8iqKWLw9H3ujZxf8wgHKGwU
 dOUP/tFfikSm7eRHTy2Igve3WqMcRsE3z9MbT9hpRgEXy3IQjw4GUVhdMQfkn0KR7fAI
 4slzuGHlc4TZAiM/GgBDGJ6uyuJbDVZ2ES3MuYcBK+JUS4nhr10z3bk+51ERIj+j7JpU
 Kgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y1ekWK8CJLvHrVxfCc2kYGCDX3fGw6jKhM4D+UOMVQU=;
 b=QBK05Zu+hklgDD7ssOJl1RdtMDlqLrLDv4pdPiCSyWmVkjJeQJbtsdAhmTB1KsnBA2
 nT46jC7SQbkiV3YrkCafxBqkBbIHA6Eawlq/X0fTOPUdU5dOqIQoerkdg9l9EPCzZnJy
 yZUlQ/T1Dg7fSpmpDlKeVfp2YAZnbF/vl8+MePcTBfBaIeNXAWlI9+Gv9+VFHMPem8T1
 Ff3o4L2ifmRBFVLiFSh8c6b+wYnBNs6tjE7T6rYBiNXVt411XKpFafoszexnwF5s+g+q
 18cc+pSBv6CfxUPbCvmzP1lL+BrjkJjheJthhwBo/y5L/ZIKcc/dLKV5Lkr3C/TyxhQQ
 NYQw==
X-Gm-Message-State: AOAM533EOoYYsZ2FnVR1cgj0RT7sZjecEtZ5Tn296Thm2I8R1ghPEYBY
 N4/Idk2MbHlruWu+4++5dpA/GCpha2QXMg==
X-Google-Smtp-Source: ABdhPJzE1z34Bxuf3hSO7vcf19ZRKdzwMDDTIi7X9o6mMipYo/II9z6mJ+MVdMMfu1Oe5eTsMOeEIw==
X-Received: by 2002:a7b:c054:: with SMTP id u20mr22517wmc.2.1596458930936;
 Mon, 03 Aug 2020 05:48:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d7sm19153174wra.29.2020.08.03.05.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 05:48:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Delete unused VFP_DREG macros
Date: Mon,  3 Aug 2020 13:48:48 +0100
Message-Id: <20200803124848.18295-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


