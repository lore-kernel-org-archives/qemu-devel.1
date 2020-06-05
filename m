Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4947DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2203206F0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YOEWsUBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2203206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFPw-0005dY-59
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhFPM-00058Z-5l; Fri, 05 Jun 2020 12:41:28 -0400
Received: from mail-eopbgr130127.outbound.protection.outlook.com
 ([40.107.13.127]:17155 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhFPJ-0008IN-KY; Fri, 05 Jun 2020 12:41:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7X7Uqqw9xmVnrBHAyjRohJK2/ZhL3u0WO6Zp+sgJ8GDdEFqMViElNfAK1KzFquikhZAHqlPBWR51ZHC3i/MafW0fSzn56tZGIoKy+m5U9SVnk4p840KcQ2HPh/o2lM5JPItQS3nBKuBH4W4S7bygEAeXOG6ibuhLqDTs2UrY36Wkc4kVrhLABvfCv+OUTLiS93Q2BR+xjBDvAMZSP6QJUWcmrgqeHXhQbEunmPb7/yK7zaFcRaYCT0vNJSOmX+NJAImcYnXDit0599mQFDTVcQJhWPY6F6AFblbIGmGiOk7OPjADInZc9oihqum2xasaYyi3udlB7FQ/O+FQmwJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+6BTce3okbR8ST/P4aaiweKou26BjN0kkymwQlGBII=;
 b=AKffY22D3y4X1o7GycVIvkPeC40q8nP5pu8/Pg6ATvCNTTu7+0SBBqPL8OBkq35tZWmC8+wktsra7kAT+Ty3A+anUy+Zi8kh41QyBq7UV2LcVY+uN05to00cZfx/kmeJLq8ubkV1PyLKrZ/RR6jcDZ8XfMgpTOGBJ2BpVOp1L+UEx/6dSkBodz/juRQWXnvGO43qRSTDXADigShtbXvLOCNC5iVsjutpzSWZkgmhbICtSMk15l6HlQeKdM5UCYNF+hoZH5UAGOaVTdmyHoEhfx9KS9HnXgN+A1KFSiK7+DgDpJtPe5j4y8mBnxTaB8uibcPyaRquA28rfZ3H7bnb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+6BTce3okbR8ST/P4aaiweKou26BjN0kkymwQlGBII=;
 b=YOEWsUBfpqxSHxSzeyYPGlL6dvfhLWbczs+4z0pXSTXgHfSPn0Gk/+nOCW+Qw3r+YdVeexatw92vjtiRzQb3EecLEMe6XrnhHzxuNFd3mkL7+pUFB0lNnid+DXpbgrUoQeb3inFxFJ6SvcKYazDGe6uQYiqOUEKSUEaxRmZkNgU=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3943.eurprd08.prod.outlook.com (2603:10a6:20b:a0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 16:41:21 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 16:41:21 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 11/12] qcow2: QcowHeaderExtension print names for
 extension magics
Thread-Topic: [PATCH v4 11/12] qcow2: QcowHeaderExtension print names for
 extension magics
Thread-Index: AQHWOpdy6/Wb86tljUm8ajfBu7uJMajKNwWAgAADZ1Y=
Date: Fri, 5 Jun 2020 16:41:21 +0000
Message-ID: <AM6PR08MB4070C92A0844806E2056B859F4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>
 <20200604174135.11042-12-vsementsov@virtuozzo.com>,
 <4e04eb8f-c599-b7e6-4879-860a7ad8d7ec@virtuozzo.com>
In-Reply-To: <4e04eb8f-c599-b7e6-4879-860a7ad8d7ec@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [109.252.114.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bd3b024-9476-4fc2-7df1-08d8096f475a
x-ms-traffictypediagnostic: AM6PR08MB3943:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB394330581B4A68601793AFF3F4860@AM6PR08MB3943.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mv96USktDG8NKxfqhq1bcm52sswoUcs1uH7dkXtx6QOwwQ88vQlbu8CkvyN3FNzHxFgQVJVUXKsE38UUbvWkTxxjttcHoev7NhRlVteppqV2TdJNuYVhr2ziRsOwMu3K1i+H/pmJDtmf3Iq9/JfJrhDAC1mC+t8iP93lyog3r7ScRbzx1+5StTbKQ34QKfZhA18BSw4cu6h+VlYOdcxa44oDGEwK27hw61pPfjZQy3EtWRI9RdUAmB4V3F8dcM169LNPnAh22HM4lA9+mMFhmBI9w9594XcgQzX06r5SdGdRVVNOE+ICxIZKb4K8aKsCqMozblWiN06yaYhUBYNF3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(136003)(366004)(346002)(376002)(76116006)(7696005)(33656002)(5660300002)(186003)(6506007)(26005)(86362001)(52536014)(4326008)(83380400001)(66946007)(54906003)(2906002)(64756008)(66476007)(71200400001)(91956017)(107886003)(55016002)(8676002)(9686003)(44832011)(53546011)(8936002)(66556008)(316002)(66446008)(110136005)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: gtkSQgykLACMA1BY405hraLNihUvvXc1WYbpp7DcfG09FnWxz2psTb6zGguXC7qov6Dz3sHC7tkpSmjfW6ziiIlLj44z6vMvMCyCBhbGK9zBTTVep4nX0JSqjf2qmx5GmyDwl1SEwOd85qSqdpSju+bH07iXHujR2KxN2XYJrhlmrcE9/4ziyqPRE6n0M3wqotfSzW7skQeWKk7ZhiS3kdpZbVggswHEJQXIRI0OJgY+0FqvmyXxsa9blAGkuuyYPIlPSIhomhtfi3tazEWOHOPKujniqpcnl01MS4GCKVmNA0K1lQjlJ83T0IiJeozqBngGB5Jii9SmQ01Rz5KywgixQwpvbSZXamegg8ggL+CSyx8FitY0qAkDk/A3hYrAWaKsjOSAakrhwdrdKLE4STTKQrSFu8ZEjP/Oc5uePW5d4bdDHUlND8i7cCrdzNHcCcOLb0e76jGh+2/kGE0Q0ZDSjk8Mx/7wb86L4Cf0HnRFWFP/QJGetJ/wy1hr4Fjy
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB4070C92A0844806E2056B859F4860AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd3b024-9476-4fc2-7df1-08d8096f475a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 16:41:21.5208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CxtsJqusxTQEVNHSyoFNDQl/oW82W0+KwcEtVsHuG680cxZDgfze1E72MlXp/HMwIQIwYWFdpjr1tSGLYaMEghhMdB/drQJNY68tah8K4nA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3943
Received-SPF: pass client-ip=40.107.13.127;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 12:41:22
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

--_000_AM6PR08MB4070C92A0844806E2056B859F4860AM6PR08MB4070eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, but hex(int) returns str.

Andrey

________________________________
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Sent: Friday, June 5, 2020 7:26 PM
To: qemu-block@nongnu.org <qemu-block@nongnu.org>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; mreitz@redhat.com <mreit=
z@redhat.com>; kwolf@redhat.com <kwolf@redhat.com>; eblake@redhat.com <ebla=
ke@redhat.com>; Denis Lunev <den@virtuozzo.com>; Andrey Shinkevich <andrey.=
shinkevich@virtuozzo.com>
Subject: Re: [PATCH v4 11/12] qcow2: QcowHeaderExtension print names for ex=
tension magics

04.06.2020 20:41, Vladimir Sementsov-Ogievskiy wrote:
> Suggested-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/031.out         | 22 +++++++++++-----------
>   tests/qemu-iotests/036.out         |  4 ++--
>   tests/qemu-iotests/061.out         | 14 +++++++-------
>   tests/qemu-iotests/qcow2_format.py | 17 ++++++++++++++++-
>   4 files changed, 36 insertions(+), 21 deletions(-)
>
> diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
> index 5a4beda6a2..e0225f4247 100644
> --- a/tests/qemu-iotests/031.out
> +++ b/tests/qemu-iotests/031.out
> @@ -25,7 +25,7 @@ refcount_order            4
>   header_length             72
>
>   Header extension:
> -magic                     0x12345678
> +magic                     305419896 (<unknown>)

Oops, I've broken hex number. I think it should be kept hex, even with name=
.


--_000_AM6PR08MB4070C92A0844806E2056B859F4860AM6PR08MB4070eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div>Yes, but hex(int) returns str.</div>
<div><br>
</div>
<div>Andrey&nbsp;</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Vladimir Sementsov-Og=
ievskiy &lt;vsementsov@virtuozzo.com&gt;<br>
<b>Sent:</b> Friday, June 5, 2020 7:26 PM<br>
<b>To:</b> qemu-block@nongnu.org &lt;qemu-block@nongnu.org&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; mreitz@redh=
at.com &lt;mreitz@redhat.com&gt;; kwolf@redhat.com &lt;kwolf@redhat.com&gt;=
; eblake@redhat.com &lt;eblake@redhat.com&gt;; Denis Lunev &lt;den@virtuozz=
o.com&gt;; Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;<br>
<b>Subject:</b> Re: [PATCH v4 11/12] qcow2: QcowHeaderExtension print names=
 for extension magics</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">04.06.2020 20:41, Vladimir Sementsov-Ogievskiy wro=
te:<br>
&gt; Suggested-by: Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt=
;<br>
&gt; Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.c=
om&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; tests/qemu-iotests/031.out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 22 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;-----------<br>
&gt;&nbsp;&nbsp; tests/qemu-iotests/036.out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;--<br>
&gt;&nbsp;&nbsp; tests/qemu-iotests/061.out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 14 &#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&gt;&nbsp;&nbsp; tests/qemu-iotests/qcow2_format.py | 17 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; 4 files changed, 36 insertions(&#43;), 21 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out<b=
r>
&gt; index 5a4beda6a2..e0225f4247 100644<br>
&gt; --- a/tests/qemu-iotests/031.out<br>
&gt; &#43;&#43;&#43; b/tests/qemu-iotests/031.out<br>
&gt; @@ -25,7 &#43;25,7 @@ refcount_order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&gt;&nbsp;&nbsp; header_length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 72<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; Header extension:<br>
&gt; -magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x12345678<br>
&gt; &#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 305419896 (&lt=
;unknown&gt;)<br>
<br>
Oops, I've broken hex number. I think it should be kept hex, even with name=
.<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB4070C92A0844806E2056B859F4860AM6PR08MB4070eurp_--

