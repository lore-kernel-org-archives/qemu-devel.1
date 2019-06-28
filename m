Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9585EC5B579
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D4F205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D4F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgvHO-0001I7-N8
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 14:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55028)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgul5-0000EX-K0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgul2-0000lu-7o
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44359)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgul0-0000fj-8f
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so3318506pfe.11
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=8AbRazPuGbBA4/wcOJ0NXPkCs6Kyha3rsVtogdXoPZc=;
 b=bL53O1FKeCSg/7ZXiMZjaoxtaH17jt8pXMtEy9I4/sqIs8dZ9zHmVnih5bUnjF7QNC
 XN1Fvkw8DiSMsFOB7damuJyyUZaCMSGANxzn0wrknGREM7TRoUIF5U+98UrJu396IsQI
 Rn+/H3pLhwO9oaHuHrVNPBL1BuaZ6Apg383CWpN1f1IAtKV+hlAsP6Ffjbebl4/Z+Kak
 1P/Vksm2Cj6M/ILsX1ilHbgm5Ph8+lcw9JYCjpJDn0QJBBR6leZnIE03oPulNv9r+/Qr
 qM3iiEx23ryCMh3rk3k/5RPjaUoKJsUrckJrgig6Wy29LHwbwy65hd2azQUT2xAvsZu5
 yBrQ==
X-Gm-Message-State: APjAAAUE2Fq3rqQzTGGtD5jrQYVIfD85qHfIFRg/l3bIvCuVlJUqACxD
 zRkfc68IH9j734ZK7/17jrYBh1zgbxO2MNuu
X-Google-Smtp-Source: APXvYqxfodMerfjoAXuAZBJVvxFtBLdj0y5A0PYRaLJYrY0ggS0qGIs+o+tz1+mErYtldZexIfaOsw==
X-Received: by 2002:a63:c20e:: with SMTP id b14mr10160941pgd.96.1561743230047; 
 Fri, 28 Jun 2019 10:33:50 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id i14sm4626583pfk.0.2019.06.28.10.33.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:33:49 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:32:18 -0700
Message-Id: <20190628173227.31925-26-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.194
Subject: [Qemu-devel] [PULL 25/34] riscv: virt: Add cpu-topology DT node.
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


