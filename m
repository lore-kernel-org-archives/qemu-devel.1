Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6228CC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE7921872
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lqg7y0Kv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NqKyu3zb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE7921872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU9ya-0003Gs-B2
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 08:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2113f9b6e=Anup.Patel@wdc.com>)
 id 1iU9xd-0002nJ-TD
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2113f9b6e=Anup.Patel@wdc.com>)
 id 1iU9xc-0001Bm-Jr
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:42:29 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2113f9b6e=Anup.Patel@wdc.com>)
 id 1iU9xZ-0001B5-7t; Mon, 11 Nov 2019 08:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573479746; x=1605015746;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YQ5QqC/k6RxjgYbVA6cC/nV4WIQ1A3yEsxGVhfoCzjk=;
 b=Lqg7y0KvViGIPJvT8sU6u8yyUgbVNKECDtNZYYt9qMz9bNA202p+UZzY
 gUnUg8zsKHKacntFIYu49hiSrsY9gtu0fQjbSkVG17oXJuFNB2K9GgvZY
 fchz9bI5jgaIujEQp+Fq7elK6zdZSG6lw1KKF1/3KpbPcDtc+XXTyz+wT
 4zRt65yPbTY9c31gEKPrbNHL+21PG7sgAqWhgabYWChA1+Nct+UxI5cEj
 RfOP2EpKk2NkAHpEn/2Rza/+Y9Qqp7slkz1SoGHSl7pBx0zdewwOLxdeo
 sY/SLraE6300RP6SbFgJcqaU8xl6XUWl0U2Z6RExvLXL4eQoDKJEEyTi3 Q==;
IronPort-SDR: z4qVmYQJe9Tcstwo+YZnihcL8FjWd7UzpJcYpM4+IgfTeGnUyLRdBplopKmcbKRutEA+MsbHvy
 NpLLpaWfVfjJ+7oglXC7YLHRIPZUejFYfkRkSAzBPUrMmamAR2eB2/A6HqLfh8C9bl3lTV3BXf
 Gl0vFKYwIUIImDoZ28/ssadknYZrehmXvebdTNxxKkCDFaCnjlBHzaZQi4VQRU8DaJgdrBIoQT
 xtGdpq9eLXAlskLyglMZI79Cpk1l8qELXKrcUFiHVNeDkL3tIh1XiGrS9hrafGA4jIdkIajFCZ
 qek=
X-IronPort-AV: E=Sophos;i="5.68,293,1569254400"; d="scan'208";a="123414795"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
 by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2019 21:42:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr1u5aXw4qKvbMY6/Gl9K//olVOzr62hWmWUop8nZ5ezTd7Nv/0aRD2r3gYYbqKveBuQViaZ4F7VSKdr/eBbCqwswqoRfcmejSGKPWYgoWHx+y/8TF2w2vaxNTM+78MMf6+tahRt38rh2dNHCrJH6v92vLxsp+OoGExysj0bbollhF5tGxRa9JHfpPtoKdUqepDoituaYvH99rYcfmgh7azpdwzKAAUezo6S8iGoL7BHXBj8fNi1kKWLf63LvwW3UYvyn0b9LU3EAxZR0EgjqwPOgiM4Ysm38aJY25rf2w8oJThD7fRjPPaquaWPwPHTxGqck0eMp2g4/vT8Mm6O1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PvW6rdRAC6IoJXKCpGBFo98HwMDcwPiNKy/HrDI5Q8=;
 b=jYMSJpxBHZcsrHwWEbHkzKgSYbGs5uZJFSh+K7xngvNgqmWb8Zb8hSrwjICv27+8NWEe1RSsNNY0z4p48wqu1k75cv7IEUGmpPj7OWTXjy9+n9GWTUw2OhVe0FrSMRfE3oDbOjPNTG0D/xAC9BaQ3MEvuQnUp1XCQVZBErEDNmLZTKh/vMocVSoDYfS6H/5szyDFoxnQpL4/Fe7yBIF894hGAu3CwzBd8dgcy77uv0Lhuv4U8qSZaaan4QC7g6BDt5FFblPDeS97tbQUYY3IEouCdoYpvfBhlArb9jA3GRHhVHlsoPxQq5OSENcQv/8SyUYVJ5DFbR4xmzoPmqWzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PvW6rdRAC6IoJXKCpGBFo98HwMDcwPiNKy/HrDI5Q8=;
 b=NqKyu3zbDv/64o9wDTN1rRZvIX0n7py6cId7mC0nv7KxH86c1D5LADLwNLc0JTaodDqy36hrC+N5LjiNiMNXMUYSB0JY/lOeleXHqH36abai7R97Gk1T28z2yd9MAJrQzPfJ7+sanOChFu3xPjU0/3sGlsTSYe9ejJ5UMM5eJFs=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6894.namprd04.prod.outlook.com (10.186.147.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Mon, 11 Nov 2019 13:42:20 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ac5b:8360:b7a7:f8fd]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ac5b:8360:b7a7:f8fd%6]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 13:42:20 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis
 <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: RE: [PATCH] riscv/virt: Add syscon reboot and poweroff DT nodes
