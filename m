Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0409C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D907206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mQxhDZ0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D907206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEKW-0007Hq-JC
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhEIs-00061D-Tz; Fri, 05 Jun 2020 11:30:42 -0400
Received: from mail-eopbgr80128.outbound.protection.outlook.com
 ([40.107.8.128]:2118 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhEIn-0007cx-5P; Fri, 05 Jun 2020 11:30:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVG7vT7DZ3HDev9vRwoS4VLNGNa98HgjiTZo5FE0Tu2sTx2nBupYeBvZQHED7Ew9lzq5xK28zKDChqtdzpIC036CMeBoiD3r/aPPeyTxtKCKRoGzjucOdAwE5efSWogHtjG00TTutIhYkg8HPON1xzjlK19C8wj8ZUodkKnpy2x3tEprfBti37QOdzPXR08lB7LORsx6lAs9kqEn7RQHU2864xBNgJpVAB7WBO21yn97l3P8M1DCzTDAG13DN8sffBaq1gyjcj1tv0JKcM69Hm4F4cXb7kjH3izj5SBcn9BSSvVUWXHL5m00LhTIpnewhUOfhqeJ1LliSsvImW6OOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgaEOQ5KBhkEj3GKBsF6DmCRt2Nzk8Y+l61JzSRo3qc=;
 b=FEBDB9jLhAn69H2l1Q9ucY5SOWqU93JXBwOvwa15pedDRFEUIRSg1C70AgbOKsttCEtQrL3qVhw1gd6TRnU2eOHxpCA7DqU9I2hBc2yAbSvR5D5+KM/z/4G0QO2BpIh6nrMp4yhVwvsZdVTIpQu1TuzvwVe5lowvc9sAxaVMw0VRo4AGWLTrkvzFUpyEqN9OU3rxjd6Z6stc3RDMWFyDQzPZLZJC6ruhNzA1GKa+GzsJnTM+vIL1AdEUeyMy12y06vYD8oxYEt2t9joUAYkqRO5XYdoBl+s2CMKXEqYSwj7/WzRpcN1tJkp6BZQaxB07NN1QJn7C0yr13bU1znH9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgaEOQ5KBhkEj3GKBsF6DmCRt2Nzk8Y+l61JzSRo3qc=;
 b=mQxhDZ0FLSpd4RypsPwo5gcDgAvM5nDNX6wZdi9p62kUSO8kDUnvYXu4gi9u46la0Fs27fQexEgqzTwKo8UK1W64Q0dd4fcx5M18UNzawogshD/GEuOqwESkXDxiSLAeKw7fXKko+sKNi694MGaQSMf1vLY6cpz5kcSmBK54QB4=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB5271.eurprd08.prod.outlook.com (2603:10a6:20b:ef::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 15:30:33 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 15:30:33 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 10/12] qcow2_format: refactor QcowHeaderExtension as a
 subclass of Qcow2Struct
Thread-Topic: [PATCH v4 10/12] qcow2_format: refactor QcowHeaderExtension as a
 subclass of Qcow2Struct
Thread-Index: AQHWOpdxYa89/GQSNEOGG00hVJ5xjqjKJi2T
Date: Fri, 5 Jun 2020 15:30:32 +0000
Message-ID: <AM6PR08MB4070C5919D04DB93DB108E31F4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>,
 <20200604174135.11042-11-vsementsov@virtuozzo.com>
In-Reply-To: <20200604174135.11042-11-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [109.252.114.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11ab6462-6860-465a-f9d3-08d80965630a
x-ms-traffictypediagnostic: AM6PR08MB5271:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB5271A39DE53212F54D8DA764F4860@AM6PR08MB5271.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tmlkovxZqI66M7UWt2e2VwG2psoSzRpsqKD94q6CfWOQb0rvgq2qUkResro+ydEbXQDMlgsZ9kGpaGui2JvvyGsBzsB5giLCD/4wtlYg/977erqPaA+IRki0pEpK+kzLPE7zN6UIVgkqq1hsVf0PARJg9kER1x2Md/sB/XQpO87vIDIgNS9CtS3XFlIJ5EEMLfzZujgMcH90GElU8bcEhAiABOH6b4L2qZzKhA/fqYexpPBgrFC/6dUjToIXN7pXLYnm+fufeUDcVda06LXrccp/7nEG+Y1RF/XyJV9bhlBmEixbGfmTEKwjSAvWRWxj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39850400004)(346002)(376002)(366004)(110136005)(86362001)(26005)(44832011)(83380400001)(71200400001)(54906003)(53546011)(316002)(6506007)(9686003)(186003)(7696005)(66946007)(76116006)(8936002)(33656002)(478600001)(91956017)(2906002)(66556008)(52536014)(66476007)(64756008)(55016002)(8676002)(107886003)(4326008)(5660300002)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Un7d3PiRx7b2QRdcD9/BdcdzL+T1i66naQMzK9yvP4+/JrtfS9PyRBriV/EBaR4bRnBt89SyIxKPzPd2mXn/GTUsM2ZS/1F8xsWHHqeujeooh5z5ANxlZUE6G0ZSMx274BsbbJs0QJCcIfa1wbNZ5GioeWFNPzcSnydsO3jL9tnKhpU6p5SQXsUoTS3JjFwKr3X5VzPGa1VvehRmOGff53Dsdqr2Da6pM5x2lJmWGzFVq3JyqDypqpLvZdGvo62uCW09+G0wyInytlxADwS0mTblGMoOYwyUA/Q9pS0eLZGejR2FFCB0fUg2UGbDTL9C6eujvRP0gc0DLlTnohJlm4rdzD9mIjpYGeUnCUkmazJnt2lT3m/MvUXXD8LFrRLR3W76LlWoXKCpdqidayzeanOymmbRCopYy3IPUlMxll4YwGbLoNz2FJfkLSXhk0+QjmzqwiRGXtAt1qXJ55hV9OXQTr7LkBWI7m8imRGZvGmZiGbtoc0qBzHs9rZHqjU3
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB4070C5919D04DB93DB108E31F4860AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ab6462-6860-465a-f9d3-08d80965630a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 15:30:33.0006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpP62MCiYUMkfQ2gAwaWM3yMyAdd9OJB1n3PYj5ZOuI2cZ8M+dR5ROU8gUTEZwvYGHoesRrBgC76RvB9ferL8qrtYqMvgphRCxTyPP3xoqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5271
Received-SPF: pass client-ip=40.107.8.128;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 11:30:33
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

--_000_AM6PR08MB4070C5919D04DB93DB108E31F4860AM6PR08MB4070eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'd add a comment that correct current file offset is the responsibility of=
 a caller.

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
Subject: [PATCH v4 10/12] qcow2_format: refactor QcowHeaderExtension as a s=
ubclass of Qcow2Struct

Only two fields we can parse by generic code, but that is better than
nothing. Keep further refactoring of variable-length fields for another
day.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 51 ++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 16 deletions(-)

--_000_AM6PR08MB4070C5919D04DB93DB108E31F4860AM6PR08MB4070eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div>I'd add a comment that correct current file offset is the responsibili=
ty of a caller.&nbsp;</div>
<div><br>
</div>
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
<b>Subject:</b> [PATCH v4 10/12] qcow2_format: refactor QcowHeaderExtension=
 as a subclass of Qcow2Struct</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Only two fields we can parse by generic code, but =
that is better than<br>
nothing. Keep further refactoring of variable-length fields for another<br>
day.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt=
;<br>
---<br>
&nbsp;tests/qemu-iotests/qcow2_format.py | 51 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----=
------<br>
&nbsp;1 file changed, 35 insertions(&#43;), 16 deletions(-)<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB4070C5919D04DB93DB108E31F4860AM6PR08MB4070eurp_--

