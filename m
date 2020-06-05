Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4227C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D72F206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dkIwJDti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D72F206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAev-0008Rk-OV
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhAeI-0007xQ-31; Fri, 05 Jun 2020 07:36:34 -0400
Received: from mail-eopbgr30106.outbound.protection.outlook.com
 ([40.107.3.106]:19878 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhAeF-000507-7n; Fri, 05 Jun 2020 07:36:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O463PR/QXEnUei/VxoOjtbBzqpl0Ijj84x84rdJy5i6SjLWZMSg7hbz+GLmfAsoQHBKMJ6gLVJN7AOLIuqy0sNPfaGQW7hHeKl3K0Afe/3M9JE3NYwL37r21l20b5QCeYP5m0Ahy0JJ8THnqJzNtRaVm2wunBwqZxNq/TzoDanJj2hdVtkBTYCMAF52meOWRB/G4MpRedRR6+ZLMf2R6d104n/lvDdqVFUrCyQeN4tEaafr1t1iicbzzknauiahNaKfxA4fwz4Rm1yeZq+ampoyMAYHaSXyBYI5Rmt9eSyPUXLOou2Eig1X97TYrhtSUdlEbrz0u7SSuuMBvAdHWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFj+8UpNX4tAAKu9YMgxdMgNnavwfqUSCHzWI8dUb7Y=;
 b=CYRcYkSGRfjpt7UNzU+U5Ra29yMXnm728f5KXoY4OmWP3+7rVOkVVsb+U1ml6tLitCdPakHGynM6cgxyGWj6HE5hfkZVIlOMXO9y8DDw1wj7I/lT59O8yhZWWyrHbXo7MrXz0XwQ+vX6AcygAKCP9oDGnELd8cAaV2b2JylZbuqcxf1O0RCd9K7/4qnrM60EcgQ1azrFM+0J9WlqnHl5OL+9pcEhbDxetJYKLWbVmR/ln6wyyu9VaMtD4WqobsG0d4wT4X5U6A8u++2SYntCxPajs9IRT80IIhyuLOTVy7Gsu6qLxLRxvcJwR9Og2x0NCL+0R9LsdZaahDhJtEsixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFj+8UpNX4tAAKu9YMgxdMgNnavwfqUSCHzWI8dUb7Y=;
 b=dkIwJDtiYnpPAu6R5sW4tzsBZ8B2B6kdo82nQb89OIw77Y/ejwoW0FRB0AUsesWzG4W09GlKYWyJ3g1RkMsCd6/QJoypy+Bvjo3QV+pTm3R6hDnhb0pVD5BcZe4VYc5XeVIgrac75g2wmi6H13ssW98jjzHYF/vLdgVePAuW+b8=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB2967.eurprd08.prod.outlook.com (2603:10a6:209:44::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 11:36:27 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 11:36:27 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 06/12] qcow2_format.py: use strings to specify c-type
 of struct fields
Thread-Topic: [PATCH v4 06/12] qcow2_format.py: use strings to specify c-type
 of struct fields
Thread-Index: AQHWOpdvLXgmQz4yjEKWFG9o3MasH6jJ5c99
Date: Fri, 5 Jun 2020 11:36:27 +0000
Message-ID: <AM6PR08MB407095A89EFF45353DFEB615F4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>,
 <20200604174135.11042-7-vsementsov@virtuozzo.com>
In-Reply-To: <20200604174135.11042-7-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [109.252.114.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58ee988a-0ae2-42d5-bf53-08d80944af54
x-ms-traffictypediagnostic: AM6PR08MB2967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB2967B3C348654449D024756DF4860@AM6PR08MB2967.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rDtcU5m9drkTveDtVlccfqpfu6npXeFSK5fuHe1UObF5DfOgA2P8opiq7gjO5weOvgcKMJTExUxrzPYz+iR2CTmj6pLQXur/brr4F5GCpOxxya13xp66BtoZ+SBNaLHbCTARxQ2OR4PXw+KAOVzK/9WdG9gPattPkkB6kfzrFspdbBlfcLULJGl9w3Ouk//pluWsAYR5NImzrxs2Iihkjsq2ZhD9XZ8AQ+1xDbpZlteKCMviAHZ5H6IoEjZsdiEiScvpciK4GDSxF1/kinP54ZlXKWodI1OvRNnLrvp3Ap0aZ315a2t2N9kfL9NMtird
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39840400004)(2906002)(86362001)(53546011)(110136005)(66476007)(8676002)(8936002)(66446008)(66556008)(83380400001)(64756008)(316002)(54906003)(91956017)(478600001)(66946007)(76116006)(26005)(9686003)(5660300002)(33656002)(44832011)(7696005)(4326008)(71200400001)(107886003)(55016002)(186003)(52536014)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: bWkE8IoDqTNmcwownHT/T2pvDcq+VwfgQ9mN4/eVGqa0FH0tje9D74rfzjJipvvV1C5eBBPGwWRgmaopnTC2jjyuXBNfHHSokegmQxcrnk7isNc2TiD4y05zQaQBYCxLi7GxMwEENkBh6ptI4WeBd6XcsNH1V2+6YJ5ZMdfOm0c+uicBvqhchdMcIN2+5hMqNtFmQqOdfN+3wlRCNYBSaCUJ0XhKwSOUHqqQ8MbaW8ML1EjSjqPJVJod4ZLiMntsLevnOzDLMvrdboQlQM/9PKNR1kDJsmQJhXb5B8n59OGhEuL/j11sXkOwco2p94ZjUAIZJIiElWzTGCfDC8fXGQU17RTPXrhDtzkr8K5t30dtM6po8Dhd+Xc6+/kVoHv2KCchdmzpMxVMcm6ZMKSXtqd7MVApQgTHSiDjh80Z8ERyuao5u1xCcBuSQ24CGb2DwRmGb0TBPhh88yfvFiHA5/Um7Ol/E/tCA04DaCJYz97h0bsFnKPrhWQeqQnQvc3e
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB407095A89EFF45353DFEB615F4860AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ee988a-0ae2-42d5-bf53-08d80944af54
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 11:36:27.5398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ISA8IwBWVgEOQ7YWiTGYE14wqPM+c1RcJJMqMyC7fUtbVu8dLX6Do8ickNGjd3bzLHBKkTiCg/sscJLH3Jk4qtMf4NxrH5veMfhu3UhQ0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2967
Received-SPF: pass client-ip=40.107.3.106;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:36:28
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

--_000_AM6PR08MB407095A89EFF45353DFEB615F4860AM6PR08MB4070eurp_
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
Subject: [PATCH v4 06/12] qcow2_format.py: use strings to specify c-type of=
 struct fields

We are going to move field-parsing to super-class, this will be simpler
with simple string specifiers instead of variables.

For some reason python doesn't allow to define ctypes in class too, as
well as fields: it's not available than in 'for' operator. Don't worry:
ctypes will be moved to metaclass soon.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 50 +++++++++++++++++-------------
 1 file changed, 28 insertions(+), 22 deletions(-)

--_000_AM6PR08MB407095A89EFF45353DFEB615F4860AM6PR08MB4070eurp_
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
<b>Subject:</b> [PATCH v4 06/12] qcow2_format.py: use strings to specify c-=
type of struct fields</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">We are going to move field-parsing to super-class,=
 this will be simpler<br>
with simple string specifiers instead of variables.<br>
<br>
For some reason python doesn't allow to define ctypes in class too, as<br>
well as fields: it's not available than in 'for' operator. Don't worry:<br>
ctypes will be moved to metaclass soon.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt=
;<br>
---<br>
&nbsp;tests/qemu-iotests/qcow2_format.py | 50 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------------<br>
&nbsp;1 file changed, 28 insertions(&#43;), 22 deletions(-)<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB407095A89EFF45353DFEB615F4860AM6PR08MB4070eurp_--

