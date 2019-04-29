Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBECC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C149E2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uk2e4CRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C149E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32774 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLA6V-0004nN-U8
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:30:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9f0-00051k-8R
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9ev-0006pZ-CF
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:37627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9et-0006V7-PH
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id y5so180516wma.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=vtBrTkFqiiSUWIPlpjuEnbusTdYc8K9uQ2c0Vb5XVQ8=;
	b=Uk2e4CRZPxAmSSrRaATC4bj6htBawTpqAtVcIXO0RmmcWD801AWkhUB6Jk5O4x7BzF
	NMQ1MyJAiU/R5OmK6sOWUEG0+JZnHx5YGmNb9OXUREzKiGjJdiP/emcNHBenk/TJGC5U
	+U0xWtJSyWgfMTlRltGK242Qya2MDhZUO29vgpVyrKBgvngFPK+ee+ca3og7SkV24vi/
	vQtVcpFcUGY4ktwArg0o2SgHNugWl8kR4zE+JWhEku/bMIt44buA5V8Xy6JYOFZvkOQD
	QLMnFetkrXKYnVOWMm6VuCVz0LITYrdNc/qrWPTCZLhGxoGR+t6chTeVqFRs/HsaCIqy
	1WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=vtBrTkFqiiSUWIPlpjuEnbusTdYc8K9uQ2c0Vb5XVQ8=;
	b=lVq5NzSQfzVmGmC3fcPOslfUygbsXjGGpaOJtg2ypU0uU06oqXu93omdcnsFknxTuA
	Bqy8q/rDr5K/IAq7F6NveC6D+t6Ylpc9IZfatOghMIaamgnVR9upAjiAqQ6EXdz59pbr
	FsNeWHEhVPKM9RYwh86R2JswMpiN9fmN1Dasu81UmYy5tr2dYrhZbuBhSfIwq5TEBa4D
	2IyooY/b5C0xpZ4avCEHVg5AHkkRJ4qEghPBZotIlhc9yYSld/0JMpMINw4Eg6KUjg5q
	NW+qImlvBx4fYrx13F+2/Ywrm0+Y5BziWVDHbgevaQZEBepZY6WGHblDFZcn2nMh2qfG
	/MOQ==
X-Gm-Message-State: APjAAAVqdSoHT/TDpWk3NxV6A/cdFsWkxfCIEdyFslTeOZK5EXmBpft4
	cMqvCCIsIjty6Pkkiw+xxl4FmAmDYSU=
X-Google-Smtp-Source: APXvYqzN7kdeCZN21w2pHZ8e0/pf907Js9EG7r59Nz6GUIXDsBFKGlk64k7miJx65164Zt9ii4u/2A==
X-Received: by 2002:a05:600c:204f:: with SMTP id
	p15mr42988wmg.150.1556557261716; 
	Mon, 29 Apr 2019 10:01:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.00
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:11 +0100
Message-Id: <20190429170030.11323-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PULL 23/42] target/arm: New helper function
 arm_v7m_mmu_idx_all()
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429170011.pQlRSXolNDr9pQmX4jegA7u7lRo-LwShXknsEl0L_vI@z>

Add a new helper function which returns the MMU index to use
for v7M, where the caller specifies all of the security
state, privilege level and whether the execution priority
is negative, and reimplement the existing
arm_v7m_mmu_idx_for_secstate_and_priv() in terms of it.

We are going to need this for the lazy-FP-stacking code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-21-peter.maydell@linaro.org
---
 target/arm/cpu.h    |  7 +++++++
 target/arm/helper.c | 14 +++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d4996a4d204..920cf367020 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2911,6 +2911,13 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
     }
 }
 
+/*
+ * Return the MMU index for a v7M CPU with all relevant information
+ * manually specified.
+ */
+ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
+                              bool secstate, bool priv, bool negpri);
+
 /* Return the MMU index for a v7M CPU in the specified security and
  * privilege state.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 84e3790a9de..1ed5f1a2513 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13230,8 +13230,8 @@ int fp_exception_el(CPUARMState *env, int cur_el)
     return 0;
 }
 
-ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
-                                                bool secstate, bool priv)
+ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
+                              bool secstate, bool priv, bool negpri)
 {
     ARMMMUIdx mmu_idx = ARM_MMU_IDX_M;
 
@@ -13239,7 +13239,7 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
         mmu_idx |= ARM_MMU_IDX_M_PRIV;
     }
 
-    if (armv7m_nvic_neg_prio_requested(env->nvic, secstate)) {
+    if (negpri) {
         mmu_idx |= ARM_MMU_IDX_M_NEGPRI;
     }
 
@@ -13250,6 +13250,14 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
     return mmu_idx;
 }
 
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
+                                                bool secstate, bool priv)
+{
+    bool negpri = armv7m_nvic_neg_prio_requested(env->nvic, secstate);
+
+    return arm_v7m_mmu_idx_all(env, secstate, priv, negpri);
+}
+
 /* Return the MMU index for a v7M CPU in the specified security state */
 ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
 {
-- 
2.20.1


