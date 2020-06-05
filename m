Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D3EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F34B2075B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qHfuksoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F34B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAPY-00079T-IF
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhAOx-0006dP-C6; Fri, 05 Jun 2020 07:20:43 -0400
Received: from mail-eopbgr20116.outbound.protection.outlook.com
 ([40.107.2.116]:41379 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhAOu-0000mB-PL; Fri, 05 Jun 2020 07:20:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiuF1gMxpsn8tBFIGXayNzYWlp8xGYQdoUSSgTFjq1xBilUpwxrGFzWAXFqPCGwC7kzw6o13XajNNy3k9nWQzY4Cx+viPyk1Fz3mYdVBLvl9ZWfMgrySdoETTBZY5f+01LeKqn4cpRbdAYCzT5msJLHodzhcDaay5Wa2i7hDprVNCGEi9fHu0wtKrnsCh15DpXHDfPnmVvM1wDDGXDcdGR6kP/PrF9PmaOHquVPPsPa3dQpBAJz5zBGaLLlsZveRFaq/WdSdCngjbIQoD1sxjJX7EZGy99P1oAPSv6dZ2yJHlYi8Ehz9tRgoEoAvjnIdwfuXOKDAc5hjsw4dXKK4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OeI+P5moIOvH5iP37832p+Ylt12QDJjwe2zMm2cwIo=;
 b=mtx/al52DudnN13AUuqUtkfLT5WwYOdHPZoqk1MmAQEnHI1NBPPwrSCbli84AA+r+D6omJZcTQw3FOpcNTJfudnwrFr4+Grlx35xwhO0S7KPIN8P06Z0EZEPBoyu22xipqmOpNjZ7jhHyGqp8XTiYtB5NSBjyt8LUVLUqYGTSzagF0L6DqAwqEOKXadK4iqI8QY/sVHD8LWZncZTykOkxddRJcuUSH5KM6Ai2YhKQj1XZ1uWT/RSfp76K7fItk4L5tCK8vg9hnya4U15TkdwvpNYDkDWwb1wlrYF/JWzKtPWUBoSsLPpMtMxZaBhx2IGrNStshyVBwX8AjL8ZF9jxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OeI+P5moIOvH5iP37832p+Ylt12QDJjwe2zMm2cwIo=;
 b=qHfuksoyiK4Q1KCagZRe19UimPrYwj20ngebf5Y9Udqby5xDdGXCY5lMaFDl1oUjkxUPQNJhfWSkIAzkmai002VHTRDLBtwiuxgo1oEoREer2kavYw4wXF6V0dBx4Kv0KkBvxD6KaBbAWENvYeDSIiAgPuAdO3oo0bEmmPENia4=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3992.eurprd08.prod.outlook.com (2603:10a6:20b:a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 11:20:36 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 11:20:36 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 04/12] qcow2_format.py: use tuples instead of lists for
 fields
Thread-Topic: [PATCH v4 04/12] qcow2_format.py: use tuples instead of lists
 for fields
Thread-Index: AQHWOpdvDZ37+O4qYkG2OEgMeT3kOKjJ4VOT
Date: Fri, 5 Jun 2020 11:20:36 +0000
Message-ID: <AM6PR08MB4070D79411C860B242058B8AF4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>,
 <20200604174135.11042-5-vsementsov@virtuozzo.com>
In-Reply-To: <20200604174135.11042-5-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [109.252.114.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea5c09ca-ee90-4c9b-6cd4-08d80942789b
x-ms-traffictypediagnostic: AM6PR08MB3992:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB399264848EF1CCEF0A8099A6F4860@AM6PR08MB3992.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fgxpVL4QnR4DwSpqbpnbVBigFo5//NI7n9yyzcQ1FUfhZ930KAwPX2vrvZUFKfcJT8MkjmPwfKYHvf9PTK+V3WIfoHHUEWSb1fYGd+zgKgGgsTSPcxx41mviq4qAbeKZd9RtXascsZIdmdEIS4WZtQlB05rtSiR+tysf66k6Ie3gQ7H5tAEiOxf/pPs+fM/xq8jlRFpRz5KCfvxsgJ5KiFGOLPn177j0DrykRKh4xl16Pt0kzfTpq7ZoI0KwACvXvggFatx2V3iEYmqQS6iPRSIB1iu75DJzu42giyN/NfK24IbUiVolURF4RpcYP6jp4Fx3N2kElmDigBEe1cOKnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39840400004)(366004)(136003)(396003)(346002)(76116006)(8936002)(4326008)(478600001)(86362001)(83380400001)(44832011)(8676002)(4744005)(5660300002)(33656002)(66476007)(53546011)(71200400001)(316002)(186003)(26005)(66946007)(55016002)(66446008)(66556008)(2906002)(52536014)(110136005)(107886003)(7696005)(64756008)(9686003)(91956017)(6506007)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: sPX7vAdPQzGPi/1EUGXXMHrwiwQ0ztIh5vt5IVoRt80z4J2GF85Oy0V1iDapIo9HnTO9tQFwMXSpIxzdVdl4Dv//kQ9+RLN9hoAR+OFHErsFacRj4y2JMGijbxXlSe7NJ8yesqc8LJcl/b8Uu+jxkZYkbxLlELIrUBQUrFyYwRtGR2mMcSLt2/Eprb9z4K+y5KhdfGj48i4M03SSvU16ee0Yi+kU/3JkK7kw3CwlEyhobAga4na6HGkV65UPT0im0y7O3U/RMnA+T6NZmODEaY7gyTW1+gjeDLUh5P2rXxybip3MPpY/o/AYDkADQ3uP7L3goK3KQ9HtRFvzlRvYDK7NQ/lFW9HfvVlccCKQJ+Kmmw3MqsI2QdZp8HTUv06CooVLx3Y8ny2hkTDrTaSBTAYUt2qXKjClw6wAQ82g31r7pSL7P2UU1LoQpyrcQtWORJsngYV6XDKfXG/yT3zBekDxW6VoGsrF2YdK49/O6IF4AtaSsTVxRNDPTOJtppoD
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB4070D79411C860B242058B8AF4860AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5c09ca-ee90-4c9b-6cd4-08d80942789b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 11:20:36.7469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aqxlBoJv2+8NdCTBdW8ppgQXgLKMvZtWO9uuqiPfOuKOJzLVvuo4HXXAIIMPdAEMawb8ixgohch/+XSMCmwXwCp/cK9PJAQ8L9zG+rBdmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3992
Received-SPF: pass client-ip=40.107.2.116;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:20:38
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

--_000_AM6PR08MB4070D79411C860B242058B8AF4860AM6PR08MB4070eurp_
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
Subject: [PATCH v4 04/12] qcow2_format.py: use tuples instead of lists for =
fields

No need in lists: it's a constant variable.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 40 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 20 deletions(-)

--_000_AM6PR08MB4070D79411C860B242058B8AF4860AM6PR08MB4070eurp_
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
<b>Subject:</b> [PATCH v4 04/12] qcow2_format.py: use tuples instead of lis=
ts for fields</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">No need in lists: it's a constant variable.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt=
;<br>
---<br>
&nbsp;tests/qemu-iotests/qcow2_format.py | 40 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------------<br>
&nbsp;1 file changed, 20 insertions(&#43;), 20 deletions(-)<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB4070D79411C860B242058B8AF4860AM6PR08MB4070eurp_--

