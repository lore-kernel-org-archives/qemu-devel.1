Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33BBC2BA19
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 00:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9965B20768
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 00:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="riRjD/lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9965B20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMhJ6-0001Ml-QB
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 20:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jMhI5-0000ST-GN
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 20:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jMhI3-0007y9-33
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 20:13:00 -0400
Received: from mail-eopbgr70115.outbound.protection.outlook.com
 ([40.107.7.115]:34368 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jMhI2-0007xZ-BV; Thu, 09 Apr 2020 20:12:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eI72pAsbJXdbFPWzfz7tJ+zsjnIn2SHhy2c3QBRlXwbXJQnfd4RRWgPjnEQCwk2CF38g+FO1XAInCDYElj1bBRReOo67xjto79CP0VWjJgE5ctjsU4e1h+njZg/pL6jiJuFv6B1UYzmApj+4qSKdH5viDFZv0IjUNKTLMksZ2z45zRViF134WnqupXE7avRKFn5pmDUYlk49CeJPcSHg6PdtCP+2zoQs29bnwKHDrENq6IZjQhl/sq5w2za7dznXFNcaHnxRzZMmwI0TN2Pnnnn8ao3A5+Nqzu4tte78uIWiVReEjQJwD95jvDRRFi/U+Z7YwPTIhNofhF7ZlnskJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1/1hmnxebuCcJf9si73Ri3GjrhrOL8aOFJBFxw/OxQ=;
 b=T0ybMQvM+uPAlRepk7LZAiH07KFmoYyAtIryT9HW81y5rg04MjkqnDiZdkOy1X+NjkwfQ1cEZ9Vn5OYe5zJAPzzz30s+BBGklflMk0XiSZsC4R2M+71/i8u56zR4/rJrWT26V2kU26LlZOKcxe2F7jscSlNaTlryzJ0T5VQbbHJhQvtI8M5E/7aXUwdnnPIAAFTZYid9jsREXHOdJijGeHo5Sg313VY0bPg5OGIG3SLm9dFHCqlyWk247uP7So+D3OkoUqCOixXsKESgTAFFdJ4A0jzr5yTxw0b4y3cFhjVpHvI1Mm/5SYZnMn7BzPc1RKY1NTIm1xzoPe9BN9b6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1/1hmnxebuCcJf9si73Ri3GjrhrOL8aOFJBFxw/OxQ=;
 b=riRjD/ljxbVa8x81SsHL4gHCI3f7hnH8NFDnBaz7OMxnGxl5zpuJsxEc7g4TIQLymOvsvLHY5MltQiudcqHR1LCBd6mZ5iQA3Dsp3wVm6dYJD3l/ArN0euy77ShI5nzY8uLJOe21dAptwUZ780jqqh6hHbUxyeRSm73ORLaLcQY=
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (2603:10a6:20b:ee::31)
 by AM6PR08MB4421.eurprd08.prod.outlook.com (2603:10a6:20b:71::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Fri, 10 Apr
 2020 00:12:54 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::d530:4303:deff:33b3]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::d530:4303:deff:33b3%6]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 00:12:54 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Alberto Garcia
 <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v12 2/3] qcow2: Allow writing compressed data of multiple
 clusters
Thread-Topic: [PATCH v12 2/3] qcow2: Allow writing compressed data of multiple
 clusters
Thread-Index: AQHVqQoqZLOxCCmSgEmNHsQclBfRxKhxy8gAgAAedgCAAFZd9g==
Date: Fri, 10 Apr 2020 00:12:54 +0000
Message-ID: <AM6PR08MB504841785FF8C1149D70DFC3F4C10@AM6PR08MB5048.eurprd08.prod.outlook.com>
References: <1575288906-551879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1575288906-551879-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <w51y2r41u4d.fsf@maestria.local.igalia.com>,
 <5bbb126f-37c0-f107-c3b3-667ed43670fa@virtuozzo.com>
