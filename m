Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85227C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 13:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F04C20663
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 13:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="q6JZ8o5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F04C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhCOl-0000B2-Gq
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 09:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhCNd-0007fq-SC; Fri, 05 Jun 2020 09:27:29 -0400
Received: from mail-eopbgr80138.outbound.protection.outlook.com
 ([40.107.8.138]:28742 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhCNb-0004cJ-Bc; Fri, 05 Jun 2020 09:27:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1H5H5Mb3++wsMBf1EARQDW1tjIDMQ9XL+C8jh2qYghOonxpTNGVgFIIMyxC0exczLo5+lNHZKRKPdNfuTIWIeTdWF3PM7lDByI4pmjFbMoT8Vtk27K1yogZYsWA93b4qIeO1AbL1VcJWqM/SaXpLoMliVBhFWhX0XEQ1pTpP3nVv0QLptAPXzhOOywDH0bDwTM3ZhxSfhDWixTHlxmHOeBMQBbtrF/7XNrPxsKT+mG6zzy8mCxY9HNjcmT8/ehfPIrBHrfy94gvvltrHOA5iOEOLn1WIBH0aOUeofTWDgrdRowJg0OFnBgCbiED5/3vHdRIJcV4JXT++wy4VueaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YwMmg2Cc5GtTPvWwd8CSFiyB0MGdxleMFWhUvVjVZ4=;
 b=TOc6QVRBjqX2bwEu4FWDLFhmu0OvtfFKKOpcbl5EFExxjE0fQLWGOleBwMmD8B8sKHdO3NVh/IZaCQUiQEE0+H3XSkPJRWl5eW6cIyx86f0k5mpnkovARZrLZfrk7+iNrJx+rVRsondoJ9rHhv9C740OmhoKJFR1oLJM3UkdnNpZGjeV8ommsFTbn8lvB1RTqsQHn5dT9QyS7oxS8fDiLrJcE+tHQDFAb1CFuVNs9EPzsbh3eDFgz+9ELq7PCV17mxiaK+hyAR/L/knmrMEMC2NTmkedDb9fdQbkuhuMpeHCEi/DDmqh5zlKiWOV5IJQc4VhJkMmA/pxTarSeeqfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YwMmg2Cc5GtTPvWwd8CSFiyB0MGdxleMFWhUvVjVZ4=;
 b=q6JZ8o5/zOpJtrx0R81IfbkeJnR+/0nTXmiDCOt1ltu1nnBJjQtVsJqSjpFkkrID6sYOIdtbg7U+X0u8JyAPWwFQqAAGPTK6xohBLEHZpnI2aDSu7XxOu8VIqpvzyRBUIhQRCazVVifvA6TnE4i0Y3W9X3PF2HjhqhnxGNvajmw=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3429.eurprd08.prod.outlook.com (2603:10a6:20b:49::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 13:27:23 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 13:27:23 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 08/12] qcow2_format.py: add field-formatting class
Thread-Topic: [PATCH v4 08/12] qcow2_format.py: add field-formatting class
Thread-Index: AQHWOpdwt5ZtqCPFS0GSdBUSfQgYyqjKBE27
Date: Fri, 5 Jun 2020 13:27:23 +0000
Message-ID: <AM6PR08MB407040A1B65B031124763EBFF4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>,
 <20200604174135.11042-9-vsementsov@virtuozzo.com>
In-Reply-To: <20200604174135.11042-9-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [109.252.114.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba919c82-0fec-4054-4859-08d809542eac
x-ms-traffictypediagnostic: AM6PR08MB3429:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3429BB0BB8C7630D26BAA700F4860@AM6PR08MB3429.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lnz8OYDPIjueOGEro+xmayQCvRPfEkb+HdbANborMTesH8FNObOxoOIAwDNcnm9LP7/E5hFZPcO8/I1z911hllzdO5/H1hn2Ln5wP/5cqIBdO58SKbEhZxUncF2w3eQYlZJ5r/0dkrwOHaMRhJdZo3NSQesQiwARKEJjmL7F9Oz5TXJujpjrXuIBeIm/MZn8Fs1Rh0+udDLi9Y/GITwj8moUHArjiFRiljzl/8906sawEPc2nXqL2YgBF1zAnCMbkizQffphfmzunxqAYDCF7ShZf7PKLVpePs+KArjPiJzZFY7wQtCHpzeyhfMdvkqv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(396003)(39850400004)(136003)(76116006)(91956017)(4744005)(316002)(66476007)(66946007)(64756008)(66446008)(5660300002)(478600001)(6506007)(110136005)(54906003)(53546011)(33656002)(7696005)(86362001)(44832011)(52536014)(66556008)(8676002)(4326008)(83380400001)(107886003)(8936002)(71200400001)(2906002)(9686003)(55016002)(26005)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Q1ET9fzBCi2bBkkhE5R5J6LQhG+ZPbOSBk+jeDBBeK4Id4HBZ0SqUA3kY1qTZRjhJLJ3qm/lap7mxRaOhttFMY1BAJ5wz9aMPfFCI+6x8DcjeOBlIDyHb6gl2n1KARf1H/y2O3QPv6D8l/kcGyebmFcpTjbkkttXzUPV4poRQMCnRRBPrHyliEPtAtb6UYcptzRvevwLgkkeNT5JVK520R6T1KmxsVoJYOLsPK4j9x7agkpiDK6iwH9W3uKvbHbleojf1pOJ8/uHoD5wCb5/gr7RIK2HJY4gOV/Y+xE7qqg6qAdZRXhtJqNp//JBX4Hoj/CrkK6gvQdPcWNVcuCJKPvDgFNT1DGU6iVkbJufEmeaBUeiPlWvtzd/bu7cDmyUBNsLFbZWVcmsyQVBvSsJ4trPvxKLWg+YdjKvKZX7gm3sQi8VEFvHBCFjz9RLbhbzPRVVG0tD/zQDoJBEckefSjO11tV6JiPvXTIzWzy/NHLlfaJDD7TAP57KYN77hvPO
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB407040A1B65B031124763EBFF4860AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba919c82-0fec-4054-4859-08d809542eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 13:27:23.7141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOuuhpwNvXWqmuKFynf+6dCBc7HLdxDnt0huXlRok5jzexcPLxjAh8xJkcECkDt6sOAC2ohMjIwPpHMgs2SAvIsIzpQqf2ug5k7btafnNcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3429
Received-SPF: pass client-ip=40.107.8.138;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 09:27:24
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

--_000_AM6PR08MB407040A1B65B031124763EBFF4860AM6PR08MB4070eurp_
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
Subject: [PATCH v4 08/12] qcow2_format.py: add field-formatting class

Allow formatter class in structure definition instead of hacking with
'mask'. This will simplify further introduction of new formatters.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 35 +++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 10 deletions(-)

--_000_AM6PR08MB407040A1B65B031124763EBFF4860AM6PR08MB4070eurp_
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
<b>Subject:</b> [PATCH v4 08/12] qcow2_format.py: add field-formatting clas=
s</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Allow formatter class in structure definition inst=
ead of hacking with<br>
'mask'. This will simplify further introduction of new formatters.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt=
;<br>
---<br>
&nbsp;tests/qemu-iotests/qcow2_format.py | 35 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;---------<br>
&nbsp;1 file changed, 25 insertions(&#43;), 10 deletions(-)<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB407040A1B65B031124763EBFF4860AM6PR08MB4070eurp_--

