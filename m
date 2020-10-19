Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0705C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D5B22257
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emdalo.onmicrosoft.com header.i=@emdalo.onmicrosoft.com header.b="DrmUwhmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D5B22257
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emdalo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQle-0001oa-O8
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.griffin@emdalo.com>)
 id 1kUQkg-00019I-Vq; Mon, 19 Oct 2020 04:42:47 -0400
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com
 ([40.107.21.70]:26464 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.griffin@emdalo.com>)
 id 1kUQke-0000ZT-32; Mon, 19 Oct 2020 04:42:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Smqi6sZFu7mUWoqGZdnwfe2/jfWQDq2SKhTR0QK+u02AuIjXFTZd78DuOzJuiFrG2wizxc+lTV+k1F0lEAJxbvLu0da8lQQGh4L0g31zKPlfMtvPWck22B0SFIFt7ZUNFOduD6Odeb/8kq0YhClqb1puSmTGD+Hphch/d6aiTkRCq52E1aqGImjtWX0mY4Wil0He9ZtxLWmI0ybm7nBSQABAI+8BV6RvcvjLVJqPaRjVh0FNT09LndCDxqYJGKEIZekIPjlOtw6p3gjy2lciZM2cfQLjWBYHnCljFMfQdI2nbA3uey6mwcjM3JLwwx6qyddMH4X7UCxiGE1oCRIeNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEFyZ2e8PK8EMYbcta6sgHFpMWfpxY3RRa9KuonGcXs=;
 b=ZgZhuxa86/vvNqcjJICQWCbQYcBRF/HFHta4LF2he/f8RtFfAiS2ECHxoPuVRkcjCNFpJErMzkQT16jQa8S1nWuFH/kMVYFR1GVFDB2mUm+d7UheJyLwjSrmGUnut87UQUv4SD7bLrLINP6KMz5Vg350WNJKx06q89NjIJL7U1aqmSieVxbEp7aoz41x+aAFPNTCCtMFftzwJfYMAESQ5RNY0crZaDV92N+B6Lmj5lOupyhKKjVcZnQ+bNRIjWgIn/vgS6V9jgICoFdscP3HG7hfxDeQXMvHwMVuqfyoVCEJR+o2X8umrr+vy8u2TVsCOLJxqik4NyVTfHzro55XCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emdalo.com; dmarc=pass action=none header.from=emdalo.com;
 dkim=pass header.d=emdalo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emdalo.onmicrosoft.com; s=selector2-emdalo-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEFyZ2e8PK8EMYbcta6sgHFpMWfpxY3RRa9KuonGcXs=;
 b=DrmUwhmoyiO/Pc/77fzD3o0pw4hpP8E5OrpOaM77wzaTx7CjC2kXM88s0o909obtAMQRfObOWFszm9KRwS+1yB2XNozbizzJCvrNdSgwKCj43C4MPzvEAkN/vKcrO2MXHXfcDSY1Oi2tGOyXp+57C8H8lK1w9VkMxvz+6r8eI0o=
Received: from DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:e::24) by
 DB8PR10MB3500.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:139::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Mon, 19 Oct 2020 08:42:39 +0000
Received: from DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2cbe:c29d:d77f:e65f]) by DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2cbe:c29d:d77f:e65f%7]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 08:42:39 +0000
From: Ivan Griffin <ivan.griffin@emdalo.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
Thread-Topic: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
Thread-Index: AQHWo7koTlHYzPX6kkGBi37eK2QKsqmaZYWAgAAFWCCAA8Y+AIAAZ4/kgAAGQICAAADJrQ==
Date: Mon, 19 Oct 2020 08:42:39 +0000
Message-ID: <DB7PR10MB19156652F022AF0FB502A976FE1E0@DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM>
References: <20201016123737.8118-1-ivan.griffin@emdalo.com>
 <CAKmqyKNykruYK2AQ05KZyGCGD0rUsqQOVBbnccY+ELATBF=Ozg@mail.gmail.com>
 <DB7PR10MB191544AA04D0B3ECF82C57CDFE030@DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM>
 <CAEUhbmVPzOuP3kuMhZB2JgN47nnzL7p9+meyhyBK7kRAhu5BCw@mail.gmail.com>
 <DB7PR10MB1915CB83F5FD388871B4D841FE1E0@DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM>,
 <CAEUhbmXmmtpZx9WUFBLgdDMm31QVc+vUFNmizfph8DEiu9Cjuw@mail.gmail.com>
