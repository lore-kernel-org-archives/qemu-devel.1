Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4A8C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1872098B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zrzoEfzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1872098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8QR-0002bn-UD
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD84C-000184-1U
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:24 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD84A-0006LL-8q
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id w2so1550014wmi.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KXRF7dKCMKNyNPHCpFwJuF+ejPlwLK3/fbYiZ44r5oU=;
 b=zrzoEfzsDLRhwM4Uy1TpUCviXcY8Q+EaCLs3x14CRyxCoF3nHsuzUsjoCH5APa+Z3H
 dhMI8R+aYOHBeDbHTNdl5N8g3sqatEhrgGblGv7+oVnTkiMHprc30HYOJRTBpXB95OIy
 TUOYzEtR4ZByJ0cAPgpxpNHFqiuntJ+7X9bjU5Llz9JgcF661EWj/SBVH/Z+1OmItKms
 ji7opVvoXnzMA+Hp36W4lE5ABQUXYNig5THBDAa8WI67tJOz2Map93jpFe7uQ+nwtn4Z
 2A0gLEUt2cVbAyEgw22GvqUQZmBRi9kBoaWlJP9bYpQnzcmJb5ah35O+esALxK5rrx8s
 w1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KXRF7dKCMKNyNPHCpFwJuF+ejPlwLK3/fbYiZ44r5oU=;
 b=ThLxrGeYN+8dGVR7t/Fh1lYvxY1T+7/WmvkYYsomFBi87U+qJx4Nl/uiJaEVUXyXc0
 xiMpLFJ36er+wdMbabOn8YHav/DprAHQQY6j0Z574qBxVo+SJbHVAgB9qCCAmCcxuYa9
 kFH2fC9EAqf79qrc2alxnru/jn1e2Gb8yNkad0hxq031vlplF+B9VWVlrj1G8vc6gAHc
 TI0HXwlU+LH9uPCzI2G19EsOdqlC4s8wPROTGUHnLiBPHZPWyqhV5+ihpAB5Y4mvfLg/
 +KWdZrvHrU+xUHd6BM0qpRVGS3rvAW0sFQwj9Frt49hSWyQLv5o7Utwb8HDVvt2UyD9g
 L4uA==
X-Gm-Message-State: AOAM531k+J0FKkPwjIPKY8mM5aJdLWBMKsnLIcPs+FNePh6RB7L2hSHH
 ZOvVxvHf5kTJuSNRbG3Vr9cEjBtOwl2V9XkJ
X-Google-Smtp-Source: ABdhPJwhfOCDgACcinqpKrkJ8y6WMQPaQXQYmf4HsL+UvKWekKfiX9h7EnbRYY1hOUb8ZfkZtrfbzQ==
X-Received: by 2002:a1c:24c4:: with SMTP id k187mr2266224wmk.148.1598973560529; 
 Tue, 01 Sep 2020 08:19:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/47] hw/arm/sbsa-ref: add "reg" property to DT cpu nodes
Date: Tue,  1 Sep 2020 16:18:21 +0100
Message-Id: <20200901151823.29785-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

From: Leif Lindholm <leif@nuviainc.com>

The sbsa-ref platform uses a minimal device tree to pass amount of memory
as well as number of cpus to the firmware. However, when dumping that
minimal dtb (with -M sbsa-virt,dumpdtb=<file>), the resulting blob
generates a warning when decompiled by dtc due to lack of reg property.

Add a simple reg property per cpu, representing a 64-bit MPIDR_EL1.

This also ends up being cleaner than having the firmware calculating its
own IDs for generating APCI.

Signed-off-by: Leif Lindholm <leif@nuviainc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200827124335.30586-1-leif@nuviainc.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 2a7d9a61fc7..7475aac0dfa 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -138,6 +138,12 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_EHCI] = 11,
 };
 
+static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
+{
+    uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
+    return arm_cpu_mp_affinity(idx, clustersz);
+}
+
 /*
  * Firmware on this machine only uses ACPI table to load OS, these limited
  * device tree nodes are just to let firmware know the info which varies from
@@ -183,14 +189,31 @@ static void create_fdt(SBSAMachineState *sms)
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
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
         CPUState *cs = CPU(armcpu);
+        uint64_t mpidr = sbsa_ref_cpu_mp_affinity(sms, cpu);
 
         qemu_fdt_add_subnode(sms->fdt, nodename);
+        qemu_fdt_setprop_u64(sms->fdt, nodename, "reg", mpidr);
 
         if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
             qemu_fdt_setprop_cell(sms->fdt, nodename, "numa-node-id",
@@ -717,12 +740,6 @@ static void sbsa_ref_init(MachineState *machine)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &sms->bootinfo);
 }
 
-static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
-{
-    uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
-    return arm_cpu_mp_affinity(idx, clustersz);
-}
-
 static const CPUArchIdList *sbsa_ref_possible_cpu_arch_ids(MachineState *ms)
 {
     unsigned int max_cpus = ms->smp.max_cpus;
-- 
2.20.1


