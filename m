Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4158AC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5D2208C7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="l8hf11tW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5D2208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXdAk-00021h-SS
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 00:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kXd70-0006TN-WB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 00:31:04 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com
 ([40.107.92.57]:29409 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kXd6y-0002sw-0O
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 00:31:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3Rh1Q6dqLEM5Jc0tDyX2KKbbQLdyu6CANKKoixL2gf9YO4z82torcq0MGNSsJait6PmxGWeOxwGmDLs77Dlc5YxwZuzMxjQHWKS3YLifmhO6+kan3cq9vCK15mcD8wk47nXUTV1KJw3cyiEK2EKI7qEWst5OpBKjbN3izLBscyNxoxFqtAGzyTWvJhi1n58n13moeduYpEWJvsCOWpBV6EG12kozw5Ber2F8LWZ6q2LP67/2krSwctHDVX2aIOUp3paX8THnUunTBPZ5SEl398nUXOVIpKZOD/3lF78sc5vzICY6ZjcHhlFIzfRd1vQP8qcsG8FSX4PTs2/B0TW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVgGaifIsB2LmBbhLIsa0gpo+ygIW7Ra9Zka7IFtfO0=;
 b=g2WrHAglqAw3OhbnzbU1mN6DsCPC7HN2lqBuYcMuCt5JqFTmBdFOjhKke5hHrHHIIxWkPdqZnxVFtOeVHPu3v15vjtWpXjAZN8QFTnkdQqERbuLuMAdvykfDPhBndGFDpWm2Y3zMedBwaTmCY+Azt3hcUwWIPUdIJ7S3xsOzWs2msxl+Y3LCWCsQA3JxJtJHJYYyg9JffhpTT7T7yuJ2JiVNPhrXasmD7vBKJUceoVZxgtwXLB59FSsf2CkwsbV7lXUeJuPpRRe3Ao18HtmBRgY2ZT5sCbrL1PRjZ/RYfg4ZZCG7bKJBS8Mjj/ftmxV0bepS4fErU7bxrzFfMsY5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVgGaifIsB2LmBbhLIsa0gpo+ygIW7Ra9Zka7IFtfO0=;
 b=l8hf11tWrAAGHWfS0wHpEOWpTx31YQy06h9uyxlZxIiBIHOsNB6kaZvn9qAqWFRIvmnSd8jFOSM+kmgLFg0GKQ1IRjfMdXYTHxlsk2KPUYCe/cQ+0cIUd5O5c8m2tr6ynMybfmWRaWYbYcVmwesjaN2NmYabMgGM8U7JX503yh4=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB6440.namprd02.prod.outlook.com (2603:10b6:a03:11f::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Wed, 28 Oct
 2020 04:15:54 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15%3]) with mapi id 15.20.3499.018; Wed, 28 Oct 2020
 04:15:54 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: Help on TCG asserts
