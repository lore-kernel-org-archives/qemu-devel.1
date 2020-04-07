Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9EBC2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 06:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB48206F5
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 06:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jjsddPAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB48206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLhY1-0006Ln-2S
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 02:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jLhXE-0005gL-Qp
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jLhXD-0004Uv-2j
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:16:32 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com
 ([40.107.7.109]:23846 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jLhXC-0004T6-G3; Tue, 07 Apr 2020 02:16:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmDGvOrtqSlaZFiWKxF8KzAdqjiHSHN6Oig7+1aY0OQhihECj7VEH2CNXPyhkISe1JKdoHkPVuwq8/1OeHyp6qnFcyQ1dDw9ynHrXAVegQDMgKlbGZVqxz6WSiVmMhjX4nCStFqP7ekjaRdvQR3yadyeG6dvNb7eiku3YpRPAjy4JcPlyM4Ag+P3oZfsd4uvbFv1i4wakAzvoovtVyc1dcLmKQufAX3XuOmWELIvChqRwhQfQUvHnLh8oiBn+RLQwZ0ARAtxHJ9MvvgigDsLmdCRyWVNKAsjOrTFQO3PFwx8wTsrLdiEBNk7eBx8jezG20XjwiK+vvSInDB3F6GlvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAp47Vw0WsqSGf8Rp/a8qZNNQ14vVAfRcnDo0AZVU/c=;
 b=A9+XIxwdBlKAgYVG9chWbB2fkLXOo2IKqNF8Q1y/Uk5p7kEEYEdWmIZmAFQC0sctuKnBMFZj8NTa5khq/Av6x98SngrlJpRhhva7m74BQklIVBBni8xFC2b0Wcn8oIAF9clhVVkyeK6IH+QQ5c8HXizJdiL8y8DZrJTUP4JgP8Au47YTlaNZ5b71tkxWL4HVdvpk2tXaq7c+UZCNMKU5cnVaYMtf52jGxogFA2ZzFDI81t/0fP6WsTXTbfy4UdQSGZCP0CXcTvxjVEKwB+APJoCkGz5PYEGD0PYyEIEder0jmWkQFbx8N7t0Ea2m+VLAh59wVs3QenI0grxffwzPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAp47Vw0WsqSGf8Rp/a8qZNNQ14vVAfRcnDo0AZVU/c=;
 b=jjsddPAn9MrjtL6ttexK/ZYp6MZevm437VZ7S3dpiEnfwcJPi2ItPNWAZPxUC6FLb/EFWGGOcYOxLU3a3+WlG9Agut+fUBZSFzaEX98OJCLnAixtrGHuTi26VM1Gi8hU+5tp4rmLLxeakde4D8s+dsxHsr10iNsK3VVpXSsYH+4=
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3030.eurprd08.prod.outlook.com (52.135.164.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.17; Tue, 7 Apr 2020 06:16:26 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5%7]) with mapi id 15.20.2878.017; Tue, 7 Apr 2020
 06:16:26 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] qcow2: Check request size in
 qcow2_co_pwritev_compressed_part()
Thread-Topic: [PATCH v2] qcow2: Check request size in
 qcow2_co_pwritev_compressed_part()
Thread-Index: AQHWDCB88p2wqMkMHkKOqJjxfSztq6hsQwAAgADsv/Y=
Date: Tue, 7 Apr 2020 06:16:26 +0000
Message-ID: <AM6PR08MB50485BA32FA4F88D896A17A8F4C30@AM6PR08MB5048.eurprd08.prod.outlook.com>
References: <20200406143401.26854-1-berto@igalia.com>,
 <w518sj8ppff.fsf@maestria.local.igalia.com>
