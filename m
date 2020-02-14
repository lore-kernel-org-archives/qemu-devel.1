Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214E6C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5E62187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HyElCl4d";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CYKCmXMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5E62187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2VJd-0003SA-05
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 02:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3066d6cb9=Anup.Patel@wdc.com>)
 id 1j2VIl-00029q-Mm
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3066d6cb9=Anup.Patel@wdc.com>)
 id 1j2VIk-0004DP-Kj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:22:15 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:14555)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3066d6cb9=Anup.Patel@wdc.com>)
 id 1j2VIh-00044h-6f; Fri, 14 Feb 2020 02:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581664931; x=1613200931;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=YjCTXHezOVLFDooZkPJzdfDny5vRw/HCQyAxyBXHGEY=;
 b=HyElCl4dZmDWTT00HOYRnDpFs5cDpf/cFqFxqV4eFHbSmEsnC59/UmDr
 ZlLKuyqP3l4PXiYhVizKQf9X22x8I78cdioNi4u2aNHqujquBAFI7p61x
 OIz5ZJNn7H9K9T8DlHcyze5ZhPc0U3aYI4ay4rkEZDrcrXiD7YQ2hxs3w
 ROz/lybZquPj3pOu9qy5HQHM3t94ppEPovR+/sSR0Phvj5ZQ1oLyBDR0+
 Kg2KEEFndk2iFECtn/adS8yWBQj8RMnPSuT4WAB9AVkVtxGfs5SL4ydYW
 ZWFM5rSobQqaYMGoqdoW+21njt64kng58zv4qL3pd+kEfIWl1eqcxIJg2 Q==;
IronPort-SDR: LelLP4ixCVHoehVOnoDLYHjs4vaKd7qw/8CwtP3wZEOTy9dP8rM8zCmxjTLzOgdLPcAv0gS0Lo
 OgQ6Lsr8UtKBeqPb9KfZTHBEeyM7IfXrcZYa/n1NUBwS1IVbzjOy6mNnXXrEXfnWrbOZSo3V4x
 UC7N5Wfr2ERcWpxthfMFeadgQGJtH8vFck/BP4RtE8g2+uFJaHqDn7BFf0gH34U2CdtI4dlxUt
 6MStGSQYDV9it2jIDKd7zz9Yig4ypQ/XAVvrnaKmxPhm06XdP8DvMsfuRSnb9a7KZ5Ss1giKo3
 kvg=
X-IronPort-AV: E=Sophos;i="5.70,439,1574092800"; d="scan'208";a="134205083"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
 by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2020 15:22:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgwKwBEMzz6GxFjgWM2ME1hJdctio0pLbarwTbp3XZlTNzAjXvI1AkKLqY30GDWUI6FnAtuayRI4riWFD9VoAxbR5d5FJ2JDaml/4Depr5HqaZ98KqbcEYW8sugTfywWHYUJrfVZuIF15idj0cDIrLzxsjPVbwI5D7VCUxfETMwGmk91rpmWSwDVfEYQnbQljWgiOycIlmJn2fVwNFrHAmgR2KUkNH9+1sjmTdO8uhgg7+XpeNBBu6Fll9g1lzyDqqzZrv00LslpYDarxd/XedbdcWyl/A5m9LERwCQoKEQ/CcGpR+TO+Ixgm+f+AgyYyzSxTKze3ZY5zjJuJczYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KldUSXrRbZP7oM7jgWvNMHmehtZ98ROrsNtNL+l25s=;
 b=NOLhkS3q9grSDTKbbQD88oK4Q2AvunxaaZ77EK5t9tI7DCoONwMOLVBhJIPUj3i0XpWer9+klnSZ+S4jDwIprS0qUusnDG5OWmkxWP7bDQnqktbqsrgwY8uU1gOJPde0zZpA+Aq5oGg0RZSLM6X4gBIlp+08qU3tpdKbJttIOifwj3WwbyWwMvRgsCtiqbh+llNQbXuTBrwt+NZ015aCP1GdegkJ07GsXHHk6t4267nuYaS0W8BkWTkXcvlq659MD7YdNd6qUXQ3TES4Dd/ZZMOtxyOmaW56mC7m9MNbWt7jNXTXXt0n8qTRFL7Lg0NL0M5vaj2HjPzxla7Vy6Qxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KldUSXrRbZP7oM7jgWvNMHmehtZ98ROrsNtNL+l25s=;
 b=CYKCmXMH62dTP3/gyBHbaG+vS/RIblbCIkEA/uCNgmT+0BVTuncq2/gzUZGjBMPsiJDs0aePASAIx/g2teR0PHx9vhjt9fKBR5m8E3JO1VIkWiEYI9NN7Eo3H3BSDwdfYcissmu0JlonLoqtD1oNpKR72TxTq3afkJXK3o1ncs4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6288.namprd04.prod.outlook.com (52.132.169.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Fri, 14 Feb 2020 07:22:07 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89%7]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 07:22:07 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 2/3] hw/riscv/spike: Allow loading firmware separately using
 -bios option
