Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EC4C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F7120936
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pgDpj8RM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F7120936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBijX-0002uu-VC
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBiiA-0001Kc-3E
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:02:50 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBii8-0002HA-FO
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:02:49 -0400
Received: by mail-pl1-x641.google.com with SMTP id t11so29328plr.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DZszukU5Z/VedP7Gi8MxkvM7fSfNSRPJAs1Yn+4Y17M=;
 b=pgDpj8RMQnzchc4VU898wPTuz0IG0elIuqpcdNREwyfQazG+mQP+pAmTCzcZO0iBrZ
 uZDYmOwCBar5VVIXWzzkWCIRuEGm7gDwP+t2AH0hNSfEUd9CHafH1Mc3o4K1GvkFX+Iy
 2jhdl6PVhRmPmwP2WssvlLH7pNyX87ApnbFuIBIQN2d+wn0lcM32nmjQUeD6bt6yr0Ot
 +HLcN4yBrwQ2XdfRZeWkV6KzwvbcZbN2GF0Z+yvirHyd09fP7TzwTVNhKjR5W4DIC90Q
 vdKfDWcZdS4m886OcsKFX+hWqDz8SH1cZKz2ZeXAqAaYeTf4S/VxKAarufASZqQ1jXlD
 EdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DZszukU5Z/VedP7Gi8MxkvM7fSfNSRPJAs1Yn+4Y17M=;
 b=dAkj4hOOxxaGnVh/fWBeJRw84Mh2C3lHEgDcqpcyaooPxmYzuAf/IV3qC4sVZiQI3/
 bPoL4tRTAMXmwvBkTjANgcPjgHGus989PalmuEvQhdvRQU7m0D57sl36jKQynRoaU4ZQ
 qK2OtYVF09Z+/bEz6i6sKp7+9uoTMYQVlQDjnwXqRFUQLVP+65hOdXklEAO8SRxTckeR
 OJs4oFEWbcP5ggLcSN+xOUFPP10xBPPl8F7ociFGktfehhCCWqD5a3tD/Ghlyj9TOrnO
 CHQh1Gr1lBERCBwcfaddik3Au0Pksm4rM/DNbk8Nde1JMBWOt8MHJMbTM3SjHlO86SpY
 GAEg==
X-Gm-Message-State: AOAM5311N8+qnNrHCagyVpmHdr9WAKZOnQXXroTlBi06+AozP3YOEieu
 KtH/i2YrIItoJxl9LXTXrOnW/7L5icEXWw==
X-Google-Smtp-Source: ABdhPJy2AO1cDvIKPeCQSm40tX4Ne11oTcOvrCGY6TuOoCSYrE8XwL1T1Zb1XnMTqwpMwsstIkv7yQ==
X-Received: by 2002:a17:90a:bc09:: with SMTP id w9mr182920pjr.43.1598637766597; 
 Fri, 28 Aug 2020 11:02:46 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w14sm41656pfi.211.2020.08.28.11.02.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:02:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] softmmu/cpus: Only set parallel_cpus for SMP
Date: Fri, 28 Aug 2020 11:02:41 -0700
Message-Id: <20200828180243.443016-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828180243.443016-1-richard.henderson@linaro.org>
References: <20200828180243.443016-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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

Do not set parallel_cpus if there is only one cpu instantiated.
This will allow tcg to use serial code to implement atomics.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 softmmu/cpus.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index a802e899ab..e3b98065c9 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -1895,6 +1895,16 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
     if (!tcg_region_inited) {
         tcg_region_inited = 1;
         tcg_region_init();
+        /*
+         * If MTTCG, and we will create multiple cpus,
+         * then we will have cpus running in parallel.
+         */
+        if (qemu_tcg_mttcg_enabled()) {
+            MachineState *ms = MACHINE(qdev_get_machine());
+            if (ms->smp.max_cpus > 1) {
+                parallel_cpus = true;
+            }
+        }
     }
 
     if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
@@ -1904,7 +1914,6 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
 
         if (qemu_tcg_mttcg_enabled()) {
             /* create a thread per vCPU with TCG (MTTCG) */
-            parallel_cpus = true;
             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
                  cpu->cpu_index);
 
-- 
2.25.1


