Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BDBC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC22620897
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IS2O6XuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC22620897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI1QO-0003mG-1B
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 23:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1OH-0000eV-Fl
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:21 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1OF-0001l5-Mb
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:21 -0400
Received: by mail-pl1-x641.google.com with SMTP id bg9so596574plb.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 20:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ttZlTeQRiqAfohcWiL5/T40b1TJUWiG1lTmcd0fZw3M=;
 b=IS2O6XuEJSiZJDGUq0SNt7l9x3joh9zRRBNSWAAlorBsl+/baV/rLWBCV8hzOETjKW
 6T9hSwktaRZXtoFESrfWRAqqiw/ZC4RqZzuBEhva8mZR26Giik8FqAQuHUw8zZO6cqLu
 UEMpbHazR94QtzFhXCaDmjSFJBJLSOyT+9k7EZqEFWQ35lYcK/TQXtpTbXjE5AnskadY
 hTfiS1dompDH67PeT1mJvSGyfrY+kL8hmR8m7bd6nlkQuAZeo2KeG8Bo8k6YLqeOrhSc
 gIsN5NELvw9RRM/zDgs7ph8FCp3i1zQHAJRMedmL1MVxIio7JJCYjYvY8JhciecTP8kQ
 ywgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ttZlTeQRiqAfohcWiL5/T40b1TJUWiG1lTmcd0fZw3M=;
 b=OV2iaT/GPuwiZv6vtdkigSqsxKPULA4StfVqRd4GrS0D8LObuD2NhQpEAl/ez4o+dk
 JyaaOibTbnb++mmJkTXfJuQlTKzJnfATvvS+9jbVVHfrRjf708pKPHBLuRXyLlFKKhEl
 eItXV2VxgS61i16Dr+n+l7N3pfiPICdhGn5Ed6pwbhNjVS66jowy9PsjwtmQemWIcYR4
 Jj06aawGbn1a9gDAGJDMAIGG5cC/iObG+yrk+x8tA6G9316obmRHnCtY2miGXXkd+wHx
 OZLQxFhU1/g2XBtv8018/MVFuZEUESWOhhnpR6HSrz4koACAWArxSUAJNpm22tmRDQ5z
 FGDQ==
X-Gm-Message-State: AOAM5313RnVXauCWmOyFCLP5AiVijVPCg9e8lb7AB4pfw/JKcnXQUPwJ
 kmQ5MvAom0yiU2wh/mFMn668
X-Google-Smtp-Source: ABdhPJy0JO5zBKRti76UC/J0h3yeDUA9lFPulm1VFKxD+Oq4Zrb9Az7xNZZbxPKrWkoVuIABRO0TBA==
X-Received: by 2002:a17:902:b193:: with SMTP id
 s19mr17147865plr.125.1600139538439; 
 Mon, 14 Sep 2020 20:12:18 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id g23sm11551776pfh.133.2020.09.14.20.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 20:12:17 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v3 11/12] target/arm/kvm: spe: Enable userspace irqchip
 support.
Date: Tue, 15 Sep 2020 03:11:47 +0000
Message-Id: <6e6ef8d1ea15180514a6f1540933aca4d59939a8.1600135462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600135462.git.haibo.xu@linaro.org>
References: <cover.1600135462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=haibo.xu@linaro.org; helo=mail-pl1-x641.google.com
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

Since the current kernel patches haven't enabled the
userspace irqchip support, this patch is not verified yet!

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 hw/arm/virt.c    | 2 +-
 target/arm/kvm.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ee0831922b..bdb1ce925c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1715,8 +1715,8 @@ static void virt_cpu_post_init(VirtMachineState *vms)
                 assert(ARM_CPU(cpu)->has_spe == ON_OFF_AUTO_ON);
                 if (kvm_irqchip_in_kernel()) {
                     kvm_arm_spe_set_irq(cpu, PPI(VIRTUAL_SPE_IRQ));
-                    kvm_arm_spe_init(cpu);
                 }
+                kvm_arm_spe_init(cpu);
             }
         }
     } else {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 58f991e890..7950ff1d83 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -820,6 +820,11 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
             switched_level &= ~KVM_ARM_DEV_PMU;
         }
 
+        if (switched_level & KVM_ARM_DEV_SPE) {
+            qemu_set_irq(cpu->spe_interrupt,
+                         !!(run->s.regs.device_irq_level & KVM_ARM_DEV_SPE));
+            switched_level &= ~KVM_ARM_DEV_SPE;
+        }
         if (switched_level) {
             qemu_log_mask(LOG_UNIMP, "%s: unhandled in-kernel device IRQ %x\n",
                           __func__, switched_level);
-- 
2.17.1


