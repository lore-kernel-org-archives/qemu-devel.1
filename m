Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDC8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660E020663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hUUvpnKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660E020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k01Jp-00033S-Nj
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 07:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k01JC-0002TR-KQ; Mon, 27 Jul 2020 07:28:42 -0400
Received: from mail-eopbgr80103.outbound.protection.outlook.com
 ([40.107.8.103]:7284 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k01JA-0007zO-Aw; Mon, 27 Jul 2020 07:28:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYJ2QC+noEOlJowLePHizOUBy5zQh0+s58U5/OH+O+4KmxksaGD1YoNq13RmK+UKPoKIqByEfPEeUErFZ+JQJA3ljA70TYp2DVSgJF6BjUg1LzL2SzYI0sK6udQAGu/mXBzZCVJnh1r2N00FQl4tkxZKIoUvxkW051lLrTbf7f/MxmAJsneh60gxSEiIYxHEJQfrutPMKclbFOsdMgPFwWTAsiK7X9QdudvY6WSCIr1usnBknFS7sCQl+YHhABgqC0Bt/Huyh6J2WhB4XA23wvwZZeiElzRyqLAIhWEvF5olEyzLmmv+N3mDCv2Cri/NZlKFgW3/LPs1OjogD0IxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsFoWWsxWzDBNFZA86zU8L7NRRBmnAntjuGh7cK5WP8=;
 b=IqvKxk27ad4qvo666b0ZLLlR5CgHLgZZ31++WUHMBSU4rRqKuxU3BmOQwn5iH5s8OJv5f+6DMsGyZFfmMJHfxCtVUmfiQFbCBLzsOoZcIvGVBHD4xicYMmv1lBWCD9HizHk1CsRDQN1Ge3njZSPdf7swbo2p4tcjwcTJpZKDtJ1bwjdaUyMAMLJGUQVW48EJliJJeJrqdls8/222ylxtBOU3pA1uPMX+SggFHULHI2imcmGzznaardNpWus8eH7PExIPcaOxATHSYdbr2KdkmVAe3FLbMbLbG8n8YGnRKSmF7wOdu825H51DXE51MWIm4S06kfznJe+4D6mPg7NccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsFoWWsxWzDBNFZA86zU8L7NRRBmnAntjuGh7cK5WP8=;
 b=hUUvpnKr+7mHVaruNmX++J6TH62OUncX6mde2ysCRi8kn+FBNp2ZCsnnlaLFBhirxKD0JO7sHmh3yDNSpy6grSHQah8tkVN/sTN5M9y3sAVcrNRoYQIO2D7knzMN5ARIh1Zr/CzAYoD7MGDMg2pNdBhyFaCcg9c0LeT8ozxZmk8=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4951.eurprd08.prod.outlook.com (2603:10a6:20b:eb::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Mon, 27 Jul
 2020 11:28:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 11:28:36 +0000
Subject: Re: [PATCH v3 15/21] migration/block-dirty-bitmap: relax error
 handling in incoming part
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
 <20200724084327.15665-16-vsementsov@virtuozzo.com>
 <20200727112337.GK3040@work-vm>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <dc79f27c-bb9d-e5f8-d29b-730d0e30df21@virtuozzo.com>
Date: Mon, 27 Jul 2020 14:28:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727112337.GK3040@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0106.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::47) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR06CA0106.eurprd06.prod.outlook.com (2603:10a6:208:fa::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Mon, 27 Jul 2020 11:28:35 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d583fdf5-90f9-4db9-9521-08d8322033a6
X-MS-TrafficTypeDiagnostic: AM6PR08MB4951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4951FDAAD7C9C9D3A95859DEC1720@AM6PR08MB4951.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcH1rHc8HyPUR3Fw/0YigHd+QXzSvejYc9f2gYyg5jDgUEUNSUPjNEHt2DDWBpVZKMiUEDgHE5zWyHdAHXfXh5hHOVc1Sp9ID+EoRuu0dMQthLLIe5PzxjtOsCzWJsHgvyo3jesv+gEdXmKSgZcirC3ucviyzTelCk11HSRDAIkTP69nIsk7nfy8goT7HnQkG82HdTTAt+v+Or4QY0Mcj7u3vO+hxekzviIYYFqWpWQgakGeDmz2yyd1KLWm3H7afYS0XzeTp/RpZ/X1XJI+krfyM/hcoYYaw4Bz0ziE9297D+tG7oQ7uV1Hp9Y8eGYxgqqd7jTa0OJY9sIwUT8L/POZY4YwtIOKwFOZQDMkIv+9zj8s7usuEK2Sw70nlX2iqbT9r/lxtYetVrLUp0BsBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39840400004)(346002)(376002)(136003)(66946007)(66476007)(66556008)(478600001)(7416002)(4326008)(6916009)(107886003)(8936002)(83380400001)(52116002)(6486002)(86362001)(31696002)(5660300002)(2616005)(16576012)(31686004)(316002)(36756003)(2906002)(8676002)(956004)(16526019)(26005)(186003)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: RYYZD6BHLwRjN/fD+gfqiLwj9oCR7SMrrzRdACZtejbnjQ5vDpe4IYtyVjkIQjUj9luwgXXhrx7t7ICSgGr4jiTYYcAlRxrH1zSmd7pID94lxVQVd7KFnd2zPWVoil3d2Pj6JTKOdflYVApGFL4l13Sj6Jrq0IY4W0rsi4OjjnmTpgSDiiR+uJzulExNdZq7ClXiHRMhaDdzLFfhSmVo9g0g2UixCrRDvTlmRlbVUCf03UHPS1lgLS/tQz127cnrgSM1/3S/C2APCn0KHPNyiXN3L7GoxPmAaqXFsVUs7NBPnrJAniPDq5RdYZIarnGOxjXnNZzFo1boQQRcKruBvNcXcoBqNZ/LbZdWnX+BHgPTbPMRgB//rlp2lNnBYK6EiWW8UWyMlQ/1/BcPg9gQRN1RVU3ycyTCsODTSvj+kaH1NcepQ8fV4mf5FXt0ttXnvtJiaMvrWQD6zO//uv5o6EGfMgNce9G0ywX1H/9JyB9O86MLC3Y8mPyM5nUQdKNO
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d583fdf5-90f9-4db9-9521-08d8322033a6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 11:28:36.0549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+8qbmb4QvMiO3XKwiZMoHBCATnd61ZHddYbko+AoREXHZ0WX7SOz9SMe7ImG0kkKY1eT0nxw5By1t5HJFPyTIB0Zs3lyiEQHofOeCkweQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4951
Received-SPF: pass client-ip=40.107.8.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 07:28:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.07.2020 14:23, Dr. David Alan Gilbert wrote:
> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>> Bitmaps data is not critical, and we should not fail the migration (or
>> use postcopy recovering) because of dirty-bitmaps migration failure.
>> Instead we should just lose unfinished bitmaps.
>>
>> Still we have to report io stream violation errors, as they affect the
>> whole migration stream.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   migration/block-dirty-bitmap.c | 152 +++++++++++++++++++++++++--------
>>   1 file changed, 117 insertions(+), 35 deletions(-)
>>
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>> index eb4ffeac4d..c24d4614bf 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -145,6 +145,15 @@ typedef struct DBMLoadState {
>>   
>>       bool before_vm_start_handled; /* set in dirty_bitmap_mig_before_vm_start */
>>   
>> +    /*
>> +     * cancelled
>> +     * Incoming migration is cancelled for some reason. That means that we
>> +     * still should read our chunks from migration stream, to not affect other
>> +     * migration objects (like RAM), but just ignore them and do not touch any
>> +     * bitmaps or nodes.
>> +     */
>> +    bool cancelled;
>> +
>>       GSList *bitmaps;
>>       QemuMutex lock; /* protect bitmaps */
>>   } DBMLoadState;
>> @@ -531,6 +540,10 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
>>       uint8_t flags = qemu_get_byte(f);
>>       LoadBitmapState *b;
>>   
>> +    if (s->cancelled) {
>> +        return 0;
>> +    }
>> +
>>       if (s->bitmap) {
>>           error_report("Bitmap with the same name ('%s') already exists on "
>>                        "destination", bdrv_dirty_bitmap_name(s->bitmap));
>> @@ -613,13 +626,47 @@ void dirty_bitmap_mig_before_vm_start(void)
>>       qemu_mutex_unlock(&s->lock);
>>   }
>>   
>> +static void cancel_incoming_locked(DBMLoadState *s)
>> +{
>> +    GSList *item;
>> +
>> +    if (s->cancelled) {
>> +        return;
>> +    }
>> +
>> +    s->cancelled = true;
>> +    s->bs = NULL;
>> +    s->bitmap = NULL;
>> +
>> +    /* Drop all unfinished bitmaps */
>> +    for (item = s->bitmaps; item; item = g_slist_next(item)) {
>> +        LoadBitmapState *b = item->data;
>> +
>> +        /*
>> +         * Bitmap must be unfinished, as finished bitmaps should already be
>> +         * removed from the list.
>> +         */
>> +        assert(!s->before_vm_start_handled || !b->migrated);
>> +        if (bdrv_dirty_bitmap_has_successor(b->bitmap)) {
>> +            bdrv_reclaim_dirty_bitmap(b->bitmap, &error_abort);
>> +        }
>> +        bdrv_release_dirty_bitmap(b->bitmap);
>> +    }
>> +
>> +    g_slist_free_full(s->bitmaps, g_free);
>> +    s->bitmaps = NULL;
>> +}
>> +
>>   static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>>   {
>>       GSList *item;
>>       trace_dirty_bitmap_load_complete();
>> -    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
>>   
>> -    qemu_mutex_lock(&s->lock);
>> +    if (s->cancelled) {
>> +        return;
>> +    }
>> +
>> +    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
>>   
>>       if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
>>           bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
>> @@ -637,8 +684,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>>               break;
>>           }
>>       }
>> -
>> -    qemu_mutex_unlock(&s->lock);
>>   }
>>   
>>   static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>> @@ -650,15 +695,32 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>>   
>>       if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>>           trace_dirty_bitmap_load_bits_zeroes();
>> -        bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte, nr_bytes,
>> -                                             false);
>> +        if (!s->cancelled) {
>> +            bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte,
>> +                                                 nr_bytes, false);
>> +        }
>>       } else {
>>           size_t ret;
>>           uint8_t *buf;
>>           uint64_t buf_size = qemu_get_be64(f);
>> -        uint64_t needed_size =
>> -            bdrv_dirty_bitmap_serialization_size(s->bitmap,
>> -                                                 first_byte, nr_bytes);
>> +        uint64_t needed_size;
>> +
>> +        buf = g_malloc(buf_size);
>> +        ret = qemu_get_buffer(f, buf, buf_size);
>> +        if (ret != buf_size) {
>> +            error_report("Failed to read bitmap bits");
>> +            g_free(buf);
>> +            return -EIO;
>> +        }
>> +
>> +        if (s->cancelled) {
>> +            g_free(buf);
>> +            return 0;
>> +        }
>> +
>> +        needed_size = bdrv_dirty_bitmap_serialization_size(s->bitmap,
>> +                                                           first_byte,
>> +                                                           nr_bytes);
>>   
>>           if (needed_size > buf_size ||
>>               buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
>> @@ -667,15 +729,8 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>>               error_report("Migrated bitmap granularity doesn't "
>>                            "match the destination bitmap '%s' granularity",
>>                            bdrv_dirty_bitmap_name(s->bitmap));
>> -            return -EINVAL;
>> -        }
>> -
>> -        buf = g_malloc(buf_size);
>> -        ret = qemu_get_buffer(f, buf, buf_size);
>> -        if (ret != buf_size) {
>> -            error_report("Failed to read bitmap bits");
>> -            g_free(buf);
>> -            return -EIO;
>> +            cancel_incoming_locked(s);
>> +            return 0;
>>           }
>>   
>>           bdrv_dirty_bitmap_deserialize_part(s->bitmap, buf, first_byte, nr_bytes,
>> @@ -700,14 +755,16 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
>>               error_report("Unable to read node name string");
>>               return -EINVAL;
>>           }
>> -        s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
>> -        if (!s->bs) {
>> -            error_report_err(local_err);
>> -            return -EINVAL;
>> +        if (!s->cancelled) {
>> +            s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
>> +            if (!s->bs) {
>> +                error_report_err(local_err);
>> +                cancel_incoming_locked(s);
>> +            }
>>           }
>> -    } else if (!s->bs && !nothing) {
>> +    } else if (!s->bs && !nothing && !s->cancelled) {
>>           error_report("Error: block device name is not set");
>> -        return -EINVAL;
>> +        cancel_incoming_locked(s);
>>       }
>>   
>>       if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
>> @@ -715,24 +772,38 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
>>               error_report("Unable to read bitmap name string");
>>               return -EINVAL;
>>           }
>> -        s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
>> -
>> -        /* bitmap may be NULL here, it wouldn't be an error if it is the
>> -         * first occurrence of the bitmap */
>> -        if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
>> -            error_report("Error: unknown dirty bitmap "
>> -                         "'%s' for block device '%s'",
>> -                         s->bitmap_name, s->node_name);
>> -            return -EINVAL;
>> +        if (!s->cancelled) {
>> +            s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
>> +
>> +            /*
>> +             * bitmap may be NULL here, it wouldn't be an error if it is the
>> +             * first occurrence of the bitmap
>> +             */
>> +            if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
>> +                error_report("Error: unknown dirty bitmap "
>> +                             "'%s' for block device '%s'",
>> +                             s->bitmap_name, s->node_name);
>> +                cancel_incoming_locked(s);
>> +            }
>>           }
>> -    } else if (!s->bitmap && !nothing) {
>> +    } else if (!s->bitmap && !nothing && !s->cancelled) {
>>           error_report("Error: block device name is not set");
>> -        return -EINVAL;
>> +        cancel_incoming_locked(s);
>>       }
>>   
>>       return 0;
>>   }
>>   
>> +/*
>> + * dirty_bitmap_load
>> + *
>> + * Load sequence of dirty bitmap chunks. Return error only on fatal io stream
>> + * violations. On other errors just cancel bitmaps incoming migration and return
>> + * 0.
>> + *
>> + * Note, than when incoming bitmap migration is canceled, we still must read all
>> + * our chunks (and just ignore them), to not affect other migration objects.
>> + */
>>   static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>>   {
>>       DBMLoadState *s = &((DBMState *)opaque)->load;
>> @@ -741,12 +812,19 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>>       trace_dirty_bitmap_load_enter();
>>   
>>       if (version_id != 1) {
>> +        qemu_mutex_lock(&s->lock);
>> +        cancel_incoming_locked(s);
>> +        qemu_mutex_unlock(&s->lock);
>>           return -EINVAL;
>>       }
>>   
>>       do {
>> +        qemu_mutex_lock(&s->lock);
> 
> Would QEMU_LOCK_GUARD(&s->lock)  work there?
> It avoids the need to catch the unlock on each of the failure cases.
> 

Yes it should work, thanks. I just didn't know about this thing.


> 
>>           ret = dirty_bitmap_load_header(f, s);
>>           if (ret < 0) {
>> +            cancel_incoming_locked(s);
>> +            qemu_mutex_unlock(&s->lock);
>>               return ret;
>>           }
>>   
>> @@ -763,8 +841,12 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>>           }
>>   
>>           if (ret) {
>> +            cancel_incoming_locked(s);
>> +            qemu_mutex_unlock(&s->lock);
>>               return ret;
>>           }
>> +
>> +        qemu_mutex_unlock(&s->lock);
>>       } while (!(s->flags & DIRTY_BITMAP_MIG_FLAG_EOS));
>>   
>>       trace_dirty_bitmap_load_success();
>> -- 
>> 2.21.0
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 


-- 
Best regards,
Vladimir

