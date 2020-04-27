Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD32C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B102063A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jvGcxQK2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RGN2P2Vk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B102063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSyoq-0004FX-3L
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=379c65f89=Anup.Patel@wdc.com>)
 id 1jSynf-0002Ys-KN
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=379c65f89=Anup.Patel@wdc.com>)
 id 1jSynf-0001Yl-8n
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:07:35 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=379c65f89=Anup.Patel@wdc.com>)
 id 1jSynb-0001Hu-Er; Mon, 27 Apr 2020 04:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587974851; x=1619510851;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=IkX3NAMOd7d00WdzX3NnoJRwc0QuyzD1CnB87D0CqNs=;
 b=jvGcxQK2PO3Bp4oKM+5r1+VWV2tFAm16jODhboOHtxiLNhmlpCI77RR5
 2x19H6HuaDvytNE5uUAa6yE6FFunKT1Tfzz/9bIqGBIus02P+QCm2ZChc
 +mgJmWB347uZNn4z2BR5Go+25+4+sPZk+cOXPj3kzSvgmcf5EeKIoaqQy
 MwP0cboKu5dvCGOmEdXS7nY/qtwQsCbEAmLPC8ax5ZtURCQB0IPbiDlTR
 r0FwZ6HgG80+6NwJaGA9amWtGZPAr/nOCbqLiw3Pdywu0oKzhMJgXfjQX
 FNB6WlEXRNxI/QgBzmycqMqJzcy5RxxrSvFwEK0XAY2Tx0I4o7M6eP5x3 A==;
IronPort-SDR: JqDQcoCmSEgVgECBvd9FaWHfKop9+FTj0CHTiu8/nNRW6iyrBhqwM0gGDpDAuhIgeS9I09WHBd
 Li/HaqsOYopuHCu+85IWL2rk27B3SplKVrB0aWs019Y2xCA+C+ZCy0+r16FHAHjz3fxG392/Lh
 I2Pw6IU3iNNWmTGeCa0XuvTiEhOoNTje3vlfhE1hQPHszZQawzEjkBQfCws7uwLEYaSHr7mXNC
 97Cz/XLkOS/djoGvaOgcuPPGL8+ADbk+ub+e548zzZCHUepgVRqKclgendMoSpkeQxjXn/Uxg4
 iiM=
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; d="scan'208";a="137668059"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 16:07:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOm5aUQ/k4vucbg4uMPIwjj/XPAY/7HuzvWTUMQpqR+CSxeIPZRtfLZoWjL0Bgzp613syM9MkXKg4+OdNBNeN9HcgY3Wqh10BtT6XQx/P0XPzyYDnEXVfu/hbi6ySIID+9FtTKZIXLYs3OfYnzlIPseZJUhNPrAQdNsMVAGEigWr9lH7tPFiq86zP/KjAWCCI+n7rI/CLeLaeqM1tdZoS1hR09LPUmQLk7BP9dCCfURJTE4NvOQil1QVh84QUwbZsGtpP2mNQfD7oQswsB27eDPByCge05E6EOBUJ9ppcgBD9gWK3c5Rm6j6wpNkArIiFfSHPD36a7DpFL5HhngLMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe7TnEEFhCpLOM+DVliA9+BSHBG0ZHws7ChNLGirMJE=;
 b=SC//2l+mnPC9H/nkiEM5MZePpu2+SZpWS5E+mS7+iEcdJ/mKZTiIH2UNa4hAdn5aqMne3iWEOT+zyxj5EHTaedY9KzoRRvsEVdpq2vlY9pH3XuKM1KiPZ5972e5cwj5DrQfXSF91q82DyiGM8cpvzudd018gZ1+KqcyO7lM/zYxGyNxYKd+Sw9u3UHyekrkyLHpu9ornEb61p+x3N0ZOBSroK6YF7bD/TGisElH7kv7MXGTKXxwukqcFRKorPfwhAS0RiiXEh3dxIxsZ2aX4b/MJC6t/b9HzfhBA+TCyzar5V34Al5hvqc5TJEw8t72vooKMSA+7M6RuJcJL0inqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe7TnEEFhCpLOM+DVliA9+BSHBG0ZHws7ChNLGirMJE=;
 b=RGN2P2VkoqvNebBUEyNggscgtIvqsNnJGFnyGL8Q1jPkJHJS6DUZ9lOM2NE3pJIlS4lRgQ94Uj0kYG1Rp1pSIfei9jVeSzSJ9RgCM3o4Myx0LpoEG2zibRwnTnrtwQs/bf7x5CFT/PqtbvPhzSconhegv6v7tsC2ruUncswFwVc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (20.178.225.224) by
 DM6PR04MB5241.namprd04.prod.outlook.com (20.178.27.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Mon, 27 Apr 2020 08:07:27 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 08:07:27 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v3 2/3] hw/riscv/spike: Allow loading firmware separately
 using -bios option
Date: Mon, 27 Apr 2020 13:36:43 +0530
Message-Id: <20200427080644.168461-3-anup.patel@wdc.com>
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
 Transport; Mon, 27 Apr 2020 08:07:23 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.31.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d6c78cb-85dd-482e-a390-08d7ea8206b6
