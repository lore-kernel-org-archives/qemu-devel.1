Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8092C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFE020727
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NeuroBlade.onmicrosoft.com header.i=@NeuroBlade.onmicrosoft.com header.b="GesyTkFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFE020727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuroblade.ai
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9OX-00028x-7L
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shaked.m@neuroblade.ai>)
 id 1kY4JL-0005vc-RV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:33:35 -0400
Received: from mail-eopbgr50134.outbound.protection.outlook.com
 ([40.107.5.134]:16366 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shaked.m@neuroblade.ai>)
 id 1kY4JI-0006P8-Px
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:33:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUD9InVekKd9KguTg61pOYXn2Hg6HpCN3yP2W8vT2c0zuXdP4BZnA0+jQKYnq9xV2RnaSGaPPrZq5Frok+DzcgBEUcmrM1sJMAT70gGc+hqduki5u3lvCS9PAvTOJD2fuuZ96KgRi9W9VhVE+WsuvRcfQHBYFiNIEg5t+0SZ4zDbg70TPVItajDOQmj8GW3moR2gMAqyIou8569e6YzF7vPqsMRZ/YaIuG3jgANkZvmr4ATMwCxhepRxxQtjvAY+9L/v3CqMpsWNu69AMXIcDQtA6tqqp83zLDmFbGWWPF1jMmq7LM/RJWG7PsWWTSd5BlvhwlXDHdLU/OAXcDZkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlGk3x+pRaphARQ9tQcAXGBWMGStYPXq3sH00+kGeyA=;
 b=dKVOiMgq8qKNd6vwua6g4JQSV6SShTfw9OWTJFVbzHY6baPYuvf9UPQQxUg2UaRj7jmqPo0fDJPFJmPHGoaxfxxZwAp5rSaRjQjeW9T7BXBfSsZTMbzALeNOQh+sz9RrDht33N27vhzBZHJkgkyNr4tOcIg1YtJjRVaei0c1g81QXApQ8xpLT4GipTltqgvWCCeP4jOLqFzF2vhNX4XEZ1KNfuwXZ7X7bdCEQQpC7sCW8FKNSRfa7/Jv5hWsXBFvXauxcRQq3FlEPtrYd75htGyyySCiX9FyawBVM55/GL5UHCIQPlTLc9RkR5Ye4nUyxcRUKh7LVYVxWNSnBRloNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=neuroblade.ai; dmarc=pass action=none
 header.from=neuroblade.ai; dkim=pass header.d=neuroblade.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NeuroBlade.onmicrosoft.com; s=selector2-NeuroBlade-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlGk3x+pRaphARQ9tQcAXGBWMGStYPXq3sH00+kGeyA=;
 b=GesyTkFXYFj4/480dRHkXtyn74WggFyCoY9TKLomHy5H2MCFPiKE5bdpMgTNvqUJGVAzDoJW2Lqx8G7VlS/sT7Ak9askABBvxA81J3SPPd8wlM6QfwzkSBZoFSe9Fhmg8b//3aCXvXdQCQd14zD7HJFn4r9rRiKu9DjBRbCSqTs=
