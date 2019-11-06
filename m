Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86BFC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79356217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g0kK0ALz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lVgTEyOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79356217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSGoZ-0000zl-Ls
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSGmn-0006to-NU
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:35:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSGmm-0003bP-Hd
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:35:29 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29689)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSGmj-0003Zw-V2; Wed, 06 Nov 2019 03:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573029326; x=1604565326;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ky8BZ8iaJiI0A0WDHkxMzZD2O+ipw7mbPNxy7q+UjxQ=;
 b=g0kK0ALzy81hyA27XIVIgxliZhxEXscsYuo+CAh1r7kbLu9MPE5PzUeQ
 3/6/J4+hlLW9KYM4+go740AbSAN+ffmZ3kGrhOmljPtqmxsUIjkN5MHBQ
 PFvrSdFKdx9/XcAnEgPnj8eYUIRVRyYno9le0VH96iWyAVXuUlr6GL1+2
 JfJWQH98R/lFloMzxDEj0lcItNXXnVvSvmxXMn1Ra978fGkS1HWZ3aqIZ
 +1AqPmsv2BofHTCYbjGstNYPHtuJgJsd1VXpooHoHQBJKkoiay09L0gDq
 u3YgBF4UmdYp3qdsNt14XMNKOr866uLo7B8FtLzWlERl8E7qAHMN6tkqR g==;
IronPort-SDR: fwsZoT0wpfCSGsggEjZ0zBnZ6OVSa6xBn8UEABeQKLWo2izQ6O3eVnYJYRO/nt7AklpbjFCNDe
 YQHOb88B2xYO9OZ1pJkmOn0YNUP/BJ1zYetxnz12Kl3/FzpTaMMomUED34zEyFIJhnOOz1cXpN
 cOBUIobRTZ9YU/dK/8N2dFLKII2R8q+VNaAvkgW1wmiKYawtPkolObEuD5ur+6+0OwrvaF18T1
 V/mh0kYakhHnVBRvrk8tLzEN8viUx2wbvOJ7V5ujSJKH+ATOAs++YbCsOf+NpdZ+a1EJ1/gJcC
 EAQ=
X-IronPort-AV: E=Sophos;i="5.68,274,1569254400"; d="scan'208";a="123869337"
Received: from mail-sn1nam01lp2057.outbound.protection.outlook.com (HELO
 NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.57])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2019 16:35:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVnQW+OmzHO0d5buIhOckHvWblOlxXi4TOkVvlpwdVxt1wPLotCSP90U77NY9WJqTpLw0tC1fuw2ykoK+ktvuFwuCgf263ZNFj0dZC2NTjsk03JufCQv7Zm0MexfwIbvNp8xjzrSeBtIqbO1d4CuXHfLI07ZCviLGeaEhVkQNQnHrFWgN5+dm+wJQY/lORnP3g/WdtTOtirfwJqeFrH/FZwnZ3DxxZV1iaA+ZM5sYdq97cTKA8VMjfO2oyQtY5lN6KRYk9Y20X1T0yh80QS7I3OAPswsW8x+TeozZ2q4Upcib5gagFKCnoHYVVexrrThuv/FS6yKdXqBJG9pl5/Sig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfO82K7SRKK9ZCscBuVbuPJlRokkEhnF0xm0w3c+H70=;
 b=INSL4GGDkmck7YyjiQox6jqwerQ16LBDjwVpJQb+8lnZ5024FnmQ7XSlXP+Ihsjfrb1qATQRi24n9z6WYSHAKEk6hz3SPPZZlJZHsaBCULW/FnpOHmQ6VnfEQn+kF2b58OoODLbptd0QOriobeZk3krU6RL/XRoBTF25nPzhWdRZdEBvsHM69FmupEdeeJgs3tXxBhk7xh3hwlBLrYEjwblR5MnKk04JdlYcqlD0san6wEkgirPu5nFTmxtcVxuw5iqEw9K4NpTtkJzdVZVy61hzyB+X+cVtc/LXhUcZvaoiLYWRF5wphRaETh/FF+LdzlYdDw7Ro/sUScftAthrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfO82K7SRKK9ZCscBuVbuPJlRokkEhnF0xm0w3c+H70=;
 b=lVgTEyORE0CaZOcHu6dgT4pf7FOKUPQXKu5H/DKhjqigba0LkZaGTEiyYxH0ILN+YYKaAEGYMfrfpMflZ6oA/HkOmM6I+1neXn/K1CP5fQW3VWAfW3EN3LUM/KOFssGnhVGIRnYWTHqOYd9XPSsYgsnIDo0lMAMx0zxgAaZwVuM=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5936.namprd04.prod.outlook.com (20.179.21.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 08:35:22 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::b181:29c4:fcfb:7a0a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::b181:29c4:fcfb:7a0a%7]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 08:35:22 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v7 2/3] riscv: virt: Use Goldfish RTC device
