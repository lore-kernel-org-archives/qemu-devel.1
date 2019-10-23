Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5508ACA9EAE
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 06:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB0C214B2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 06:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ccffVTJk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KJSZZRBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB0C214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNAHt-0003f0-Um
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 02:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=192d452e1=Anup.Patel@wdc.com>)
 id 1iNAGW-0002LM-8a
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 02:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=192d452e1=Anup.Patel@wdc.com>)
 id 1iNAGV-0004tk-0k
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 02:37:04 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:46346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=192d452e1=Anup.Patel@wdc.com>)
 id 1iNAGS-0004p8-GV; Wed, 23 Oct 2019 02:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571812620; x=1603348620;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x2LYqHXcC7dq/y3KGLF8LgBgk5NG//4566p8xmnogNQ=;
 b=ccffVTJk+xy/81/FbLg5bFEUD2sgTxzz0gEdgwAR9Tqh3boE3bdKJ0JS
 JZ0evKoebzX9KGJy6qDlPUMLnvh8nOdedafLl1o83aVt+vNwA2YOKtcd0
 HzhxEOYsXP1MUM3gZ/Qa8gTBjkK4DYo+6Vm9kGvKiPU+23xuxiUVybPnP
 qE6fkoiv8ek8+9oIcqlPKTSIlB3ihxPdXWWhwohOaS7GOM5J9II8CwVSi
 8eQ+1nd5oWsUEhjAU0HzUQJ2uojqYJBLry9HO7PAu5MMkA3GPqx+DYodm
 0IgOHtAxFAIiZ9ze3wAbMpw1sNYHmrFLuCdttO41ja7tWu9LbdzuebbtO Q==;
IronPort-SDR: kiZNbv63263xkKz6vD97Y+UNse/lHH45NhfPYqCht6SkwVcYqh7bRO74wP48iQjCQP6GcnUphi
 M06C6TieUKRcv6+5g9E+fRvU2Qu8P2jhuU/DGOm2bBLHZiOXbCRLvBUzMLZqimjB6WqRvJ5rKd
 7F5llwXC87tp9sbyctDn+THfEoKM0eoYdm/q70LEZyULRsbbD4MSRg43KYq3A3dka7C1NyNp0J
 z7a5A9Q+AlYOMjam5DatVuDKW2BlDylJOMh5Gsnof1PlQ6u0/7CZf49y4T6s2ZZyEmW+B5GNj6
 ug4=
X-IronPort-AV: E=Sophos;i="5.68,219,1569254400"; d="scan'208";a="122707271"
Received: from mail-bl2nam02lp2053.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.53])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2019 14:36:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXfyN3XhIh8HPpAp612tCBtGBDSGhNNtigoI6EqzsSqh3qxdq1mXQl1nW7VJjRkpffBUIyo/2bR+FmvGYIugTazyFo6fD07pfhH8dZxntC9x1Ivp2B7DUDcSsMQ9UlpDdCCMFgjG6z6lYbTsVhA6aO/T0gXUsEXO1STdjb7jlxPlKbxhjkogebhNCGhe+/KwRTNK5IBUGUr1rQ2RaAWi1Mn2YRbuNtmAFPsD8Z35csmVKeynMqz2ItaSMMlpE5NrQM2mPz3Y+7q+ZKuVWJCatOD8fhYecXE4I4UF1bBd0RsNLEtl5rnnDd+wQq6ZtYI98UgRI0Ay6/KfWgso3NZm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0y3+h1psXEIRtGMAZtdqQKFI9+CUrcrouf9S7Z1+wE=;
 b=jaYPDnAm0jJ4zAJPP3NN02ErWfalW6w7XDGtfSZg5kvF2oCHKWuN+ZzhZ42yg+vSzEiITwku5ksxdvXxD/5xX1sKw3mFPWWGhwkrZMjJ5D/AgWsfndjjI3CzkmZjGO+gtIVkqwwoZkmxcyoXwx67pX+Rk7AjJmvEOR6w4yG7CgITSmbvy0XtS14v9nWTEp6eeHBHExeL407w7qCXYGRCTYNRGl7Q+JTCJzWl4xsd99nwKtb6skcMp3zPsXJYOwqBehRFnVPYcl7LtAwFcUUXm1iHWrO7vcqqwt1iGMmk8pFA2JlhB4zEfpIlDij4HTcHUmiHkRp+IsS3jCaEJlLyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0y3+h1psXEIRtGMAZtdqQKFI9+CUrcrouf9S7Z1+wE=;
 b=KJSZZRBH1fNgubgFnnKEP+nZaRm5Bs6km/715AhVRPQmPoiyK5BjLGMsLSIBBfzcKGRaZQVgNcot+gq2BLuxdGBjpLeLz7ULGxwTItrh+bAY134FmKgK6ajJxS1Q/YQVHyhUmEgDO0Rbwi/9HBvTKGilOGFaGiwsv+DQ+8ah3MI=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5871.namprd04.prod.outlook.com (20.179.22.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 23 Oct 2019 06:36:58 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a%7]) with mapi id 15.20.2387.019; Wed, 23 Oct 2019
 06:36:58 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v4 2/2] riscv: virt: Use Goldfish RTC device