In-Reply-To: <w518sj8ppff.fsf@maestria.local.igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-originating-ip: [109.252.115.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0477ba5-0a85-4789-7075-08d7dabb3409
x-ms-traffictypediagnostic: AM6PR08MB3030:
x-ld-processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3030A22361D1B9A944597EF5F4C30@AM6PR08MB3030.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB5048.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(136003)(376002)(346002)(39830400003)(366004)(54906003)(110136005)(6506007)(52536014)(53546011)(186003)(44832011)(2906002)(81156014)(5660300002)(8676002)(33656002)(316002)(81166006)(8936002)(4744005)(26005)(66446008)(66946007)(66556008)(76116006)(19627405001)(478600001)(86362001)(66476007)(64756008)(4326008)(107886003)(9686003)(55016002)(71200400001)(7696005);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WAEepy5NplbHsXxQKiMZcSoAViz0/m0AR2AEUATBzBDz/WzShC0mudDrwyqmuD6gFushcC/LoN4cYs3MH4LlZBX8kljXdqjNCFJicUdDoMDL05OxZMLOnE71tMxPEG7S50dq1XBX8wtTjVNio3QZ4Ygk0ojwQZS8UY7nUBISm9KtlxoYjO0aCoLUL/Vzki5BAh+tpPBrId6Rg5xipTt6saC2j9k1PDCWvtjRM8IayW1we0P2w+NxRacHjJD+5GIYj7i57UvjpvNz9dsMkxdNdJL0GY7AOyPqCFdz9RGPL/2gas3eo7wDK2ifQyui5O67a/N51XPWbbm5aO1LLwQ+Qy6zKx0tswSU/unsEqLdY5RnrqOy9epQbmioX7aEXgxz/eVyGWNpNYYHplhrqChID+AuKh6YyDlavKwoDE5otkul4K3TvC/CYzPG5028CjST
x-ms-exchange-antispam-messagedata: 7xayu4WwkOcGGrk9Qh86+XthQ+YFN0rLATXNRAvLhXDQ+VjH/Ug8nobBerhu4UgkhDjv9TacHrMvYgTw6JQZ+BjjMH1uox1J7AIHdOoyFmLo1UNKmrU1g+CKoeTrzhBGJpWkRW/3LoChclFC5fQpZw==
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB50485BA32FA4F88D896A17A8F4C30AM6PR08MB5048eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0477ba5-0a85-4789-7075-08d7dabb3409
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 06:16:26.2068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVDfT8K3LLXeZ3fbIBw2+CJAyQHQoVw39Y0EhzEGgXhSqwCF9OpQTHn68zh3VMQ0mv8cOidBqAJkjqXQDDaiH3rAOdAaOFz9MVO2YLma+yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3030
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.109
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM6PR08MB50485BA32FA4F88D896A17A8F4C30AM6PR08MB5048eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I wouldn't mind either.

Andrey

________________________________
From: Alberto Garcia <berto@igalia.com>
Sent: Monday, April 6, 2020 7:08 PM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: qemu-block@nongnu.org <qemu-block@nongnu.org>; Andrey Shinkevich <andre=
y.shinkevich@virtuozzo.com>; Max Reitz <mreitz@redhat.com>; Kevin Wolf <kwo=
lf@redhat.com>; Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>; Pa=
vel Butsykin <pbutsykin@virtuozzo.com>
Subject: Re: [PATCH v2] qcow2: Check request size in qcow2_co_pwritev_compr=
essed_part()

I forgot to add the "for-5.0" tag in the subject, do I need to resend
the patch?

Berto

--_000_AM6PR08MB50485BA32FA4F88D896A17A8F4C30AM6PR08MB5048eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I wouldn't mind either.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Andrey</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alberto Garcia &lt;be=
rto@igalia.com&gt;<br>
<b>Sent:</b> Monday, April 6, 2020 7:08 PM<br>
<b>To:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> qemu-block@nongnu.org &lt;qemu-block@nongnu.org&gt;; Andrey Shin=
kevich &lt;andrey.shinkevich@virtuozzo.com&gt;; Max Reitz &lt;mreitz@redhat=
.com&gt;; Kevin Wolf &lt;kwolf@redhat.com&gt;; Vladimir Sementsov-Ogievskiy=
 &lt;vsementsov@virtuozzo.com&gt;; Pavel Butsykin &lt;pbutsykin@virtuozzo.c=
om&gt;<br>
<b>Subject:</b> Re: [PATCH v2] qcow2: Check request size in qcow2_co_pwrite=
v_compressed_part()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">I forgot to add the &quot;for-5.0&quot; tag in the=
 subject, do I need to resend<br>
the patch?<br>
<br>
Berto<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB50485BA32FA4F88D896A17A8F4C30AM6PR08MB5048eurp_--

