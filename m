Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66306C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D726206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Q3Yj7hhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D726206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLTV-0000ND-BT
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jGLSE-0007bJ-LA
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jGLSC-0001cn-OX
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:41:13 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com
 ([40.107.7.118]:51646 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jGLSC-0001bL-4H; Mon, 23 Mar 2020 07:41:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPO6g8DobmFt4NWgnPsAvsnXeerKPGFCBjhYcFLu06vTTAvpz6/7LsBgEgaom9W3/D7oAFpZD/iDFqFjKG+pgjPpioTq81UkH2mJQXIqJdJT0WOeHkJnyCRlUv+D46B+dXa+5hhvph9CE3yKARLL8NUePeReFmByFj7+hU77Lbm1Nqp9do38FDO7H7pB2Pjd5RIf4y/r5ciqDc7HgTaLD+4QmBfeHyLG6WwYg7tqMSoW8o34c2vFufOlyEP37VlVT9cbxWB13yBPWHGlLjWGPmc0i1pI8Dqgq4ZfBTfpznKTNe10xaoFNbKPgDORVOsdWfdD0uwZMHLKnql419robQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YkFmUaX9qtf+NdRgL1/sVPCVzMgd1SFhD4I4nh+9J8=;
 b=QOuvLd+dAzo6iNXz4nia7+FzjqDoj/mOTaKDVfiVXrW8WtteeLm4xWT1+6EyckAdXSFllDyGNtq0iEq19il1hQTsQunvvvqnLVCB8PsSXPqxdQ8MuNFMr8wpHcZNQvDqYE4UC847RLfonK36oIQ7HKao0TLWtBSV3l+WFn+eGOwX4p7E3RionYCoJs3Y0AjqPX+M8GSL74fS93JJDnvOd7aDH2t36idDVeICJbRrfnxWgOp0UYvJbn2ZgfK9Ljju3rc49e9uJBQNNwM/yvV7GHjES9cmS6dByj48KXVN8Oq7egOv9l315riTBFJUpn8asajumCZY5z745PawON6WuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YkFmUaX9qtf+NdRgL1/sVPCVzMgd1SFhD4I4nh+9J8=;
 b=Q3Yj7hhpqMOr8G8MPvFoPMuwGqmUHZy8T/WXnSezIA1eE3Tu791ZtMbqKp7wcM8TRKJH+7YO3pZVj/N6tBWmaFc09Vtxl0fyeUo4Hg99qEpycPwuvk4SIA5ol+DvEY6Pu8VZL7vF+yW8lYQ1U3kSEgK3GhuuyWa6Gm5MQhm8YtY=
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4965.eurprd08.prod.outlook.com (10.255.121.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Mon, 23 Mar 2020 11:41:05 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 11:41:05 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] block: Avoid memleak on qcow2 image info failure
Thread-Topic: [PATCH] block: Avoid memleak on qcow2 image info failure
Thread-Index: AQHV/ubaA9pXQDy+pEaUB1O2p8k1RKhWECct
Date: Mon, 23 Mar 2020 11:41:04 +0000
Message-ID: <AM6PR08MB5048BD6CC01492C36FA6D5C1F4F00@AM6PR08MB5048.eurprd08.prod.outlook.com>
References: <20200320183620.1112123-1-eblake@redhat.com>
In-Reply-To: <20200320183620.1112123-1-eblake@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-originating-ip: [176.59.45.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4567dba-8b2c-4ec7-6e18-08d7cf1f1216
x-ms-traffictypediagnostic: AM6PR08MB4965:
x-microsoft-antispam-prvs: <AM6PR08MB49653D5232BCCE70C0FEAB65F4F00@AM6PR08MB4965.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(346002)(39840400004)(396003)(136003)(376002)(199004)(71200400001)(81166006)(81156014)(8676002)(478600001)(8936002)(54906003)(316002)(110136005)(19627405001)(4744005)(33656002)(186003)(76116006)(26005)(44832011)(6506007)(53546011)(64756008)(66476007)(7696005)(66946007)(66446008)(66556008)(55016002)(52536014)(5660300002)(2906002)(4326008)(86362001)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4965;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lj4j0BZudwgsdWjtYkW9RaVzkRMUTYoJzClHik7yi4sjcOm2UIC9FQkRN3AmAtlL1wOcSLFcFSx4WeBnakudPfKX37V8mw2yv0ob2X5g0/kQOc9izy7zdm8FTmMmfUmIUe5AiTEXbw4pglPOntBYV2lgLVRLxDqAq0F0Qghr0woK51QYCknTJiy8b/J+Ox5gtwTF/UaCwz/Djh4/MGobyDq1gTl8YFwbR65XxzV2YT/5D2DAL7wKEvOT6meAKlE7yEPEyw2Wx0EbSPONCFUporShVBycrOYPk+jtaQ8aul/5j9Ekpkio1J+S5bgtcxU13+lsHm8il8tIvwSw1owh94hfnLL9HEhr6GiW5PFvMyh67/GnJo/U9xkXi3LmaSjFrupohu98apsSHJUdrQFuTBet5H62A7Wc9D04jFKYAExSXj52ftJ43TJCUYn2r1s1
x-ms-exchange-antispam-messagedata: Tmr9XrkZtN6pZb0HbYPe2pyhBlK1xNcK/O08QsLf7xrI4NTTZw8UtCbgXbJ8i5fVWF/5H5jJY1oIQ/r2FeH5WzSVXhwz6WPyFJiVywwzN0oXtfLjhN5pum0iTOBBxAJl3/QRzGMAV7MFmBSI5PE8KQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB5048BD6CC01492C36FA6D5C1F4F00AM6PR08MB5048eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4567dba-8b2c-4ec7-6e18-08d7cf1f1216
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 11:41:04.9011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikkNmgv7mAuLa8Ff0C7xwy8WOQU9KqUtCqYhO5bOCDPvONMzH4qSQNayxsoVf9nSPaIP9m2Eo1Vhh4Bg8JIjkf2J4K9dmYvqoXFQr8AXfKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4965
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.118
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "open list:qcow2" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM6PR08MB5048BD6CC01492C36FA6D5C1F4F00AM6PR08MB5048eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



________________________________
From: Eric Blake <eblake@redhat.com>
Sent: Friday, March 20, 2020 9:36 PM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: peter.maydell@linaro.org <peter.maydell@linaro.org>; Andrey Shinkevich =
<andrey.shinkevich@virtuozzo.com>; Kevin Wolf <kwolf@redhat.com>; Max Reitz=
 <mreitz@redhat.com>; open list:qcow2 <qemu-block@nongnu.org>
Subject: [PATCH] block: Avoid memleak on qcow2 image info failure

If we fail to get bitmap info, we must not leak the encryption info.

Fixes: b8968c875f403
Fixes: Coverity CID 1421894
Signed-off-by: Eric Blake <eblake@redhat.com>
---

Thank you Eric.
I have made a smoke test only without the crypto object instantiation.

Andrey


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Tested-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


--_000_AM6PR08MB5048BD6CC01492C36FA6D5C1F4F00AM6PR08MB5048eurp_
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
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Eric Blake &lt;eblake=
@redhat.com&gt;<br>
<b>Sent:</b> Friday, March 20, 2020 9:36 PM<br>
<b>To:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> peter.maydell@linaro.org &lt;peter.maydell@linaro.org&gt;; Andre=
y Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;; Kevin Wolf &lt;kwolf@=
redhat.com&gt;; Max Reitz &lt;mreitz@redhat.com&gt;; open list:qcow2 &lt;qe=
mu-block@nongnu.org&gt;<br>
<b>Subject:</b> [PATCH] block: Avoid memleak on qcow2 image info failure</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">If we fail to get bitmap info, we must not leak th=
e encryption info.<br>
<br>
Fixes: b8968c875f403<br>
Fixes: Coverity CID 1421894<br>
Signed-off-by: Eric Blake &lt;eblake@redhat.com&gt;<br>
---</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Thank you Eric.</div>
<div class=3D"PlainText">I have made a smoke test only without the crypto o=
bject instantiation.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Andrey</div>
<div class=3D"PlainText">&nbsp;</div>
<div class=3D"PlainText">
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 11.0px Menlo; color: #00=
0000"><span style=3D"font-variant-ligatures: no-common-ligatures"></span></=
p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 11.0px Menlo; color: #00=
0000"><span style=3D"font-variant-ligatures: no-common-ligatures">Reviewed-=
by:&nbsp;</span><span style=3D"color: rgb(0, 0, 0); font-family: Menlo; fon=
t-size: 11px; font-style: normal; font-variant-caps: normal; font-variant-l=
igatures: no-common-ligatures;">Andrey
</span><span style=3D"font-family: Menlo; font-size: 11px; font-style: norm=
al; font-variant-caps: normal; font-variant-ligatures: no-common-ligatures;=
 color: rgb(255, 255, 255); background-color: rgb(0, 0, 0);">Shinkevich</sp=
an><span style=3D"color: rgb(0, 0, 0); font-family: Menlo; font-size: 11px;=
 font-style: normal; font-variant-caps: normal; font-variant-ligatures: no-=
common-ligatures;">
 &lt;andrey.shinkevich@virtuozzo.com&gt;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 11.0px Menlo; color: #ff=
ffff"><span style=3D"font-variant-ligatures: no-common-ligatures; backgroun=
d-color: #000000">Tested-by</span><span style=3D"font-variant-ligatures: no=
-common-ligatures; color: #000000">:<span>&nbsp;</span></span><span style=
=3D"color: rgb(0, 0, 0); font-family: Menlo; font-size: 11px; font-style: n=
ormal; font-variant-caps: normal; font-variant-ligatures: no-common-ligatur=
es;">Andrey
</span><span style=3D"font-family: Menlo; font-size: 11px; font-style: norm=
al; font-variant-caps: normal; font-variant-ligatures: no-common-ligatures;=
 color: rgb(255, 255, 255); background-color: rgb(0, 0, 0);">Shinkevich</sp=
an><span style=3D"color: rgb(0, 0, 0); font-family: Menlo; font-size: 11px;=
 font-style: normal; font-variant-caps: normal; font-variant-ligatures: no-=
common-ligatures;">
 &lt;andrey.shinkevich@virtuozzo.com&gt;</span></p>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB5048BD6CC01492C36FA6D5C1F4F00AM6PR08MB5048eurp_--