Date: Fri, 14 Feb 2020 12:51:26 +0530
Message-Id: <20200214072127.64330-3-anup.patel@wdc.com>
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
 Transport; Fri, 14 Feb 2020 07:22:03 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [106.51.31.230]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d843a3b1-541f-4c26-f6e1-08d7b11e991d
X-MS-TrafficTypeDiagnostic: MN2PR04MB6288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB62880204A9C61D247F1E5FC08D150@MN2PR04MB6288.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(110136005)(478600001)(54906003)(316002)(52116002)(1076003)(7696005)(66946007)(36756003)(16526019)(8676002)(4326008)(81156014)(1006002)(44832011)(55236004)(8886007)(2906002)(956004)(26005)(66556008)(66476007)(8936002)(2616005)(5660300002)(86362001)(186003)(55016002)(81166006)(6666004)(32040200004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6288;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atlXZihIX+ZMZOJiM1uTDsuYXpyY07OEhqR7i6uJEDM4bA3z/VN1rktheNbqFHwgzdWLkNuApbX1K77aCeabd8XkbEby52YJs+WjouusNMn1A2omm9tb6gk6yb8m234Sp7mUiQt07lpswtZPrmuPkU2L86Xo9LK/m/CyJ4eLYkLrcHp/m1or7LhsJSVvfL4TyWBofaHSzm0J92pGjW05KdaXkp1oKcCu3YNzTXbbYBJto8oBbAMzyRcVFbfxvu0HmsxkSGfxNcj+Ycoat3yMpqRVuoqRZhy03wNDQR9LhTtWt47/rOzn2gSSDyUhT5k7mbGVxIdGfBTVhWHZdjCWOCqwnJRR/76uD4XUhzrqu5o0US4GB0FPUmk0r5onLL9m97bPvSD8vECq5/2lVD+xM8G5fzaeIEv1bkq72QEdqmOyAvEpDzZnolRH0UyjjlOFSj4H76WRxtVSlAxH1k4VXLvcjkeB0S5CtxLHqBZ4AsVFmlPwcZtzx1tSFQN4L/nY
X-MS-Exchange-AntiSpam-MessageData: 0Nlaqx+kRGeyllYgxxTOkSWOuCpw29JaHWFweN5P0HVD94cUchNMbe9NkuBgIm7pPURkLATDUCMqb4UUTiXVpTWsmBMw1W4KG7uvB5uf6DVAWxAtBoIo3ZFd9lHcUMRozshUuzWybpif4Lf3bHKCkw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d843a3b1-541f-4c26-f6e1-08d7b11e991d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 07:22:07.5975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRnj1e60Lh6Q3t7yr8tTeCkYpsJMGQ8zv9DQMcV/rpT3A9T8nO7t1r4fN2vZJhDzKq9pRD4Gq8jx9cu0tiotVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6288
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.141
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
index 8823681783..060a86f922 100644
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
2.17.1