Thread-Topic: [PATCH v7 2/3] riscv: virt: Use Goldfish RTC device
Thread-Index: AQHVlH0hhDcc0euSVkqbQuGiToNmTg==
Date: Wed, 6 Nov 2019 08:35:22 +0000
Message-ID: <20191106083444.41113-3-anup.patel@wdc.com>
References: <20191106083444.41113-1-anup.patel@wdc.com>
In-Reply-To: <20191106083444.41113-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::33) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 927fc216-e4ca-4823-f460-08d76294439b
x-ms-traffictypediagnostic: MN2PR04MB5936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB59369A79C390FBCBAE0B08378D790@MN2PR04MB5936.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:121;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(25786009)(3846002)(6116002)(71190400001)(99286004)(2616005)(6436002)(8936002)(316002)(476003)(5660300002)(1076003)(71200400001)(8676002)(6506007)(66066001)(386003)(110136005)(81166006)(446003)(4326008)(44832011)(54906003)(81156014)(14454004)(186003)(11346002)(6512007)(50226002)(52116002)(86362001)(478600001)(36756003)(6486002)(256004)(76176011)(66946007)(66446008)(64756008)(66556008)(66476007)(2906002)(102836004)(26005)(305945005)(7736002)(486006)(2171002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB5936;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vUbVOrYVIqm2lAhkulj0gBhnBCBXV043ysu1TYrsmeGRoaWWXa4rLf7PQ7gxq9G1hqMiBTky756uc4FwiSZlHkvkucfLIVYnihO5xjuaQt3SP2DYni1Wai8D7E3blUVmnke10oPJmMwxAPxmfQ+93dsxkxg9wR9AxeiShM6R+i4GPpVpU4i/evGERbBDe9GN5FvD5ihKokljangErd8wFZ58ijzNYTYTFn3COuZXz78ElIGylC/SCWTNuftj3iMqNrG0Ov3Dgji5Z72mJGL/4Q6qKv7TnlIQV82sWMOJSuVQYodIXdLgUvNlhqOLaZqObnbF4y1Z2f7cNNXoVWdtOzJroWXFOKfC5qacRO59yQuD9fEKFX9WFv7JGA3gcqmJCHDDGZXInENZM/OvwfghJDPqHkyDhfn0W7HlFID2p/iUEEGfamoemeb2FxTCoIZa
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927fc216-e4ca-4823-f460-08d76294439b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 08:35:22.8628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Hp8WwLTmSlvDB77lhgx3xu4Xx0EFHxQzxC6B0VEkjPtrKyD3wUhAaaHsOGSSmowYUxJG25plxpAQMHxVjHzuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5936
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Anup Patel <anup@brainfault.org>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We extend QEMU RISC-V virt machine by adding Goldfish RTC device
to it. This will allow Guest Linux to sync it's local date/time
with Host date/time via RTC device.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Acked-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/virt.c         | 15 +++++++++++++++
 include/hw/riscv/virt.h |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index b12660b9f8..ff9fbe958a 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -34,6 +34,7 @@ config RISCV_VIRT
     select PCI
     select HART
     select SERIAL
+    select GOLDFISH_RTC
     select VIRTIO_MMIO
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PFLASH_CFI01
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cc8f311e6b..818678a4b2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -58,6 +58,7 @@ static const struct MemmapEntry {
     [VIRT_DEBUG] =3D       {        0x0,         0x100 },
     [VIRT_MROM] =3D        {     0x1000,       0x11000 },
     [VIRT_TEST] =3D        {   0x100000,        0x1000 },
+    [VIRT_RTC] =3D         {   0x101000,        0x1000 },
     [VIRT_CLINT] =3D       {  0x2000000,       0x10000 },
     [VIRT_PLIC] =3D        {  0xc000000,     0x4000000 },
     [VIRT_UART0] =3D       { 0x10000000,         0x100 },
@@ -376,6 +377,17 @@ static void create_fdt(RISCVVirtState *s, const struct=
 MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle)=
;
     qemu_fdt_setprop_cell(fdt, nodename, "interrupts", UART0_IRQ);
=20
+    nodename =3D g_strdup_printf("/rtc@%lx",
+        (long)memmap[VIRT_RTC].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+        "google,goldfish-rtc");
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[VIRT_RTC].base,
+        0x0, memmap[VIRT_RTC].size);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle)=
;
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", RTC_IRQ);
+
     qemu_fdt_add_subnode(fdt, "/chosen");
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
     if (cmdline) {
@@ -579,6 +591,9 @@ static void riscv_virt_board_init(MachineState *machine=
)
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
=20
+    sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
+        qdev_get_gpio_in(DEVICE(s->plic), RTC_IRQ));
+
     virt_flash_create(s);
=20
     for (i =3D 0; i < ARRAY_SIZE(s->flash); i++) {
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index b17048a93a..e69355efaf 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -44,6 +44,7 @@ enum {
     VIRT_DEBUG,
     VIRT_MROM,
     VIRT_TEST,
+    VIRT_RTC,
     VIRT_CLINT,
     VIRT_PLIC,
     VIRT_UART0,
@@ -57,6 +58,7 @@ enum {
=20
 enum {
     UART0_IRQ =3D 10,
+    RTC_IRQ =3D 11,
     VIRTIO_IRQ =3D 1, /* 1 to 8 */
     VIRTIO_COUNT =3D 8,
     PCIE_IRQ =3D 0x20, /* 32 to 35 */
--=20
2.17.1


