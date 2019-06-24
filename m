Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049F2C4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C311920663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="alT2L9e/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C311920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55486 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfYc0-00084c-MZ
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 19:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51256)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0714f841a=atish.patra@wdc.com>)
 id 1hfYbR-0007av-1H
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0714f841a=atish.patra@wdc.com>)
 id 1hfYbP-00066K-P9
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:42:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61229)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0714f841a=atish.patra@wdc.com>)
 id 1hfYbM-0005zp-DW; Mon, 24 Jun 2019 19:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561419740; x=1592955740;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=94tX/HnMqhSklm+vTa89vm8kXlhCBjhpnBv26y+knTE=;
 b=alT2L9e/pAAakEdT9nsJOux0u78Qt1K+G8/qMn6dsheRpzGj/nABn9cA
 ZrJR4Ztn5ormn+qNbo4VEIVRNxaV7i7XURh88CDIarF77G6i1ah1qv77e
 nlmey/23QWE2YFnvDoZ3Yp/N3WXkib4FV0BFArIVstiapWFjJblxKF/06
 +kL3fYCBjl0Gm0s9lpQEuvEwWIjy8KY/eiuKCDs6udNbzpg9/r52KWv3b
 fNQvMy6ASWbLHz6oU1+vEcjQJOfMaMKWACs3dBZyMwJsFdUXMC7Y2WZuf
 ULNT3Xc3N6RFtPJRNZS4zGTys9B7Ok3IRRgKzyeT5QIyliIdRKXwv0E9+ w==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; d="scan'208";a="217801147"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 07:42:06 +0800
IronPort-SDR: iWXFNbab6CAcv6Jiv5SkWCca5hZVdS2BSYRm28Je4kvZjmf405L79I99Y3jmk4Vyb/7wOviulP
 Y6KvU6UZhOBjsDXqETZvvCnKhZFU+5EpuuYqbimaksOCfTCWlURMz/p68hw3eTAe9osiuS4ogK
 h5fZpC9nR6JQWmhuBJY/YzrDq1NNR7W5BSak2jpSLOGGjv2/ZLmZzv7/D20SItZ2TXPKflmQBV
 vMb/TyUcES6hgiPLI5OvM6DNZgDvI6WNshIiZw56U9MGIx7ZtbdIhfmx2GKjAFwbylXF5DTEIT
 nluRSX4VimQA/Qff/zgfI49L
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 24 Jun 2019 16:41:25 -0700
IronPort-SDR: J7rg9QJz4pbNTv9xWe3D7wtiFzIoJ1WqZB2HuIgLewP5yvC+RdAudGTdhfuHr9Fmp2jlS50bh2
 g+Q4hFlcfZI6e2hrgZsGOc1vu6JwjgqZEfFN5uMyoBA1kEe9hMZ+CsCrsfgbKWvFml2mHzb9+F
 bfjgADlZUlhQCnT8TBod0wdyLM8ZupCheOA52wK6Jbz64No58FYN2HjZ/Fdhm0JNFb2FZyg+pb
 wRohb5uaKddht9/0cCaU+ZlZXyq2jHzekMHygtUdIgR/a1u1mtQw9hPDB7h8Jy2+Kf6OreEjP3
 L18=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO
 jedi-01.int.fusionio.com) ([10.11.143.218])
 by uls-op-cesaip02.wdc.com with ESMTP; 24 Jun 2019 16:42:04 -0700
From: Atish Patra <atish.patra@wdc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 24 Jun 2019 16:41:44 -0700
Message-Id: <20190624234144.10768-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 68.232.141.245
Subject: [Qemu-devel]  [PATCH v2] riscv: virt: Add cpu-topology DT node.
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
Cc: Atish Patra <atish.patra@wdc.com>, Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/riscv/virt.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 84d94d0c42d8..45a1edcd6c4a 100644
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


