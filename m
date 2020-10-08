Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D148AC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE0921927
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bz7sT2Ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE0921927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQWvZ-0000tb-Ec
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWrz-0004F8-4M
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:36075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWrx-0005yu-9A
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id z1so6839757wrt.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=PNZt5eZzpygN/NHe9hxZ5YJUWkGZkxNu5QAdM0lAEmk=;
 b=Bz7sT2IxENPOnXhADBS8vO95PRsgXG8s2Wmn91ibGAKf4Uy31SR6glksxl9ZKvX4dU
 GELfriuECpAWudyTRdIE2PYpUzAZoWVUIA+IT9Ed8Hx90rEmDUn/VDm2fNSuc5wKKrMT
 WKTNFavJaEHu6DunemAqGmvCJy72wSUqN/Qnto6NgELQyFAqA3yCfwJ61ui9xnWppcFK
 xSiax+Qehli/0OM9HhPN5jjUhGwSBl9cmLBbi9kONHnlqX5BgZUCek5nwRHTvpwINExz
 E7GerzVss8jKIVCT3L3Q5rpQn4hmi7/jTn4kxt5abz/a/kMzvpFIYHSBPYsKEKD0L4h8
 7urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PNZt5eZzpygN/NHe9hxZ5YJUWkGZkxNu5QAdM0lAEmk=;
 b=CQjexUlg+s7F4csxI87a50WMjXoe7biFoZYNGsVcnce+kajvEnbXROicyV6RYOp6zZ
 kP0WvqWOlkldJ7MyARvvGQmoNI/b1KsKgjSosrPT0spMpWe3/R1nHDwLlb3FiG20ineD
 /HPaYJZHz2BMSat0qxR8rPCI5x9IJY7T+oTrfVtTR7t+KAbkqPZ4X1Pmo7ec5kDYXIxG
 j/QGL1YIXStflUwgCKuF6U/8FJNgMDCOq6Ab0ZDpW6BY/gfgGwzjICwwzO98GgtPIfMZ
 HzMHu4PBNsWOQt4ikgI2pMEiAVOG6vW6z+yZ2oBssRkZhowg2c12fNsp6oP5lhuOltlB
 EmzQ==
X-Gm-Message-State: AOAM533Xq2skYvpYBFHHzdpCijrmkCu94FwWuB+/F1tsx8mB6fLadKDx
 bpQkpydoVs0LTKx+QiYZNzbs8zrZmimdhSkl
X-Google-Smtp-Source: ABdhPJzTz4W4vRf0BmDvs2r9WCbTf+uVPH33bkoaSdMCNLr70NWRy1eubSi8UhVeESwzCH7RC1E2mw==
X-Received: by 2002:adf:a405:: with SMTP id d5mr3456528wra.421.1602167167647; 
 Thu, 08 Oct 2020 07:26:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j1sm7905104wrc.28.2020.10.08.07.26.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 07:26:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] target/arm/kvm: Make uncalled stubs explicitly
 unreachable
Date: Thu,  8 Oct 2020 15:25:52 +0100
Message-Id: <20201008142557.9845-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008142557.9845-1-peter.maydell@linaro.org>
References: <20201008142557.9845-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Andrew Jones <drjones@redhat.com>

When we compile without KVM support !defined(CONFIG_KVM) we generate
stubs for functions that the linker will still encounter. Sometimes
these stubs can be executed safely and are placed in paths where they
get executed with or without KVM. Other functions should never be
called without KVM. Those functions should be guarded by kvm_enabled(),
but should also be robust to refactoring mistakes. Putting a
g_assert_not_reached() in the function should help. Additionally,
the g_assert_not_reached() calls may actually help the linker remove
some code.

We remove the stubs for kvm_arm_get/put_virtual_time(), as they aren't
necessary at all - the only caller is in kvm.c

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-id: 20201001061718.101915-3-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 51 +++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index bc178eeb84c..f513702176a 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -344,18 +344,10 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 #else
 
-static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
-{
-    /*
-     * This should never actually be called in the "not KVM" case,
-     * but set up the fields to indicate an error anyway.
-     */
-    cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
-    cpu->host_cpu_probe_failed = true;
-}
-
-static inline void kvm_arm_add_vcpu_properties(Object *obj) {}
-
+/*
+ * It's safe to call these functions without KVM support.
+ * They should either do nothing or return "not supported".
+ */
 static inline bool kvm_arm_aarch32_supported(void)
 {
     return false;
@@ -371,23 +363,44 @@ static inline bool kvm_arm_sve_supported(void)
     return false;
 }
 
+/*
+ * These functions should never actually be called without KVM support.
+ */
+static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+static inline void kvm_arm_add_vcpu_properties(Object *obj)
+{
+    g_assert_not_reached();
+}
+
 static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
 {
-    return -ENOENT;
+    g_assert_not_reached();
 }
 
 static inline int kvm_arm_vgic_probe(void)
 {
-    return 0;
+    g_assert_not_reached();
 }
 
-static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq) {}
-static inline void kvm_arm_pmu_init(CPUState *cs) {}
+static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
+{
+    g_assert_not_reached();
+}
 
-static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map) {}
+static inline void kvm_arm_pmu_init(CPUState *cs)
+{
+    g_assert_not_reached();
+}
+
+static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map)
+{
+    g_assert_not_reached();
+}
 
-static inline void kvm_arm_get_virtual_time(CPUState *cs) {}
-static inline void kvm_arm_put_virtual_time(CPUState *cs) {}
 #endif
 
 static inline const char *gic_class_name(void)
-- 
2.20.1