X-MS-TrafficTypeDiagnostic: DM6PR04MB5241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB5241DA3158F18F82284F74658DAF0@DM6PR04MB5241.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(55236004)(16526019)(6666004)(8676002)(1006002)(54906003)(1076003)(8936002)(498600001)(81156014)(186003)(110136005)(44832011)(86362001)(5660300002)(8886007)(4326008)(26005)(2906002)(55016002)(7696005)(52116002)(66476007)(66556008)(2616005)(36756003)(956004)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaoIRSKgBB++DUDoxIeMXLdsVw4+tO2H3QomYVDuO05+k0PYPOvWtVlB7Aump6Ce3k10ZQGfpO7t/mI77SwgAaFWh5dwyRw4xL6nYVlzeLQAUkR1EZQ/xr7hnlUlhM+4h13hAI6127PoakaA20YwesuXi+ksC0I6Mk+crfND/vvpCWpuYhWASGmMNsIZBVjZr1tIiv6EO/Ybl4uz9CX01sQuvURJsr1e3BHjYGvpiMkwJrAuB69NH+YHaVpETuaKw98K0+pbpkNgZ6XxOS1Qq7cQ//XC3X4y+xdK3wkXKc/mV+J4TZvtpjMuMELFAEo2SiHLOm4ElZgPYaILJmXt+QsjMTF2vaeAcIkzLuG3IXcf+lLYEEXWUwzmo4os7fFHpIs9MibgDD3U2CoJ9sT1uSMjKzroWtOo7Q7813+opiorL1AG2e70DGdcXEOaTmyu
X-MS-Exchange-AntiSpam-MessageData: B0gVIVaCvqk7FPeZy2fXz6LjDV2IxEB3j3z7kxvQyn3rNHvJbwxlQESJnvc+vD6+KUjb8b9dhX5DiezNUmMtjU3bLBgOxa8AeA61B33mOp3WPdlHX/YHczu7G27brAeON4z5U1MGnMwxX6jajnNur0ugnaVJZLFE2i5ikW9DEEmQyyE3VUQzyExzeLmNoYc4jqXaRWGCe5smDMUeYqUIxdHXEHStuyRJopKdkfxXs6dKoyddStZFPUPxKaPgeCj6epwbL9ZH2OMQwEvsNDiOWsjew9ibvbHOezjMLnuFzc6mOiMvtNRt0jtFZpnnG5pw8XjyFM3vuZcbidernvNwkfZjhFop1fzuy3n+6jnQurh81QO/QyuKCwAiz/gO84fvYbihch1jL2WP/GxrsQWSciCHigMuHN1E5zWz254mKVMl0RvaqyvhhxtrDlOohQ5pMGK+VRhL/cGSCNQXXX1CH0YGTkJfmVqgnES5UXlZY2ax5iWeMyxQugr/vE8hrvXUPvoJFUg82PhnHuLHKyfD8PpLKdcwqNpnLgDSjpERrQfLwx5mJbhAwlsHciDg2gH/z2J1oPGxk+UqRmqjeJzr5T2nL2kOk+jyF1KKgngWku6Tj88MSEgAlqC4+yey4/c29VeEGPUsN/p8mMA1cv4XEuMd6zUZkaiyIUTldawlFLQDlqZ3rrCYjplJwAwAYe6Aj/QM3yStFQvRbrHPSY3xvyw0UkFTgp0GJKpNOn5tznA/CyaubEr7Cu3yOXql1UAkNGWeT5vs+KhuAuOr+WIfsqqravpnpWYaVXWvhRq37MQ=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6c78cb-85dd-482e-a390-08d7ea8206b6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:07:27.8393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2rpoj6b+hFtjkSefDl2kgTihb3QqgK9SYKk31Ojr/UMamGNWn6ajhf6eLecpsYLhMwuIjWPTj0wQjrKAEE42Q==
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

This patch extends Spike machine support to allow loading OpenSBI
firmware (fw_jump.elf) separately using -bios option.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/spike.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 5053fe4590..b0395e227c 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -45,6 +45,12 @@
 
 #include <libfdt.h>
 
+#if defined(TARGET_RISCV32)
+# define BIOS_FILENAME "opensbi-riscv32-spike-fw_jump.elf"
+#else
+# define BIOS_FILENAME "opensbi-riscv64-spike-fw_jump.elf"
+#endif
+
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
@@ -183,8 +189,24 @@ static void spike_board_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
                                 mask_rom);
 
+    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
+                                 memmap[SPIKE_DRAM].base,
+                                 htif_symbol_callback);
+
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename, htif_symbol_callback);
+        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
+                                                  htif_symbol_callback);
+
+        if (machine->initrd_filename) {
+            hwaddr start;
+            hwaddr end = riscv_load_initrd(machine->initrd_filename,
+                                           machine->ram_size, kernel_entry,
+                                           &start);
+            qemu_fdt_setprop_cell(s->fdt, "/chosen",
+                                  "linux,initrd-start", start);
+            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
+                                  end);
+        }
     }
 
     /* reset vector */
-- 
2.25.1


