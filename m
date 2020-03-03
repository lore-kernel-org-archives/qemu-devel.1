Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BAEC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F47E2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bRmwcikJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vGqtOU+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F47E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j988M-0002F3-Cb
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 09:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3240045c5=Anup.Patel@wdc.com>)
 id 1j9876-00016l-MH
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3240045c5=Anup.Patel@wdc.com>)
 id 1j9872-0006aC-CU
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:01:36 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54521)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3240045c5=Anup.Patel@wdc.com>)
 id 1j986s-0006Us-27; Tue, 03 Mar 2020 09:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583244082; x=1614780082;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=DjkHNPqlivrNB4kus+2xGrzXcMhmSRHIAnZ7iClBfF4=;
 b=bRmwcikJdpI+cAhDuG6f9qaIFXSjaieHpKwcROu5SDHurVY+eBsa7krg
 dj77tBgGzcKZuAcq23VV+68GlhBqY03+6llqD5KQecMlKkpUH9fiWytqx
 3upINjT9b6FRCoh/rko9+V5+kO9ONR3QIOEitkCrc3CxGoWnLRf07O6jj
 VC4KN72mlAX/inOn80NdkBeohbs0omR5gGw5VqYZVJOG+DMf2t+u/iqbO
 04NwHBKaH2Rk1wqLP9z/z9oQUW+N+rl7PWa43iXAQ1odUJX+6xdz582HN
 LVYdHQHVqd8EkmOHDqY4DsaoCAv0KIEvTFgPu5XXAqVypElzC42KJib/J g==;
IronPort-SDR: qRKNUEFNLnsFLXX6MwGjUxsXTWWVsSSADkNYL2x4tRPXzh8QaUIBzJwRxaFhdKmndeLIxfygdZ
 2MVOe8n88+GUSGjK8szvr7uMNAC4HM4VQACtkPfCtijjiHZig0LgXdhWnhYVUJmcVrr9srEz9L
 JawEygYANGKiErMJDSeCv0enKs7Lg8y1hobTTIeTtxAyB+Y9iJJgYyJlUw64KqLSbUMJJCZgBS
 H4jJ9NN6DNqUf5cxjsrkDuelCAqQbzrNBtYn07ns/MH9uzQcXhxTcbIN9qCVWHUgZyCIydw3cP
 bh0=
X-IronPort-AV: E=Sophos;i="5.70,511,1574092800"; d="scan'208";a="132719434"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
 by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2020 22:01:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTER8XRohF9VbUkZYKW46ren0xouxXvi0sOGP4SAT5WuSpRPhceM20niKG8JnmUCRbOMdxK1WBzMN8qjWOzEChJw6QbiTNe5eOAdT2bguf3D5QZHP694SJTCJE/FodPrssVVCPygWUpYk4EyVjW/oXV0QaZoyuClU2OdsH36T7Xq2Dxp/0Opfm5V7fJ4tQeRMk+LZzCoIKID6w/AuS15tIdvMm9L5EEtc8dCaufd+NQUl8PoAjDztJEt2dvs8SWRCMV/1IcQenvFND/s0cGz+XH2o6uLSijjV08hyWD7TL/c5Kk9XSi3MCuuwJz8JCKZpYVxoEAxC8mU9Ql8KWPNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jgvO3QNgOhswXvvJL2ZPMXgwFsB+7qEilEYErK+CIU=;
 b=gqj12SPPt9Vy+DEUS07dBgxetfnz9Nu+v9NNWIUFsmg/uJalZc9PKTbkkd5dtE0Wn5BfC9vEkx84TXBVxPRUdDLrCiYMsMQ5Ks9HivpFvNJllwD7UvqA6Yu6l9D1YJj/jDZqbajwoJ9vgJjxMUnVycCuApNSBTyD5JWpvI5bnbq4CymMO04L27toQJQufjp7P7fJb79VQRKLF0AeEdOY0pD6mpoV+W7jDI4p7P4SWYiPYwe2m2wIWkxFu3dfoO9iyitJaNAiclQ410Sn+HFNarv90mm7HdSRMKm+uU8xeJ1s6JDck0bvw/xudX5sYQWcs0mrNrDTG1RIFfY08G1n1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jgvO3QNgOhswXvvJL2ZPMXgwFsB+7qEilEYErK+CIU=;
 b=vGqtOU+lcr5aMEoZPsKh9pFryoyxoTgOX30BeK9LJfIxZcAHyHPbG3rvWMbYMhYKRbbYoPWJVRu1pZgAv4IGQMbh1/JzADwf8T0DhW0fDicKNICSdta6aLV8DbGVumdf/QssOhGAhdTwCCPJ5TR7ZVmBkX5YZEIC5qbqNr6xjv4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
 by MN2PR04MB5949.namprd04.prod.outlook.com (2603:10b6:208:fe::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 14:01:16 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 14:01:16 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v2 2/3] hw/riscv/spike: Allow loading firmware separately
 using -bios option
Date: Tue,  3 Mar 2020 19:30:36 +0530
Message-Id: <20200303140037.85311-3-anup.patel@wdc.com>
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
 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 14:01:13 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [49.207.61.196]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce4f0ca2-f29b-401d-13ea-08d7bf7b573a
X-MS-TrafficTypeDiagnostic: MN2PR04MB5949:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB5949CEFFC2D21B3D700E86E48DE40@MN2PR04MB5949.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(189003)(199004)(2906002)(2616005)(1006002)(6666004)(55016002)(26005)(54906003)(110136005)(8936002)(81166006)(81156014)(52116002)(44832011)(7696005)(956004)(186003)(55236004)(16526019)(8886007)(66946007)(478600001)(66476007)(316002)(86362001)(5660300002)(66556008)(8676002)(36756003)(4326008)(1076003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB5949;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lG7eACXOF7OAtnUAB93CmsIwGkUCn3G9Cmv96zrdvimSJHKCOZmVn9u6/7L8xJsHVCgOv4Zl15BXW//oEBnJT8djSACda3w0YgqXOqZS07vqs0xXe5TD1QraHxG5oTXJZM9BXtdrCqL2NpiCN1zLhENXjvEysFsboWL0TBAUBBPXstIA9eHrN3iGsBIS9mL9IE/sj3nKpiHv4+s16ZjVaHhnvd3KLs4shsdDwsPcOd5LjXnRV3zoTq3eNfC9m3m92471KmsYUogqRx3nnl8l9lgeix6+ATtxia3ouAav82rWM6o0gSmlZ5gEI3sMm6ZgkLOrTxldsfFbrcrpvZPntV5w2l9FaqafOEP44UuTZj7EJxmBpkD1QiCKAZ1qToqXFF4ukR+QsrWKCkuUdUKDuv+Wx7e/7JtJA6VfNm0in+K+dd0ay38XstTiCrEoYuO8
X-MS-Exchange-AntiSpam-MessageData: RX4n+M+XLeHG1vV27LU59AuOMl5zfXHxl8dDfBev8JY/UioIKxDEnE2L8m6knk193yBL8cycSw3WtQ2k4pnMwkxYEBM1y+TA52GpbDX9/t1hsR78qBWJEzYdQ3cFMFByTdaaPCq9lDTGctz6psCtoQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4f0ca2-f29b-401d-13ea-08d7bf7b573a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 14:01:16.4509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyM6QCScIKTnvF+ZxEZzBWY3KyPueJvqxkimTjPLQoefzwc5GbP72qfCppHI4OTJOCk8HtGTP9cYuyLR/Mawaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5949
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
2.17.1


