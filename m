Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03A5C34049
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E0D24125
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="e2B8N4aX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E0D24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j482o-0004dh-Ji
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j481K-0003Ut-7d
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j481E-00008E-EL
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:54:58 -0500
Received: from mail-eopbgr130122.outbound.protection.outlook.com
 ([40.107.13.122]:59561 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4818-0008LC-Hf; Tue, 18 Feb 2020 13:54:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4wagxC70LnAL3IVElEvYb7HXYKmcu8D7Ncwzwgwn7IQtcps3KK8SBMI2xAzFQitnaZrACvVKcBDjcCjJIfSWZ8DH4nAJM67cmL0K0oKyr4GYizLS3qcuC3fykQiePTxjmM0BFtqY4hEW2r9VvGxl6mC9Oy08C9lLDYWej17t5kz3b9vURVn7hZKU/Vju91poKrm1Mn9DKweeG0SiUlLzA5Omg63PKUss8dH2FTicEwUfedLJnCxtCH+2CN8nFBxT/ekDmodUifwkLYc4LZnMpwx6Ss4GJf4zHk7IHL02OB/8CchcsJlnaDVSUz3x+PEHHhuhpR17/eXJMAFJBhNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rhZmZW8DlZW2RfKj//n3RzjhJ2Uj8NtMmuV184DFCY=;
 b=iqfwxHjd5klgQnhO7c972yX/sJoA/CW7hU2WiDTPXhCryzyCDpwKKSJjuOmXM8VSQEtdcXhfv2nJGB0fPFqio/fNr7UqFCx21M8bIXhwU/Xs0By6MYoMKq4umiY/v6wMwZWF4SfP+B5sRqFvnYufrcGHBbKBrSA0+ajEqUTwpjX4lbpau+z2dmi8PmMl6/XvxUoJWlj1xj+8ly53zKZpZ3bUwz2pGsmkzjqjXWEBJ2Yi36jw17ZLTByWM8ZEE6GlKY+TLpldTtBYpwKyBqrYiKw9c7RIfBG4vHA95TJM1XdjNsUE8Uf6rYCQWKhhNIUPYq4x8uU+aXnglpiJW6rzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rhZmZW8DlZW2RfKj//n3RzjhJ2Uj8NtMmuV184DFCY=;
 b=e2B8N4aX0Vf3AL326bEor6CRy8XA9nC1EB4XYiQUL+Kz538CoDYBgDNUr15kxP2SnP0dMV/ucclj7akIgCcQsdOafzcyqGUdcjohvX0o1wGG6Nf6RIDayqzHX2k73Xgxhzpd0CcVK6V8Gk3bJ/EfnGjG/WtQKyOOiROP1OoF7iw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4567.eurprd08.prod.outlook.com (20.179.3.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Tue, 18 Feb 2020 18:54:44 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 18:54:43 +0000
Subject: Re: [PATCH v2 09/22] migration/block-dirty-bitmap: relax error
 handling in incoming part
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-10-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <9a2bb54f-108b-a4bd-37e2-8382112c84ee@virtuozzo.com>
Date: Tue, 18 Feb 2020 21:54:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::25) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0202CA0015.eurprd02.prod.outlook.com (2603:10a6:3:8c::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 18:54:43 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 538c627a-2794-4521-82db-08d7b4a40466
X-MS-TrafficTypeDiagnostic: AM6PR08MB4567:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4567DE6E8A181057FBA29743F4110@AM6PR08MB4567.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:235;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(16576012)(6486002)(31696002)(36916002)(52116002)(86362001)(316002)(16526019)(44832011)(956004)(31686004)(54906003)(478600001)(5660300002)(53546011)(186003)(81156014)(8676002)(66946007)(81166006)(8936002)(66556008)(2906002)(66476007)(2616005)(36756003)(4326008)(26005)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4567;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnBGBUNgY9OfiQS+VgC5iqB6lSe/KeQ5vCJsw25OvNgjeir96zyu9Rj641BMnb+cjWnsEu5IFcC7OmFXw+vAXL3uuG4E62UsPGlAaiYPL671mfzOiw6FTSRVFgu6IWAcAK0zfAcHs+xrb9dDV0vFZCyP+7/urDRvhbNUm0TQBcYMIigtM8huShEAzev367xJjyNUcA/e54brK1/n4Kcmac9vdnn+Vpr/1W3z2YEMOADoy9DKVkTWH2ytt8AB2c5GljKwjikdrWvNnNnyJq/m4X+crWpaIT/k5Yv7jsJdM6nHYnAfr3hQ7yH6e21qqaJVOxnXNFaS4mikehKjGvUU1K4Re8x4UgDI5xrbbcb0x+pFSKmELbjXSaXRyfqFL/crhdSbD43Ta7p/HPW544nZFpL1pkEHi6eGPH0+nRG8OyRYXRFM1iQOh40R6PdLk3lxOsCo3EE7BqINRLcOjO1HCUUdzuS7AKMRYzmfx21Z2zU=
X-MS-Exchange-AntiSpam-MessageData: /H4CVpbvkDU4YGNumP5C/JfvA94Xa1yLzPfLnP58SoqWsPwSTgNbORD9Bn8fpYHJ69sFEnhLyMmQ5cyEL41hDMAoVqfj9N6wMwKMqEdd0x6ba5R+mgD0QK9q/X1qumMGWLSJxco/9Rwjh76wliDo7Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538c627a-2794-4521-82db-08d7b4a40466
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 18:54:43.8897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph3WZ/EBlDwqmLp58nPIV//0iNlsNp4LIhy2Hb8ONF6MFLWSRP8Sj7PD+Lanaj8Z61wjebGlcNYPh8ZTP9t9Q9fQO4VN6mVc6H8Pw8V90E8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4567
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.13.122
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
> Bitmaps data is not critical, and we should not fail the migration (or
> use postcopy recovering) because of dirty-bitmaps migration failure.
> Instead we should just lose unfinished bitmaps.
> 
> Still we have to report io stream violation errors, as they affect the
> whole migration stream.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 148 +++++++++++++++++++++++++--------
>   1 file changed, 113 insertions(+), 35 deletions(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 1329db8d7d..aea5326804 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -145,6 +145,15 @@ typedef struct DBMLoadState {
>   
>       bool before_vm_start_handled; /* set in dirty_bitmap_mig_before_vm_start */
>   
> +    /*
> +     * cancelled
> +     * Incoming migration is cancelled for some reason. That means that we
> +     * still should read our chunks from migration stream, to not affect other
> +     * migration objects (like RAM), but just ignore them and do not touch any
> +     * bitmaps or nodes.
> +     */
> +    bool cancelled;
> +
>       GSList *bitmaps;
>       QemuMutex lock; /* protect bitmaps */
>   } DBMLoadState;
> @@ -545,13 +554,47 @@ void dirty_bitmap_mig_before_vm_start(void)
>       qemu_mutex_unlock(&s->lock);
>   }
>   
> +static void cancel_incoming_locked(DBMLoadState *s)
> +{
> +    GSList *item;
> +
> +    if (s->cancelled) {
> +        return;
> +    }
> +
> +    s->cancelled = true;
> +    s->bs = NULL;
> +    s->bitmap = NULL;
> +
> +    /* Drop all unfinished bitmaps */
> +    for (item = s->bitmaps; item; item = g_slist_next(item)) {
> +        LoadBitmapState *b = item->data;
> +
> +        /*
> +         * Bitmap must be unfinished, as finished bitmaps should already be
> +         * removed from the list.
> +         */
> +        assert(!s->before_vm_start_handled || !b->migrated);
> +        if (bdrv_dirty_bitmap_has_successor(b->bitmap)) {
> +            bdrv_reclaim_dirty_bitmap(b->bitmap, &error_abort);
> +        }
> +        bdrv_release_dirty_bitmap(b->bitmap);
> +    }
> +
> +    g_slist_free_full(s->bitmaps, g_free);
> +    s->bitmaps = NULL;
> +}
> +
>   static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>   {
>       GSList *item;
>       trace_dirty_bitmap_load_complete();
> -    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
>   
> -    qemu_mutex_lock(&s->lock);

Why is it safe to remove the critical section?

> +    if (s->cancelled) {
> +        return;
> +    }
> +
> +    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
>   
>       if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
>           bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
> @@ -569,8 +612,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>               break;
>           }
>       }
> -
> -    qemu_mutex_unlock(&s->lock);
>   }
>   
>   static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
> @@ -582,15 +623,32 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>   
>       if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>           trace_dirty_bitmap_load_bits_zeroes();
> -        bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte, nr_bytes,
> -                                             false);
> +        if (!s->cancelled) {
> +            bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte,
> +                                                 nr_bytes, false);
> +        }
>       } else {
>           size_t ret;
>           uint8_t *buf;
>           uint64_t buf_size = qemu_get_be64(f);
> -        uint64_t needed_size =
> -            bdrv_dirty_bitmap_serialization_size(s->bitmap,
> -                                                 first_byte, nr_bytes);
> +        uint64_t needed_size;
> +
> +        buf = g_malloc(buf_size);
> +        ret = qemu_get_buffer(f, buf, buf_size);
> +        if (ret != buf_size) {
> +            error_report("Failed to read bitmap bits");
> +            g_free(buf);
> +            return -EIO;
> +        }
> +
> +        if (s->cancelled) {
> +            g_free(buf);
> +            return 0;
> +        }
> +
> +        needed_size = bdrv_dirty_bitmap_serialization_size(s->bitmap,
> +                                                           first_byte,
> +                                                           nr_bytes);
>   
>           if (needed_size > buf_size ||
>               buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
> @@ -599,15 +657,8 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>               error_report("Migrated bitmap granularity doesn't "
>                            "match the destination bitmap '%s' granularity",
>                            bdrv_dirty_bitmap_name(s->bitmap));
> -            return -EINVAL;
> -        }
> -
> -        buf = g_malloc(buf_size);
> -        ret = qemu_get_buffer(f, buf, buf_size);
> -        if (ret != buf_size) {
> -            error_report("Failed to read bitmap bits");
> -            g_free(buf);
> -            return -EIO;
> +            cancel_incoming_locked(s);

                /* Continue the VM migration as bitmaps data are not 
critical */

> +            return 0;
>           }
>   
>           bdrv_dirty_bitmap_deserialize_part(s->bitmap, buf, first_byte, nr_bytes,
> @@ -632,14 +683,16 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
>               error_report("Unable to read node name string");
>               return -EINVAL;
>           }
> -        s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
> -        if (!s->bs) {
> -            error_report_err(local_err);
> -            return -EINVAL;
> +        if (!s->cancelled) {
> +            s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
> +            if (!s->bs) {
> +                error_report_err(local_err);

The error message may be supplemented with a report about the canceled 
bitmap migration. Also down there at cancel_incoming_locked(s).

> +                cancel_incoming_locked(s);
> +            }
>           }
> -    } else if (!s->bs && !nothing) {
> +    } else if (!s->bs && !nothing && !s->cancelled) {
>           error_report("Error: block device name is not set");
> -        return -EINVAL;
> +        cancel_incoming_locked(s);
>       }
>   
>       if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
> @@ -647,24 +700,38 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
>               error_report("Unable to read bitmap name string");
>               return -EINVAL;
>           }
> -        s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
> -
> -        /* bitmap may be NULL here, it wouldn't be an error if it is the
> -         * first occurrence of the bitmap */
> -        if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
> -            error_report("Error: unknown dirty bitmap "
> -                         "'%s' for block device '%s'",
> -                         s->bitmap_name, s->node_name);
> -            return -EINVAL;
> +        if (!s->cancelled) {
> +            s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
> +
> +            /*
> +             * bitmap may be NULL here, it wouldn't be an error if it is the
> +             * first occurrence of the bitmap
> +             */
> +            if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
> +                error_report("Error: unknown dirty bitmap "
> +                             "'%s' for block device '%s'",
> +                             s->bitmap_name, s->node_name);
> +                cancel_incoming_locked(s);
> +            }
>           }
> -    } else if (!s->bitmap && !nothing) {
> +    } else if (!s->bitmap && !nothing && !s->cancelled) {
>           error_report("Error: block device name is not set");
> -        return -EINVAL;
> +        cancel_incoming_locked(s);
>       }
>   
>       return 0;
>   }
>   
> +/*
> + * dirty_bitmap_load
> + *
> + * Load sequence of dirty bitmap chunks. Return error only on fatal io stream
> + * violations. On other errors just cancel bitmaps incoming migration and return
> + * 0.
> + *
> + * Note, than when incoming bitmap migration is canceled, we still must read all
"than (that)" may be omitted

> + * our chunks (and just ignore them), to not affect other migration objects.
> + */
>   static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>   {
>       DBMLoadState *s = &((DBMState *)opaque)->load;
> @@ -673,12 +740,19 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>       trace_dirty_bitmap_load_enter();
>   
>       if (version_id != 1) {
> +        qemu_mutex_lock(&s->lock);
> +        cancel_incoming_locked(s);
> +        qemu_mutex_unlock(&s->lock);
>           return -EINVAL;
>       }
>   
>       do {
> +        qemu_mutex_lock(&s->lock);
> +
>           ret = dirty_bitmap_load_header(f, s);
>           if (ret < 0) {
> +            cancel_incoming_locked(s);
> +            qemu_mutex_unlock(&s->lock);
>               return ret;
>           }
>   
> @@ -695,8 +769,12 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>           }
>   
>           if (ret) {
> +            cancel_incoming_locked(s);
> +            qemu_mutex_unlock(&s->lock);
>               return ret;
>           }
> +
> +        qemu_mutex_unlock(&s->lock);
>       } while (!(s->flags & DIRTY_BITMAP_MIG_FLAG_EOS));
>   
>       trace_dirty_bitmap_load_success();
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