Thread-Topic: Help on TCG asserts
Thread-Index: Adas4QWfA8SUlpWfQnWvDi+N7i94TA==
Date: Wed, 28 Oct 2020 04:15:53 +0000
Message-ID: <BY5PR02MB677272B3B2FB297EFBDF20E2CA170@BY5PR02MB6772.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ced82187-7ba2-4017-440d-08d87af82996
x-ms-traffictypediagnostic: BYAPR02MB6440:
x-microsoft-antispam-prvs: <BYAPR02MB6440EE42082AA441F729A5F8CA170@BYAPR02MB6440.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mIP4p7Sd9gtcoHM2FO+kFOp7oxo+AW5Dgw2WooqvtM6CxGjB+h4ZjOmd58HXsmDXDVOOZtvADIYMfWuOlNOwulAyY461XvptepkBJx6YLYlD9dQ6hfpn3KcgATaGlmBSd4OwsNUQkyHmrpAIbvKSJtrNapQ/4tehEvQQp6uJXPiYSAiaGgbh6OcD+uoV//mn1RnKPbdNm0KFS19l3ZZ3v4uR7jrTq6u3CGPrBZphsTicXAJwBCKY769lXFyb7D4Bl6tFhqj/3sIHKesBo2i4mKdZlQTFn6x50aD6pgEKUyGjw8pZrdRkt8sZ5U6UZZaY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39850400004)(366004)(376002)(396003)(9326002)(6916009)(316002)(55016002)(5660300002)(9686003)(3480700007)(54906003)(52536014)(66946007)(4744005)(76116006)(33656002)(2906002)(71200400001)(8936002)(8676002)(86362001)(66556008)(66476007)(26005)(186003)(478600001)(7696005)(66446008)(64756008)(6506007)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4l0N6ADpYszqUcKWfVfEpZT27k+R3E8Fyy+Cm/ddKrj5oju8dcGcqChVQ3sCltiJbKt2ICdA3/VzCYFIODGCeS5D6V8g7eQj9j75mkNqp3bDiBWCqCI2c+MzGKJxY/nKBTBrniuubHhObPW5SnrqQHb+HRE1EfHUfJ313BcTzZesAwtNpQEp0dvpvH0eqBsRHXN666xeIQG5nvPPuFAihOYsg1xkqdD/wxWZDFl8fl+K5jRF+QJSbh9B+wLX2wLUCJeNvS6FYZcoDusaw1FuqV2RWwn/Z6zE3g3Aq29zTYDL4AqqZMSkS7Sx/Fw9hyFSXwYzsZzAQUtHapmlJT+GLYXAvMjqpb0+52ZFB2SyjCIyCCmU+5pPy1OfYNkK4bTadAujvHK3C8D3HfIfhzvVlAEiRT1adIgwfGTKjtI5ChUnwZBs7WMpQOZnD+t3tGs+CpmN/20dkUbbHj96urnH3cn6s0Dskrg2rbmHxPeuDbIHcaEVZQM4sUa4xX0XMqhQR3hDPgWXgxGUo02+r5HiLEZHVPGAlQRsq2L1VnstNzhWdSShtNjYtLxE11q3gKNUcqoCDlYGMSwsfnqWHRGvUFBKv670PTEl05+mQ2IUjVlQ8+4BEJIgReua7/QWYkZByjxDwicIRJ0/TEOq8G3oGw==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BY5PR02MB677272B3B2FB297EFBDF20E2CA170BY5PR02MB6772namp_"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced82187-7ba2-4017-440d-08d87af82996
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 04:15:54.0420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+t2XMJ9Y1hXVHx8VHCsviCo47gcsOdkI7eYTwlfeJ4/goIYyIhDhtDn9Njn4tQU+2JeTcYJcz3tR3te39E1mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB6440
Received-SPF: pass client-ip=40.107.92.57; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 00:30:57
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BY5PR02MB677272B3B2FB297EFBDF20E2CA170BY5PR02MB6772namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Need some help on a qemu crash we are facing.

We hit asserts on below line

"tcg/tcg.c"
336 static void set_jmp_reset_offset(TCGContext *s, int which)
             337 {
             338     size_t off =3D tcg_current_code_size(s);
             339     s->tb_jmp_reset_offset[which] =3D off;
             340     /* Make sure that we didn't overflow the stored offset=
.  */
      >>> 341     assert(s->tb_jmp_reset_offset[which] =3D=3D off);
             342 }

Can anyone give some color on what to look out for. As I see, tcg seems to =
have some restriction of code size it could handle, but I'm confused how to=
 control that in qemu.

Regards,
Sai Pavan


--_000_BY5PR02MB677272B3B2FB297EFBDF20E2CA170BY5PR02MB6772namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Need some help on a qemu crash we are facing.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We hit asserts on below line<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&quot;tcg/tcg.c&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">336 static void set_jmp_reset_offset(TCGContext *s, =
int which)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 337 {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 338&nbsp;&nbsp;&nbsp;&nbsp; size_t off =3D tcg_current=
_code_size(s);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 339&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;tb_jmp_reset_offset[=
which] =3D off;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 340&nbsp;&nbsp;&nbsp;&nbsp; /* Make sure that we didn'=
t overflow the stored offset.&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;&gt;&gt; 341=
&nbsp;&nbsp;&nbsp;&nbsp; assert(s-&gt;tb_jmp_reset_offset[which] =3D=3D off=
);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 342 }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can anyone give some color on what to look out for. =
As I see, tcg seems to have some restriction of code size it could handle, =
but I&#8217;m confused how to control that in qemu.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Sai Pavan<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BY5PR02MB677272B3B2FB297EFBDF20E2CA170BY5PR02MB6772namp_--

