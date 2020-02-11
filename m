Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F6EC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4C720675
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mwNOYNlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4C720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1X5d-00061m-4f
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j1X4r-0005DW-0b
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:03:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j1X4o-0003zf-MM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:03:52 -0500
Received: from mail-vi1eur04on070e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::70e]:36930
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j1X4n-0003tZ-QZ; Tue, 11 Feb 2020 10:03:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLxbsyfgT5LRthH3yetSEedqbFuZKEMBf3QmuCIMhW6kpoxecZqX36Y31/dayEL6yzSwfe67m+brdli2O24DAgXM31kozKpUyMgL62aNCG8ZhYo0JaXP4BNPnx0hr287SDmxFVqrZc3E43jXEE7apOEhsv2rRe1kOtuKI5Vn3TQcb7Ds59CdMbXUP6mqmdwbujINfTJyj64v/PeFEndLnPTAMWm/rO8UoMkersvkD1LzFsb9QJiKf5yDe1AFvsh/6Hm5H26gpo9EOsNVwXtOgN48+39Dy0iMFs4y3n8j+w6xNGH9v+bHtSfib0JyhlTTA4Nn53ln+38awewknM6U1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDDYwzMydUQ6g9JiODRLB/p6P5gLEsCpmWiRSe7JTsY=;
 b=dBUB8+grnOKAIw4QqQFWb8dsxMh3xe2IayMVhijkssH9OKzjAJNsk46g11lWpaQ00y19db3SZ1IvKUW/aTgcLYsx4d8XEhD5SVO4GNs4JUpDrFNDMJ9soqfr2OU/omt3ez/BE1J8KFHwKLbSO52px10HzyopeNezUwPnWaH3JM8YL/IEwo/iO+uC2ieykpgPu3tKzcg3lpT4u78Ml2Bj/nq/7jqQ+dGy4jxupkSh/6g3wE86EnXeTf9VauWAvVoIfPWw8KksmubV6VIb0VQ0ck4+/4PiqVphHA0DOFOG3GGvdjYi0uH2NjbhoiAf8SvD2hrS3AhHhZln6jNWtRWFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDDYwzMydUQ6g9JiODRLB/p6P5gLEsCpmWiRSe7JTsY=;
 b=mwNOYNlYXRkdIYpSK7nlldiQ9RqPforATStyQlo+6RfLLh/Lsi8OqMJb3WoME71NMQw+Lo/k6u429y5b8Z6owDnSFPUFgWIDIrVnkPnGAGv5ZTsFGhAWMJVdZ2VtV3tYTWW8trpbPPTYG5i3Ei/AeeqMNnuYqg9xaRfnd5TyZY0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4818.eurprd08.prod.outlook.com (10.255.98.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 15:03:44 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 15:03:43 +0000
Subject: Re: [PATCH 1/7] migration/block-dirty-bitmap: refactor incoming state
 to be one struct
To: quintela@redhat.com
References: <20200122132328.31156-1-vsementsov@virtuozzo.com>
 <20200122132328.31156-2-vsementsov@virtuozzo.com>
 <87eevp5dib.fsf@secure.laptop>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200211180341008
Message-ID: <dbbbfaf4-1fb6-d952-df1c-3303039fe2f4@virtuozzo.com>
Date: Tue, 11 Feb 2020 18:03:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87eevp5dib.fsf@secure.laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0202CA0037.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::23) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0202CA0037.eurprd02.prod.outlook.com (2603:10a6:3:e4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 15:03:43 +0000
X-Tagtoolbar-Keys: D20200211180341008
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b67f2ee-4089-42f2-b809-08d7af039648
X-MS-TrafficTypeDiagnostic: AM6PR08MB4818:
X-Microsoft-Antispam-PRVS: <AM6PR08MB481852CBF731C0ADE8642663C1180@AM6PR08MB4818.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(136003)(366004)(376002)(39850400004)(189003)(199004)(6486002)(52116002)(478600001)(86362001)(31686004)(2616005)(4326008)(956004)(8936002)(31696002)(36756003)(66946007)(316002)(66476007)(66556008)(6916009)(16576012)(16526019)(186003)(2906002)(26005)(8676002)(5660300002)(81166006)(81156014)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4818;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmX/YkhORxYssR5krhl6VG12WnEUi7msmoW7G5YtiDIIAfnjEchyax6HndXYcZhuei5fxbBFAUkYRbN2IpBllJ9QS4NaaIr9QeG12+NGI95KXI+NpxDrwW87wT8xbiy/r+y4vpaqr1y1BxqD2Xyd05QBlTO7vBqsAGioZb4nFsG9mDdpV7PdJ8WpxQAl8TUxbWSupTyERpHoiyjkcmPdv6e2X5fZvjtCqEJ+JNP+QXeKaM+3Utp82RIYf2nIp3eb3Coq/S+tEqW+leWr7C6IHxzNSV3NQ+iQQOcy9+XsB4CBb7xsawTfM+icaZ+NxTxl/ZfiaWoJmH7P7m1DNprsKyiFnbzXGyijbnQjvgFebMRJmIknYSmDv2pJzWghjzJHdDnR+AKqoRlr476n9idSj6iQhPnO4K0S1KWsnAOTs2Re+Rx+3TXah1knn1qZQ7zvhYwf6J/eYC9PaNZCxlMg19DOQ8HULDYeKPK2SNPS7ckgrLZA06bLVd4J2yiAkK08
X-MS-Exchange-AntiSpam-MessageData: G0ud9GK1qsqLwXtnBlpVN64DwfBLD3aAld2vcCj35A+xi5huLhAuTT8Zvo55KkD+8+lrNKdECgiVMEGbwj/2FaK7RdDSaVRS8cbZH3WL4cwn0y/DegBW3UOlKAmmhjH5YGO4Pxbmud0Bnuy9WC/tJA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b67f2ee-4089-42f2-b809-08d7af039648
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 15:03:43.8914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MX6MVzMk8HyTeJgwwpWxcWnnmxPcU8v/rFvC62EKTc6Xh/O+DMLLzqJ3MgbZwOI5FYp+HzwPYJS0+UYCATr73h/ZLGryaJC/8/f+UxlpD3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4818
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::70e
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 dgilbert@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.01.2020 13:56, Juan Quintela wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>> Move enabled_bitmaps and finish_lock, which are part of incoming state
>> to DirtyBitmapLoadState, and make static global variable to store state
>> instead of static local one.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   migration/block-dirty-bitmap.c | 77 +++++++++++++++++++---------------
>>   1 file changed, 43 insertions(+), 34 deletions(-)
>>
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>> index 7eafface61..281d20f41d 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -125,6 +125,13 @@ typedef struct DirtyBitmapMigState {
>>       BlockDriverState *prev_bs;
>>       BdrvDirtyBitmap *prev_bitmap;
>>   } DirtyBitmapMigState;
>> +static DirtyBitmapMigState dirty_bitmap_mig_state;
> 
> Missing new line.
> 
>> +
>> +typedef struct DirtyBitmapLoadBitmapState {
>> +    BlockDriverState *bs;
>> +    BdrvDirtyBitmap *bitmap;
>> +    bool migrated;
>> +} DirtyBitmapLoadBitmapState;
>>   
>>   typedef struct DirtyBitmapLoadState {
>>       uint32_t flags;
>> @@ -132,21 +139,15 @@ typedef struct DirtyBitmapLoadState {
>>       char bitmap_name[256];
>>       BlockDriverState *bs;
>>       BdrvDirtyBitmap *bitmap;
>> -} DirtyBitmapLoadState;
>>   
>> -static DirtyBitmapMigState dirty_bitmap_mig_state;
>> -
>> -typedef struct DirtyBitmapLoadBitmapState {
>> -    BlockDriverState *bs;
>> -    BdrvDirtyBitmap *bitmap;
>> -    bool migrated;
>> -} DirtyBitmapLoadBitmapState;
>> -static GSList *enabled_bitmaps;
>> -QemuMutex finish_lock;
>> +    GSList *enabled_bitmaps;
>> +    QemuMutex finish_lock;
>> +} DirtyBitmapLoadState;
>> +static DirtyBitmapLoadState dbm_load_state;
> 
> You move two global variables to an struct (good)
> But you create a even bigger global variable (i.e. state that was not
> shared before.)
> 
>>   /* First occurrence of this bitmap. It should be created if doesn't exist */
>> -static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
>> +static int dirty_bitmap_load_start(QEMUFile *f)
>>   {
>> +    DirtyBitmapLoadState *s = &dbm_load_state;
> 
> You create a local alias.
> 
>>       Error *local_err = NULL;
>>       uint32_t granularity = qemu_get_be32(f);
>>       uint8_t flags = qemu_get_byte(f);
>> @@ -482,7 +484,8 @@ static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
>>           b->bs = s->bs;
>>           b->bitmap = s->bitmap;
>>           b->migrated = false;
>> -        enabled_bitmaps = g_slist_prepend(enabled_bitmaps, b);
>> +        dbm_load_state.enabled_bitmaps =
>> +            g_slist_prepend(dbm_load_state.enabled_bitmaps, b);
> 
> And then you access it using the global variable?
> 
>> -static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
>> +static void dirty_bitmap_load_complete(QEMUFile *f)
>>   {
>> +    DirtyBitmapLoadState *s = &dbm_load_state;
> 
> Exactly the same on this function.
> 
> I still don't understand why you are removing the pass as parameters of
> this function.
> 
> 
>> -    static DirtyBitmapLoadState s;
> 
> Aha, this is why you are moving it as a global.
> 
> But, why can't you put this inside dirty_bitmap_mig_state?  Then you:
> a- don't have to have "yet" another global variable
> b- you can clean it up on save_cleanup handler.

Because dirty_bitmap_mig_state is source state, and new dbm_load_state is
destination state. So, at least [b] will not work...

Do you think it's good to combine both source and destination states into one
struct, and use opaque everywhere?

It will look like

DirtyBitmapMigSourceState *s = ((DirtyBitmapMigState *)opaque)->source_state;

in save functions

and
DirtyBitmapIncomingState *s = ((DirtyBitmapMigState *)opaque)->incoming_state;

in load function

> 
> not related to this patch, but to the file in general:
> 
> static void dirty_bitmap_save_cleanup(void *opaque)
> {
>      dirty_bitmap_mig_cleanup();
> }
> 
> We have opaque here, that we can do:
> 
> DirtyBitmapMigBitmapState *dbms = opaque;
> 
> And then pass dbms to dirty_bitmap_mig_cleanup().
> 
> /* Called with iothread lock taken.  */
> static void dirty_bitmap_mig_cleanup(void)
> {
>      DirtyBitmapMigBitmapState *dbms;
> 
>      while ((dbms = QSIMPLEQ_FIRST(&dirty_bitmap_mig_state.dbms_list)) != NULL) {
>          QSIMPLEQ_REMOVE_HEAD(&dirty_bitmap_mig_state.dbms_list, entry);
>          bdrv_dirty_bitmap_set_busy(dbms->bitmap, false);
>          bdrv_unref(dbms->bs);
>          g_free(dbms);
>      }
> }
> 
> 
> Because here we just use the global variable.
> 
> Later, Juan.
> 


-- 
Best regards,
Vladimir

