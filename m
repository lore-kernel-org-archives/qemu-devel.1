Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E824FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10AA206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RZWN3lwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10AA206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiESq-0007Ab-V0
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jiERz-0006Et-V9; Mon, 08 Jun 2020 05:52:15 -0400
Received: from mail-am6eur05on2091.outbound.protection.outlook.com
 ([40.107.22.91]:7840 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jiERx-00045z-G8; Mon, 08 Jun 2020 05:52:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIdNsLJKCdmy1x5TZM6qXKOkPqsivHVW05yOgqcyR2w2Twxn7zHrx8GH1zVa3WIQjm6Y+NVJ4K9NFVCoLPwZqk8rDFTZthLfxWPjFdcO8mWjNNA3T9vzXAkOhJ8N7WCFO8wJFQx878uWO8ixotfEYj57bcW8ZcELDrdbqtOs8ZZomQXKkhLyZLAFweVzMtKeEg3AJcW/+CBPbdZU7YF9l0aS3T9X5CVECNQH5BdRVgril+w1vL48fKV2uX097oaHhECiQJCC39YsqXKI5CbkKhX1e8cihm2TQCNB7Ng2bkbRlI85O9KxB+2S+3XR4/BNCjD88Uq3vRpeSsrGxpLWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpSQN3JrnibluVFYbzwfoDXAOxaxV+QNiP8hnWwGl8A=;
 b=XOd2euPGE1+AkoyZIX1wUhUPfZJVhMAS1R7T/9xdYxh10QzKg0nwqM/8ALy13Nma86oBemuSWfPy6GvUVG7CJ5LVVtyJ+laH6M4qPs/gFPfEwW28zYNxTvGIvaVlIqZBgm9+4Q44aWBIMQiqljWw1SGzUmvfZd37D8vThygPUOa8qYfCfDYiIpM8qrkaHwHQIIrkx/cV6iUNQVWOErCHk1+guvlNM/Ua24zNCD32aGQR2FaAmquLEk94qb3p75KMER+KMbvxmCfg6KNMQ6pC1KWTc30FDM37ducCz+5YY1pFXeujsxEVgxQc7C1UuDsdhiM/bwqvtiaHpWWpJs2fXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpSQN3JrnibluVFYbzwfoDXAOxaxV+QNiP8hnWwGl8A=;
 b=RZWN3lwUC2FazTStCrFtQWOmzROWO9k7ft0ZtZKXL/iRQq6k3O4QdcZp6v/pTM8EjDPJ/HioFqVlc7AzDKbcc5zhxWLs99tpNl2XFctwOHE0j1FOrbjDjucge62fh/SbKqkThoj3oF7j6aHW/xBxFg0iVO7SCg1Htxbm6LlcWBA=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4469.eurprd08.prod.outlook.com (2603:10a6:20b:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Mon, 8 Jun
 2020 09:52:10 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 09:52:10 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 12/13] qcow2: QcowHeaderExtension print names for
 extension magics
Thread-Topic: [PATCH v5 12/13] qcow2: QcowHeaderExtension print names for
 extension magics
Thread-Index: AQHWO9sQh+oMXy2mWEmAdvXrPnkkoajOOAVtgABEitA=
Date: Mon, 8 Jun 2020 09:52:10 +0000
Message-ID: <AM6PR08MB4070ABE5DB45F47AB85D3716F4850@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200606081806.23897-1-vsementsov@virtuozzo.com>,
 <20200606081806.23897-13-vsementsov@virtuozzo.com>,
 <AM6PR08MB407028BA3B40A5CAE37C21D6F4850@AM6PR08MB4070.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB407028BA3B40A5CAE37C21D6F4850@AM6PR08MB4070.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [109.252.114.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05808213-fca4-48b5-47c0-08d80b919d00
x-ms-traffictypediagnostic: AM6PR08MB4469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4469BEC8314F3702739A85B1F4850@AM6PR08MB4469.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 54PtskGVPiZnhHH9ODRaNh1h9OxZGtwhIpkr5uFCv5eWh4sRKEGEDQQsJijpGkNPOizBh1HjXTqKqqnAhOXuvSxwpZza472NWyA735Hhee1/IMBWCojyIgMBaNy8HWYleCLVY8H+eEJbW5Yb5PAzGvD17dibIckfBdpKDqbI2+sYGjaxdMDdvfdMoM9zdmfrwz2skfeFYBlDLks7Riw+liwEs6DknksSdAk+yweDgGwd3rdFmk48/tveUqhiVohG49VTjvlmdFZr7K2gmxNTmN/Oiib6O4SyuehvSqrx/fLG2mnqAcgX0IzSUWwGqnrr/u1DQoFdLk3oYDcfZBFS0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39840400004)(136003)(366004)(396003)(346002)(4326008)(2940100002)(52536014)(26005)(66446008)(7696005)(44832011)(2906002)(33656002)(9686003)(186003)(66476007)(8936002)(91956017)(53546011)(76116006)(86362001)(107886003)(66946007)(316002)(83380400001)(8676002)(6506007)(66556008)(110136005)(64756008)(54906003)(71200400001)(55016002)(5660300002)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 8qO73AiDF7A4QDiuEGO/9p1xO0dEcyeXLcGaq4jFLSwqO9P1ZuI7KlBXYhSLcjiWm6wzUOeS6iekY1HHXLv6MV/7l8uc/mG07KzntVVz05hL1YWf7WnCB9TvrjLYSu8rNTRgT/1LogMnSsWmR8W1kYVWgXEMMOU24xA/c5FYyqJiSjkwS5vZ7HV/oJ3s+W+PvxmiQpSxOhirmJKfe/k2xQfrYCCF7RGSRSDQnnv1nXXXlt5Mi+Gr9r5mO5axxhjxx7+G+QpHEFBMRgaZB6YW8i/AyQ6jQiSZPdIF6DAxAI3hvAq6/rrI2OCBO2l/01hyAYf9jEA20FHwWwJ5IYVWzVHnO9YsML2mDFg4SXPDAdEc7Sb1KRxbB8DBp8DX512fzd6vg5B4eGrvYyX0O7IgTH/aIE3kqhQwTDjzdvr3cHYuI8138GzBr/QBTBiuaTKm+SzGkjeufklRABjSJo0qCAw1LmVDcWaIIwG3xxLWA6qC8TP03rRuUI060cQ91PYj
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB4070ABE5DB45F47AB85D3716F4850AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05808213-fca4-48b5-47c0-08d80b919d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 09:52:10.0422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wmwUaZqX/PkyBxXMNUsdVyjJlQEFxvPkDl7ohGHSsjD07WBzMsvyDe4YI0BWpDIPLSYUm7ksPM9ohlwcqqckrfBZcoFrgOPn+2D01pemc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4469
Received-SPF: pass client-ip=40.107.22.91;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:52:11
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

--_000_AM6PR08MB4070ABE5DB45F47AB85D3716F4850AM6PR08MB4070eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



________________________________
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Sent: Monday, June 8, 2020 8:48 AM
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>; qemu-block@non=
gnu.org <qemu-block@nongnu.org>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; mreitz@redhat.com <mreit=
z@redhat.com>; kwolf@redhat.com <kwolf@redhat.com>; eblake@redhat.com <ebla=
ke@redhat.com>; Denis Lunev <den@virtuozzo.com>
Subject: Re: [PATCH v5 12/13] qcow2: QcowHeaderExtension print names for ex=
tension magics



________________________________
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Sent: Saturday, June 6, 2020 11:18 AM
To: qemu-block@nongnu.org <qemu-block@nongnu.org>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; mreitz@redhat.com <mreit=
z@redhat.com>; kwolf@redhat.com <kwolf@redhat.com>; eblake@redhat.com <ebla=
ke@redhat.com>; Denis Lunev <den@virtuozzo.com>; Andrey Shinkevich <andrey.=
shinkevich@virtuozzo.com>; Vladimir Sementsov-Ogievskiy <vsementsov@virtuoz=
zo.com>
Subject: [PATCH v5 12/13] qcow2: QcowHeaderExtension print names for extens=
ion magics

Suggested-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/031.out         | 22 +++++++++++-----------
 tests/qemu-iotests/036.out         |  4 ++--
 tests/qemu-iotests/061.out         | 14 +++++++-------
 tests/qemu-iotests/qcow2_format.py | 17 ++++++++++++++++-
 4 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_=
format.py
index 32371e42da..40b5bf467b 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -39,6 +39,12 @@ class Flags64(Qcow2Field):
         return str(bits)


+class Enum(Qcow2Field):
+
+    def __str__(self):
+        return f'{self.value:#x} ({self.mapping.get(self.value, "<unknown>=
")})'

I've got the error E0100: invalid syntax [pylama]

Andrey

The script itself works. Probably, my python syntax checker is obsolete.

Andrey


--_000_AM6PR08MB4070ABE5DB45F47AB85D3716F4850AM6PR08MB4070eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div><br>
</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Andrey Shinkevich &lt=
;andrey.shinkevich@virtuozzo.com&gt;<br>
<b>Sent:</b> Monday, June 8, 2020 8:48 AM<br>
<b>To:</b> Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt;; q=
emu-block@nongnu.org &lt;qemu-block@nongnu.org&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; mreitz@redh=
at.com &lt;mreitz@redhat.com&gt;; kwolf@redhat.com &lt;kwolf@redhat.com&gt;=
; eblake@redhat.com &lt;eblake@redhat.com&gt;; Denis Lunev &lt;den@virtuozz=
o.com&gt;<br>
<b>Subject:</b> Re: [PATCH v5 12/13] qcow2: QcowHeaderExtension print names=
 for extension magics</font>
<div>&nbsp;</div>
</div>
<div>
<div><br>
</div>
<div><br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Vladimir Sementsov-=
Ogievskiy &lt;vsementsov@virtuozzo.com&gt;<br>
<b>Sent:</b> Saturday, June 6, 2020 11:18 AM<br>
<b>To:</b> qemu-block@nongnu.org &lt;qemu-block@nongnu.org&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; mreitz@redh=
at.com &lt;mreitz@redhat.com&gt;; kwolf@redhat.com &lt;kwolf@redhat.com&gt;=
; eblake@redhat.com &lt;eblake@redhat.com&gt;; Denis Lunev &lt;den@virtuozz=
o.com&gt;; Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;;
 Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt;<br>
<b>Subject:</b> [PATCH v5 12/13] qcow2: QcowHeaderExtension print names for=
 extension magics</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Suggested-by: Andrey Shinkevich &lt;andrey.shink=
evich@virtuozzo.com&gt;<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt=
;<br>
---<br>
&nbsp;tests/qemu-iotests/031.out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 22 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------=
--<br>
&nbsp;tests/qemu-iotests/036.out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;tests/qemu-iotests/061.out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 14 &#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&nbsp;tests/qemu-iotests/qcow2_format.py | 17 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;4 files changed, 36 insertions(&#43;), 21 deletions(-)<br>
&nbsp;<br>
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_=
format.py<br>
index 32371e42da..40b5bf467b 100644<br>
--- a/tests/qemu-iotests/qcow2_format.py<br>
&#43;&#43;&#43; b/tests/qemu-iotests/qcow2_format.py<br>
@@ -39,6 &#43;39,12 @@ class Flags64(Qcow2Field):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return str(bits)<br>
&nbsp;<br>
&nbsp;<br>
&#43;class Enum(Qcow2Field):<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; def __str__(self):<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return f'{self.value:#x} ({=
self.mapping.get(self.value, &quot;&lt;unknown&gt;&quot;)})'</div>
<div class=3D"x_PlainText"><br>
</div>
<div class=3D"x_PlainText">I've got the error E0100: invalid syntax [pylama=
]</div>
<div class=3D"x_PlainText"><br>
</div>
<div class=3D"x_PlainText">Andrey</div>
<div class=3D"x_PlainText"><br>
</div>
<div class=3D"x_PlainText">The script itself works. Probably, my python syn=
tax checker is obsolete.</div>
<div class=3D"x_PlainText"><br>
</div>
<div class=3D"x_PlainText">Andrey&nbsp;<br>
&nbsp;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_AM6PR08MB4070ABE5DB45F47AB85D3716F4850AM6PR08MB4070eurp_--

