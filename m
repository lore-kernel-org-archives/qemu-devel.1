Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2836C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F83C205CB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZh++ogd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F83C205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxEW-000152-OU
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDwyl-0007RL-PD
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:41:12 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:35856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDwyj-0004aN-Ij
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:41:11 -0400
Received: by mail-pg1-x532.google.com with SMTP id p37so3170417pgl.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 14:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+IpDS3pKsg+orX5M7DofjfKOj/+sV/QvHnOyEKwjMnE=;
 b=UZh++ogd+TpI1ahfhOsvV8lmQ10uIbCS2TlFQAk55jKxEx7gb8+SRVEtfPMkHqFk7L
 i7IFDGrDbBzCM/sukMj6VDhzC7rsPRRfrgYh/OQSWw11Zi08ingehHkI2tDJpHxqPO66
 74KaRXbC/RgMqOVf3poGEXq5DwWijn6yMuyGn/f2KcVC4DGkHmXZ7QHx8UUTatfcnPLj
 PXognyJCXXE4m9qjKAjw9rsGSf84c40PDkwU9dZa+YiG6q6tRUInMKozqqrMEj3OIS5+
 N8oM2vQfdSd6VY9muJHnZ+dlYiCKUuK8ja/3YqtkUEqqEXdfUltcGyQbv/Rlxsp80EBL
 mcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+IpDS3pKsg+orX5M7DofjfKOj/+sV/QvHnOyEKwjMnE=;
 b=jbprJrt+u5vSSU59X9wjJJ5zo4LLhZ4pl+JCJ/dxUe9wwgJ6VSzawGC2dMAidWFotZ
 zxgUB8KU/LB5zXPK90VqF5f+abknWHnT/E0ir0Gqcp0LJlWk/5dJUgszVcjcFOco9F6M
 sqf95YreAX20TMCdjVaKNynRbuW6lR6xvIK8SIgx8yguCf4KQhet+KDIemo0qb94VZoK
 umNd0bvi5B3sMRitGGMWmHWtw4ZIl8zCwwuHt95dbq17PMIVAGYqwPgrPzM0uVK/uFCc
 fwvVEhmUFBi/6ErVLIq+2oRni+nIet2FTXFxvfdtkjmCYRR3yqiY+rdyRozXnLEyAP4E
 Jgtg==
X-Gm-Message-State: AOAM533jGwKv/djWbprafTlRRISwnl+zej50ddz1H+YtknnX9141JalW
 jEnP3sMZrfGT0j3crDnH9jSs8M2yAmDsUg==
X-Google-Smtp-Source: ABdhPJx0zu/UJAqI8jxJ8vR6QB+eotQx2U3XX492DvUytR0UT8lm+8PD9YkkAFyLwL1zs8SkqQ57YQ==
X-Received: by 2002:a63:fa45:: with SMTP id g5mr4510243pgk.448.1599169267417; 
 Thu, 03 Sep 2020 14:41:07 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v17sm4113290pfn.24.2020.09.03.14.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 14:41:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] softmmu/cpus: Only set parallel_cpus for SMP
Date: Thu,  3 Sep 2020 14:40:59 -0700
Message-Id: <20200903214101.1746878-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903214101.1746878-1-richard.henderson@linaro.org>
References: <20200903214101.1746878-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not set parallel_cpus if there is only one cpu instantiated.
This will allow tcg to use serial code to implement atomics.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


