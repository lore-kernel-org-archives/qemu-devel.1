Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542A7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F406B20657
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="phru8ROn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RTuFlFi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F406B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jduvx-00018U-4d
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 08:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jduuu-0007gy-7B; Wed, 27 May 2020 08:12:16 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jduus-0004C6-37; Wed, 27 May 2020 08:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590581552; x=1622117552;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=jMwIKVKzoezZ9UrQ5CaFazmiJhSecaVBfa5zHeN8SeY=;
 b=phru8ROnpHeCTil4wFm+8RiT87+4jugVciQtb0kaKNWJCpY+yya4iUut
 pJJSAMYxjyZyV54sYX9wtfNvk3rXBn7rCk7UUKLfQmUcKxDD99JVbEofL
 VxTLSoTi5cswpHdYqKm7E5nfgPSWHlEh2Uj81A4U1yOef0vTkiGEF3MlU
 9TDbd6EpfgpURYqvMMLBHDmmrojS/o36RpmZdGT2aZQXeihiIdf4jNrA6
 mQKGWYcbqutvOP8rvgWhcdjl+F+nKwawl7ypNWN/MCySTHD965o4KFnGf
 74CYSgQUOAzWKW7En4oASmtnKY1tapT5FdHk+GIIPpCQPSOlu+7xBVh1n Q==;
IronPort-SDR: 8LhHd45QpJrVPp3g/2HouB2vrd6K3visDmqy2CkqaVhnwdcusao04Pny5wV0AfKAgZmZpSOnXt
 p5m30jBtiT7ikx3mmg+6CSjUwtLsxBeaRMiSiZ3XFVDmim3Ljn5bCAEKd1Xp/3zd9VueskxUuk
 tyriFQu0q1X0ZnWcZ0SPqvnto9Dv3tATrECvJqP3odSbKq4q5fPoDcpu6WdQVpY6TBwosrXVyU
 /H3szqBGdktKZ3RGHHUwV20etuLIryq0cjejHeeUF/qWY9Gemi0f5eA9BDPseDlyzqVb4qH6LB
 z/4=
X-IronPort-AV: E=Sophos;i="5.73,441,1583164800"; d="scan'208";a="241425838"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 20:12:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKxjfX3vRks9Logc4vDTW7q27TWQTfEZUXbkLFPClyJ4F0xFukgD0wLQhltQ430rEZovJq0wc51IeWmjuykj+p1EyY65OCzrfFh9KEVhdPcLX11/D+Sclt3kciA1yqhZEcrLmDgjI1bnhzS9Vq6ey/bgcxXaeIXd9oF2ll00EzUpCHoXyUehK7Xm2F05Bk8Wsi/s3g2L19cDXP0zobUR5Ce3wLO9Eu0Mzcrlx89UiE4gB2dPLwL69/4ArfVvxnesbRJ0zwfaUFVsZ1GbbROFFYzHueVpxAnHjJjddyVR//p8uZAmjxd3LSVfliSB1Nq7Bn4LmVv2ZCoeJCl+7FHuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WboayNL9QfWqcXdFOtaA3tdFsROsOMIkwI1rdSJh7gA=;
 b=g4utNK4h+ptDOFIfuk2w4wm3g64DBjx2qExqEhU/6LsqIms3qk94ESCjJP1KqWEOBtZZPb346lipb1PFatxIV9GivWVkp0SN9p9fHtL1w08gCIyJX1DmP8bdPFfwxiy6NgwF2JEQZwARp1lMwVnyfxiqI5XmcLFrCWTcxxH1O0kqpTemcmqoceycWCnC1Y1N2CLFSKFsZdNGaY3FlXNQC7zTLzVNfzwIwfcOTzeVcQ4jRGewn9elBnRYILk8esKRK8X55eSSK8swpY41r5/n2gZbcULdMdFJmewxU1UbLf4l0yiOcSuJvzXHDYgF+V3FW1rrQxCTZpD498BK0NCnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WboayNL9QfWqcXdFOtaA3tdFsROsOMIkwI1rdSJh7gA=;
 b=RTuFlFi2gTXR8pSwl37C95JVyWWdQCEQyXAjU+HyZsLgIYpez5Tj55w9lMuizOsF8AmQkbWBNnKEAkFSEKVEAZyPjeuxSOGklGY8V9yHjl2fPTVI4GRlVxLH7WLeKDkxyt3UPtYrd7GFUIg41MyfuxzMsY+h3cYOCzchUSghmqU=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4473.namprd04.prod.outlook.com (2603:10b6:5:2e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 27 May
 2020 12:12:10 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3021.030; Wed, 27 May 2020
 12:12:10 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v3 2/4] hw/riscv: spike: Allow creating multiple sockets
