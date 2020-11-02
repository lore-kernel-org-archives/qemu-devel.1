Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AF2C4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B026C20715
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAMqMRPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B026C20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdc4-00066b-Km
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdM1-0001DY-5L
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:49 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:55352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLy-0006d6-C0
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:48 -0500
Received: by mail-wm1-x331.google.com with SMTP id c9so8605910wml.5
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dOaBvJdurD+84xPf+pPC2Y9lDQ6drzzzVrYottzGd7A=;
 b=iAMqMRPCmtm0Sde3NfHc/VZ/YbcsryubxrXIsqXNe/J2Gdg4TByaanosW+JWGhQvgL
 dCbSiDz+2jRa8biQe82ThMRKDCFeuL41hxAP5R2qlF4X/YPd8N8MzOTYbzsLuIahQO3p
 HI8OXKa2t2bwiIzMTZ3rMxmZ1bekPhcYhfGDjXHh+Sb4GY9BM5aZpCQPLqz6yzHfzScM
 xZ1EUogrznibXRLnh+fTxTYQ7nXmm7z2f1dW2NY9nxmgEiVLtdHCLUaXrjYzWkeGfDBn
 3kavUzZjnfuu8JmjJSXx7DV5G9O9hEDYWUssxQa71I4agrOdekVRK0kOp9ozRnd1R7xd
 5Iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dOaBvJdurD+84xPf+pPC2Y9lDQ6drzzzVrYottzGd7A=;
 b=YHEs95vY6IoEwRZgFfUzTiPjNqHDf7WxALpDPR7SUU1pV683a9339cMAFo8uWMfW9i
 YjafIPwngaX6kS1yzKALOt3Im9x1Xo0GSosNFpcSyx9XHxtQj1S0LtN/X91cGz5J0Wuj
 J/FEYzM9Sb85UcBQyXA0Rbj5NsyZQF0n2MO0xdyKYvfNK4IWPeZM/Ygs2jlBNQ6AYCel
 m4BqZfGcwF6q5zp/+SYMJMhiaJVrRsTbekqpjWAx30ep0YYM7EMfjERpVzHJU2mlEHdv
 h1C/89P3baGKmZa2lvj+ZYuDAfzhkr2MRDjqnyRGI9RLwgQbRb3crQanAP7EMqlII/a4
 CQaA==
X-Gm-Message-State: AOAM531+vSlv/ERDOGlIytT0GXmG7UEPCS4AU0oPL0UaHbXuVhiNi0Cz
 ToCE7efRWBBeIXch5zRu0unxzRoQnFYI7g==
X-Google-Smtp-Source: ABdhPJyhaGxI8p+EbjeWfjowZ0vsU33vqeZKIhpMa/z/rPL6DycCQkfCa2OzTQjSxpwBIJzjvU4Etw==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr8240495wmi.42.1604337044754;
 Mon, 02 Nov 2020 09:10:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/26] hw/intc/arm_gicv3_cpuif: Make GIC maintenance interrupts
 work
Date: Mon,  2 Nov 2020 17:10:02 +0000
Message-Id: <20201102171005.30690-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
Message-id: 20201009153904.28529-1-peter.maydell@linaro.org
Reviewed-by: Luc Michel <luc@lmichel.fr>
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


