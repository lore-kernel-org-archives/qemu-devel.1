Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F01C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38A32075B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KcihkD23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38A32075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhBU8-00062b-44
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 08:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhBTO-0005bT-LS; Fri, 05 Jun 2020 08:29:22 -0400
Received: from mail-vi1eur05on2095.outbound.protection.outlook.com
 ([40.107.21.95]:59072 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhBTN-0000M9-46; Fri, 05 Jun 2020 08:29:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzYnN15iBy+DuPJl2ClkA4jtbOKdOzxTEUC412h2CXGCln2GBYQ7vOsVlHMopj2zuu7XXw4xFv8/A3etpuH0rfsm+N7YAspqnF5EmwwdhvWk9guc8tC4YX9Ibgax3C4qY9eBnczNndqb8lgAYqGFN+FW8sOsgmCmv+vVgn6uw1n37DUeYqf2t3XzW/LrIwzvfY7Sx3ihmVLVBN10pnzdcgANFK17cYsF1VXyghyCG+mGzwB8c6vd7SZJDvJu61kqJGeqQEBhFGAQNaxgRTxALwlJ/3JhOiYHktWEuAKuvHRabd2hMYrQuUwrbN8ZKzKecz6FIGA5FFrUI9ODqqw/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Xp8hG9JtdqzdlihkLFy13RCqSLNcUOFpdC7BWE4vGs=;
 b=k+AEbhgOWjqcCYFOcYXVrlRsgc81UYeWhSMFS81eMdkytwo3zA4IGUIattwX20B+vXV7IalLfeEnkR4epm7V9iv0fb2JuGX4vmRapxzgxBCOfXMPJEQ4FTrV/Q2CblG3B88OQK/Y8c0ljNoS+Re1ZjqeUfsmaj8zAZctKopu5bIt0g1tXlwo4Q9aiJ1H1eyt/LqpyOpKccdyIL2IkKqlX5u6WFSiWoefZdoRs8DqlaYrBIx5oqmckAWxi20rFjoe7vjQlkGIFToTq4WNaGomL0/27RKgyaVYktY/+bIbdQNmhAdQCmZ+kyaHBJ9GGy1RT9tdclqfZyxocf8dtIDGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Xp8hG9JtdqzdlihkLFy13RCqSLNcUOFpdC7BWE4vGs=;
 b=KcihkD236lCONehnwYX+Fwm03W/RThsaYm0QC6dXTaj+V2M4fOPuaCJtinJjESBWjiAXa7K2xQJjt7JYDEs8Z2cxi6zTXZTesjh61+RIOqzDuyrPsHIA1XibPBPFNIcqmpaqKPQKmNw19Ga4yWeMfRenKx2JxvYMG9A1i3fYBTs=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4152.eurprd08.prod.outlook.com (2603:10a6:20b:a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Fri, 5 Jun
 2020 12:29:17 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 12:29:17 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 07/12] qcow2_format.py: separate generic functionality
 of structure classes
Thread-Topic: [PATCH v4 07/12] qcow2_format.py: separate generic functionality
 of structure classes
Thread-Index: AQHWOpdw2OBDPv1/70OPnvaU2KRbR6jJ8lBa
Date: Fri, 5 Jun 2020 12:29:17 +0000
Message-ID: <AM6PR08MB4070FDB41EB8996982EEAF1CF4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>,
 <20200604174135.11042-8-vsementsov@virtuozzo.com>
In-Reply-To: <20200604174135.11042-8-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [109.252.114.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff0d346f-f603-4d7b-111e-08d8094c109b
x-ms-traffictypediagnostic: AM6PR08MB4152:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4152607A61E2CA4E80A0CED0F4860@AM6PR08MB4152.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qP36Be9hZIuXjLedlW+klqtNeThRdSRaOMbnVWnM6ImMLxbosoSCIo70a9ejCWOWC4yyWCQmUFgmFnjIQkQmQQbnXzBQHrqozzs24f8gnJ30rehCHZt5KpUKDZZ8tHBfYiNicWmtdMfyNc5Dh/3aOHfi8rJo/sR0fRx76+xH3y+sNp8ehTAAiat4c8xJRexJJDStGLhhtL2DMX4ymGsJ9/KGP63h44nW/Rd9QFvJYuo975PFOk4kDXUxFd21ttrVfo4D+E0Cly7xd6R4qFzFeziOaazvYg0uTvD/WBWZ7mUOYGZqDipkUs3Sqc/TEKLw7sjKPgYM0kB82XFCu73tZFk3x60I1ZB4bqYjYCY62wQpBut1vSCAie7DCr0Hm+rs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(376002)(396003)(346002)(366004)(26005)(44832011)(5660300002)(478600001)(8676002)(6506007)(76116006)(53546011)(186003)(91956017)(2906002)(8936002)(66556008)(64756008)(66946007)(33656002)(54906003)(66446008)(7696005)(71200400001)(86362001)(66476007)(83380400001)(52536014)(4326008)(9686003)(316002)(55016002)(110136005)(107886003)(41533002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Zmke/aAUMtDY2u2OVH3xQng8yx+jAcGETxWHCpLqA4ZJ8QSSw3+aQOV8NxU1AOpaF73qXFim2YtlROQb4oM7f2P01WvuY4H4bb9eZdfWQ6wnrSce0DMU/Uj6NwIHA7O3XHmULjnM2F+awowaGzJL+xI36tcvr9fWYA3TtyYvtB2lJkEbaBDY5nN6wemLWwfWFLkj7bSXyGQuw3q+LloLSQAjTMOA8wIXRjflT3JFeWqT4ljRjAd97yS2f1o21/Pz9bRlz1Eg6Kb+gACN1nP87Y4f3flZ7Pbfw0Tph1QcCRk3+RW8tpmOej/vFLOBMyR1zf/KqPeKyPUjEwTgzDACxhA/32Uxi5ijWRN0RqfacRZnoRBoSe5IggSAFmWBV7dnNYh8URQQkKCp4zNk83Q84foSXre3px5L17uNQ4QChm68YTXfr/BePLy49xDC1j3Ynp9tnV4rtxxVF0aSp0MBiVguwyywCUAgeHML3IAoYP+k3jsbTsyf+PTuYTn08Ot/
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB4070FDB41EB8996982EEAF1CF4860AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0d346f-f603-4d7b-111e-08d8094c109b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 12:29:17.2598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHG+jLciY5F0DJfeHKtSC04yw4tQbweNSYB7GjpUc6BpSIlmmos37ACexry2IMfoJftY5+iRnf4Mr51y+QlCoh9mmvy2zFtZLg1zjQOq8QE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4152
Received-SPF: pass client-ip=40.107.21.95;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 08:29:18
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

--_000_AM6PR08MB4070FDB41EB8996982EEAF1CF4860AM6PR08MB4070eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Two more int types in the comment?

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
Subject: [PATCH v4 07/12] qcow2_format.py: separate generic functionality o=
f structure classes

We are going to introduce more Qcow2 structure types, defined like
QcowHeader. Move generic functionality into base class to be reused for
further structure classes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 93 +++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 35 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_=
format.py
index 1fd9473b7f..d71f578377 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -2,6 +2,62 @@ import struct

+
+class Qcow2Struct(metaclass=3DQcow2StructMeta):
+
+    """Qcow2Struct: base class for qcow2 data structures
+
+    Successors should define fields class variable, which is: list of tupl=
es,
+    each of three elements:
+        - c-type (one of 'u32', 'u64')

u8, u16 ?

--_000_AM6PR08MB4070FDB41EB8996982EEAF1CF4860AM6PR08MB4070eurp_
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
riant-caps: normal; font-weight: 400;">Two more int types
 in the comment?</span></div>
<div><span style=3D"color: rgb(33, 33, 33); font-family: &quot;Segoe UI Wes=
tEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif; font-s=
ize: 14.6667px; font-style: normal; font-variant-ligatures: normal; font-va=
riant-caps: normal; font-weight: 400;"><br>
</span></div>
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
<b>Subject:</b> [PATCH v4 07/12] qcow2_format.py: separate generic function=
ality of structure classes</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">We are going to introduce more Qcow2 structure typ=
es, defined like<br>
QcowHeader. Move generic functionality into base class to be reused for<br>
further structure classes.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt=
;<br>
---<br>
&nbsp;tests/qemu-iotests/qcow2_format.py | 93 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------=
--<br>
&nbsp;1 file changed, 58 insertions(&#43;), 35 deletions(-)<br>
<br>
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_=
format.py<br>
index 1fd9473b7f..d71f578377 100644<br>
--- a/tests/qemu-iotests/qcow2_format.py<br>
&#43;&#43;&#43; b/tests/qemu-iotests/qcow2_format.py<br>
@@ -2,6 &#43;2,62 @@ import struct<br>
<br>
&#43;<br>
&#43;class Qcow2Struct(metaclass=3DQcow2StructMeta):<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; &quot;&quot;&quot;Qcow2Struct: base class for qcow2=
 data structures<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; Successors should define fields class variable, whi=
ch is: list of tuples,<br>
&#43;&nbsp;&nbsp;&nbsp; each of three elements:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - c-type (one of 'u32', 'u6=
4')</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">u8, u16 ?</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB4070FDB41EB8996982EEAF1CF4860AM6PR08MB4070eurp_--

