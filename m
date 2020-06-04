Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13503C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 07:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6ABB206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 07:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GOo+EblM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6ABB206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgkiS-0000ZI-1z
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 03:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jgkhg-0008TS-2k; Thu, 04 Jun 2020 03:54:20 -0400
Received: from mail-eopbgr60104.outbound.protection.outlook.com
 ([40.107.6.104]:26691 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jgkhe-00070l-IT; Thu, 04 Jun 2020 03:54:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uhu/XK52ReOxgZEtFq6QDFjxq6xkUEiXnq+pKCNbSadhjw4qHwCLY8vnc//optWhkBpNuLDVUOdcl9L36svASiWVfTmaMdjseaupMJn0Awh6bhrKQ1XeN4HquvjxtyjYaMKVWpw18PGj0dvKuIBYtisXA8e/bbfCViHrgTw8GqnSJ+OYLSVvmD2QkPewQ+abUqOK1QThFGw2SPpkJuFujLkQ3BkGGFsS0DYHNxLFBlxrHclb1bJwzttrhzi9ucmfVZQPjlEqimvVouZ/kGJh6OkquAxzCh7gOQfv3g5s0pwPWKFGxUEHOsXUFwCnDov97GNfbESFS3jg39m2N+U7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VlvT0hH3+iNmtzOytnGwCzosE0k1YjNPqtYcWTe/vw=;
 b=IE8Pt/Qhyoig9FpTTpM2pLyYlsYqNI7hFIyiWZ3bLYU8x0d+B4P0hIvUAiN3BW7QBa192jA9xaw+PpkZ3dWe6byiR4djElGQT3yYJjMlnC6Uo3xXOahyf7mXdfaYiTw4ru7kEVOl8i+W1bc64c7wqdC9PBb+nWCodi+yswPAsCqDSQY3XLn9FDsTheQu7U7tpazBwC5eTnx/ctUAep1CyaVbkIHgJVve6pY74nFV+21Zj6SVck2i7wkH5JSZRmV/x/woSDL/uIxgOMXOvk9I+vOrrwCeZWwT6exPNZUuzefyocBUDkjduSgEkH/ghCSWBI+tcvBO/MF9RdL9XckSBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VlvT0hH3+iNmtzOytnGwCzosE0k1YjNPqtYcWTe/vw=;
 b=GOo+EblMjLjWHCdeM6XSWAX/tOYz6Cz5bvXNQjtIFu/rdoDdj3gzABHdJSuJyqkPDnMtgI+W2ZwGTYGQMmAxLQJvQoWymGKYS+Eo4KLevcBykrz3llnaiJKrBiqWyWNtK/Sx8YOCre6/V8td0ztDJ4LOVuKGU3Wy4Cvzi19p2GU=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4359.eurprd08.prod.outlook.com (2603:10a6:20b:b9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 07:54:12 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 07:54:12 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 0/6] iotests: Dump QCOW2 dirty bitmaps metadata
Thread-Topic: [PATCH v3 0/6] iotests: Dump QCOW2 dirty bitmaps metadata
Thread-Index: AQHWOBtRrDpZTXfVsU+t0QZof/ObYajETAmAgAPNnB0=
Date: Thu, 4 Jun 2020 07:54:12 +0000
Message-ID: <AM6PR08MB4070E6ECEBD6B855A92313E0F4890@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>,
 <0df8d1a7-6f72-48a2-0433-cdf1c5e97492@redhat.com>
In-Reply-To: <0df8d1a7-6f72-48a2-0433-cdf1c5e97492@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
x-originating-ip: [176.59.39.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21d7dc99-d67b-4262-1bbd-08d8085c7899
x-ms-traffictypediagnostic: AM6PR08MB4359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4359C90CB70A3C032FB69BC9F4890@AM6PR08MB4359.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5R2PSkIoi4LH0joJm9xC/g+pmERFPiYGWp95m/CPCvUYJAbjpH69h0v++Yjx5KXUyd4IHbCbpoWctQbH8mt0n61yJqjucmy/fpDuBXl6YYRTv8ecDK5Kdx2Yc/A7c1NtnhZ7EQwA1xGs70XiHeADnBdRcam4ebfvlKqM70vnMRDtIlTYJvM2sXCYHypv6/zthXz8krAfnMZjd54J3Ml39Nw90NwzPQXOmoIUPuNJnh27Ti6IrkZScejhxgLKrC6/b/W9Evez9WBMrQzeD4WaUp2+HvMEnpbIAr0e/C0I/NKCG402NFqUvrknZ/rsFvrruhsckNO06zBpcRd0cNdTx82WgVmb5jDz62+xXTmSWLMw5Nr1Jq9XseBcymk/2Fth
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39840400004)(136003)(376002)(83380400001)(53546011)(110136005)(107886003)(2906002)(44832011)(316002)(186003)(26005)(4326008)(52536014)(5660300002)(71200400001)(7696005)(9686003)(33656002)(54906003)(478600001)(66446008)(86362001)(6506007)(76116006)(55016002)(91956017)(66556008)(8676002)(64756008)(8936002)(66476007)(66946007)(14143004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: +o4Af6ycKiGW2LdYlNfVGdsuay28Isn5L23Dh+tFZvQJ4WV61G0OceiwaUBRF+x4HOhyhcISMHScMMNyg2A1Hb7DhmF7q4Yt2KfJjz0Knj6GErzo0WGbCP51v9WVFy3xJOzTUP3eUEEdXXATjnYIWcuLKi7DsChj/kPa+g+0iV+QjuetQBtOgXODFgi0Xy1KufM/2N2JPlnWE3bdSF26w9VpfKbDlTEHxDac9s7YN/IW/gIbrSFPb1FcVXztWX7qvppT0CMFXTqD2qAtVpJZ1QMRxKQdO7ZVDT9WFE6Ow3Sosu+ffHpyz0y/DqqHN3VjTQZjr8LK0WYtQnnQ9FhWxZIrdxgYZZbw013HtSxMfJM3gTbjeMJAzdPw6oUdaNkIDKWMgLWFgn9yazY216iYDyVp9Emta0lmXdg96/HmDAEheokqi5fgXOG1OCeG23xu6Lg4THaDWjsnld+4stbKgnz39C+bQrp4eXnqKD3gc7Q=
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB4070E6ECEBD6B855A92313E0F4890AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d7dc99-d67b-4262-1bbd-08d8085c7899
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 07:54:12.4969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Csu0BGt3tFTypIVhbjlikOICX/WwHjcP//vCQUFJV+jZvSX5QMVR5Ct+kDGxDfG969KQ6Hq5+0A8VLkbt7DEGIiO2aCYY9L0H6ORtuNsWYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4359
Received-SPF: pass client-ip=40.107.6.104;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 03:54:14
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM6PR08MB4070E6ECEBD6B855A92313E0F4890AM6PR08MB4070eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thank you very much dear colleagues for your collaboration. Your reviews co=
mments are well noted.

Andrey

________________________________
From: Eric Blake <eblake@redhat.com>
Sent: Tuesday, June 2, 2020 12:46 AM
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>; qemu-block@nongnu.=
org <qemu-block@nongnu.org>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; kwolf@redhat.com <kwolf@=
redhat.com>; mreitz@redhat.com <mreitz@redhat.com>; Denis Lunev <den@virtuo=
zzo.com>; Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 0/6] iotests: Dump QCOW2 dirty bitmaps metadata

On 6/1/20 8:48 AM, Andrey Shinkevich wrote:
> Add dirty bitmap information to QCOW2 metadata dump in qcow2.py script.
>
> v3:
>    01: JSON format output possibility added.

Also, you split it into a series.  Thanks; this makes it easier to
review each step :)

