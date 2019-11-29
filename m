Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36D9C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1AA217BA
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CqfVazhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1AA217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadjD-0006WW-Ri
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iad49-0001Ya-MO
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iad44-0004sq-S3
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:59:54 -0500
Received: from mail-eopbgr10106.outbound.protection.outlook.com
 ([40.107.1.106]:64862 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iad44-0004ax-EA; Fri, 29 Nov 2019 04:59:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4yG00kF5Hc/BesN3fbRlTr08SANKW6aQ+pjf9f+yNNHrBi4XS2uLQKqUNyCiGoynsLZ8TN+oqj5uN057Og+GrlRzlcN217uRc0Bl92UTLRxjCu3RwC1WlA9ed4lClJUz5THip495TaQN4RxkNncfA3cdBEeIzJhil4lhKxPQTQlU0f3au4+E8X6PH1543E+oSVjt9zFqbsNA5fpQtWxSIZixp/InQzhUXVLDyXtdnSfC5q6qBZm71QrKkReFDJkNMEjyR+sNwZNKCoAJPSq76Iark2LLUEtLEDb+j1Np9o4euuq/4n7V0CIqqf9rjw151pZnIk5wBQ65KzifN5tfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G73ewjXLwwwhTcMv8rRvsbzm8f5klQtmuJMR66jz5cQ=;
 b=a8SjDYkr+D9RnqwwZHtyeIO5UXVsTdH6v4AdEOA4kyK5/R+IBhei0D9sp+9wq7NXlIuRIF7XN/P2qoe0Rhi16CVDIDG47zZzpB1GKZFJSQ8Y5Fz0LY/2oyxopZPBj4C4MKazRWjj50BdbjdbOjEq/8OAw7QnZEvyw91NsLkd6vLNpiCdRjulPTAZ+YzZKluPuK2lB3kvihzqJ/RxeDKXz4DLkM1PSa6GxNaQ6wdDWYYe46Etdy+9GYoE3ugwOUBxcmskq2K4l5l3c+HZAZIR+Zy+o1ZE6JNVVCm2MsBHvb288HazRYcFvVM3cag0UIbA54UTCLa52OkspcVO51WOsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G73ewjXLwwwhTcMv8rRvsbzm8f5klQtmuJMR66jz5cQ=;
 b=CqfVazhES4EC7dK1C5cKO1apGyaAB28eVL4mGYkwFRPpM0Nn58Rv8JA7qtfDVZgVjKYfCcVe6enltW8atz6cR99n/fsKEKiMrfurndpPeGbi9zJpJN6d/m9zjj8n20sctrQX9cG3VXbGYXEh4KKon55/uojiY2SIdhHZALtUYjw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4739.eurprd08.prod.outlook.com (10.255.97.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 09:59:46 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 09:59:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 09/23] quorum: Add QuorumChild.to_be_replaced
Thread-Topic: [PATCH for-5.0 v2 09/23] quorum: Add QuorumChild.to_be_replaced
Thread-Index: AQHVmKl4VCwIRwSEWUCadLGn1eIb1qeiBiAA
Date: Fri, 29 Nov 2019 09:59:46 +0000
Message-ID: <a3884493-4cd6-d565-ece0-1bd8a14e9aa4@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-10-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-10-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0271.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::23) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129125944386
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33a54ae0-863e-4bb6-866e-08d774b2dd45
x-ms-traffictypediagnostic: AM6PR08MB4739:
x-microsoft-antispam-prvs: <AM6PR08MB4739FD831D88825873307669C1460@AM6PR08MB4739.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:250;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(396003)(366004)(39840400004)(136003)(189003)(199004)(64756008)(66446008)(6116002)(5660300002)(6486002)(66556008)(7736002)(76176011)(52116002)(2906002)(6436002)(66066001)(81166006)(8936002)(99286004)(8676002)(14454004)(316002)(229853002)(305945005)(25786009)(81156014)(110136005)(478600001)(54906003)(71190400001)(4326008)(14444005)(66476007)(2501003)(66946007)(71200400001)(6246003)(26005)(102836004)(6506007)(446003)(11346002)(2616005)(6512007)(186003)(3846002)(31686004)(256004)(386003)(36756003)(31696002)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4739;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C9lZ0FvntUiBWmGvENuyO+iHcGRhND9HYRF2T9Nlszokvc5Zl5Ma81gL4xyQvlomPOkkzGXqYgTi32Uq4ES27VlIaTONZfuZqEqAzbcng2sZ2pT/JRQ4bmWZrwJzum9n3sFLHc8mDDJBg9M0I26hCPqmXwt3DgA7S5M46m9+AyVOk74zR55toLn+s7dEGljsznQeybyXgupNkaaR466PYqnkkkCSIcegvI3lwBhtCnUmdf+/6ruGwcBRvbjVP+2f08VH8Nq71K7uXolYUjnDYSNKAU/Opqdk8wETP6oACOaJQ4ZrEoFx8RXvsbRRbnu3qUmdq/C++mJqDSjysMUYwOXtsj5ql+9s5gTVwDYW81UjlEbKbMxDPtKEGe9/mDEfycfM1fmD9wosz850di28jE1kqntnhWW5k962jebFKW+I8rbMh5p1/BRWXvYEO+mv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <5204807F2F09EE479825FF12B0092646@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a54ae0-863e-4bb6-866e-08d774b2dd45
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 09:59:46.2775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0Q9L09wVVjH3NDCm2ZWOu0gcG/SOmS4V1wL+EH94rLCEOOL0QtN389AOgVS8oCdOSxpBZaArRpVHhrujEUlxNmuvlHxgj1P409aJKCBKBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4739
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.106
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.11.2019 19:02, Max Reitz wrote:
> We will need this to verify that Quorum can let one of its children be
> replaced without breaking anything else.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/quorum.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>=20
> diff --git a/block/quorum.c b/block/quorum.c
> index 59cd524502..3a824e77e3 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -67,6 +67,13 @@ typedef struct QuorumVotes {
>  =20
>   typedef struct QuorumChild {
>       BdrvChild *child;
> +
> +    /*
> +     * If set, check whether this node can be replaced without any
> +     * other parent noticing: Unshare CONSISTENT_READ, and take the
> +     * WRITE permission.
> +     */
> +    bool to_be_replaced;
>   } QuorumChild;
>  =20
>   /* the following structure holds the state of one quorum instance */
> @@ -1128,6 +1135,16 @@ static void quorum_child_perm(BlockDriverState *bs=
, BdrvChild *c,
>                                 uint64_t perm, uint64_t shared,
>                                 uint64_t *nperm, uint64_t *nshared)
>   {
> +    BDRVQuorumState *s =3D bs->opaque;
> +    int i;
> +

loop is still useless if c =3D=3D NULL...

if (c) {

> +    for (i =3D 0; i < s->num_children; i++) {
> +        if (s->children[i].child =3D=3D c) {
> +            break;
> +        }
> +    }


        assert(i < s->num_children);

}

> +
>       *nperm =3D perm & DEFAULT_PERM_PASSTHROUGH;
>  =20
>       /*
> @@ -1137,6 +1154,12 @@ static void quorum_child_perm(BlockDriverState *bs=
, BdrvChild *c,
>       *nshared =3D (shared & (BLK_PERM_CONSISTENT_READ |
>                             BLK_PERM_WRITE_UNCHANGED))
>                | DEFAULT_PERM_UNCHANGED;
> +
> +    if (c && s->children[i].to_be_replaced) {
> +        /* Prepare for sudden data changes */
> +        *nperm |=3D BLK_PERM_WRITE;
> +        *nshared &=3D ~BLK_PERM_CONSISTENT_READ;
> +    }
>   }
>  =20
>   static const char *const quorum_strong_runtime_opts[] =3D {
>=20

with or without "if (c)":

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--=20
Best regards,
Vladimir