Thread-Topic: [PATCH v4 2/2] riscv: virt: Use Goldfish RTC device
Thread-Index: AQHViWxFkpinkDEOekyW3aOOBNwebQ==
Date: Wed, 23 Oct 2019 06:36:58 +0000
Message-ID: <20191023063620.35104-3-anup.patel@wdc.com>
References: <20191023063620.35104-1-anup.patel@wdc.com>
In-Reply-To: <20191023063620.35104-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::24) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63ec5f37-8d93-4cbf-deed-08d757836783
x-ms-traffictypediagnostic: MN2PR04MB5871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB58718FAB58963DB2F479F9DF8D6B0@MN2PR04MB5871.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:131;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(8676002)(2906002)(26005)(486006)(50226002)(2171002)(86362001)(6486002)(476003)(25786009)(3846002)(44832011)(446003)(11346002)(36756003)(6116002)(6506007)(386003)(7736002)(186003)(305945005)(2616005)(102836004)(4326008)(14454004)(99286004)(6436002)(52116002)(76176011)(478600001)(81156014)(66066001)(6512007)(81166006)(54906003)(71190400001)(316002)(8936002)(66946007)(1076003)(66556008)(110136005)(64756008)(66476007)(256004)(71200400001)(5660300002)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB5871;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vV+3HbxOUx5XMcgrurrXCOyow6eRE5pVek7LCtpwZ40RO2o/2l7Y8KNZpidr9HpjFChZ7jgWZJEh2fHCOHDAIk2vLS5MVjMGqDyG3SwcQ40PA+0CsIF7/93dun2TS5ZSzLKPJYZ5oK8tzamg+p8e+RcDmuc0GXi9u7abgsXGb4PFuGDN89B65F1DQJHgKnaD1Rnqg1yNF0inw1XIO9g/JvF9DuVEO9c/DHRHCg0VUiwVyKRRi7uNPlXsSAyyOzpTdKdguSfXnIE03iZFKLCDz216sPkRJjbdnXyvX3DHAciESrG6SpfbhxKLkt2jFBFteJgYVYFhnBmRtgGqGIuKRRmIFdfoosvUP2Uco23f7pVzkg5wmdOubrMjAvI/kMYMs1GWr111iqfIppJJ0RLeTS3xVGGtjKXeP7zMRlqjvo66OxwNDXz8xDQOqAzgQEm
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ec5f37-8d93-4cbf-deed-08d757836783
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 06:36:58.7351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9OCFL6GWXrEpRQs58I7xDwpTSSXOdlHvZ4DoGz9IS+rgv/b72AQTRUY5nNOcyhxq2cf+Pg4buK2aCa+z+HEVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5871
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


