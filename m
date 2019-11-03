Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287DBCA9ED0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 07:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E632320848
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 07:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gNju+hJR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wsRs5XNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E632320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRAl6-0001O1-M4
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 02:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=20340a2d7=Anup.Patel@wdc.com>)
 id 1iRAjY-00088x-1j
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 02:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=20340a2d7=Anup.Patel@wdc.com>)
 id 1iRAjW-0003r2-Rg
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 02:55:35 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41717)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=20340a2d7=Anup.Patel@wdc.com>)
 id 1iRAjU-0003po-1e; Sun, 03 Nov 2019 02:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572767732; x=1604303732;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ky8BZ8iaJiI0A0WDHkxMzZD2O+ipw7mbPNxy7q+UjxQ=;
 b=gNju+hJRs3bSM6TAFTbA6kq6RtUr71mUNJFDhekxtr9lG5gr3/6hUWP3
 CKNzFCBDn79w43aGRr2lzeCqGD4GpNMqVUOjx62qgsIOOVrAMMJraZiQr
 1J24hp+OR6BZdGzizzPqyKqAC9Go5Jbd0ndly9/du6UgRbZ/IVszaURV9
 vmeZvS5phc4rWVZIz3gYD5LufAJHfFclVP3A8qrc9zbt3X3e0fUHOkag3
 +/TYodBgZVaE7/rOLwotZ+4L3cWFnzpes+G9DP+8k5mF8mbQk22RCk7fn
 7dnH1SFFc0ijulPauPO2xqzjLbqrgCElRrT81UO5HzJsbkEhtcBkvLw3s A==;
IronPort-SDR: M9I5GuufprTqTnXLyBy6phzNrzu3+tdF5dF2UamMRLQvgVLdxt3Ir82TpOIxzxAI32I2guRiN3
 h5YAqFSyG/JhEIcvnVWEjInaDua0+BHkGOWvLBDBLRIiLUu8pG6VEHfykRvJhBTDR8CbLctz8h
 ax1NGzNw93LW1y4frL/E01cAtS8gxolZBp8BGZlI+VOjV7Riiqwun0vpGicAB1zoT5kNk/Y4MU
 Smy478H1S1vYf5Qvh08iRG7FhalvszUGATI3o2Ru/a1Qgv3wAH9DcENNPbXKefcE1/kHF97YGM
 ECE=
X-IronPort-AV: E=Sophos;i="5.68,262,1569254400"; d="scan'208";a="229199001"
Received: from mail-dm3nam03lp2058.outbound.protection.outlook.com (HELO
 NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.58])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2019 15:55:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwhZ0QYnGJMAFfWJMsxc/cPoPIEEba5yUTkYP4Xbz2ooKVnK2dZH9O4COJjrm3iJm1zJR+B7mxjdzDpBjp8NUmKh+nKGlJ0IwiTpTcB9Cvf4mWm/masbB2ScLaTfZUkJzys/+j3l/tqJhXh10kfo5zfcMNE9xg5LsVGsJiTG/UlPQDlU4y7jNLebzQzXJRnVyGXABba1l3G50xz80CUN2/Wrxqk1fR2vfyyPG0B9Qfv26+P7ViC/fauYr78Xy4UMUM8VM80W6Q3LtYq1JZR7BppyZtORAH+KnZbRUnlvh6vJYQi03hfokUWTOMGoefzirjllMdYccTXfU1jQVVbs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfO82K7SRKK9ZCscBuVbuPJlRokkEhnF0xm0w3c+H70=;
 b=jxrccz6XK9EVkoatt99qfgyodt/aPRZgP4zzJm0aEsooIijzgdgBzcmRj/qMczybyaOs6PGFjftssJHivrf+7aJADGm9M7bZXSA/o3KMyOrvKCDWrtDb9DUO5dqt75tSdNyTK8zAz9vr8StDY6mvLLuuCcSN1wWCAoWXXaRDQRRT77Ss2yqn/71f9WThQHRZJo2+6I2vOZ+4OvD3E1zI7SgnUW5ealYyKoNBZv++GYZMyiMcBM3Qdzg5E5qRrMy7YcCmCU2TH2/D6oOa+UN30mv+6rneivliU7divhCKZnVGwV53uvCQP1Arfv1n0sfqlw7cnF2gUPSnxKjyfGwm9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfO82K7SRKK9ZCscBuVbuPJlRokkEhnF0xm0w3c+H70=;
 b=wsRs5XNEssiVO7wcHoC8ZUCGocQhkXsDm0LvReVhv8ObH5cOVrS+WH169kdfGHwO686X/oj3ZyT1km/BgzQpRZb6j8AHDdv//hfIrnQL5RlhSmfP88wbA5eVPbrlOIxD7O/ij+tIPD1txXzseI/mfxfHZ6lh8WWnVhxcHCKLvuk=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB4635.namprd04.prod.outlook.com (20.176.106.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Sun, 3 Nov 2019 07:55:29 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::dd8a:a9c0:97c5:cd70]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::dd8a:a9c0:97c5:cd70%6]) with mapi id 15.20.2408.024; Sun, 3 Nov 2019
 07:55:29 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v6 2/3] riscv: virt: Use Goldfish RTC device
