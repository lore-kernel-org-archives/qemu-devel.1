Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48073C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E65D2077C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQh+F+4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E65D2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36612 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNxP-0003Ej-7L
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:17:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfY-00055v-KR
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfW-0001V6-JC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:36 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfU-0001Qs-Fy
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id n25so25318242wmk.4
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Bad+ohxUQ2aXQF4pfMXnuYXIWQ2Nayau0QYhuZSUXeA=;
	b=xQh+F+4AbZ+JCj/OZ/rPi5WMngHxfn7bzPGmvSBmXWAksdoKPWFbXxpRxG+ubwvYzr
	xMuGppCtKP8bU2c0rfGv0rB6FmHFLCP8kPXniXAgn/uOVyapMzSBZq0nUbQPmUwTIFyO
	9j9i/9aWuzWeNIJfun9jaWvbNk89jz9Dv7EJZAzAYMwIPEKHFMtG3vp7LlOOepW7dP5G
	AyFEn8yODfKJ6LtFT6c2+gumefP6ofHSDDUXhySESONyYP9IjaAAOWtbY/nHCW2N5QRh
	WFciEQN+3hqik5lXeP/HwyyHv0Ffyb63k54R3JCI+aiMclp3aZDgh8VjNOZZ9kcryJzT
	yyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Bad+ohxUQ2aXQF4pfMXnuYXIWQ2Nayau0QYhuZSUXeA=;
	b=juPA5JVBqcogd6FvuCDwqGKWCRHlXGxXSZ7HNBLvTZHKSfv/00WZG1xOF4f936Soip
	pr0rIFuf1ucD8dgI3lMQih8xBJKPPgx//gF8YhNNbO8y6Lc5Pbywx18PYJMrsCM5RLYC
	+Udkifxhsk9YhUDTQxsr/6MZyiKoX89VNij9wl0oXXKOHbM+kshHk0TsE04UN8AIM2bP
	ZifjgjLu/Ya5vlYiVffq7+AR/gdwvoD0c4Ry5uNVy3v/wyeCQMtTGONav1C48OJ9mWBm
	UN9J3paea2SEJuUyy1viz9eWicqjSqD7PZ21gowtXys+uWCb/iQMYUQ8/iOS0hdLN+aJ
	H/VQ==
X-Gm-Message-State: APjAAAVSrS4Qnxn2tF6eXBH1yRp6j+orLZEP1/limjFq5U9ATf7rw2to
	3/WmC6tZbjnKc4R8a93tGxpDaw==
X-Google-Smtp-Source: APXvYqwCwOsyF7xm5StMQ+0Gl7Rnfk9xS5aaqHRR31UM6URdlacOLi2dhQQu/zPWFZxeQjOJYd879Q==
X-Received: by 2002:a1c:80cd:: with SMTP id b196mr26034521wmd.84.1555419507531;
	Tue, 16 Apr 2019 05:58:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.58.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:58:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:38 +0100
Message-Id: <20190416125744.27770-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 20/26] target/arm: New helper function
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
Message-ID: <20190416125738.M6_zErhvw6RVJMDayfEnirrm4re9tGEIKEuFlHEZqV0@z>

Add a new helper function which returns the MMU index to use
for v7M, where the caller specifies all of the security
state, privilege level and whether the execution priority
is negative, and reimplement the existing
arm_v7m_mmu_idx_for_secstate_and_priv() in terms of it.

We are going to need this for the lazy-FP-stacking code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Suggestions for better function name welcome.
arm_v7m_mmu_idx_for_secstate_and_priv_and_negpri()
just seems way too long and unwieldy...
---
 target/arm/cpu.h    |  7 +++++++
 target/arm/helper.c | 14 +++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 500e0ab4c5d..0a1b82dc996 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2912,6 +2912,13 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
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
index 2feb3f664fe..c8e30b40366 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13235,8 +13235,8 @@ int fp_exception_el(CPUARMState *env, int cur_el)
     return 0;
 }
 
-ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
-                                                bool secstate, bool priv)
+ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
+                              bool secstate, bool priv, bool negpri)
 {
     ARMMMUIdx mmu_idx = ARM_MMU_IDX_M;
 
@@ -13244,7 +13244,7 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
         mmu_idx |= ARM_MMU_IDX_M_PRIV;
     }
 
-    if (armv7m_nvic_neg_prio_requested(env->nvic, secstate)) {
+    if (negpri) {
         mmu_idx |= ARM_MMU_IDX_M_NEGPRI;
     }
 
@@ -13255,6 +13255,14 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
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