Received: from AM9PR09MB4643.eurprd09.prod.outlook.com (2603:10a6:20b:286::17)
 by AM0PR09MB3651.eurprd09.prod.outlook.com (2603:10a6:208:181::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Thu, 29 Oct
 2020 09:18:25 +0000
Received: from AM9PR09MB4643.eurprd09.prod.outlook.com
 ([fe80::3c65:130c:3906:6542]) by AM9PR09MB4643.eurprd09.prod.outlook.com
 ([fe80::3c65:130c:3906:6542%7]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 09:18:25 +0000
From: Shaked Matzner <shaked.m@neuroblade.ai>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: simple example of pci driver with dma
Thread-Topic: simple example of pci driver with dma
Thread-Index: AdatzlSpgJldPz/zQsi+/NRP8xO5pw==
Date: Thu, 29 Oct 2020 09:18:25 +0000
Message-ID: <AM9PR09MB4643ECD51E00A54B871DED7682140@AM9PR09MB4643.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=neuroblade.ai;
x-originating-ip: [79.181.92.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 830cb5da-50b7-4aec-243a-08d87beb9729
x-ms-traffictypediagnostic: AM0PR09MB3651:
x-microsoft-antispam-prvs: <AM0PR09MB36515EE1872AC22AD061940782140@AM0PR09MB3651.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTJL+omkYQ8Ax+VoM2qHkOlJuTeVrVtnYQAf5b/Y1hWWzk3wheYcxAf6fCDfIcaJjCp9lr86WSKJeneXLgkOGViniReDps+tw2iS9XlPJPGSOEKz9Ql/MYgymFIgRn44Nbh6+28ZvruzgT+iv53Bzv/kMjB28FH4MDnhJwO4/IonY5lfDSWW2sWY5Cy4UZT9JENfsiawypRjU19rndqyygWxXz9p2Ob13o0y5VHhgkVEIGr1zdqp4oSrNeizEfZ4PFox3lRzqGjihcrtCIVpxlWy2FmS1bnLJiCdZTQJPyJ75ZnIBZu8jRiziiNfkxugUAMAobSjRWOye/LRjOGdfyWAkMYLA9WBWjm5fYulYKpxFlM/j1O7J1mhqBYVOmf5oX/0Ivwd3hxM577LiPpo3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR09MB4643.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(396003)(376002)(346002)(136003)(39830400003)(26005)(478600001)(186003)(2906002)(966005)(6916009)(83380400001)(166002)(9686003)(6506007)(7696005)(316002)(8936002)(5660300002)(33656002)(86362001)(71200400001)(55016002)(8676002)(76116006)(66946007)(52536014)(66556008)(64756008)(66446008)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: fvLWw+yKy48XpObAraE3JVWhwAGdRe0i+jUD996aBsrBOXQGtKZOQGDCbnOWg+uG8vlYoJ/NJvQBYgxEyNu2vvjryrfCLU2YTsYt/0onqUZ42oyRmClDIjVJ8kRdFNzFrzBgdAD4ffhVWoSvBSpkwgC0V1GQ5BOr/hGugxy14ETh8U/lfIYiIEgSVg8f+g8tj3xk0/ExTerM1KRzSI2oLoHeO+vI1VkdaVXSO97tlN0ve+op6luikZC8yWGICuwq+qkAUdYAx/EuVz3dFOCjX663XzQX9usTKsqpLrCcw19m3tcTdSYsvRpRelPAQyeYIFWfbBn4JW1DUC4CLnK4yuh9liPeUdpBuQ5bdrrPHn1fhi1psPrHLO1N0/efcEZpmccUO12B56bTD6+9U9wHFWe47QhugnOxhZCGpxxgL6tF4LA7kZu0m+L/hqnJbQpw/lXS+S4dPSrT7c9TikehMM0Yl5iNJpkDC493feJcVQqiM66i0pyC0uNoHeBku+p3P4WmCUQcm3G1ColeTUNOTGPN+pVxLFtAxifLAld6uCOhCiPgjZkoU6mI+pkQsTgvI1o8XjJgXqa99ce0mCtDUsibXoOygwFBTfObD9+KWSmudj1tRyXLFzuvPbxRszXvWNKfXcH3cj/uW6VL6O2BpQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM9PR09MB4643ECD51E00A54B871DED7682140AM9PR09MB4643eurp_"
MIME-Version: 1.0
X-OriginatorOrg: neuroblade.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4643.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830cb5da-50b7-4aec-243a-08d87beb9729
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 09:18:25.6103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63c61203-65af-4cf8-98e5-d12f35edaefa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTo3Oij3f5o+5cfcpv3UMqAMc/MTFOq5RU08XLSaRJ/N2SlUcf7WHKGF1D6QycVUqDnrSXuhEt69mgL0mgJN5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3651
Received-SPF: pass client-ip=40.107.5.134; envelope-from=shaked.m@neuroblade.ai;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 05:33:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Oct 2020 10:57:05 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM9PR09MB4643ECD51E00A54B871DED7682140AM9PR09MB4643eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey All,

So I'm trying to learn how pci devices and drivers work using the edu devic=
e and an educational driver, and It seems like the pci_dma_write function f=
ails to actually write the information from the the dma buffer into the all=
ocated address in the ram. Here is How I testsed it: 1.I've initialized the=
 first byte of the dma buff to be 0x12 in the realize function of the edu:

 edu->dma_buf[0] =3D 0x12;

In the driver I've defined a struct save both the major and the destination=
 address allocated through the dma cohherent:

 struct test {

      int major;

      void *vaddr_to;

    };

allocated it on the probe function and commanded the device to read 4 bytes=
:

 dev_info(&(dev->dev),"Hello from Shaked\n");

 dma_addr_t dma_handle_from, dma_handle_to;

 void *vaddr_from, *vaddr_to;

 enum { SIZE =3D 4 };



 /* device -> RAM. */

   vaddr_to =3D dma_alloc_coherent(&(dev->dev), 4, &dma_handle_to, GFP_ATOM=
IC);

   *((volatile int*)vaddr_to) =3D 0xff;

    test->vaddr_to =3D vaddr_to;

    dev_info(&(dev->dev), "vaddr_to =3D %px\n", vaddr_to);

    dev_info(&(dev->dev), "dma_handle_to =3D %llx\n", (unsigned long long)d=
ma_handle_to);

    /*write source, dest, number of bytes to transfer and activate the dma =
timer)/*

    iowrite32(DMA_BASE, mmio + IO_DMA_SRC);

    iowrite32((u32)dma_handle_to, mmio + IO_DMA_DST);

    iowrite32(SIZE, mmio + IO_DMA_CNT);

    iowrite32(DMA_CMD | DMA_FROM_DEV | DMA_IRQ, mmio + IO_DMA_CMD);

I've changed a little bit the interrtupt and added a print to check the val=
ue I just read:

static irqreturn_t irq_handler(int irq, void *dev)

{

    int devi;

    irqreturn_t ret;

    u32 irq_status;

    struct test* test;



    test =3D  (struct test *)dev;

    if (test->major =3D=3D major) {

        irq_status =3D ioread32(mmio + IO_IRQ_STATUS);

        pr_info("irq_handler irq =3D %d dev =3D %d irq_status =3D %llx\n",

                irq, devi, (unsigned long long)irq_status);

        /* Must do this ACK, or else the interrupts just keeps firing. */

        iowrite32(irq_status, mmio + IO_IRQ_ACK);

        pr_info("*vaddr_to new_value =3D %u\n", (*((u8*)test->vaddr_to)));



        ret =3D IRQ_HANDLED;

    } else {

        ret =3D IRQ_NONE;

    }

    return ret;

}

however the value I get is still 255(0xff) and not 18(0x12) probably I've m=
issed something but when the interrupt is called the transfer to the RAM ad=
dress should be completed, however it seems like the dma_write_buffer funct=
ion from the device does not perform any transfer. What Am I missing?

when I debugged the dma_coherent_alloc I saw it uses direct acccess(without=
 iommu), however when the dma_pci_write is called it tries to access the me=
mory via iommu and get's an error code(MEMTX_DECODE_ERROR) from memory.c 's=
 memory_region_dispatch_write. Since memory_region_access_valid returns fal=
se on it's first condition(also under memory.c

I am now in a deadlock, since even this simple example  doesn't seem to wor=
k, any idea what happens, or any suggestions for an alternative simple devi=
ce with a simple driver which I can learn from will be great.

Technical details: edu_device: https://github.com/qemu/qemu/blob/master/hw/=
misc/edu.c original edu_driver: https://github.com/cirosantilli/linux-kerne=
l-module-cheat/blob/master/kernel_modules/qemu_edu.c I run this on an x86-6=
4 qemu machine with the following configuration:

$repo_loc/build/qemu-system-x86_64 \

    -no-kvm \

    -kernel $repo_loc/linux-5.8.5/arch/x86/boot/bzImage \

    -boot c -m 2049M \

    -hda $repo_loc/buildroot-2020.02.6/output/images/rootfs.ext4 \

    -append "root=3D/dev/sda rw console=3DttyS0,115200 acpi=3Doff nokaslr" =
\

    -serial stdio -display none \

    -virtfs local,path=3D$repo_loc/shared,mount_tag=3Dhost0,security_model=
=3Dpassthrough,id=3Dhost0 \

    -device edu

(where $repo_location is the path to my build dir)


Thanks,
           Shaked Matzner



The contents of this email message and any attachments are intended solely =
for the addressee(s) and may contain confidential and/or privileged informa=
tion and may be legally protected from disclosure. If you are not the inten=
ded recipient of this message or their agent, or if this message has been a=
ddressed to you in error, please immediately alert the sender by reply emai=
l and then delete this message and any attachments. If you are not the inte=
nded recipient, you are hereby notified that any use, dissemination, copyin=
g, or storage of this message or its attachments is strictly prohibited.

--_000_AM9PR09MB4643ECD51E00A54B871DED7682140AM9PR09MB4643eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:inherit;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
code
	{mso-style-priority:99;
	font-family:"Courier New";}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
span.hljs-number
	{mso-style-name:hljs-number;}
span.hljs-string
	{mso-style-name:hljs-string;}
span.hljs-class
	{mso-style-name:hljs-class;}
span.hljs-keyword
	{mso-style-name:hljs-keyword;}
span.hljs-title
	{mso-style-name:hljs-title;}
span.hljs-comment
	{mso-style-name:hljs-comment;}
span.hljs-function
	{mso-style-name:hljs-function;}
span.hljs-params
	{mso-style-name:hljs-params;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hey All,<o:p></o:p></p>
<p style=3D"margin-top:0in;background:white;vertical-align:baseline"><span =
style=3D"font-size:11.5pt;font-family:&quot;inherit&quot;,serif;color:#2427=
29">So I'm trying to learn how pci devices and drivers work using the edu d=
evice and an educational driver, and It seems
 like the pci_dma_write function fails to actually write the information fr=
om the the dma buffer into the allocated address in the ram. Here is How I =
testsed it: 1.I've initialized the first byte of the dma buff to be 0x12 in=
 the realize function of the edu:<o:p></o:p></span></p>
<pre style=3D"background:white;vertical-align:baseline;margin-bottom:calc(v=
ar(--s-prose-spacing) + 0.4em);font-style:inherit;font-variant:inherit;font=
-weight:inherit;font-stretch: inherit;box-sizing: inherit;max-height: 600px=
;background-color:var(--highlight-bg);border-radius: 5px;color:var(--highli=
ght-color);overflow-wrap: normal;overflow:auto"><code><span style=3D"font-f=
amily:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;=
padding:0in"> edu-&gt;dma_buf[</span></code><span class=3D"hljs-number"><sp=
an style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none=
 windowtext 1.0pt;padding:0in">0</span></span><code><span style=3D"font-fam=
ily:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">] =3D </span></code><span class=3D"hljs-number"><span style=3D"f=
ont-family:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1=
.0pt;padding:0in">0x12</span></span><code><span style=3D"font-family:&quot;=
inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;padding:0in"=
>;<o:p></o:p></span></code></pre>
<p style=3D"margin-top:0in;background:white;vertical-align:baseline;margin-=
bottom:var(--s-prose-spacing);font-style:inherit;font-variant:inherit;font-=
weight:inherit;font-stretch: inherit;line-height:inherit;box-sizing: inheri=
t">
<span style=3D"font-size:11.5pt;font-family:&quot;inherit&quot;,serif;color=
:#242729">In the driver I've defined a struct save both the major and the d=
estination address allocated through the dma cohherent:<o:p></o:p></span></=
p>
<pre style=3D"background:white;vertical-align:baseline;margin-bottom:calc(v=
ar(--s-prose-spacing) + 0.4em);font-style:inherit;font-variant:inherit;font=
-weight:inherit;font-stretch: inherit;box-sizing: inherit;max-height: 600px=
;background-color:var(--highlight-bg);border-radius: 5px;color:var(--highli=
ght-color);overflow-wrap: normal;overflow:auto"><code><span style=3D"font-f=
amily:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;=
padding:0in"> </span></code><span class=3D"hljs-keyword"><span style=3D"fon=
t-family:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0=
pt;padding:0in">struct</span></span><span class=3D"hljs-class"><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in"> </span></span><span class=3D"hljs-title"><span styl=
e=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none window=
text 1.0pt;padding:0in">test</span></span><span class=3D"hljs-class"><span =
style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none wi=
ndowtext 1.0pt;padding:0in"> {</span></span><code><span style=3D"font-famil=
y:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;padd=
ing:0in"><o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</span></code><span c=
lass=3D"hljs-keyword"><span style=3D"font-family:&quot;inherit&quot;,serif;=
color:#242729;border:none windowtext 1.0pt;padding:0in">int</span></span><c=
ode><span style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;bord=
er:none windowtext 1.0pt;padding:0in"> major;<o:p></o:p></span></code></pre=
>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</span></code><span c=
lass=3D"hljs-keyword"><span style=3D"font-family:&quot;inherit&quot;,serif;=
color:#242729;border:none windowtext 1.0pt;padding:0in">void</span></span><=
code><span style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;bor=
der:none windowtext 1.0pt;padding:0in"> *vaddr_to;<o:p></o:p></span></code>=
</pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></code></pre>
<p style=3D"margin-top:0in;background:white;vertical-align:baseline;margin-=
bottom:var(--s-prose-spacing);font-style:inherit;font-variant:inherit;font-=
weight:inherit;font-stretch: inherit;line-height:inherit;box-sizing: inheri=
t">
<span style=3D"font-size:11.5pt;font-family:&quot;inherit&quot;,serif;color=
:#242729">allocated it on the probe function and commanded the device to re=
ad 4 bytes:<o:p></o:p></span></p>
<pre style=3D"background:white;vertical-align:baseline;margin-bottom:calc(v=
ar(--s-prose-spacing) + 0.4em);font-style:inherit;font-variant:inherit;font=
-weight:inherit;font-stretch: inherit;box-sizing: inherit;max-height: 600px=
;background-color:var(--highlight-bg);border-radius: 5px;color:var(--highli=
ght-color);overflow-wrap: normal;overflow:auto"><code><span style=3D"font-f=
amily:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;=
padding:0in"> dev_info(&amp;(dev-&gt;dev),</span></code><span class=3D"hljs=
-string"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#242729=
;border:none windowtext 1.0pt;padding:0in">&quot;Hello from Shaked\n&quot;<=
/span></span><code><span style=3D"font-family:&quot;inherit&quot;,serif;col=
or:#242729;border:none windowtext 1.0pt;padding:0in">);<o:p></o:p></span></=
code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in"> </span></code><span class=3D"hljs-keyword"><span st=
yle=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none wind=
owtext 1.0pt;padding:0in">dma_addr_t</span></span><code><span style=3D"font=
-family:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0p=
t;padding:0in"> dma_handle_from, dma_handle_to;<o:p></o:p></span></code></p=
re>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in"> </span></code><span class=3D"hljs-keyword"><span st=
yle=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none wind=
owtext 1.0pt;padding:0in">void</span></span><code><span style=3D"font-famil=
y:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;padd=
ing:0in"> *vaddr_from, *vaddr_to;<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in"> </span></code><span class=3D"hljs-keyword"><span st=
yle=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none wind=
owtext 1.0pt;padding:0in">enum</span></span><code><span style=3D"font-famil=
y:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;padd=
ing:0in"> { SIZE =3D </span></code><span class=3D"hljs-number"><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">4</span></span><code><span style=3D"font-family:&quo=
t;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;padding:0i=
n"> };<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; <o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;</span></code><span class=3D"hljs-comment"><sp=
an style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none=
 windowtext 1.0pt;padding:0in">/* device -&gt; RAM. */</span></span><code><=
