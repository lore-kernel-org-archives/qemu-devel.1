Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D3AC468BD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:27:59 +0000 (UTC)
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F561208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F561208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51750 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKWs-0003uw-OQ
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45741)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hZJKd-00071R-IJ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hZJKb-000589-Ky
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:11:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42270)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hZJKR-0004Zc-Vs; Fri, 07 Jun 2019 14:11:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 39CF34E92A;
 Fri,  7 Jun 2019 18:10:52 +0000 (UTC)
Received: from [10.10.120.179] (ovpn-120-179.rdu2.redhat.com [10.10.120.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41F161711D;
 Fri,  7 Jun 2019 18:10:50 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190606184159.979-1-jsnow@redhat.com>
 <20190606184159.979-3-jsnow@redhat.com>
 <70a53585-bdc6-1877-01f5-1b2d1aad8de6@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e5bb6d0b-567f-2c2d-6415-93d79fece228@redhat.com>
Date: Fri, 7 Jun 2019 14:10:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <70a53585-bdc6-1877-01f5-1b2d1aad8de6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 07 Jun 2019 18:10:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/5] block/dirty-bitmap: Refactor
 bdrv_can_store_new_bitmap
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



On 6/7/19 10:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> 06.06.2019 21:41, John Snow wrote:
>> Instead of bdrv_can_store_new_bitmap, rework this as
>> bdrv_add_persistent_dirty_bitmap. This makes a more obvious symmetry
>> with bdrv_remove_persistent_dirty_bitmap. Most importantly, we are free
>> to modify the driver state because we know we ARE adding a bitmap
>> instead of simply being asked if we CAN store one.
>>
>> As part of this symmetry, move this function next to
>> bdrv_remove_persistent_bitmap in block/dirty-bitmap.c.
>>
>> To cement this semantic distinction, use a bitmap object instead of the
>> (name, granularity) pair as this allows us to set persistence as a
>> condition of the "add" succeeding.
>>
>> Notably, the qcow2 implementation still does not actually store the new
>> bitmap at add time, but merely ensures that it will be able to at store
>> time.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   block/qcow2.h                |  5 ++---
>>   include/block/block.h        |  2 --
>>   include/block/block_int.h    |  5 ++---
>>   include/block/dirty-bitmap.h |  3 +++
>>   block.c                      | 22 ---------------------
>>   block/dirty-bitmap.c         | 38 ++++++++++++++++++++++++++++++++++++
>>   block/qcow2-bitmap.c         | 24 ++++++++++++++---------
>>   block/qcow2.c                |  2 +-
>>   blockdev.c                   | 19 +++++++-----------
>>   9 files changed, 68 insertions(+), 52 deletions(-)
>>
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index fc1b0d3c1e..95d723d3c0 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -742,9 +742,8 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
>>   int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
>>   void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>>   int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
>> -bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>> -                                      const char *name,
>> -                                      uint32_t granularity,
>> +int qcow2_add_persistent_dirty_bitmap(BlockDriverState *bs,
>> +                                      BdrvDirtyBitmap *bitmap,
>>                                         Error **errp);
>>   void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>                                             const char *name,
>> diff --git a/include/block/block.h b/include/block/block.h
>> index f9415ed740..6d520f3b59 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -683,8 +683,6 @@ void bdrv_add_child(BlockDriverState *parent, BlockDriverState *child,
>>                       Error **errp);
>>   void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
>>   
>> -bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
>> -                                     uint32_t granularity, Error **errp);
>>   /**
>>    *
>>    * bdrv_register_buf/bdrv_unregister_buf:
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 06df2bda1b..93bbb66cd0 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -537,9 +537,8 @@ struct BlockDriver {
>>        * field of BlockDirtyBitmap's in case of success.
>>        */
>>       int (*bdrv_reopen_bitmaps_rw)(BlockDriverState *bs, Error **errp);
>> -    bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs,
>> -                                            const char *name,
>> -                                            uint32_t granularity,
>> +    int (*bdrv_add_persistent_dirty_bitmap)(BlockDriverState *bs,
>> +                                            BdrvDirtyBitmap *bitmap,
>>                                               Error **errp);
>>       void (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
>>                                                   const char *name,
>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
>> index 8044ace63e..c37edbe05f 100644
>> --- a/include/block/dirty-bitmap.h
>> +++ b/include/block/dirty-bitmap.h
>> @@ -38,6 +38,9 @@ int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitmap, uint32_t flags,
>>                               Error **errp);
>>   void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap);
>>   void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
>> +int bdrv_add_persistent_dirty_bitmap(BlockDriverState *bs,
>> +                                      BdrvDirtyBitmap *bitmap,
>> +                                      Error **errp);
>>   void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>                                            const char *name,
>>                                            Error **errp);
>> diff --git a/block.c b/block.c
>> index e3e77feee0..6aec36b7c9 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -6379,25 +6379,3 @@ void bdrv_del_child(BlockDriverState *parent_bs, BdrvChild *child, Error **errp)
>>   
>>       parent_bs->drv->bdrv_del_child(parent_bs, child, errp);
>>   }
>> -
>> -bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
>> -                                     uint32_t granularity, Error **errp)
>> -{
>> -    BlockDriver *drv = bs->drv;
>> -
>> -    if (!drv) {
>> -        error_setg_errno(errp, ENOMEDIUM,
>> -                         "Can't store persistent bitmaps to %s",
>> -                         bdrv_get_device_or_node_name(bs));
>> -        return false;
>> -    }
>> -
>> -    if (!drv->bdrv_can_store_new_dirty_bitmap) {
>> -        error_setg_errno(errp, ENOTSUP,
>> -                         "Can't store persistent bitmaps to %s",
>> -                         bdrv_get_device_or_node_name(bs));
>> -        return false;
>> -    }
>> -
>> -    return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp);
>> -}
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 49646a30e6..615f8480b2 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -466,6 +466,44 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>       }
>>   }
>>   
>> +int bdrv_add_persistent_dirty_bitmap(BlockDriverState *bs,
>> +                                     BdrvDirtyBitmap *bitmap,
>> +                                     Error **errp)
> 
> strange thing for me: "bitmap" in function name is _not_ the same
> thing as @bitmap argument.. as if it the same,
> function adds "persistent bitmap", but @bitmap is not persistent yet,
> so may be function, don't add persistent bitmap, but marks bitmap persistent?
> 
> 
> Ok, I can think of it like "add persistent dirty bitmap to driver. if succeed, set
> bitmap.persistent flag"
> 

