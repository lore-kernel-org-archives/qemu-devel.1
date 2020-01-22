Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41B5C33CB6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FD22071E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hq63O5Bk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LoEKqneF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FD22071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuFtx-0004Js-IY
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 08:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=283669e78=Anup.Patel@wdc.com>)
 id 1iuFt9-0003eO-Ec
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=283669e78=Anup.Patel@wdc.com>)
 id 1iuFt8-0006x6-6Y
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:17:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:9745)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=283669e78=Anup.Patel@wdc.com>)
 id 1iuFt2-0006tC-3y; Wed, 22 Jan 2020 08:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1579699056; x=1611235056;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=6tuPoaypj07XJjlk89cQM6z7K5QJRTuutpmvv5LiUFU=;
 b=hq63O5BkSKS7SorakSpXYZnw2a88XS3sSIQ4q0ZmeybTspH0XZtUyUI3
 L+EoBmTe/RAtSdw9LK6CFcVSSxUqJy64OkVbu2zQ2/G2l7fbMgmrSB5FW
 E+DH2V84UYRMpNE7h5cJSxXx0i6eFOtOnefXvidQJr2xSAIKfZOKBlZ2q
 gK8D4sc0fMbs5qPC0G1M6nC2uAV/5VuYe/Qfna3zCvUDRdiP6SmmFo58y
 yUNKGvQWhIDJKGnONaYHLnDQanuqG62IoBwNzQQjh5pDtGA8Xk0Il5nSs
 v0SI2VSN70b7RdbIZ9F8Oa/eCb+/rIgP7stZsMGLvVIQ9NWW9w7ADkaqL w==;
IronPort-SDR: 80xa65dqTBcIAHFg+8lJ779gnpMi0ZdPaEzIvc8pFTIazhVxQtfzwwJLw4p/+BSMV+vHR69ydg
 XZqyg4knItzF7GffAY15PEk8OpswjbjsJ3g/62rNDzxRv6140q5PjAIt4M4xapP8ZF//VAfhDt
 ek3FZWHuZgnRWe/MB3QWjOTnWMRLiNg7NqZ+yTwdu15X2z341WOsejBSVrvxNaLflRSLfvWyUO
 c2coBo5LlpVzDSXzfYlcdinVcD0IKitJjgRFs8V2AKSHV8yRGRg5xUbqQ5z3oq14A5txMY/Rs4
 PaU=
X-IronPort-AV: E=Sophos;i="5.70,350,1574092800"; d="scan'208";a="132534402"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2020 21:17:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9FOiUPt2oNZxj2rGLx4mli3FROP4ZG8R8NdnxE9X4tJeypHALrEAktnQ83UpmAA1vp/kkanutRpxSQ2sT1PLoD6hvdTfeBKQzOr48epxEYNvzYkDsMb6HMF8ZBkOLvDvV1Mne+wtrPSHAFzC/7x1YFWO+U7cufYiILePalAK4OLScksv1y+G9DAH6iVJUupKzasHhXmC+TtC+o93a08/wnzTgGkf5XXYUG09vz9tH9XzR6phXsG1bmt2nZmGSecIJ4YJWdAuINNYztUZNmfrNGmjp1WybjFpqkSmQdzsqU+KiCP/UH4Xo++W+JZkg9i+X8witZTUSEeHz1/k5fcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkjGzq06zsyd5O0eBKMfSbSDcCp+YK1l4KUWZXMHfo4=;
 b=B6cAXc5FISwVavwIickEkrQywUtMgi92FzrFcPBHR0zxCiiAJLwsGBW4YWB3SqQHEjjqy5sEYvEUUkV+0bYZA2LB/s3gaIOeTYegMkHJ1Dvw9Oc2voLYnpHpvXmnlJ9Dh9Eo6LMMUV36NIJjGibpS1NQzhDAL//c18c5V53jrglNEGr6uBuvkxRFkAqpNV13pik6DUlD4nAlpqVIoEkq1c77nsGGP7OT2Co9vDtAQTN8bJP1VKct9PeJjHf3tk2lfeRWWUh88a5/JcpJO8OmK8l/SYeyQmM9TuCuVOqXQTVidOsiTEqtxstyLFPqeutpKrbhm7mITK1MUSwyIHWMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkjGzq06zsyd5O0eBKMfSbSDcCp+YK1l4KUWZXMHfo4=;
 b=LoEKqneFQZGfDEBzDRNWzUoycwhFpxnT9hkAP8MFLkcrmLtMTI8MspC6jeslrpXitORSC6ujDIjRVcPcemkvTQbpGY078cy6wdWOfYMAOW0SQ3ATqC9KZBSU6PmChknopmSP1iFkSlZ+vQAhcxA1U1EvwHg/k34cXbPszLcDZz0=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6800.namprd04.prod.outlook.com (10.186.145.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.25; Wed, 22 Jan 2020 13:17:23 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89%7]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 13:17:23 +0000
