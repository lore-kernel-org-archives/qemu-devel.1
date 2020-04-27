Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A886C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 04:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF19F206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 04:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X6URB/UY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF19F206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSv5N-0006Gr-2W
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 00:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jSv4V-000531-MU
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 00:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jSv4V-0005yd-3P
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 00:08:43 -0400
Received: from mail-eopbgr30123.outbound.protection.outlook.com
 ([40.107.3.123]:32899 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jSv4R-0005xT-B0; Mon, 27 Apr 2020 00:08:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty0PE35SAJ+LXbwBa1aDfN+KTV35uIEUZdqxLgPgke8rzF4bT2vDzoiyGuuYbTw8WIZPCTTRhmXWCRwR7H9635VgldUCTa5XWFQ3NvXXoM8e5IHudWq/hHjmCYH4LsKBUTOc8aHxg9pFad1lKSmepBB2TV4xuGyW1suEgDFZSqvlNAkNpHzRbxPDOomQ89gmHUiy/h1xs2ljzQ13fUb7cXicUWuobmO1dwjwm/yHWmc0NLn1xqxAMve8v/WY77yG1x53Yb12G4e23e6OKqi+e2VMdvCCgUKIiFLQmIfziRzoWkbpZ6F610DzWozPnKp2kKFsCgoXh5MqHuBAPqN7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLw9wXVN2QSwwo9P/650E83yGNES79sXcJfchtfzpUE=;
 b=isYfUwwoJpd/xGVpceetzhougAuba4z3gr5FwnMEz9i6SRiyxX6zPWKAk85NxPTobUdUhe7DzKUrKD3sEB7JcEE83R81yQzR50kX7BE6QK6M9lgo/MwnsdL+fviYEZGXZv6XXna6j56B4ntxposmRu/QaD9rRmJkdmKQdQy3Iu3LUqwdtiqHaWXokmZQM1+LpuC5RoETAslT/s+ls+4eAH3dsyU6yi/lq4x93Ezejn17xSEoVJD5Sbdu7FdmjOPBpWv5zBhONXGIaJ6GzTrwM/GfUWprNq1LVbXfGTJiPgAXnfac99Y2cij28Chny8zOic8N2l7lbXMl+/LN41vxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLw9wXVN2QSwwo9P/650E83yGNES79sXcJfchtfzpUE=;
 b=X6URB/UYB89/jodEPgxbc3ZgZVJZv/JFUY8VdBgkKIGN4RPWtZ4Mznjmjqwx0XgZpIF6qlhwRi1/yVASV5Me/Et0RXL7qdFylg7QO/z/GvFw+Rgg0gfvq5yuYG9w166keAoqSIeuGvmuoSmD+5XleJA2LTsfxq2t1q+jmylQ7Jk=
Received: from VI1PR0802MB2206.eurprd08.prod.outlook.com
 (2603:10a6:800:9b::14) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:ad::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 04:08:33 +0000
Received: from VI1PR0802MB2206.eurprd08.prod.outlook.com
 ([fe80::5143:32f:9e92:487e]) by VI1PR0802MB2206.eurprd08.prod.outlook.com
 ([fe80::5143:32f:9e92:487e%6]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 04:08:33 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH 7/7] block: apply COR-filter to block-stream jobs
Thread-Topic: [PATCH 7/7] block: apply COR-filter to block-stream jobs
Thread-Index: AQHWF0KtV9+gBDwts0GEHLTWREgZUqiDipOAgAjTS2s=
Date: Mon, 27 Apr 2020 04:08:33 +0000
Message-ID: <VI1PR0802MB22061455B6632D402C45ED88F4AF0@VI1PR0802MB2206.eurprd08.prod.outlook.com>
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1587407806-109784-8-git-send-email-andrey.shinkevich@virtuozzo.com>,
 <17237b84-d71a-0648-4614-65515b4ecc30@virtuozzo.com>
In-Reply-To: <17237b84-d71a-0648-4614-65515b4ecc30@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-originating-ip: [109.252.115.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39b896d7-f27d-408a-059c-08d7ea60a720
x-ms-traffictypediagnostic: VI1PR0802MB2528:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0802MB2528AB2F9CC9151DC916DD58F4AF0@VI1PR0802MB2528.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR0802MB2206.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(376002)(346002)(396003)(136003)(9686003)(54906003)(5660300002)(6506007)(76116006)(8936002)(44832011)(53546011)(66446008)(66476007)(64756008)(66556008)(316002)(7696005)(8676002)(107886003)(110136005)(81156014)(33656002)(186003)(86362001)(478600001)(26005)(55016002)(2906002)(71200400001)(66946007)(52536014)(4326008);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jAG0OMXtt8NozSHRB9q09I3xY/VDBAg4q+vRl/4IcunFlScakO5Dky8SLzPYNdS6BIvILRIPxky5Uj8UwQ5LpTxMNMjNOA+zrTNLZaNykk3XC4kNp0R3MPWmQUH5vxc6xnCUYCaPlyn6UtZXrHt7E/x1t48LQs/drCQfLVtyM58qoVU2W1f0WUYqpLXcJTAip3ENjgy72cDFKPyaGCwQepee+Srli7SwWCc78SJLVKPKHx46ky8vgUYTCfwBBq0Gbq4VK7VOkky6k9nbFVbGLJpaRqDq3vWQD3Gb5dKgE4HXYIVXmLPZbuwUA8fB77e5gGnxx3Xw2fHHv7K0wM9mMOgzAE5fYDMfGdRRsTgqRVOIdBNwOGG2++EKe39v96OjNETd1oo3PY9jQn5XSp2JskvSxnhlpUZRdgbRJnw01jy55vConTc9c6UYhuT9LePu
x-ms-exchange-antispam-messagedata: hETUiEwBYLNqa/HxSINkEqa8MLvd97/TKJjQ6kQM/M478pmly2Mxzsjaq5AylfH7BXdD/gFXtsPICyMWz86sLr7bJt9L4xDtV0T/kgT+u5dCEdwZwt6HRccO/L6kcP+2NFwNJ85pwgln/E69H55CRT5DkciXO9VhMRpPE3lKrbj9DljuKlwIWNkj4WOf9yaEJmFgwcTAqPWODDjkRfjLhjoaJSrPDWPKlrwSEywjii5LgxHX4uhDHBu3x6pz4gliSL7kJjnX4SQWqNOkub9Sq4bLDqrT7+/5EEPegZYmVXw7tigp+ODLEFStkx+pR46LtNdOic4NgCvt/u+pJ+JersGn4n0fBdXFL/2P/1t0N3BU3Fh29nkJ8rNuA2AhPdVwSeA4f1RfqREdu0tBmPuH2hgWvD6qFzSpbjJEykVTYrp0DkfzlrTqsUSeoFrUsBY7OPNGzT4Hh3tuaL4nBJY1D643epUgR8kW8PB7lBK8nen/ev/nAyuZhWt1ciZtwnWs8iprcEctJbAzCKSyTJLChWVeGizjiusvjdxTLpaw0Lxkxjglga3lSYrznXEsvcDi2+woYvhOr0DCBRm1ECNznlw82pH5+Xx3M/bmTmm4jnijP/V8XaondIk37Jl8kQRY6e4CwWD+xjiciYI+txB/T4bzgM7WK13t7gj3EnSUqxgNe7suSgFDyw6dzmfIMqPNy/et4LqPRdQSas5uSw9Sf4eHHj69r7qxnvZElyf8Pvrx0QGg+TIaErBy91ySOh+ZS17mYh8lQdKeEuWHMTgojkATTm2iQFf/E38Se7LKsXbX2v4pLlm3QUls/0km/zGB
Content-Type: multipart/alternative;
 boundary="_000_VI1PR0802MB22061455B6632D402C45ED88F4AF0VI1PR0802MB2206_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b896d7-f27d-408a-059c-08d7ea60a720
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 04:08:33.6428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UqK5FPcuWYO98fvb+lY3hV5Yu9swOo4f/Jz/32e9Zke4FAQdjapP2NOiXAITS0TIqPx5IsSrkRkAN0Fs1axW6vnLa+3ZfNETfITxHNadXsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2528
Received-SPF: pass client-ip=40.107.3.123;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 00:08:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.3.123
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

--_000_VI1PR0802MB22061455B6632D402C45ED88F4AF0VI1PR0802MB2206_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

1. The mirror technology instantiates its own BLK, sets 0/BLK_PERM_ALL for =
it on exit and then, via subsequent call to bdrv_child_refresh_perms(), cal=
ls bdrv_child_try_set_perm(). We don't have the extra BLK for our filter in=
 stream and do call the same function directly.

2. The function remove_filter() can't be used in the stream job on exit bec=
ause we should remove the filter and change a backing file in the same crit=
ical 'drain' section.

3. Due to the specifics above, I suggest that we make insert/remove filter =
as an interface when there gets another user of it.

Andrey

________________________________
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Sent: Tuesday, April 21, 2020 3:58 PM
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>; qemu-block@nongnu.=
org <qemu-block@nongnu.org>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; kwolf@redhat.com <kwolf@=
redhat.com>; mreitz@redhat.com <mreitz@redhat.com>; jsnow@redhat.com <jsnow=
@redhat.com>; armbru@redhat.com <armbru@redhat.com>; dgilbert@redhat.com <d=
gilbert@redhat.com>; eblake@redhat.com <eblake@redhat.com>; Denis Lunev <de=
n@virtuozzo.com>
Subject: Re: [PATCH 7/7] block: apply COR-filter to block-stream jobs

20.04.2020 21:36, Andrey Shinkevich wrote:
> The patch completes the series with the COR-filter insertion to any
> block-stream operation. It also makes changes to the iotests 030, 141
> and 245.
>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/stream.c             | 151 ++++++++++++++++++++++++++++++++++++++=
+------
>   tests/qemu-iotests/030     |   6 +-
>   tests/qemu-iotests/141.out |   2 +-
>   tests/qemu-iotests/245     |   5 +-
>   4 files changed, 141 insertions(+), 23 deletions(-)
>
> diff --git a/block/stream.c b/block/stream.c
> index fab7923..af14ba8 100644
> --- a/block/stream.c
> +++ b/block/stream.c


[..]

> +static int stream_exit(Job *job, bool abort)
> +{
> +    StreamBlockJob *s =3D container_of(job, StreamBlockJob, common.job);
> +    BlockJob *bjob =3D &s->common;
> +    BlockDriverState *target_bs =3D s->target_bs;
> +    int ret =3D 0;
> +
> +    if (s->chain_frozen) {
> +        bdrv_unfreeze_chain(s->target_bs, s->bottom_cow_node);
> +        s->chain_frozen =3D false;
> +    }
> +
> +    /* Retain the BDS until we complete the graph change. */
> +    bdrv_ref(target_bs);
> +    /* Hold a guest back from writing while permissions are being reset.=
 */
> +    bdrv_drained_begin(target_bs);
> +    /* Drop permissions before the graph change. */
> +    bdrv_child_try_set_perm(bdrv_filtered_rw_child(s->cor_filter_bs),
> +                            0, BLK_PERM_ALL, &error_abort);

Hmm. I don't remember what's wrong with it, but something is. Neither mirro=
r nor backup do this now,
instead they use some flag, that permissions are not needed anymore and cal=
l bdrv_child_refresh_perms()

Also, strange that you have insert_filter function, but don't use it here.

Also, could we keep add/remove filter api in block/copy-on-read.c, like it =
is done for backup-top ?

--
Best regards,
Vladimir

--_000_VI1PR0802MB22061455B6632D402C45ED88F4AF0VI1PR0802MB2206_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div>1. The mirror technology instantiates its own BLK, sets 0/BLK_PERM_ALL=
 for it on exit and then, via subsequent call to&nbsp;<span style=3D"font-f=
amily: &quot;Segoe UI WestEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, =
Arial, sans-serif; font-style: normal; font-variant-ligatures: normal; font=
-variant-caps: normal; font-weight: 400; font-size: 14.6667px;">bdrv_child_=
refresh_perms(),
 calls bdrv_child_try_set_perm(). We don't have the extra BLK for our filte=
r in stream and do call the same function directly.</span><br>
</div>
<div><font size=3D"2"><span style=3D"font-size: 11pt;">
<div><span style=3D"font-style: normal; font-variant-ligatures: normal; fon=
t-variant-caps: normal; font-weight: 400; font-size: 14.6667px; font-family=
: &quot;Segoe UI WestEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial=
, sans-serif;"><br>
</span></div>
<div><span style=3D"font-style: normal; font-variant-ligatures: normal; fon=
t-variant-caps: normal; font-weight: 400; font-size: 14.6667px; font-family=
: &quot;Segoe UI WestEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial=
, sans-serif;">2. The function remove_filter() can't be
 used in the stream job on exit because we should remove the filter and cha=
nge a backing file in the same critical 'drain' section.</span></div>
<div><span style=3D"font-style: normal; font-variant-ligatures: normal; fon=
t-variant-caps: normal; font-weight: 400; font-size: 14.6667px; font-family=
: &quot;Segoe UI WestEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial=
, sans-serif;"><br>
</span></div>
<div><span style=3D"font-style: normal; font-variant-ligatures: normal; fon=
t-variant-caps: normal; font-weight: 400; font-size: 14.6667px; font-family=
: &quot;Segoe UI WestEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial=
, sans-serif;">3. Due to the specifics above, I suggest
 that we make insert/remove filter as an interface when there gets another =
user of it.&nbsp;</span></div>
<div><span style=3D"font-style: normal; font-variant-ligatures: normal; fon=
t-variant-caps: normal; font-weight: 400; font-size: 14.6667px; font-family=
: &quot;Segoe UI WestEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial=
, sans-serif;"><br>
</span></div>
<div><span style=3D"font-style: normal; font-variant-ligatures: normal; fon=
t-variant-caps: normal; font-weight: 400; font-size: 14.6667px; font-family=
: &quot;Segoe UI WestEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial=
, sans-serif;">Andrey</span></div>
<div><span style=3D"font-style: normal; font-variant-ligatures: normal; fon=
t-variant-caps: normal; font-weight: 400; font-size: 14.6667px; font-family=
: &quot;Segoe UI WestEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial=
, sans-serif;"><br>
</span></div>
</span></font><font size=3D"2"><span style=3D"font-size: 11pt;"></span></fo=
nt></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Vladimir Sementsov-Og=
ievskiy &lt;vsementsov@virtuozzo.com&gt;<br>
<b>Sent:</b> Tuesday, April 21, 2020 3:58 PM<br>
<b>To:</b> Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;; qemu-=
block@nongnu.org &lt;qemu-block@nongnu.org&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; kwolf@redha=
t.com &lt;kwolf@redhat.com&gt;; mreitz@redhat.com &lt;mreitz@redhat.com&gt;=
; jsnow@redhat.com &lt;jsnow@redhat.com&gt;; armbru@redhat.com &lt;armbru@r=
edhat.com&gt;; dgilbert@redhat.com &lt;dgilbert@redhat.com&gt;; eblake@redh=
at.com
 &lt;eblake@redhat.com&gt;; Denis Lunev &lt;den@virtuozzo.com&gt;<br>
<b>Subject:</b> Re: [PATCH 7/7] block: apply COR-filter to block-stream job=
s</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">20.04.2020 21:36, Andrey Shinkevich wrote:<br>
&gt; The patch completes the series with the COR-filter insertion to any<br=
>
&gt; block-stream operation. It also makes changes to the iotests 030, 141<=
br>
&gt; and 245.<br>
&gt; <br>
&gt; Signed-off-by: Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&g=
t;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; block/stream.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; | 151 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;------<br>
&gt;&nbsp;&nbsp; tests/qemu-iotests/030&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbs=
p; 6 &#43;-<br>
&gt;&nbsp;&nbsp; tests/qemu-iotests/141.out |&nbsp;&nbsp; 2 &#43;-<br>
&gt;&nbsp;&nbsp; tests/qemu-iotests/245&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbs=
p; 5 &#43;-<br>
&gt;&nbsp;&nbsp; 4 files changed, 141 insertions(&#43;), 23 deletions(-)<br=
>
&gt; <br>
&gt; diff --git a/block/stream.c b/block/stream.c<br>
&gt; index fab7923..af14ba8 100644<br>
&gt; --- a/block/stream.c<br>
&gt; &#43;&#43;&#43; b/block/stream.c<br>
<br>
<br>
[..]<br>
<br>
&gt; &#43;static int stream_exit(Job *job, bool abort)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; StreamBlockJob *s =3D container_of(job, Stream=
BlockJob, common.job);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; BlockJob *bjob =3D &amp;s-&gt;common;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; BlockDriverState *target_bs =3D s-&gt;target_b=
s;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; if (s-&gt;chain_frozen) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdrv_unfreeze_chain(s-=
&gt;target_bs, s-&gt;bottom_cow_node);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;chain_frozen =3D=
 false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; /* Retain the BDS until we complete the graph =
change. */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; bdrv_ref(target_bs);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; /* Hold a guest back from writing while permis=
sions are being reset. */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; bdrv_drained_begin(target_bs);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; /* Drop permissions before the graph change. *=
/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; bdrv_child_try_set_perm(bdrv_filtered_rw_child=
(s-&gt;cor_filter_bs),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0, BLK_PERM_ALL, &amp;error_abort);<br>
<br>
Hmm. I don't remember what's wrong with it, but something is. Neither mirro=
r nor backup do this now,<br>
instead they use some flag, that permissions are not needed anymore and cal=
l bdrv_child_refresh_perms()<br>
<br>
</div>
</span></font><font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">Also, strange that you have insert_filter function=
, but don't use it here.<br>
<br>
Also, could we keep add/remove filter api in block/copy-on-read.c, like it =
is done for backup-top ?<br>
<br>
-- <br>
Best regards,<br>
Vladimir<br>
</div>
</span></font></div>
</body>
</html>

--_000_VI1PR0802MB22061455B6632D402C45ED88F4AF0VI1PR0802MB2206_--

