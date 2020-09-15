Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F33C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D3620672
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifSRseTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D3620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI1Rx-0006Hg-RS
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 23:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1OA-0000L2-FV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:14 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1O8-0001iZ-M5
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:14 -0400
Received: by mail-pf1-x442.google.com with SMTP id o68so1134737pfg.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 20:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W+V3obnXTS2moUn5807WDrMB34yhPyYZkE7Y60hl+S0=;
 b=ifSRseTT+IWW7cF7o8md//hp9KC4y2VFoKEda5+zNgS5OgbVUI75l1wLZoBfX7lPOJ
 xSWO6wfLFj9roXdVz4Fzbh1tXGv3Yu97dDQqO7I8lINsz9U7zrf/Tao+OvLzQXUITarS
 /4lbI5seL2WtvSMwZy1dWTcNsPAbrXU7toSnJWlYPLALgQGBH2S9d2tZOBQXroOVxe4U
 4HJAdOIXQN95zsyzKgcUbVJFIa4RkG1H650i0LxCzT+5pxrXG5vH0ZgNcZgk9oZg7NGv
 fwuZGfcme0iIYTRUh1uCvE3uLTC7jsWFnGlt6GErb/4YsNdNkroZgxiYqxXVySIi+1HK
 paKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W+V3obnXTS2moUn5807WDrMB34yhPyYZkE7Y60hl+S0=;
 b=VnYhD2+Ly/6wrZdVynBmbBw79xPbTE+zTxaxTrgYx9iVKZqFfJ0ZAZzcHAMgHwuLPm
 XcTSBTMhwVWq66v4XXhzmmWQ8/lZ44XS5cF/maYwEqNM95zL3S2w23ZyCbirado6TE31
 tRZEWj1qE3ysz42u0f6AhpAnXSeHMeqhDTjLFrSirSkFKqBG+O2gOeq7ymabYhXpv1nD
 opanjEm7QuHAU8os6mwzZiuGX/QU1gC+ZV6OyhcjK6PwOeziKnkzSvSTbmvAIpnBJKat
 9821EQoHBbBpESuQxaLXdPGZO6smw2kq5sv0MSAQblig5PDhIQCM9ObnstOnQ7431Xv8
 nk6A==
X-Gm-Message-State: AOAM530egDuRSy7eYxbtkxqHiNNYHomTrDblbS2hGb2+zluQvTK2mLnq
 Epxg7Y46FIz6W6qiJU/PZY2o
X-Google-Smtp-Source: ABdhPJwes4vNo0kWiasqZCEl/gMjelpQm40X53QFAaBZ9xkNlNu46Y/p6ra0vW1osMEbl17WB1Ngrg==
X-Received: by 2002:aa7:92c8:0:b029:13e:d13d:a12b with SMTP id
 k8-20020aa792c80000b029013ed13da12bmr16460143pfa.19.1600139531540; 
 Mon, 14 Sep 2020 20:12:11 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id g23sm11551776pfh.133.2020.09.14.20.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 20:12:11 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v3 06/12] target/arm/kvm: spe: Add device init and set_irq
 operations
Date: Tue, 15 Sep 2020 03:11:42 +0000
Message-Id: <cdd78c54073f1bcedef391b3d08b4a520690756f.1600135462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600135462.git.haibo.xu@linaro.org>
References: <cover.1600135462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=haibo.xu@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 target/arm/kvm64.c   | 33 +++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h |  5 +++++
 2 files changed, 38 insertions(+)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 8ffd31ffdf..5a2032fc9e 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -450,6 +450,39 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     }
 }
 
+void kvm_arm_spe_init(CPUState *cs)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_ARM_VCPU_SPE_V1_CTRL,
+        .attr = KVM_ARM_VCPU_SPE_V1_INIT,
+    };
+
+    if (!ARM_CPU(cs)->has_spe) {
+        return;
+    }
+    if (!kvm_arm_set_device_attr(cs, &attr, "SPE")) {
+        error_report("failed to init SPE");
+        abort();
+    }
+}
+
+void kvm_arm_spe_set_irq(CPUState *cs, int irq)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_ARM_VCPU_SPE_V1_CTRL,
+        .addr = (intptr_t)&irq,
+        .attr = KVM_ARM_VCPU_SPE_V1_IRQ,
+    };
+
+    if (!ARM_CPU(cs)->has_spe) {
+        return;
+    }
+    if (!kvm_arm_set_device_attr(cs, &attr, "SPE")) {
+        error_report("failed to set irq for SPE");
+        abort();
+    }
+}
+
 static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
 {
     uint64_t ret;
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index f79655674e..bb155322eb 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -348,6 +348,8 @@ int kvm_arm_vgic_probe(void);
 
 void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
 void kvm_arm_pmu_init(CPUState *cs);
+void kvm_arm_spe_set_irq(CPUState *cs, int irq);
+void kvm_arm_spe_init(CPUState *cs);
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 #else
@@ -397,6 +399,9 @@ static inline int kvm_arm_vgic_probe(void)
 static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq) {}
 static inline void kvm_arm_pmu_init(CPUState *cs) {}
 
+static inline void kvm_arm_spe_set_irq(CPUState *cs, int irq) {}
+static inline void kvm_arm_spe_init(CPUState *cs) {}
+
 static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map) {}
 
 static inline void kvm_arm_get_virtual_time(CPUState *cs) {}
-- 
2.17.1