Received: from wdc.com (106.51.28.174) by
 MAXPR0101CA0040.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Wed, 22 Jan 2020 13:17:19 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v2] riscv/virt: Add syscon reboot and poweroff DT nodes
Thread-Topic: [PATCH v2] riscv/virt: Add syscon reboot and poweroff DT nodes
Thread-Index: AQHV0SZIt4qZDvt9QUaSbSZUw8ntvQ==
Date: Wed, 22 Jan 2020 13:17:23 +0000
Message-ID: <20200122131641.34953-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::26) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.28.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36d43101-27fe-452d-daaa-08d79f3d6b15
x-ms-traffictypediagnostic: MN2PR04MB6800:|MN2PR04MB6800:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6800E66479B51127636EC4F38D0C0@MN2PR04MB6800.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:40;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(189003)(199004)(316002)(44832011)(8886007)(5660300002)(54906003)(71200400001)(6666004)(110136005)(8936002)(1006002)(86362001)(81166006)(81156014)(8676002)(1076003)(16526019)(66476007)(55236004)(478600001)(66446008)(66946007)(64756008)(4326008)(26005)(66556008)(36756003)(956004)(7696005)(2616005)(52116002)(55016002)(2906002)(186003)(20680400001)(32040200004);
 DIR:OUT; SFP:1501; SCL:5; SRVR:MN2PR04MB6800;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; CAT:OSPM; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wgq6cvn19k780qPm5ncUjiuShpEyvwlYg/V072O74RMmyiMs+QM48ZJZ93mjP9N/F+EUPY46kB6Q77zhk1fO7lXnNSGrwodHxUWM5H30jCde8TGolmNCtTWiyaLs7DfVRXFXuQ+SfvKFJlRSJX3HDmIqSK8MudF1WiSFeJogZLHOiRtDyEe+671mP4hHGfzVTNvXT7cjZrUUUl/wrSiMnhHbFjohBceDLD3KCotz0r1dkKtOo8/7q1vh70G6hgQ1sA7dADEvMbM07ELJ7fNsG2LHhMRhE3GhZNySJh7Ehf4N6K296aWfN/iVlm0tJOqvorcuBsQIAeGZ6lhC0eyOWBr3O/vpLlqzqPmaRP97ZW5pvHPV0OvT6rSzDRymdwMz4JjLiwx3OXbc2B+B3fJlXrek1RaVRHumRTqpJxyzlQYmPTGOuHdc7+q0r/TTidKWDUFgCsXQ69X0VhICv4Eh2LP05ITYQiIiZ4rUNKLavq6CTILJaFWiUs0+KJA2sb5MdLKS/MeCnrvBpXFumSi4VtwgsopJxCgsQ3PT5x5s/6rzUSFnwOLGC6SHFJmAmSxFfOJS97Z+j884qpeK43/5PBccIFMVI/B+dJDG0svsq290ZFVYUEfF/4IOwKpKCDdJsTnuv1SFkMUPEodGuOcGIw/ZVF+/3QP7f+NhzPsga9pgooXUCR7MV0B9RPlgFnBnhOoBDi1RhE5yDnNO5KjWvLxBSvrPMD031bnS/JRbW3j8ee79WzoJblg/WXcN5HMyFbu+qKmbInsDwTt/ShkGSLWk1t05G7z65SOpOFEYyfxey7F3cJUYoRaw+wd5kio5
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d43101-27fe-452d-daaa-08d79f3d6b15
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 13:17:23.7638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVtgy1sVuG4Y+JTzFLbJ6wXshxqa6Z7REj4z9QooLLV5wFmVDZgKyTnrwUMwC1MmlHs6L/2KzH9Uf27Ge4qiyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6800
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
Changes since v1:
 - Rebased on latest QEMU master commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde=
0dd40
---
 hw/riscv/virt.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c44b865959..6d682f8a78 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -182,11 +182,10 @@ static void create_fdt(RISCVVirtState *s, const struc=
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
+    uint32_t plic_phandle, test_phandle, phandle =3D 1;
     hwaddr flashsize =3D virt_memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase =3D virt_memmap[VIRT_FLASH].base;
=20
@@ -356,16 +355,35 @@ static void create_fdt(RISCVVirtState *s, const struc=
t MemmapEntry *memmap,
     create_pcie_irq_map(fdt, nodename, plic_phandle);
     g_free(nodename);
=20
+    test_phandle =3D phandle++;
     nodename =3D g_strdup_printf("/test@%lx",
         (long)memmap[VIRT_TEST].base);
     qemu_fdt_add_subnode(fdt, nodename);
     {
-        const char compat[] =3D "sifive,test1\0sifive,test0";
+        const char compat[] =3D "sifive,test1\0sifive,test0\0syscon";
         qemu_fdt_setprop(fdt, nodename, "compatible", compat, sizeof(compa=
t));
     }
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


