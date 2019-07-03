Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDEEC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75CF621882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CF621882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibTk-0008Sv-Ir
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51697)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiaq9-0006RL-0v
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiaq6-0008Ff-7x
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiaq5-0007kf-Ld
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so1499534ljg.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=8AbRazPuGbBA4/wcOJ0NXPkCs6Kyha3rsVtogdXoPZc=;
 b=nxPdoBAvwM3WpmPx/z63Lup4gbfiecB1FiTcM5Gpb/KmiVca/wkn85A5xg5xhaBdmK
 D4O/0p8DZmP2+Hk6z61vooKHTv2evQeOct8nN5yhZfAkcc3GuuobQAkhrHFMgdcpfW22
 Yqn3N/KEM7nKNOhcbsZUll/vJRv/hyXuHSeTqFaBPnGuNYjwaniNBd2cLt+9Ai9AfAqn
 Be+cQx7K10FffNqzD431dNlG7i9NVE4QAQHZg9CuWHo8fStLUaA0fkeRmKfjYdcH3Q/k
 gXnoPYUGElaLs/qWGfPHoqrSdULO8yvFjJRXpmxoyYmwEYJ9G14UGhd1ZCh9mJ2p+bfX
 OPMQ==
X-Gm-Message-State: APjAAAXIv5ZjFroOqaom7OBjztwK/ObjdJZbZyP32gCtEbR8CGgpCsHK
 QDrR/frJAtwvVPKTyuVeh286VZbc+K7mcQ==
X-Google-Smtp-Source: APXvYqyntEe6/cQ3QzcERYAO3kMrAmy4lREpqg2kj8uDd6qVasZewNi+/M1+ksf8IyVIkrpBJ7yBMA==
X-Received: by 2002:a2e:9b84:: with SMTP id z4mr20728835lji.75.1562143313867; 
 Wed, 03 Jul 2019 01:41:53 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id o24sm326736ljg.6.2019.07.03.01.41.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:53 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:41 -0700
Message-Id: <20190703084048.6980-26-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.193
Subject: [Qemu-devel] [PULL 25/32] riscv: virt: Add cpu-topology DT node.
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
Cc: Atish Patra <atish.patra@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Atish Patra <atish.patra@wdc.com>

Currently, there is no cpu topology defined in RISC-V.
Define a device tree node that clearly describes the
entire topology. This saves the trouble of scanning individual
cache to figure out the topology.

Here is the linux kernel patch series that enables topology
for RISC-V.

http://lists.infradead.org/pipermail/linux-riscv/2019-June/005072.html

CPU topology after applying this patch in QEMU & above series in kernel

/ # cat /sys/devices/system/cpu/cpu2/topology/thread_siblings_list
2
/ # cat /sys/devices/system/cpu/cpu2/topology/physical_package_id
0
/ # cat /sys/devices/system/cpu/cpu2/topology/core_siblings_list
0-7

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/virt.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 487f61404b21..28d96daf8c5b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -191,6 +191,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
 
     for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
         int cpu_phandle = phandle++;
+        int intc_phandle;
         nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         char *isa = riscv_isa_string(&s->soc.harts[cpu]);
@@ -203,9 +204,12 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
         qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
         qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
+        qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
+        qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", cpu_phandle);
+        intc_phandle = phandle++;
         qemu_fdt_add_subnode(fdt, intc);
-        qemu_fdt_setprop_cell(fdt, intc, "phandle", cpu_phandle);
-        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", cpu_phandle);
+        qemu_fdt_setprop_cell(fdt, intc, "phandle", intc_phandle);
+        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", intc_phandle);
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
@@ -214,6 +218,20 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         g_free(nodename);
     }
 
+    /* Add cpu-topology node */
+    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
+    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map/cluster0");
+    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
+        char *core_nodename = g_strdup_printf("/cpus/cpu-map/cluster0/core%d",
+                                              cpu);
+        char *cpu_nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
+        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, cpu_nodename);
+        qemu_fdt_add_subnode(fdt, core_nodename);
+        qemu_fdt_setprop_cell(fdt, core_nodename, "cpu", intc_phandle);
+        g_free(core_nodename);
+        g_free(cpu_nodename);
+    }
+
     cells =  g_new0(uint32_t, s->soc.num_harts * 4);
     for (cpu = 0; cpu < s->soc.num_harts; cpu++) {
         nodename =
-- 
2.21.0