span style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:no=
ne windowtext 1.0pt;padding:0in"><o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp; vaddr_to =3D dma_alloc_coherent(&amp;(d=
ev-&gt;dev), </span></code><span class=3D"hljs-number"><span style=3D"font-=
family:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt=
;padding:0in">4</span></span><code><span style=3D"font-family:&quot;inherit=
&quot;,serif;color:#242729;border:none windowtext 1.0pt;padding:0in">, &amp=
;dma_handle_to, GFP_ATOMIC);<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp; *((</span></code><span class=3D"hljs-ke=
yword"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;b=
order:none windowtext 1.0pt;padding:0in">volatile</span></span><code><span =
style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none wi=
ndowtext 1.0pt;padding:0in"> </span></code><span class=3D"hljs-keyword"><sp=
an style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none=
 windowtext 1.0pt;padding:0in">int</span></span><code><span style=3D"font-f=
amily:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;=
padding:0in">*)vaddr_to) =3D </span></code><span class=3D"hljs-number"><spa=
n style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none =
windowtext 1.0pt;padding:0in">0xff</span></span><code><span style=3D"font-f=
amily:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;=
padding:0in">;<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; test-&gt;vaddr_to =3D vaddr_to;<o=
:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; dev_info(&amp;(dev-&gt;dev), </sp=
an></code><span class=3D"hljs-string"><span style=3D"font-family:&quot;inhe=
rit&quot;,serif;color:#242729;border:none windowtext 1.0pt;padding:0in">&qu=
ot;vaddr_to =3D %px\n&quot;</span></span><code><span style=3D"font-family:&=
quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;padding=
:0in">, vaddr_to);<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; dev_info(&amp;(dev-&gt;dev), </sp=
an></code><span class=3D"hljs-string"><span style=3D"font-family:&quot;inhe=
rit&quot;,serif;color:#242729;border:none windowtext 1.0pt;padding:0in">&qu=
ot;dma_handle_to =3D %llx\n&quot;</span></span><code><span style=3D"font-fa=
mily:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;p=
adding:0in">, (</span></code><span class=3D"hljs-keyword"><span style=3D"fo=
nt-family:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.=
0pt;padding:0in">unsigned</span></span><code><span style=3D"font-family:&qu=
ot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;padding:0=
in"> </span></code><span class=3D"hljs-keyword"><span style=3D"font-family:=
&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;paddin=
g:0in">long</span></span><code><span style=3D"font-family:&quot;inherit&quo=
t;,serif;color:#242729;border:none windowtext 1.0pt;padding:0in"> </span></=
code><span class=3D"hljs-keyword"><span style=3D"font-family:&quot;inherit&=
quot;,serif;color:#242729;border:none windowtext 1.0pt;padding:0in">long</s=
pan></span><code><span style=3D"font-family:&quot;inherit&quot;,serif;color=
:#242729;border:none windowtext 1.0pt;padding:0in">)dma_handle_to);<o:p></o=
:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp; &nbsp;</span></code><span class=3D"hljs=
-comment"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#24272=
9;border:none windowtext 1.0pt;padding:0in">/*write source, dest, number of=
 bytes to transfer and activate the dma timer)/*<o:p></o:p></span></span></=
pre>
<pre style=3D"background:white;vertical-align:baseline"><span class=3D"hljs=
-comment"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#24272=
9;border:none windowtext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; iowrite32(DM=
A_BASE, mmio + IO_DMA_SRC);<o:p></o:p></span></span></pre>
<pre style=3D"background:white;vertical-align:baseline"><span class=3D"hljs=
-comment"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#24272=
9;border:none windowtext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; iowrite32((u=
32)dma_handle_to, mmio + IO_DMA_DST);<o:p></o:p></span></span></pre>
<pre style=3D"background:white;vertical-align:baseline"><span class=3D"hljs=
-comment"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#24272=
9;border:none windowtext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; iowrite32(SI=
ZE, mmio + IO_DMA_CNT);<o:p></o:p></span></span></pre>
<pre style=3D"background:white;vertical-align:baseline"><span class=3D"hljs=
-comment"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#24272=
9;border:none windowtext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; iowrite32(DM=
A_CMD | DMA_FROM_DEV | DMA_IRQ, mmio + IO_DMA_CMD);<o:p></o:p></span></span=
></pre>
<p style=3D"margin-top:0in;background:white;vertical-align:baseline;margin-=
bottom:var(--s-prose-spacing);font-style:inherit;font-variant:inherit;font-=
weight:inherit;font-stretch: inherit;line-height:inherit;box-sizing: inheri=
t">
<span style=3D"font-size:11.5pt;font-family:&quot;inherit&quot;,serif;color=
:#242729">I've changed a little bit the interrtupt and added a print to che=
ck the value I just read:<o:p></o:p></span></p>
<pre style=3D"background:white;vertical-align:baseline;margin-bottom:calc(v=
ar(--s-prose-spacing) + 0.4em);font-style:inherit;font-variant:inherit;font=
-weight:inherit;font-stretch: inherit;box-sizing: inherit;max-height: 600px=
;background-color:var(--highlight-bg);border-radius: 5px;color:var(--highli=
ght-color);overflow-wrap: normal;overflow:auto"><span class=3D"hljs-keyword=
"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border=
:none windowtext 1.0pt;padding:0in">static</span></span><span class=3D"hljs=
-function"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#2427=
29;border:none windowtext 1.0pt;padding:0in"> </span></span><span class=3D"=
hljs-keyword"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#2=
42729;border:none windowtext 1.0pt;padding:0in">irqreturn_t</span></span><s=
pan class=3D"hljs-function"><span style=3D"font-family:&quot;inherit&quot;,=
serif;color:#242729;border:none windowtext 1.0pt;padding:0in"> </span></spa=
n><span class=3D"hljs-title"><span style=3D"font-family:&quot;inherit&quot;=
,serif;color:#242729;border:none windowtext 1.0pt;padding:0in">irq_handler<=
/span></span><span class=3D"hljs-params"><span style=3D"font-family:&quot;i=
nherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;padding:0in">=
(</span></span><span class=3D"hljs-keyword"><span style=3D"font-family:&quo=
t;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;padding:0i=
n">int</span></span><span class=3D"hljs-params"><span style=3D"font-family:=
&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;paddin=
g:0in"> irq, </span></span><span class=3D"hljs-keyword"><span style=3D"font=
-family:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0p=
t;padding:0in">void</span></span><span class=3D"hljs-params"><span style=3D=
"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowtext=
 1.0pt;padding:0in"> *dev)</span></span><span class=3D"hljs-function"><span=
 style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none w=
indowtext 1.0pt;padding:0in"><o:p></o:p></span></span></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">{<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp; &nbsp;</span></code><span class=3D"hljs=
-keyword"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#24272=
9;border:none windowtext 1.0pt;padding:0in">int</span></span><code><span st=
yle=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none wind=
owtext 1.0pt;padding:0in"> devi;<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp; &nbsp;</span></code><span class=3D"hljs=
-keyword"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#24272=
9;border:none windowtext 1.0pt;padding:0in">irqreturn_t</span></span><code>=
<span style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:n=
one windowtext 1.0pt;padding:0in"> ret;<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; u32 irq_status;<o:p></o:p></span>=
</code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp; &nbsp;</span></code><span class=3D"hljs=
-keyword"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#24272=
9;border:none windowtext 1.0pt;padding:0in">struct</span></span><span class=
=3D"hljs-class"><span style=3D"font-family:&quot;inherit&quot;,serif;color:=
#242729;border:none windowtext 1.0pt;padding:0in"> </span></span><span clas=
s=3D"hljs-title"><span style=3D"font-family:&quot;inherit&quot;,serif;color=
:#242729;border:none windowtext 1.0pt;padding:0in">test</span></span><span =
class=3D"hljs-class"><span style=3D"font-family:&quot;inherit&quot;,serif;c=
olor:#242729;border:none windowtext 1.0pt;padding:0in">* </span></span><spa=
n class=3D"hljs-title"><span style=3D"font-family:&quot;inherit&quot;,serif=
;color:#242729;border:none windowtext 1.0pt;padding:0in">test</span></span>=
<span class=3D"hljs-class"><span style=3D"font-family:&quot;inherit&quot;,s=
erif;color:#242729;border:none windowtext 1.0pt;padding:0in">;</span></span=
><code><span style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;b=
order:none windowtext 1.0pt;padding:0in"><o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in"><o:p>&nbsp;</o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; test =3D&nbsp; (struct test *)dev=
;<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp; &nbsp;</span></code><span class=3D"hljs=
-keyword"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#24272=
9;border:none windowtext 1.0pt;padding:0in">if</span></span><code><span sty=
le=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windo=
wtext 1.0pt;padding:0in"> (test-&gt;major =3D=3D major) {<o:p></o:p></span>=
</code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq_statu=
s =3D ioread32(mmio + IO_IRQ_STATUS);<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(<=
/span></code><span class=3D"hljs-string"><span style=3D"font-family:&quot;i=
nherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;padding:0in">=
&quot;irq_handler irq =3D %d dev =3D %d irq_status =3D %llx\n&quot;</span><=
/span><code><span style=3D"font-family:&quot;inherit&quot;,serif;color:#242=
729;border:none windowtext 1.0pt;padding:0in">,<o:p></o:p></span></code></p=
re>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq, devi, (</span></code><span clas=
s=3D"hljs-keyword"><span style=3D"font-family:&quot;inherit&quot;,serif;col=
or:#242729;border:none windowtext 1.0pt;padding:0in">unsigned</span></span>=
<code><span style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;bo=
rder:none windowtext 1.0pt;padding:0in"> </span></code><span class=3D"hljs-=
keyword"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#242729=
;border:none windowtext 1.0pt;padding:0in">long</span></span><code><span st=
yle=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none wind=
owtext 1.0pt;padding:0in"> </span></code><span class=3D"hljs-keyword"><span=
 style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none w=
indowtext 1.0pt;padding:0in">long</span></span><code><span style=3D"font-fa=
mily:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;p=
adding:0in">)irq_status);<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</span></=
code><span class=3D"hljs-comment"><span style=3D"font-family:&quot;inherit&=
quot;,serif;color:#242729;border:none windowtext 1.0pt;padding:0in">/* Must=
 do this ACK, or else the interrupts just keeps firing. */</span></span><co=
de><span style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;borde=
r:none windowtext 1.0pt;padding:0in"><o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iowrite32=
(irq_status, mmio + IO_IRQ_ACK);<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(<=
/span></code><span class=3D"hljs-string"><span style=3D"font-family:&quot;i=
nherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;padding:0in">=
&quot;*vaddr_to new_value =3D %u\n&quot;</span></span><code><span style=3D"=
font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowtext =
1.0pt;padding:0in">, (*((u8*)test-&gt;vaddr_to)));<o:p></o:p></span></code>=
</pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in"><o:p>&nbsp;</o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D I=
RQ_HANDLED;<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; } </span></code><span class=3D"hl=
js-keyword"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#242=
729;border:none windowtext 1.0pt;padding:0in">else</span></span><code><span=
 style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none w=
indowtext 1.0pt;padding:0in"> {<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D I=
RQ_NONE;<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp; &nbsp;</span></code><span class=3D"hljs=
-keyword"><span style=3D"font-family:&quot;inherit&quot;,serif;color:#24272=
9;border:none windowtext 1.0pt;padding:0in">return</span></span><code><span=
 style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none w=
indowtext 1.0pt;padding:0in"> ret;<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">}<o:p></o:p></span></code></pre>
<p style=3D"margin-top:0in;background:white;vertical-align:baseline;margin-=
bottom:var(--s-prose-spacing);font-style:inherit;font-variant:inherit;font-=
weight:inherit;font-stretch: inherit;line-height:inherit;box-sizing: inheri=
t">
<span style=3D"font-size:11.5pt;font-family:&quot;inherit&quot;,serif;color=
:#242729">however the value I get is still 255(0xff) and not 18(0x12) proba=
bly I've missed something but when the interrupt is called the transfer to =
the RAM address should be completed, however
 it seems like the dma_write_buffer function from the device does not perfo=
rm any transfer. What Am I missing?<o:p></o:p></span></p>
<p style=3D"margin-top:0in;background:white;vertical-align:baseline"><span =
style=3D"font-family:&quot;Arial&quot;,sans-serif;color:#242729;background:=
white">when I debugged the dma_coherent_alloc I saw it uses direct acccess(=
without iommu), however when the dma_pci_write
 is called it tries to access the memory via iommu and get's an error code(=