In-Reply-To: <5bbb126f-37c0-f107-c3b3-667ed43670fa@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-originating-ip: [109.252.115.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54369bae-ed4b-405c-501b-08d7dce3ea78
x-ms-traffictypediagnostic: AM6PR08MB4421:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB44214BEC480B38EEE62F5CE6F4DE0@AM6PR08MB4421.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB5048.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(376002)(396003)(136003)(366004)(346002)(4326008)(53546011)(6506007)(71200400001)(7696005)(110136005)(54906003)(316002)(55016002)(9686003)(8676002)(81156014)(8936002)(107886003)(2906002)(33656002)(19627405001)(81166007)(186003)(86362001)(44832011)(66446008)(66476007)(5660300002)(66946007)(76116006)(64756008)(52536014)(66556008)(26005)(478600001);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fW4BMr9gKLf/xpETZHD9HVYP2NCdUocUyz7RhXCTUsagqEgBQJLLD504oQyM+OfC5iV8iXiKB9qwwm7C2sgjP5ITc3emERDc9/x2zoUdk+UPSk6nVXbqr/z1ZQp2avGtJmxSTYiepOfxEu4VR/Plqfiymdkj681NykpvLmqrXUqDvCwoLoTHUhpyyhpQxP9dNLuAkOUnhYOUU3+vxoFOPhgC7eCtcFEWPgWdCf0/YwdAyj5OxaD5JEPwHfYQFDjvwSayhmJIM2eXHbeglDfO4sw9z4CnGgPoWizgB8fkCVZW87lnIxAzB49W3eiYwzdIfTpRN5A1iYz9JDr+A9a2rnadUzwciBhqjkB+9abWu5wPUFtXptZEGGJICK5iPudmD7RO3MSGdndRlMsIexAl/XHK1Kqbz8Lh+O8MNmJOX5aWsDS8t8k5EF7uo5iC0qiP
x-ms-exchange-antispam-messagedata: YFIAcgt543oXrJYVqwmUJPUoQ2SSqiGcjew7a6opTeAu9oV1u5q/wybvkDBSvg5rA+cLFX3iu6tek2VYk/jrA95yAqbKKg5XGezpKTvQX6GdhF+b9PU1m4UrKAGEAmV3jQVeuT106AyeZzSaNbZSZg==
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB504841785FF8C1149D70DFC3F4C10AM6PR08MB5048eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54369bae-ed4b-405c-501b-08d7dce3ea78
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 00:12:54.4415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FyN4qhk/Yer39SD75wNIfm+aJVhe6BuunNjbcErw3o6xC+ZswDTyJhiBIxoD5WdsS0sBygaVYwBBCIQF3HQuR2ZnhG3Dua/wG6V9n3FDulg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4421
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.115
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
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM6PR08MB504841785FF8C1149D70DFC3F4C10AM6PR08MB5048eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

We could assign indices to the clusters/chunks and improve the algorithm to=
 write them down on the disk in the same order adjacently. If you find it f=
easible for QEMU, I'd like to create a task for doing that, shall I?

Andrey

________________________________
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Sent: Thursday, April 9, 2020 9:39 PM
To: Alberto Garcia <berto@igalia.com>; Andrey Shinkevich <andrey.shinkevich=
@virtuozzo.com>; qemu-devel@nongnu.org <qemu-devel@nongnu.org>; qemu-block@=
nongnu.org <qemu-block@nongnu.org>
Cc: kwolf@redhat.com <kwolf@redhat.com>; armbru@redhat.com <armbru@redhat.c=
om>; mreitz@redhat.com <mreitz@redhat.com>; Denis Lunev <den@virtuozzo.com>
Subject: Re: [PATCH v12 2/3] qcow2: Allow writing compressed data of multip=
le clusters

09.04.2020 19:50, Alberto Garcia wrote:
> On Mon 02 Dec 2019 01:15:05 PM CET, Andrey Shinkevich wrote:
>> +static coroutine_fn int
>> +qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
>> +                                 uint64_t offset, uint64_t bytes,
>> +                                 QEMUIOVector *qiov, size_t qiov_offset=
)
>> +{
>> +    BDRVQcow2State *s =3D bs->opaque;
>> +    AioTaskPool *aio =3D NULL;
>> +    int ret =3D 0;
>> +
>> +    if (has_data_file(bs)) {
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    if (bytes =3D=3D 0) {
>> +        /*
>> +         * align end of file to a sector boundary to ease reading with
>> +         * sector based I/Os
>> +         */
>> +        int64_t len =3D bdrv_getlength(bs->file->bs);
>> +        if (len < 0) {
>> +            return len;
>> +        }
>> +        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF=
, NULL);
>> +    }
>> +
>> +    if (offset_into_cluster(s, offset)) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    while (bytes && aio_task_pool_status(aio) =3D=3D 0) {
>> +        uint64_t chunk_size =3D MIN(bytes, s->cluster_size);
>> +
>> +        if (!aio && chunk_size !=3D bytes) {
>> +            aio =3D aio_task_pool_new(QCOW2_MAX_WORKERS);
>> +        }
>> +
>> +        ret =3D qcow2_add_task(bs, aio, qcow2_co_pwritev_compressed_tas=
k_entry,
>> +                             0, 0, offset, chunk_size, qiov, qiov_offse=
t, NULL);
>> +        if (ret < 0) {
>> +            break;
>> +        }
>> +        qiov_offset +=3D chunk_size;
>> +        offset +=3D chunk_size;
>> +        bytes -=3D chunk_size;
>> +    }
>
> This patch allows the user to write more than one cluster of compressed
> data at a time, and it does so by splitting the request into many
> cluster-sized requests and using qcow2_add_task() for each one of them.
>
> What happens however is that there's no guarantee that the requests are
> processed in the same order that they were added.
>
> One consequence is that running on an empty qcow2 file a command as
> simple as this one:
>
>     qemu-io -c 'write -c 0 256k' image.qcow2
>
> does not always produce the same results.
>
> This does not have any user-visible consequences for the guest. In all
> cases the data is correctly written, it's just that the ordering of the
> compressed clusters (and therefore the contents of the L2 entries) will
> be different each time.
>
> Because of this a test cannot expect that running the same commands on
> an empty image produces always the same results.
>
> Is this something that we should be concerned about?
>

Parallel writing compressed clusters is significant improvement, as it allo=
w compressing in really parallel threads.

Generally, async parallel issuing of several requests gives more performanc=
e than handling peaces one-by-one, mirror works on this basis and it is fas=
t. I've already moved qcow2 to this idea (aio tasks in qcow2 code), and in =
progress of moving backup job. So, I think that asynchrony and ambiguity wo=
uld be native for block-layer anyway.

Hmm. Still, what about cluster sequence? For normal clusters there may be s=
imple thing to do: preallocation (at least of metadata). So, we can pre-cre=
ate cluster sequence.. But what to do with compressed clusters if we want s=
pecific order for them, I don't know. On the other hand, ordering of normal=
 cluster may make sence: it should increase performnace of following IO. Bu=
t for compressed clusters it's not the case.

So, I don't think we should make specific workaround for testing... What ex=
actly is the case?

--
Best regards,
Vladimir

--_000_AM6PR08MB504841785FF8C1149D70DFC3F4C10AM6PR08MB5048eurp_
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
We could assign indices to the clusters/chunks and improve the algorithm to=
 write them down on the disk in the same order adjacently. If you find it f=
easible for QEMU, I'd like to create a task for doing that, shall I?</div>
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
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Vladimir Sementsov-Og=
ievskiy &lt;vsementsov@virtuozzo.com&gt;<br>
<b>Sent:</b> Thursday, April 9, 2020 9:39 PM<br>
<b>To:</b> Alberto Garcia &lt;berto@igalia.com&gt;; Andrey Shinkevich &lt;a=
ndrey.shinkevich@virtuozzo.com&gt;; qemu-devel@nongnu.org &lt;qemu-devel@no=
ngnu.org&gt;; qemu-block@nongnu.org &lt;qemu-block@nongnu.org&gt;<br>
<b>Cc:</b> kwolf@redhat.com &lt;kwolf@redhat.com&gt;; armbru@redhat.com &lt=
;armbru@redhat.com&gt;; mreitz@redhat.com &lt;mreitz@redhat.com&gt;; Denis =
Lunev &lt;den@virtuozzo.com&gt;<br>
<b>Subject:</b> Re: [PATCH v12 2/3] qcow2: Allow writing compressed data of=
 multiple clusters</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">09.04.2020 19:50, Alberto Garcia wrote:<br>
&gt; On Mon 02 Dec 2019 01:15:05 PM CET, Andrey Shinkevich wrote:<br>
&gt;&gt; &#43;static coroutine_fn int<br>
&gt;&gt; &#43;qcow2_co_pwritev_compressed_part(BlockDriverState *bs,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t offset, u=
int64_t bytes,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QEMUIOVector *qiov=
, size_t qiov_offset)<br>
&gt;&gt; &#43;{<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; BDRVQcow2State *s =3D bs-&gt;opaque;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; AioTaskPool *aio =3D NULL;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (has_data_file(bs)) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOTSUP;<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (bytes =3D=3D 0) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * align end =
of file to a sector boundary to ease reading with<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * sector bas=
ed I/Os<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int64_t len =3D bd=
rv_getlength(bs-&gt;file-&gt;bs);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (len &lt; 0) {<=
br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return len;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return bdrv_co_tru=
ncate(bs-&gt;file, len, false, PREALLOC_MODE_OFF, NULL);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (offset_into_cluster(s, offset)) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br=
>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; while (bytes &amp;&amp; aio_task_pool_stat=
us(aio) =3D=3D 0) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t chunk_siz=
e =3D MIN(bytes, s-&gt;cluster_size);<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aio &amp;&amp=
; chunk_size !=3D bytes) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; aio =3D aio_task_pool_new(QCOW2_MAX_WORKERS);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D qcow2_add_=
task(bs, aio, qcow2_co_pwritev_compressed_task_entry,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, 0, offset, chunk_size, qiov, qiov_offse=
t, NULL);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<=
br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; break;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qiov_offset &#43;=
=3D chunk_size;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset &#43;=3D ch=
unk_size;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes -=3D chunk_s=
ize;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; This patch allows the user to write more than one cluster of compresse=
d<br>
&gt; data at a time, and it does so by splitting the request into many<br>
&gt; cluster-sized requests and using qcow2_add_task() for each one of them=
.<br>
&gt; <br>
&gt; What happens however is that there's no guarantee that the requests ar=
e<br>
&gt; processed in the same order that they were added.<br>
&gt; <br>
&gt; One consequence is that running on an empty qcow2 file a command as<br=
>
&gt; simple as this one:<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; qemu-io -c 'write -c 0 256k' image.qcow2<br>
&gt; <br>
&gt; does not always produce the same results.<br>
&gt; <br>
&gt; This does not have any user-visible consequences for the guest. In all=
<br>
&gt; cases the data is correctly written, it's just that the ordering of th=
e<br>
&gt; compressed clusters (and therefore the contents of the L2 entries) wil=
l<br>
&gt; be different each time.<br>
&gt; <br>
&gt; Because of this a test cannot expect that running the same commands on=
<br>
&gt; an empty image produces always the same results.<br>
&gt; <br>
&gt; Is this something that we should be concerned about?<br>
&gt; <br>
<br>
Parallel writing compressed clusters is significant improvement, as it allo=
w compressing in really parallel threads.<br>
<br>
Generally, async parallel issuing of several requests gives more performanc=
e than handling peaces one-by-one, mirror works on this basis and it is fas=
t. I've already moved qcow2 to this idea (aio tasks in qcow2 code), and in =
progress of moving backup job. So,
 I think that asynchrony and ambiguity would be native for block-layer anyw=
ay.<br>
<br>
Hmm. Still, what about cluster sequence? For normal clusters there may be s=
imple thing to do: preallocation (at least of metadata). So, we can pre-cre=
ate cluster sequence.. But what to do with compressed clusters if we want s=
pecific order for them, I don't
 know. On the other hand, ordering of normal cluster may make sence: it sho=
uld increase performnace of following IO. But for compressed clusters it's =
not the case.<br>
<br>
So, I don't think we should make specific workaround for testing... What ex=
actly is the case?<br>
<br>
-- <br>
Best regards,<br>
Vladimir<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB504841785FF8C1149D70DFC3F4C10AM6PR08MB5048eurp_--