Yeah, I meant "Add bitmap to file", where the persistence is implied
because it's part of the file. The bitmap is indeed not YET persistent,
but becomes so as a condition of this call succeeding.

Do you have a suggestion for a better name? I liked the symmetry with
'remove' so that there was an obvious "add bitmap" and "remove bitmap".

Of course, when you remove, it is indeed persistent, so
"remove_persistent_dirty_bitmap" makes sense there.

> 
>> +{
>> +    BlockDriver *drv = bs->drv;
>> +    int ret;
>> +
>> +    if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
>> +        error_setg(errp, "Bitmap '%s' is already persistent, "
>> +                   "and cannot be re-added to node '%s'",
>> +                   bdrv_dirty_bitmap_name(bitmap),
>> +                   bdrv_get_device_or_node_name(bs));
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!drv) {
>> +        error_setg_errno(errp, ENOMEDIUM,
>> +                         "Can't store persistent bitmaps to %s",
>> +                         bdrv_get_device_or_node_name(bs));
>> +        return -ENOMEDIUM;
>> +    }
>> +
>> +    if (!drv->bdrv_add_persistent_dirty_bitmap) {
>> +        error_setg_errno(errp, ENOTSUP,
>> +                         "Can't store persistent bitmaps to %s",
>> +                         bdrv_get_device_or_node_name(bs));
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    ret = drv->bdrv_add_persistent_dirty_bitmap(bs, bitmap, errp);
>> +    if (ret == 0) {
>> +        bdrv_dirty_bitmap_set_persistence(bitmap, true);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +
>>   void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>>   {
>>       bdrv_dirty_bitmap_lock(bitmap);
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 83aee1a42a..c3a72ca782 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -1607,14 +1607,16 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
>>       return 0;
>>   }
>>   
>> -bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>> -                                      const char *name,
>> -                                      uint32_t granularity,
>> +int qcow2_add_persistent_dirty_bitmap(BlockDriverState *bs,
>> +                                      BdrvDirtyBitmap *bitmap,
>>                                         Error **errp)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>>       bool found;
>>       Qcow2BitmapList *bm_list;
>> +    const char *name = bdrv_dirty_bitmap_name(bitmap);
>> +    uint32_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
>> +    int ret = 0;
> 
> dead assignment
> 

Will take care of.

>>   
>>       if (s->qcow_version < 3) {
>>           /* Without autoclear_features, we would always have to assume
>> @@ -1623,20 +1625,23 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>>            * have to drop all dirty bitmaps (defeating their purpose).
>>            */
>>           error_setg(errp, "Cannot store dirty bitmaps in qcow2 v2 files");
>> +        ret = -ENOTSUP;
>>           goto fail;
>>       }
>>   
>> -    if (check_constraints_on_bitmap(bs, name, granularity, errp) != 0) {
>> +    ret = check_constraints_on_bitmap(bs, name, granularity, errp);
>> +    if (ret) {
> 
> hmm, in other places you prefere
> if ((ret = ...)) {
> syntax
> 

I have to get rid of those anyway, they violate our coding style. I'll
be replacing them all with this full style.

>>           goto fail;
>>       }
>>   
>>       if (s->nb_bitmaps == 0) {
>> -        return true;
>> +        return 0;
>>       }
>>   
>>       if (s->nb_bitmaps >= QCOW2_MAX_BITMAPS) {
>>           error_setg(errp,
>>                      "Maximum number of persistent bitmaps is already reached");
>> +        ret = -EOVERFLOW;
>>           goto fail;
>>       }
>>   
>> @@ -1644,24 +1649,25 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>>           QCOW2_MAX_BITMAP_DIRECTORY_SIZE)
>>       {
>>           error_setg(errp, "Not enough space in the bitmap directory");
>> +        ret = -EOVERFLOW;
>>           goto fail;
>>       }
>>   
>> -    if (bitmap_list_load(bs, &bm_list, errp)) {
>> +    if ((ret = bitmap_list_load(bs, &bm_list, errp))) {
> 
> interesting, now we load all bitmaps, so, may be, we don't need to load list every time,
> but may use bs.dirty_bitmaps to check such things.. But it seems unsafe
> 

Yeah, I would like to cache this list eventually, but I ran into a lot
of hassle with it last time I tried and put it off for now.

I think we should definitely be able to.

And in fact, if we did, we could even add these bitmaps to the bm_list
as soon as _add_ is called and drop the need for the queued counters.

>>           goto fail;
>>       }
>>   
>>       found = find_bitmap_by_name(bm_list, name);
>>       bitmap_list_free(bm_list);
>>       if (found) {
>> +        ret = -EEXIST;
>>           error_setg(errp, "Bitmap with the same name is already stored");
>>           goto fail;
>>       }
>>   
>> -    return true;
>> -
>> +    return 0;
>>   fail:
>>       error_prepend(errp, "Can't make bitmap '%s' persistent in '%s': ",
>>                     name, bdrv_get_device_or_node_name(bs));
> 
> didn't you consider to move this error_prepend to caller and drop all these gotos?
> 

Nope! But I'll do that.

>> -    return false;
>> +    return ret;
>>   }
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 9396d490d5..1c78eba71b 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -5229,7 +5229,7 @@ BlockDriver bdrv_qcow2 = {
>>       .bdrv_attach_aio_context  = qcow2_attach_aio_context,
>>   
>>       .bdrv_reopen_bitmaps_rw = qcow2_reopen_bitmaps_rw,
>> -    .bdrv_can_store_new_dirty_bitmap = qcow2_can_store_new_dirty_bitmap,
>> +    .bdrv_add_persistent_dirty_bitmap = qcow2_add_persistent_dirty_bitmap,
>>       .bdrv_remove_persistent_dirty_bitmap = qcow2_remove_persistent_dirty_bitmap,
>>   };
>>   
>> diff --git a/blockdev.c b/blockdev.c
>> index 3f44b891eb..169a8da831 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -2851,26 +2851,21 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>>           disabled = false;
>>       }
>>   
>> -    if (persistent) {
>> -        aio_context = bdrv_get_aio_context(bs);
>> -        aio_context_acquire(aio_context);
>> -        if (!bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp)) {
>> -            goto out;
>> -        }
>> -    }
>> -
>>       bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
>>       if (bitmap == NULL) {
>> -        goto out;
>> +        return;
>>       }
>>   
>>       if (disabled) {
>>           bdrv_disable_dirty_bitmap(bitmap);
>>       }
>>   
>> -    bdrv_dirty_bitmap_set_persistence(bitmap, persistent);
>> - out:
>> -    if (aio_context) {
>> +    if (persistent) {
> 
> Good thing. I suggest to define aio_context in this block too.
> 

Oh, sure.

>> +        aio_context = bdrv_get_aio_context(bs);
>> +        aio_context_acquire(aio_context);
>> +        if (bdrv_add_persistent_dirty_bitmap(bs, bitmap, errp)) {
>> +            bdrv_release_dirty_bitmap(bs, bitmap);
>> +        }
>>           aio_context_release(aio_context);
>>       }
>>   }
>>
> 
> With some my suggestions or without:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 

I will respin anyway, so I will take your suggestions.

--js

