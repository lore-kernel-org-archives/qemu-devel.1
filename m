Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0012C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD03821D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJ0/OEYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD03821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pOB-0004Er-Sn
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pL1-0006nN-Lh
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pL0-0007cJ-Kl
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:43 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8pL0-0007bv-Fb
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:42 -0500
Received: by mail-pg1-x544.google.com with SMTP id z12so184921pgl.4
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dr35bRmDl5K2ZK/zV6tEHz3P5CK2kUhrH8hqSGr33Rw=;
 b=ZJ0/OEYLqfjbDLH2HPXWjjFaocOmukBiVGnzk0V+U8OA7hE/kfZ68Gr/1lSpMROAFk
 pRJKWCQxNS2/QIjxSFwbS60hW2/8hgQVGzJ+HYitny4NgKJec0USwyK6z0jMVKPHmS0Y
 Sm5ao3zmmc12Nw9vumEe9JcG/wPKSFjiOiasKfYEiTdNoK9JBVX9/LdpttrrDM9B+nuF
 ZDDnG9rMyp4g3fkU6g20pbGSK4pl7siJ3vRDjPSeDFYkR7QTxtBEE1L6w5hwKW9MgCsF
 PQH9aerx8NzYc2WB9Gk0QWHs4oZv+oxICiBhKl+uG1/z9Tm6qbU+NvexHSw74WUWlayl
 doYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dr35bRmDl5K2ZK/zV6tEHz3P5CK2kUhrH8hqSGr33Rw=;
 b=VAkjxsW8NpCO7A6ic5ahUjWWnpr2DiX5Me/jZ6SqBA2rQxTxD56U7AR5HY619AxT1L
 +DcdLGUC40M4HbrsjTPw6Wk5yzIVZJEb5Ic3+wcxVJyr/I7HT3KcUtnP4mQXEvsa1kQy
 tCKSpEmxwUGfu5wkH3PEAKbe5BsQLSYEh918hTPYJtQ9jUz+L/zBGnHcVBlD0YXdDJif
 q5s32u68d0gWaXbrLEvglMKHa+NurfeboUmvm5N7tgjuwae6wcy/oD3tQmCbG1C29a3E
 3mDDFhX/8GRWjm2+RSlLlkjhUgUvH3IgWzHLi611bCEA+DuJmbS+iWv7rDpMua7zFS+x
 XvuA==
X-Gm-Message-State: ANhLgQ3OTj73yOGS7qLVeSmLL5xKN+YI0sUHJvKOFCYXAkZj7Y9VYwl8
 z20zN1D6sFwpmTaqLqjuA8e1g6JtQBQ=
X-Google-Smtp-Source: ADFU+vvEJ6ha4LdilaG5Om6dsFOZqlnpl/z5zZXDvqpA0yV8uiT3FM1wjO/myfIwoBC2PmS1HjkahA==
X-Received: by 2002:aa7:80d1:: with SMTP id a17mr209275pfn.143.1583171921259; 
 Mon, 02 Mar 2020 09:58:41 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id s18sm99510pjp.24.2020.03.02.09.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 09:58:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 8/9] target/arm: Check addresses for disabled regimes
Date: Mon,  2 Mar 2020 09:58:28 -0800
Message-Id: <20200302175829.2183-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302175829.2183-1-richard.henderson@linaro.org>
References: <20200302175829.2183-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
index addbec91d8..0ef32d3c24 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11634,7 +11634,38 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
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


