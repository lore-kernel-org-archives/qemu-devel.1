Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BECEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0C72067B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J+TCYASe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0C72067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9yb-0003lT-8a
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jh9x8-0001uY-45; Fri, 05 Jun 2020 06:51:58 -0400
Received: from mail-eopbgr70113.outbound.protection.outlook.com
 ([40.107.7.113]:37159 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jh9x5-00048x-6h; Fri, 05 Jun 2020 06:51:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0JPbRTVctX0c26MQbOXLYqTdDYt8J//YtVAvxJ32hcujWEzcCS6x7wuOsUBMzUfu5WSTU9LZZ8eV5J7IQvY3az3idPtQFDR0PBNUI4i9v/R4w7rX+cvAzPRBaxZI8ODOuBthBHQEMfjLZFY/4iTvthh6ISCq0OWlKH7CtEvm086GwLi6DGqHHgmR0CDfui2AjbK34KAGtNxsdYSWNudq6N44Xfl7F6dZwWbRPqfyXJ94U0sfGRuAcqrJGs+J9XXP4msKgvxCXSwZHatPMvmSYWD8C3hJOIzXSZFi+W/LdvjM1ApIaT+ID0TCeCR/F2ko7HCxGdCUI4SwwHvwBzheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QBFP7l29fo/l4HLdfKRq77GpH9FqyLs0d7B/KCUJlA=;
 b=nTGFsdwwvnxIzVrSEBK5CpqGKmBEk4HcN5MMp/+iYbdlz1BLEBh7OuySVJRIbtoDE9XP6e1veQoJ5gbzauEtpvRyYwq9f9VttsQlmFoaMYdZGYhPJT90xcg9qxY2gvlS6lA5pM/9ImfpY19ggeRjxaBzp6dSdEuq47oNGxcENrama/UyD0zmaFZ50IdWl4LeBosl9jyOXFHuuBfwZkiLI1BeP4X9AfFDDeKCyDXUOCV9j06h1AqJ75ZXPzqpo398Z12ylybLpcgvPy2QIq1TVbcIAP5s51ao/Jdtw7GpFrZQIXX1VT2Rw2VpFNpvFP1DAYENM1bIsusZ+epYFbiVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QBFP7l29fo/l4HLdfKRq77GpH9FqyLs0d7B/KCUJlA=;
 b=J+TCYASekIINulMYupLui/YS1AtRamQC12d0Bn3rF5u/i7Dnz+A9j2WPR9ppYtHC5WJ4aJaIv3EzN9bsPWs59TCv1iHxM05OQ0hwHRgW+/ZsAKd/Te/O5O/drqudDzPi0QIgBeb6QKzrduzoAG7pred754elw64rGM9++YngkPI=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4231.eurprd08.prod.outlook.com (2603:10a6:20b:73::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 10:51:51 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 10:51:51 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 02/12] qcow2.py: move qcow2 format classes to separate
 module
Thread-Topic: [PATCH v4 02/12] qcow2.py: move qcow2 format classes to separate
 module
Thread-Index: AQHWOpdtOjDkOZ67Y0ilvO6wA8Zv1ajJ2TvV
Date: Fri, 5 Jun 2020 10:51:51 +0000
Message-ID: <AM6PR08MB40700E666A4805864D458863F4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>,
 <20200604174135.11042-3-vsementsov@virtuozzo.com>
In-Reply-To: <20200604174135.11042-3-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [109.252.114.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd6b190d-69ba-4ba0-1e4a-08d8093e742f
x-ms-traffictypediagnostic: AM6PR08MB4231:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4231FC6075389F2AB6E3CD85F4860@AM6PR08MB4231.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:337;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ebDXCBEDF/PSAJ9OOlmkOtSh+cNZ1jjscRoEO3wgvDJdpleHC0HJjDSlsizrchQY4UbcsZxOlb1TBq+L8CRMfua7mH6/CeacR3/sqdju4DnpneJr0Be2ieHytpsbgEhL6SB+l0MEMUAgQNg6820UZME2wiXTkuwLlGfhT29E+nUHFpbskjOStO/iYd1WLB71Z1JsMMQ1aLpzU5HVFoPZULUyHfHEaqT/fARbynM4Ni140SjjP4M7m+yyOSBdGtyvhz0EAa3qSDWneR1XKusaghhSFZMudafik8WnriKwnhKnLmzXmv+BeCkPRV8JKPGXZ2YMQAU1Wo+NDTcgAj81RA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39840400004)(346002)(376002)(83380400001)(4326008)(5660300002)(52536014)(26005)(86362001)(2906002)(55016002)(6506007)(53546011)(186003)(66446008)(9686003)(66556008)(66946007)(91956017)(64756008)(66476007)(76116006)(316002)(110136005)(54906003)(7696005)(8936002)(44832011)(478600001)(8676002)(33656002)(71200400001)(107886003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 9M97oZ2pSq6BPt7TOO2pBxnv9o5Y20dtzFGO2BsFco/WyAYXxmpvaOmgHpzJRvEogHVM3rygjozMNYhFEyzQDC4TRsVSCAnP0r2tewVQyZRDLtHBrGYPIBalhMgKLf5qC2aFNPsImx4egUchTBlLlj1mDPwzAJaRstiVAZYaXCzm93/LY6aq3Ng8HbdKyxd2hHiBEC3/xwypcsRJQYprsaURegr6/LyTDoaOXxdFwGm280M5l1bE48oSY/S7dRJgudQpAPURZsqhy8RdjGF/CF4nJnBFHiqhcpThYpmLYVVElcsO9pHJlio8vLvrQ3p0iuUs8aJSrOAiJ0vMpnn9kP48trip5dMNz7JXi2eRZOv6feRic6y2ofXPSgFst7dB5fTZIbAFBGhdIW1DD5rVQRLPmw8d7NTmxziRHJac1g1GXgJWanhMVMUY2G9wurq5xXx2m6vD+6m6TUGJjipXlflhR++Hmx0scHCKU8BBaG1/B/xvyi3VbarDX85qMWJQ
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB40700E666A4805864D458863F4860AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6b190d-69ba-4ba0-1e4a-08d8093e742f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 10:51:51.3563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7+A/I87y+RWQotyPIcRY2hfuYXNpHGK3N+u4LZwvtq6Eq5iu32jxjmqileWwhkmWDz8q1PNW7zxerlQ0vkV7yWrK2NfAmWZLjq2eQ9dAec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4231
Received-SPF: pass client-ip=40.107.7.113;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 06:51:52
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM6PR08MB40700E666A4805864D458863F4860AM6PR08MB4070eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

________________________________
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Sent: Thursday, June 4, 2020 8:41 PM
To: qemu-block@nongnu.org <qemu-block@nongnu.org>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; mreitz@redhat.com <mreit=
z@redhat.com>; kwolf@redhat.com <kwolf@redhat.com>; eblake@redhat.com <ebla=
ke@redhat.com>; Denis Lunev <den@virtuozzo.com>; Vladimir Sementsov-Ogievsk=
iy <vsementsov@virtuozzo.com>; Andrey Shinkevich <andrey.shinkevich@virtuoz=
zo.com>
Subject: [PATCH v4 02/12] qcow2.py: move qcow2 format classes to separate m=
odule

We are going to enhance qcow2 format parsing by adding more structure
classes. Let's split format parsing from utility code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py        | 161 +----------------------------
 tests/qemu-iotests/qcow2_format.py | 157 ++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+), 157 deletions(-)
 create mode 100644 tests/qemu-iotests/qcow2_format.py

--_000_AM6PR08MB40700E666A4805864D458863F4860AM6PR08MB4070eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div><span style=3D"color: rgb(33, 33, 33); font-family: &quot;Segoe UI Wes=
tEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif; font-s=
ize: 14.6667px; font-style: normal; font-variant-ligatures: normal; font-va=
riant-caps: normal; font-weight: 400;">Reviewed-by: Andrey
 Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;</span><br>
</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Vladimir Sementsov-Og=
ievskiy &lt;vsementsov@virtuozzo.com&gt;<br>
<b>Sent:</b> Thursday, June 4, 2020 8:41 PM<br>
<b>To:</b> qemu-block@nongnu.org &lt;qemu-block@nongnu.org&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; mreitz@redh=
at.com &lt;mreitz@redhat.com&gt;; kwolf@redhat.com &lt;kwolf@redhat.com&gt;=
; eblake@redhat.com &lt;eblake@redhat.com&gt;; Denis Lunev &lt;den@virtuozz=
o.com&gt;; Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt;;
 Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;<br>
<b>Subject:</b> [PATCH v4 02/12] qcow2.py: move qcow2 format classes to sep=
arate module</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">We are going to enhance qcow2 format parsing by ad=
ding more structure<br>
classes. Let's split format parsing from utility code.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt=
;<br>
---<br>
&nbsp;tests/qemu-iotests/qcow2.py&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 | 161 &#43;----------------------------<br>
&nbsp;tests/qemu-iotests/qcow2_format.py | 157 &#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 161 insertions(&#43;), 157 deletions(-)<br>
&nbsp;create mode 100644 tests/qemu-iotests/qcow2_format.py<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB40700E666A4805864D458863F4860AM6PR08MB4070eurp_--

