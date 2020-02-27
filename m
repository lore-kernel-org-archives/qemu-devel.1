Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5D1C4BA2D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B6B24695
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="O61vZ3fS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B6B24695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7IZJ-0004qj-TR
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7IYV-0004Jo-TU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7IYU-0001cE-61
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:46:19 -0500
Received: from mail-eopbgr140133.outbound.protection.outlook.com
 ([40.107.14.133]:34967 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7IYT-0001Z7-FJ; Thu, 27 Feb 2020 07:46:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrbr0OsDADLJoYrlwDUz3fDaFcyuA1hoXHDD1CBOUfxl1qARubX1NNbzzlXJIFyHEWJJRFBXcb9DR5St05TzRoqr9vZslLspjpa3eHNMt7F/Fn6BzMG8icxLQlESwFKXAloJ0mMkY2hF5RuQltcpv+ZHfhnA0XLCQoOBinyKdsLteiYcYWWXMyrv6pGxYt/iel+E10MQYf55oosoNeLX5eeg64lHjlchf2t7AwiRpUex/TNqrQs0R31y85bzT7HlVaw1HiIZMNmLvTYltqU/0D977m0JZris6OiMyNgJqXXJEMqkKfEBLfFAb1FjGC1+ebuv6Sv29ku2qnXVB/VfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hhk0mhzdRrB7BMqRQjOD0+Z+AL0RGjB0onHf3CdM8bI=;
 b=k1ymZQgo32EnWZCn1qbNQ5YPUUxKBJQPZ7hG7ZkdeCacZlbigOc3dh6lBh/lp9Zt+8VOlGmV8BLjVtnIzDzEXEHfnYi7SXboJbqUTcOyk/JHy+mF5fmRnpJ5dzd+JNRnx+x264y49q/On1azj/hl824Lln3k5SWCdWKVvd8Scn9xfqhbT4sGSjds0f7mBmWrWcajXdAPWQyIDj8/t8xlqkf93eIycaOkMvq4oQo0P4iouXw6T/Enz3vAoPGidZfgIGcpx5Z8uOVSbmC1qY+iMRvevKtiNpEDx3jB5YIavz41IMCQo6sVHLekHwM1n8dwhi0J9Cw4/7Knl33xcladcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hhk0mhzdRrB7BMqRQjOD0+Z+AL0RGjB0onHf3CdM8bI=;
 b=O61vZ3fSpuMm+3qV6AN/vE6oGnnIEM5gSVKaHMCPVV5qCBqd7Bla+AIyyxZFCK9le+q9DsEqshFLMBtUHw99M752ficKGaGRt9wNYALieooLs2mUfGF4m34geWOt4tHMs34NjD8zQatuhjHRtOf+mroho2TzZXNbwHeGK5cKG5w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3902.eurprd08.prod.outlook.com (20.178.80.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 12:46:14 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 12:46:14 +0000
Subject: Re: [PATCH v4 08/10] nbd/server: introduce NBDExtentArray
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200205112041.6003-1-vsementsov@virtuozzo.com>
 <20200205112041.6003-9-vsementsov@virtuozzo.com>
 <6396ff32-16a3-62fe-1001-fde8b5a4f431@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227154612365
Message-ID: <f23161d4-0bff-30aa-6700-70c532ff8db5@virtuozzo.com>
Date: Thu, 27 Feb 2020 15:46:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <6396ff32-16a3-62fe-1001-fde8b5a4f431@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0281.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::33) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0281.eurprd05.prod.outlook.com (2603:10a6:3:fc::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 12:46:14 +0000
X-Tagtoolbar-Keys: D20200227154612365
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f3574e4-c84a-4f8c-fb9a-08d7bb83080a
X-MS-TrafficTypeDiagnostic: VI1PR08MB3902:
X-Microsoft-Antispam-PRVS: <VI1PR08MB3902E4B2A4E42194D73F10E4C1EB0@VI1PR08MB3902.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(346002)(376002)(39850400004)(366004)(199004)(189003)(956004)(2616005)(4326008)(81166006)(81156014)(2906002)(6486002)(186003)(26005)(31696002)(8936002)(8676002)(31686004)(36756003)(66946007)(66556008)(16526019)(66476007)(53546011)(316002)(86362001)(52116002)(478600001)(16576012)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3902;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPk/5weRAKESFA2QYwbr4xKRCNYM5dzVtSZ6ppw+Sa4EhxrcGXt60/6/CtOJliFl3dgguyb0bZ8AoqmMFuCkch5Y/BATKUqZ/5ts9dVjBNj+IWQmbztn2M1go741hLOxL/0n8CC7BVOimE6Dex77UFquV0orW4/p24sDYcCQfPFI1oBM5/8TaYOgu4QDeXeqXekr4PiB0+XdNM4DZlTRSp17/KMjFVIZnZpdfrgaMFfWINTkS2NXGbko5k5aeu6zFtw4w49W6KAxpy2PKOpv7OZVogOojATlWBZ7O+T5lpwaS91cJTAIhI0dR+lCE5L1ZPZKuIOnZwAQj0r9V4X/tXt9IiXw5JjQX9UDaZEbzFQRQeTKUU+ZJTeo/sasA6PY3lUowCu6AQyXqm2uQ+CmIRy0SU2Zn9+o4e3KQZbmkTTvJ+qucjMOwBKnrCkdXPa7
X-MS-Exchange-AntiSpam-MessageData: O+UoAWoEJ8ygXuRf27vH/roF2qg7Duf1JXotrufPt1WVBs+G3qKdGPDqrvw/OaefyG2y/RQdD4FM6X22fupreiBHt7HBUQGWAc2ZAH6Jrbt2n3+7PUmlQkAjdHCX/MEEwQox05iri31m4rWXQX/WiQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3574e4-c84a-4f8c-fb9a-08d7bb83080a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 12:46:14.7331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmbcN6QXu5SdpnMkvDBgZZRhDqsx/P9ft01yjNBOqLXJoso6cYQWkVDizFRNr7Ypz1N360rbz+mcTmycb2H/LfcccFqilDSIZS33rtHo328=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3902
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.133
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

26.02.2020 18:06, Eric Blake wrote:
> On 2/5/20 5:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Introduce NBDExtentArray class, to handle extents list creation in more
>> controlled way and with fewer OUT parameters in functions.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 nbd/server.c | 210 +++++++++++++++++++++++++++++--------------------=
--
>> =A0 1 file changed, 118 insertions(+), 92 deletions(-)
>>
>=20
>> +
>> +/* Further modifications of the array after conversion are abandoned */
>> +static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
>> +{
>> +=A0=A0=A0 int i;
>> +
>> +=A0=A0=A0 assert(!ea->converted_to_be);
>=20
> Comment is stale - further modifications after conversion are a bug that =
aborts the program, not abandoned.

I always thought that "abandoned" is something that must not be done, so th=
e word works here. But I don't know English well).
May be:

"No further modifications of the array allowed after converting to BE."? Is=
 it better?

Or just drop the comment.


>=20
>=20
>> =A0 /*
>> - * Populate @extents from block status. Update @bytes to be the actual
>> - * length encoded (which may be smaller than the original), and update
>> - * @nb_extents to the number of extents used.
>> - *
>> - * Returns zero on success and -errno on bdrv_block_status_above failur=
e.
>> + * Add extent to NBDExtentArray. If extent can't be added (no available=
 space),
>> + * return -1.
>> + * For safety, when returning -1 for the first time, .can_add is set to=
 false,
>> + * further call to nbd_extent_array_add() will crash.
>=20
> s/further call/so further calls/
>=20
>> + * (to avoid the situation, when after failing to add an extent (return=
ed -1),
>> + * user miss this failure and add another extent, which is successfully=
 added
>> + * (array is full, but new extent may be squashed into the last one), t=
hen we
>> + * have invalid array with skipped extent)
>=20
> Long comment with nested ().=A0 I'm not sure it adds much value, I think =
it can safely be dropped.=A0 But if it is kept, I suggest:
>=20
> (this ensures that after a failure, no further extents can accidentally c=
hange the bounds of the last extent in the array)

works for me

>=20
>> =A0=A0 */
>> -static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset=
,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint64_t *bytes, NBDExtent *extents,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int *nb_extents)
>> +static int nbd_extent_array_add(NBDExtentArray *ea,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t length, uint32_t flags)
>> =A0 {
>> -=A0=A0=A0 uint64_t remaining_bytes =3D *bytes;
>> -=A0=A0=A0 NBDExtent *extent =3D extents, *extents_end =3D extents + *nb=
_extents;
>> -=A0=A0=A0 bool first_extent =3D true;
>> +=A0=A0=A0 assert(ea->can_add);
>> +
>> +=A0=A0=A0 if (!length) {
>> +=A0=A0=A0=A0=A0=A0=A0 return 0;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 /* Extend previous extent if flags are the same */
>> +=A0=A0=A0 if (ea->count > 0 && flags =3D=3D ea->extents[ea->count - 1].=
flags) {
>> +=A0=A0=A0=A0=A0=A0=A0 uint64_t sum =3D (uint64_t)length + ea->extents[e=
a->count - 1].length;
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 if (sum <=3D UINT32_MAX) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ea->extents[ea->count - 1].length =3D=
 sum;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ea->total_length +=3D length;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 if (ea->count >=3D ea->nb_alloc) {
>> +=A0=A0=A0=A0=A0=A0=A0 ea->can_add =3D false;
>> +=A0=A0=A0=A0=A0=A0=A0 return -1;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 ea->total_length +=3D length;
>> +=A0=A0=A0 ea->extents[ea->count] =3D (NBDExtent) {.length =3D length, .=
flags =3D flags};
>> +=A0=A0=A0 ea->count++;
>> -=A0=A0=A0 assert(*nb_extents);
>> -=A0=A0=A0 while (remaining_bytes) {
>> +=A0=A0=A0 return 0;
>> +}
>=20
> Looks like you properly addressed my concerns from v3.
>=20
> Comment changes are trivial, so you can add:
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Thanks!

--=20
Best regards,
Vladimir

