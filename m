Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13DCC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDBE322251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfEPA0sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBE322251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQuVW-0004gi-VP
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 11:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQuUA-00044l-Id
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:39:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQuU8-00073t-R0
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:39:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id w5so10763078wrp.8
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m+57w4waUDsMvpjTdXukUzVLKUiAH7ggRqO2IkZWWK8=;
 b=zfEPA0sbIKc7BepKUD4ycqD72V2CdcgFW9Nw480YWGBnSAei9TCbuibGeZwVeUdlSa
 jBC7CkBhjL/iRfyVyYUVh17yW7Im8y8TtyEMpN17nbx9VhvHQ5coKwNnDLiP29d8a7tn
 H0J4H/vujHMu9AxWDVltkY4AO7ocMnbYctFzabS8/ucGkhIRsOikLq3ZHVVcxiidPb81
 V4bPPsQetOY2lXFKLajXyr09CcbJz4KchO+VdwCE4riLpJLjnH9RVryQWmhyZNxz/KJu
 mCwx5024Thk4ejD+LAMRaoPOQQDh+FRNozUnzs9ksUuf0JjJyLyK7RJga7eh8NqJJD5u
 U7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m+57w4waUDsMvpjTdXukUzVLKUiAH7ggRqO2IkZWWK8=;
 b=EY6AQWL9ImnG4o49hVX+jQPGjw+i5EdFfGtQqdSDNz/10FIeXVmJz4JSqRpNdn6+fa
 cIh6phIr5BKiONwI4mbxT5dbwjo/agiy7Lu4f7ogG0G/uxd8r1E1t9GV5sRMj8oJfc49
 vGyRi6AgpE54hrbbf48fm+scwxwazEeIHT3Uklx30BbWrqnuiWF+91hRMjVixVDLxTcN
 PxSt7aUZvbzw7cyU09DLPBoExoK6NDn3oG/AP+zydGxc4poJwJd/nYA7QyWU9IFYlYAF
 GfEe9Tojh37SsnZHLsK6dNzswEOm+ljJSP2pzVhShzF68aRuMrI92Dq8FP8xj0Ipczsq
 ihYA==
X-Gm-Message-State: AOAM533sYyVMUAgfTlJrdd8YSwAcYwKqLfG+wCvMMlG7T5DrdvfTlXhF
 i8IWXzcwqFPbR5+FdNxqck+6Mw==
X-Google-Smtp-Source: ABdhPJzRO5OYSD84zVXadug50AaLA0OPa+yrnkwj3ZzeJqTbfz/36Xkc1iOxrWcOLPVB9B6xYejbAw==
X-Received: by 2002:a5d:40c3:: with SMTP id b3mr17209904wrq.157.1602257946742; 
 Fri, 09 Oct 2020 08:39:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h3sm13050598wrq.0.2020.10.09.08.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 08:39:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/intc/arm_gicv3_cpuif: Make GIC maintenance interrupts work
Date: Fri,  9 Oct 2020 16:39:04 +0100
Message-Id: <20201009153904.28529-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Jose Martins <josemartins90@gmail.com>, Marc Zyngier <maz@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In gicv3_init_cpuif() we copy the ARMCPU gicv3_maintenance_interrupt
into the GICv3CPUState struct's maintenance_irq field.  This will
only work if the board happens to have already wired up the CPU
maintenance IRQ before the GIC was realized.  Unfortunately this is
not the case for the 'virt' board, and so the value that gets copied
is NULL (since a qemu_irq is really a pointer to an IRQState struct
under the hood).  The effect is that the CPU interface code never
actually raises the maintenance interrupt line.

Instead, since the GICv3CPUState has a pointer to the CPUState, make
the dereference at the point where we want to raise the interrupt, to
avoid an implicit requirement on board code to wire things up in a
particular order.

Reported-by: Jose Martins <josemartins90@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---

QEMU's implementation here is a bit odd because we've put all the
logic into the "GIC" device where in real hardware it's split between
a GIC device and the CPU interface part in the CPU.  If we had
arranged it in that way then we wouldn't have this odd bit of code
where the GIC device needs to raise an IRQ line that belongs to the
CPU.

Not sure why we've never noticed this bug previously with KVM as a
guest, you'd think we'd have spotted "maintenance interrupts just
don't work"...
---
 include/hw/intc/arm_gicv3_common.h | 1 -
 hw/intc/arm_gicv3_cpuif.c          | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 0331b0ffdb8..91491a2f664 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -153,7 +153,6 @@ struct GICv3CPUState {
     qemu_irq parent_fiq;
     qemu_irq parent_virq;
     qemu_irq parent_vfiq;
-    qemu_irq maintenance_irq;
 
     /* Redistributor */
     uint32_t level;                  /* Current IRQ level */
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 08e000e33c6..43ef1d7a840 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -399,6 +399,7 @@ static void gicv3_cpuif_virt_update(GICv3CPUState *cs)
     int irqlevel = 0;
     int fiqlevel = 0;
     int maintlevel = 0;
+    ARMCPU *cpu = ARM_CPU(cs->cpu);
 
     idx = hppvi_index(cs);
     trace_gicv3_cpuif_virt_update(gicv3_redist_affid(cs), idx);
@@ -424,7 +425,7 @@ static void gicv3_cpuif_virt_update(GICv3CPUState *cs)
 
     qemu_set_irq(cs->parent_vfiq, fiqlevel);
     qemu_set_irq(cs->parent_virq, irqlevel);
-    qemu_set_irq(cs->maintenance_irq, maintlevel);
+    qemu_set_irq(cpu->gicv3_maintenance_interrupt, maintlevel);
 }
 
 static uint64_t icv_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -2624,8 +2625,6 @@ void gicv3_init_cpuif(GICv3State *s)
             && cpu->gic_num_lrs) {
             int j;
 
-            cs->maintenance_irq = cpu->gicv3_maintenance_interrupt;
-
             cs->num_list_regs = cpu->gic_num_lrs;
             cs->vpribits = cpu->gic_vpribits;
             cs->vprebits = cpu->gic_vprebits;
-- 
2.20.1


