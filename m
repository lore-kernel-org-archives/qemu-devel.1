Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABD0C5519A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C132063A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VOIvS0ej";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="arsmYjIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C132063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSyqY-0006sd-UR
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=379c65f89=Anup.Patel@wdc.com>)
 id 1jSynj-0002gW-5M
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=379c65f89=Anup.Patel@wdc.com>)
 id 1jSyni-0001eF-MR
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:07:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=379c65f89=Anup.Patel@wdc.com>)
 id 1jSynU-0000s1-F9; Mon, 27 Apr 2020 04:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587974844; x=1619510844;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=nl3aSz2zkjAV9pCzBXTdUWqq+qb4ll+bYePGIRZ+OTE=;
 b=VOIvS0ejt4JE7qzmOED9foAai3G4mHPZIH8Fghq6RoiARfe6i7d2WbnG
 YMk6bJdrknAz/GaKAqm6XRYFFERy081azquvNsR+I1i8VSYER35GYdHeT
 r+gxZ9M2l+zWN5SleEKAelvdsks01pntwJSFqUGn6vmmFHWrmpH/7VBvO
 y9ePz5WdcL8EhN9dB6quFmxhhEvydAFya1XeBomjFDR68Bpor01Hp8uHf
 yt7JnjW8FA2Kn8saVpCdTuxOH8H2EeWrMTyIjFVpIgGK0yLSSpEzpFrXG
 9xhpoS/tDraHJqmxaZXGIcSpxmp2ZsrE6qHV2ZR5KoyGPsc1/zcM4HwjC Q==;
IronPort-SDR: +tW/lkyBU6kB8dY6weSvdiUtvFKF/iSeW21UQE/UIb9EQA2quqTAjDplaSIz4F9CC4rC8kk1VW
 KTDLeg4ouePDLE/19VtXuggyrZaLQX+54cHBmgN6T1lxrBWSZp8F8yJ8VdfbhatfRh5oStDTUr
 CkMntzTfSms3BFDlqOrzE/LaYyCAWc71QewE8f7jaO9EBrS+aIcMrHesgFyHUvhJnURoP9iuMZ
 Urg+lAV4cu4khj6I5B4obIhRbKIAyIKT9h6QpQVaYfxDjaiHT3tCWolUX9zMoZnbu6uAIL9bfg
 /m8=
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; d="scan'208";a="137668055"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 16:07:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPx98bctKF1LHwhk3QHJ0QlISea1paZPPQReQll/L2XvzBLZvFRzPD9xAjmSuQqK6Xw8AiGw4ojXTkx9MLsYZBtKl0W5AbkVDa9NXBaw6Iwn27/m6At2+CtzE3YDjKhzEzwSotAFvP0yK8ORka3u/AsSJ1tf0EGJcdLttFGs4mjhAVBctwsIybMzHYgXVcPNeV5OV/HwDqDjoalX/u/A1Oq3woaKjHOQ7JmOBqElpNQ40nosHhkMpP0I87EySlCpAibT0FVWxpJU0pkKiVy4MoVhoAAVct5ZbZUp3SWts1spYia80tE8K4Pc9Ekw5CqHFsSeYAY/b97KbG9OwPfLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTyNkJJ7Dbav6Xh5HsRL5r1+SCo8qt3+2ntEswOAkAg=;
 b=CTLV5OnzchMgiOdneKntF6Qudn57n1lnNGVIauu1ExCp5yNLk4eiBZXSimup0XT9kRq40ePxS92g+JnfFJs8xTpdZcUt+p5OMMfq9aZUh1BvpAPvzVeRS+cPYoxIpnIrkV7XXfNGLwyAcKGBnjSrz1neWNOcidEEFJpbB4WW1fB31uZgL+fgEQzsC3l7R8knLSVKQ/n1RSHt1NVk3YJiTTGF3wTdfl+HeGZ5kjqDbrWJgP7aTCLTwwNUzjpd+M8Jp4o0Ti2Sot/jvVIZk7VuX2QNq99nbKtp1DJ/M4cxh+nxIHIj/2wD/VHeJSnvoTReXWeB8d0cJ5GqvPN0rN88Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTyNkJJ7Dbav6Xh5HsRL5r1+SCo8qt3+2ntEswOAkAg=;
 b=arsmYjIhZNfCmIhyLyNKxKFzkOAA4270gmY0VS/HrfTc48UGBZXy4qJLSto3jq8yh09QqRFBa0rgX9qGWVYeVSk+R5GSMNoHAFi441exnNcxlUEs6Iu0+hBsamR+R/pHknoVERiMfXmuJ/wsrvpPtwu7AONuBqx8SgYEzzdO9hU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (20.178.225.224) by
 DM6PR04MB5241.namprd04.prod.outlook.com (20.178.27.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Mon, 27 Apr 2020 08:07:21 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 08:07:21 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v3 1/3] hw/riscv: Add optional symbol callback ptr to
 riscv_load_firmware()
