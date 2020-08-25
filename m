Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513CBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E41120782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="Nl+O7UlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E41120782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAcBu-0000Qr-9d
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 12:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kAcBL-0008Gz-Ft
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:52:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kAcBJ-0003V6-KM
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:52:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id h15so6712045wrt.12
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 09:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fIVyrpVHMw6tNd0qd5YUw4P9aigzbhlX4LJYiIphK6A=;
 b=Nl+O7UlR0KSc9w/ZPf//XlYBzkvkzudcCbX0bJx7ZgY/uc6DnGZVoLEG2U3eV7HrmV
 50q6jDUKtMae+2lRRm6rTxDee2DYLGpL/6GyHObdoYjAiiK6IQr1B8+eK65+ctvKFSeg
 rJCtRRb5wym/O5a82S78/yBZObYNUSd5NIYhweDAdQBrZh61AkItUOX4Ta5/OU3iBDjA
 JLOm+rmV+FMiXDEXjFHKS2Aa5IY+rf1fLHBEQe8cpSW94HFw6NrXusZo2mtBkYSedopy
 5fh6Gh8Rzi0riiAipO97XRkRHWPlCTfddCJUZIC3yVt8H0hh+GOapsi1QmDiPW/yDvUf
 7gPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fIVyrpVHMw6tNd0qd5YUw4P9aigzbhlX4LJYiIphK6A=;
 b=eQRrg18SdayalTvBqH44iKm5nA2Z1r63BlNRqiE7MHt2aQ9wSZDdvjmAIrgPMm4DWs
 t8igZxeCGwdbF+OnEcXbrRxCl2aQ10GXuEV829uY5TSg29PCApZE0lWwye3kSi0YlklN
 vbDeq6kblfXn32tqqNUlz/nn6KWGASMMC0Biy4a79SeReZ/3SmnPi+mK5pbokNdw4u6a
 snhHF+8F8ah2LAvMyLHC1yeor4507SPZ70rf2cuHxZNJa0G/+vkLKx55QZwCIoOsrKVU
 fwkuhHsJsHdoZg+r14CVwtIGqTcie1eCCv2ZET3kwzpPNRP7WgW8QgcboB5B/gehVQq7
 LdWA==
X-Gm-Message-State: AOAM5305doKVuERScJcybkelv59nciva2klQLJxwmKv7dZlaboENOlOx
 aj6qxCdj1H0DaRGqJ8i/uGxrFQ==
X-Google-Smtp-Source: ABdhPJzsFmU+P/xZtsbSm2+Ko/ieKSMSeCqd6geInZKHzcO0/ARQnZNLbz86aKu/1cUZ/fqfrvgB1g==
X-Received: by 2002:adf:80cb:: with SMTP id 69mr12191966wrl.313.1598374339637; 
 Tue, 25 Aug 2020 09:52:19 -0700 (PDT)
Received: from vanye.hemma.eciton.net
 (cpc92302-cmbg19-2-0-cust304.5-4.cable.virginm.net. [82.1.209.49])
 by smtp.gmail.com with ESMTPSA id v9sm20281870wru.37.2020.08.25.09.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 09:52:18 -0700 (PDT)
From: Leif Lindholm <leif@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: [PATCH] hw/arm/sbsa-ref: add "reg" property to DT cpu nodes
Date: Tue, 25 Aug 2020 17:52:17 +0100
Message-Id: <20200825165217.7379-1-leif@nuviainc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sbsa-ref platform uses a minimal device tree to pass amount of memory
as well as number of cpus to the firmware. However, when dumping that
minimal dtb (with -M sbsa-virt,dumpdtb=<file>), the resulting blob
generates a warning when decompiled by dtc due to lack of reg property.

Add a simple reg property per cpu, representing a 64-bit MPIDR_EL1.

Signed-off-by: Leif Lindholm <leif@nuviainc.com>
---
 hw/arm/sbsa-ref.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f030a416fd..167c57a08b 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -183,7 +183,22 @@ static void create_fdt(SBSAMachineState *sms)
         g_free(matrix);
     }
 
+    /*
+     * From Documentation/devicetree/bindings/arm/cpus.yaml
+     *  On ARM v8 64-bit systems this property is required
+     *    and matches the MPIDR_EL1 register affinity bits.
+     *
+     *    * If cpus node's #address-cells property is set to 2
+     *
+     *      The first reg cell bits [7:0] must be set to
+     *      bits [39:32] of MPIDR_EL1.
+     *
+     *      The second reg cell bits [23:0] must be set to
+     *      bits [23:0] of MPIDR_EL1.
+     */
     qemu_fdt_add_subnode(sms->fdt, "/cpus");
+    qemu_fdt_setprop_cell(sms->fdt, "/cpus", "#address-cells", 2);
+    qemu_fdt_setprop_cell(sms->fdt, "/cpus", "#size-cells", 0x0);
 
     for (cpu = sms->smp_cpus - 1; cpu >= 0; cpu--) {
         char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
@@ -191,6 +206,7 @@ static void create_fdt(SBSAMachineState *sms)
         CPUState *cs = CPU(armcpu);
 
         qemu_fdt_add_subnode(sms->fdt, nodename);
+        qemu_fdt_setprop_u64(sms->fdt, nodename, "reg", cpu);
 
         if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
             qemu_fdt_setprop_cell(sms->fdt, nodename, "numa-node-id",
-- 
2.20.1


