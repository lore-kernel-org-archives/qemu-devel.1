Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DFDC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9C320578
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lH/TWb/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9C320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4STS-0006XP-UL
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:45:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4Rzt-00035s-DF
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4Rzs-0002wM-5f
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:14:49 -0500
Received: from mail-eopbgr70103.outbound.protection.outlook.com
 ([40.107.7.103]:5277 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j4Rzp-0002uZ-EW; Wed, 19 Feb 2020 11:14:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb+Jhz+9h11Wq1iRoffIdVaOmWOI2CJ8PH04L8ns2hYmJIlll5mVs/VdsAexStpGgx81lU+NaBtihSWnPFkrdnyTZMYq8R98UVum1AJsjwRVByznisyJZTgsWo3A6VC/1LU+NM1aRmjxkXYCYktWMLJZBqq+O4UXqj4/xl3wF5FiHEft6X3a531Tfujenru01UmMCBR0JoXDq6HjFOgEIvc66LEBAiKk3/mg5HLYs0XlAQE/KNaZnYuN6ezp9d6sg0DErcWgpPra7lOL7uf0HNExCDa2ET0KV1JsFelPAXb8Y29LnwX6TVCaDZi1k6Iy5NebcR5ranCoj7jH4ymzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5zVcTungZKg50XGcZhVj8fPLhY2A8H47wgKzjS4cQ8=;
 b=BddHu90VI5N+UMALg1MqAyWHnZG0iDRDr5KixAfOTTfTyeM1e536eH/bZWWx9tcDErR/XQU9PfNwpTnCP+Ewpwxae882rZ1LENb5jMwk9tma9m5zXI4rH807+lQ7UmJ8nyce0XIUt2rwMcS23IVWuBScnT+gQ2eCKDEQbcRhwOgWFtsdrMZzhGZqoOytRfPey/o0z11ajBuJb/0xHTHTqE6CfX1SHK/ZUHbLekQOeYxCaUujvKscneREvvZSiaFHYBFiUbhMlIsXEV9Z2c122UQgORKyprmJuoJE0NOYUFp/i8ZbJDjPHQzPuPZPlyZyhp9yIwUiTonnGj+Na1tpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5zVcTungZKg50XGcZhVj8fPLhY2A8H47wgKzjS4cQ8=;
 b=lH/TWb/teXrD/UGJJ7TRj3mt/pDuv01gDFlOGxDxDEeE+XwhaW9Q6S+fh39gMdo1sE6Hjqyuw/amu+8cEh8cWY239poIsmwrtrnUozmIznWB3ge9rwVCvbLK0gir9bUZebbze+TBRgL3XP3S+MQY4LFlqHr+JgxW+kUMcARL2QE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5061.eurprd08.prod.outlook.com (10.255.34.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 16:14:41 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 16:14:41 +0000
Subject: Re: [PATCH v2 07/22] migration/block-dirty-bitmap: simplify
 dirty_bitmap_load_complete
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-8-vsementsov@virtuozzo.com>
 <4682455a-db9d-f1af-9b45-f0bce493d17c@virtuozzo.com>
 <32bdbcd8-a87a-93d8-cc8b-140617bbcda6@virtuozzo.com>
X-Tagtoolbar-Keys: D20200219191439320
Message-ID: <ad93a0f1-d5fd-87f1-a27b-3fe6c822f4cd@virtuozzo.com>
Date: Wed, 19 Feb 2020 19:14:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <32bdbcd8-a87a-93d8-cc8b-140617bbcda6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR07CA0016.eurprd07.prod.outlook.com
 (2603:10a6:7:67::26) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR07CA0016.eurprd07.prod.outlook.com (2603:10a6:7:67::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.9 via Frontend Transport; Wed, 19 Feb 2020 16:14:40 +0000
X-Tagtoolbar-Keys: D20200219191439320
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2b88aef-4842-479b-681d-08d7b556d36b
X-MS-TrafficTypeDiagnostic: AM6PR08MB5061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5061137DEA61B1AAFA93AA42C1100@AM6PR08MB5061.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(396003)(366004)(39850400004)(376002)(199004)(189003)(66476007)(478600001)(66556008)(86362001)(16576012)(956004)(2616005)(54906003)(53546011)(52116002)(31696002)(316002)(66946007)(8936002)(5660300002)(81166006)(8676002)(186003)(16526019)(26005)(81156014)(36756003)(2906002)(31686004)(4326008)(6486002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5061;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffJu5sc+oBWYy/8ncXHt0InhL3BKrNhKlC/wHZPbHCcASSdP2qLYjUDo+brddKw2Fb+XlVUkZ3ZeVLvHLbrWKLNJoNSz4jfhmSay2nvYsTx9lOfsxGhPkSY5QhQvyA0XCEL+K163zQTelDAarjn8u2gvpMhih2BXSIlRhDRgG4xxv0kSU0pDSxyNxXykWhGRRe2neGA9OzDP3VdqQWtMxHQPCS3nFaB/Zr9cw6OTxcQT4L5PgB0stN+Qy8KZbY2shxy4bQKwUpYtXDUEr15AxnTHsFliU0nuvjTNvtcaY2RBB34E0Y8AfQAr8t368FLJDTpRJODoDTcaShwG1hzvSUsZd7XdRWeigcHadu/El26Zo/WDyacBRak7pc+N1sqdaCdkTl6AHu+jQWPMCdHbO1Q+PRd9ZmfOJMrLR4fOTL77GkzUvrJ2ETG0LNwik77dwtnk+assQsbEQoLLAOjJgu3tINdJUXuhPnlNsUuKlzPJ7obFFFwyF5rLVwDhkEts
X-MS-Exchange-AntiSpam-MessageData: Y1Dg0Zrg0cqRJtoEMESPtTs7mdSNadlH3RM+Qh6lpPZm2pbpVnjVo4vnbVnD3zXPZrUA240DKdxJrKXX352cgCsIMNiYRnTISiDbbCN6Hw3W83znKqZmEBk7dcI0lIRZ2gOrzUkaspHIu/u7p5Mngw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b88aef-4842-479b-681d-08d7b556d36b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 16:14:41.6580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VF7sey1nCeFiI1cSmSbtAc1YBSGMBVpA382DTGgqGw9ryTQX9kfLMg4FQ+yPXnjwRWM6G/5Rcie1mD3xZHkuXqJ0BF/HyjVo1RRKKkm13Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5061
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.103
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

19.02.2020 18:30, Vladimir Sementsov-Ogievskiy wrote:
> 18.02.2020 17:26, Andrey Shinkevich wrote:
>> On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
>>> bdrv_enable_dirty_bitmap_locked() call does nothing, as if we are in
>>> postcopy, bitmap successor must be enabled, and reclaim operation will
>>> enable the bitmap.
>>>
>>> So, actually we need just call _reclaim_ in both if branches, and
>>> making differences only to add an assertion seems not really good. The
>>> logic becomes simple: on load complete we do reclaim and that's all.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =C2=A0 migration/block-dirty-bitmap.c | 25 ++++---------------------
>>> =C2=A0 1 file changed, 4 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bit=
map.c
>>> index 440c41cfca..9cc750d93b 100644
>>> --- a/migration/block-dirty-bitmap.c
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -535,6 +535,10 @@ static void dirty_bitmap_load_complete(QEMUFile *f=
, DBMLoadState *s)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_lock(&s->lock);
>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
>> What about making it sure?
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asser=
t(!s->bitmap->successor->disabled);
>=20
> I'm afraid we can't as BdrvDirtyBitmap is not public structure
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_reclaim_dirty_bitmap(s=
->bitmap, &error_abort);
>=20
> But we can assert that resulting bitmap is enabled.

Or not, as bitmap may be not yet enabled, if guest is not yet started.

>=20
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (item =3D s->enabled_bitmaps; item; =
item =3D g_slist_next(item)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LoadBitmapState =
*b =3D item->data;
>>> @@ -544,27 +548,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f=
, DBMLoadState *s)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_lock(s->b=
itmap);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->enabled_bitmaps =3D=
=3D NULL) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* =
in postcopy */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdr=
v_reclaim_dirty_bitmap_locked(s->bitmap, &error_abort);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdr=
v_enable_dirty_bitmap_locked(s->bitmap);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* =
target not started, successor must be empty */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int=
64_t count =3D bdrv_get_dirty_count(s->bitmap);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bdr=
vDirtyBitmap *ret =3D bdrv_reclaim_dirty_bitmap_locked(s->bitmap,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* =
bdrv_reclaim_dirty_bitmap can fail only on no successor (it
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * must be) or on merge fail, but merge can't fail when second
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * bitmap is empty
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ass=
ert(ret =3D=3D s->bitmap &&
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count =3D=3D bdrv_get_dirty_count(s=
->bitmap));
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_unlock(s-=
>bitmap);
>>> -=C2=A0=C2=A0=C2=A0 }
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock(&s->lock);
>>> =C2=A0 }
>>>
>>
>> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>=20
>=20


--=20
Best regards,
Vladimir

