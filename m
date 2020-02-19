Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BA4C34051
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006B224654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m+JCttpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006B224654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4RIU-0007z7-56
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 10:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4RHo-0007Rc-2Q
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4RHl-00074W-Ku
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:29:16 -0500
Received: from mail-db8eur05on20717.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::717]:25921
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j4RHe-0006vj-C1; Wed, 19 Feb 2020 10:29:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGiJaxgaJLcBcpQKxxho0N27qLetIn6IgSOAIgiypnIAF4B1tTP+XZO0Zc2+wFGJdsoCw/SuVOoZXeZ8RsWiJyQrWSMcpJZ2Nmg1EFVR0SR86XSDFbLKpLywdK7hYCPb8ko/rC812lIu9vcXQxP/9UmDb5xn5WdtFsvTsVp7bgYKuCS5BWUH8R1AAaWiMZDWDAYP4ymaU314fR7rkFZFB6Xi54jLYdZCpmmbe/o+ww/kHCu7PPBWuMVy6xt5L8vWojLKNnH8nrD8me5W6WVWzaFljyoqsThh4SaqKxorV5IpAjJRyIvr5awTn0lwPiuuB0ROtFbnypImuHsUOicU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsIPSRrWUFfI4Hf2lpFrPZYCbHlzG6S6EYEkM0u2rJ8=;
 b=ldK+4KikO5f2gLdHhLL+ukPXceFTths9aTheW46n74oEfiHA2d/rdgBkMfBprM75+ve+o8Wxg+KBdD1pSTiBw0/CEpMS89EwFl+r86/pqQKIUwt77E2kss+1K0fuSQp8e0bE2O26Kop5yqqb+O0jXstnh9kdD1QhVt5FFwAfra8TU8i+O6SIrCec36fJrmWpLg1aWt+rxraK/fmI5vPx1QsDBqNOq5UwN42xmEzR9YfnjQRr9W5pAS2e2OZVksnpFWm+8TLkn78b/SVp62ccnNXTkyECUCxX7zbGrQ317/HLSkMW3yZuB0KqF0qbsxM5F5xU4kv6Iv8P8bIzwhHkLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsIPSRrWUFfI4Hf2lpFrPZYCbHlzG6S6EYEkM0u2rJ8=;
 b=m+JCttpF0xi3TJRy3U/Hw2eGAePFrbLHNsdXhdwq4d4s5kCUn3zjuBUAaK0ln8b3wSWrgnfFuBXnnqGWPjAxO8GnwYqSkbDLWfvbUua6DzczcgSnsd1YIZfM5hXG+tMu5c5ChLsdUTXGCGLDhuiuBc0tbWnVwRS2VG50JfPFKE8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3909.eurprd08.prod.outlook.com (20.178.91.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 15:29:02 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 15:29:02 +0000
Subject: Re: [PATCH v2 05/22] migration/block-dirty-bitmap: refactor state
 global variables
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-6-vsementsov@virtuozzo.com>
 <662ed516-18c4-6bfd-c295-f2528e770d15@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200219182900353
Message-ID: <58af50b1-5f1e-e2a3-dca5-9f828f43cb49@virtuozzo.com>
Date: Wed, 19 Feb 2020 18:29:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <662ed516-18c4-6bfd-c295-f2528e770d15@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0902CA0010.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::20) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0902CA0010.eurprd09.prod.outlook.com (2603:10a6:3:e5::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25 via Frontend Transport; Wed, 19 Feb 2020 15:29:01 +0000
X-Tagtoolbar-Keys: D20200219182900353
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3b9e0e3-c75d-434c-f4a9-08d7b55072cf
X-MS-TrafficTypeDiagnostic: AM6PR08MB3909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3909CD8236A99E5D47AB543FC1100@AM6PR08MB3909.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(366004)(376002)(39850400004)(396003)(199004)(189003)(8676002)(2616005)(54906003)(8936002)(66556008)(16576012)(81166006)(956004)(316002)(186003)(5660300002)(53546011)(66946007)(81156014)(26005)(31686004)(66476007)(4326008)(16526019)(31696002)(52116002)(2906002)(478600001)(30864003)(86362001)(6486002)(36756003)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3909;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NwSCi6hgmQungyTKAiSpqglY32Sz/ycozzla6tEpqtN7fdzyrYKRsKfEJQs/rVrzQAYmeMZtPz5wsvAzPoWvjDsHLgGXVNcgchkPYg4/8TZbpbyAKM7GlKdmNghxzSjypFwtlkgyAaMpknfp8l9kQUibeEI9/RHMDixX0iUbNLvGcOUHM65gmpcJZTCRbaLmT+mpZjgel9Sec8KU6do55hWPWQMmcuQjkqIs5OVLNCAlKCDbMTD8yYCRgPWGrVgPRACZ5YUKweKBpSnCJit8b+2nTrdh64K5/cpKZsQyuQc4ZOuhVsq0g9eqbCgcDpPt+XCHznBcM7bm0JJG9RcR04wBkTTPcdI06DhcKG9270vajRDohUQ+KIYfkjPk55CKC/LWPooB9ipOsWDwwcaSfIF/fg/z2tlECzhLPzmPpnvG51eMcaM31Qzv9zV0sa1B2AYUOZ9kUtPHZhIL1dCtZ10hYOM9t3sgM13i2GVlMcpCorUSeGPQTiv/J1m2w54f
X-MS-Exchange-AntiSpam-MessageData: +dKhwnxJQkBd8hCembg2FtMr9BV+PAFkTE6B7ua97aU6Z+7hZYBnAVDT1fw12s/Z8P0ugUeg6GQZRtHVt8ozWo1M5dAXJEENolNg0wbOYqZ/iQjmZuBxG2aPZScyKOPr0mJNwWD9ed9RdFO8ZuSolw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b9e0e3-c75d-434c-f4a9-08d7b55072cf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 15:29:02.5896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klhQwDnToCUnfL4MeZdEXIVcPm+kTDeIgkbaKsQjoyEgVTNiX6Q+2wHEEiZws4qVzIL/nyrZRjKhE1YGA9A5GA/OUlAeb0R+sPvQja6faAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3909
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7e1a::717
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

18.02.2020 16:05, Andrey Shinkevich wrote:
>=20
>=20
> On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
>> Move all state variables into one global struct. Reduce global
>> variable usage, utilizing opaque pointer where possible.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 migration/block-dirty-bitmap.c | 171 ++++++++++++++++++----------=
-----
>> =C2=A0 1 file changed, 95 insertions(+), 76 deletions(-)
>>
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitm=
ap.c
>> index 49d4cf8810..7a82b76809 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -128,6 +128,12 @@ typedef struct DBMSaveState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *prev_bitmap;
>> =C2=A0 } DBMSaveState;
>> +typedef struct LoadBitmapState {
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>> +=C2=A0=C2=A0=C2=A0 bool migrated;
>> +} LoadBitmapState;
>> +
>> =C2=A0 /* State of the dirty bitmap migration (DBM) during load process =
*/
>> =C2=A0 typedef struct DBMLoadState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t flags;
>> @@ -135,18 +141,17 @@ typedef struct DBMLoadState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char bitmap_name[256];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>> +
>> +=C2=A0=C2=A0=C2=A0 GSList *enabled_bitmaps;
>> +=C2=A0=C2=A0=C2=A0 QemuMutex finish_lock;
>> =C2=A0 } DBMLoadState;
>> -static DBMSaveState dirty_bitmap_mig_state;
>> +typedef struct DBMState {
>> +=C2=A0=C2=A0=C2=A0 DBMSaveState save;
>> +=C2=A0=C2=A0=C2=A0 DBMLoadState load;
>> +} DBMState;
>> -/* State of one bitmap during load process */
>> -typedef struct LoadBitmapState {
>> -=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>> -=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>> -=C2=A0=C2=A0=C2=A0 bool migrated;
>> -} LoadBitmapState;
>> -static GSList *enabled_bitmaps;
>> -QemuMutex finish_lock;
>> +static DBMState dbm_state;
>> =C2=A0 static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
>> =C2=A0 {
>> @@ -169,21 +174,21 @@ static void qemu_put_bitmap_flags(QEMUFile *f, uin=
t32_t flags)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_byte(f, flags);
>> =C2=A0 }
>> -static void send_bitmap_header(QEMUFile *f, SaveBitmapState *dbms,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t additional_flags)
>> +static void send_bitmap_header(QEMUFile *f, DBMSaveState *s,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SaveBitmapState *dbms, uint32_t additi=
onal_flags)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *bs =3D dbms->bs;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap =3D dbms->bitmap;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t flags =3D additional_flags;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_send_bitmap_header_enter();
>> -=C2=A0=C2=A0=C2=A0 if (bs !=3D dirty_bitmap_mig_state.prev_bs) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.prev_=
bs =3D bs;
>> +=C2=A0=C2=A0=C2=A0 if (bs !=3D s->prev_bs) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->prev_bs =3D bs;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags |=3D DIRTY_=
BITMAP_MIG_FLAG_DEVICE_NAME;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 if (bitmap !=3D dirty_bitmap_mig_state.prev_bitmap) =
{
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.prev_=
bitmap =3D bitmap;
>> +=C2=A0=C2=A0=C2=A0 if (bitmap !=3D s->prev_bitmap) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->prev_bitmap =3D bitmap;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags |=3D DIRTY_=
BITMAP_MIG_FLAG_BITMAP_NAME;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -198,19 +203,22 @@ static void send_bitmap_header(QEMUFile *f, SaveBi=
tmapState *dbms,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> -static void send_bitmap_start(QEMUFile *f, SaveBitmapState *dbms)
>> +static void send_bitmap_start(QEMUFile *f, DBMSaveState *s,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SaveBitmapState *dbms)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_ST=
ART);
>> +=C2=A0=C2=A0=C2=A0 send_bitmap_header(f, s, dbms, DIRTY_BITMAP_MIG_FLAG=
_START);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_be32(f, bdrv_dirty_bitmap_granul=
arity(dbms->bitmap));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_byte(f, dbms->flags);
>> =C2=A0 }
>> -static void send_bitmap_complete(QEMUFile *f, SaveBitmapState *dbms)
>> +static void send_bitmap_complete(QEMUFile *f, DBMSaveState *s,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SaveBitmapState *dbms)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_CO=
MPLETE);
>> +=C2=A0=C2=A0=C2=A0 send_bitmap_header(f, s, dbms, DIRTY_BITMAP_MIG_FLAG=
_COMPLETE);
>> =C2=A0 }
>> -static void send_bitmap_bits(QEMUFile *f, SaveBitmapState *dbms,
>> +static void send_bitmap_bits(QEMUFile *f, DBMSaveState *s,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 SaveBitmapState *dbms,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t start_sector, uint32_t nr_sector=
s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* align for buffer_is_zero() */
>> @@ -235,7 +243,7 @@ static void send_bitmap_bits(QEMUFile *f, SaveBitmap=
State *dbms,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_send_bitmap_bits(flags, start_secto=
r, nr_sectors, buf_size);
>> -=C2=A0=C2=A0=C2=A0 send_bitmap_header(f, dbms, flags);
>> +=C2=A0=C2=A0=C2=A0 send_bitmap_header(f, s, dbms, flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_be64(f, start_sector);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_be32(f, nr_sectors);
>> @@ -254,12 +262,12 @@ static void send_bitmap_bits(QEMUFile *f, SaveBitm=
apState *dbms,
>> =C2=A0 }
>> =C2=A0 /* Called with iothread lock taken.=C2=A0 */
>> -static void dirty_bitmap_do_save_cleanup(void)
>> +static void dirty_bitmap_do_save_cleanup(DBMSaveState *s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SaveBitmapState *dbms;
>> -=C2=A0=C2=A0=C2=A0 while ((dbms =3D QSIMPLEQ_FIRST(&dirty_bitmap_mig_st=
ate.dbms_list)) !=3D NULL) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_REMOVE_HEAD(&dirty_=
bitmap_mig_state.dbms_list, entry);
>> +=C2=A0=C2=A0=C2=A0 while ((dbms =3D QSIMPLEQ_FIRST(&s->dbms_list)) !=3D=
 NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_REMOVE_HEAD(&s->dbm=
s_list, entry);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap=
_set_busy(dbms->bitmap, false);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_unref(dbms->=
bs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(dbms);
>> @@ -267,17 +275,17 @@ static void dirty_bitmap_do_save_cleanup(void)
>> =C2=A0 }
>> =C2=A0 /* Called with iothread lock taken. */
>> -static int init_dirty_bitmap_migration(void)
>> +static int init_dirty_bitmap_migration(DBMSaveState *s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SaveBitmapState *dbms;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>> -=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.bulk_completed =3D false;
>> -=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.prev_bs =3D NULL;
>> -=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.prev_bitmap =3D NULL;
>> -=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.no_bitmaps =3D false;
>> +=C2=A0=C2=A0=C2=A0 s->bulk_completed =3D false;
>> +=C2=A0=C2=A0=C2=A0 s->prev_bs =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 s->prev_bitmap =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 s->no_bitmaps =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (bs =3D bdrv_next_all_states(NULL); b=
s; bs =3D bdrv_next_all_states(bs)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name =
=3D bdrv_get_device_or_node_name(bs);
>> @@ -316,35 +324,36 @@ static int init_dirty_bitmap_migration(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dbms->flags |=3D DIRTY_BITMAP_MIG_START_FLAG=
_PERSISTENT;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIM=
PLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIM=
PLEQ_INSERT_TAIL(&s->dbms_list,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dbms, entry);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* unset migration flags here, to not rol=
l back it */
>> -=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_=
list, entry) {
>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap=
_skip_store(dbms->bitmap, true);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 if (QSIMPLEQ_EMPTY(&dirty_bitmap_mig_state.dbms_list=
)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.no_bi=
tmaps =3D true;
>> +=C2=A0=C2=A0=C2=A0 if (QSIMPLEQ_EMPTY(&s->dbms_list)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->no_bitmaps =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 fail:
>> -=C2=A0=C2=A0=C2=A0 dirty_bitmap_do_save_cleanup();
>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_do_save_cleanup(s);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> =C2=A0 }
>> =C2=A0 /* Called with no lock taken.=C2=A0 */
>> -static void bulk_phase_send_chunk(QEMUFile *f, SaveBitmapState *dbms)
>> +static void bulk_phase_send_chunk(QEMUFile *f, DBMSaveState *s,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SaveBitmapState *dbm=
s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t nr_sectors =3D MIN(dbms->total_s=
ectors - dbms->cur_sector,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dbms->sectors_per_chunk);
>> -=C2=A0=C2=A0=C2=A0 send_bitmap_bits(f, dbms, dbms->cur_sector, nr_secto=
rs);
>> +=C2=A0=C2=A0=C2=A0 send_bitmap_bits(f, s, dbms, dbms->cur_sector, nr_se=
ctors);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dbms->cur_sector +=3D nr_sectors;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dbms->cur_sector >=3D dbms->total_sec=
tors) {
>> @@ -353,61 +362,66 @@ static void bulk_phase_send_chunk(QEMUFile *f, Sav=
eBitmapState *dbms)
>> =C2=A0 }
>> =C2=A0 /* Called with no lock taken.=C2=A0 */
>> -static void bulk_phase(QEMUFile *f, bool limit)
>> +static void bulk_phase(QEMUFile *f, DBMSaveState *s, bool limit)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SaveBitmapState *dbms;
>> -=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_=
list, entry) {
>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (!dbms->bul=
k_completed) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bulk=
_phase_send_chunk(f, dbms);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bulk=
_phase_send_chunk(f, s, dbms);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (limit && qemu_file_rate_limit(f)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.bulk_completed =3D true;
>> +=C2=A0=C2=A0=C2=A0 s->bulk_completed =3D true;
>> =C2=A0 }
>> =C2=A0 /* for SaveVMHandlers */
>> =C2=A0 static void dirty_bitmap_save_cleanup(void *opaque)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 dirty_bitmap_do_save_cleanup();
>> +=C2=A0=C2=A0=C2=A0 DBMSaveState *s =3D &((DBMState *)opaque)->save;
>> +
>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_do_save_cleanup(s);
>> =C2=A0 }
>=20
> Why do one need the extra nested "do" function?

Because "_do_" has sub-structure argument, and I don't have pointer to the
whole structure in another "_do_" caller..

>=20
>> =C2=A0 static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 DBMSaveState *s =3D &((DBMState *)opaque)->save;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_save_iterate(migration=
_in_postcopy());
>> -=C2=A0=C2=A0=C2=A0 if (migration_in_postcopy() && !dirty_bitmap_mig_sta=
te.bulk_completed) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bulk_phase(f, true);
>> +=C2=A0=C2=A0=C2=A0 if (migration_in_postcopy() && !s->bulk_completed) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bulk_phase(f, s, true);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG=
_FLAG_EOS);
>> -=C2=A0=C2=A0=C2=A0 return dirty_bitmap_mig_state.bulk_completed;
>> +=C2=A0=C2=A0=C2=A0 return s->bulk_completed;
>> =C2=A0 }
>> =C2=A0 /* Called with iothread lock taken.=C2=A0 */
>> =C2=A0 static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 DBMSaveState *s =3D &((DBMState *)opaque)->save;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SaveBitmapState *dbms;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_save_complete_enter();
>> -=C2=A0=C2=A0=C2=A0 if (!dirty_bitmap_mig_state.bulk_completed) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bulk_phase(f, false);
>> +=C2=A0=C2=A0=C2=A0 if (!s->bulk_completed) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bulk_phase(f, s, false);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_=
list, entry) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 send_bitmap_complete(f, dbms=
);
>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 send_bitmap_complete(f, s, d=
bms);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG=
_FLAG_EOS);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_save_complete_finish()=
;
>> -=C2=A0=C2=A0=C2=A0 dirty_bitmap_do_save_cleanup();
>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_save_cleanup(opaque);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> @@ -417,12 +431,13 @@ static void dirty_bitmap_save_pending(QEMUFile *f,=
 void *opaque,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 uint64_t *res_compatible,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 uint64_t *res_postcopy_only)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 DBMSaveState *s =3D &((DBMState *)opaque)->save;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SaveBitmapState *dbms;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t pending =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_lock_iothread();
>> -=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_=
list, entry) {
>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t gran =3D=
 bdrv_dirty_bitmap_granularity(dbms->bitmap);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t sectors =
=3D dbms->bulk_completed ? 0 :
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dbms->total_sectors - dbms->cur_sector;
>> @@ -481,7 +496,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBML=
oadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b->bs =3D s->bs;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b->bitmap =3D s->=
bitmap;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b->migrated =3D f=
alse;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled_bitmaps =3D g_slist_=
prepend(enabled_bitmaps, b);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->enabled_bitmaps =3D g_sli=
st_prepend(s->enabled_bitmaps, b);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> @@ -489,11 +504,12 @@ static int dirty_bitmap_load_start(QEMUFile *f, DB=
MLoadState *s)
>> =C2=A0 void dirty_bitmap_mig_before_vm_start(void)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 DBMLoadState *s =3D &dbm_state.load;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSList *item;
>> -=C2=A0=C2=A0=C2=A0 qemu_mutex_lock(&finish_lock);
>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_lock(&s->finish_lock);
>> -=C2=A0=C2=A0=C2=A0 for (item =3D enabled_bitmaps; item; item =3D g_slis=
t_next(item)) {
>> +=C2=A0=C2=A0=C2=A0 for (item =3D s->enabled_bitmaps; item; item =3D g_s=
list_next(item)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LoadBitmapState *=
b =3D item->data;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (b->migrated) =
{
>> @@ -505,10 +521,10 @@ void dirty_bitmap_mig_before_vm_start(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(b);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 g_slist_free(enabled_bitmaps);
>> -=C2=A0=C2=A0=C2=A0 enabled_bitmaps =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 g_slist_free(s->enabled_bitmaps);
>> +=C2=A0=C2=A0=C2=A0 s->enabled_bitmaps =3D NULL;
>> -=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock(&finish_lock);
>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock(&s->finish_lock);
>> =C2=A0 }
>> =C2=A0 static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState =
*s)
>> @@ -517,9 +533,9 @@ static void dirty_bitmap_load_complete(QEMUFile *f, =
DBMLoadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_load_complete();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_deserialize_finish(s->b=
itmap);
>> -=C2=A0=C2=A0=C2=A0 qemu_mutex_lock(&finish_lock);
>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_lock(&s->finish_lock);
>> -=C2=A0=C2=A0=C2=A0 for (item =3D enabled_bitmaps; item; item =3D g_slis=
t_next(item)) {
>> +=C2=A0=C2=A0=C2=A0 for (item =3D s->enabled_bitmaps; item; item =3D g_s=
list_next(item)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LoadBitmapState *=
b =3D item->data;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (b->bitmap =3D=
=3D s->bitmap) {
>> @@ -530,7 +546,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, =
DBMLoadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_has_successor(s->bi=
tmap)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap=
_lock(s->bitmap);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (enabled_bitmaps =3D=3D N=
ULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->enabled_bitmaps =3D=
=3D NULL) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* in postcopy */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bdrv_reclaim_dirty_bitmap_locked(s->bitmap, &error_abort);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bdrv_enable_dirty_bitmap_locked(s->bitmap);
>> @@ -549,7 +565,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, =
DBMLoadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap=
_unlock(s->bitmap);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock(&finish_lock);
>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock(&s->finish_lock);
>> =C2=A0 }
>> =C2=A0 static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>> @@ -646,7 +662,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBM=
LoadState *s)
>> =C2=A0 static int dirty_bitmap_load(QEMUFile *f, void *opaque, int versi=
on_id)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 static DBMLoadState s;
>> +=C2=A0=C2=A0=C2=A0 DBMLoadState *s =3D &((DBMState *)opaque)->load;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_load_enter();
>> @@ -656,17 +672,17 @@ static int dirty_bitmap_load(QEMUFile *f, void *op=
aque, int version_id)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D dirty_bitmap_load_he=
ader(f, &s);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D dirty_bitmap_load_he=
ader(f, s);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s.flags & DIRTY_BITMAP_M=
IG_FLAG_START) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D dirty_bitmap_load_start(f, &s);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (s.flags & DIRTY_B=
ITMAP_MIG_FLAG_COMPLETE) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirt=
y_bitmap_load_complete(f, &s);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (s.flags & DIRTY_B=
ITMAP_MIG_FLAG_BITS) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D dirty_bitmap_load_bits(f, &s);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->flags & DIRTY_BITMAP_=
MIG_FLAG_START) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D dirty_bitmap_load_start(f, s);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (s->flags & DIRTY_=
BITMAP_MIG_FLAG_COMPLETE) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirt=
y_bitmap_load_complete(f, s);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (s->flags & DIRTY_=
BITMAP_MIG_FLAG_BITS) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D dirty_bitmap_load_bits(f, s);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>> @@ -676,7 +692,7 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaq=
ue, int version_id)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 } while (!(s.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
>> +=C2=A0=C2=A0=C2=A0 } while (!(s->flags & DIRTY_BITMAP_MIG_FLAG_EOS));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_load_success();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> @@ -684,13 +700,14 @@ static int dirty_bitmap_load(QEMUFile *f, void *op=
aque, int version_id)
>> =C2=A0 static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 DBMSaveState *s =3D &((DBMState *)opaque)->save;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SaveBitmapState *dbms =3D NULL;
>> -=C2=A0=C2=A0=C2=A0 if (init_dirty_bitmap_migration() < 0) {
>> +=C2=A0=C2=A0=C2=A0 if (init_dirty_bitmap_migration(s) < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_=
list, entry) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 send_bitmap_start(f, dbms);
>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 send_bitmap_start(f, s, dbms=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG=
_FLAG_EOS);
>> @@ -699,7 +716,9 @@ static int dirty_bitmap_save_setup(QEMUFile *f, void=
 *opaque)
>> =C2=A0 static bool dirty_bitmap_is_active(void *opaque)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 return migrate_dirty_bitmaps() && !dirty_bitmap_mig_=
state.no_bitmaps;
>> +=C2=A0=C2=A0=C2=A0 DBMSaveState *s =3D &((DBMState *)opaque)->save;
>> +
>> +=C2=A0=C2=A0=C2=A0 return migrate_dirty_bitmaps() && !s->no_bitmaps;
>> =C2=A0 }
>> =C2=A0 static bool dirty_bitmap_is_active_iterate(void *opaque)
>> @@ -727,10 +746,10 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers=
 =3D {
>> =C2=A0 void dirty_bitmap_mig_init(void)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 QSIMPLEQ_INIT(&dirty_bitmap_mig_state.dbms_list);
>> -=C2=A0=C2=A0=C2=A0 qemu_mutex_init(&finish_lock);
>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_INIT(&dbm_state.save.dbms_list);
>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_init(&dbm_state.load.finish_lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 register_savevm_live("dirty-bitmap", 0, 1=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &savevm_dirty_bitmap_handlers,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 &dirty_bitmap_mig_state);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 &dbm_state);
>> =C2=A0 }
>>
>=20
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


--=20
Best regards,
Vladimir

