Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692A7C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F56F217D7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V14XvdUT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tICtW9og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F56F217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClR0-00083R-U7
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCkc6-0000Zj-CG
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCkc5-0002wU-0l
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:12:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCkbz-0002rk-EJ; Tue, 24 Sep 2019 09:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569330765; x=1600866765;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YjRlnmJ8YkdtsmNOvvOzVJi1LZ55WMensqP3Mc6kIk8=;
 b=V14XvdUTWBB3+xHbs0env0kV1ks+H7ez6J380kjgkhDQgLMeAMR0YQHh
 qgRDOXwWOZbQUtt2n1VoxZwgtc7d2Ts0aNy8WhSbjm6yE1xwRxxApjncm
 ogwhOweNRQcnodXeymTP5JSVDY9BVsJZBuFwjtFkr03fwEdGwH9VSOjVk
 Q7Mia3h513wRmQkSf4Jz0KyNCLhw1bQwaGeF9LVccWFu05ulYgER1Zil9
 mkXEDDCGFhfRdp2vam6XH09UYJ0MBrvN35fAeyTlk3EYRClC8mqpLpzka
 aaE7Ebn8+G68mvZprznIL4ftSmwGiKiZsjY8dY8gky7phtBB1y3JP3sTk g==;
IronPort-SDR: qg7vqfWNM10mICx27KvVsP2FqOA1IZItjbIESsw5V3+56LdpK+xvVzsDYlOPHg7oLQcR0u1zff
 9PBv6+l+lxsNfRzOdC2Y4vkvvRnM7T12h2FpL+BPMrW01hmwZB2Wr+QPKP8WOHLb7Uvpvso1p2
 oWRZVC4cr4OswPagVZ/z2fn3GfgzaM0LV6jbfZERTcMjN5NHu4dsyMIoo3oAMX9w4mciJro7p5
 s7QivoDY9qM6yYS7rwLRl5WS31GxWUdaIqGCOErwOo/1/AKNSROb/p1UTRj7yP6sIf3IYBvAob
 u2I=
X-IronPort-AV: E=Sophos;i="5.64,544,1559491200"; d="scan'208";a="219807936"
Received: from mail-by2nam03lp2056.outbound.protection.outlook.com (HELO
 NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.56])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2019 21:12:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqQF9WME8UebDcDddN1ChEPrqZhFC4cDB51/fRIcFDXnyPDXzgYFy6LZVsD+bTRxlTn/b2Wv8pj5a3bsqt0YXN356mrvrwPkzmEWrEjnUdt5OypU8ORBCXH/Fb4V91MYZ46YRupWS2sCM6BiFlrHGIyqWPDPgv3mgpBZiBOSxMknJGVkq8hqUpWXy5KK54zGDMbyj7cPkj/6yGCE4QnObOYYrbNAo4RY29XBw0bvwsDFABaOiWka6Fgm5vpqsRxlUz82GdNKjzQBLTFlUf2lfctVghb2h22ONK5DS1hNVe9oG2IHNgUhtPSVW/l9EupSx9SV9+VQ/i+B6mKWRcv0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QFalQcva71sTGAhg6PdUkHuKxqhy6hkayNCFUhn99w=;
 b=XyuNjcvN3I6IYAW6pM5B5VE4HisV6XZMauCsnYulWV0DfVPypEVTsljGUQig9upusxsA8D8aniAbm+EcYCOC9Z3BjusQCDIuIa696ORC71HSL8dZrkuYCiWFf3WHr6ndaONL67/WHjkv4/5v41yTwGeqXKuFni3WcwbM0au1Yq/CyEteuuHXdXn3G7RPO/3zngrS367d21W7Rqm6GlubutevaMiKn98e2Lwae5NTrTeX0QRSkBGju8np14DdVO26hPdk11iUWyTS8qCfcWZivYEE73Y2fHCVdZ44xMX4ecXgkfZS/eV2HxuygwsU+rP4+dAWltp34RLgWFLuHzDptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QFalQcva71sTGAhg6PdUkHuKxqhy6hkayNCFUhn99w=;
 b=tICtW9ogUJkNnltUAgoLsw8Xk1iP3B9oRSC8UYlXfTBre2KWpgKNfpF/ftFCNOKeDdOobHy85CFOCl64K/nAaqcIZLZ4FhCrI1w0Z9rMjUaKWoffBOjrEqC4djdl83iKQnUpdHS3v9bKc1+DG7tL2HqxV4+mvuuNTeU/HFg8kBs=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6318.namprd04.prod.outlook.com (52.132.168.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 13:12:07 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 13:12:07 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v2 2/2] riscv: virt: Use Goldfish RTC device