>
> v2:
>    01: Refactoring of the Python code in the script qcow2.py.
>        New methods were added. The bitmap dictionary was instantiated.
>        The all of bitmaps information is read completely before
>        printing the dictionary.
>    02: The outputs of the tests 031, 036 and 061 were modified.
>
> Andrey Shinkevich (6):
>    iotests: Add extension names to qcow2.py dump
>    iotests: move check for printable data to QcowHeaderExtension class
>    iotests: dump bitmap extension data with qcow2.py
>    iotests: Dump bitmap directory info with qcow2.py
>    iotests: Dump bitmap table entries serialized in QCOW2 image
>    iotests: Dump QCOW2 image metadata in JSON format with qcow2.py
>
>   tests/qemu-iotests/031.out  |  22 +--
>   tests/qemu-iotests/036.out  |   4 +-
>   tests/qemu-iotests/061.out  |  18 +--
>   tests/qemu-iotests/qcow2.py | 338 +++++++++++++++++++++++++++++++++++++=
+++++--
>   4 files changed, 346 insertions(+), 36 deletions(-)
>

--
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--_000_AM6PR08MB4070E6ECEBD6B855A92313E0F4890AM6PR08MB4070eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div>Thank you very much dear colleagues for your collaboration. Your revie=
ws comments are well noted.</div>
<div><br>
</div>
<div>Andrey&nbsp;</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Eric Blake &lt;eblake=
@redhat.com&gt;<br>
<b>Sent:</b> Tuesday, June 2, 2020 12:46 AM<br>
<b>To:</b> Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;; qemu-=
block@nongnu.org &lt;qemu-block@nongnu.org&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; kwolf@redha=
t.com &lt;kwolf@redhat.com&gt;; mreitz@redhat.com &lt;mreitz@redhat.com&gt;=
; Denis Lunev &lt;den@virtuozzo.com&gt;; Vladimir Sementsov-Ogievskiy &lt;v=
sementsov@virtuozzo.com&gt;<br>
<b>Subject:</b> Re: [PATCH v3 0/6] iotests: Dump QCOW2 dirty bitmaps metada=
ta</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 6/1/20 8:48 AM, Andrey Shinkevich wrote:<br>
&gt; Add dirty bitmap information to QCOW2 metadata dump in qcow2.py script=
.<br>
&gt; <br>
&gt; v3:<br>
&gt;&nbsp;&nbsp;&nbsp; 01: JSON format output possibility added.<br>
<br>
Also, you split it into a series.&nbsp; Thanks; this makes it easier to <br=
>
review each step :)<br>
<br>
&gt; <br>
&gt; v2:<br>
&gt;&nbsp;&nbsp;&nbsp; 01: Refactoring of the Python code in the script qco=
w2.py.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; New methods were added. The =
bitmap dictionary was instantiated.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The all of bitmaps informati=
on is read completely before<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printing the dictionary.<br>
&gt;&nbsp;&nbsp;&nbsp; 02: The outputs of the tests 031, 036 and 061 were m=
odified.<br>
&gt; <br>
&gt; Andrey Shinkevich (6):<br>
&gt;&nbsp;&nbsp;&nbsp; iotests: Add extension names to qcow2.py dump<br>
&gt;&nbsp;&nbsp;&nbsp; iotests: move check for printable data to QcowHeader=
Extension class<br>
&gt;&nbsp;&nbsp;&nbsp; iotests: dump bitmap extension data with qcow2.py<br=
>
&gt;&nbsp;&nbsp;&nbsp; iotests: Dump bitmap directory info with qcow2.py<br=
>
&gt;&nbsp;&nbsp;&nbsp; iotests: Dump bitmap table entries serialized in QCO=
W2 image<br>
&gt;&nbsp;&nbsp;&nbsp; iotests: Dump QCOW2 image metadata in JSON format wi=
th qcow2.py<br>
&gt; <br>
&gt;&nbsp;&nbsp; tests/qemu-iotests/031.out&nbsp; |&nbsp; 22 &#43;--<br>
&gt;&nbsp;&nbsp; tests/qemu-iotests/036.out&nbsp; |&nbsp;&nbsp; 4 &#43;-<br=
>
&gt;&nbsp;&nbsp; tests/qemu-iotests/061.out&nbsp; |&nbsp; 18 &#43;--<br>
&gt;&nbsp;&nbsp; tests/qemu-iotests/qcow2.py | 338 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&gt;&nbsp;&nbsp; 4 files changed, 346 insertions(&#43;), 36 deletions(-)<br=
>
&gt; <br>
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
#43;1-919-301-3226<br>
Virtualization:&nbsp; qemu.org | libvirt.org<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB4070E6ECEBD6B855A92313E0F4890AM6PR08MB4070eurp_--

