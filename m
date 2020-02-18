Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F978C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D410208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dlpfpo0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D410208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46Ld-0005Qf-G1
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j46L1-0004sD-Ax
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j46L0-0002VC-3p
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:07:11 -0500
Received: from mail-vi1eur05on2137.outbound.protection.outlook.com
 ([40.107.21.137]:5440 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j46Kw-0002Pr-9r; Tue, 18 Feb 2020 12:07:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFfTLwXekKeok3MmxsANeIxTMWBF3j+5XNUi3cgiDg6sYT6lO9SEey8aUwfEj1Jm7jSKcGH4K8U6WxOoowOX8X2CLWlIYvEE/H02Lf85yOClE6mcJMTu9yofHEvLn8QijZZHBGW8G9vRhMnmmmkwjoFqqeH8IEZup8KtjBnQHhPumBDBIk8AqOHUC7TYyAYGqt+kZcwanqWFbbB+OdyV27fYVjoXhEjnfWVa4eDGv1tT5xX4ZgiFRL2/0jMvVFjlnjGfGzk7Uzq+HXs5MkaPw8Z3CTujp2p2A4z1U5Q/QIybuFga2eb7xhvflXH6go2AHhv7feTsQsQnzduTzpYXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McspLDCXTOGVst4P7YzgRC3f6sWBlrNnvPUfoTITxn0=;
 b=BCrnuZQIkR7ATnsVqTF1FK+ju7MmUiBeqpO7Y3qFpjB79GyZGeC8RcbXtXDC14EMN/5zp9eCKy3iBcFfy+XZSg75rrQy7MkR58F7qI/IOJRmMtj53tdwYn16RJZUJv54qo469/78Mn0dtTiqBf0kLHijNoezOyoWNRsYs9aUBYy6BPxyV8wk/0vbNmGVAHyTjS9FJZoqrE7Xo5TVnXiCR/GgI+vieFPFhSE9krrnHyhtpElX8vvLB5Wa2uLTNvAbKZyil6AQrCQU7AJuwfTzlobI35l3wwBb9MmwVNnszXzptDm5qultHBE8XOU32iNQxDOYA+lXZT9ZUDjNe/pdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McspLDCXTOGVst4P7YzgRC3f6sWBlrNnvPUfoTITxn0=;
 b=dlpfpo0aecli6Fh1LfzTdczNQzKnEeg/u0jtL3DJnrLxexFAA/QsTFFrxc0A+LAcmUZYzc1lxT5tQlSHHydvNpc9T3Py59tcqmXzs+efw2X6wikmSCD7fePyJJ0LWW5mvwbNEVa3x/M2PuqPIu7hLywAKy26PnVmGftpLiC4h3A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3174.eurprd08.prod.outlook.com (52.135.163.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Tue, 18 Feb 2020 17:07:03 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 17:07:03 +0000
Subject: Re: [PATCH v2 08/22] migration/block-dirty-bitmap: keep bitmap state
 for all bitmaps
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-9-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <5bcb49d4-6da3-0fe2-a1b4-4f910192acbb@virtuozzo.com>
Date: Tue, 18 Feb 2020 20:07:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0205.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::29) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR05CA0205.eurprd05.prod.outlook.com (2603:10a6:3:f9::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Tue, 18 Feb 2020 17:07:02 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94b58b0d-f57f-4dec-2b80-08d7b494f9c5
X-MS-TrafficTypeDiagnostic: AM6PR08MB3174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3174D46D1A7D5C7886202506F4110@AM6PR08MB3174.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(396003)(346002)(376002)(136003)(199004)(189003)(54906003)(316002)(16576012)(66476007)(66946007)(66556008)(36756003)(36916002)(53546011)(31696002)(52116002)(86362001)(2906002)(478600001)(81166006)(44832011)(8936002)(81156014)(6486002)(26005)(4326008)(16526019)(186003)(5660300002)(2616005)(956004)(31686004)(8676002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3174;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6Ynwpx8PlQ6mdftoz5iBivHEOx/Zedu5uk797/D2llazz5KeSczoD31/g0KE3DXt7tA6PyBMcc6vOSMCTpOrD1ft3h81gST7c7T9SZfy/ZU3jZqMm1fH+a8xDjZQbhvxpA4GywWV2aWC4tAV2sNyd+8pGN1KN5ovw5TP2rFkeVDssrjKb6uy9w1R8U8VMGVPmWEMkyxfD6yj/Zoppi+ydm0THrU85ziKgCFTuOOutDTAuPU9f/l/1jwKmNROytdj+tIP3Gi7cNo61tv57XiLb1sftR/PQwHY+f7AWnnOZWWSaCjvd6qExdhTE8bFJvJbmqC6m3GjmKizscOw47bAzUJslDGGyYebHQKsxqjg9PlaHzWMrNrtA/kct4Y9V5exOzh+5piCafMFIKusvVLWSzJfRyRWYBqrLDkemzSEov4CK8NF8L8X2FIope2ut8AckxXL183f3c20HWLSfQXeMw5jUIPP9nTpuHSF0SfjzAXZJMo37qdhkWpzBsNgCMW
X-MS-Exchange-AntiSpam-MessageData: xZdGOeKx6GJW9xWmfxd9arCzNl5Q43YmjyOtTMwiBD03/DXiqBqnp2SaTk2Usb7yLtxHqK5X3CLK6YcwxlAAmABkiia+yJDR5wA0lsGMTGjQoXx1QaDF/y45UmN0fIVArcpccZoeJBWenQvFfibr7w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b58b0d-f57f-4dec-2b80-08d7b494f9c5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 17:07:03.6581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OF6VHgl/bNn+U4v61bKLcQI2ePzPC9w/S4Geqrsfxr+mZGywAsWmjmVfvj6KRQ6iHfrg8A5y6h2YVBfIHuW0P8M4X21aAjK/cFGwTrZm0sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3174
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.21.137
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



On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
> Keep bitmap state for disabled bitmaps too. Keep the state until the
> end of the process. It's needed for the following commit to implement
> bitmap postcopy canceling.
> 
> To clean-up the new list the following logic is used:
> We need two events to consider bitmap migration finished:
> 1. chunk with DIRTY_BITMAP_MIG_FLAG_COMPLETE flag should be received
> 2. dirty_bitmap_mig_before_vm_start should be called
> These two events may come in any order, so we understand which one is
> last, and on the last of them we remove bitmap migration state from the
> list.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 64 +++++++++++++++++++++++-----------
>   1 file changed, 43 insertions(+), 21 deletions(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 9cc750d93b..1329db8d7d 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -132,6 +132,7 @@ typedef struct LoadBitmapState {
>       BlockDriverState *bs;
>       BdrvDirtyBitmap *bitmap;
>       bool migrated;
> +    bool enabled;
>   } LoadBitmapState;
>   
>   /* State of the dirty bitmap migration (DBM) during load process */
> @@ -142,8 +143,10 @@ typedef struct DBMLoadState {
>       BlockDriverState *bs;
>       BdrvDirtyBitmap *bitmap;
>   
> -    GSList *enabled_bitmaps;
> -    QemuMutex lock; /* protect enabled_bitmaps */
> +    bool before_vm_start_handled; /* set in dirty_bitmap_mig_before_vm_start */
> +
> +    GSList *bitmaps;
> +    QemuMutex lock; /* protect bitmaps */
>   } DBMLoadState;
>   
>   typedef struct DBMState {
> @@ -458,6 +461,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
>       Error *local_err = NULL;
>       uint32_t granularity = qemu_get_be32(f);
>       uint8_t flags = qemu_get_byte(f);
> +    LoadBitmapState *b;
>   
>       if (s->bitmap) {
>           error_report("Bitmap with the same name ('%s') already exists on "
> @@ -484,45 +488,59 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
>   
>       bdrv_disable_dirty_bitmap(s->bitmap);
>       if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
> -        LoadBitmapState *b;
> -
>           bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
>           if (local_err) {
>               error_report_err(local_err);
>               return -EINVAL;
>           }
> -
> -        b = g_new(LoadBitmapState, 1);
> -        b->bs = s->bs;
> -        b->bitmap = s->bitmap;
> -        b->migrated = false;
> -        s->enabled_bitmaps = g_slist_prepend(s->enabled_bitmaps, b);
>       }
>   
> +    b = g_new(LoadBitmapState, 1);
> +    b->bs = s->bs;
> +    b->bitmap = s->bitmap;
> +    b->migrated = false;
> +    b->enabled = flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED,
> +
> +    s->bitmaps = g_slist_prepend(s->bitmaps, b);
> +
>       return 0;
>   }
>   
> -void dirty_bitmap_mig_before_vm_start(void)
> +/*
> + * before_vm_start_handle_item
> + *
> + * g_slist_foreach helper
> + *
> + * item is LoadBitmapState*
> + * opaque is DBMLoadState*
> + */
> +static void before_vm_start_handle_item(void *item, void *opaque)
>   {
> -    DBMLoadState *s = &dbm_state.load;
> -    GSList *item;
> -
> -    qemu_mutex_lock(&s->lock);
> -
> -    for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
> -        LoadBitmapState *b = item->data;
> +    DBMLoadState *s = opaque;
> +    LoadBitmapState *b = item;
>   
> +    if (b->enabled) {
>           if (b->migrated) {
>               bdrv_enable_dirty_bitmap(b->bitmap);
>           } else {
>               bdrv_dirty_bitmap_enable_successor(b->bitmap);
>           }
> +    }
>   
> +    if (b->migrated) {
> +        s->bitmaps = g_slist_remove(s->bitmaps, b);
>           g_free(b);
>       }
> +}
>   
> -    g_slist_free(s->enabled_bitmaps);
> -    s->enabled_bitmaps = NULL;
> +void dirty_bitmap_mig_before_vm_start(void)
> +{
> +    DBMLoadState *s = &dbm_state.load;
> +    qemu_mutex_lock(&s->lock);
> +
> +    assert(!s->before_vm_start_handled);
> +    g_slist_foreach(s->bitmaps, before_vm_start_handle_item, s);
> +    s->before_vm_start_handled = true;
>   
>       qemu_mutex_unlock(&s->lock);
>   }
> @@ -539,11 +557,15 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>           bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
>       }
>   
> -    for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
> +    for (item = s->bitmaps; item; item = g_slist_next(item)) {
>           LoadBitmapState *b = item->data;
>   
>           if (b->bitmap == s->bitmap) {
>               b->migrated = true;
> +            if (s->before_vm_start_handled) {
> +                s->bitmaps = g_slist_remove(s->bitmaps, b);
> +                g_free(b);
> +            }
>               break;
>           }
>       }
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