In-Reply-To: <CAEUhbmXmmtpZx9WUFBLgdDMm31QVc+vUFNmizfph8DEiu9Cjuw@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=emdalo.com;
x-originating-ip: [86.45.25.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfb2b4fe-c852-49b2-6d75-08d8740af006
x-ms-traffictypediagnostic: DB8PR10MB3500:
x-microsoft-antispam-prvs: <DB8PR10MB3500B56378B6519FA2F1F6F1FE1E0@DB8PR10MB3500.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JxTZpQoDfYmAXjF35nyQ1b+wXQmSfHhHCG3UvAzojCV+vSyeSEPmXxgu3DEwY4Q4Y4dj+ZLFODiRBQTxqW8jwyN4AtCdX1uC0WZZ6i1iuuPRHuQvNdNCX+tonuG044DvbE/qNV9IuEknC2qZj4BfVTaxmay6vwo4pp9Cm1BTT3mIzOBOumCRIicSLj9uEsGESvX+7X188vlQqCRT8TRicj560Wj8BueIcw5ObZZIbdii2Z5dmKSHXZm6WeH1t1ESjeXt/a1rG5O7yzFVdsoM2OJAxBjWmA+2FDfIRFB0Q6YqMWAUNwj7xMq6oZhb52hW8v7ZSgLnfIhXq7sGaLlCemlcKHVsOp8QHNfmwiVHnPysmv/1NVvAohzjp0anL00IGy7ptggeq6PswpdpeH93aA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(366004)(346002)(39830400003)(376002)(136003)(396003)(71200400001)(2906002)(19627405001)(8676002)(478600001)(5660300002)(8936002)(186003)(52536014)(33656002)(966005)(54906003)(44832011)(76116006)(66446008)(64756008)(6506007)(53546011)(6916009)(7696005)(316002)(166002)(83380400001)(66946007)(66556008)(26005)(4326008)(86362001)(55016002)(66476007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: m7gBSHeklwoN55gZoFukuT0vORnFSr5FEl3LKxo6ajx9L6LRyNV3U+Y3bkEjYeGAAaXaxapihE1UXMKhUJD85DSuV27nzW9CByp5L8Hn5id73cz8j6/CTYyxTRr9bLCJcc6MgnkKz1igoqQGfEf5s0U+A85amxROp63T3QfeoVzbhO/AbTQXi2UDzDbKZ84P4nFM5leR5KFQOO0NiJQh5maqNMakJkuWrws9Zqbmt33lHRTM4Vlw/WdHN6AJAHr9y6qSJm3VqujEjkFzNNaeUMlNh3siAh1tNiJA9gsKVPqReIjOI9eeX3TEhdfP/fCJECHMYJI6DVImt9eMpcDNHoDLB2jwXXnHcpd2opsWIMBvjUbKL6DFJNOFb1L48ZLNvB6aP11fO+Xw71u67MaoMtbnSry1yAQ8w/OnoB2quXvgViyaRw0W1/2E0pT8k0Cploy66UQQTgqQHiOK1B9Bt4yghVHvEfkusfA+aKYsdcHnvK70yRBdBW3ijPuq5WLrFyACVHFy8UYtrXQntiLpG+WMj8jEqHiOpPBbuyW+XEwYXzxDVzUFn3Ql4yqK+zZNYkl2nfDbTvOVhSCniaY4B7yd5yjBkAjRmjJVs+8UA3q/qPephHRSp8IXuTgxVewaaimdy6d9o4gMHsAqF2R/Jw==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DB7PR10MB19156652F022AF0FB502A976FE1E0DB7PR10MB1915EURP_"
MIME-Version: 1.0
X-OriginatorOrg: emdalo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb2b4fe-c852-49b2-6d75-08d8740af006
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 08:42:39.7823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12485e48-c3f6-4e74-8f2d-9058be9b6951
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDJ98qkJThHIRalrZcamHifYqCN9TyAgLggM/M3L3cJMpsKet4RfEijQTbAHqk9ej9qVQQleji9OAVb/uMI/jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3500
Received-SPF: pass client-ip=40.107.21.70;
 envelope-from=ivan.griffin@emdalo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 04:42:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_DB7PR10MB19156652F022AF0FB502A976FE1E0DB7PR10MB1915EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, it could be.

But the "Physical Address" column, in my mind, should be the 0x37020000 add=
ress.  At least when I check other peripherals, their physical address valu=
es in the register map HTML corresponds to the source code.

Cheers,
Ivan.

________________________________
From: Bin Meng <bmeng.cn@gmail.com>
Sent: Monday 19 October 2020 09:38
To: Ivan Griffin <ivan.griffin@emdalo.com>
Cc: Alistair Francis <alistair23@gmail.com>; QEMU Trivial <qemu-trivial@non=
gnu.org>; open list:RISC-V <qemu-riscv@nongnu.org>; qemu-devel@nongnu.org D=
evelopers <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry

Hi Ivan,

On Mon, Oct 19, 2020 at 4:17 PM Ivan Griffin <ivan.griffin@emdalo.com> wrot=
e:
>
> Hi Bin,
>
> Well spotted with the register map. I grepped it for 0x37020000 and didn'=
t find it, but it seems the address (incorrectly) is 0x07020000 in the docu=
mentation.
>

I believe the documented offset 0x07020000 is the offset into the
IOSCB block, not the final one that is mapped into the system memory.

Regards,
Bin

> ________________________________
> From: Bin Meng <bmeng.cn@gmail.com>
> Sent: Monday 19 October 2020 03:05
> To: Ivan Griffin <ivan.griffin@emdalo.com>
> Cc: Alistair Francis <alistair23@gmail.com>; QEMU Trivial <qemu-trivial@n=
ongnu.org>; Bin Meng <bin.meng@windriver.com>; open list:RISC-V <qemu-riscv=
@nongnu.org>; qemu-devel@nongnu.org Developers <qemu-devel@nongnu.org>
> Subject: Re: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
>
> Hi Ivan,
>
> On Sat, Oct 17, 2020 at 12:31 AM Ivan Griffin <ivan.griffin@emdalo.com> w=
rote:
> >
> > I don't know why it isn't documented in that PDF (or in the register ma=
p), but if you check https://github.com/polarfire-soc/polarfire-soc-bare-me=
tal-library/blob/master/src/platform/drivers/mss_sys_services/mss_sys_servi=
ces.h you'll see the following
> >
> > ```
> > typedef struct
> > {
> >     volatile uint32_t SOFT_RESET;
> >     volatile uint32_t VDETECTOR;
> >     volatile uint32_t TVS_CONTROL;
> >     volatile uint32_t TVS_TEMP_A;
> >     volatile uint32_t TVS_TEMP_B;
> >     volatile uint32_t TVS_TEMP_C;
> >     volatile uint32_t TVS_VOLT_A;
> >     volatile uint32_t TVS_VOLT_B;
> >     volatile uint32_t TVS_VOLT_C;
> >     volatile uint32_t TVS_OUTPUT0;
> >     volatile uint32_t TVS_OUTPUT1;
> >     volatile uint32_t TVS_TRIGGER;
> >     volatile uint32_t TRIM_VDET1P05;
> >     volatile uint32_t TRIM_VDET1P8;
> >     volatile uint32_t TRIM_VDET2P5;
> >     volatile uint32_t TRIM_TVS;
> >     volatile uint32_t TRIM_GDET1P05;
> >     volatile uint32_t RESERVED0;
> >     volatile uint32_t RESERVED1;
> >     volatile uint32_t RESERVED2;
> >     volatile uint32_t SERVICES_CR;
> >     volatile uint32_t SERVICES_SR;
> >     volatile uint32_t USER_DETECTOR_SR;
> >     volatile uint32_t USER_DETECTOR_CR;
> >     volatile uint32_t MSS_SPI_CR;
> >
> > } SCBCTRL_TypeDef;
> >
> > #define MSS_SCBCTRL                    ((SCBCTRL_TypeDef*) (0x37020000U=
L))
> >
> > /*2kB bytes long mailbox.*/
> > #define MSS_SCBMAILBOX                 ((uint32_t*) (0x37020800UL))
> > ```
> >
> > And in https://github.com/polarfire-soc/polarfire-soc-bare-metal-librar=
y/blob/master/src/platform/drivers/mss_sys_services/mss_sys_services.c you'=
ll see MSS_SCB and MSS_SCBMAILBOX used in many places to interact with the =
FPGA system controller to perform various services.
>
> It's actually documented, but not in the PDF file. I also spent some
> time locating the doc when I do the DDR controller modeling work.
>
> See Register Map/PF_SoC_RegMap_V1_1/MPFS250T/pfsoc_control_scb.htm in
> https://www.microsemi.com/document-portal/doc_download/1244581-polarfire-=
soc-register-map

--_000_DB7PR10MB19156652F022AF0FB502A976FE1E0DB7PR10MB1915EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Yes, it could be.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
But the &quot;Physical Address&quot; column, in my mind, should be the 0x37=
020000 address.&nbsp; At least when I check other peripherals, their physic=
al address values in the register map HTML corresponds to the source code.<=
/div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Cheers,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Ivan.</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size: 11pt;"><b>From:</b> Bin Meng &lt;bmeng.=
cn@gmail.com&gt;<br>
<b>Sent:</b> Monday 19 October 2020 09:38<br>
<b>To:</b> Ivan Griffin &lt;ivan.griffin@emdalo.com&gt;<br>
<b>Cc:</b> Alistair Francis &lt;alistair23@gmail.com&gt;; QEMU Trivial &lt;=
qemu-trivial@nongnu.org&gt;; open list:RISC-V &lt;qemu-riscv@nongnu.org&gt;=
; qemu-devel@nongnu.org Developers &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b> Re: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap ent=
ry</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Hi Ivan,<br>
<br>
On Mon, Oct 19, 2020 at 4:17 PM Ivan Griffin &lt;ivan.griffin@emdalo.com&gt=
; wrote:<br>
&gt;<br>
&gt; Hi Bin,<br>
&gt;<br>
&gt; Well spotted with the register map. I grepped it for 0x37020000 and di=
dn't find it, but it seems the address (incorrectly) is 0x07020000 in the d=
ocumentation.<br>
&gt;<br>
<br>
I believe the documented offset 0x07020000 is the offset into the<br>
IOSCB block, not the final one that is mapped into the system memory.<br>
<br>
Regards,<br>
Bin<br>
<br>
&gt; ________________________________<br>
&gt; From: Bin Meng &lt;bmeng.cn@gmail.com&gt;<br>
&gt; Sent: Monday 19 October 2020 03:05<br>
&gt; To: Ivan Griffin &lt;ivan.griffin@emdalo.com&gt;<br>
&gt; Cc: Alistair Francis &lt;alistair23@gmail.com&gt;; QEMU Trivial &lt;qe=
mu-trivial@nongnu.org&gt;; Bin Meng &lt;bin.meng@windriver.com&gt;; open li=
st:RISC-V &lt;qemu-riscv@nongnu.org&gt;; qemu-devel@nongnu.org Developers &=
lt;qemu-devel@nongnu.org&gt;<br>
&gt; Subject: Re: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry=
<br>
&gt;<br>
&gt; Hi Ivan,<br>
&gt;<br>
&gt; On Sat, Oct 17, 2020 at 12:31 AM Ivan Griffin &lt;ivan.griffin@emdalo.=
com&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; I don't know why it isn't documented in that PDF (or in the regis=
ter map), but if you check
<a href=3D"https://github.com/polarfire-soc/polarfire-soc-bare-metal-librar=
y/blob/master/src/platform/drivers/mss_sys_services/mss_sys_services.h">
https://github.com/polarfire-soc/polarfire-soc-bare-metal-library/blob/mast=
er/src/platform/drivers/mss_sys_services/mss_sys_services.h</a> you'll see =
the following<br>
&gt; &gt;<br>
&gt; &gt; ```<br>
&gt; &gt; typedef struct<br>
&gt; &gt; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t SOFT_RESET;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t VDETECTOR;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_CONTROL;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_TEMP_A;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_TEMP_B;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_TEMP_C;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_VOLT_A;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_VOLT_B;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_VOLT_C;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_OUTPUT0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_OUTPUT1;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_TRIGGER;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TRIM_VDET1P05;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TRIM_VDET1P8;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TRIM_VDET2P5;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TRIM_TVS;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TRIM_GDET1P05;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t RESERVED0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t RESERVED1;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t RESERVED2;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t SERVICES_CR;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t SERVICES_SR;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t USER_DETECTOR_SR;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t USER_DETECTOR_CR;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t MSS_SPI_CR;<br>
&gt; &gt;<br>
&gt; &gt; } SCBCTRL_TypeDef;<br>
&gt; &gt;<br>
&gt; &gt; #define MSS_SCBCTRL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((SCBC=
TRL_TypeDef*) (0x37020000UL))<br>
&gt; &gt;<br>
&gt; &gt; /*2kB bytes long mailbox.*/<br>
&gt; &gt; #define MSS_SCBMAILBOX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint32_t*) (0x37020=
800UL))<br>
&gt; &gt; ```<br>
&gt; &gt;<br>
&gt; &gt; And in <a href=3D"https://github.com/polarfire-soc/polarfire-soc-=
bare-metal-library/blob/master/src/platform/drivers/mss_sys_services/mss_sy=
s_services.c">
https://github.com/polarfire-soc/polarfire-soc-bare-metal-library/blob/mast=
er/src/platform/drivers/mss_sys_services/mss_sys_services.c</a> you'll see =
MSS_SCB and MSS_SCBMAILBOX used in many places to interact with the FPGA sy=
stem controller to perform various
 services.<br>
&gt;<br>
&gt; It's actually documented, but not in the PDF file. I also spent some<b=
r>
&gt; time locating the doc when I do the DDR controller modeling work.<br>
&gt;<br>
&gt; See Register Map/PF_SoC_RegMap_V1_1/MPFS250T/pfsoc_control_scb.htm in<=
br>
&gt; <a href=3D"https://www.microsemi.com/document-portal/doc_download/1244=
581-polarfire-soc-register-map">
https://www.microsemi.com/document-portal/doc_download/1244581-polarfire-so=
c-register-map</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DB7PR10MB19156652F022AF0FB502A976FE1E0DB7PR10MB1915EURP_--

