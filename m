Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8123EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEA9206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vgxiwNpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEA9206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDZc-0004ph-KR
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhDYy-0004IA-6l; Fri, 05 Jun 2020 10:43:16 -0400
Received: from mail-eopbgr40132.outbound.protection.outlook.com
 ([40.107.4.132]:42370 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhDYw-0004Cq-V9; Fri, 05 Jun 2020 10:43:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxX0/eo03rS7kmQoCPYLIxXDYSxGqratYnF0mQReaPDd/rlALhfuu5kp+NKLYowxPEDj/9ZPZOl/wJOVfPWlAy+3JwWtcUbZcx67rXAg7Qd3zsdabpe6p1gaTgFynDcDNYozYyV9/k1zGZeI/K6H4GI2YTzgfV52c1jCK18cJPLb6+2BdritpNkRFVIZIYZwCDs9RjeMQGDvxBVSqvsdPt+6lgIWxAGc6umHzBeEfTjJXAyeOVxWSi18/GVTMGLCreHUL7jcTu+G81vNf4VIxEbgcMIbPEfc5mV47eSbx/qzm7YprLRCWD7SOshQgGT3m2XcLgzb1xAASd/fxU4hjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b90YXvVFMQgCBbmW35vhDSALf/FPXweo3cj1pB0t5y0=;
 b=d7Ca4vRN6RlYNSAudP3kMa+yVIlc+v+1Or4iCLmcLLLpErQSG3K77FNVnvJdAHZ1t8CI2ILrY478X3aSAorzOT+bSvYrTPksjKrQFxHXt28TMB2RBVpUPOgKiy0zOUgFKF3lNlYIZGhv9KaSx9alHdurADXcHSOZxy3bU2OPdOVJvjBzbenGb5GPQFGdGuJ3UWoCxz5V74VqRp5JaMbKDFDG2Uc3JzVHENdtnRBbqQe01audnj8IULmvqwp2JtRIpmhzINwnLqRTNlQ3kYNa3/QwQhi6b+h2k+wMqd4Im4yaxN9RxQRNdA3gg4BaKHRQPiXIWNmx3prZ7msOYDmvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b90YXvVFMQgCBbmW35vhDSALf/FPXweo3cj1pB0t5y0=;
 b=vgxiwNplxzccOcDnBV7KTEfNWfLe5lilrzqpviIN+FvtOasTfZq0lyY2Z7NdIaSZax9/F8K4C4WDEHVSTg0N5g72NS/ofJY6ZUymzCs6A+wyV+vReYQZh/V/JqS0eu41LzEPSJeVJQuqXtAUC14ZHBv1k1AdJNIvdjoLeZan0Tw=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4616.eurprd08.prod.outlook.com (2603:10a6:20b:6f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 14:43:11 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 14:43:11 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 09/12] qcow2_format.py: QcowHeaderExtension: add dump
 method
Thread-Topic: [PATCH v4 09/12] qcow2_format.py: QcowHeaderExtension: add dump
 method
Thread-Index: AQHWOpdx7MokZqJTmku39GpZW1X9IajKGcPr
Date: Fri, 5 Jun 2020 14:43:11 +0000
Message-ID: <AM6PR08MB40708B2DF8DB9CD602BCE40FF4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>,
 <20200604174135.11042-10-vsementsov@virtuozzo.com>
In-Reply-To: <20200604174135.11042-10-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [109.252.114.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82e48d5e-3d8c-429c-202a-08d8095ec539
x-ms-traffictypediagnostic: AM6PR08MB4616:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB46160533BE89C10CD4D72C95F4860@AM6PR08MB4616.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rr85iHHGq33Tb+7oVCMNyKFnYQpV2XSA4k2/BdiDyot6bvLc14kp+Vb4Cr39zQKYrpbm+QUj9pQPjX1TWZIbQU1P+9qclWUTsJ76lQo0jpl302z/7TWE37GkjUjFnWCeb0ZnzjRFzHOHq4K5krOA+FDxOtVUXeh8GNyItULX1NZ/3jr/uwpiZjFk8bamUnylXSqikz9uNjB0aBOQ+oHMDD24JPzOFX8p+RrSSBJFfYXXt62shTBj3M2EvmhocG4jP4oSop7N74NR223/uOiUBj3bbYmzqR2bRaAq8MdvSxtxOjRNSlPJkT/gEvBaOPy79Idp1n5CSCOgZcIqe252Rg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39840400004)(366004)(136003)(396003)(54906003)(8936002)(66556008)(110136005)(316002)(44832011)(55016002)(26005)(107886003)(7696005)(9686003)(4326008)(83380400001)(478600001)(8676002)(2906002)(33656002)(6506007)(4744005)(86362001)(66476007)(5660300002)(76116006)(66446008)(64756008)(66946007)(52536014)(53546011)(186003)(71200400001)(91956017);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: GsKzp0GBQ4pFB5ugO472EA1T5xz8pZvnDpYrJfUyGQdF9MuMBV4cIg4Zas2weyOrItHwqGJu61Pt0szk7DOmUeSaVhyxAiL4UR1W0KKuyxJlxcJku5NIOFIAzGD9BVtzeyQSf0uWmJ58ncnGKsx2wZbCJyZUiNbH6hEHzD3qXPHmiHST5boS36QhTNLSe6YPLjHiJCYv8Tu2Ge+PoW6p1GkOcHBh1DzU/AGh/3D9d7u2hgwekgCZRJuk2oumTGKXIGt5CgTmxGpgzAhVXvy2tFTDc1SkH8tu/F9lC4AZeOP0AmgyImRhXqfR3mosGeF5VF6ZTUzXfnTpG1BNQ7UecJxVdcQ9K5I/Vh9oUo6kNn2MwAfZ/toSPA28VR6JUY1mG80tpRIPKMLyTRKkDBv9kB9SfgJX7uM7wHAv3dWUIbtDxViLHgYG9RAcz00oB1oW6I3MQkBkIBqcnhUsarS4Zey7K1OfNwwS71EDas0uLSB3a3KEj7XFlAaPISud0Dmm
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB40708B2DF8DB9CD602BCE40FF4860AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e48d5e-3d8c-429c-202a-08d8095ec539
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 14:43:11.2926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ry5kbaxhXjHdQZG1B5ASvCLNKmWu0nV9RyKLTxJ7uSmyf79GXzlGHOh2lrOiL7lIai8eOH9P2jWwYbnEv/v95OrEV0yc2mOZ+rNg0g0xao8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4616
Received-SPF: pass client-ip=40.107.4.132;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 10:43:12
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

--_000_AM6PR08MB40708B2DF8DB9CD602BCE40FF4860AM6PR08MB4070eurp_
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
Subject: [PATCH v4 09/12] qcow2_format.py: QcowHeaderExtension: add dump me=
thod

Obviously, for-loop body in dump_extensions should be the dump method
of extension.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--_000_AM6PR08MB40708B2DF8DB9CD602BCE40FF4860AM6PR08MB4070eurp_
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
<b>Subject:</b> [PATCH v4 09/12] qcow2_format.py: QcowHeaderExtension: add =
dump method</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Obviously, for-loop body in dump_extensions should=
 be the dump method<br>
of extension.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt=
;<br>
---<br>
&nbsp;tests/qemu-iotests/qcow2_format.py | 22 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;----------<br>
&nbsp;1 file changed, 12 insertions(&#43;), 10 deletions(-)<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB40708B2DF8DB9CD602BCE40FF4860AM6PR08MB4070eurp_--

