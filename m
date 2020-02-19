Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF3CC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4599B208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J6IWMWC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4599B208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ROo-0002Sn-E0
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 10:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4RNd-0001Zm-1Z
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4RNS-0004Qr-Ue
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:35:16 -0500
Received: from mail-eopbgr140121.outbound.protection.outlook.com
 ([40.107.14.121]:62530 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j4RMr-0003o0-4c; Wed, 19 Feb 2020 10:34:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOTYFFZ/EfQw5LO+XmQ8ZPmrshnvEuEhvFWQAsek9JH08xgG3B2vDZ69ClidSsg7BUepM6N/FKDUCHBvHhD40IqXhVjHX2mlR6hZAOlESwVTYlluz7Hukob/E8u71KaelPvAWT6G4oIyPV5lYoOmXtwnEBgsLlFdBwaeAzXBmoBiKy96dnrRwejvf9G6mNAvLWI/hr3DSYq6wjebDhN/DeijziujNUY7XvLHfkBl4Sp+vlCDLOuxMH8qMnybcwGAwsH3wuqQ11HdfRQuOrtjgX+LRzYaZTVilsIkan5vPkM6ri+eL67SyKkjqWoLF97VRb0QTgHLdaGV0rCSMDViSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2IrXxMr2ZxYfwlUDAAcHPAsqP4KeWlbrnKce8/+370=;
 b=mwM1ugOZ6YIg4AgKMymHG+d8u91YIEcK7lD+JHbOda+8OK0vwIhfVuADsPZYGwFUncGPWS92NaSWbUjjKVwAR0aYOfm/JPiWw19MmimbdZzNsvom7L1RI7SVRhkaOTANnhOlrN382jWCZoIdD88T31Rav359ytTOD4O7PSfD+Jvxbv45OuuUNR2Bpc/Ua7au/f70xmicKcjHXKM4e9+spgYRrULLBFyFAdrqLsnm2DCug/tGNBMLyQE9LwV5tm4ibgjMrgg5VsmMH68h1fPgZEYNydK9Yk9puKQOAtpWMK4JU8izYuH7xOJ3y7ek7nqHkpZkbkEpi3ARYdeISzmBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2IrXxMr2ZxYfwlUDAAcHPAsqP4KeWlbrnKce8/+370=;
 b=J6IWMWC5yPUZ7GQdnJiSI154KdmxdtYWHK0lAv92ancrviJNLfGvyGPAdi+Oi3ghsFGl8iF8ITZlpLEU4OxpwqdZc0N0XDkb3d2HFM1XWFJ/iZvQQ6VXNrPNPFiz8/R4uXbNguV/zjAwWcPghMLcH4grfpTgt9RuXCn92DooBYE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3445.eurprd08.prod.outlook.com (20.177.112.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Wed, 19 Feb 2020 15:34:26 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 15:34:26 +0000
Subject: Re: [PATCH v2 09/22] migration/block-dirty-bitmap: relax error
 handling in incoming part
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-10-vsementsov@virtuozzo.com>
 <9a2bb54f-108b-a4bd-37e2-8382112c84ee@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200219183424112
Message-ID: <3f7d5627-7ec6-d287-989c-60d3b96ef5ec@virtuozzo.com>
Date: Wed, 19 Feb 2020 18:34:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <9a2bb54f-108b-a4bd-37e2-8382112c84ee@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0202CA0020.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0202CA0020.eurprd02.prod.outlook.com (2603:10a6:3:8c::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 15:34:25 +0000
X-Tagtoolbar-Keys: D20200219183424112
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 295b3114-f20c-44b0-e51a-08d7b55133a8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB34458658D889E520978FD058C1100@AM6PR08MB3445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:295;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(8936002)(66556008)(16576012)(52116002)(956004)(6486002)(316002)(54906003)(66476007)(31696002)(5660300002)(186003)(2906002)(81156014)(31686004)(16526019)(81166006)(8676002)(478600001)(86362001)(4326008)(26005)(53546011)(36756003)(66946007)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3445;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHNgKe3nfy3uAPFpH4xQkBYHkoK2G2FB/gE0ivORDBCK77BDgECgwD0qmwFfep1Yb19pGQoMBgJYrKzFxUokKyc8VG2lPPMN7laXR7VRG0eJICy3s+dIRsxApL+0cQFdXBLRALVDKhgemkjo66wPdOcomi/A9xtXBbqEPTR442ab+3WWkGKnJ75Bg095aa2FJeqZgJul7Mh9onGYds9TxdI/yJQ6xbS0sg6emqC4Tnw4JyppxTNYGUiYN0jWomX24t2gC0+JkOuIX+wPe/v29rtV5IqTIsRSjjRF0OpVsEl8Cyh8ed1CsUvy/MPaQSez80G5Mb1Sd2x/E5j1VNASduynAoYrQ/5lxnkUzMZn5Wakp/0V3HmfCpYA8zxnKQrU+j5nh6PtxvvNCsjCGGArfXYJGRK5SlVISPccsN01bN17qkz+xil84KUaiywsK9E6tgKIKQBGNb/zW5r3MYeyFUuhYJdaQ9OZ3zyC/kgNKa0=
X-MS-Exchange-AntiSpam-MessageData: SJJnG28Doge4cpeIwsSBPC7sb75y7RsGcXpsDknMZfFgGNch7UX5b99Mf/3poTLcWAM5tTT7u3gZHwIkaPiZrNoSTRWap/BNRySwtoSocs/285QpDQnvFhw6/vyT1GlzAQGtiH2i7fspymW88dlhiQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295b3114-f20c-44b0-e51a-08d7b55133a8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 15:34:26.1298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQV3pddpMhwtArifMEhUnATOA6+k6xybUPRtMMtG705EHi108+zJAMvDlyjx0m3ZMKSqgYPK1ovkxZ06aMGCEMqDhqX6FvQyfRF1Xd+/7a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3445
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.121
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

18.02.2020 21:54, Andrey Shinkevich wrote:
>=20
>=20
> On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
>> Bitmaps data is not critical, and we should not fail the migration (or
>> use postcopy recovering) because of dirty-bitmaps migration failure.
>> Instead we should just lose unfinished bitmaps.
>>
>> Still we have to report io stream violation errors, as they affect the
>> whole migration stream.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 migration/block-dirty-bitmap.c | 148 +++++++++++++++++++++++++---=
-----
>> =C2=A0 1 file changed, 113 insertions(+), 35 deletions(-)
>>
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitm=
ap.c
>> index 1329db8d7d..aea5326804 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -145,6 +145,15 @@ typedef struct DBMLoadState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool before_vm_start_handled; /* set in d=
irty_bitmap_mig_before_vm_start */
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * cancelled
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Incoming migration is cancelled for some rea=
son. That means that we
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * still should read our chunks from migration =
stream, to not affect other
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * migration objects (like RAM), but just ignor=
e them and do not touch any
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bitmaps or nodes.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 bool cancelled;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSList *bitmaps;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QemuMutex lock; /* protect bitmaps */
>> =C2=A0 } DBMLoadState;
>> @@ -545,13 +554,47 @@ void dirty_bitmap_mig_before_vm_start(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock(&s->lock);
>> =C2=A0 }
>> +static void cancel_incoming_locked(DBMLoadState *s)
>> +{
>> +=C2=A0=C2=A0=C2=A0 GSList *item;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (s->cancelled) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 s->cancelled =3D true;
>> +=C2=A0=C2=A0=C2=A0 s->bs =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 s->bitmap =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Drop all unfinished bitmaps */
>> +=C2=A0=C2=A0=C2=A0 for (item =3D s->bitmaps; item; item =3D g_slist_nex=
t(item)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LoadBitmapState *b =3D item-=
>data;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bitmap must be unfin=
ished, as finished bitmaps should already be
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * removed from the lis=
t.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(!s->before_vm_start_h=
andled || !b->migrated);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_has_su=
ccessor(b->bitmap)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv=
_reclaim_dirty_bitmap(b->bitmap, &error_abort);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_release_dirty_bitmap(b-=
>bitmap);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 g_slist_free_full(s->bitmaps, g_free);
>> +=C2=A0=C2=A0=C2=A0 s->bitmaps =3D NULL;
>> +}
>> +
>> =C2=A0 static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState =
*s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSList *item;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_load_complete();
>> -=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
>> -=C2=A0=C2=A0=C2=A0 qemu_mutex_lock(&s->lock);
>=20
> Why is it safe to remove the critical section?

It's not removed, it becomes wider in this patch.

>=20
>> +=C2=A0=C2=A0=C2=A0 if (s->cancelled) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_has_successor(s->bi=
tmap)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_reclaim_dirt=
y_bitmap(s->bitmap, &error_abort);
>> @@ -569,8 +612,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f, =
DBMLoadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock(&s->lock);
>> =C2=A0 }
>> =C2=A0 static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>> @@ -582,15 +623,32 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBM=
LoadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZERO=
ES) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_dirty_bitma=
p_load_bits_zeroes();
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_deserializ=
e_zeroes(s->bitmap, first_byte, nr_bytes,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->cancelled) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv=
_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_by=
tes, false);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t *buf;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t buf_size=
 =3D qemu_get_be64(f);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t needed_size =3D
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv=
_dirty_bitmap_serialization_size(s->bitmap,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first=
_byte, nr_bytes);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t needed_size;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf =3D g_malloc(buf_size);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qemu_get_buffer(f, b=
uf, buf_size);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D buf_size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_report("Failed to read bitmap bits");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_fr=
ee(buf);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->cancelled) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_fr=
ee(buf);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 needed_size =3D bdrv_dirty_b=
itmap_serialization_size(s->bitmap,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first_byte,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_bytes);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (needed_size >=
 buf_size ||
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
>> @@ -599,15 +657,8 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBML=
oadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_report("Migrated bitmap granularity doesn't "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "match the destination bitmap '%s' granularity",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 bdrv_dirty_bitmap_name(s->bitmap));
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -EINVAL;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf =3D g_malloc(buf_size);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qemu_get_buffer(f, b=
uf, buf_size);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D buf_size) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_report("Failed to read bitmap bits");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_fr=
ee(buf);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 canc=
el_incoming_locked(s);
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* Continue the VM migration as bitmaps data are not critical =
*/

