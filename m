Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EF9CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005A320856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OQoda0Oi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005A320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaOq-0008Ij-Sz
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1iNZvp-0007nu-Si
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1iNZvk-0002nE-V4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:01:25 -0400
Received: from mail-eopbgr40128.outbound.protection.outlook.com
 ([40.107.4.128]:11277 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1iNZvi-0002lI-Ds; Thu, 24 Oct 2019 06:01:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inL0Ve7vQGX1/6xl1VRthkjmzw2Qoa0y71mUXFRAfnaW/Tw16Ym0kD13HYGVOpmnrrLCiyvzBGJ9koGPMpQbTuzQ3zN/Y8p//K54CVchI5LwwBJ7RGSFLKRAcAYyt16B1hUoMFldNhJDTgv5AXwqKt3oGfUpzePwrviWlVaTc+eTf4m40FJBWLXYuHTgV7BViviKiRH7bUs0Poo+RwZ+PUli7n6Ia0YltT5DstgduaER4rPqEhWehJEYivPmTw6hUbWo8E18w6MFrCLq6Q8ZOYwbuJlB43f3n5qv5XnnT3Q7SC18TmrGZOG482VfM8IeCfU/OBaaY6wDVODIcd400g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+7gcgSywle+NG/2XrZwYEm8q2g1FDQTqiAIpXZd1ME=;
 b=MunA50zIdIonZyW0pNS21Zj5r4uoUPI/CipjtJ2ZNgJ38XfRTlrBFiYGDkx3bc2DswSe7HbD3vYzHTuaNXg0gr6lf35arUkgVXJBx9JuGjkts5bLS47S8Zs1Gp6cauo2w/urSh06xC+CRQo9KmTtvd/Dnib084L+FoyNik77mgxDx3x8gYNTTa8wPkRXD8KFwC/7zKZl8Hj/spnn7Xq37kQJPxeE5+j/HEst3+FthshJ2lQbzPpubpSsvfapoPy5QDy+UbSzAePFyOuV/uCqOJYh7pY28s4T7gRcrE3dWtVE5ZGZgjJXT9XQl3Di58Zg7vX+FhToYEpjapjk7J4t5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+7gcgSywle+NG/2XrZwYEm8q2g1FDQTqiAIpXZd1ME=;
 b=OQoda0OiOcguAJ6nCwDHDmlgWSWyRSMdnQSWuiW/wo8h8bpIIGLSuFTpIvtgnlFNe4GtPTC/tHp5u/40C18LjNBmItP6z9Q1r71fj9UwBBCq2MpO68MKpksfK1qn+l03say7qPrtP0kj6ohnJAnI+Pa5yzioK9O0+VgEKB0wwAQ=
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com (10.169.221.21) by
 DB6PR0801MB2103.eurprd08.prod.outlook.com (10.168.87.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 10:01:16 +0000
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34]) by DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34%7]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 10:01:16 +0000
From: Denis Lunev <den@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 2/3] qcow2: Assert that qcow2_cache_get() callers hold
 s->lock
Thread-Topic: [PATCH 2/3] qcow2: Assert that qcow2_cache_get() callers hold
 s->lock
Thread-Index: AQHVibZRoCM6NbrZp0+Q3TpWlZwDWKdpkIKA
Date: Thu, 24 Oct 2019 10:01:16 +0000
Message-ID: <3600fb84-e1f1-c70a-4b83-e7a379f50614@virtuozzo.com>
References: <20191023152620.13166-1-kwolf@redhat.com>
 <20191023152620.13166-3-kwolf@redhat.com>
