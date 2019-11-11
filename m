Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2C5C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B726A21872
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hHZuK6qx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="esoo6wC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B726A21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU9uo-0000j1-T9
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 08:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2113f9b6e=Anup.Patel@wdc.com>)
 id 1iU9tt-0008Ac-5D
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2113f9b6e=Anup.Patel@wdc.com>)
 id 1iU9tr-0000Ka-Uu
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:38:37 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2113f9b6e=Anup.Patel@wdc.com>)
 id 1iU9to-0000JP-2x; Mon, 11 Nov 2019 08:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573479589; x=1605015589;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=QtkmE2R/0t3NUkRZ9RG/jGgzzz6kX8tdY8D5A6HsdxY=;
 b=hHZuK6qxL7Ox5FawaQasuwtscoUw9ixLlfPqzvi+OULMPdC4z8JflYHR
 AcE51AMTzEe6tdoIHEAcXMukUfbVgo4AMxQVpleN0e+rZ6z3W0UnlCLLu
 2y9VAZdpJeYkLiM4oPbMx8MWLLdQ30wmrY7s/x4s22wPx/sAxK+BgB7qY
 FPLdNdSJajFzcta7qFGVVZwRQOtNxlF3elyaI08xZdmSBrRpPyffTt5hC
 jgyh/rX36LsvA4c5jtAkL0C+31UH8IgzwwGSpj65WvypamJzPsRzQ4fnE
 qTVwAoe15k5eTz0Lv14Kw7d7zZHkNe/bMUG5u4TDDEykTmYLfzrn4eYld w==;
IronPort-SDR: pe/jMBo0sJd9OP7SJhnlWulrUNeZ12g19HSR9rK1VHmjOcL7QQKzXdbeHpYmA5Kaooo75yrk2d
 hi3qUyGYRnP4G4E7oC/oO6WoZ+fzB1mUsvSBaleWggcW89R6jRrYQshukAbkb/O0nQ1OjgY4w1
 pqh0210J0WpO1dTS12sQHzyxWjNJJZV0KdOqw3u93kTrQurL0Z/Zga7N9ofKnWSzN786Fu334a
 tpYINB4eHsE8vI0UV9+Kn8YJP1ciCyh/3xIZJfhdwnfwxtRbHckHRvhzDf/TiZHXaARKgpDFbQ
 3Xs=
X-IronPort-AV: E=Sophos;i="5.68,293,1569254400"; d="scan'208";a="223909486"
Received: from mail-bn3nam01lp2058.outbound.protection.outlook.com (HELO
 NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.58])
 by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2019 21:39:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1S5T0LrwgxBUoWEi2dxf45c32XoRb5qQXYZzOzZ3FTLmTYU9Sb+r0kcsDYggGCybc+TEylxQIKZ6A5VXiPU8ySYLTkCKg/IDYJ2GjhnC265NwHklcW5WkpROSAjqVY1Q3Ja63iYmlPR57QvvFLbgbvPgBlbApnR3hB3wD2uMHrHg+uGTZKZbAjppsjv7AxifsrWPevRArA8HiMjScGiXH+MqEeh+UKSpT99oItp629uACfyiWuAMX3afprc6hYVLM2TvuDZ50Ep7s+CmPd+Rz15Y7f20g0rs7XHVhfRHY7FfGuYSNQtlPCCnmfOWSEKFok0nm+P3pUcbUhVXfUqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0aBS4ztkv+sqcHO4YJ/owgOczgXElIix8edFhxP+fA=;
 b=DF+LdbgbP4ny99LJfmg5XtSj7/RcWUBcBMsPKufI8EVHqRWKOpeh1xvqqbJ40VsgdnXumwyAlQOLZYJiVq9p0dd4EVrYGpsw0I5propoHuDv8qM+JBuUpIepEZBAlT+OsDPATOlRbxi9R917z2zTv5vNV1arAWQE3MegAMIFVbESIPU8BVPwKhzaUSsDjV8p4ZMsxd6Hwm8EQK8hXzx14ZL4fGrGb2R/quEyJYTkcEYf085FJwh1H2/1zOm4lfb4A4DZro/EtWqp0UbAXSXYQHaHEHHNCDE8RhNpo1bo3CMpuOdF4MMPjVKdLJSr5v2xbaq7UlJgfVn/eIPXNMhJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0aBS4ztkv+sqcHO4YJ/owgOczgXElIix8edFhxP+fA=;
 b=esoo6wC85Irnz0Rfi34sNwuwOsiqvXRfkyzwWn/P0UzQHlNeHZFTTNIQE6z2DGoh8txpojq/gxjn5CDP1PfP+2KqZAeWPvhQvDI/V/UmSs6FggnJY08BLw3UzhFA8ag9UHTAC0bj1FMAyJwtmdFDXHcM5IxK5TydChNaVc3nXTE=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6989.namprd04.prod.outlook.com (10.186.147.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Mon, 11 Nov 2019 13:38:27 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ac5b:8360:b7a7:f8fd]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ac5b:8360:b7a7:f8fd%6]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 13:38:27 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH] riscv/virt: Add syscon reboot and poweroff DT nodes