Hmm yes it what this patch does.. But I don't think we should add comment t=
o each call of cancel_..()

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap=
_deserialize_part(s->bitmap, buf, first_byte, nr_bytes,
>> @@ -632,14 +683,16 @@ static int dirty_bitmap_load_header(QEMUFile *f, D=
BMLoadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_report("Unable to read node name string");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->bs =3D bdrv_lookup_bs(s->=
node_name, s->node_name, &local_err);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->bs) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_report_err(local_err);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->cancelled) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->b=
s =3D bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
!s->bs) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report_err(local_err);
>=20
> The error message may be supplemented with a report about the canceled bi=
tmap migration. Also down there at cancel_incoming_locked(s).
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cancel_incoming_locked(s);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 } else if (!s->bs && !nothing) {
>> +=C2=A0=C2=A0=C2=A0 } else if (!s->bs && !nothing && !s->cancelled) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Err=
or: block device name is not set");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cancel_incoming_locked(s);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITM=
AP_NAME) {
>> @@ -647,24 +700,38 @@ static int dirty_bitmap_load_header(QEMUFile *f, D=
BMLoadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_report("Unable to read bitmap name string");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->bitmap =3D bdrv_find_dirt=
y_bitmap(s->bs, s->bitmap_name);
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* bitmap may be NULL here, =
it wouldn't be an error if it is the
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * first occurrence of =
the bitmap */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->bitmap && !(s->flags=
 & DIRTY_BITMAP_MIG_FLAG_START)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_report("Error: unknown dirty bitmap "
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "'%s' for block device '%s'",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 s->bitmap_name, s->node_name);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->cancelled) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->b=
itmap =3D bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * bitmap may be NULL here, it wouldn't be an error if it is the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * first occurrence of the bitmap
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report("Error: unknown dirty bitmap "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "'%s' for block device '%s'",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 s->bitmap_name, s->node_name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cancel_incoming_locked(s);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 } else if (!s->bitmap && !nothing) {
>> +=C2=A0=C2=A0=C2=A0 } else if (!s->bitmap && !nothing && !s->cancelled) =
{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Err=
or: block device name is not set");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cancel_incoming_locked(s);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> +/*
>> + * dirty_bitmap_load
>> + *
>> + * Load sequence of dirty bitmap chunks. Return error only on fatal io =
stream
>> + * violations. On other errors just cancel bitmaps incoming migration a=
nd return
>> + * 0.
>> + *
>> + * Note, than when incoming bitmap migration is canceled, we still must=
 read all
> "than (that)" may be omitted
>=20
>> + * our chunks (and just ignore them), to not affect other migration obj=
ects.
>> + */
>> =C2=A0 static int dirty_bitmap_load(QEMUFile *f, void *opaque, int versi=
on_id)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBMLoadState *s =3D &((DBMState *)opaque)=
->load;
>> @@ -673,12 +740,19 @@ static int dirty_bitmap_load(QEMUFile *f, void *op=
aque, int version_id)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_load_enter();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (version_id !=3D 1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_lock(&s->lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cancel_incoming_locked(s);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock(&s->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_lock(&s->lock);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D dirty_bit=
map_load_header(f, s);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 canc=
el_incoming_locked(s);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu=
_mutex_unlock(&s->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -695,8 +769,12 @@ static int dirty_bitmap_load(QEMUFile *f, void *opa=
que, int version_id)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 canc=
el_incoming_locked(s);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu=
_mutex_unlock(&s->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock(&s->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while (!(s->flags & DIRTY_BITMAP_MIG_FL=
AG_EOS));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_load_success();
>>
>=20
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


--=20
Best regards,
Vladimir

