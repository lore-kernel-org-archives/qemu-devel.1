Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE2CC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5E92064C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="APeewc8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5E92064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrj0-0005ah-I1
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTraE-0008RB-JK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTraB-0003V4-CW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTra5-0003PZ-AX; Wed, 29 Apr 2020 14:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588185434; x=1619721434;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O7jL6iWlSIEmOeLlTVLecE6kMsdHolcxkpW6c3HjIWE=;
 b=APeewc8SLinXzReE31C3ZVzUmdbDlZ/WSVbV/Ub/ctjt515duKD5o+PB
 L7AW0iZuiw3vWcE2UIBoNUIIHJ+gD81HMG7lVzl6WJYP1MVVEeUjb4drD
 i5JihxrG6OA2NeNzPhYp7cOId4b6O/b4fwdbRdi/h6z5C93gzpb1dxO7N
 Mb9r7lAX33iC62SuKLTIP/6crOlLX6vIM0iivsSNUc1W2IJGlcJov250W
 KSX6Wry5Eo2MEzK3HPGOLvq5wY5fMnKSIGfR/mbMi2CIn8N3rrm73uhPT
 Fa/5ogfnXgvtW4oAgq3RW81IY4cVSltyrhC4Exgkw1AqnXPpbZ2CDYPxN Q==;
IronPort-SDR: LOCm9Not8pjUFJhyBPd+z89woasG4fV87YetsjEVZ98CSClOLamz8nbnBQSLicC7/fktn0Td1e
 TTSOMUcRZnyxBlRP4sZP+ttZ1Ly+g+MfqgWu8Sm3vxnM4yNfoPkgxNef2K5UrYxNLbXc5kFWTE
 D/oL6Oo35M7KP2GbBtKndGMtSaAypB2lZeVY3HfnR17/SAByRJyc+Xi7+XJWwFWSay9/GiiTVK
 0/OdvV03tqFgXL/OAmtRyiPdD6S4r3TU+JLwbGaOIbP6t5cF8/923bFK1EHJvIhJV4KW+2YLDJ
 lfY=
X-IronPort-AV: E=Sophos;i="5.73,332,1583164800"; d="scan'208";a="137935144"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 02:37:06 +0800
IronPort-SDR: 79Gem3mkFByogtgz/CvaPvjnpmN3c6MBM7Yi61e5YUcQ6N+Hb3JVGRxunVa7ZNAdYAAop5Iyi9
 1wfE3aRsWh4QzISv4kw3MxCbn9eCLndZs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 11:27:10 -0700
IronPort-SDR: v8gHI1QJExYs2uLQ0iBbeX557HXKLtOlZnxdDaJjhApS1nqkNXXPQfFwZB+NcqbFvcj4o+Odg7
 S0XcFGsyZKqQ==
WDCIronportException: Internal
Received: from cnf007834.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.55.253])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 11:37:04 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL 07/14] hw/riscv: Generate correct "mmu-type" for 32-bit machines
Date: Wed, 29 Apr 2020 11:28:49 -0700
Message-Id: <20200429182856.2588202-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429182856.2588202-1-alistair.francis@wdc.com>
References: <20200429182856.2588202-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=381fbd49e=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 14:37:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: Alistair Francis <alistair.francis@wdc.com>, palmerdabbelt@google.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

32-bit machine should have its CPU's "mmu-type" set to "riscv,sv32".

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1583585319-26603-1-git-send-email-bmeng.cn@gmail.com
Message-Id: <1583585319-26603-1-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 4 ++++
 hw/riscv/spike.c    | 4 ++++
 hw/riscv/virt.c     | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index eb0abcae89..0dd0efaa68 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -160,7 +160,11 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         qemu_fdt_add_subnode(fdt, nodename);
         /* cpu 0 is the management hart that does not have mmu */
         if (cpu != 0) {
+#if defined(TARGET_RISCV32)
+            qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
+#else
             qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+#endif
             isa = riscv_isa_string(&s->soc.u_cpus.harts[cpu - 1]);
         } else {
             isa = riscv_isa_string(&s->soc.e_cpus.harts[0]);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 5053fe4590..98697a244e 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -102,7 +102,11 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         char *isa = riscv_isa_string(&s->soc.harts[cpu]);
         qemu_fdt_add_subnode(fdt, nodename);
+#if defined(TARGET_RISCV32)
+        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
+#else
         qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+#endif
         qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
         qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
         qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 85ec9e22aa..c621a970aa 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -229,7 +229,11 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         char *isa = riscv_isa_string(&s->soc.harts[cpu]);
         qemu_fdt_add_subnode(fdt, nodename);
+#if defined(TARGET_RISCV32)
+        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
+#else
         qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+#endif
         qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
         qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
         qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
-- 
2.26.2