Thread-Topic: [PATCH] riscv/virt: Add syscon reboot and poweroff DT nodes
Thread-Index: AQHVmJVLWfJWIKb/20SwKjfRTml2CQ==
Date: Mon, 11 Nov 2019 13:38:26 +0000
Message-ID: <20191111133804.14454-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::31) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.51.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e17f77e-ac5e-4897-0f14-08d766ac6e42
x-ms-traffictypediagnostic: MN2PR04MB6989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6989679B5C60EF733F70D24E8D740@MN2PR04MB6989.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:190;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(189003)(199004)(36756003)(110136005)(1076003)(50226002)(316002)(66556008)(6116002)(3846002)(66476007)(64756008)(66446008)(386003)(66946007)(6506007)(99286004)(66066001)(186003)(102836004)(55236004)(6436002)(25786009)(26005)(2906002)(44832011)(52116002)(54906003)(86362001)(6512007)(2171002)(2616005)(486006)(476003)(5660300002)(71190400001)(478600001)(256004)(71200400001)(14454004)(8676002)(6486002)(4326008)(81156014)(81166006)(7736002)(305945005)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6989;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6pLKoVFeF0m6G95LYPVu5hvgreOXHNap5+F0NR2svVSB2YoVnBLffq/S/XhGplqXBiIswUlPYJ6DPhqmMQGEeZ08YIg3955Ft1AbPRFpM7LQhuwYPVeWNoVH11S5GGz6HCzinpm0cKUKC0Lx+em4G+CwwKIjyBGEn2vItqMJlriO4kyV++n+ERe7p1RAo7ojaRccB9qiYBx9htOeZYnKy+l+/CLTxfm7Fcr4zBa9hSJYGWLk2/oE5Kq5cNSGStKCYcUa7kMIKNdDN2SdCOpjKNFqTcvbw57w6FmDUieXmkVG/BWHYLrbd2VjwMJK+TP7pzqusJAZvKdGDtzRWDJ4sStZY0JZHf4yl077OVvudJIc/yZBdM/xuZwlMeA2r64ql2HbCA5uu6gXmGaefqh5dFsHk/p/1+SNEI5FwEhQQ8XqVRw1cZSiM9dUiU2RREEQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e17f77e-ac5e-4897-0f14-08d766ac6e42
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 13:38:26.8294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SsrIhAoJWataAbctMIm6nFWzzyLOLTgFllDFZH1WNVMAqrCBJ97m0NklgjB8avQ8zkD2Xz8xPPnw3lEwDxvXog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6989
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Anup Patel <anup@brainfault.org>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Christoph Hellwig <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SiFive test device found on virt machine can be used by
generic syscon reboot and poweroff drivers available in Linux
kernel.

This patch updates FDT generation in virt machine so that
Linux kernel can probe and use generic syscon drivers.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/virt.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cc8f311e6b..fdfa359713 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -182,11 +182,11 @@ static void create_fdt(RISCVVirtState *s, const struc=
t MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
     void *fdt;
-    int cpu;
+    int cpu, i;
     uint32_t *cells;
     char *nodename;
-    uint32_t plic_phandle, phandle =3D 1;
-    int i;
+    const char test_compat[] =3D "sifive,test0\0syscon";
+    uint32_t plic_phandle, test_phandle, phandle =3D 1;
     hwaddr flashsize =3D virt_memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase =3D virt_memmap[VIRT_FLASH].base;
=20
@@ -356,13 +356,33 @@ static void create_fdt(RISCVVirtState *s, const struc=
t MemmapEntry *memmap,
     create_pcie_irq_map(fdt, nodename, plic_phandle);
     g_free(nodename);
=20
+    test_phandle =3D phandle++;
     nodename =3D g_strdup_printf("/test@%lx",
         (long)memmap[VIRT_TEST].base);
     qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,test0");
+    qemu_fdt_setprop(fdt, nodename, "compatible",
+                     test_compat, sizeof(test_compat));
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[VIRT_TEST].base,
         0x0, memmap[VIRT_TEST].size);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", test_phandle);
+    test_phandle =3D qemu_fdt_get_phandle(fdt, nodename);
+    g_free(nodename);
+
+    nodename =3D g_strdup_printf("/reboot");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-reboot");
+    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
+    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_RESET);
+    g_free(nodename);
+
+    nodename =3D g_strdup_printf("/poweroff");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-poweroff"=
);
+    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
+    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_PASS);
     g_free(nodename);
=20
     nodename =3D g_strdup_printf("/uart@%lx",
--=20
2.17.1


