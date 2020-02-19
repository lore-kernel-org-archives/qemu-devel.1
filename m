Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE725C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A5824654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KJSxwawu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A5824654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4RKM-0000fH-Qm
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 10:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4RJK-00007p-Cb
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4RJJ-0000LK-4N
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:30:50 -0500
Received: from mail-db8eur05on2125.outbound.protection.outlook.com
 ([40.107.20.125]:38881 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j4RJF-0000GU-Qy; Wed, 19 Feb 2020 10:30:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYqn1GmZyB0t6Khhbt018Hu6CSISNzO9XWBvwY7JWnec1/mMX2hvTcxoocIRTF3NvluINO6uFb2w5zz3ZvjE98QIZDiHoEFp33BnYgXEIDuAYTLfvD/WHrZGenEFFFmP6L8Pv+GwFysB2PFrT/k+uJRLHcfj+X/1FhlLkB5AynIXqHhMgBnCqGZO4kpgM1oKBJx/VR1sAfry0gh7S6RTu0b+l+m554Sl0NYzVfrLyxLamclvulqgDmwIzrXgQDYHGMJiNjlWMEZxQSJR/mgtAbLyLHGQsWRHMSzrgzgxJr+WSN9YvUzpl6L2gSWLiubDe6lSgHlwWWtUb/GskWANnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BgpJFUn9SygS/Tf6AM98P/ttCsAigpp6AEKNEMWyTE=;
 b=CJAaYO+wFC/5MwgKpaPQCrr0krK4h0X481D2LC/YX6hT4Zn0WRpKGewljwARS190iZV1k+77Xlf4XvDJ41mDxV8jBp+kvcIBH4WRiOanHSKATnmfBx9JIdHJpnBe69jD6NfOubYAmenVvLHV10b4Rv/bJVIkDp3sPVUuAxN91SlCgJWEK5S6MqEDc8Ug3k9ijmK1e+BGYEW+F+GH7RCMXiybQbh6AfwC3DIMb/8ZvDm6h/+ua4llVSlUYeBkBALCCSapTM2kR6YXwE2OkV9UbRxe+QW9OI5R4lMPfhgpbaP7OL/BFTGuFtpOZhJRGbw7geMCduUWuwS2kSWb2c1ffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BgpJFUn9SygS/Tf6AM98P/ttCsAigpp6AEKNEMWyTE=;
 b=KJSxwawuhJpEYhZBacytlRSKLLBKvhH/F1QkDWQUmtYAZXm946jC6X3o6LJvE64BH0S6CwZTirnXxNfJauXaTkjoZU3WtV2GTz2QAGRpIs5J8P4UdbYBeCIeJoP/eh0C949H09k+ypY3+IuKf8mWbIJJtiaBInI6E3s4l+A8lAM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3909.eurprd08.prod.outlook.com (20.178.91.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 15:30:44 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 15:30:44 +0000
Subject: Re: [PATCH v2 07/22] migration/block-dirty-bitmap: simplify
 dirty_bitmap_load_complete
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-8-vsementsov@virtuozzo.com>
 <4682455a-db9d-f1af-9b45-f0bce493d17c@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200219183041569
Message-ID: <32bdbcd8-a87a-93d8-cc8b-140617bbcda6@virtuozzo.com>
Date: Wed, 19 Feb 2020 18:30:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <4682455a-db9d-f1af-9b45-f0bce493d17c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0301CA0024.eurprd03.prod.outlook.com
 (2603:10a6:3:76::34) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0301CA0024.eurprd03.prod.outlook.com (2603:10a6:3:76::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25 via Frontend Transport; Wed, 19 Feb 2020 15:30:43 +0000
X-Tagtoolbar-Keys: D20200219183041569
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ca25e88-c605-4753-f952-08d7b550af11
X-MS-TrafficTypeDiagnostic: AM6PR08MB3909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB39094872AA6C870BF4C7D093C1100@AM6PR08MB3909.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(366004)(376002)(39850400004)(396003)(199004)(189003)(8676002)(2616005)(54906003)(8936002)(66556008)(16576012)(81166006)(956004)(316002)(186003)(5660300002)(53546011)(66946007)(81156014)(26005)(31686004)(66476007)(4326008)(16526019)(31696002)(52116002)(2906002)(478600001)(86362001)(6486002)(36756003)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3909;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AE2tMni0a8jKJ2VH+gWycXb5hOOFR5H6fRT3Kr5I+iVQDgczKMgg005vwM4rSmdKTJDDJmC+IEFO3KFmk/olsI1tFCI6/JUuciVACCs8mTH0IoZezJhdUZvu2kPyT2mg62rFTlKVOmWINutZeRa2yqs+o8PEY5E7aInEN4FmUeZ3FfuRTn0GTpdgWMibO/kkGlHTlJ3cndSK3FjtCgZcMwG1lFyOhYZVE9CZAvb+RTnf54fvmasYATYJ3i2ySVlAjY+68orzoYM6cJ0iNDJlAFUe/TyC1qTn2d+3Mquz1urrSOlJzf+RDgcJ0QKGEeBz5XplV05kQxgu7S2AUINAwEeuhysPqTUxT+7edgSqi+HhW/e0/i+jWa0ouWeZaXWFDN08678WFQx0Zr3KNbmRJTbG5byTGEW5Czig27UZqW93rDeUiPEFcw23GGCUN4IQcfboXDrxJlozw8ZyJfCOog/0Dw6N8+BD7nVJcjGcOatKaDQ0Ixfs/jIisPkGpHje
X-MS-Exchange-AntiSpam-MessageData: m7+vShZjnokGHmuEzKk7Kku09Ii9p5kGpvJvegp21kZ0a9XoQuctE3KlSLOhmNfPXMjrTMvUjW7ivktfz/BKmFLnA2GWwVxiHrzkR2ezn5iRAwDxgUpH6ckZQ1Gjr7b6KdqU/VIlrIcepo8ew/h/rA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca25e88-c605-4753-f952-08d7b550af11
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 15:30:43.9733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6hZu5McFz4JLV/s51Gqmsg/C0ax5HcrBpvG/ApSg8DhC+VbCatGR3Ju0FcMjY0xyQPu35qz1iOtyxlKpzznI2EkVipEw0f+VD7rUgJOjjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3909
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.125
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, quintela@redhat.com,
 dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

18.02.2020 17:26, Andrey Shinkevich wrote:
> On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
>> bdrv_enable_dirty_bitmap_locked() call does nothing, as if we are in
>> postcopy, bitmap successor must be enabled, and reclaim operation will
>> enable the bitmap.
>>
>> So, actually we need just call _reclaim_ in both if branches, and
>> making differences only to add an assertion seems not really good. The
>> logic becomes simple: on load complete we do reclaim and that's all.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 migration/block-dirty-bitmap.c | 25 ++++---------------------
>> =C2=A0 1 file changed, 4 insertions(+), 21 deletions(-)
>>
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitm=
ap.c
>> index 440c41cfca..9cc750d93b 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -535,6 +535,10 @@ static void dirty_bitmap_load_complete(QEMUFile *f,=
 DBMLoadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_lock(&s->lock);
>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
> What about making it sure?
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(!s->=
bitmap->successor->disabled);

I'm afraid we can't as BdrvDirtyBitmap is not public structure

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_reclaim_dirty_bitmap(s-=
>bitmap, &error_abort);

But we can assert that resulting bitmap is enabled.

>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (item =3D s->enabled_bitmaps; item; i=
tem =3D g_slist_next(item)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LoadBitmapState *=
b =3D item->data;
>> @@ -544,27 +548,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f,=
 DBMLoadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_lock(s->bi=
tmap);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->enabled_bitmaps =3D=
=3D NULL) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* i=
n postcopy */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv=
_reclaim_dirty_bitmap_locked(s->bitmap, &error_abort);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv=
_enable_dirty_bitmap_locked(s->bitmap);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* t=
arget not started, successor must be empty */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int6=
4_t count =3D bdrv_get_dirty_count(s->bitmap);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bdrv=
DirtyBitmap *ret =3D bdrv_reclaim_dirty_bitmap_locked(s->bitmap,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* b=
drv_reclaim_dirty_bitmap can fail only on no successor (it
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * must be) or on merge fail, but merge can't fail when second
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * bitmap is empty
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asse=
rt(ret =3D=3D s->bitmap &&
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count =3D=3D bdrv_get_dirty_count(s=
->bitmap));
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_unlock(s->=
bitmap);
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock(&s->lock);
>> =C2=A0 }
>>
>=20
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


--=20
Best regards,
Vladimir

