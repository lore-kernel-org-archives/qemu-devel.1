Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2434CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30B0206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Nx/v7ShX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30B0206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhExx-0007ix-6N
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhErK-0006lM-3p; Fri, 05 Jun 2020 12:06:19 -0400
Received: from mail-eopbgr00105.outbound.protection.outlook.com
 ([40.107.0.105]:7808 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhErH-0007NP-FX; Fri, 05 Jun 2020 12:06:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/Yj0deTYds38Hyu/MLkE8rTHWhfzP+7czeZsO1R4q0nCGn0L74AW2Q4ESNurxh44SlktuYHbyXijrWqhbmFicckT9rE5bDY5bihHo7OwOBs/azX15OoiNJ9x7MVMUdPvhboVX3tB1F9cOiMKzSqBhyqrEDkZLrwJVGQD2jN9872VV0Nco/lrnD7TTGCdLCqesySLKOMsGFu+JzETBgeXsO4EmGLQjojqGMhmK57sPCzx5uiqAUR6a9498yEf36RmjKlNDQtT71+uuUh3yVMSaIRA6bbCBlTWKaQIEANX5kuzWiey9+GR/gdLkol1iKPeF83Gx12c9LkG4vvubj+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/fTBLGoLFI311eSgw5Mzt5IAjkVF4+uFYH8SLbwtYM=;
 b=MKtfhfElwUIGZEpR8vfCLxTezo07J8+olrLfPjxqa0SHyQQfIotwb/GPpX5lk1XcV+4wIZ6cQuc9w+6kQ0cI4aR+U/hkl0shUOsrnfCqlORE5lvTMKTrU19YYt9oHtHXAHd4Fp1l/75tA8YgRfpI37cIAHMAJ+ItI2yNASJXOqLpOqQMJYHUaj1EbAyLcjFkMXyBzC8Zt+b4J18+0QidHkTc9wo+/W1YMJtQf0fOkmbamoRB1AEQeiDMCcI72dc9A2dS9HETT0k35VAl6VWWhMLp2wZPuYKMgT5Kj27I/EPruipBwaTO3pwx7bdindCwubjVY/A/J/rgCGWlcOjmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/fTBLGoLFI311eSgw5Mzt5IAjkVF4+uFYH8SLbwtYM=;
 b=Nx/v7ShXbip8GtGMqlrsqlOmiiGIewaJoIxAZAWoSw4Z4CuzcBnllr0+VJ4m1jRwdP+toZgRa7ZRb5DIGnGiZ76eR7A0vOxu89ITso71GZpL5FlMkZuGMKV5tDl9PQyuR516cBQ5zgQQ+UoVSHlvKObHCJcLaV6/O9e5REpoo+Y=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3512.eurprd08.prod.outlook.com (2603:10a6:20b:4f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 16:06:12 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 16:06:12 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 12/12] qcow2_format.py: dump bitmaps header extension
Thread-Topic: [PATCH v4 12/12] qcow2_format.py: dump bitmaps header extension
Thread-Index: AQHWOpdyXfTZwhVkvkCElissUCy/mKjKMP41
Date: Fri, 5 Jun 2020 16:06:12 +0000
Message-ID: <AM6PR08MB4070910BF52176ED25D1BC58F4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>,
 <20200604174135.11042-13-vsementsov@virtuozzo.com>
In-Reply-To: <20200604174135.11042-13-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [109.252.114.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04342a84-c8b0-4ef0-a27f-08d8096a5e6e
x-ms-traffictypediagnostic: AM6PR08MB3512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3512AD360EA9D22985A1BB2CF4860@AM6PR08MB3512.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tGL7JjgdrRnVXqBCLT6c7B3/qLFGmdME07ldA8qoPNjsOAjnYooN8rpEluQu5kEhKp4WCb8i2S2yWeM6+pFnCQ6+YXPjFqAGWV0rMimFZ/IXjc0vh+ZEiZXix6exhrqPN04EoB8f1YTD7Dj08d3EwmENzq2HTjaFMFtbLmDt05k09eR4HtzgGFnm56TJ1A08VjYIITw4psU7CuvdtUM+g2d1s9FjaRNVAqLQ/q+gE6VFwAlYgSvMRzVQfisw1uChulmPD4fpz7fMytI5KD6IIJ8/sBAN4Fl8DDiQUF/xP4pzdkJokXa6ur2iye7dNQXFtsHhKucoSQTjd/8uI96dUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(136003)(366004)(346002)(376002)(83380400001)(478600001)(55016002)(110136005)(66556008)(26005)(71200400001)(66476007)(9686003)(316002)(8676002)(4326008)(8936002)(2906002)(54906003)(6506007)(64756008)(44832011)(186003)(5660300002)(33656002)(66946007)(107886003)(52536014)(91956017)(76116006)(66446008)(53546011)(86362001)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Wvj3LhIXmYsV73Vsv7h2isyIEUDMH4vfzbCxvkuk9jKqg6hEhLOMxqPC59Tt8IMpghl8ZFpUjVk6ov1vuPSUt1HMvegaXjvrd2mxPlU9xJ+IPZUwpkVLDzxFlvhbpqBdn17p0iUXlxU8HRgW/+PX1/79/dfpTZz8ernF+5tokNXLPKhulFg9T6FOHmvGk951qUMyxdnjLbiUNE2mH7KnnP5Oi/JsID2vaIhu5v5nzDTE+4ztHKO/7/YwnRPkm/SWGsJRHB++iIFNvZJ8eljlkhtcVaCfqsjJUM1BEhpic3Yoi1S269GALHNYPH9x75XCYVqWdkc+n1LRxLPxgsVwF7n5k0kLJPHF/gOxVCHavlq4uYl7haM4yuYAaswwfCCybGy02V4OUNzBIUByoV0heO1SUMKZbXoIZ17QVw2lshaRRqO96CPS5OBlvxwv3xCNu6gbJUb2gaOaU2u11IR3egWR2y7w6A9Roztl234L0cecoawCV/hRlCrs2Mzn8i2R
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB4070910BF52176ED25D1BC58F4860AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04342a84-c8b0-4ef0-a27f-08d8096a5e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 16:06:12.7697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c5LLy36OdVVgfK/JKXiREaO0T8quHbUi6TFKEUGFqv9Yi2tXqk1/YkiaZA4Hg4C7UsQCwE12mj0s6jG9/HnrmseZ/oY5WIyP8dzKDfrNFTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3512
Received-SPF: pass client-ip=40.107.0.105;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 12:06:13
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

--_000_AM6PR08MB4070910BF52176ED25D1BC58F4860AM6PR08MB4070eurp_
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
Subject: [PATCH v4 12/12] qcow2_format.py: dump bitmaps header extension

Add class for bitmap extension and dump its fields. Further work is to
dump bitmap directory.

Test new functionality inside 291 iotest.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/291             |  4 +++
 tests/qemu-iotests/291.out         | 33 +++++++++++++++++++++++
 tests/qemu-iotests/qcow2_format.py | 42 +++++++++++++++++++++++-------
 3 files changed, 70 insertions(+), 9 deletions(-)

--_000_AM6PR08MB4070910BF52176ED25D1BC58F4860AM6PR08MB4070eurp_
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
ize: 14.67px; font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400;">Reviewed-by: Andrey
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
<b>Subject:</b> [PATCH v4 12/12] qcow2_format.py: dump bitmaps header exten=
sion</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add class for bitmap extension and dump its fields=
. Further work is to<br>
dump bitmap directory.<br>
<br>
Test new functionality inside 291 iotest.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt=
;<br>
---<br>
&nbsp;tests/qemu-iotests/291&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;&#43;<br>
&nbsp;tests/qemu-iotests/291.out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 33 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;tests/qemu-iotests/qcow2_format.py | 42 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;-------<br>
&nbsp;3 files changed, 70 insertions(&#43;), 9 deletions(-)<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB4070910BF52176ED25D1BC58F4860AM6PR08MB4070eurp_--

