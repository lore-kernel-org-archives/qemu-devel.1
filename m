Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AC4C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 04:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9B2206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 04:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L5UIdFnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9B2206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSv9z-00017M-Pt
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 00:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jSv99-0008GU-My
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 00:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jSv99-0002d9-3f
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 00:13:31 -0400
Received: from mail-eopbgr80102.outbound.protection.outlook.com
 ([40.107.8.102]:34422 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jSv96-0002cl-6Z; Mon, 27 Apr 2020 00:13:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQF4mxN0otUdztIaJgyrrK35Fp0CGIa3BQQ5YqJHyU46K/MhuFxUKwbEXbcijCZ3hCivt8UOwAUxhLYqGSaCviv8PJ/IgE91gT8sBhGt6g5Tq8nIU7gfSWDWUw66g0w/0SGKebnxZ5QKxoiXuQ1RxYlkJfM4UTyLETN1uPDGrRhmrfyvPqN0XaNAy5DbiNMEy6CjH8vhjvgTmAFjX2Aa4QJex3e7yFjrQvy7AFmtz788nDJOcO1tY7HdA4bxHjKs9Uh1GE4mv6cBzMotzylwhHDwk25SAD2qiJokGrZBH32fBFlJHOw2GZ3lCUUPbSt9YIspz5q88vla9AhDun7E2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpRvQ9H4q/oofDWJLAsGlFql34J27RHCQCYIMsH0f88=;
 b=jsYb/G0MEVyf9hs3OzDazXjiGx2mFFW+4CIAY67JA12obZSFtcSZXgOJBUQnubc5yXZgJonXZJlj6um1aLLqy6mHuGKJyPbKBwztoUD6jQ5WRa+rbYeZqWwvOlMDBWNzeZLYDp3ox4glgiv39g8y0phRIoMuO1RXGOl+zr6kIVYMmBs9L3FEjxBXtGc8WYJn/POUkljp2D1stX34r5iiyxC7t25SdjtsOJhvQ4NjGriS9MOzA7TMOwG23eoupDApHz+ga0BRVaHyT1KAJ7y6VqbydbSlkN5c7PNfWQ3BBQq+IB4U3z9iWdoKur5bo71bm0j+YxBCsC/DmEunjFvliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpRvQ9H4q/oofDWJLAsGlFql34J27RHCQCYIMsH0f88=;
 b=L5UIdFnZwCvD8cCANSrQtzG+mrJjvtRfLy3S6EJPQbzAOs57sQezc05sptnuauouVivisvY4HVJgKISVLtLwEmcYo6ilLH7vubRLdCibmLFjCihVvZCFf/ijS6mGCfu0rdHtQgCGMLYdmhM3kR1cFYE8cTg4xR51NbsusEXj08Q=
Received: from VI1PR0802MB2206.eurprd08.prod.outlook.com
 (2603:10a6:800:9b::14) by VI1PR0802MB2429.eurprd08.prod.outlook.com
 (2603:10a6:800:ba::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 04:13:24 +0000
Received: from VI1PR0802MB2206.eurprd08.prod.outlook.com
 ([fe80::5143:32f:9e92:487e]) by VI1PR0802MB2206.eurprd08.prod.outlook.com
 ([fe80::5143:32f:9e92:487e%6]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 04:13:23 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH 0/7] Apply COR-filter to the block-stream permanently
Thread-Topic: [PATCH 0/7] Apply COR-filter to the block-stream permanently
Thread-Index: AQHWF0Kuph41O4K9NUejhj1PoxZreqiDjmCAgAjW4Fk=
Date: Mon, 27 Apr 2020 04:13:23 +0000
Message-ID: <VI1PR0802MB22061E30A2121392969148AEF4AF0@VI1PR0802MB2206.eurprd08.prod.outlook.com>
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>,
 <f91a8d20-b60b-7fe9-443a-875b6232af46@virtuozzo.com>
In-Reply-To: <f91a8d20-b60b-7fe9-443a-875b6232af46@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-originating-ip: [109.252.115.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5da74d43-e0c1-4852-ed5d-08d7ea6153f6
x-ms-traffictypediagnostic: VI1PR0802MB2429:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0802MB2429CE8B90E9499624DD6895F4AF0@VI1PR0802MB2429.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR0802MB2206.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39830400003)(346002)(966005)(2906002)(7696005)(6506007)(9686003)(53546011)(478600001)(186003)(110136005)(55016002)(26005)(52536014)(4326008)(71200400001)(33656002)(107886003)(54906003)(316002)(8936002)(5660300002)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(8676002)(81156014)(44832011)(86362001);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DWLzDjDj78/ZpTgGK79cJWfk5TpbtTrrYnZk8dY/eNQlVZ+y2HN7fQKeeFSZJEY8QripPlwaPdUA99O2y8MXSgGuuPmOhpTYNvJ7XtxRLbwN//x1cTX2RctSuYqJDArMW67pLFNNu6q8P9d1IfvDGVV/RRXiIlk4v0RKDJXTmO0So902m7PSYtSmfYrJpszCvXmYpfFbtt3iDhVdi8a66CLYXdUVNNI1lrka6/2ikaHRnho+2WiATvx7Gk7qcvdiHFXoUQh8iYzF9kYuh7W1RRjEnIEo5AsGCE9q4JAonZRtQTVfz/45u9haF1WVQhiWAxpgd5AdUjgSWQFLOBYLKN96AXlkyZvTPStKEpFYiJLKgLHvpprQeEoTZKxDV+iVJVps4tOM5gaT+/g4g5Ab7z/QFIOyPxFmBFB71Ismm8DRukoKzVnvgvL7Kl/ZT4ckhDX4Uq1T+GP12GKaqmy85PE/1+rCdNunZlAa3a74aS8d+bGVZlszSniFBRJdysoM0epDrdR0EEKnyPvB5IRx2Q==
x-ms-exchange-antispam-messagedata: qXanUgHbZ1WZU3+t0SOGGXejrVwN0Q8Rw3A3m+xVSHQA4waFmFJztKIfTG38H4MMUkMOsUeBEgpM88DR59+00MTLXBlpn9/CuaG3SsX2fRPxI5hI3iN2Y1FJPBTEUt1GpndLF8Kp7MR8dPtx1tVi3elNu3mgWDIUnRZsvWlsCTBKufNGJjIPxC3PQUqgGrrVbElBLxyYYfiOioP/7hbYoVMgLRBoXO5A/XqmKoh9VknJlprihcQwmJhFPeQ7gKS4YBjVtu9EonnQ+jyk+R+sRZwQfiqWRTwwu5h+ICO6UyulikzLy5SARLol4K5vRNhzPTwPo5+qY/d2oMMjJEFcj+TUtWrRtYZ4Dbqt3zcEEYDBeNutY7Jyi6zJDnf43NTqZtyY87NfoG3VFIbul+3QFOFl8QcVEvSEdhKgeNML4zA3nzxrp7Db8h0BoJI7I7XSgPFjjBAPtsJTXI+6zsyChzM8LeKoenGNsmeXxTuxb4Tyq47D0PxQ30bCgIvYmD5e9Hczh9hmunm+TuOzoXKaadfj6cicAkQcfvBFBjBaGSGtkfPmVXGMhCHRJQrv4+Lr0LVdSkBJW4vxCom32wRM/rR+8ThBI62lCe3wec680wyvfRldM5XgCjJjTmIpo7K5cEJirD5o0xZP6cBgImOcFNM9rDWU6aSoG4e96d2o1prDtla/T29lIReB++D6j0CtDttJYmyTQ8uvO0eU76ZhD6QQ5H0yZiH2DFuiSvOq9QrY5LWrs8i/XKqoDIhwtyrDFvwtsyspZ/wPlAqVpkw1v3VRYWM0yM2kkkDEsno1Y3YiCp3AybhAow4TN3Uq3IQc
Content-Type: multipart/alternative;
 boundary="_000_VI1PR0802MB22061E30A2121392969148AEF4AF0VI1PR0802MB2206_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da74d43-e0c1-4852-ed5d-08d7ea6153f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 04:13:23.5924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceGaVb8FG5S45zVFBJ5UlNNqqRvwmwZQIUf32tFinVV3UoIRRwBl/Lw5GVlp5ajhgdnIRborHAVPQ8wi6M8/aR7DeoZlPcL8OQ2CZEML6Jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2429
Received-SPF: pass client-ip=40.107.8.102;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 00:13:25
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.8.102
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_VI1PR0802MB22061E30A2121392969148AEF4AF0VI1PR0802MB2206_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am going to do that in version 3. Please review the changes in the versio=
n 2 first.
Thanks,
Andrey

________________________________
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Sent: Tuesday, April 21, 2020 4:12 PM
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>; qemu-block@nongnu.=
org <qemu-block@nongnu.org>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; kwolf@redhat.com <kwolf@=
redhat.com>; mreitz@redhat.com <mreitz@redhat.com>; jsnow@redhat.com <jsnow=
@redhat.com>; armbru@redhat.com <armbru@redhat.com>; dgilbert@redhat.com <d=
gilbert@redhat.com>; eblake@redhat.com <eblake@redhat.com>; Denis Lunev <de=
n@virtuozzo.com>
Subject: Re: [PATCH 0/7] Apply COR-filter to the block-stream permanently

20.04.2020 21:36, Andrey Shinkevich wrote:
> Note: this series is based on the one "block: Deal with filters"
>        by Max Reitz that can be found in the branches:
>
>        https://git.xanclic.moe/XanClic/qemu child-access-functions-v6
>        https://github.com/XanClic/qemu child-access-functions-v6

Would be very good to not make a dependency and keep the series parallel. I=
 believe, that we can proceed with this series taking a small subset of Max=
's series.

>
>        When running iotests, apply "char-socket: Fix race condition"
>        to avoid sporadic segmentation faults.
>
> With this series, all the block-stream COR operations pass through
> the COR-filter.
>
> Andrey Shinkevich (7):
>    block: prepare block-stream for using COR-filter
>    stream: exclude a link to filter from freezing
>    block: protect parallel jobs from overlapping
>    copy-on-read: Support refreshing filename
>    qapi: add filter-node-name to block-stream
>    iotests: prepare 245 for using filter in block-stream
>    block: apply COR-filter to block-stream jobs
>
>   block/copy-on-read.c       |   7 ++
>   block/stream.c             | 170 ++++++++++++++++++++++++++++++++++++++=
+------
>   blockdev.c                 |  15 +++-
>   blockjob.c                 |  15 +++-
>   include/block/block_int.h  |   7 +-
>   monitor/hmp-cmds.c         |   4 +-
>   qapi/block-core.json       |   6 ++
>   tests/qemu-iotests/030     |   6 +-
>   tests/qemu-iotests/141.out |   2 +-
>   tests/qemu-iotests/245     |  15 ++--
>   10 files changed, 210 insertions(+), 37 deletions(-)
>


--
Best regards,
Vladimir

--_000_VI1PR0802MB22061E30A2121392969148AEF4AF0VI1PR0802MB2206_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div>I am going to do that in version 3. Please review the changes in the v=
ersion 2 first.</div>
<div>Thanks,</div>
<div>Andrey</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Vladimir Sementsov-Og=
ievskiy &lt;vsementsov@virtuozzo.com&gt;<br>
<b>Sent:</b> Tuesday, April 21, 2020 4:12 PM<br>
<b>To:</b> Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;; qemu-=
block@nongnu.org &lt;qemu-block@nongnu.org&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; kwolf@redha=
t.com &lt;kwolf@redhat.com&gt;; mreitz@redhat.com &lt;mreitz@redhat.com&gt;=
; jsnow@redhat.com &lt;jsnow@redhat.com&gt;; armbru@redhat.com &lt;armbru@r=
edhat.com&gt;; dgilbert@redhat.com &lt;dgilbert@redhat.com&gt;; eblake@redh=
at.com
 &lt;eblake@redhat.com&gt;; Denis Lunev &lt;den@virtuozzo.com&gt;<br>
<b>Subject:</b> Re: [PATCH 0/7] Apply COR-filter to the block-stream perman=
ently</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">20.04.2020 21:36, Andrey Shinkevich wrote:<br>
&gt; Note: this series is based on the one &quot;block: Deal with filters&q=
uot;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; by Max Reitz that can be fou=
nd in the branches:<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://git.xancl=
ic.moe/XanClic/qemu">https://git.xanclic.moe/XanClic/qemu</a> child-access-=
functions-v6<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://github.co=
m/XanClic/qemu">https://github.com/XanClic/qemu</a> child-access-functions-=
v6<br>
<br>
Would be very good to not make a dependency and keep the series parallel. I=
 believe, that we can proceed with this series taking a small subset of Max=
's series.<br>
<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; When running iotests, apply =
&quot;char-socket: Fix race condition&quot;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to avoid sporadic segmentati=
on faults.<br>
&gt; <br>
&gt; With this series, all the block-stream COR operations pass through<br>
&gt; the COR-filter.<br>
&gt; <br>
&gt; Andrey Shinkevich (7):<br>
&gt;&nbsp;&nbsp;&nbsp; block: prepare block-stream for using COR-filter<br>
&gt;&nbsp;&nbsp;&nbsp; stream: exclude a link to filter from freezing<br>
&gt;&nbsp;&nbsp;&nbsp; block: protect parallel jobs from overlapping<br>
&gt;&nbsp;&nbsp;&nbsp; copy-on-read: Support refreshing filename<br>
&gt;&nbsp;&nbsp;&nbsp; qapi: add filter-node-name to block-stream<br>
&gt;&nbsp;&nbsp;&nbsp; iotests: prepare 245 for using filter in block-strea=
m<br>
&gt;&nbsp;&nbsp;&nbsp; block: apply COR-filter to block-stream jobs<br>
&gt; <br>
&gt;&nbsp;&nbsp; block/copy-on-read.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp;&nbsp; 7 &#43;&#43;<br>
&gt;&nbsp;&nbsp; block/stream.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; | 170 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;------<br>
&gt;&nbsp;&nbsp; blockdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 15 &#43;&#43;&#43;=
-<br>
&gt;&nbsp;&nbsp; blockjob.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 15 &#43;&#43;&#43;=
-<br>
&gt;&nbsp;&nbsp; include/block/block_int.h&nbsp; |&nbsp;&nbsp; 7 &#43;-<br>
&gt;&nbsp;&nbsp; monitor/hmp-cmds.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp;&nbsp; 4 &#43;-<br>
&gt;&nbsp;&nbsp; qapi/block-core.json&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp;&nbsp; 6 &#43;&#43;<br>
&gt;&nbsp;&nbsp; tests/qemu-iotests/030&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbs=
p; 6 &#43;-<br>
&gt;&nbsp;&nbsp; tests/qemu-iotests/141.out |&nbsp;&nbsp; 2 &#43;-<br>
&gt;&nbsp;&nbsp; tests/qemu-iotests/245&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 15 =
&#43;&#43;--<br>
&gt;&nbsp;&nbsp; 10 files changed, 210 insertions(&#43;), 37 deletions(-)<b=
r>
&gt; <br>
<br>
<br>
-- <br>
Best regards,<br>
Vladimir<br>
</div>
</span></font></div>
</body>
</html>

--_000_VI1PR0802MB22061E30A2121392969148AEF4AF0VI1PR0802MB2206_--

