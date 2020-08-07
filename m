Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01396C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D4F22C9F
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tTSRJKGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D4F22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xUl-0002D3-WB
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k3xSg-00073T-PX
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:10:46 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:39053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k3xSd-0001hX-MH
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:10:46 -0400
Received: by mail-io1-xd43.google.com with SMTP id z6so1063893iow.6
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L/G09uSg2yJJtjqwnmBQeFoDjYpnvCt5OlRmmWUK0Ac=;
 b=tTSRJKGfAxOBsFsSTy7WUzO2js2DVnRgl7sVSHksknJ19BC/jkJYUodydEAAVkKYWZ
 qGaXvRoMm48WvYyGkCkfdBKN2MdKuk0XEa/SshlYAlzNljcrnmRIBG34Hh8WFlvLx6TS
 Z3pv+08BliwfJsSVGwTigJT+CF4wDpCbUAXDWr1BS2ehv1AmPa8JZFSCBYKCe4qvdoRk
 qfgqzNE2R8N99gXJp4XozOKp/FSmRjTunknJ4893vkgjdm8iyX7dFCwv4ACNyEMcU4Rb
 dX3aAiGjK7TOBsP+NCLmaB8KC2DTHa6OddcoqaC9NpOaeADYQae/LmwK2M1ygl4gvZGS
 oMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L/G09uSg2yJJtjqwnmBQeFoDjYpnvCt5OlRmmWUK0Ac=;
 b=rndKWEOugFupsW1KXzKongMN5u6XSXIGwXutvoA/jt+sOUWYPzCRlNY5Vb5uMqCg+v
 PxSQY2zCH+jh5spEAfnkcVw/JTzaCeIl6ttumR8tg3IGkpZ+p6ZW9shYyOnn25ngSOws
 8YczPIgzsKt+/FbMYm3OGO3H2QNnSX0+tPSK+OllKKNYRUPAUtZzxm+kg4qmYSM0Q/fF
 txi1zefPwodfB3HEJLbCpcxKy5/l874AXM/IecRDa9qliF48r93vBFJrtFjTfq4mbL2K
 xSiWS1ceH60C3motE5nMtWG4d3mUaKrIAKAPNto17wXQyrS7bzqPEFusKkBTMJfg3Vmc
 kq1g==
X-Gm-Message-State: AOAM532glkTIUVZ0rk4gFzzSxWwDrIO5XUKIayECWWbBWsDLN/xMMFBz
 AU/Td6PXPMJFdQRkn3CuAjWO
X-Google-Smtp-Source: ABdhPJww0NcK6/jtcpUN+OKO9mPTY9nU3sQAgUiKkXmTrQ2icKFVY/UdxRpppbejkRPuiZN2uRpNrw==
X-Received: by 2002:a5e:d519:: with SMTP id e25mr3334981iom.36.1596787842680; 
 Fri, 07 Aug 2020 01:10:42 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id l144sm6233546ill.6.2020.08.07.01.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 01:10:42 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: peter.maydell@linaro.org
Subject: [PATCH 3/7] target/arm/cpu: spe: Add an option to turn on/off vSPE
 support
Date: Fri,  7 Aug 2020 08:10:33 +0000
Message-Id: <c4ab709b684bf6505a9721163564d2223d06c49d.1596768588.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1596768588.git.haibo.xu@linaro.org>
References: <cover.1596768588.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd43.google.com
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
Cc: drjones@redhat.com, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds a spe=[on/off] option to enable/disable vSPE support in
guest vCPU. Note this option is only available for "-cpu host"
with KVM mode, and default value is on. 

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 target/arm/cpu.c | 28 ++++++++++++++++++++++++++++
 target/arm/cpu.h |  3 +++ 
 2 files changed, 31 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 111579554f..40768b4d19 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1122,6 +1122,29 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
     cpu->has_pmu = value;
 }
 
+static bool arm_get_spe(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    return cpu->has_spe;
+}
+
+static void arm_set_spe(Object *obj, bool value, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    if (value) {
+        if (kvm_enabled() && !kvm_arm_spe_supported()) {
+            error_setg(errp, "'spe' feature not supported by KVM on this host");
+            return;
+        }
+        set_feature(&cpu->env, ARM_FEATURE_SPE);
+    } else {
+        unset_feature(&cpu->env, ARM_FEATURE_SPE);
+    }
+    cpu->has_spe = value;
+}
+
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
 {
     /*
@@ -1195,6 +1218,11 @@ void arm_cpu_post_init(Object *obj)
         object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
     }

+    if (arm_feature(&cpu->env, ARM_FEATURE_SPE)) {
+        cpu->has_spe = true;
+        object_property_add_bool(obj, "spe", arm_get_spe, arm_set_spe);
+    }
+
     /*
      * Allow user to turn off VFP and Neon support, but only for TCG --
      * KVM does not currently allow us to lie to the guest about its
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9e8ed423ea..fe0ac14386 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -822,6 +822,8 @@ struct ARMCPU {
     bool has_el3;
     /* CPU has PMU (Performance Monitor Unit) */
     bool has_pmu;
+    /* CPU has SPE (Statistical Profiling Extension) */
+    bool has_spe;
     /* CPU has VFP */
     bool has_vfp;
     /* CPU has Neon */
@@ -1959,6 +1961,7 @@ enum arm_features {
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
+    ARM_FEATURE_SPE, /* has SPE support */
 };

 static inline int arm_feature(CPUARMState *env, int feature)
-- 
2.17.1


