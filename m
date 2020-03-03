Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE15CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5AE2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dBsMY0+s";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kAjOSRU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5AE2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j989e-0004Hj-P5
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 09:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3240045c5=Anup.Patel@wdc.com>)
 id 1j9876-00016m-Mc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3240045c5=Anup.Patel@wdc.com>)
 id 1j9872-0006aH-Cb
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:01:36 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3240045c5=Anup.Patel@wdc.com>)
 id 1j986p-0006SZ-0m; Tue, 03 Mar 2020 09:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583244078; x=1614780078;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=/Ndcw8tbJAjlSTI0q5BW1JgJ4yN37BNnNQgqR3PgWpA=;
 b=dBsMY0+sbvFCgYL5/R4WXAOznCNwZW/6Ts0RhpTz/llfwby0glnE5Fnx
 1oMNPvK5uQOw2uttKdCHTPuk9Rp0EEeMsmZvzszUENtVY2WTWw/EucXCE
 ig4P17wB9rJRUCXIF6RvL3s6+0wBhUs/rnrbe/8PdQhwsv4Yv0+87snyF
 MTSt0oEf5xuZluH1aKp4ZfXOeOwg001hX7+fWdlVuSkQlnlsWHSSVnZdT
 guKnvkcybKZkGJm2cc18cbPdlA0Ry8X9p5GQgXVmtc6FGsvAM0AzFAlst
 FOxgdIkcM0yaBqTDxRCU0zG7yuokszfOcns3YamcMmFE68mmtNF2fZ5Qs g==;
IronPort-SDR: AofRAl8e+ZjQITfrn3jN1UEay7eEBCTB1SKlZZF/psp+Df7WqoVgEMT0V7po5MoAgnDbPau9Yw
 yanaM0aS0FwGVzl0St4x2+aaKqTjhrFgtOz9H9D0zKWwmSTbD5FvaOynGP0/NkzQDIHviB1aav
 IvpBDnN4vQl8ode+lCEl9zznJzT+P0fwWyyrGqfwSh/T8v4UVdy8KTRS/iW5+achfoaNqeDP/W
 wKFfOzJEJ2p/kp1FEgg9AA2pU2NWwReiO0y2R/xq7GLjIRQnyoQF8Xgn58Sdu2YzSvffYAsUwf
 y/A=
X-IronPort-AV: E=Sophos;i="5.70,511,1574092800"; d="scan'208";a="131264864"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
 by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2020 22:01:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mevVoXW2z+QpNta1ulXSCI2CGc62TrJrzZy8sSJOCX9HVBQQ2xGcqpEQhesPDjpRPRCDfGefp9lSK5mHvFv/ZrOcVXvT4U/nE4KG5Hrs3ZfLX9WuEYAHGwUwu/7yc+EqwZkxRr6GqWhHVov3N83e1W7+9oCHmr8ly1P3ekRoEVYx0i9u/RDVgsHyye6cMp3+LDOVyv5NNSAu7eN9f20mN2iPb2id26MpH9s9vsMNV9bg3j1ySzi2sa2oN42o4+v/RbtYsU9C0s9SXEDvoSTbbHhrWnwjxOUsUivBbA5XHt3OOkU429OrLmJlcTNoObIZBfK3FVWprteCSKDQFVhIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT85IypjwnGSNE5odb+0j3S4PWM+tWD3HxT3Qs7XAOk=;
 b=S67I1ZIYlzOzvsvIl0EeZXwPCCfFclzkhLqFH85nVr0RPF66p+IfYhlUGu4o+P4wt8lZ7PKMpWc6N40WfZmCwU9nUgJ2qnbUg+T5EPMt7sdiajDztAvCW2xD4TVSeAV16k8lZr9zc8FgkIpF1aSYXYVf12B16i6CHP9EBpJO5C186cPc4KWfy7GB2BBtTpysiqxMy/GtOyWyMlWwZn2fldZsdZXgIlXKNtjrkh94Ogab9VCAt9YAmlx5ovZw4eQWjTfUNTiuM50N9e54fQR+8k4zSUz0ml6ekhWCKYYRjEYYg4loZ8W0ylElcAPKealvgrM2TfO7/6CQ4Bl6vmH4aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT85IypjwnGSNE5odb+0j3S4PWM+tWD3HxT3Qs7XAOk=;
 b=kAjOSRU4SosJo84htf4kP0SN8W/1484vNNzJTi9gDPnf5rsPay+1SFIpoll7pP6MSvkoIgvBC49mfOaddtK77Jl40bk9SbPPl9YT5lLrhJdQsHaZEo+Df4RzM5TlZXe+ZvpTcZL6f/F3pKnmgEQAf0NvsnGRPeMTVRpZEl2+n3Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
 by MN2PR04MB5949.namprd04.prod.outlook.com (2603:10b6:208:fe::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 14:01:11 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 14:01:11 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v2 1/3] hw/riscv: Add optional symbol callback ptr to
 riscv_load_firmware()
