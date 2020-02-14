Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F414EC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5442187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M3icoKnD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KFgQ5J0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5442187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2VKs-00050l-TF
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 02:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3066d6cb9=Anup.Patel@wdc.com>)
 id 1j2VIf-00024E-Qe
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3066d6cb9=Anup.Patel@wdc.com>)
 id 1j2VIe-00043h-OS
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:22:09 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3066d6cb9=Anup.Patel@wdc.com>)
 id 1j2VIa-0003xQ-M3; Fri, 14 Feb 2020 02:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581664925; x=1613200925;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=sdmk7a5KXpxrXvmScNDo/qzuUy1KsT2G9tzvP6RiQCw=;
 b=M3icoKnDxWKbN9tEWLFIyxsZgUPwPlcI3YbbA3YJg9yB/fSWD+w6iEc/
 FPFAhX5maF8la+E1D0SzR5oeIOQTJgbFop3qLJshQio4Fg96Ee9LE0a9Q
 sharvS2NQwIykhbFH4IzhAfLAo3x/NUkMGirdX0D0c0kvgk7li3Fdk5cv
 fAXO0tv0y8ywF6Y1KBgGbBNDwMlgmbJtZlVX6ra3ENET/mf/wXY8bQwIa
 zP81fW+LPHBg7LGgDhr5Fv04JSvjssND4j4u7lJfcxqDxAehupksS4RpI
 +sxNhCUKFrgSYyws0VfrGs3InrwnCcXSqkUVUnKbDyQ3SXClNSvSVh/oT Q==;
IronPort-SDR: FetsdmEe8nc1w1O2wHiAQPpD6qwuPwyamxjfynQ/MNPi8NsOHW6Bk5U51uhK0iIyY8HZAIBwYR
 d0QP5YTH/RkguLn0G5Qqft1EipzgjUia6PckbKDBhuq95hgJLVtTGz8Dt6DGmPE0R8YAZXglHN
 W7tlf6+DSdy3e9orpAGYYiqTdbCJy4gJlqPVl5G6Dc+Y2clfMTvUqEvvxdYN1uIEHeacAjmfKx
 AAOMcNZvomihhyBN+nApWxfY8b8Juw4aZWrqsL0GJfyh90B2PeiTyXcsIpWFCRMCoz9JtkZ1UB
 roY=
X-IronPort-AV: E=Sophos;i="5.70,439,1574092800"; d="scan'208";a="131289868"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
 by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2020 15:22:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cldc20sp4xB36XJaI3IzIPZe6MKc5f+Otsb6v1ofaDq6XLzqoegHtH3HkH637v/YcyLDySWtOwp35cCRUw0yj6O15BAo3vPYawbikyN+QuDBW33wwVUYM37wdDkoI7x3tK5IW2fHeZjFUURKLHGioeg5TGJeg5MhS69yqVK+JyhoIw3V+t1z5vUJj5WMoMunVwUL0Cd6mpoldgfak5L2E/F+z8w9o3uKpPO4rIA+1c8gbHL30CMHagLv3mp+Ho6clqMXXittcj2o8Xc3AsRPWtANiNYZ8D7ok3BSVdRn7U/dd9ftkdA2M1wxYk1/8LeY9B+zKjwswAV9P0nQk+RWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOPQkkLSS+/fwdjqpHB5eseaQyBeFgWRXKjn41/E1zI=;
 b=M8y5aeAMHEKPi0YIkHbiiW7ZRJ8Kjn7q+M9X8/OB/ueH8pcBUhTV5rTLUoRqjZnVzib2gQ0nP/ABqxceLvksyLe14j0hblyqJC0IHXGqo2U5ge72pPn//OiEXwYQoRifArr+nGEqc7LjoIo2CatrfH3UN7uSWkhwjLOmsaEaxBlWj8S5gQ4YdGX2ZAEDYoVivkZ5Bq/s373Jj+LsBgBjIWsTHMsrgwPqAizoua1rNtlwEL0QLPvxJTl+un78ZSgSIlYP1Y3i+EHOqr6bHBVnMF513SWt95bbCi1fOE3SC1EgsYyW96THpQDEtt/ibf8IXiBSeaGTk+3nM0WOxjxCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOPQkkLSS+/fwdjqpHB5eseaQyBeFgWRXKjn41/E1zI=;
 b=KFgQ5J0tkphV5dO88X5psvhcUTj/VmO7Diz3JitYqNE27vG+jEubRdngks4v6X8ke5coGWO5hVoTza8GPUxLPrEjiilwx1S6A7IxoWxR8Qbumk9gArJiP+sA2L7xPQ6EbTmpEKNrE4lnEsRyFjaqHegseHcGuiCaqKDWixpM038=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6288.namprd04.prod.outlook.com (52.132.169.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Fri, 14 Feb 2020 07:22:01 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89%7]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 07:22:01 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 1/3] hw/riscv: Add optional symbol callback ptr to
 riscv_load_firmware()
Date: Fri, 14 Feb 2020 12:51:25 +0530
Message-Id: <20200214072127.64330-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214072127.64330-1-anup.patel@wdc.com>
References: <20200214072127.64330-1-anup.patel@wdc.com>
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::25) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
MIME-Version: 1.0
Received: from wdc.com (106.51.31.230) by
 MA1PR0101CA0015.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend
 Transport; Fri, 14 Feb 2020 07:21:57 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [106.51.31.230]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a8d40f5-c72c-4e98-ef5f-08d7b11e956a
