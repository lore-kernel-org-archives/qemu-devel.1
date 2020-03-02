Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F92FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2947A22B48
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="eFrPsTBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2947A22B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8sWs-0002Or-Dq
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 16:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1j8sWE-0001xV-Mo
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1j8sWD-0004QM-G9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:22:30 -0500
Received: from mail-bn7nam10on2119.outbound.protection.outlook.com
 ([40.107.92.119]:45504 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1j8sWD-0004Pr-Ch
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:22:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dj7evCtox9wmBzZS1JL1Mb2DHbOlrs4Do0Muuv+HMjkOEAMVgT0Hkdyokk+/a/iPWpXuhhj3O6nj8XR8p7cF72S34S81dqcuz1bF+yYVeYu0UGrmqiHyJqDqIWK/KzbgtpvAGIY0wQPIDeQ4uhRQAhivcelkeQcPrqcNK+F2dYh6t8C8+dznrfcZFy8Xn1lJG0gK43zrBawY1SXBuIKTiUfRvD0BlzhwOtl/tX0hfRb+lG5+BTMRmQWfnBAaxq5rOFpn2/FRJq38Pfdqo8qPSEPZBIUme7VTcjk1dViDPnWgf8xEGvHdWoJrNaLoDrjxj3pXJYdO3Ko7MDW8qUsjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWsZDriIMZaGbMvECUPfk46hrDVeBr4pkjYcEMcowSg=;
 b=ILA6/59Q1Ekky2bTiMVIThmi7aI+h6cRy3Kk09cyWifZ+KrMjdnmuG0RtnlcRe+0WuqW9EbKQapIuYyuTCUfjEGiBrrvyS6yFhoP1jLjfKln4D2LnAvESJQIagiJo43/pp/BUDNixdHTLOo8NYoF4aitA29gv1InV3+cHCePSSZ6tXnDHb0GfRPHcj0zADHN1TgbiZ8zaynsfbV3y83gaS2+6TA/mH6zAV9JurP1o+AgNtdx8CgnSUMi3zktYskSEUKWmEX4eKRcLzaOXgapbVLxurmS0u8Tk1e1D5xz2BSCG9e1pz+yHTTTS+OwbMn8K+4BE5nWIV8f4JVQ5VSa2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWsZDriIMZaGbMvECUPfk46hrDVeBr4pkjYcEMcowSg=;
 b=eFrPsTBzoE0SbCVLZw3nR5bESFX/QkHHNjQO+O22jLAhpJMKfKyk82ALizKlGas3/I0fME2gbOjmDGhiGawT6ytdxgbVTJL4ELlkjGPkwGoHwsV/gWOHjNlcOJ3thZB8Soa+CsYVqocRDmPD68UA11kMi6QRcMo1ME41LTUWPe8=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 (2603:10b6:405:23::11) by BN6PR2201MB1091.namprd22.prod.outlook.com
 (2603:10b6:405:35::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Mon, 2 Mar
 2020 21:22:27 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c804:a036:269:9290]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c804:a036:269:9290%4]) with mapi id 15.20.2750.027; Mon, 2 Mar 2020
 21:22:27 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [EXTERNAL][PATCH] mips/mips_malta: Allow more than 2G RAM