Date: Mon, 27 Apr 2020 13:36:42 +0530
Message-Id: <20200427080644.168461-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200427080644.168461-1-anup.patel@wdc.com>
References: <20200427080644.168461-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::24) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.31.156) by
 MAXPR0101CA0062.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Mon, 27 Apr 2020 08:07:18 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.31.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f27ed5b-65c2-4454-b501-08d7ea82030c
X-MS-TrafficTypeDiagnostic: DM6PR04MB5241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB52417DE5B018842F34F6929B8DAF0@DM6PR04MB5241.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(55236004)(16526019)(6666004)(8676002)(1006002)(54906003)(1076003)(8936002)(81156014)(186003)(478600001)(316002)(110136005)(44832011)(86362001)(5660300002)(8886007)(4326008)(26005)(2906002)(55016002)(7696005)(52116002)(66476007)(66556008)(2616005)(36756003)(956004)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tuIkMyTqB1ySbjeuyjQvkUTibI8/VVcArx453VRuSTketJBC8BOK6IpHQ1+IRFixaywfIveRsNmGoi4IluQx4cJYYbe36qepRfzo/pOAuMSqTLkR5besO+ygRR26KOQPsywm7eAcocbS9S0v9vKJQmp2lUNIRy8nSk36zNxZLpNBcvCQX2kQHwHTNJT2jtaw2OV3EqDsy89Boe7pS6X0T9Zkd/gt72w1Oh8omUs95YFKKTxGndsHHNn/coSg2nbcwdmWcrjFf06pQjRxC5xc/g5HqSbEXIo0UcS2mLqY1j3Ua9YceFtJqcs9NDDjNUwPT0NdGisVfPpCTLJjzDpwyeCN5qNtvDp0cw3kxkdwsbeQX6uWV9sUIC9RRCYGXakMjlybDQsWmETgr7zb3ZgaymP3Ihj5pIkn5Iag5ntLnxZU8mvsP9NmHb0rpcXnMU6q
X-MS-Exchange-AntiSpam-MessageData: BvdeMCQM0DyOQuo30lnUQse7+lUOnL8ga/98xWwtuOoHJ3ZkRLWl1mJDhbSwBWp7FeaQxoW3BC9vIr1xF+2DkTQlm6FO5WEzN+dHMI82U73N7cmA8lWXPpBeVtWdIeYIBHCLHG5lSgBlzE1gRzRrg9JbUpcpGpplMOUPy8RgvqlRcotptLLECHdQP1+8O3N7ax0jK81oHUblmqkJ4EDzSCArlCx1wsJQNWQrmLvUnxrtTl9j7Yf0fmxKYUSQODFZBoMv/+66+7yUqe4RrQe/cEZMsimNbtJ9/TbKVP2vh2NH84V0tdsmR7CCDfz16fgV87WQLVLNqK+FDnSd325MGYaaS8zCP/w/riPoJMZOgx/KBbhgw/n4hRC7zIlPiMxRUUNTO+ChGJtimrygXWh8dw2meITnH06LAEoRvGuoxUahpFPQZ8ST1duGgvzjHBE7iefOXFSzJ8FAU7yNGvW38i4AYwVT/lAtzmbEVio9450JW4vmkwoDgTOLv2wdULlRQVQeAwoXdsyvPJTNxs81SUdo//CR2H7A6V702apt0S5NZBcGAskSdGWXANhSYUxUXcD7fBfgbXYWC7eMKBr/RWSz1NjrphyFh28toYCS3G+sEsWLZsd7JA0VB3v6HDBe1PDRpXa+JM7n7eG1D8ANH4dFoM0J1jMc0VKfNTs9cA5OPt+638/8TYLysGByUwhFOARsA2j2D8aj2LbYhf2HYYKg563XrNiWlbsTUwUxaIeKt+DWGzZ9wiKLhvgjf2yMj8VnGM0YVhIrAKNra9LwSeYk8WPpYfk8ZPdmWlGtxCo=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f27ed5b-65c2-4454-b501-08d7ea82030c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:07:21.6065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULJvFAVbOjxifrL3+QBxk+oQaWPHo1ZixaXnwTfQzNBN0MxdLpIkVG927zgHtGeBqzSAtMTMgR/lnZzx7zTIoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5241
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=379c65f89=Anup.Patel@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:07:17
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
index 56351c4faa..54bb9eb1bf 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -345,7 +345,7 @@ static void riscv_sifive_u_init(MachineState *machine)
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
2.25.1