X-MS-TrafficTypeDiagnostic: MN2PR04MB6288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB6288B4A7773E60F1496208498D150@MN2PR04MB6288.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(110136005)(478600001)(54906003)(316002)(52116002)(1076003)(7696005)(66946007)(36756003)(16526019)(8676002)(4326008)(81156014)(1006002)(44832011)(55236004)(8886007)(2906002)(956004)(26005)(66556008)(66476007)(8936002)(2616005)(5660300002)(86362001)(186003)(55016002)(81166006)(6666004)(32040200004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6288;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vx661lO2YG3WPBCjoSWCQ2LbGEjQLglyhqRf5vpceU5cWZhK5YdgxqhpPDb7a4+735GsyAALnUF33xBNYi4s7LmIJOQobp4fBRXCeo8xMleR7lGyXc4ut2ITry0BiL76UaPBHb47RtkBItTneLBbaIWn0W5GZBEDKXNEdZ86eFE/vLwzv+ZBgOFp8yD/uiu+CrmSgqoc9MeMASrmDvWIBT4MxzUzzkpuwvLVGAmfcrP5i/vHF7CmGnJdmrD0HsJ0k2UFGgdbw9ez+81YuXz7QOUgtWkT8S5GjJXVs+DdZrM3GRcvPTp+WthetWDfsBI9pZ1SeqYcrkJ/lR/uaS0Dkbxqlzzy+8U01UQ3WtFXunxco2LdiDTKamMOcAzsWTx7h3WeZIeuLqnbA1fZG+8wXOTM0X0r3Uza14hmgyhUvnnRsB+zV0kPCeIgL0WFQ0OUnEOCOVMWi1Klo3VnPyz9fj2OQI8TEs9cH4s6IrZnryCFThwsUemfe8E3q77Z3vg3
X-MS-Exchange-AntiSpam-MessageData: TTYd4DsAjpQRBcesoiZrSroKbqg1f5y4lz451q/2y3VPWYXGN0Ol1+/N+rmv5TwALfEA1GOIPABlCAsY1ON+khGErMron2WZ2bZmxAmL7uFxL4+dNM0sze09L7Rvr/839Ji5n4mXhB76svf+eW3lhA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8d40f5-c72c-4e98-ef5f-08d7b11e956a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 07:22:01.4430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvTL+aKIs1Att5j4876DQ1h2hVBpdjWU/rVrVyuwhPIS5+bd+BHoZhrMPhLloum0E6KtBkk4dkEMX+4qoj+Gzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6288
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds an optional function pointer, "sym_cb", to
riscv_load_firmware() which provides the possibility to access
the symbol table during kernel loading.

The pointer is ignored, if supplied with flat (non-elf) firmware image.

The Spike board requires it locate the HTIF symbols from firmware ELF
passed via "-bios" option.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/boot.c         | 13 ++++++++-----
 hw/riscv/sifive_u.c     |  2 +-
 hw/riscv/virt.c         |  2 +-
 include/hw/riscv/boot.h |  6 ++++--
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 027303d2a3..7ec94dc701 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -36,7 +36,8 @@
 
 void riscv_find_and_load_firmware(MachineState *machine,
                                   const char *default_machine_firmware,
-                                  hwaddr firmware_load_addr)
+                                  hwaddr firmware_load_addr,
+                                  symbol_fn_t sym_cb)
 {
     char *firmware_filename = NULL;
 
@@ -76,7 +77,7 @@ void riscv_find_and_load_firmware(MachineState *machine,
 
     if (firmware_filename) {
         /* If not "none" load the firmware */
-        riscv_load_firmware(firmware_filename, firmware_load_addr);
+        riscv_load_firmware(firmware_filename, firmware_load_addr, sym_cb);
         g_free(firmware_filename);
     }
 }
@@ -96,12 +97,14 @@ char *riscv_find_firmware(const char *firmware_filename)
 }
 
 target_ulong riscv_load_firmware(const char *firmware_filename,
-                                 hwaddr firmware_load_addr)
+                                 hwaddr firmware_load_addr,
+                                 symbol_fn_t sym_cb)
 {
     uint64_t firmware_entry, firmware_start, firmware_end;
 
-    if (load_elf(firmware_filename, NULL, NULL, NULL, &firmware_entry,
-                 &firmware_start, &firmware_end, 0, EM_RISCV, 1, 0) > 0) {
+    if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
+                         &firmware_entry, &firmware_start, &firmware_end, 0,
+                         EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
         return firmware_entry;
     }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0140e95732..0c84215f42 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -341,7 +341,7 @@ static void riscv_sifive_u_init(MachineState *machine)
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     riscv_find_and_load_firmware(machine, BIOS_FILENAME,
-                                 memmap[SIFIVE_U_DRAM].base);
+                                 memmap[SIFIVE_U_DRAM].base, NULL);
 
     if (machine->kernel_filename) {
         uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c44b865959..90a5bfef63 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -476,7 +476,7 @@ static void riscv_virt_board_init(MachineState *machine)
                                 mask_rom);
 
     riscv_find_and_load_firmware(machine, BIOS_FILENAME,
-                                 memmap[VIRT_DRAM].base);
+                                 memmap[VIRT_DRAM].base, NULL);
 
     if (machine->kernel_filename) {
         uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index df80051fbc..474a940ad5 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -24,10 +24,12 @@
 
 void riscv_find_and_load_firmware(MachineState *machine,
                                   const char *default_machine_firmware,
-                                  hwaddr firmware_load_addr);
+                                  hwaddr firmware_load_addr,
+                                  symbol_fn_t sym_cb);
 char *riscv_find_firmware(const char *firmware_filename);
 target_ulong riscv_load_firmware(const char *firmware_filename,
-                                 hwaddr firmware_load_addr);
+                                 hwaddr firmware_load_addr,
+                                 symbol_fn_t sym_cb);
 target_ulong riscv_load_kernel(const char *kernel_filename,
                                symbol_fn_t sym_cb);
 hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
-- 
2.17.1


