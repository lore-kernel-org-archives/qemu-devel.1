Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FAEC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3205F2224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emdalo.onmicrosoft.com header.i=@emdalo.onmicrosoft.com header.b="Rr4bRJ/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3205F2224D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emdalo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQV8-0005xA-7g
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.griffin@emdalo.com>)
 id 1kUQMW-0005pa-IH; Mon, 19 Oct 2020 04:17:48 -0400
Received: from mail-vi1eur05on2089.outbound.protection.outlook.com
 ([40.107.21.89]:44417 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.griffin@emdalo.com>)
 id 1kUQMT-00005y-J1; Mon, 19 Oct 2020 04:17:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kha3Xd3U/uI085JAW9BXRQSHwvBgeGt1+5dTXjwoXbVWLb2gFce6q6uQXRxSThuPH7Tlav6ir1+yNPr7Ag256qP5lomDA84Nd3o/msB8YxNd2ho4hD2hyIshOdbsBtHyV/QTqh5V2B4lPZkrsW2jR51eA4Y2XPG6G09WBbCURlNtStDXGUIY+q1fHxnql99Ysxr+ugSRC3fNXyyu0zh0iC69QI2+tqcp7OQ8ODHgv8NQmxm8jy516BmunJ6VCXGR1bbVKsuGdJTmTgyC9HIf+MjYXwE4m/ECujHEn5Ish1PL9BZmBu77AALWWXmJJNIooxTvCA+X00C2rn9GIaxSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJYwH6v6KNyXJeRmtIUtKjpmBqQOI0l4+ZFbS2gzvdk=;
 b=k7oRQAEaZop1zG8mnjXCy4dFn3zIV7pjVBGnzVR9oX72LoACFvjywRwGOvDh5hpR6+Nlc7Rk4xzx2p9n/PCLEksNUXguf0dKZ4iuGc9RmAre1Q9CVrPOB8GVDXPAvaOIPw7wMD6zWD0QoG+d3vAC4vSDYu3ro1q7289vZcBHEdatOn6eZ+4McmCu7ahW9OWPBDfo7GxYkje9Fu85Tlwro2zMRzLUXlMTruFUrrpeVkV7vPaQV1R7rOwRSmOGH6y0KE7sxa3jmYB4oDPB14fyLOyd0XWmnZ+AVyHbpol18zbE8q6ybtir/OcPAEFLXMicBnYwj+a9Q++QVBJCweU1fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emdalo.com; dmarc=pass action=none header.from=emdalo.com;
 dkim=pass header.d=emdalo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emdalo.onmicrosoft.com; s=selector2-emdalo-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJYwH6v6KNyXJeRmtIUtKjpmBqQOI0l4+ZFbS2gzvdk=;
 b=Rr4bRJ/oCUPHDbKuSQolNWt+IKiEnEH8GatoMhug7WSQfdVX+3ozqmIcaWJftOr3NxY7Q6zGwQ2Luabgalbw/nV5/6ITJM7sPNEihbgNZ9eXUZOrbwPEWaqNVDy1EAUTJjIk1bYRltN0dtZDmv2I/MNec9y/R2v0cE86GNAE9Gw=
Received: from DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:e::24) by
 DB6PR10MB1781.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:3b::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22; Mon, 19 Oct 2020 08:17:39 +0000
Received: from DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2cbe:c29d:d77f:e65f]) by DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2cbe:c29d:d77f:e65f%7]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 08:17:39 +0000
From: Ivan Griffin <ivan.griffin@emdalo.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
Thread-Topic: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
Thread-Index: AQHWo7koTlHYzPX6kkGBi37eK2QKsqmaZYWAgAAFWCCAA8Y+AIAAZ4/k
Date: Mon, 19 Oct 2020 08:17:39 +0000
Message-ID: <DB7PR10MB1915CB83F5FD388871B4D841FE1E0@DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM>
References: <20201016123737.8118-1-ivan.griffin@emdalo.com>
 <CAKmqyKNykruYK2AQ05KZyGCGD0rUsqQOVBbnccY+ELATBF=Ozg@mail.gmail.com>
 <DB7PR10MB191544AA04D0B3ECF82C57CDFE030@DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM>,
 <CAEUhbmVPzOuP3kuMhZB2JgN47nnzL7p9+meyhyBK7kRAhu5BCw@mail.gmail.com>
