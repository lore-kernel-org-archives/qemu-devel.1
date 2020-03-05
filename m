Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36840C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CED20637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKyqsgyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CED20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tng-0004J0-5B
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPQ-0003tu-VF
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPP-0002s0-SP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:40 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:53125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPP-0002qz-L8
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:39 -0500
Received: by mail-wm1-x32c.google.com with SMTP id p9so7066096wmc.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=U58jT/n1eZn27Pw9G4/tDQIY/9rC1vRzTCSEllyVD4I=;
 b=FKyqsgySfbvki/zlVE5S98pY7I86551Og/0V174lCWlffnxmkQgzAzvhBmi72+SDg8
 QuwYvvF3dsZ64XcMK5awnawtNTr4wB9BBuQN8UnuQBsLpLuFH5BeEZ23JqxkQwvHfdr+
 gsA3tVf1A5QzmXv/WdDoLTILZsa4vCxjpchr1r13uiV9uUrY745X8iOWgjJ0yXrHCUkj
 KaIVYasiXgLzgkojNktLK7BR/UW6Q9uXnNXGBghMa/ZCEVZJmT4OVjmdXUMrZ/TQLT33
 ZXOCLIzLflQhYiuBzCIKbioNr/I7GH9ylO1RxfOlH0sTTOrLqfp60F7HXAKxZOhzOsFN
 CcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U58jT/n1eZn27Pw9G4/tDQIY/9rC1vRzTCSEllyVD4I=;
 b=Cq5kNonBonsUnmUYlDIw/5X8wic335yMT5uFcsHZMseajCLGtkS6X0gRocqhHT3TXE
 pqpNjIJynCrD6WSLg7GekwhB+/6hlkkYjp3GJWVIM4B1OVA7eu54qncGy0KUsDRCRwS1
 SMX0TOcPbSJSg+TTfud+u5Q49bukNrzT7fWJbl2O/MysVIiSWZck3M2Mpq01hNiOE6/3
 AJ3qSZXM1bPHAeEl1vnm4LztOpHgTExIhO6kGdZhEV+1aI2yRy9t72J+uyQgLW81cewU
 4hRMEdtRDxyUP18nd4qMhQmhDmMjet1q7VvryFGYIYud8lBkEDm+CF5VMuqXaULJdRtk
 WoNw==
X-Gm-Message-State: ANhLgQ02BlP44kKSD85p7vku62BEFAlSv70KcIZCFQTM9TkMHp0C7yGW
 4Qx1pVcluDNFlNKlI0TQXQy07ah1pHSshA==
X-Google-Smtp-Source: ADFU+vtgN33qfdLE9eRkGiLNpcxhHsWMuQA0+V4o8VjdYO3buzNuSql0IJ2hN8qf5QmZZ5TN4cGBlw==
X-Received: by 2002:a1c:4b0d:: with SMTP id y13mr10711393wma.4.1583425898368; 
 Thu, 05 Mar 2020 08:31:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/37] target/arm: Introduce core_to_aa64_mmu_idx
Date: Thu,  5 Mar 2020 16:30:56 +0000
Message-Id: <20200305163100.22912-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

If by context we know that we're in AArch64 mode, we need not
test for M-profile when reconstructing the full ARMMMUIdx.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200302175829.2183-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h     | 6 ++++++
 target/arm/translate-a64.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 9f96a2359f3..e633aff36ef 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -783,6 +783,12 @@ static inline ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_idx)
     }
 }
 
+static inline ARMMMUIdx core_to_aa64_mmu_idx(int mmu_idx)
+{
+    /* AArch64 is always a-profile. */
+    return mmu_idx | ARM_MMU_IDX_A;
+}
+
 int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx);
 
 /*
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 579180af0a9..c910a49b4e0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14300,7 +14300,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->condexec_mask = 0;
     dc->condexec_cond = 0;
     core_mmu_idx = FIELD_EX32(tb_flags, TBFLAG_ANY, MMUIDX);
-    dc->mmu_idx = core_to_arm_mmu_idx(env, core_mmu_idx);
+    dc->mmu_idx = core_to_aa64_mmu_idx(core_mmu_idx);
     dc->tbii = FIELD_EX32(tb_flags, TBFLAG_A64, TBII);
     dc->tbid = FIELD_EX32(tb_flags, TBFLAG_A64, TBID);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
-- 
2.20.1