MEMTX_DECODE_ERROR) from memory.c 's memory_region_dispatch_write. Since me=
mory_region_access_valid returns false on it's first condition(also under m=
emory.c<o:p></o:p></span></p>
<p style=3D"margin-top:0in;background:white;vertical-align:baseline"><span =
style=3D"font-family:&quot;Arial&quot;,sans-serif;color:#242729;background:=
white">I am now in a deadlock, since even this simple example&nbsp; doesn&#=
8217;t seem to work, any idea what happens, or any suggestions
 for an alternative simple device with a simple driver which I can learn fr=
om will be great.</span><span style=3D"font-size:12.5pt;font-family:&quot;i=
nherit&quot;,serif;color:#242729"><o:p></o:p></span></p>
<p style=3D"margin-top:0in;background:white;vertical-align:baseline;margin-=
bottom:var(--s-prose-spacing);font-style:inherit;font-variant:inherit;font-=
weight:inherit;font-stretch: inherit;line-height:inherit;box-sizing: inheri=
t">
<span style=3D"font-size:11.5pt;font-family:&quot;inherit&quot;,serif;color=
:#242729">Technical details: edu_device:&nbsp;<a href=3D"https://github.com=
/qemu/qemu/blob/master/hw/misc/edu.c"><span style=3D"border:none windowtext=
 1.0pt;padding:0in">https://github.com/qemu/qemu/blob/master/hw/misc/edu.c<=
