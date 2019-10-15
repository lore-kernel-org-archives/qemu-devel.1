Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7037C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF662064B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZvYi0ezA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QQBhtAKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF662064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKILj-0001de-Pm
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 04:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1843cfbdc=Anup.Patel@wdc.com>)
 id 1iKIJ3-0007EP-5a
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1843cfbdc=Anup.Patel@wdc.com>)
 id 1iKIJ1-0004Xq-So
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:35:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49873)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1843cfbdc=Anup.Patel@wdc.com>)
 id 1iKIIz-0004WZ-7h; Tue, 15 Oct 2019 04:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571128545; x=1602664545;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YjRlnmJ8YkdtsmNOvvOzVJi1LZ55WMensqP3Mc6kIk8=;
 b=ZvYi0ezArMaGV/GBi0eaYSqQx5OrCrUdrES2YCw08LkkJcg0y4kWT2ZE
 3HYR4ROmmTMczmowYZulaCY7QJEfR1kmsUM4fEgKB637aeek/Ah51VT9y
 pg8wXB4HBAKYGzrStsQyfyM86xHvgPU8oM9ezViVy5K1bqCqKgANWPyyw
 K7NrYkV+jtGXrr8jEOGo6zT6QZARsuI4ug7227jdSliJxaWj8Y/YKyEYh
 AMUL5JKumoQh7k2vgfS5GORF2gpkkC1XFLEdbT2TCIsr7Jk92+NdNh2LU
 t113xdVcCsHWmVxW7cdFxpvlQ9sBXq2djjvEYhpeppIJpNX76m0MGetl1 g==;
IronPort-SDR: pxy3EE3aGpgaMKbrB4zztj17HVB5c9iM4qVXaqh1b+aARCdtpYBcHw7jD8n6AQwWnYatBsWzIf
 x/MYfI5CoZ4QOTdU+tvxS/OvzrJk0NbanO+Cj/JRw3puns2yuHTyd6QprMrV2+PSp1HME3DtWy
 tv8OXyUKuviPrW2RFiyjRZ86ZR3707AKGNQqgX3OlIskPaGzcPkdmP1vFo5XrwBNR0FkLgApee
 u7/J6hOGhf1PCQ5HfFaRIhxP2eHxYT7P/hJ/paai+3Cpo4SC++hGJA0Hwh3fo0RzvV8WShXUzD
 VKk=
X-IronPort-AV: E=Sophos;i="5.67,298,1566835200"; d="scan'208";a="124990126"
Received: from mail-cys01nam02lp2053.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.53])
 by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2019 16:35:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dU/Hi5tHoTLRIGEY9hvXd1eGfWtrIAC2WoWxqmjU0m+fmV9CMNbrWFavsKiwtEA/Z/fGkY+NhIWpMPNhn8pCp/ZP4xH+dKPIyWkRpYuUSvUHibyplR8UBOg0ch7e58ln6PFMSR0xJvoluabcjNH/5nZ9uniZXvZVB7buX0ZbsAZFD9rkA7vHNriKjIp5JRW7cKd+Fn0CGO51fT22duEz4qE4qs5NVu1HhxxmsAS3o/orVsqshJk9yjQYgs4oa/AFh4GafHQ1Klfnyl/EUHP2b+6JbKPDqIe8Tjtl1TMZsHAS1wLkemR37K2KcV6NbB3+sVmjz9bdWeA8U3b7+m4c3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QFalQcva71sTGAhg6PdUkHuKxqhy6hkayNCFUhn99w=;
 b=edHQu67/uLkQrOtO/MR2cJuyfcuBpJOx8ySgX2xWE9m+n7pEN4CzFKdgqZYF3DaF32jvB1LrNmSF8RIdhE+zsgrRVyxLoTe7vcq5YfVPjudMkabXNjfGDr/gm4lnQmozloaWfo2WTDMCXAHURl3QZkzoDpS9zTR9B0a2oeJoy+PDckpZA0dijeVZw16ddhAhlY2pxQKzrxhwU7yaYwbyyliZ2Ml/1COdnh3vY/1oCg0143MLZ0pZRww5g+72WwOfoBmejga36Tep5NbQlmrzQDojHBbzei5Uo0IkqtZHQI5VntJ6MQrVH9cLltpMX4Hw/oh0NCWE3j4FAL/1fA7gfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QFalQcva71sTGAhg6PdUkHuKxqhy6hkayNCFUhn99w=;
 b=QQBhtAKPA/YjlLlGLx8nOgC+lM5Q65IfWc99Ubb8d3grU7hBEq8ZheKSPaopxHULp3s3MeNizEj6+zHJUv9Rqi2G0zdrvuf04cuUvCICCh1n5D0mXn+TTz0c5Ocg8b+6AmvWajKv5qEqDSnX0tHOVwIKHniZoKpWOYiGl/XHkNc=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB7071.namprd04.prod.outlook.com (10.186.146.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Tue, 15 Oct 2019 08:35:42 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a%7]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 08:35:42 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v3 2/2] riscv: virt: Use Goldfish RTC device
Thread-Topic: [PATCH v3 2/2] riscv: virt: Use Goldfish RTC device
Thread-Index: AQHVgzOIEoApYUmy8UKrhJBWQTf9Yw==
Date: Tue, 15 Oct 2019 08:35:42 +0000
Message-ID: <20191015083459.76959-3-anup.patel@wdc.com>
References: <20191015083459.76959-1-anup.patel@wdc.com>
In-Reply-To: <20191015083459.76959-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::22) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1efe3e6c-76b0-44ae-7661-08d7514aaa6a
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR04MB7071:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB7071B2C750F9A105B33E857E8D930@MN2PR04MB7071.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:131;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(189003)(199004)(26005)(71200400001)(11346002)(256004)(446003)(66946007)(386003)(6506007)(66476007)(66556008)(64756008)(66446008)(14454004)(36756003)(71190400001)(102836004)(186003)(478600001)(44832011)(66066001)(476003)(486006)(2616005)(2906002)(25786009)(5660300002)(86362001)(81166006)(3846002)(316002)(50226002)(305945005)(1076003)(4326008)(2171002)(6512007)(6486002)(54906003)(8676002)(8936002)(110136005)(76176011)(7736002)(52116002)(99286004)(6116002)(6436002)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB7071;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZKCB6cINoYcwfRw19dRqgrpaaevDprykpS42tEM7fudab4b8WTUxYfryRqq3o4fSNLESj3jrDwRXngzL4jzYLya0ZJ+ZXsemCHvO9yx/GAh3nleA4yOPz70KAl3RCkSjRShlZnL6JtpAsNcuiyaGaEynKv+NYSNC231uuC3/PHXDC+M7Avftu/7/3C0D7x2uGlt+wPQDD5g4FcMZ18MvNYwbMU/INAVtZXYgTEa/YEps0kmPi3bPcJ0/SuhiRWC/mkN0QvUMxAeVMqfbmt+qu3Ci1WPhmO3Uv3mP07R67tEAi7MItzuSccIVRrGYxcJeg4SVS53Au0Vp4TsiBlfIIndr/MQfR3TMm3AGlsccf1QXrnODySBmycpg32SHxbbnjmDTDkYs9EYd4Q4ykGgQZE4cXICZ5xOh3H+VEe9MxT4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efe3e6c-76b0-44ae-7661-08d7514aaa6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 08:35:42.6507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nw4TYEaPtXcM0Y/1lb+FtIK9gkQPVXe3KLl5xjDyFx4YJzLDwTlLOReiH6lJA6s7QWyfc/uu7zF2/Dw8S8xZzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7071
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


