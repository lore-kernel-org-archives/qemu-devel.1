Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EABC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC0720833
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A4vlpkwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC0720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaeWh-00074i-60
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iaeER-0002uV-CK
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iae51-00018b-IB
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:04:58 -0500
Received: from mail-eopbgr60122.outbound.protection.outlook.com
 ([40.107.6.122]:33282 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iae51-0000yd-6Y; Fri, 29 Nov 2019 06:04:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irvxVQOBIKlyiCBoq5JN9xznpeUooSdzSi+cDZ05TfBrhrVpCuA1VPme/sOqF4JZn1s+knRVxx+EZVX/PVVmAZ+9i4CNbRJHXw/lbkomJfxVvlC9whsYueKBnmHZjYayo+sqFK6DfGWA6E5oxhyqwzoeR+yY4DYlDpbAksIyddvnklIP8WS+jwGpgBwU52p3rE2epm7AfJCKpCAZ/ZE0cri8qmN70q5ZNYjkdFH7cj0aAMbpAt9BesSm/cPsxV6m/NYwtkcTUw8Y4CxmjJuR4oWy9Abi0q4P3dnthZvoEahLl3v0x5wrblwDVxDiRNCvF0wnXoRd3OxWJ5r63nnSow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXmabFhYX2Mgc0y7R+QJcrq8mSK9XhOSBK6bOwV8vss=;
 b=Fs6c/0TGmQhdCxaJRLiPv6RjsDIkSyDI0RVN1817AnATUjMX0jwAqGzDgQewPb/sk8BGPH+H+OCNP5gpx5hNoV9G/7RIDxYwa2MJ5sBtUVD/XJPkbNR7FKCqgBC0P53QahxV9WgO2yhXgksV4m9iyMKi3Qya+KTTJHEpgXQc21hNn6084Qx1LT/B0RZyY3xqbGODi9crAyklmrhoD2ICZ2qzvy+BpmC3JWDXamd/K8svDvmYLBxhBMxzcxAtPO9GH5/IeyRb7QheR0LvhrzFAYiyr7ePLSRQTROg3WXr285FskBZXP7Ga8N++5MNBtSrLkvSC2aDErW1bdG2U+lMFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXmabFhYX2Mgc0y7R+QJcrq8mSK9XhOSBK6bOwV8vss=;
 b=A4vlpkwXpooal1sybHhSbl2PSRXvA6cPEtmOVbL0tNteE7Zp0xHjgVnE2n0+/qxHtjdef+HDUkRZpi5oWWpV5h8XaAoYPbCI9Qcr5oNlZnEQ8ejN8m4WasPL7BZ/Z6CYtXjQ2EV2Tnr1OdAhh3c5xeQhblG9bmM5Gziut+mvzaQ=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4325.eurprd08.prod.outlook.com (20.179.18.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 11:04:52 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 11:04:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 06/23] block: Add bdrv_recurse_can_replace()
Thread-Topic: [PATCH for-5.0 v2 06/23] block: Add bdrv_recurse_can_replace()
Thread-Index: AQHVmKl0WF/VLFkw5UGbjTiBCl5DpaeiMWcA///bcYCAAAt3gA==
Date: Fri, 29 Nov 2019 11:04:51 +0000
Message-ID: <f50d5578-8f4f-42aa-3984-083aef0e82c6@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-7-mreitz@redhat.com>
 <5370cd61-413a-0208-541c-49894ad0c630@virtuozzo.com>
 <c9dff2ff-cea7-8397-8fc6-b393723a4895@redhat.com>
In-Reply-To: <c9dff2ff-cea7-8397-8fc6-b393723a4895@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0008.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::18)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129140449561
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f9e4060-9309-454c-899a-08d774bbf4f9
x-ms-traffictypediagnostic: AM6PR08MB4325:
x-microsoft-antispam-prvs: <AM6PR08MB432577CA86ACEA0D32421889C1460@AM6PR08MB4325.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(6506007)(256004)(66556008)(76176011)(26005)(102836004)(186003)(6246003)(386003)(2616005)(53546011)(11346002)(52116002)(8936002)(14444005)(446003)(2906002)(6116002)(31686004)(71200400001)(8676002)(3846002)(81156014)(71190400001)(2501003)(4326008)(14454004)(81166006)(86362001)(66476007)(66946007)(305945005)(316002)(31696002)(7736002)(36756003)(25786009)(6512007)(99286004)(6436002)(110136005)(54906003)(5660300002)(64756008)(478600001)(229853002)(6486002)(66446008)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4325;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AlZCu00LSuNfETnWDaCJVn4bzbSXooZ6gJh+1Zob4dvEldd51XzNIV+egN0++d697Obm38Zd5k13k0PavL9szcyYMulfSRaGbKfkzPQMnWyJ1VcLpPe1Z9v9OZoQKTQAfbBN5jzF4VQGX8282oza7Nd7NhfFPl9CtcdMtgzWyKBjWRlCO0k4zHvCpFoIOik4v26au7eG4RRjdUbf4JwagL2T/tCpWMWNnBqXXl55+3Zo6OFR6zB5vLsGf3CVUrF89icJ0ZL3l1iHJ9roa+mY+1RF0ggDAQz0pUVTrsvKjDPYhPifgyWaxT3EfcFia6l7a+YWM/IH2FUhgCMVdmpUVI5cL9GclvOCSaCr27MSSEhWqT8UkRj/YxxWVj+bl0hsU80+s5Xs9S7On86WYX5V3QbVFNah+KJMryhe27bjng1t+KRnPWRUDSF57g4izmQa
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <C5629C4F53724A4397DFA90E49AFFF23@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9e4060-9309-454c-899a-08d774bbf4f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 11:04:51.7263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jk7nLfvbCqsM3R50rvS9iGYKkg0CUUtC8WJnjsNMGtRXYmdkymX45FXS8j+MTG0jyG/dxNbh2F0Nz4xKs0IO9SU+ZKa1opKeGlh2+BN8ZtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4325
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.122
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