/span></a>&nbsp;original
 edu_driver:&nbsp;<a href=3D"https://github.com/cirosantilli/linux-kernel-m=
odule-cheat/blob/master/kernel_modules/qemu_edu.c"><span style=3D"border:no=
ne windowtext 1.0pt;padding:0in">https://github.com/cirosantilli/linux-kern=
el-module-cheat/blob/master/kernel_modules/qemu_edu.c</span></a>&nbsp;I
 run this on an x86-64 qemu machine with the following configuration:<o:p><=
/o:p></span></p>
<pre style=3D"background:white;vertical-align:baseline;margin-bottom:calc(v=
ar(--s-prose-spacing) + 0.4em);font-style:inherit;font-variant:inherit;font=
-weight:inherit;font-stretch: inherit;box-sizing: inherit;max-height: 600px=
;background-color:var(--highlight-bg);border-radius: 5px;color:var(--highli=
ght-color);overflow-wrap: normal;overflow:auto"><code><span style=3D"font-f=
amily:&quot;inherit&quot;,serif;color:#242729;border:none windowtext 1.0pt;=
padding:0in">$repo_loc/build/qemu-system-x86_64 \<o:p></o:p></span></code><=
/pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; -no-kvm \<o:p></o:p></span></code=
></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; -kernel $repo_loc/linux</span></c=
ode><span class=3D"hljs-number"><span style=3D"font-family:&quot;inherit&qu=
ot;,serif;color:#242729;border:none windowtext 1.0pt;padding:0in">-5.8.5</s=
pan></span><code><span style=3D"font-family:&quot;inherit&quot;,serif;color=
:#242729;border:none windowtext 1.0pt;padding:0in">/arch/x86/boot/bzImage \=
<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; -boot c -m </span></code><span cl=
ass=3D"hljs-number"><span style=3D"font-family:&quot;inherit&quot;,serif;co=
lor:#242729;border:none windowtext 1.0pt;padding:0in">2049</span></span><co=
de><span style=3D"font-family:&quot;inherit&quot;,serif;color:#242729;borde=
r:none windowtext 1.0pt;padding:0in">M \<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; -hda $repo_loc/buildroot</span></=
code><span class=3D"hljs-number"><span style=3D"font-family:&quot;inherit&q=
uot;,serif;color:#242729;border:none windowtext 1.0pt;padding:0in">-2020.02=
.6</span></span><code><span style=3D"font-family:&quot;inherit&quot;,serif;=
color:#242729;border:none windowtext 1.0pt;padding:0in">/output/images/root=
fs.ext4 \<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; -append </span></code><span class=
=3D"hljs-string"><span style=3D"font-family:&quot;inherit&quot;,serif;color=
:#242729;border:none windowtext 1.0pt;padding:0in">&quot;root=3D/dev/sda rw=
 console=3DttyS0,115200 acpi=3Doff nokaslr&quot;</span></span><code><span s=