Thread-Topic: [EXTERNAL][PATCH] mips/mips_malta: Allow more than 2G RAM
Thread-Index: AQHV7eblU+nIe1YkdEW+Vw9fA7ByIKg11URu
Date: Mon, 2 Mar 2020 21:22:27 +0000
Message-ID: <BN6PR2201MB12518300604D482EAE3CA145C6E70@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20200228032613.1049955-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20200228032613.1049955-1-jiaxun.yang@flygoat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44635006-e0e9-4366-b816-08d7beefcee9
x-ms-traffictypediagnostic: BN6PR2201MB1091:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR2201MB1091A0159E7614A69C5ADDDEC6E70@BN6PR2201MB1091.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(136003)(346002)(366004)(39840400004)(199004)(189003)(66946007)(66476007)(55016002)(76116006)(9686003)(66556008)(2906002)(316002)(64756008)(66446008)(86362001)(91956017)(508600001)(53546011)(52536014)(6506007)(110136005)(71200400001)(81166006)(7696005)(55236004)(54906003)(4326008)(8676002)(8936002)(186003)(33656002)(81156014)(5660300002)(26005)(107886003)(208264002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1091;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cEMTkvpcek6FqKAnO0M3gWbmOqai8QP2wEtwE4BkZTt84z1iDtjEPd1n7R8Ytu3OWhKUzSweByhEJMiNoG9jtg6zSg4la3eY/9PQujt6Ns2Jld8PcuPN3r2MzXtFY/G6LQPlnSiDZbJRERPx0tQfFZYpmCracxBozF++YqJz4w3Yc4ne473IJsCgFqCQ9vH7DQ6qpkktPUimBvb+2oTDezS0cNC+qygKkOw2+0zFLqAZkEM8tFz5SVsPzWt5BAXFkR+Jo3zdvxCM60noWBrrMRUW/hClOXw+VnAa8Z+cUIQAnYVdiQr8dWHkuqV6zxiy+8Y4VniFTiT57qVKoQRWiI66llzORlvEHirc5ytPGOXLuG1DDwB+9s2FQhAWnuiI5BYtoHJhE/nHOWmrgmrMkKFsr2N/2ey5+3uBDPlcLfq75cu+9fWJy7UNvLKHe8dqjni83vs3vNnEE71A1Do5QNSKaVcVekWvBeTNbSeB0YW5iU3uYpTR4P7F+sSLWdL+
x-ms-exchange-antispam-messagedata: i8h6iwfy2CXY7YMCB+9bBb0QVZToUljP8nD2ae9Mx+oER66pqpAUSdltmQYVi2Is7OzFP1KkWTJ3iPxgYht6kLVnBNFD0GkXnJ/Zw10wR5cm81h9YUO6K5otPC6Xl1+Z/rCPsU1qyi6805wEY+gUdQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44635006-e0e9-4366-b816-08d7beefcee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 21:22:27.2579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mih1SvaiUIctVNJ3VVEydb3lhwl9YY+0TsUYiiOEkqN1R50FiZGUtsKE1HCJPpruwzStPSwwMmT2MM7GKqUMwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1091
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.119
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
Cc: Yunqiang Su <ysu@wavecomp.com>, "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Forwarding this to Igor. Can you please give us your opinion, Igor, on this=
 proposal?=0A=
=0A=
________________________________________=0A=
From: Jiaxun Yang <jiaxun.yang@flygoat.com>=0A=
Sent: Friday, February 28, 2020 4:26 AM=0A=
To: qemu-devel@nongnu.org=0A=
Cc: philmd@redhat.com; Aleksandar Markovic; Jiaxun Yang; Yunqiang Su=0A=
Subject: [EXTERNAL][PATCH] mips/mips_malta: Allow more than 2G RAM=0A=
=0A=
When malta is coupled with MIPS64 cpu which have 64bit=0A=
address space, it is possible to have more than 2G RAM.=0A=
=0A=
So we removed ram_size check and overwrite memory=0A=
layout for these targets.=0A=
=0A=
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>=0A=
Suggested-by: Yunqiang Su <ysu@wavecomp.com>=0A=
---=0A=
 hw/mips/mips_malta.c | 24 ++++++++++++++++++------=0A=
 1 file changed, 18 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c=0A=
index 6e7ba9235d..de89cdcfc1 100644=0A=
--- a/hw/mips/mips_malta.c=0A=
+++ b/hw/mips/mips_malta.c=0A=
@@ -98,7 +98,8 @@ typedef struct {=0A=
 } MaltaState;=0A=
=0A=
 static struct _loaderparams {=0A=
-    int ram_size, ram_low_size;=0A=
+    unsigned int ram_low_size;=0A=
+    ram_addr_t ram_size;=0A=
     const char *kernel_filename;=0A=
     const char *kernel_cmdline;=0A=
     const char *initrd_filename;=0A=
@@ -1023,6 +1024,7 @@ static int64_t load_kernel(void)=0A=
 {=0A=
     int64_t kernel_entry, kernel_high, initrd_size;=0A=
     long kernel_size;=0A=
+    char mem_cmdline[128];=0A=
     ram_addr_t initrd_offset;=0A=
     int big_endian;=0A=
     uint32_t *prom_buf;=0A=
@@ -1099,20 +1101,28 @@ static int64_t load_kernel(void)=0A=
     prom_buf =3D g_malloc(prom_size);=0A=
=0A=
     prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_filename);=
=0A=
+=0A=
+    /*=0A=
+     * Always use cmdline to overwrite mem layout=0A=
+     * as kernel may reject large emesize.=0A=
+     */=0A=
+    sprintf(&mem_cmdline[0],=0A=
+        "mem=3D0x10000000@0x00000000 mem=3D0x%" PRIx64 "@0x90000000",=0A=
+        loaderparams.ram_size - 0x10000000);=0A=
     if (initrd_size > 0) {=0A=
         prom_set(prom_buf, prom_index++,=0A=
-                 "rd_start=3D0x%" PRIx64 " rd_size=3D%" PRId64 " %s",=0A=
-                 xlate_to_kseg0(NULL, initrd_offset),=0A=
+                 "%s rd_start=3D0x%" PRIx64 " rd_size=3D%" PRId64 " %s",=
=0A=
+                 &mem_cmdline[0], xlate_to_kseg0(NULL, initrd_offset),=0A=
                  initrd_size, loaderparams.kernel_cmdline);=0A=
     } else {=0A=
-        prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_cmdline=
);=0A=
+        prom_set(prom_buf, prom_index++, "%s %s",&mem_cmdline[0] ,loaderpa=
rams.kernel_cmdline);=0A=
     }=0A=
=0A=
     prom_set(prom_buf, prom_index++, "memsize");=0A=
     prom_set(prom_buf, prom_index++, "%u", loaderparams.ram_low_size);=0A=
=0A=
     prom_set(prom_buf, prom_index++, "ememsize");=0A=
-    prom_set(prom_buf, prom_index++, "%u", loaderparams.ram_size);=0A=
+    prom_set(prom_buf, prom_index++, "%lu", loaderparams.ram_size);=0A=
=0A=
     prom_set(prom_buf, prom_index++, "modetty0");=0A=
     prom_set(prom_buf, prom_index++, "38400n8r");=0A=
@@ -1253,12 +1263,14 @@ void mips_malta_init(MachineState *machine)=0A=
     /* create CPU */=0A=
     mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);=0A=
=0A=
-    /* allocate RAM */=0A=
+#ifdef TARGET_MIPS32=0A=
+    /* MIPS32 won't accept more than 2GiB RAM due to limited address space=
 */=0A=
     if (ram_size > 2 * GiB) {=0A=
         error_report("Too much memory for this machine: %" PRId64 "MB,"=0A=
                      " maximum 2048MB", ram_size / MiB);=0A=
         exit(1);=0A=
     }=0A=
+#endif=0A=
=0A=
     /* register RAM at high address where it is undisturbed by IO */=0A=
     memory_region_add_subregion(system_memory, 0x80000000, machine->ram);=
=0A=
--=0A=
2.25.1=0A=
=0A=
=0A=