In-Reply-To: <20191023152620.13166-3-kwolf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0010.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::20)
 To DB6PR0801MB1702.eurprd08.prod.outlook.com
 (2603:10a6:4:2f::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c720a5e-a206-4329-45a9-08d758691c1d
x-ms-traffictypediagnostic: DB6PR0801MB2103:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0801MB2103EFD55E944A677FE9C944B66A0@DB6PR0801MB2103.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(376002)(136003)(39840400004)(199004)(189003)(25786009)(71200400001)(14454004)(478600001)(256004)(81156014)(229853002)(305945005)(8676002)(36756003)(7736002)(486006)(54906003)(71190400001)(81166006)(14444005)(6486002)(6246003)(6436002)(5660300002)(6512007)(11346002)(2616005)(8936002)(476003)(76176011)(110136005)(86362001)(386003)(26005)(102836004)(53546011)(31686004)(4326008)(52116002)(186003)(446003)(99286004)(31696002)(316002)(66066001)(2906002)(66446008)(64756008)(66556008)(66476007)(66946007)(3846002)(6116002)(2501003)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR0801MB2103;
 H:DB6PR0801MB1702.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ovu16gpybheD1qo7+b4gQUtsyfi9pKTGPw+Y7DLIpxhAMVUpmVFTPrA+o0KkzKG87zRg1KsB/K1n3pHmn3SN+alGn4QbQBMWVap7JGYdIGCtb8lHUKVz2UdPN7rojl4L0n7WkHh8j8T3tMaUYWQZq4CwaOI94O2DBKBeZuMFGReS3tn+XZdGroeXSrS9FL3MZvXUaZiqWaw+QmuHComt3I9qXbg9aANbxV6IESVUKGLW5CieO79FJP0cXjuww0muYy4rZSg+E+l8q7XteTMrpfH014pRDunjbVT0a4Hco2MTDMYUVURdBw1wek8G6Nr84mzTS7RMem67nOUqSSx4LIz/mEuK81fZNs59pZRE5LQDnsy5QLk3s8jZTwd03dEJ+uZnOTgcmNH/N8/SoivYye+yqW6dk4+s1XJ32yvUZbwgU7nVmU3ivU+jYJLWIt0P
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <A6BDC543345E1A448CAC730B667F2815@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c720a5e-a206-4329-45a9-08d758691c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 10:01:16.4364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4MOo5h+9gmZVzGv5gNv6CBXK8SPsZIIjHUO8Ro0Vz5CZp26YrSuLxq5tp3mXGdkirEMf7haEeK2DSx2Esgnzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2103
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.128
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
Cc: "psyhomb@gmail.com" <psyhomb@gmail.com>,
 "michael@weiser.dinsnail.net" <michael@weiser.dinsnail.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 6:26 PM, Kevin Wolf wrote:
> qcow2_cache_do_get() requires that s->lock is locked because it can
> yield between picking a cache entry and actually taking ownership of it
> by setting offset and increasing the reference count.
>
> Add an assertion to make sure the caller really holds the lock. The
> function can be called outside of coroutine context, where bdrv_pread
> and flushes become synchronous operations. The lock cannot and need not
> be taken in this case.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2-cache.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
> index d29b038a67..75b13dad99 100644
> --- a/block/qcow2-cache.c
> +++ b/block/qcow2-cache.c
> @@ -327,6 +327,9 @@ static int qcow2_cache_do_get(BlockDriverState *bs, Q=
cow2Cache *c,
>      int min_lru_index =3D -1;
> =20
>      assert(offset !=3D 0);
> +    if (qemu_in_coroutine()) {
> +        qemu_co_mutex_assert_locked(&s->lock);
> +    }

that is looking not good to me. If this is really requires lock, we should
check for the lock always. In the other hand we could face missed
lock out of coroutine.

Den

> =20
>      trace_qcow2_cache_get(qemu_coroutine_self(), c =3D=3D s->l2_table_ca=
che,
>                            offset, read_from_disk);
> @@ -386,6 +389,8 @@ static int qcow2_cache_do_get(BlockDriverState *bs, Q=
cow2Cache *c,
>          }
>      }
> =20
> +    assert(c->entries[i].ref =3D=3D 0);
> +    assert(c->entries[i].offset =3D=3D 0);
>      c->entries[i].offset =3D offset;
> =20
>      /* And return the right table */