In-Reply-To: <CAEUhbmVPzOuP3kuMhZB2JgN47nnzL7p9+meyhyBK7kRAhu5BCw@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=emdalo.com;
x-originating-ip: [86.45.25.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cc60e16-f98c-4dd1-50f4-08d874077192
x-ms-traffictypediagnostic: DB6PR10MB1781:
x-microsoft-antispam-prvs: <DB6PR10MB1781A4E6A2510CBA0618F50CFE1E0@DB6PR10MB1781.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZlSc8lRQ9YgxoUhORCbBNuSAeF6iBSaKE+pl3AvA3V3AsyGwE8dd6Bz9LiCBpguDqctU1pRIuCfGaJy/MwrFIT/sjGojem0hFGnmJsFLbwRruyGkjPUOrjwZPQ/HXKtnmr9UCTV2lNKa5uBeLDGaFEKh0RFcvA8y/kC0l/J7/6FpEXjFFD7vM50gQ4/kkzZtdIY2vu66cU0SimUmvpJqmBZzy4l1p1LWvYKsDcyKD1qO0NTJlES31Tyra3lxFmdRJ2tqgy1SaUlePmLlZ1qew3f20DMA1wLvB9uhLj5M9CxaKnGmaERw8+J2glwGqon+UtqzUSHCxa3f1c0V2dxc8tEHBa//uH3A5aN9iWKBls8ICrP9Qh0zcwgI5/c079E7wTZuMMh670R7kjDYppknPQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(366004)(346002)(376002)(396003)(136003)(39830400003)(86362001)(64756008)(66476007)(66946007)(44832011)(76116006)(66556008)(5660300002)(55016002)(6506007)(52536014)(66446008)(478600001)(186003)(53546011)(7696005)(26005)(71200400001)(966005)(33656002)(166002)(6916009)(83380400001)(9686003)(8936002)(2906002)(19627405001)(8676002)(316002)(4326008)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: HLiQFxiIt9fAQl7476Q2lALyJBbtNbrtq6Te5CH8KsDbCJ0zxXY2UtjH7vvTZ36poL5sR1kDf1/PCuPaAdNfyUohJqZgmZCCr8CN3v64n9ze9AsDJK4ekTGMhVI5KnpNk7m2GJNfdMGs4CJOR5IMk2R2fOpyn0WcB9jy9OIWgcP96QMVvD14tvXpC9GhQc18n9vdnEQHZVtg74eusNITjMSflRkIhbPucGYjZ9tJZXlV5wfynOi5ZWzy6gS+5R9mSpwGd03m83FBAmBqxYtSSPRpKb74/AsW4BO7pEQqvKhQ/iLoeaVEIVfhMTCmn5QRrsDq6C2k3otQoVt2VRt2n2N6VwZMc4lthKwXz0NPZ+t0FxB+GNIQiP8PO6euwlqKjW640gGqxIgkiaON0VL4DMjazx89xHUnMpuyO5n6riXLXtgMz2qOF8Y2J/BxxKsh8qfVirrBhRPdtyRBXYg4ExlicT4MGu2w9nwpb9+y6TlrjXq0vDwSZJqYzqfnW7Yy045Xx4XNPrPjSBcy2JWiheigh41T2jNXX4GF/HUPPbT+RsFHtCudEMl7oPU/tyLYW9x443OYfZPb/nLYzLxnL0fBUVGcg3V9A8TeZzsIxT0sq+uVKxzo7gU2Kdj/CqSQYM+wXCsH88BwbVGRRmj8mw==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DB7PR10MB1915CB83F5FD388871B4D841FE1E0DB7PR10MB1915EURP_"
MIME-Version: 1.0
X-OriginatorOrg: emdalo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc60e16-f98c-4dd1-50f4-08d874077192
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 08:17:39.0113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12485e48-c3f6-4e74-8f2d-9058be9b6951
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbFV8kQVDi2wpa9juB7DhL5AaHAz+mAaqUvvrSxXGc7tlHWtkeFNp8Ds+I2I/uhEcx4PvJ+VWtnL74B58ZMJIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1781
Received-SPF: pass client-ip=40.107.21.89;
 envelope-from=ivan.griffin@emdalo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 04:17:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

--_000_DB7PR10MB1915CB83F5FD388871B4D841FE1E0DB7PR10MB1915EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Bin,

Well spotted with the register map. I grepped it for 0x37020000 and didn't =
find it, but it seems the address (incorrectly) is 0x07020000 in the docume=
ntation.

Thanks,
Ivan.

________________________________
From: Bin Meng <bmeng.cn@gmail.com>
Sent: Monday 19 October 2020 03:05
To: Ivan Griffin <ivan.griffin@emdalo.com>
Cc: Alistair Francis <alistair23@gmail.com>; QEMU Trivial <qemu-trivial@non=
gnu.org>; Bin Meng <bin.meng@windriver.com>; open list:RISC-V <qemu-riscv@n=
ongnu.org>; qemu-devel@nongnu.org Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry

Hi Ivan,

On Sat, Oct 17, 2020 at 12:31 AM Ivan Griffin <ivan.griffin@emdalo.com> wro=
te:
>
> I don't know why it isn't documented in that PDF (or in the register map)=
, but if you check https://github.com/polarfire-soc/polarfire-soc-bare-meta=
l-library/blob/master/src/platform/drivers/mss_sys_services/mss_sys_service=
s.h you'll see the following
>
> ```
> typedef struct
> {
>     volatile uint32_t SOFT_RESET;
>     volatile uint32_t VDETECTOR;
>     volatile uint32_t TVS_CONTROL;
>     volatile uint32_t TVS_TEMP_A;
>     volatile uint32_t TVS_TEMP_B;
>     volatile uint32_t TVS_TEMP_C;
>     volatile uint32_t TVS_VOLT_A;
>     volatile uint32_t TVS_VOLT_B;
>     volatile uint32_t TVS_VOLT_C;
>     volatile uint32_t TVS_OUTPUT0;
>     volatile uint32_t TVS_OUTPUT1;
>     volatile uint32_t TVS_TRIGGER;
>     volatile uint32_t TRIM_VDET1P05;
>     volatile uint32_t TRIM_VDET1P8;
>     volatile uint32_t TRIM_VDET2P5;
>     volatile uint32_t TRIM_TVS;
>     volatile uint32_t TRIM_GDET1P05;
>     volatile uint32_t RESERVED0;
>     volatile uint32_t RESERVED1;
>     volatile uint32_t RESERVED2;
>     volatile uint32_t SERVICES_CR;
>     volatile uint32_t SERVICES_SR;
>     volatile uint32_t USER_DETECTOR_SR;
>     volatile uint32_t USER_DETECTOR_CR;
>     volatile uint32_t MSS_SPI_CR;
>
> } SCBCTRL_TypeDef;
>
> #define MSS_SCBCTRL                    ((SCBCTRL_TypeDef*) (0x37020000UL)=
)
>
> /*2kB bytes long mailbox.*/
> #define MSS_SCBMAILBOX                 ((uint32_t*) (0x37020800UL))
> ```
>
> And in https://github.com/polarfire-soc/polarfire-soc-bare-metal-library/=
blob/master/src/platform/drivers/mss_sys_services/mss_sys_services.c you'll=
 see MSS_SCB and MSS_SCBMAILBOX used in many places to interact with the FP=
GA system controller to perform various services.

It's actually documented, but not in the PDF file. I also spent some
time locating the doc when I do the DDR controller modeling work.

See Register Map/PF_SoC_RegMap_V1_1/MPFS250T/pfsoc_control_scb.htm in
https://www.microsemi.com/document-portal/doc_download/1244581-polarfire-so=
c-register-map

Regards,
Bin

--_000_DB7PR10MB1915CB83F5FD388871B4D841FE1E0DB7PR10MB1915EURP_
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
Hi Bin,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
Well spotted with the register map. I grepped it for 0x37020000 and didn't =
find it, but it seems the address (incorrectly) is 0x07020000 in the docume=
ntation.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Thanks,</div>
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
<b>Sent:</b> Monday 19 October 2020 03:05<br>
<b>To:</b> Ivan Griffin &lt;ivan.griffin@emdalo.com&gt;<br>
<b>Cc:</b> Alistair Francis &lt;alistair23@gmail.com&gt;; QEMU Trivial &lt;=
qemu-trivial@nongnu.org&gt;; Bin Meng &lt;bin.meng@windriver.com&gt;; open =
list:RISC-V &lt;qemu-riscv@nongnu.org&gt;; qemu-devel@nongnu.org Developers=
 &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b> Re: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap ent=
ry</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Hi Ivan,<br>
<br>
On Sat, Oct 17, 2020 at 12:31 AM Ivan Griffin &lt;ivan.griffin@emdalo.com&g=
t; wrote:<br>
&gt;<br>
&gt; I don't know why it isn't documented in that PDF (or in the register m=
ap), but if you check
<a href=3D"https://github.com/polarfire-soc/polarfire-soc-bare-metal-librar=
y/blob/master/src/platform/drivers/mss_sys_services/mss_sys_services.h">
https://github.com/polarfire-soc/polarfire-soc-bare-metal-library/blob/mast=
er/src/platform/drivers/mss_sys_services/mss_sys_services.h</a> you'll see =
the following<br>
&gt;<br>
&gt; ```<br>
&gt; typedef struct<br>
&gt; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t SOFT_RESET;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t VDETECTOR;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_CONTROL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_TEMP_A;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_TEMP_B;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_TEMP_C;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_VOLT_A;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_VOLT_B;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_VOLT_C;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_OUTPUT0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_OUTPUT1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TVS_TRIGGER;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TRIM_VDET1P05;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TRIM_VDET1P8;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TRIM_VDET2P5;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TRIM_TVS;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t TRIM_GDET1P05;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t RESERVED0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t RESERVED1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t RESERVED2;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t SERVICES_CR;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t SERVICES_SR;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t USER_DETECTOR_SR;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t USER_DETECTOR_CR;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t MSS_SPI_CR;<br>
&gt;<br>
&gt; } SCBCTRL_TypeDef;<br>
&gt;<br>
&gt; #define MSS_SCBCTRL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((SCBCTRL_T=
ypeDef*) (0x37020000UL))<br>
&gt;<br>
&gt; /*2kB bytes long mailbox.*/<br>
&gt; #define MSS_SCBMAILBOX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint32_t*) (0x37020800UL=
))<br>
&gt; ```<br>
&gt;<br>
&gt; And in <a href=3D"https://github.com/polarfire-soc/polarfire-soc-bare-=
metal-library/blob/master/src/platform/drivers/mss_sys_services/mss_sys_ser=
vices.c">
https://github.com/polarfire-soc/polarfire-soc-bare-metal-library/blob/mast=
er/src/platform/drivers/mss_sys_services/mss_sys_services.c</a> you'll see =
MSS_SCB and MSS_SCBMAILBOX used in many places to interact with the FPGA sy=
stem controller to perform various
 services.<br>
<br>
It's actually documented, but not in the PDF file. I also spent some<br>
time locating the doc when I do the DDR controller modeling work.<br>
<br>
See Register Map/PF_SoC_RegMap_V1_1/MPFS250T/pfsoc_control_scb.htm in<br>
<a href=3D"https://www.microsemi.com/document-portal/doc_download/1244581-p=
olarfire-soc-register-map">https://www.microsemi.com/document-portal/doc_do=
wnload/1244581-polarfire-soc-register-map</a><br>
<br>
Regards,<br>
Bin<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DB7PR10MB1915CB83F5FD388871B4D841FE1E0DB7PR10MB1915EURP_--

