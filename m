Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20355C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6026208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6026208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52532 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKy8-0001Ib-TG
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47319)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hZJQM-0002CQ-K9
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hZJQK-0004pK-9A
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:17:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hZJQB-0004h1-7y; Fri, 07 Jun 2019 14:16:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 750AA30860BD;
 Fri,  7 Jun 2019 18:16:58 +0000 (UTC)
Received: from [10.10.120.179] (ovpn-120-179.rdu2.redhat.com [10.10.120.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B2DE891C;
 Fri,  7 Jun 2019 18:16:55 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190606184159.979-1-jsnow@redhat.com>
 <20190606184159.979-4-jsnow@redhat.com>
 <36d3d30b-08ad-f5a1-ae56-eb2af8866528@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9e930aab-1278-e2e0-1d19-97cd7b792bbb@redhat.com>
Date: Fri, 7 Jun 2019 14:16:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <36d3d30b-08ad-f5a1-ae56-eb2af8866528@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 07 Jun 2019 18:16:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/5] block/dirty-bitmap: rework
 bdrv_remove_persistent_dirty_bitmap
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/7/19 10:41 AM, Vladimir Sementsov-Ogievskiy wrote:
> 06.06.2019 21:41, John Snow wrote:
>> Allow propagating error code information from
>> bdrv_remove_persistent_dirty_bitmap as well.
>>
>> Give it an interface that matches the newly revised
>> bdrv_add_persistent_dirty_bitmap, including removing the persistent flag
>> when the operation succeeds and refusing to operate on bitmaps that are
>> not persistent.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   block/qcow2.h                |  6 +++---
>>   include/block/block_int.h    |  6 +++---
>>   include/block/dirty-bitmap.h |  6 +++---
>>   block/dirty-bitmap.c         | 25 ++++++++++++++++++++-----
>>   block/qcow2-bitmap.c         | 16 +++++++++-------
>>   blockdev.c                   | 15 ++++++---------
>>   6 files changed, 44 insertions(+), 30 deletions(-)
>>
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index 95d723d3c0..ce07f003f7 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -745,9 +745,9 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
>>   int qcow2_add_persistent_dirty_bitmap(BlockDriverState *bs,
>>                                         BdrvDirtyBitmap *bitmap,
>>                                         Error **errp);
>> -void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>> -                                          const char *name,
>> -                                          Error **errp);
>> +int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>> +                                         BdrvDirtyBitmap *bitmap,
>> +                                         Error **errp);
>>   
>>   ssize_t coroutine_fn
>>   qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 93bbb66cd0..59f8cb9c12 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -540,9 +540,9 @@ struct BlockDriver {
>>       int (*bdrv_add_persistent_dirty_bitmap)(BlockDriverState *bs,
>>                                               BdrvDirtyBitmap *bitmap,
>>                                               Error **errp);
>> -    void (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
>> -                                                const char *name,
>> -                                                Error **errp);
>> +    int (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
>> +                                               BdrvDirtyBitmap *bitmap,
>> +                                               Error **errp);
>>   
>>       /**
>>        * Register/unregister a buffer for I/O. For example, when the driver is
>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
>> index c37edbe05f..88a9832ddc 100644
>> --- a/include/block/dirty-bitmap.h
>> +++ b/include/block/dirty-bitmap.h
>> @@ -41,9 +41,9 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
>>   int bdrv_add_persistent_dirty_bitmap(BlockDriverState *bs,
>>                                         BdrvDirtyBitmap *bitmap,
>>                                         Error **errp);
>> -void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>> -                                         const char *name,
>> -                                         Error **errp);
>> +int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>> +                                        BdrvDirtyBitmap *bitmap,
>> +                                        Error **errp);
>>   void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
>>   void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
>>   void bdrv_enable_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap);
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 615f8480b2..4667f9e65a 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -455,15 +455,30 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
>>    * BdrvDirtyBitmap can have .persistent = true but not yet saved and have no
>>    * stored version. For such bitmap bdrv_remove_persistent_dirty_bitmap() should
>>    * not fail.
>> - * This function doesn't release corresponding BdrvDirtyBitmap.
>> + * This function doesn't release the corresponding BdrvDirtyBitmap.
>>    */
>> -void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>> -                                         const char *name,
>> -                                         Error **errp)
>> +int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>> +                                        BdrvDirtyBitmap *bitmap,
>> +                                        Error **errp)
>>   {
>> +    int ret = 0;
>> +
>> +    if (!bdrv_dirty_bitmap_get_persistence(bitmap)) {
>> +        error_setg(errp, "Bitmap '%s' is not persistent, "
>> +                   "so it cannot be removed from node '%s'",
>> +                   bdrv_dirty_bitmap_name(bitmap),
>> +                   bdrv_get_device_or_node_name(bs));
>> +        return -EINVAL;
>> +    }
>> +
>>       if (bs->drv && bs->drv->bdrv_remove_persistent_dirty_bitmap) {
>> -        bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
>> +        ret = bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, bitmap, errp);
>>       }
>> +    if (!ret) {
>> +        bdrv_dirty_bitmap_set_persistence(bitmap, false);
>> +    }
>> +
>> +    return ret;
>>   }
>>   
>>   int bdrv_add_persistent_dirty_bitmap(BlockDriverState *bs,
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index c3a72ca782..930a6c91ff 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -1402,23 +1402,24 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2BitmapList *bm_list,
>>       return NULL;
>>   }
>>   
>> -void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>> -                                          const char *name,
>> -                                          Error **errp)
>> +int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>> +                                         BdrvDirtyBitmap *bitmap,
>> +                                         Error **errp)
>>   {
>> -    int ret;
>> +    int ret = 0;
> 
> dead assignment
> 
>>       BDRVQcow2State *s = bs->opaque;
>>       Qcow2Bitmap *bm;
>>       Qcow2BitmapList *bm_list;
>> +    const char *name = bdrv_dirty_bitmap_name(bitmap);
>>   
>>       if (s->nb_bitmaps == 0) {
>>           /* Absence of the bitmap is not an error: see explanation above
>>            * bdrv_remove_persistent_dirty_bitmap() definition. */
>> -        return;
>> +        return 0;
>>       }
>>   
>> -    if (bitmap_list_load(bs, &bm_list, errp)) {
>> -        return;
>> +    if ((ret = bitmap_list_load(bs, &bm_list, errp))) {
>> +        return ret;
>>       }
>>   
>>       bm = find_bitmap_by_name(bm_list, name);
> if (bm == NULL) {
>     goto fail;
> }
> 
> You don't set ret, as it's considered success. Worth s/fail/out then (preexisting, of course)?
> 

This becomes an error in the next patch, so I'll omit this suggestion
because the problem goes away soon anyway.

>> @@ -1439,6 +1440,7 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>   fail:
>>       bitmap_free(bm);
>>       bitmap_list_free(bm_list);
>> +    return ret;
>>   }
>>   
>>   void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>> diff --git a/blockdev.c b/blockdev.c
>> index 169a8da831..82f02d8e72 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -2875,7 +2875,6 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
>>   {
>>       BlockDriverState *bs;
>>       BdrvDirtyBitmap *bitmap;
>> -    Error *local_err = NULL;
> 
> Oh, that's cool. And it was my mistake to create interfaces provoking endless local_errors..
> 

I was worried these first three patches might look useless, but I'm glad
you like the idea of doing it this way.

>>       AioContext *aio_context = NULL;
>>   
>>       bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
>> @@ -2889,20 +2888,18 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
>>       }
>>   
>>       if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
>> +        int ret;
>> +
>>           aio_context = bdrv_get_aio_context(bs);
> 
> and here, could you define aio_context in this block?
> 

Indeed.

>>           aio_context_acquire(aio_context);
>> -        bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
>> -        if (local_err != NULL) {
>> -            error_propagate(errp, local_err);
>> -            goto out;
>> +        ret = bdrv_remove_persistent_dirty_bitmap(bs, bitmap, errp);
>> +        aio_context_release(aio_context);
>> +        if (ret) {
>> +            return;
>>           }
>>       }
>>   
>>       bdrv_release_dirty_bitmap(bs, bitmap);
>> - out:
>> -    if (aio_context) {
>> -        aio_context_release(aio_context);
>> -    }
>>   }
>>   
>>   /**
>>
> 
> With some my suggestions or without:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 

Will take them, thanks for the review!

