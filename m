Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B25C388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7FE20735
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qtf8U7+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7FE20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyLX-0003Rp-0B
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJO-0001ME-MJ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:30 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJL-0001Fa-68
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417607; x=1635953607;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TzxgUt8qZfaREE4D9HrT8ndkP8t5MJfPtFf4kMe2y/8=;
 b=qtf8U7+zQnBuRL4wOWzd49aJhtDQgsjptwNezzqhTvtJPp/6Xydv9Zq0
 ZJ+RfxTEZMhpWu2hIi3PzfCJHz1+Qn4JGEe4u5nH9AUyXqAAHtuDpis80
 rtTWNX8RsKDs346MIpRUWWKjoF42wil2ijDKJ0aJVvLzORdGqn2vzw1Q2
 imqmYV3G+ECRNpOzFtwX7nVQjrmJWbP4wVpKNrgDNvwLj+7Ua8RM9uP5E
 eQAGWPi6gIgQk2Nf1ZbbesPQ3ybh/gKo/uESUHRez50r9vEW8kJ05eoDn
 TQh9UPyGJ4GAMaJPrZafzNxuG+F4npfp3GvDcn69EL+i35qdpVDhFzatR Q==;
IronPort-SDR: RFCaP+H0TMDknHLA0k+KnvOyuTtkyvrebUrMRyn+PGtgucrtWHT81z5szAg4BaDgweWmEngzjk
 3mOUGti4JmPvqDGGvxOlArIZMoWLCPly1ArOKI0hJ67C+waEwcg+eOx7JaM2/EwrYWxgwlOzHK
 JohXtpjwy2pdHb7Ze8FCflGxiVIOonumd616YIOx/RXCmKi81VTi2kIiIPm0+BJ+KMPO8z99Gp
 PsixK8TEVwnQdUsuG9esmSC+45GdX2I4xtF7ZCqpukqnqTHUjYDk4h9vR47HCHglFi5S2nSyY5
 lEc=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867450"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:24 +0800
IronPort-SDR: WWfRwdT+RgOZoqgRPAoROpkkg4+ywi7w+a6SJhGr4km9kZrQyfGyHQME7XIeYr33bleHolyphp
 tf0snJpjK7ldC5bn6f4eD3/miQ8FpkVe7RmdYiMk0JVIIKjHSE4vzdV4dMMyKNEcngia1vtDoa
 AYbpYYBNJfuJfmpiGYw2tPsTSdjhy2skjCallDTbYWySmpIlA5mFrivWen5UcYx0Fr/Sbq89pk
 4LEZEO9kuwbrTaZ8qp60AALI/8TWfqILlDYI5Y79idW1m1Hi+o+JCrxlbv85qbEvy5HBqdH0Iq
 I2BZlmeqCyw9xQnWBB91TV/A
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:32 -0800
IronPort-SDR: 9SxSLGmg9J+s8zAFGmKh7pwsbxWynnMIeHFyv4C6l9Dftkl7X5p8npuKZdA1xA3aNSCnK0/m1T
 Rpaq+dAiQYJEDv46gv6zotd7OpR7BEexpjMnGaLUCJ+Y8ZSV6LrdWIJg/bFQjK4rUgLIp4h9BD
 Lj4tpFzV8ZNkDvIUOUeXcbqgw3rpG7du4O31l9RRmDNCiblVvi5fR6yiwMn3f+SntAWqHF/RAd
 monrF3/mSH6kXHu3SvMJt6W7MXY9IOYHEpAVHEGiKfpwBnf/a32Fhx0rinQyASUEZjdg+x5FJ/
 BGQ=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:24 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 02/19] hw/riscv: virt: Allow passing custom DTB
Date: Tue,  3 Nov 2020 07:21:33 -0800
Message-Id: <20201103152150.2677566-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103152150.2677566-1-alistair.francis@wdc.com>
References: <20201103152150.2677566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:33:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anup Patel <anup.patel@wdc.com>

Extend virt machine to allow passing custom DTB using "-dtb"
command-line parameter. This will help users pass modified DTB
to virt machine.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201022053225.2596110-2-anup.patel@wdc.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 6bfd10dfc7..25cea7aa67 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -181,6 +181,7 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
 {
     void *fdt;
     int i, cpu, socket;
+    const char *dtb_filename;
     MachineState *mc = MACHINE(s);
     uint64_t addr, size;
     uint32_t *clint_cells, *plic_cells;
@@ -194,10 +195,20 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
 
-    fdt = s->fdt = create_device_tree(&s->fdt_size);
-    if (!fdt) {
-        error_report("create_device_tree() failed");
-        exit(1);
+    dtb_filename = qemu_opt_get(qemu_get_machine_opts(), "dtb");
+    if (dtb_filename) {
+        fdt = s->fdt = load_device_tree(dtb_filename, &s->fdt_size);
+        if (!fdt) {
+            error_report("load_device_tree() failed");
+            exit(1);
+        }
+        goto update_bootargs;
+    } else {
+        fdt = s->fdt = create_device_tree(&s->fdt_size);
+        if (!fdt) {
+            error_report("create_device_tree() failed");
+            exit(1);
+        }
     }
 
     qemu_fdt_setprop_string(fdt, "/", "model", "riscv-virtio,qemu");
@@ -418,9 +429,6 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
 
     qemu_fdt_add_subnode(fdt, "/chosen");
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", name);
-    if (cmdline) {
-        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
-    }
     g_free(name);
 
     name = g_strdup_printf("/soc/rtc@%lx", (long)memmap[VIRT_RTC].base);
@@ -441,6 +449,11 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
                                  2, flashbase + flashsize, 2, flashsize);
     qemu_fdt_setprop_cell(s->fdt, name, "bank-width", 4);
     g_free(name);
+
+update_bootargs:
+    if (cmdline) {
+        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    }
 }
 
 static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
-- 
2.28.0