Thread-Topic: [PATCH v6 2/3] riscv: virt: Use Goldfish RTC device
Thread-Index: AQHVkhwPG0F9IkEqREKQwHL7/6aKCA==
Date: Sun, 3 Nov 2019 07:55:29 +0000
Message-ID: <20191103075353.86497-3-anup.patel@wdc.com>
References: <20191103075353.86497-1-anup.patel@wdc.com>
In-Reply-To: <20191103075353.86497-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::20) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.18.255]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8258c7dd-27f8-4476-4355-08d7603331be
x-ms-traffictypediagnostic: DM6PR04MB4635:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4635DC846841DD94579A7E1F8D7C0@DM6PR04MB4635.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:121;
x-forefront-prvs: 0210479ED8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(189003)(199004)(71200400001)(55236004)(4326008)(305945005)(66556008)(71190400001)(6116002)(76176011)(3846002)(14454004)(102836004)(36756003)(256004)(476003)(110136005)(8936002)(7736002)(99286004)(54906003)(81166006)(386003)(316002)(2616005)(11346002)(25786009)(26005)(6436002)(50226002)(66066001)(6506007)(1076003)(66476007)(478600001)(2171002)(81156014)(8676002)(9456002)(5660300002)(6512007)(64756008)(446003)(52116002)(486006)(6486002)(66946007)(44832011)(2906002)(186003)(66446008)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB4635;
 H:DM6PR04MB6059.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTzYDJBzBI/SXs24JO0WJgZGRohI3wcx1W/6IcdxNjZAZUT+xU/W1Talbo+9vM+ebOhJt//GnDZW0Dki2+MMLSYpV+mj4V22kiPwA1QyYtiit3iLjd9CmX+AcSPDzVY4/bKsj60Wh1vvp+pCr1TseV/9umCdtZtolwLOAJESI/kQY4KPAd+7w8mDfkmI1UnTXkHyX7IOMkvievcmSVpxXFJctJWVgETkeIlWRh0+kHDXKc9Zcu2eybQw1I6PHab0aAdu86GIlA52KmLPlD5wALrZNBOgaL+zi+kRKixWIKI1ZeMDjLslD2QkaC3mioi5cj3QfDmBMNyJZRAr8qdQTnEw+hVCkXn31M2KUXZCkAjnAsdYzlBtIcok6tw8qn7ICW9sbaaLG6r38MBogk1f1HM37989ZLvxXJfMsJp4DcOMJd2dlw/xJ6Nqeu4IN5dJ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8258c7dd-27f8-4476-4355-08d7603331be
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2019 07:55:29.4793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVDB+ZNvY+epa+mSPJk8obVpELHY2XdjPka1IeN1E5u9CVCO4p5wUJWJO2ULgj5yw4mueNWt4uXGSnVaFoJbEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4635
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
Cc: Atish Patra <Atish.Patra@wdc.com>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Anup Patel <anup@brainfault.org>
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


