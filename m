Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24F7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CF4221E5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NnLuiKB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CF4221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xXN-0007V4-Um
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k3xSk-0007CZ-1f
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:10:50 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:38654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k3xSh-0001iZ-L5
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:10:49 -0400
Received: by mail-io1-xd44.google.com with SMTP id l1so1073662ioh.5
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 01:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TviGzmtVooeSyONCBmDeM4dNkoolotdPP8RSZaeKQ7o=;
 b=NnLuiKB3M9BBUwK6Ivp+tfr1wgrcB2dVtHLFJLK3G5M7zD8ZVcpU+F8n1mLDr+8QX7
 jEwIsOVdjpwqq5wwpQbmgBnzV9U+J6n+aoT8+z3R+iedUYm8Sgrymxsb4sBNMDm46jdi
 OoZtB/mh1L99BGq99JUGlHhsROt4PcYEyGGaM28kH99B8T7GiszCu9tlab4pn+VW/EfL
 wVFSfWlHzJo3TSK+b0IRS3cnNVCydf+zItie7bCmpjvdMlXCUc0kG1YCTTKelDnkvTPS
 CwnX+vWK8IdqIEcz306Dj+u4Kb37g7NJQM4pOaOZPN9RXzqzisygEg1OmHGLagiH4raL
 5EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TviGzmtVooeSyONCBmDeM4dNkoolotdPP8RSZaeKQ7o=;
 b=eCkeMHQlsRwK2GbhnfZ53tysBvknBhSjT3G7pULUI7ZSbTMJgYnia6/wTGs/k0/k3R
 JVpSvMwbZWErBNSDuf1UCZmyghZcjlk6Yh6sU9d9q8Xid/sjOZ7YeJHoPrFIDQimmVyk
 Ln8Lhm4kQo0SERRpn7AOc4bqy3DpSuszE/p2HVgtlObWC18hbJTvjASSdbJ1z2uBlKMz
 arzeg035TmcrUeJHb03jluKrWaEZY54VfJGOv02A4OTRBkjKJYFw466H0n3BNBkD7UIj
 f/BgP7SSqZCQVKRmjwslCdlmUI1yq1G1SQuqOP7hnrnqiu76Ddrpfi1yamMQ1sL6joq7
 2gZg==
X-Gm-Message-State: AOAM530Pi+KJdrh7kXo1mA4X/87WaB9EFJYxFhYG6a3qRdsH7J875zXo
 URnix8KlKrxTsw+NWhs34799
X-Google-Smtp-Source: ABdhPJzbWE2PhJrPC7izkBXrhGIft8RwnixzjcRw8vrv/HWqOtjoXZzdMHja6Sn8a9Axo0m5dOjsbQ==
X-Received: by 2002:a6b:5d05:: with SMTP id r5mr3266184iob.14.1596787846498;
 Fri, 07 Aug 2020 01:10:46 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id l144sm6233546ill.6.2020.08.07.01.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 01:10:46 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: peter.maydell@linaro.org
Subject: [PATCH 7/7] target/arm/cpu: spe: Enable spe to work with host cpu
Date: Fri,  7 Aug 2020 08:10:37 +0000
Message-Id: <bf909c1f4904a22be0804cae9fd6f38ba4862563.1596768588.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1596768588.git.haibo.xu@linaro.org>
References: <cover.1596768588.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: drjones@redhat.com, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Turn on the spe cpu property by default when working with host
cpu type in KVM mode, i.e. we can now do '-cpu host' to add the 
vSPE, and '-cpu host,spe=off' to remove it. 

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 target/arm/cpu.c   | 4 ++++
 target/arm/kvm64.c | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 67ab0089fd..42fa99953c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1719,6 +1719,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cpu->pmceid1 = 0;
     }   
 
+    if (!cpu->has_spe || !kvm_enabled()) {
+        unset_feature(env, ARM_FEATURE_SPE);
+    }
+
     if (!arm_feature(env, ARM_FEATURE_EL2)) {
         /* Disable the hypervisor feature bits in the processor feature
          * registers if we don't have EL2. These are id_pfr1[15:12] and
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index be045ccc5f..4ea58afc1d 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -679,6 +679,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     features |= 1ULL << ARM_FEATURE_AARCH64;
     features |= 1ULL << ARM_FEATURE_PMU;
     features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
+    features |= 1ULL << ARM_FEATURE_SPE;

     ahcf->features = features;

@@ -826,6 +827,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
     } else {
         env->features &= ~(1ULL << ARM_FEATURE_PMU);
     }
+    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_SPE_V1)) {
+        cpu->has_spe = false;
+    }
+    if (cpu->has_spe) {
+        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SPE_V1;
+    } else {
+        env->features &= ~(1ULL << ARM_FEATURE_SPE);
+    }
     if (cpu_isar_feature(aa64_sve, cpu)) {
         assert(kvm_arm_sve_supported());
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
-- 
2.17.1