Thread-Topic: [PATCH v2 2/2] riscv: virt: Use Goldfish RTC device
Thread-Index: AQHVctmqoY2WGh0s9UytwrGPM+rJ5g==
Date: Tue, 24 Sep 2019 13:12:07 +0000
Message-ID: <20190924131131.118155-3-anup.patel@wdc.com>
References: <20190924131131.118155-1-anup.patel@wdc.com>
In-Reply-To: <20190924131131.118155-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::18) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.51.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49b4d693-1c5c-48da-b059-08d740f0cd1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:MN2PR04MB6318; 
x-ms-traffictypediagnostic: MN2PR04MB6318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6318D2B9461ED39766CEA91A8D840@MN2PR04MB6318.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:131;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(8676002)(25786009)(476003)(305945005)(8936002)(81156014)(81166006)(6512007)(36756003)(3846002)(6116002)(6436002)(5660300002)(110136005)(54906003)(44832011)(71190400001)(71200400001)(2616005)(486006)(316002)(256004)(66066001)(7736002)(6486002)(11346002)(50226002)(446003)(6506007)(66946007)(1076003)(14454004)(64756008)(2906002)(186003)(99286004)(102836004)(2171002)(386003)(52116002)(26005)(478600001)(66476007)(76176011)(66556008)(86362001)(55236004)(66446008)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6318;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s5A/bhsJTGu73adFdjsOABdc1CXMM1e6h4fqz3odkzAKfNNmR4g1cvLTZCCUUjhciLU7cNv4bdYO+GQ7LLAB55BOc3k20SWsMMLIIedmbFJ5JMuY50d+HaWFgTxTaiz0aVj+IX9H9sjrshn8r+JJtt0Jvl3RyDamJozbFSaCAolnR64eWPPfRZD2sLMz9Q4aW9aH2AivhwoJOhGjopa4cGbyLXAcd1AhBtqZE6Hd+utFRL3FOl8p7DgeLSzvWKyYuMI+ZQD/odYyNYtWgANHK50H6YDSLX2lp2kZ67b/6btV3brb7Nak5TQpm9gMOAPyBg1wGlX+1KS9N5tXY45frIMI+SlVKQ2WA5Yy7kDA55ojHpCCMxoVx6MHHgf6Y16eYtGkXZ2qmL9vQW8SlIrytbtKKkrBvSp6lZykm4ON8XM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b4d693-1c5c-48da-b059-08d740f0cd1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 13:12:07.5628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43XNRYKuCe6tK0qcbAjPkCi6EwQ8tU49knAaMrhf2xMZJr4KvFzk5Fz48O/N92+3c1lm0ziIjgW02aSYnNpstQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6318
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
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
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/virt.c         | 15 +++++++++++++++
 include/hw/riscv/virt.h |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fb19b2df3a..b33753c780 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -34,6 +34,7 @@ config RISCV_VIRT
     select PCI
     select HART
     select SERIAL
+    select GOLDFISH_RTC
     select VIRTIO_MMIO
     select PCI_EXPRESS_GENERIC_BRIDGE
     select SIFIVE
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d36f5625ec..95c42ab993 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -57,6 +57,7 @@ static const struct MemmapEntry {
     [VIRT_DEBUG] =3D       {        0x0,         0x100 },
     [VIRT_MROM] =3D        {     0x1000,       0x11000 },
     [VIRT_TEST] =3D        {   0x100000,        0x1000 },
+    [VIRT_RTC] =3D         {   0x101000,        0x1000 },
     [VIRT_CLINT] =3D       {  0x2000000,       0x10000 },
     [VIRT_PLIC] =3D        {  0xc000000,     0x4000000 },
     [VIRT_UART0] =3D       { 0x10000000,         0x100 },
@@ -310,6 +311,17 @@ static void create_fdt(RISCVVirtState *s, const struct=
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
@@ -496,6 +508,9 @@ static void riscv_virt_board_init(MachineState *machine=
)
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
=20
+    sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
+        qdev_get_gpio_in(DEVICE(s->plic), RTC_IRQ));
+
     g_free(plic_hart_config);
 }
=20
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 6e5fbe5d3b..e6423258d3 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -37,6 +37,7 @@ enum {
     VIRT_DEBUG,
     VIRT_MROM,
     VIRT_TEST,
+    VIRT_RTC,
     VIRT_CLINT,
     VIRT_PLIC,
     VIRT_UART0,
@@ -49,6 +50,7 @@ enum {
=20
 enum {
     UART0_IRQ =3D 10,
+    RTC_IRQ =3D 11,
     VIRTIO_IRQ =3D 1, /* 1 to 8 */
     VIRTIO_COUNT =3D 8,
     PCIE_IRQ =3D 0x20, /* 32 to 35 */
--=20
2.17.1


