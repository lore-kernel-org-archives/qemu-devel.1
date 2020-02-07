Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3535EC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D8120720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7+GNTRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D8120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04tV-0007y6-1p
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i6-0000yX-Op
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i5-0003LI-GA
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:22 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:35751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04i5-0003KD-96
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:21 -0500
Received: by mail-wr1-x42f.google.com with SMTP id w12so2980925wrt.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=NGxmYuCYm8SCNf8p1Ezg9MlhA8LSdxz3a0m3bCctsvQ=;
 b=K7+GNTRn/RiYIX8FDQLPvI3FR1rfE+FjlUVYSz8/Skbt9NSQFZepKjJGSKfJ84tXeH
 fjMscYauZjRKYzN7vBKvANoysr68jLxtHUCButPL90pF1Qi6W0Q7LZERfPccKE4tpXii
 3UCSaJWAJG8fLSpWgyUFt4bR44Cp+NqYRbVLyDyDSOf96UVgSaO8aTBoozUyvwThfcjG
 FUng7lUqFtXsVrpA/3qd44yimTV08V4ahoS8bw26d8lgHXvjcMj9450ZFXMq/8ZS74ov
 SnjqkOxe51IG0QROSZU3boCpkVr4Q4bLayvpaSLLgdwJsnGquuuKlLhYoQEfuTNaH+d/
 Y7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NGxmYuCYm8SCNf8p1Ezg9MlhA8LSdxz3a0m3bCctsvQ=;
 b=sbrEaYOVATSUdl7SSagQ5DC/pFMXHmHDqQ6++2qfVpj7IVcB5hZfVKOflq4DM/XSbN
 E5vQBv+Cc9Fsv0TIoHZukm9js+rhj6g7L9X1/CuS+FrA5agOjnQX0++W2/1ZpRZQlavu
 QRI3+B5LKcn7QfOuWIZ+lMUxIW7qimrxQly2O/H1k4pGB4DzC/u0IoPWCz/FfykLvuCL
 UHKXQ4OJPji2vhEOKE8WZHwk/dWDJP5I3XnbqeCjJQdiv5QXJ0VtwwwtIzSR/+DzWxnm
 cpdefId1MvU/swxz0d0poPPPDVe1NNNxIutuKb4Rgkug4og7KTyM1vWhp6/y2PBFcR12
 jCpA==
X-Gm-Message-State: APjAAAU1zB5lxUqiBDXfg/3CHVKxSIqj+ALNhxxjHprvHGnCq4taeMU4
 oTvZkVj/qQFI+Xi1xmsNiE9VUZp2mPQ=
X-Google-Smtp-Source: APXvYqzlztV1+lGbFHvw2sP7iKqpKYCIaJDL7iLXXQPILqvRapw3yFVNcWLfOFtqtvQjbwt8DggSfg==
X-Received: by 2002:adf:f507:: with SMTP id q7mr4979075wro.384.1581086060110; 
 Fri, 07 Feb 2020 06:34:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/48] target/arm: Flush tlbs for E2&0 translation regime
Date: Fri,  7 Feb 2020 14:33:27 +0000
Message-Id: <20200207143343.30322-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-32-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f9be6b052f0..3b7b459314d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4174,8 +4174,12 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
 
 static int vae1_tlbmask(CPUARMState *env)
 {
+    /* Since we exclude secure first, we may read HCR_EL2 directly. */
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_SE10_1 | ARMMMUIdxBit_SE10_0;
+    } else if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE))
+               == (HCR_E2H | HCR_TGE)) {
+        return ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E20_0;
     } else {
         return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0;
     }
@@ -4219,6 +4223,12 @@ static int alle1_tlbmask(CPUARMState *env)
     }
 }
 
+static int e2_tlbmask(CPUARMState *env)
+{
+    /* TODO: ARMv8.4-SecEL2 */
+    return ARMMMUIdxBit_E20_0 | ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E2;
+}
+
 static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
@@ -4231,10 +4241,10 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+    int mask = e2_tlbmask(env);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
+    tlb_flush_by_mmuidx(cs, mask);
 }
 
 static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4259,8 +4269,9 @@ static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
     CPUState *cs = env_cpu(env);
+    int mask = e2_tlbmask(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
 static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4278,11 +4289,11 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * Currently handles both VAE2 and VALE2, since we don't support
      * flush-last-level-only.
      */
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+    int mask = e2_tlbmask(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
 }
 
 static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.20.1