Date: Wed, 27 May 2020 17:41:29 +0530
Message-Id: <20200527121131.251007-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200527121131.251007-1-anup.patel@wdc.com>
References: <20200527121131.251007-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::27) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.30.5) by
 MA1PR0101CA0065.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend
 Transport; Wed, 27 May 2020 12:12:06 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a9359ba-a7ac-4ae6-dbb9-08d802372e33
X-MS-TrafficTypeDiagnostic: DM6PR04MB4473:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB447323F586F6CFE61BDFC1338DB10@DM6PR04MB4473.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kb9KNcXS566gp1/RMD3vTeYnWM57W0NFVRn0kyia+k+hSZa/e7+3DSbwRi6vmL0+tfZxNeLwkcPuDLihDU+tEDlGhouTcQ1xFdNwof6Wb+XepqywpaKJZ7e7yQ9HU4cyW4zwvdFDuei8CTYfxF1ovik9Irrx+y48kmVUsZtsQuVfF5z/yI3l6ex9QtZfqnd3LECV259iVlJr5zhvlfG+Rn+uSn+Jr5Kzxc90Uuz3cT81ZdKxhB6OQpt9yV0iCpBAiizjtmanIaFLz8hGKxlj1XS3xk+ysmfl682cmw5U53cYePGPM04a/87azFr8qx1gquffgD/MeQD+UfTItekr6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(83380400001)(36756003)(5660300002)(55236004)(44832011)(1006002)(16526019)(6666004)(186003)(66946007)(8886007)(316002)(2616005)(110136005)(54906003)(52116002)(7696005)(66476007)(66556008)(86362001)(956004)(2906002)(1076003)(55016002)(8676002)(8936002)(478600001)(26005)(4326008)(30864003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: q2SWLzhM7dbOz2nWDW0wS+/XyfkZbf+XJRwOw5PXQeBF1vFyXqXCjSYIbgT8hynpMtPVdbD7WGLSh2jnnNmre2HWzSsEqCt3vofNkfy15xA8izfewhjipGUWV4r2Vw5g4HuKPfShwQcj8qvPhtVK8SpAKuzyrltn78O5yyk+8LrosXTj0cvs9v3si3Mp/2b+nql2PsPHn67A4Ndgc3G52E0Q9zy5i/pZG6GPjJz/Sc+vr57FLe8UuEA4m8YHC9bCIrNPjOhVLO5GfvTWDpRr51tr7fQt5IJlmC8UFRANyvFL0n8sNKaT97NboEWO5EpYhdOrjeRsLqdIGuTBHrcvGV+arKn5PAjsqTPh4wSuigBDyMRPK4CrlyRhb4q96K2leKDsTY6cgRzqPOIJfKvP68LuCm+EFm7ash4SzO1cZYjeJcE1CSitVAVTX/A4+01BmF20fIAfGLpPckIarMf0czQezqvw9jZYMOeVggC87HQ=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9359ba-a7ac-4ae6-dbb9-08d802372e33
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 12:12:09.9069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRHnh3nR73MvxPsXFfR5+I9lS2Vj+G0UsqADk35axDntiK27lCXzkJGODOQvA+crg2OdTaDQGts9l8lpzxyKJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4473
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=409226bd6=Anup.Patel@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 06:55:51
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We extend RISC-V spike machine to allow creating a multi-socket machine.
Each RISC-V spike machine socket is a set of HARTs and a CLINT instance.
Other peripherals are shared between all RISC-V spike machine sockets.
We also update RISC-V spike machine device tree to treat each socket as
a NUMA node.

By default, multi-socket support is disabled for RISC-V spike machine.
To enable multi-socket support, users can pass "multi-socket=on" option
in machine name.

The number of sockets in RISC-V spike machine can be specified using
the "sockets=" sub-option of QEMU "-smp" command-line option.

Currently, we only allow creating upto maximum 4 sockets but this limit
can be changed in future.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/spike.c         | 269 ++++++++++++++++++++++++++-------------
 include/hw/riscv/spike.h |  13 +-
 2 files changed, 195 insertions(+), 87 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index d5e0103d89..b60350e912 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -64,9 +64,11 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
     void *fdt;
-    int cpu;
-    uint32_t *cells;
-    char *nodename;
+    int cpu, socket;
+    uint32_t *clint_cells;
+    unsigned long clint_addr;
+    uint32_t cpu_phandle, intc_phandle, phandle = 1;
+    char *name, *clint_name, *clust_name, *core_name, *cpu_name, *intc_name;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -88,68 +90,87 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
-    nodename = g_strdup_printf("/memory@%lx",
-        (long)memmap[SPIKE_DRAM].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+    name = g_strdup_printf("/memory@%lx", (long)memmap[SPIKE_DRAM].base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_cells(fdt, name, "reg",
         memmap[SPIKE_DRAM].base >> 32, memmap[SPIKE_DRAM].base,
         mem_size >> 32, mem_size);
-    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
-    g_free(nodename);
+    qemu_fdt_setprop_string(fdt, name, "device_type", "memory");
+    g_free(name);
 
     qemu_fdt_add_subnode(fdt, "/cpus");
     qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
         SIFIVE_CLINT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
+    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
 
-    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
-        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
-        char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        char *isa = riscv_isa_string(&s->soc.harts[cpu]);
-        qemu_fdt_add_subnode(fdt, nodename);
+    for (socket = (s->num_socs - 1); socket >= 0; socket--) {
+        clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
+        qemu_fdt_add_subnode(fdt, clust_name);
+
+        clint_cells =  g_new0(uint32_t, s->soc[socket].num_harts * 4);
+
+        for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
+            cpu_phandle = phandle++;
+
+            cpu_name = g_strdup_printf("/cpus/cpu@%d",
+                s->soc[socket].hartid_base + cpu);
+            qemu_fdt_add_subnode(fdt, cpu_name);
 #if defined(TARGET_RISCV32)
-        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
+            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv32");
 #else
-        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
 #endif
-        qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
-        qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
-        qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
-        qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
-        qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
-        qemu_fdt_add_subnode(fdt, intc);
-        qemu_fdt_setprop_cell(fdt, intc, "phandle", 1);
-        qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
-        qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
-        qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
-        g_free(isa);
-        g_free(intc);
-        g_free(nodename);
-    }
+            name = riscv_isa_string(&s->soc[socket].harts[cpu]);
+            qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
+            g_free(name);
+            qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
+            qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
+            qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
+                s->soc[socket].hartid_base + cpu);
+            qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
+            qemu_fdt_setprop_cell(fdt, cpu_name, "numa-node-id", socket);
+            qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
+
+            intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
+            qemu_fdt_add_subnode(fdt, intc_name);
+            intc_phandle = phandle++;
+            qemu_fdt_setprop_cell(fdt, intc_name, "phandle", intc_phandle);
+            qemu_fdt_setprop_string(fdt, intc_name, "compatible",
+                "riscv,cpu-intc");
+            qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
+            qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
+
+            clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
+            clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
+            clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
+            clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
+
+            core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
+            qemu_fdt_add_subnode(fdt, core_name);
+            qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
+
+            g_free(core_name);
+            g_free(intc_name);
+            g_free(cpu_name);
+        }
 
-    cells =  g_new0(uint32_t, s->soc.num_harts * 4);
-    for (cpu = 0; cpu < s->soc.num_harts; cpu++) {
-        nodename =
-            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
-        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
-        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
-        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
-        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
-        g_free(nodename);
+        clint_addr = memmap[SPIKE_CLINT].base +
+            (memmap[SPIKE_CLINT].size * socket);
+        clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
+        qemu_fdt_add_subnode(fdt, clint_name);
+        qemu_fdt_setprop_string(fdt, clint_name, "compatible", "riscv,clint0");
+        qemu_fdt_setprop_cells(fdt, clint_name, "reg",
+            0x0, clint_addr, 0x0, memmap[SPIKE_CLINT].size);
+        qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
+            clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
+        qemu_fdt_setprop_cell(fdt, clint_name, "numa-node-id", socket);
+
+        g_free(clint_name);
+        g_free(clint_cells);
+        g_free(clust_name);
     }
-    nodename = g_strdup_printf("/soc/clint@%lx",
-        (long)memmap[SPIKE_CLINT].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,clint0");
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[SPIKE_CLINT].base,
-        0x0, memmap[SPIKE_CLINT].size);
-    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
-        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
-    g_free(cells);
-    g_free(nodename);
 
     if (cmdline) {
         qemu_fdt_add_subnode(fdt, "/chosen");
@@ -160,23 +181,50 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
 static void spike_board_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = spike_memmap;
-
-    SpikeState *s = g_new0(SpikeState, 1);
+    SpikeState *s = SPIKE_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     int i;
+    char *soc_name;
     unsigned int smp_cpus = machine->smp.cpus;
+    unsigned int base_hartid, cpus_per_socket;
 
-    /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
-                            &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
+    /* Figure-out number of sockets */
+    s->num_socs = (s->multi_socket) ? machine->smp.sockets : 1;
+
+    /* Limit the number of sockets */
+    if (SPIKE_SOCKETS_MAX < s->num_socs) {
+        s->num_socs = SPIKE_SOCKETS_MAX;
+    }
+
+    /* Initialize socket */
+    for (i = 0; i < s->num_socs; i++) {
+        base_hartid = i * (smp_cpus / s->num_socs);
+        if (i == (s->num_socs - 1)) {
+            cpus_per_socket = smp_cpus - base_hartid;
+        } else {
+            cpus_per_socket = smp_cpus / s->num_socs;
+        }
+        soc_name = g_strdup_printf("soc%d", i);
+        object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
+            sizeof(s->soc[i]), TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
+        g_free(soc_name);
+        object_property_set_str(OBJECT(&s->soc[i]),
+            machine->cpu_type, "cpu-type", &error_abort);
+        object_property_set_int(OBJECT(&s->soc[i]),
+            base_hartid, "hartid-base", &error_abort);
+        object_property_set_int(OBJECT(&s->soc[i]),
+            cpus_per_socket, "num-harts", &error_abort);
+        object_property_set_bool(OBJECT(&s->soc[i]),
+            true, "realized", &error_abort);
+
+        /* Core Local Interruptor (timer and IPI) for each socket */
+        sifive_clint_create(
+            memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size,
+            memmap[SPIKE_CLINT].size, base_hartid, cpus_per_socket,
+            SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
+    }
 
     /* register system main memory (actual RAM) */
     memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
@@ -249,12 +297,8 @@ static void spike_board_init(MachineState *machine)
                           &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
-
-    /* Core Local Interruptor (timer and IPI) */
-    sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
-        false);
+    htif_mm_init(system_memory, mask_rom,
+                 &s->soc[0].harts[0].env, serial_hd(0));
 }
 
 static void spike_v1_10_0_board_init(MachineState *machine)
@@ -268,6 +312,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
+    s->num_socs = 1;
+
     if (!qtest_enabled()) {
         info_report("The Spike v1.10.0 machine has been deprecated. "
                     "Please use the generic spike machine and specify the ISA "
@@ -275,13 +321,14 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     }
 
     /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                            &s->soc[0], sizeof(s->soc[0]),
                             TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->soc), SPIKE_V1_10_0_CPU, "cpu-type",
+    object_property_set_str(OBJECT(&s->soc[0]), SPIKE_V1_10_0_CPU, "cpu-type",
                             &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
+    object_property_set_int(OBJECT(&s->soc[0]), smp_cpus, "num-harts",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
+    object_property_set_bool(OBJECT(&s->soc[0]), true, "realized",
                             &error_abort);
 
     /* register system main memory (actual RAM) */
@@ -339,7 +386,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
                           &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
+    htif_mm_init(system_memory, mask_rom,
+                 &s->soc[0].harts[0].env, serial_hd(0));
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
@@ -358,6 +406,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
+    s->num_socs = 1;
+
     if (!qtest_enabled()) {
         info_report("The Spike v1.09.1 machine has been deprecated. "
                     "Please use the generic spike machine and specify the ISA "
@@ -365,13 +415,14 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     }
 
     /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                            &s->soc[0], sizeof(s->soc[0]),
                             TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->soc), SPIKE_V1_09_1_CPU, "cpu-type",
+    object_property_set_str(OBJECT(&s->soc[0]), SPIKE_V1_09_1_CPU, "cpu-type",
                             &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
+    object_property_set_int(OBJECT(&s->soc[0]), smp_cpus, "num-harts",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
+    object_property_set_bool(OBJECT(&s->soc[0]), true, "realized",
                             &error_abort);
 
     /* register system main memory (actual RAM) */
@@ -425,7 +476,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
         "};\n";
 
     /* build config string with supplied memory size */
-    char *isa = riscv_isa_string(&s->soc.harts[0]);
+    char *isa = riscv_isa_string(&s->soc[0].harts[0]);
     char *config_string = g_strdup_printf(config_string_tmpl,
         (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_TIME_BASE,
         (uint64_t)memmap[SPIKE_DRAM].base,
@@ -448,7 +499,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
                           &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
+    htif_mm_init(system_memory, mask_rom,
+                 &s->soc[0].harts[0].env, serial_hd(0));
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
@@ -472,15 +524,62 @@ static void spike_v1_10_0_machine_init(MachineClass *mc)
     mc->max_cpus = 1;
 }
 
-static void spike_machine_init(MachineClass *mc)
+DEFINE_MACHINE("spike_v1.9.1", spike_v1_09_1_machine_init)
+DEFINE_MACHINE("spike_v1.10", spike_v1_10_0_machine_init)
+
+static bool spike_get_multi_socket(Object *obj, Error **errp)
+{
+    SpikeState *s = SPIKE_MACHINE(obj);
+
+    return s->multi_socket;
+}
+
+static void spike_set_multi_socket(Object *obj, bool value, Error **errp)
+{
+    SpikeState *s = SPIKE_MACHINE(obj);
+
+    s->multi_socket = value;
+}
+
+static void spike_machine_instance_init(Object *obj)
 {
-    mc->desc = "RISC-V Spike Board";
+    SpikeState *s = SPIKE_MACHINE(obj);
+
+    /*
+     * Multi-socket is disabled by default so users have to
+     * explicitly enable it from command-line.
+     */
+    s->multi_socket = false;
+    object_property_add_bool(obj, "multi-socket",
+                             spike_get_multi_socket,
+                             spike_set_multi_socket);
+    object_property_set_description(obj, "multi-socket",
+                                    "Set on/off to enable/disable the "
+                                    "multi-socket support");
+}
+
+static void spike_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V Spike board";
     mc->init = spike_board_init;
-    mc->max_cpus = 8;
+    mc->max_cpus = SPIKE_CPUS_MAX;
     mc->is_default = true;
     mc->default_cpu_type = SPIKE_V1_10_0_CPU;
 }
 
-DEFINE_MACHINE("spike_v1.9.1", spike_v1_09_1_machine_init)
-DEFINE_MACHINE("spike_v1.10", spike_v1_10_0_machine_init)
-DEFINE_MACHINE("spike", spike_machine_init)
+static const TypeInfo spike_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("spike"),
+    .parent     = TYPE_MACHINE,
+    .class_init = spike_machine_class_init,
+    .instance_init = spike_machine_instance_init,
+    .instance_size = sizeof(SpikeState),
+};
+
+static void spike_machine_init_register_types(void)
+{
+    type_register_static(&spike_machine_typeinfo);
+}
+
+type_init(spike_machine_init_register_types)
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index dc770421bc..f0ab381a88 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -22,12 +22,21 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
 
+#define SPIKE_CPUS_MAX 8
+#define SPIKE_SOCKETS_MAX 4
+
+#define TYPE_SPIKE_MACHINE MACHINE_TYPE_NAME("spike")
+#define SPIKE_MACHINE(obj) \
+    OBJECT_CHECK(SpikeState, (obj), TYPE_SPIKE_MACHINE)
+
 typedef struct {
     /*< private >*/
-    SysBusDevice parent_obj;
+    MachineState parent;
 
     /*< public >*/
-    RISCVHartArrayState soc;
+    bool multi_socket;
+    unsigned int num_socs;
+    RISCVHartArrayState soc[SPIKE_SOCKETS_MAX];
     void *fdt;
     int fdt_size;
 } SpikeState;
-- 
2.25.1


