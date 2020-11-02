Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE291C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A04A2071A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCOSqn7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A04A2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdMs-0002KH-VZ
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLV-0000WD-11
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:17 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLT-0006O2-8p
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:16 -0500
Received: by mail-wm1-x342.google.com with SMTP id v5so10135949wmh.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wRbK+boMFOA38V3XwqhrElTFyf+xXduXL37Qdsdc3+E=;
 b=mCOSqn7N2zqE0t8RHHsOBxiYKyZhLu3HKkJHxB2A4tIInWRsJq3gqNkBBzl42ktEDi
 V6xlYqUshVqNcAVJHqNwatEb6vz8Xi+WDXI4KfekSPk/hjTR5xmTOdx2vBFrQTlVJl33
 PswG5qs1fRbBst+6/FtFB5ddHuSZKj8ZZhKfCnyMesbT3RnGC1yrsHdZbr3ApX2OD8cE
 BLIAl3bpwy3+umQaYEk8skKY2xXGX7rrgYxAvrlc9SFMly9undYCMl9myimP1Vq/mE8A
 RJx65nzW3tQ2tJ/OZCqaUDN6UsBqUw6dvqueXTqdzoH/Tv+tj/5YGVKueG8h7DplkJFI
 A+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wRbK+boMFOA38V3XwqhrElTFyf+xXduXL37Qdsdc3+E=;
 b=ArXQeXKWeRYqXsSBCTlyC5rV+3pykdaWMwutptS3ciIW+n1OULtUFcq4EMVU249fcz
 IHe5w2213bUuhW10MlZGtXvL2rxcPZeOH237+X1+OH12xru+Rl9evqT9BeMnl4Ld86it
 2PVNLWtaMZ751Uh8b5t+Xyzpfm3xJu0IXfCYGPSqDvqsF9yqs+koilFPkPHuHYiropLz
 6MVAv3msXMrPw2fS0L65HFj4trUQiRJhTI5SHeMCWUdrdC3Ednl7/gTJ9zaHgjEv9d2W
 rBDviAxfu5J7Di6PsfpaQFfQoQiD3lofJiHp6uMY9Vj40obft2IeS62ZfqtiM9LNJ1xT
 Ll8g==
X-Gm-Message-State: AOAM5323L9HUDC9vAodMz8w5UtP+H45Gr47zHHiRybIn6QaYczogBn/b
 5DqK1zEhyZbNmGJAaP8r83y596yXdY2VWA==
X-Google-Smtp-Source: ABdhPJy/zkVJjO0BuXxvKTWJ84+nJ7OlSMtTKHTbsdGSP6yxsHDZUeqBzu7yDDf2/mUCxjd+XfMwww==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr18314708wmh.46.1604337013616; 
 Mon, 02 Nov 2020 09:10:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/26] target/arm: Use neon_element_offset in vfp_reg_offset
Date: Mon,  2 Nov 2020 17:09:43 +0000
Message-Id: <20201102171005.30690-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This seems a bit more readable than using offsetof CPU_DoubleU.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201030022618.785675-5-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 88a926d1df0..88ded4ac2c0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1122,18 +1122,13 @@ static long neon_element_offset(int reg, int element, MemOp size)
     return neon_full_reg_offset(reg) + ofs;
 }
 
-static inline long vfp_reg_offset(bool dp, unsigned reg)
+/* Return the offset of a VFP Dreg (dp = true) or VFP Sreg (dp = false). */
+static long vfp_reg_offset(bool dp, unsigned reg)
 {
     if (dp) {
-        return offsetof(CPUARMState, vfp.zregs[reg >> 1].d[reg & 1]);
+        return neon_element_offset(reg, 0, MO_64);
     } else {
-        long ofs = offsetof(CPUARMState, vfp.zregs[reg >> 2].d[(reg >> 1) & 1]);
-        if (reg & 1) {
-            ofs += offsetof(CPU_DoubleU, l.upper);
-        } else {
-            ofs += offsetof(CPU_DoubleU, l.lower);
-        }
-        return ofs;
+        return neon_element_offset(reg >> 1, reg & 1, MO_32);
     }
 }
 
-- 
2.20.1


