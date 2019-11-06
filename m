Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECABC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB4B2075C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jHxhRGJO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="arN0kWjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB4B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJzO-0008AC-Qb
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:00:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSJvi-0004kN-T4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSJvh-00064H-Md
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:56:54 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSJvb-0005zm-59; Wed, 06 Nov 2019 06:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573041407; x=1604577407;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Z/9D9OGXgTVv7J9Pqpy+//37V3BK1nIPYhs7KJBd2tk=;
 b=jHxhRGJOShMBz4Ff54wKY6koxhyJB3XAy8yWFeS1rYz50wb4jP0iuO8j
 xGl3Ffmm0AZitcDZ8phkRgmmTqOasK7jlYQmuyWikNBcOrY3iWqdZOjmW
 LHoLYsnASmqYSpxeU7KKizGG4FaKrErpoA4079FmhExV/CRCEQkVkYgx7
 vylGTAiEM/Ll1QltJl7vudaxJHdIuM0YFv4UehHGEW1sdo+ExfmjozFLp
 gPucjQpNN9EbODjqKEd2bJDM3A6tcvDr3YZsCSILhx2OQzr0xrsoZtNSr
 aZhEJirVXbaHUX0q1vKcpm9EotuJ3OsO87r38Oe0HIAKB0IRBUBm7XaAf w==;
IronPort-SDR: pmRdHA6uPI4FrojHpGysZc9gb+fUFNtFnW4vVIl6XWQhSNRxHvm7mN0L3PzsXBoViKSIGr0/1G
 sNKAmqehaHZC4Ns80wR9aBDbOLEBLir+rIdg2wjRlgk1hAjV6C0XtBlWXl/otab+eWPKRVVnxJ
 YR354XfdezhsNTY2MACBNqMCwmBmncwqOcCuqODx7oJiXhgFD9CUAbsO29FLuQ237U48x/KnyX
 4SMhvCcI5a8VjXJh97NTwYmp8W4CrYhV4bx0fWrtWWO8J7CsbVy8QI7F1ZyDAHmGpYsB1nMOn4
 CLs=
X-IronPort-AV: E=Sophos;i="5.68,274,1569254400"; d="scan'208";a="123022224"
Received: from mail-dm3nam05lp2050.outbound.protection.outlook.com (HELO
 NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.50])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2019 19:56:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn3Tw7BxvFFGdwzQG4/e16jm5sO5saDksC/VmNu+YSKixVAGdWx6fiRiIZudEu4NIUPF8ksLG2+PBJMCPaE7R+QVxDeOgoTSdrGryPRcV1KPSb+SSSQfQkJpIhbclcr4YoU/7zSE5TWEpXARuNWoaxJRvaIY5kY5eWandrZsQpooccFd1eUehOa690hkZzY8kFTrtkvz435Ct9a3YTw3xYwR+pLZmtNL+2dzyc2ZwIkjgJV/KeDvoBkNVHWG1kiylszbn+EJ+A6ViooGDHLoOVDTs0hbZzKIHzW/guee3U8eqX0/jNp764+N4Q+nycNVM7SQ6HMw2EEpGn/4mpwvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dHJ9znm+obj0+HDPGnmLvvFEpArXGNqNkCytI9TMAA=;
 b=NcZvbRosRfTT1osCqsSftCdMkd/pVjxW3ahiPpHyI0R/VKM9D2xjUxSKiqDa6hVzLBM0TTL9V993pa6AvESu/N7720hAp3YUQirf5htjDVT5KbiOmxxqzeTzCB4e+oWbaER0x36241aYxHfQQLL2j1pUPiZAKk41o9FewVc87Sbc9F8q/OtXagOYDoU/RjqhsmQGpl0ScRtWCH1451CxitBrpEY0l5LxFANn7FYLxgNM9qJEOGPlMQTituVCqSe9oXLPDW1LxXFW6lDsT+7mcXQnsSQDXyM2FquPkgHt4aOfQzN7+onLSdFmyAO6kmN03t7cEldxOJcac3jP6Y+naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dHJ9znm+obj0+HDPGnmLvvFEpArXGNqNkCytI9TMAA=;
 b=arN0kWjljQ9CaTY+y4og1Dd40Ww1RIAVnj5JMhsNkUY3vsZwlNqovCUbKWyT9DAxADULP+SbzY0cmWBt9nBv/kS1Q/9bk/4ihC6sPzDcK5/CvueWaL0f1IGwwTZ7E/nycTRkbhigWzsrm2c4Ulqma1+YaeCV6uP+GC0KNlVgsEg=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6080.namprd04.prod.outlook.com (20.178.247.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 11:56:43 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::b181:29c4:fcfb:7a0a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::b181:29c4:fcfb:7a0a%7]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 11:56:43 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v8 2/3] riscv: virt: Use Goldfish RTC device
