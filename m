Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36718CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 04:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F387C21872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 04:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XN7I5Tjc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bL2GlJ0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F387C21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNrET-0007LQ-3b
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 00:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1942c9cee=Anup.Patel@wdc.com>)
 id 1iNrDC-0006CY-3M
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 00:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1942c9cee=Anup.Patel@wdc.com>)
 id 1iNrDA-0007ly-UU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 00:28:29 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31213)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1942c9cee=Anup.Patel@wdc.com>)
 id 1iNrD8-0007ip-Ba; Fri, 25 Oct 2019 00:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571977723; x=1603513723;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x2LYqHXcC7dq/y3KGLF8LgBgk5NG//4566p8xmnogNQ=;
 b=XN7I5TjcpZ9b6tbOD/M0imSSon8+GJgHRmQPD+niLgHiJ1u9P762iEnY
 mCJnRtsduZfnKFfbvBmO94CUGGasXkPfjW/o78Cevsuvo3zUf3OE+07kZ
 e4fPD2Zp9B2eUA9SDBxa8hWNmKs1au4XuSK10UA5aBFi6GjCkhLuBrw28
 TVgAHAtf7ZGH9wGve1vnpMkiunpKIVVY0vZneb5zyaDX2NPLXVJNjEiBZ
 liLI06+SpTUZlScC6etzdookaa+Pe1bFf3Uv6nzu/uoKydn+Yupjr9Pht
 gAMPgkI578JCqe5NAPayReMiVQzuUwNsbaxPgp0F0/2VKjYkXRvCYlLKJ g==;
IronPort-SDR: c5B2kpsMr77Ppx0cANLNc+I7iXNu4GUDYcYl5nMvFn6ZHtmxjPq1DwWE9zhru3hCozQsyJwldu
 WcXgILweBZkM9CRy9dsJq1gV6idn/a2cPz9pQ1kDzQLpzpbhzByoe1tn6i6jxvpYjxfwXcSQfa
 7cXOlADHfATpDgok9ORDqNI4oCnp+6U0yb68WZD31MV+YfUdDmBSU/8BST8k9zou8GKvcDlmfq
 rfrAEKcWeLQTgilNROVredMciGEtaBGAfnpw8bas9AfSfPcSsLuj5vSGidi+2Ayd0Wkqm35RoL
 ZSU=
X-IronPort-AV: E=Sophos;i="5.68,227,1569254400"; d="scan'208";a="222437869"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
 by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2019 12:28:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izRpSa6y2QqgwIElFnq8auHeboI2HHGImxj6Ps3J2VqqOsW/QC60mp1OmBmeIchfURLPzFpL2Y56zbS5FpfXDFRQycOagLd1evFCMnchvZEBJQl+MC4g424uIRoTEy8GcN3GfMdfMYOyNA4hgy2k0Z+qn/HQXTpiUmkj4jVtI60aNzLGaKT3hsrdbQoDi+6QgoCpgLEVOvGxSQ/KFIwJLkRxo+HfKmwZGGSD220JkN++IcgjWV8vGdnQSHbN+lDxPJ+BKJ2YhTHEfp1SSwRk4nQJwGlUnKHunmguUJuJM2/R6rISnPS7W53uI2apU6JG8XzDBGL2uSSNMLeRxevc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0y3+h1psXEIRtGMAZtdqQKFI9+CUrcrouf9S7Z1+wE=;
 b=TI+n0vsnMxpotTcQezguzA0bXCfTZXU54RYfXE1sLm/JngoqylnroKxeGT25mNMXg4oXw/1dTVERAMyVf9U1j+yhmDJdiwuejYcibV7DYQ/srxrUhMpY7OiCeLdTc/Qw6zqpUfMpH9/Oi3yjrV91ZvVbLqnaPz6aZqnh5B1c4LRnAurDel1WihA7Ekhi2wq/BlUdNIpoxe/T2ymxMkSZOLtkV+/yM/IhYd1q/A06wDeWZD3GV3dmPtpFcNB8Kr+rG2gTRN2/LXhsSft4F0pvLLYtEkpXEPW9/ZaqYLLTxSsNwVHaOgiOOzxIRccnJ83WFDBSbQQjz6N3S4nDfWydew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0y3+h1psXEIRtGMAZtdqQKFI9+CUrcrouf9S7Z1+wE=;
 b=bL2GlJ0m+7Epm51fvvPkd2loEE7Zt87JKsW4G4QeUkSLeC4sSmfl1iN8xY+x0CWO8l8oBCOIttWp6W/CG66NCrrX2a5Ftju0j3dR3z7aw/RDsxbdinNK8WqZviV4wIsq8NjSJOIF+4SgNKNOTXm8pMz4foOWQVx+oCOAwXrLGrc=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6048.namprd04.prod.outlook.com (20.178.249.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Fri, 25 Oct 2019 04:28:24 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a%7]) with mapi id 15.20.2387.019; Fri, 25 Oct 2019
 04:28:24 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v5 2/2] riscv: virt: Use Goldfish RTC device
Thread-Topic: [PATCH v5 2/2] riscv: virt: Use Goldfish RTC device
Thread-Index: AQHViuyjrZiK5XOhH06iDXRvjySOvA==
Date: Fri, 25 Oct 2019 04:28:23 +0000
Message-ID: <20191025042734.69244-3-anup.patel@wdc.com>
References: <20191025042734.69244-1-anup.patel@wdc.com>
In-Reply-To: <20191025042734.69244-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::20) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.51.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce555e46-e0ed-4114-2ce1-08d75903c5f8
x-ms-traffictypediagnostic: MN2PR04MB6048:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB60481AA17A665EF6319288458D650@MN2PR04MB6048.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:131;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(189003)(199004)(14454004)(50226002)(476003)(8936002)(486006)(66556008)(81156014)(6512007)(76176011)(6436002)(6486002)(81166006)(4326008)(66476007)(66446008)(64756008)(7736002)(52116002)(2171002)(66066001)(99286004)(66946007)(305945005)(386003)(102836004)(6506007)(478600001)(256004)(25786009)(55236004)(186003)(36756003)(86362001)(54906003)(71200400001)(8676002)(2616005)(3846002)(6116002)(446003)(11346002)(5660300002)(110136005)(2906002)(26005)(1076003)(44832011)(71190400001)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6048;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z4WP8MybwY2lGRPthbvp+XGhzxTqYaithBfHcSakTWFpfnN+Myil6aDuSZ5W1OMLkzLGOwKxHzjeT6IMnG6/MTqS6bbBYMYHQjcY9XnkQlGfnNcPQViiScCEykIeCK+Ndo7FZuhYZhuzTtfOeEpuetSbatdjbz4MjoLAKGrGUwstWnR0BAfEx2XQrVhKibXQfl7K7W7mkmL91j8V2GnK06vn3arvYHfz8fPDzKRBeNYJvLty4Ow7C7/03L9sUvjJkSV4PTVCFYmTr7k7CO8i/NdeaIlA8khrx0rBoiXevkPNLCKBcfLI+EnS+THIIkuin+G2BOI1sByq2xz0DiimPQ7WIR76SzalUWHk300C/QmHSIsb9sZgAYXPa2rMofPMWB8fKMjk6o95ZQi9PMfan30viHXiDd0+IhVIaNVpKFgBmZvAIYp35spjAR70NwP7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce555e46-e0ed-4114-2ce1-08d75903c5f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 04:28:23.9293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SfW3NbAeHrxUIKPc6ONbsxFs4nue7FDR5eCmBOGKLoX7woNsQ7ebdi0LGN4SUmTp2xTu5VpZjyMCVwbLKmdagw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6048
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


