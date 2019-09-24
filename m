Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C5C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFBA2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hZfVkksJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Iw4fiGjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFBA2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCgSY-0001Ce-3w
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 04:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCgPf-0007gb-TW
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCgPe-00050M-Jk
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:43:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCgPb-0004y3-PL; Tue, 24 Sep 2019 04:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569314589; x=1600850589;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YjRlnmJ8YkdtsmNOvvOzVJi1LZ55WMensqP3Mc6kIk8=;
 b=hZfVkksJn1DPA5XlUIBfkvhB8SaYYcbzHBU3khuPDV1UxZupxTXjxjGF
 66+HZWGv+InumtE6lATDj7gTp4hKM049e9LTf1vkvcNAKG5/BkoGyo3p5
 zFNP7UKb332RBVHen8GS9NOuy5dXxRrXSK6xAk5NSHbOEW7B3j+Q6aDuT
 H7m1XJ57zFiZlR0ekTYf/sD9aNlaZKW1h/ORdwYYZpccmdklyJhMzWsox
 HvfuvHQD6qJg+f8WeS2g2ldg71zk3JAcSmmjM+oH1byZ/NAc1AG6DSCec
 6YrQUEixxjmwehNsu5i8ogV6QXJHN+6zMavr+STtNF9hB06/l3GyzTiSQ g==;
IronPort-SDR: EGS5DMJQf89tINH1cqJQmanqlYhiJ3KbCTSn6p6u4uRVrqrjG4f5CmHskbEyGS7c5ZcekfGGmQ
 7+Rb8XOikRpX+vwTpOoDG9P7Z8n5EoC/c6Fq0m/rpUySqob9VL3rm/RYEXCudP9gGScRoz9Ccj
 xfC/P6wuT8huz1vOP6yPTMLTkvFkCuhm6y6HEz7sHh46q4NZvRzSulQFkU2Yb1AdIkDbNC+VED
 etPTLCsBeqCQ1oSnzTN4efz8e2vXNo1UPLuZZwJBYxNo6dWfxhek6bRtpWVPUXMsB5kU1fdGCM
 FZs=
X-IronPort-AV: E=Sophos;i="5.64,543,1559491200"; d="scan'208";a="119740823"
Received: from mail-by2nam01lp2051.outbound.protection.outlook.com (HELO
 NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.51])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2019 16:43:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGSyTpP/4AJACFdNzF67N7WRZFXz3eM6ubrGogBWIbuerzEHJGQ9X2iaorRfdaAe/PyyHFn0zGlnjZ+1Lcls27kBFTlYmRSDs3VqXCgHiubSMDQxPs6aC+xwbAFctVDW8kLzNn6fM+IgL5E6EkqloDOsTyI+AFosCHsBmSxqOKSPRafm+Iw2RUsTJbMxfI0pVLPFhm8cABCYsowgOw+3m2+G9eK9PL1uibfCQyAsk6pdqij9VCHKrlL0PgA3yi2E5fUMc4hlLuYatIuBMFrrsa4HoZSBPNkE5p9JAJ0R7QDfK71e9YXVVG07CoFC9OOY/lM3hnVx76FZIl93tO6ATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QFalQcva71sTGAhg6PdUkHuKxqhy6hkayNCFUhn99w=;
 b=fePmRDGgBRAf2C249k7sNHjP0rS7TZ5UFIHyXbCUXoLGE0+9h/Ij5x47nPam3MGv8oAs9a3jJ81y7dzyj2EL4azycTPapySzg51JRYwLAQwTtSaFG5Q2ylyjiSwW8u51hsq14tQt8f7Oc2tO4a4sSTAStTmQ1D6q6v+8CTKWtJoCnG2/mdlKT+6v2q92wZBF61kxY68bpWdQTOxt2GAC/s6W9Wrn1rVHC+Q3hlL5Gr764UVEn6GOoPU8oIV2gz3QDi311VMG249Q++ow0D4QNPhesnhThbZ4xbK1k2TFznyWoZ8x0MicqoQPT4nOEaZrbt6sA7hFJi69fRgdOTa7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QFalQcva71sTGAhg6PdUkHuKxqhy6hkayNCFUhn99w=;
 b=Iw4fiGjUM4WR8cT8JVU9oRbvQhdmleLyRs2oAQLn14uIwWlv8eqKJrDGYw3/WKYX864jKSgBWTFLjQejgEzpCoTwD7y5u027wpOWGtGOmt/Ndw6EIDTuSrwtzBL9j9UQ0i+JbAM+niFvO102f4PPVwERW2UJAg48Vk1ueAaYnPk=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6957.namprd04.prod.outlook.com (10.186.147.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Tue, 24 Sep 2019 08:43:05 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 08:43:05 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Palmer Dabbelt <palmer@sifive.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH 2/2] riscv: virt: Use Goldfish RTC device
Thread-Topic: [PATCH 2/2] riscv: virt: Use Goldfish RTC device
Thread-Index: AQHVcrQVe624jW09nEa7T4mrUJmZyw==
Date: Tue, 24 Sep 2019 08:43:05 +0000
Message-ID: <20190924084201.107958-3-anup.patel@wdc.com>
References: <20190924084201.107958-1-anup.patel@wdc.com>
In-Reply-To: <20190924084201.107958-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::29) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a755d127-04fc-4ac2-ad8a-08d740cb3744
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:MN2PR04MB6957; 
x-ms-traffictypediagnostic: MN2PR04MB6957:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6957275E96CC73CFDAB042EC8D840@MN2PR04MB6957.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:131;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(189003)(199004)(76176011)(66446008)(2171002)(5660300002)(66556008)(25786009)(99286004)(86362001)(50226002)(44832011)(66066001)(1076003)(8936002)(2616005)(6506007)(54906003)(256004)(305945005)(446003)(81156014)(478600001)(8676002)(81166006)(3846002)(2906002)(6486002)(71190400001)(14454004)(26005)(71200400001)(11346002)(7736002)(386003)(66946007)(316002)(52116002)(64756008)(4326008)(186003)(6512007)(6116002)(66476007)(36756003)(110136005)(476003)(6436002)(102836004)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6957;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4i1N7X60aH4uuESwyEZYb8/2zztRWEHbR9kcke40F8cyrE5AsQWtGeLLOIXbIrT3FV7LaO9XpL1JYPJSj6Nk1y76Eds+Ko9aPOcnGlm5qvaRFhr1UIP1f7k1dpuDKC6WgPmbHBWP2GEFsIsyqzsU4Czi8agMdtJ3mFoUlseVTQdVeZXiHUB6bSSuKhn9sizqPdCGAS8hf/+ZqLSzIY2NA/BvX1y+I0D+TGCQTwAFGKFck1nZRKSIcN7cq2o1nJ3TwE0Fzp4TnPmqWkmjbDjIEYX7itYg3EY4DeQEYuKqZu6AP+7kQC2qHm2VFNP9rRd/FumhCpvd052qClm5ozLtvr5+XK9vXqABDeT91Ju8ToFY1bZjNBZ91KgYRbhLYAtl8ld5cM2ijQqLjkY7k4RLsGvZQmCwUpxkeO8ISrwsd9c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a755d127-04fc-4ac2-ad8a-08d740cb3744
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 08:43:05.4246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0HNH+xZSJFYwEa8XVAABXVF3fYQjaKy2stJyr/HBl52N+M5dqalJv4leBJEK2L1mH9piHRqsxNDtERBpzz7Elw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6957
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
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