Date: Tue,  3 Mar 2020 19:30:35 +0530
Message-Id: <20200303140037.85311-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303140037.85311-1-anup.patel@wdc.com>
References: <20200303140037.85311-1-anup.patel@wdc.com>
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::13) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (49.207.61.196) by
 BMXPR01CA0027.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 14:01:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [49.207.61.196]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a2749fd-3579-44cf-fedd-08d7bf7b5455
X-MS-TrafficTypeDiagnostic: MN2PR04MB5949:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB594961D302F00CACD1D90E3C8DE40@MN2PR04MB5949.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(189003)(199004)(2906002)(2616005)(1006002)(6666004)(55016002)(26005)(54906003)(110136005)(8936002)(81166006)(81156014)(52116002)(44832011)(7696005)(956004)(186003)(55236004)(16526019)(8886007)(66946007)(478600001)(66476007)(316002)(86362001)(5660300002)(66556008)(8676002)(36756003)(4326008)(1076003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB5949;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dp/I2faLN6wmcTsJIi1HzDJRp0nD94T+NjIduiM4eaL2hIXkW977PcYJ7Ku1Edb4X7EKDLYU7zMR3C8VQfDsgzUqJFLA/KJuKyU3YZ2uk8/S64dqP18kw5Q1ZjrWAdDdTcQr9w45fdZC8d48z+RoTXRw2TxGlRgdFv32cHGbOju+MJsij/x6LQacR4bwJewx+a0Rsls1obqeK1L7kEB0+iYHNTJ/xUCny7h9E7n4MtoFcRlCSM05ihBDumFn5rsoxNOFU6gh8ZbqSOZj/ZvHyVHytQ9NNiDGCPC6ntt0CnjB8G8LtZFjU+mAhnufYGBSS7/1q4bQO9/Hyz4C4aL5cvW4eO28114AOVaHQdggZYxWKCpPXGXXt/SD5xj0sbhjELNKehnY3s9NfHUVf9mSMFH/4+lixc2WwR3SUD1w+hOWpzU6q1i+rjmbqXjnQWJn
X-MS-Exchange-AntiSpam-MessageData: J5T0zz3PhKveVz0JxKaMGFMQUmD2vQ/TD/Jnca8lHcl1aZTY+njZguJU2dre11TojpCecoqIoO0Zc6fb8x16+xJDfnkvlmc//N7mxT9DTI9Sd1vxUq077uIhzqrM9mvGpjMdIYBky2bs4+grXYMUrg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2749fd-3579-44cf-fedd-08d7bf7b5455
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 14:01:11.6137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUyydmnFyZluuiYxxhULqcYt0E6WUhIYYrPpw7Ew/0tSa18o++043q7PfvtVyBriT6b3c+bM0CmefVHFE8wxVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5949
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
index b8e765277d..726300a171 100644
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
-                 &firmware_start, &firmware_end, NULL, 0, EM_RISCV, 1, 0) > 0) {
+    if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
+                         &firmware_entry, &firmware_start, &firmware_end, NULL,
+                         0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
         return firmware_entry;
     }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 156a003642..0ef9fc0fd0 100644
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
index 85ec9e22aa..24f851e895 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -507,7 +507,7 @@ static void riscv_virt_board_init(MachineState *machine)
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