Thread-Topic: [PATCH] riscv/virt: Add syscon reboot and poweroff DT nodes
Thread-Index: AQHVmJVLWfJWIKb/20SwKjfRTml2CaeF+jgg
Date: Mon, 11 Nov 2019 13:42:20 +0000
Message-ID: <MN2PR04MB60618CCC891177DC612532E98D740@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20191111133804.14454-1-anup.patel@wdc.com>
In-Reply-To: <20191111133804.14454-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [106.51.25.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1050bc83-e7e9-45b3-eb29-08d766acf98a
x-ms-traffictypediagnostic: MN2PR04MB6894:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6894240E944E361F466F18508D740@MN2PR04MB6894.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:190;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(13464003)(189003)(199004)(2171002)(66556008)(66446008)(66476007)(64756008)(66946007)(256004)(6436002)(478600001)(76116006)(102836004)(7696005)(2906002)(6246003)(33656002)(76176011)(316002)(9456002)(110136005)(4326008)(99286004)(55236004)(54906003)(53546011)(6506007)(8936002)(3846002)(186003)(55016002)(26005)(6116002)(14454004)(74316002)(11346002)(66066001)(7736002)(476003)(9686003)(305945005)(446003)(229853002)(5660300002)(71190400001)(71200400001)(86362001)(81166006)(8676002)(52536014)(486006)(25786009)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6894;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jcFF43S2kP7Z3y8Y79tuHiDqxPD+15ClcqrJerCNOnaf0RFBN5YMwb0IPjVn6EQQWBuUvQkLEjJcyMAwds1ozACgmqIh2Id+xCywEze9jlL4zVKZita3DQmxNDFczKygHFcGt9FYEg6cTDdOvRMr7d5tjQesL5088SGLICwIlJwcRawv7fD8YqrG6fYRYdCCmOwHu6BPaBXOH9IdBGVYNhL7hibkkkJhxyree7EEEA/ZWAAjYQqsjpKkU6GsJBDBWf+o0xoESpQHyf2vOcLD1zxSUeCvpHt8jUqTXnFINvhQvfxHQdTycoeVJfbq8jmMv2jyp7dD+SLv7XBOu+Y5EtO00y1jcqzTlADRQpbzmnvnHHWHLnDhSWjoJ9tXnttQHiliGdoku6WXc3vFawPxGfuFEiAn+mLbaRcpnVGeprFmDMBb/D6c2uKA/DrnSWeu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1050bc83-e7e9-45b3-eb29-08d766acf98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 13:42:20.1314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbOkshl6aimltYc53qmmWVLmINWc3I+SBFTUz8wLqDURaqBsfLIKPWHfid8EkYjnscf693XbNVuOB3040G8V/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6894
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.144
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Christoph Hellwig <hch@lst.de>, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Correct Palmer's email address.

> -----Original Message-----
> From: Anup Patel
> Sent: Monday, November 11, 2019 7:08 PM
> To: Peter Maydell <peter.maydell@linaro.org>; Palmer Dabbelt
> <palmer@sifive.com>; Alistair Francis <Alistair.Francis@wdc.com>; Sagar
> Karandikar <sagark@eecs.berkeley.edu>
> Cc: Atish Patra <Atish.Patra@wdc.com>; Christoph Hellwig <hch@lst.de>;
> Anup Patel <anup@brainfault.org>; qemu-riscv@nongnu.org; qemu-
> devel@nongnu.org; Anup Patel <Anup.Patel@wdc.com>
> Subject: [PATCH] riscv/virt: Add syscon reboot and poweroff DT nodes
>=20
> The SiFive test device found on virt machine can be used by generic sysco=
n
> reboot and poweroff drivers available in Linux kernel.
>=20
> This patch updates FDT generation in virt machine so that Linux kernel ca=
n
> probe and use generic syscon drivers.
>=20
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  hw/riscv/virt.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c index cc8f311e6b..fdfa3597=
13
> 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -182,11 +182,11 @@ static void create_fdt(RISCVVirtState *s, const
> struct MemmapEntry *memmap,
>      uint64_t mem_size, const char *cmdline)  {
>      void *fdt;
> -    int cpu;
> +    int cpu, i;
>      uint32_t *cells;
>      char *nodename;
> -    uint32_t plic_phandle, phandle =3D 1;
> -    int i;
> +    const char test_compat[] =3D "sifive,test0\0syscon";
> +    uint32_t plic_phandle, test_phandle, phandle =3D 1;
>      hwaddr flashsize =3D virt_memmap[VIRT_FLASH].size / 2;
>      hwaddr flashbase =3D virt_memmap[VIRT_FLASH].base;
>=20
> @@ -356,13 +356,33 @@ static void create_fdt(RISCVVirtState *s, const
> struct MemmapEntry *memmap,
>      create_pcie_irq_map(fdt, nodename, plic_phandle);
>      g_free(nodename);
>=20
> +    test_phandle =3D phandle++;
>      nodename =3D g_strdup_printf("/test@%lx",
>          (long)memmap[VIRT_TEST].base);
>      qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,test0")=
;
> +    qemu_fdt_setprop(fdt, nodename, "compatible",
> +                     test_compat, sizeof(test_compat));
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[VIRT_TEST].base,
>          0x0, memmap[VIRT_TEST].size);
> +    qemu_fdt_setprop_cell(fdt, nodename, "phandle", test_phandle);
> +    test_phandle =3D qemu_fdt_get_phandle(fdt, nodename);
> +    g_free(nodename);
> +
> +    nodename =3D g_strdup_printf("/reboot");
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-
> reboot");
> +    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
> +    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_RESET);
> +    g_free(nodename);
> +
> +    nodename =3D g_strdup_printf("/poweroff");
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-
> poweroff");
> +    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
> +    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_PASS);
>      g_free(nodename);
>=20
>      nodename =3D g_strdup_printf("/uart@%lx",
> --
> 2.17.1


