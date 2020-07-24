Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0AEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A392065E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="b/GHLZm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A392065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jys5e-0003K2-MM
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 03:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jys3L-0001pe-2m; Fri, 24 Jul 2020 03:23:35 -0400
Received: from mail-eopbgr20133.outbound.protection.outlook.com
 ([40.107.2.133]:52866 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jys3E-0005ys-KJ; Fri, 24 Jul 2020 03:23:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNY10pMD+gJgunYFctF/JW4rcAniyBEhvnBGI27rVGcGjqQyN+mQHhpR4Dq5lSc7d1EeMPA/wVn/Dk4687UyhQ1dvHxe6MiBUNPqRqNfavqT5G9sZis8DSIQSMgE+olx6UfeD4cWmiuZJiEpcCA3sTLWViEr2I7WSUNi7fJqmYTmWSBfxkuYsOjNl7pbnDAHW4jXyXqXZzuuKFos7dPIl3pbaFbCGe26soaRwLmo3g5RcIguEAyQVDInCWQe4tovasEnnkGj/ltxHHigRbBCZpsFxXuVW0gUqhBRrT0cnJpBGtAnXid1hzEDWLZera/cbQBQEY/FZ2BCullSikXSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l9/iLItS5UfXe8g/+OUziJgx44J/jwIMZgsBPSg2s4=;
 b=WZvCd6oLwyrCX/Y0hn+gtUU5FcMIn3x1rwbPhg2Iz6MrjfMGI1WYL8TgYcRzYP5BpGcgzd/knxnOwopdqoR3F7JKFZImNHQgmXkoiPwAeE7qJZrLoBbcEw0vykhjfUqpMREy9JM87WASgJWFF6vl+B7zmNe2KUITYxojFptx7hNcEXlCYXaWuKN8DSsPI7qdAjSv4uogNL+/ukiCBjH/oVuwV5OF1wF3RbCN8lv4GbPS2bUZxBf2b9Tizzo0SdJR8OqWA9z5ojRIiqlHFh93yNQmVNIdNaVYDKYTrNQcgCig1TNgQEGpoMfIf+x57z0hWDAH15ucrJK2Vt2Y27QETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l9/iLItS5UfXe8g/+OUziJgx44J/jwIMZgsBPSg2s4=;
 b=b/GHLZm66mMiB1fRUrRBsY4S0Nbpe0jDWBaqsPgq2PB3vBKYQxeCVa7+0c+QXkAQQNw7F1uIqBByFC2FjgHVo6099Z7EK92SGjeHMh1Ojlsv3E+x+tamn/bkkMSiP5Li2N2IEsRmjsM8lk7y3AKG3buy4zSasLCrLbFDeXpI48U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5445.eurprd08.prod.outlook.com (2603:10a6:20b:10d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 07:23:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 07:23:24 +0000
Subject: Re: [PATCH v2 09/22] migration/block-dirty-bitmap: relax error
 handling in incoming part
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-10-vsementsov@virtuozzo.com>
 <9a2bb54f-108b-a4bd-37e2-8382112c84ee@virtuozzo.com>
 <3f7d5627-7ec6-d287-989c-60d3b96ef5ec@virtuozzo.com>
Message-ID: <6b2b848c-9589-6d99-01e9-0b35cb6ab180@virtuozzo.com>
Date: Fri, 24 Jul 2020 10:23:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <3f7d5627-7ec6-d287-989c-60d3b96ef5ec@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0087.eurprd02.prod.outlook.com
 (2603:10a6:208:154::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.156) by
 AM0PR02CA0087.eurprd02.prod.outlook.com (2603:10a6:208:154::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 07:23:23 +0000
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8901857b-90ed-4cd6-a575-08d82fa2735f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5445F4F38F8DCBAB67A4AF87C1770@AM7PR08MB5445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:295;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlgxQsfeHS0NVV9Hy8iH0A52GqxQiAUaaqTwlfT9cZ5CrAqLOgY59xbJXPvwkXCqHrOEsNZkfAGCG1SBXLHGMmg3nWHnW9oUJwJyEIroJ0ipzqsAKrrwF40qd3BoQyBtIfh23AhahbXN+VkJZ1QLYig2Ic5OCNkTBE3sGCNN0doxTOmRn8IvzpG/tXAmJbr+WVP1bMqTBeeuT1SQ3e0OZzdQoAgqgarrs5hYMhASpjHef4gqNzLlsfNIL+aHvLDg5dbBcUa/s52EycgYQBnQZgkMw0uMPPoHk6qbEbWpVAL0Y25u7J1IReTN7hpsrIoVfSesXleyYBKK6zfg1YFtRf0+MJF8vZkiUba464spLebKveLptRi5oHy+BJqWjaMvVh1EjNKznduB9uOYoxbHRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(39840400004)(366004)(376002)(396003)(66556008)(66946007)(8936002)(2616005)(8676002)(31696002)(956004)(4326008)(5660300002)(86362001)(66476007)(36756003)(26005)(83380400001)(478600001)(52116002)(2906002)(54906003)(6486002)(16576012)(31686004)(186003)(53546011)(16526019)(316002)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gliJHppujYsqO6ADCeu390RMYRdcBquk1FMYdAySb5b7MR5W3D5V3ZvvaPM1R+JVDJrjRNdU6gkTqpsLrqeNDDmr+lmmKkfp7wdM3h3YnklFEHUmjp70MQI28lTx2el9To8MQdi8xN5wDMq2HZucKBwUEkPQ1j+6j5Q7Ty0TQBKukwRxcUORtRpqwugUNIpsO6ixQH/i5tizbcfHj7+O2+r/AUAY3JeHmysAI9Guz+Vi+iCB2qElP/N0BvXCdTtp8a/l9RuZIS3wBKWTz6Ag9hjTNFEoRNmozBVF0be5//5NDRb9kZ8M7u6Ee3P5C/mp7Vnt0WztrXPIETnSg5PqmO1VznP/6j2FrutwDCOoG2jCcO3AgQO+ZhNNSr7OzTCL3T7JQjT/BDtEo0wa6xnA09hLG1bX34nHuaOYjZ4zUXMUM+5EA1udL+TPypvdbsO59AOLrJh4PLOb28EzT4oSG9IzeWVRb+H71gkVwSgAXFOmn0kI90ZMEbhtPJ8c6hvx
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8901857b-90ed-4cd6-a575-08d82fa2735f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:23:24.1811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2nLxaVMPT4m/FBV0kciX1vrMq0AaSG9X0cHKPoePKjtuzItUm/pM8Kw9RpBiIS7iR1NFiztviZxdQx8a7VXqpXZqysgV5ia8rQgJ6DGXM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5445
Received-SPF: pass client-ip=40.107.2.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 03:23:25
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, quintela@redhat.com,
 dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.02.2020 18:34, Vladimir Sementsov-Ogievskiy wrote:
> 18.02.2020 21:54, Andrey Shinkevich wrote:
>>
>>
>> On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
>>> Bitmaps data is not critical, and we should not fail the migration (or
>>> use postcopy recovering) because of dirty-bitmaps migration failure.
>>> Instead we should just lose unfinished bitmaps.
>>>
>>> Still we have to report io stream violation errors, as they affect the
>>> whole migration stream.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   migration/block-dirty-bitmap.c | 148 +++++++++++++++++++++++++--------
>>>   1 file changed, 113 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>>> index 1329db8d7d..aea5326804 100644
>>> --- a/migration/block-dirty-bitmap.c
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -145,6 +145,15 @@ typedef struct DBMLoadState {
>>>       bool before_vm_start_handled; /* set in dirty_bitmap_mig_before_vm_start */
>>> +    /*
>>> +     * cancelled
>>> +     * Incoming migration is cancelled for some reason. That means that we
>>> +     * still should read our chunks from migration stream, to not affect other
>>> +     * migration objects (like RAM), but just ignore them and do not touch any
>>> +     * bitmaps or nodes.
>>> +     */
>>> +    bool cancelled;
>>> +
>>>       GSList *bitmaps;
>>>       QemuMutex lock; /* protect bitmaps */
>>>   } DBMLoadState;
>>> @@ -545,13 +554,47 @@ void dirty_bitmap_mig_before_vm_start(void)
>>>       qemu_mutex_unlock(&s->lock);
>>>   }
>>> +static void cancel_incoming_locked(DBMLoadState *s)
>>> +{
>>> +    GSList *item;
>>> +
>>> +    if (s->cancelled) {
>>> +        return;
>>> +    }
>>> +
>>> +    s->cancelled = true;
>>> +    s->bs = NULL;
>>> +    s->bitmap = NULL;
>>> +
>>> +    /* Drop all unfinished bitmaps */
>>> +    for (item = s->bitmaps; item; item = g_slist_next(item)) {
>>> +        LoadBitmapState *b = item->data;
>>> +
>>> +        /*
>>> +         * Bitmap must be unfinished, as finished bitmaps should already be
>>> +         * removed from the list.
>>> +         */
>>> +        assert(!s->before_vm_start_handled || !b->migrated);
>>> +        if (bdrv_dirty_bitmap_has_successor(b->bitmap)) {
>>> +            bdrv_reclaim_dirty_bitmap(b->bitmap, &error_abort);
>>> +        }
>>> +        bdrv_release_dirty_bitmap(b->bitmap);
>>> +    }
>>> +
>>> +    g_slist_free_full(s->bitmaps, g_free);
>>> +    s->bitmaps = NULL;
>>> +}
>>> +
>>>   static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>>>   {
>>>       GSList *item;
>>>       trace_dirty_bitmap_load_complete();
>>> -    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
>>> -    qemu_mutex_lock(&s->lock);
>>
>> Why is it safe to remove the critical section?
> 
> It's not removed, it becomes wider in this patch.
> 
>>
>>> +    if (s->cancelled) {
>>> +        return;
>>> +    }
>>> +
>>> +    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
>>>       if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
>>>           bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
>>> @@ -569,8 +612,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>>>               break;
>>>           }
>>>       }
>>> -
>>> -    qemu_mutex_unlock(&s->lock);
>>>   }
>>>   static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>>> @@ -582,15 +623,32 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>>>       if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>>>           trace_dirty_bitmap_load_bits_zeroes();
>>> -        bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte, nr_bytes,
>>> -                                             false);
>>> +        if (!s->cancelled) {
>>> +            bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte,
>>> +                                                 nr_bytes, false);
>>> +        }
>>>       } else {
>>>           size_t ret;
>>>           uint8_t *buf;
>>>           uint64_t buf_size = qemu_get_be64(f);
>>> -        uint64_t needed_size =
>>> -            bdrv_dirty_bitmap_serialization_size(s->bitmap,
>>> -                                                 first_byte, nr_bytes);
>>> +        uint64_t needed_size;
>>> +
>>> +        buf = g_malloc(buf_size);
>>> +        ret = qemu_get_buffer(f, buf, buf_size);
>>> +        if (ret != buf_size) {
>>> +            error_report("Failed to read bitmap bits");
>>> +            g_free(buf);
>>> +            return -EIO;
>>> +        }
>>> +
>>> +        if (s->cancelled) {
>>> +            g_free(buf);
>>> +            return 0;
>>> +        }
>>> +
>>> +        needed_size = bdrv_dirty_bitmap_serialization_size(s->bitmap,
>>> +                                                           first_byte,
>>> +                                                           nr_bytes);
>>>           if (needed_size > buf_size ||
>>>               buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
>>> @@ -599,15 +657,8 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>>>               error_report("Migrated bitmap granularity doesn't "
>>>                            "match the destination bitmap '%s' granularity",
>>>                            bdrv_dirty_bitmap_name(s->bitmap));
>>> -            return -EINVAL;
>>> -        }
>>> -
>>> -        buf = g_malloc(buf_size);
>>> -        ret = qemu_get_buffer(f, buf, buf_size);
>>> -        if (ret != buf_size) {
>>> -            error_report("Failed to read bitmap bits");
>>> -            g_free(buf);
>>> -            return -EIO;
>>> +            cancel_incoming_locked(s);
>>
>>                 /* Continue the VM migration as bitmaps data are not critical */
> 
> Hmm yes it what this patch does.. But I don't think we should add comment to each call of cancel_..()
> 
>>
>>> +            return 0;
>>>           }
>>>           bdrv_dirty_bitmap_deserialize_part(s->bitmap, buf, first_byte, nr_bytes,
>>> @@ -632,14 +683,16 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
>>>               error_report("Unable to read node name string");
>>>               return -EINVAL;
>>>           }
>>> -        s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
>>> -        if (!s->bs) {
>>> -            error_report_err(local_err);
>>> -            return -EINVAL;
>>> +        if (!s->cancelled) {
>>> +            s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
>>> +            if (!s->bs) {
>>> +                error_report_err(local_err);
>>
>> The error message may be supplemented with a report about the canceled bitmap migration. Also down there at cancel_incoming_locked(s).

If we want to log something about cancelling, I think it should be done in cancel_incoming_locked(). I'll keep this patch as is.

>>
>>> +                cancel_incoming_locked(s);
>>> +            }
>>>           }
>>> -    } else if (!s->bs && !nothing) {
>>> +    } else if (!s->bs && !nothing && !s->cancelled) {
>>>           error_report("Error: block device name is not set");
>>> -        return -EINVAL;
>>> +        cancel_incoming_locked(s);
>>>       }
>>>       if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
>>> @@ -647,24 +700,38 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
>>>               error_report("Unable to read bitmap name string");
>>>               return -EINVAL;
>>>           }
>>> -        s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
>>> -
>>> -        /* bitmap may be NULL here, it wouldn't be an error if it is the
>>> -         * first occurrence of the bitmap */
>>> -        if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
>>> -            error_report("Error: unknown dirty bitmap "
>>> -                         "'%s' for block device '%s'",
>>> -                         s->bitmap_name, s->node_name);
>>> -            return -EINVAL;
>>> +        if (!s->cancelled) {
>>> +            s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
>>> +
>>> +            /*
>>> +             * bitmap may be NULL here, it wouldn't be an error if it is the
>>> +             * first occurrence of the bitmap
>>> +             */
>>> +            if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
>>> +                error_report("Error: unknown dirty bitmap "
>>> +                             "'%s' for block device '%s'",
>>> +                             s->bitmap_name, s->node_name);
>>> +                cancel_incoming_locked(s);
>>> +            }
>>>           }
>>> -    } else if (!s->bitmap && !nothing) {
>>> +    } else if (!s->bitmap && !nothing && !s->cancelled) {
>>>           error_report("Error: block device name is not set");
>>> -        return -EINVAL;
>>> +        cancel_incoming_locked(s);
>>>       }
>>>       return 0;
>>>   }
>>> +/*
>>> + * dirty_bitmap_load
>>> + *
>>> + * Load sequence of dirty bitmap chunks. Return error only on fatal io stream
>>> + * violations. On other errors just cancel bitmaps incoming migration and return
>>> + * 0.
>>> + *
>>> + * Note, than when incoming bitmap migration is canceled, we still must read all
>> "than (that)" may be omitted
>>
>>> + * our chunks (and just ignore them), to not affect other migration objects.
>>> + */
>>>   static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>>>   {
>>>       DBMLoadState *s = &((DBMState *)opaque)->load;
>>> @@ -673,12 +740,19 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>>>       trace_dirty_bitmap_load_enter();
>>>       if (version_id != 1) {
>>> +        qemu_mutex_lock(&s->lock);
>>> +        cancel_incoming_locked(s);
>>> +        qemu_mutex_unlock(&s->lock);
>>>           return -EINVAL;
>>>       }
>>>       do {
>>> +        qemu_mutex_lock(&s->lock);
>>> +
>>>           ret = dirty_bitmap_load_header(f, s);
>>>           if (ret < 0) {
>>> +            cancel_incoming_locked(s);
>>> +            qemu_mutex_unlock(&s->lock);
>>>               return ret;
>>>           }
>>> @@ -695,8 +769,12 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>>>           }
>>>           if (ret) {
>>> +            cancel_incoming_locked(s);
>>> +            qemu_mutex_unlock(&s->lock);
>>>               return ret;
>>>           }
>>> +
>>> +        qemu_mutex_unlock(&s->lock);
>>>       } while (!(s->flags & DIRTY_BITMAP_MIG_FLAG_EOS));
>>>       trace_dirty_bitmap_load_success();
>>>
>>
>> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> 
> 


-- 
Best regards,
Vladimir

