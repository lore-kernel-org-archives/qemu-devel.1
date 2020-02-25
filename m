Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29945C35DEE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEEF524650
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Te07B5xB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEF524650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Ql6-00010I-5b
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 22:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Qfx-0002yd-76
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Qfw-0005Nh-6S
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:25 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6Qfw-0005NL-1V
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:24 -0500
Received: by mail-pl1-x641.google.com with SMTP id a6so4894920plm.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 19:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+H7GpCgYZHS/IW315wViv17HgfT/NtNKXlKqXRLBSps=;
 b=Te07B5xBZN1kP0q1x/cXkOyyjpYcyqFvd2MnJaUsHPx/z462Mr9BigvmgCaxVwSHjC
 7bilDqYP2cdo5M/W6PRdpwSF2rKCbjhGgReQS2uU/Rph6IV79bz3xRALh86X4U6XBMMw
 C2m7CGgiPOadoIGTPeS3Qxk4aDKFUB7+8jZCpuEIJqTjtz7ZGEhyGi7oxAMjuFITZwLA
 chURZGnTLA389QWQ5HxUY3Tv7WuSbMmmSFyp/BtWd3MQmA/JX1JNihtSSib5nJjDOUn6
 xy4Yye1JTPAkzWUJl6EMvLZbiOFr/YC1SlexMUwSotk8lFg0UyfC5rZahmHLUCoi9LfQ
 9MDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+H7GpCgYZHS/IW315wViv17HgfT/NtNKXlKqXRLBSps=;
 b=LrebtAI8jYnzGyfafHFZkgin9vPoRP4RoCA2E5RBtTBdWnCvmPqW2uJnwulhABwg07
 Rkew6Rrn8nLTrl9dmLhOMcpoOj4W5wjs8KunNBlO5QvRMkLJ5v0wZnc18LUTDS9nOaqr
 x2boO1hNiB5n0+t/97FpRHgXGdzZB/HbaeSrHCCtMzC+NdWHzABVPd40dY6Ej01Xz4Wk
 pLlmIt+n63W4AAzQpxdfDItoH4C9MelhntOd/pEox9GqckGSMkRiNv3fMo+8TdWb9F2h
 rS79Uhfp8fr9eoklHTaiW1rmMqaoui8wgO6OChn6p9QtDh9ytikQnZzSrJ87MLA+kfw2
 Gw1g==
X-Gm-Message-State: APjAAAUCOZkQfdGUsd4hKKsVqw24BfzGiH5HxnIlaR6SelM1cP+NHJlt
 MJpyUcqHNs8ajLbYlyHCxyqasvf5gaE=
X-Google-Smtp-Source: APXvYqxVW0JybJVcHmryWXPSmJZTSsIeIAOC+lsnYSGPr/5d0hU6Ch4Iz2brxMOrNsObytnwIWuzEg==
X-Received: by 2002:a17:90a:af81:: with SMTP id
 w1mr2741808pjq.14.1582600462711; 
 Mon, 24 Feb 2020 19:14:22 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id q66sm14975242pfq.27.2020.02.24.19.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 19:14:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] target/arm: Check addresses for disabled regimes
Date: Mon, 24 Feb 2020 19:14:13 -0800
Message-Id: <20200225031414.15649-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225031414.15649-1-richard.henderson@linaro.org>
References: <20200225031222.15434-1-richard.henderson@linaro.org>
 <20200225031414.15649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We fail to validate the upper bits of a virtual address on a
translation disabled regime, as per AArch64.TranslateAddressS1Off.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7cf6642210..2867adea29 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11615,7 +11615,38 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     /* Definitely a real MMU, not an MPU */
 
     if (regime_translation_disabled(env, mmu_idx)) {
-        /* MMU disabled. */
+        /*
+         * MMU disabled.  S1 addresses are still checked for bounds.
+         * C.f. AArch64.TranslateAddressS1Off.
+         */
+        if (is_a64(env) && mmu_idx != ARMMMUIdx_Stage2) {
+            int pamax = arm_pamax(env_archcpu(env));
+            uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
+            int addrtop, tbi;
+
+            tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
+            if (access_type == MMU_INST_FETCH) {
+                tbi &= ~aa64_va_parameter_tbid(tcr, mmu_idx);
+            }
+            tbi = (tbi >> extract64(address, 55, 1)) & 1;
+            addrtop = (tbi ? 55 : 63);
+
+            if (extract64(address, pamax, addrtop - pamax + 1) != 0) {
+                fi->type = ARMFault_AddressSize;
+                fi->level = 0;
+                fi->stage2 = false;
+                return 1;
+            }
+
+            /*
+             * The ARM pseudocode copies bits [51:0] to addrdesc.paddress.
+             * Except for TBI, we've just validated everything above PAMax
+             * is zero.  So we only need to drop TBI.
+             */
+            if (tbi) {
+                address = extract64(address, 0, 56);
+            }
+        }
         *phys_ptr = address;
         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         *page_size = TARGET_PAGE_SIZE;
-- 
2.20.1