Thread-Topic: [PATCH v8 2/3] riscv: virt: Use Goldfish RTC device
Thread-Index: AQHVlJlCtQKiqy5yhEGvdBIqO3FM1A==
Date: Wed, 6 Nov 2019 11:56:43 +0000
Message-ID: <20191106115602.74299-3-anup.patel@wdc.com>
References: <20191106115602.74299-1-anup.patel@wdc.com>
In-Reply-To: <20191106115602.74299-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::11) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.25.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d214b19-8649-46b9-7ac7-08d762b0645b
x-ms-traffictypediagnostic: MN2PR04MB6080:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6080BFA8BC1580B6C1528C5B8D790@MN2PR04MB6080.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:109;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(9456002)(2616005)(6506007)(99286004)(52116002)(55236004)(102836004)(186003)(36756003)(76176011)(66556008)(81156014)(8676002)(26005)(8936002)(6116002)(50226002)(476003)(256004)(2171002)(386003)(6512007)(4326008)(44832011)(71200400001)(71190400001)(7736002)(2906002)(5660300002)(14454004)(6486002)(1076003)(3846002)(446003)(486006)(11346002)(66946007)(66476007)(64756008)(110136005)(54906003)(81166006)(316002)(86362001)(66066001)(478600001)(25786009)(66446008)(6436002)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6080;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T1j9wIX38PdoepaSr9WRJqvi2NBRABKPaG6tdhfk1rziVcGfVlE0RsFjseoQCfu8pnBJK01LhHfve/tMhEQhbWkEXBOPe6ZGcCPqUz0uHN3wBzXYucu+D89DKcinRSkxT4d4G2LG4FBnwNQbNfYu0dHKzy3YWZT9GXl6q4xml6Y7lULnwDmDvlmeGVOzYkvNkfWRfBFv1CohCDxVR6FnhFqSyBdaS5c67d70YeS3LypCNjgTQ3o1sCJDD719jLv/Dm+Ox0nV34Qm9EH7xl3qiwZd4bC8CfgvxHhjYPSL3s0lRsaL+LDiGW2KLaZ962cSYlYl0ZF79x/EahPbqiF6PQ8jEMZJvSEIMYX1i1Zc0YyZd04js7DNrIUCC2A5RXcGtEtQ3NJ3pZtts571WApru0WeKrVj1n2E+ohC2rse5LRs+PSmeS+8SWSZzq1C7LbN
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d214b19-8649-46b9-7ac7-08d762b0645b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 11:56:43.6076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbWRojHeJyOHu2b4Zg3RGwGXvDO4DF+zPbPLWFKA7vAOP7kVjwpk0LJJDSio+AXglkxOlZPk3nInp0xCitZ+5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6080
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Anup Patel <anup@brainfault.org>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Philippe Mathieu-Daude <philmd@redhat.com>
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
 hw/riscv/virt.c         | 16 ++++++++++++++++
 include/hw/riscv/virt.h |  2 ++
 3 files changed, 19 insertions(+)

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
index cc8f311e6b..d7c5d630eb 100644
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
@@ -383,6 +384,18 @@ static void create_fdt(RISCVVirtState *s, const struct=
 MemmapEntry *memmap,
     }
     g_free(nodename);
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
+    g_free(nodename);
+
     nodename =3D g_strdup_printf("/flash@%" PRIx64, flashbase);
     qemu_fdt_add_subnode(s->fdt, nodename);
     qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "cfi-flash");
@@ -579,6 +592,9 @@ static void riscv_virt_board_init(MachineState *machine=
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


