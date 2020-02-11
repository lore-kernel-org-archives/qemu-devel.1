Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EEAC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033012086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DcIvSfyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033012086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1XG9-0002qh-5p
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j1XFN-0002Lb-VK
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:14:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j1XFM-0006SI-Gc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:14:45 -0500
Received: from mail-db8eur05on2115.outbound.protection.outlook.com
 ([40.107.20.115]:39393 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j1XFM-0006Rr-9a; Tue, 11 Feb 2020 10:14:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkyz2LjMztGZ4NJBryZzK7serVbbY3Ypf6C743yDuKkcR9g4X9KNoNc2lk2GhTer8Q8mzFwUOqNq8GVkib/3vdXdQ72aZfkQ5IEUNt5oh1Ym+pclEGOx6njJ+R5w48thNH8r/Us4cAFHH5WedvNFe5hkEB9j1D3t/I2ggyztgCkYHJSvprZBUfIWQF7GA385eOIQx8gl5t6L3Ckw92qYX0/d514Ah1Pn5F/SH6xLsAhvc7SXL7h+lB1CPJqQuHOJTZVe4xDxR3PH/6TKlLR6OGKHdI6yflgCJDj5aDfXnuD9eSD++X+Te8yNw/BrSSaTugjemtYSdqMJPRpod4XdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5TrM9JDU9HK/ZDDAxLGxc1icZG5j6+31CwW4hsg7vM=;
 b=D3y2UBFeF/2xdPq5WkbFLV7bFTqvSnVtOBpDNIy2oWpZJWoq3nPHK8V5clT/sN7bWr+v+UspToa5Ivrf6EmBF0icixi2mPZ8miVUgNdXG/53WVB0dbj70vDIg8/94yYoUfu5NwGPgOEy+icAwumBcuOpowrnFVWbFfYwYPwPlCm6kX694hLrpeJ3yn3l5HKBOIev2YChZFO7SOmckH9K37+vb3HEJCoNxjLMWRCJn77X6BC7oXajkd1m0knj07kuC3LJhbQ1Vn6DVjgmPza4Mvb1YVjJiX5pRCXy7KO/+GxlrDMfqLYNhrdFOZGW6PFJp96LK6BXKHwMadfEjds5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5TrM9JDU9HK/ZDDAxLGxc1icZG5j6+31CwW4hsg7vM=;
 b=DcIvSfyEjOyvw7A1GMtzx0eT1suLNfBVHYFHQoR2Z9yzcdZYVZu6KtV4+9kE2KnjReJ5/j40wGlC3h23j/2S22OXWtKxWWjWxenVzHSFObpaczsXPp7y5X7zxJd6Rkk96m8w4ZL3kutDETNZW4t4m9hWWHK4WKwcCYfJ/JRqla4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3013.eurprd08.prod.outlook.com (52.135.168.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 15:14:42 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 15:14:42 +0000
Subject: Re: [PATCH 4/7] migration/block-dirty-bitmap: keep bitmap state for
 all bitmaps
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200122132328.31156-1-vsementsov@virtuozzo.com>
 <20200122132328.31156-5-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200211181439899
Message-ID: <4d8aff71-917e-3f79-7002-9efa23f64a43@virtuozzo.com>
Date: Tue, 11 Feb 2020 18:14:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200122132328.31156-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P192CA0007.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::17)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P192CA0007.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Tue, 11 Feb 2020 15:14:41 +0000
X-Tagtoolbar-Keys: D20200211181439899
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10e45cc9-103d-45a9-f8f6-08d7af051e8d
X-MS-TrafficTypeDiagnostic: AM6PR08MB3013:
X-Microsoft-Antispam-PRVS: <AM6PR08MB301353E2C2EBE883D27C9CB7C1180@AM6PR08MB3013.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:16;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(346002)(366004)(136003)(376002)(199004)(189003)(31696002)(86362001)(2906002)(5660300002)(4326008)(66476007)(8936002)(36756003)(66946007)(31686004)(66556008)(16526019)(478600001)(8676002)(81156014)(81166006)(186003)(6486002)(316002)(26005)(52116002)(2616005)(956004)(16576012)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3013;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTTi5eIWPaL1sIvLaAKNrMZcrQtl6Hri9kzLEjzkhYX6VPZuMMPCafekW9EHJJmJHwPXXtd33J7U8yFLoipk0RUfmAxvuRH+etNGV1/AjuylSbwdkBV6hrZTI9vbdLg2QYqq3KReZ+CJXCX44b0xu2bR1244yfvM3GvapOAaAQieYl3Y3prjsebveKFfhr28R9xFZLpgMtid0R0ayim3Smi2C1FPX5VpygSna3oO3Cu6LKzKYcsmQ25P/LWMhB1Zw7GWXAuofAm1pqWixfZWDZ7jwKx9Pg7Ww3ZygX2B8r9y9db1Yu4UznneMlRtFMuHSRH4EkEvyH2OezlBwaSduMgE31WtHdFiUaRS7i56wVJAVswVTv6rgeai3w/m2mShmWVFBmzh9XLoqwR7Gs7OiBeOqMCibeHa4EwruwgT7rFVMH03yYPMqErv4QXbWqJyJTuhM4B3C82BIdyTiC45XJ93Y+naSiulRLcUxCXRsn2ge79U1/Ikt5kD2SnuZQ1n
X-MS-Exchange-AntiSpam-MessageData: rDXcie1rpvsI8LIfGAv4oEDuQ+fYC6ANqGOdoHeIq5Nvx6yexc+zYlcwT1JaM2qveWM7B6jjH4J/B5rCKdbFbMXjopSXoJM2c8a3eoY0CgsSGzTpVh5WPYWDEnLvlhd5f6nEOeZWwiJeaN4i4zQL/w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e45cc9-103d-45a9-f8f6-08d7af051e8d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 15:14:41.9841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezdkZ3+qV2dGTPwRxCT6BkE8fzjtUtEnZVJScL1fGBkMGu43VgR+9nurLfbo27wv8GJDgzMcXO54QHKvMWSBNgyfbFY+pI+paiQLU5u9og0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3013
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.115
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
Cc: kwolf@redhat.com, fam@euphon.net, quintela@redhat.com, dgilbert@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.01.2020 16:23, Vladimir Sementsov-Ogievskiy wrote:
> Keep bitmap state for disabled bitmaps too. Keep the state until the
> end of the process. It's needed for the following commit to implement
> bitmap postcopy canceling.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 59 ++++++++++++++++++++++------------
>   1 file changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index eeaab2174e..f96458113c 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -131,6 +131,7 @@ typedef struct DirtyBitmapLoadBitmapState {
>       BlockDriverState *bs;
>       BdrvDirtyBitmap *bitmap;
>       bool migrated;
> +    bool enabled;
>   } DirtyBitmapLoadBitmapState;
>   
>   typedef struct DirtyBitmapLoadState {
> @@ -140,8 +141,11 @@ typedef struct DirtyBitmapLoadState {
>       BlockDriverState *bs;
>       BdrvDirtyBitmap *bitmap;
>   
> -    GSList *enabled_bitmaps;
> -    QemuMutex lock; /* protect enabled_bitmaps */
> +    bool bitmaps_enabled; /* set in dirty_bitmap_mig_before_vm_start */
> +    bool stream_ended; /* set when all migrated data handled */
> +
> +    GSList *bitmaps;
> +    QemuMutex lock; /* protect bitmaps */
>   } DirtyBitmapLoadState;
>   static DirtyBitmapLoadState dbm_load_state;
>   
> @@ -446,6 +450,7 @@ static int dirty_bitmap_load_start(QEMUFile *f)
>       Error *local_err = NULL;
>       uint32_t granularity = qemu_get_be32(f);
>       uint8_t flags = qemu_get_byte(f);
> +    DirtyBitmapLoadBitmapState *b;
>   
>       if (s->bitmap) {
>           error_report("Bitmap with the same name ('%s') already exists on "
> @@ -472,22 +477,23 @@ static int dirty_bitmap_load_start(QEMUFile *f)
>   
>       bdrv_disable_dirty_bitmap(s->bitmap);
>       if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
> -        DirtyBitmapLoadBitmapState *b;
> -
>           bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
>           if (local_err) {
>               error_report_err(local_err);
>               return -EINVAL;
>           }
> -
> -        b = g_new(DirtyBitmapLoadBitmapState, 1);
> -        b->bs = s->bs;
> -        b->bitmap = s->bitmap;
> -        b->migrated = false;
> -        dbm_load_state.enabled_bitmaps =
> -            g_slist_prepend(dbm_load_state.enabled_bitmaps, b);
>       }
>   
> +    b = g_new(DirtyBitmapLoadBitmapState, 1);
> +    *b = (DirtyBitmapLoadBitmapState) {
> +        .bs = s->bs,
> +        .bitmap = s->bitmap,
> +        .migrated = false,
> +        .enabled = flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED,
> +    };
> +
> +    dbm_load_state.bitmaps = g_slist_prepend(dbm_load_state.bitmaps, b);
> +
>       return 0;
>   }
>   
> @@ -497,22 +503,25 @@ void dirty_bitmap_mig_before_vm_start(void)
>   
>       qemu_mutex_lock(&dbm_load_state.lock);
>   
> -    for (item = dbm_load_state.enabled_bitmaps; item;
> -         item = g_slist_next(item))
> -    {
> +    for (item = dbm_load_state.bitmaps; item; item = g_slist_next(item)) {
>           DirtyBitmapLoadBitmapState *b = item->data;
>   
> +        if (!b->enabled) {
> +            continue;
> +        }
> +
>           if (b->migrated) {
>               bdrv_enable_dirty_bitmap_locked(b->bitmap);
>           } else {
>               bdrv_dirty_bitmap_enable_successor(b->bitmap);
>           }
> -
> -        g_free(b);
>       }
>   
> -    g_slist_free(dbm_load_state.enabled_bitmaps);
> -    dbm_load_state.enabled_bitmaps = NULL;
> +    dbm_load_state.bitmaps_enabled = true;
> +    if (dbm_load_state.stream_ended) {
> +        g_slist_free_full(dbm_load_state.bitmaps, g_free);
> +        dbm_load_state.bitmaps = NULL;
> +    }
>   
>       qemu_mutex_unlock(&dbm_load_state.lock);
>   }
> @@ -530,9 +539,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f)
>           bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
>       }
>   
> -    for (item = dbm_load_state.enabled_bitmaps; item;
> -         item = g_slist_next(item))
> -    {
> +    for (item = dbm_load_state.bitmaps; item; item = g_slist_next(item)) {
>           DirtyBitmapLoadBitmapState *b = item->data;
>   
>           if (b->bitmap == s->bitmap) {
> @@ -671,6 +678,16 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>           }
>       } while (!(dbm_load_state.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
>   
> +    qemu_mutex_lock(&dbm_load_state.lock);
> +
> +    dbm_load_state.stream_ended = true;

This is wrong. EOS doesn't mean that bitmap migration finished: only one set of sequential
bitmap chunks finished. EOS may be sent several times during migration and it is needed to
switch to other things migration.

> +    if (dbm_load_state.bitmaps_enabled) {
> +        g_slist_free_full(dbm_load_state.bitmaps, g_free);
> +        dbm_load_state.bitmaps = NULL;
> +    }
> +
> +    qemu_mutex_unlock(&dbm_load_state.lock);
> +
>       trace_dirty_bitmap_load_success();
>       return 0;
>   }
> 


-- 
Best regards,
Vladimir