tyle=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none win=
dowtext 1.0pt;padding:0in"> \<o:p></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; -serial stdio -display none \<o:p=
></o:p></span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; -virtfs local,path=3D$repo_loc/sh=
ared,mount_tag=3Dhost0,security_model=3Dpassthrough,id=3Dhost0 \<o:p></o:p>=
</span></code></pre>
<pre style=3D"background:white;vertical-align:baseline"><code><span style=
=3D"font-family:&quot;inherit&quot;,serif;color:#242729;border:none windowt=
ext 1.0pt;padding:0in">&nbsp;&nbsp;&nbsp; -device edu<o:p></o:p></span></co=
de></pre>
<p style=3D"margin:0in;margin-bottom:.0001pt;background:white;vertical-alig=
n:baseline;font-style:inherit;font-variant:inherit;font-weight:inherit;font=
-stretch: inherit;line-height:inherit;box-sizing: inherit">
<span style=3D"font-size:11.5pt;font-family:&quot;inherit&quot;,serif;color=
:#242729">(where $repo_location is the path to my build dir)<o:p></o:p></sp=
an></p>
<p style=3D"margin:0in;margin-bottom:.0001pt;background:white;vertical-alig=
n:baseline">
<span style=3D"font-size:11.5pt;font-family:&quot;inherit&quot;,serif;color=
:#242729"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Shaked Matzner<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<br>
<p style=3D"font-size:8pt; line-height:10pt; font-family: 'Cambria','times =
roman',serif;">
The contents of this email message and any attachments are intended solely =
for the addressee(s) and may contain confidential and/or privileged informa=
tion and may be legally protected from disclosure. If you are not the inten=
ded recipient of this message or
 their agent, or if this message has been addressed to you in error, please=
 immediately alert the sender by reply email and then delete this message a=
nd any attachments. If you are not the intended recipient, you are hereby n=
otified that any use, dissemination,
 copying, or storage of this message or its attachments is strictly prohibi=
ted. </p>
</body>
</html>

--_000_AM9PR09MB4643ECD51E00A54B871DED7682140AM9PR09MB4643eurp_--