29.11.2019 13:23, Max Reitz wrote:
> On 29.11.19 10:34, Vladimir Sementsov-Ogievskiy wrote:
>> 11.11.2019 19:01, Max Reitz wrote:
>>> After a couple of follow-up patches, this function will replace
>>> bdrv_recurse_is_first_non_filter() in check_to_replace_node().
>>>
>>> bdrv_recurse_is_first_non_filter() is both not sufficiently specific fo=
r
>>> check_to_replace_node() (it allows cases that should not be allowed,
>>> like replacing child nodes of quorum with dissenting data that have mor=
e
>>> parents than just quorum), and it is too restrictive (it is perfectly
>>> fine to replace filters).
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    block.c                   | 38 +++++++++++++++++++++++++++++++++++++=
+
>>>    include/block/block_int.h | 10 ++++++++++
>>>    2 files changed, 48 insertions(+)
>>>
>>> diff --git a/block.c b/block.c
>>> index 9b1049786a..de53addeb0 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -6205,6 +6205,44 @@ bool bdrv_recurse_is_first_non_filter(BlockDrive=
rState *bs,
>>>        return false;
>>>    }
>>>   =20
>>> +/*
>>> + * This function checks whether the given @to_replace is allowed to be
>>> + * replaced by a node that always shows the same data as @bs.  This is
>>> + * used for example to verify whether the mirror job can replace
>>> + * @to_replace by the target mirrored from @bs.
>>> + * To be replaceable, @bs and @to_replace may either be guaranteed to
>>> + * always show the same data (because they are only connected through
>>> + * filters), or some driver may allow replacing one of its children
>>> + * because it can guarantee that this child's data is not visible at
>>> + * all (for example, for dissenting quorum children that have no other
>>> + * parents).
>>> + */
>>> +bool bdrv_recurse_can_replace(BlockDriverState *bs,
>>> +                              BlockDriverState *to_replace)
>>> +{
>>> +    if (!bs || !bs->drv) {
>>> +        return false;
>>> +    }
>>> +
>>> +    if (bs =3D=3D to_replace) {
>>> +        return true;
>>> +    }
>>> +
>>> +    /* See what the driver can do */
>>> +    if (bs->drv->bdrv_recurse_can_replace) {
>>> +        return bs->drv->bdrv_recurse_can_replace(bs, to_replace);
>>> +    }
>>> +
>>> +    /* For filters without an own implementation, we can recurse on ou=
r own */
>>> +    if (bs->drv->is_filter) {
>>> +        BdrvChild *child =3D bs->file ?: bs->backing;
>>
>> should we check that child !=3D NULL ?
>=20
> I=92d say that normally (once they are open) filters must have a child,
> and so I=92d make it an assertion.  But then again an assertion isn=92t m=
uch
> better than the dereferencing that follows, I think. :?
>=20
> Max

OK then.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

>=20
>>> +        return bdrv_recurse_can_replace(child->bs, to_replace);
>>> +    }
>>> +
>>> +    /* Safe default */
>>> +    return false;
>>> +}
>>> +
>>>    BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
>>>                                            const char *node_name, Error=
 **errp)
>>>    {
>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>> index dd033d0b37..75f03dcc38 100644
>>> --- a/include/block/block_int.h
>>> +++ b/include/block/block_int.h
>>> @@ -102,6 +102,13 @@ struct BlockDriver {
>>>         */
>>>        bool (*bdrv_recurse_is_first_non_filter)(BlockDriverState *bs,
>>>                                                 BlockDriverState *candi=
date);
>>> +    /*
>>> +     * Return true if @to_replace can be replaced by a BDS with the
>>> +     * same data as @bs without it affecting @bs's behavior (that is,
>>> +     * without it being visible to @bs's parents).
>>> +     */
>>> +    bool (*bdrv_recurse_can_replace)(BlockDriverState *bs,
>>> +                                     BlockDriverState *to_replace);
>>>   =20
>>>        int (*bdrv_probe)(const uint8_t *buf, int buf_size, const char *=
filename);
>>>        int (*bdrv_probe_device)(const char *filename);
>>> @@ -1264,6 +1271,9 @@ void bdrv_format_default_perms(BlockDriverState *=
bs, BdrvChild *c,
>>>                                   uint64_t perm, uint64_t shared,
>>>                                   uint64_t *nperm, uint64_t *nshared);
>>>   =20
>>> +bool bdrv_recurse_can_replace(BlockDriverState *bs,
>>> +                              BlockDriverState *to_replace);
>>> +
>>>    /*
>>>     * Default implementation for drivers to pass bdrv_co_block_status()=
 to
>>>     * their file.
>>>
>>
>>
>=20
>=20


--=20
Best regards,
Vladimir

