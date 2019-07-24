Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C6EC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 16:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB0821841
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 16:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB0821841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqJuA-0004gj-NT
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 12:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59128)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hqJtw-0003zn-5u
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hqJtu-00011M-Ov
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:14:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hqJtr-0000xD-RS; Wed, 24 Jul 2019 12:13:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 941AC3084246;
 Wed, 24 Jul 2019 16:13:54 +0000 (UTC)
Received: from [10.18.17.145] (dhcp-17-145.bos.redhat.com [10.18.17.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 795176061E;
 Wed, 24 Jul 2019 16:13:50 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190708220502.12977-1-jsnow@redhat.com>
 <20190708220502.12977-3-jsnow@redhat.com>
 <47b79140-e9ee-d469-fa60-76044671f80d@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c57c723c-f923-9ea0-bffb-bebb370c3261@redhat.com>
Date: Wed, 24 Jul 2019 12:13:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <47b79140-e9ee-d469-fa60-76044671f80d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 24 Jul 2019 16:13:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/3] qapi: implement
 block-dirty-bitmap-remove transaction action
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
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/24/19 9:58 AM, Vladimir Sementsov-Ogievskiy wrote:
> 09.07.2019 1:05, John Snow wrote:
>> It is used to do transactional movement of the bitmap (which is
>> possible in conjunction with merge command). Transactional bitmap
>> movement is needed in scenarios with external snapshot, when we don't
>> want to leave copy of the bitmap in the base image.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   block.c                        |  2 +-
>>   block/dirty-bitmap.c           | 15 +++----
>>   blockdev.c                     | 79 +++++++++++++++++++++++++++++++---
>>   include/block/dirty-bitmap.h   |  2 +-
>>   migration/block-dirty-bitmap.c |  2 +-
>>   qapi/transaction.json          |  2 +
>>   6 files changed, 85 insertions(+), 17 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index c139540f2b..5195d4b910 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -5316,7 +5316,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
>>       for (bm = bdrv_dirty_bitmap_next(bs, NULL); bm;
>>            bm = bdrv_dirty_bitmap_next(bs, bm))
>>       {
>> -        bdrv_dirty_bitmap_set_migration(bm, false);
>> +        bdrv_dirty_bitmap_skip_store(bm, false);
>>       }
>>   
>>       ret = refresh_total_sectors(bs, bs->total_sectors);
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 95a9c2a5d8..a308e1f84b 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -48,10 +48,9 @@ struct BdrvDirtyBitmap {
>>       bool inconsistent;          /* bitmap is persistent, but inconsistent.
>>                                      It cannot be used at all in any way, except
>>                                      a QMP user can remove it. */
>> -    bool migration;             /* Bitmap is selected for migration, it should
>> -                                   not be stored on the next inactivation
>> -                                   (persistent flag doesn't matter until next
>> -                                   invalidation).*/
>> +    bool skip_store;            /* We are either migrating or deleting this
>> +                                 * bitmap; it should not be stored on the next
>> +                                 * inactivation. */
>>       QLIST_ENTRY(BdrvDirtyBitmap) list;
>>   };
>>   
>> @@ -757,16 +756,16 @@ void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap *bitmap)
>>   }
>>   
>>   /* Called with BQL taken. */
>> -void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, bool migration)
>> +void bdrv_dirty_bitmap_skip_store(BdrvDirtyBitmap *bitmap, bool skip)
>>   {
>>       qemu_mutex_lock(bitmap->mutex);
>> -    bitmap->migration = migration;
>> +    bitmap->skip_store = skip;
>>       qemu_mutex_unlock(bitmap->mutex);
>>   }
>>   
>>   bool bdrv_dirty_bitmap_get_persistence(BdrvDirtyBitmap *bitmap)
>>   {
>> -    return bitmap->persistent && !bitmap->migration;
>> +    return bitmap->persistent && !bitmap->skip_store;
>>   }
>>   
>>   bool bdrv_dirty_bitmap_inconsistent(const BdrvDirtyBitmap *bitmap)
>> @@ -778,7 +777,7 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
>>   {
>>       BdrvDirtyBitmap *bm;
>>       QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
>> -        if (bm->persistent && !bm->readonly && !bm->migration) {
>> +        if (bm->persistent && !bm->readonly && !bm->skip_store) {
>>               return true;
>>           }
>>       }
>> diff --git a/blockdev.c b/blockdev.c
>> index 01248252ca..800b3dcb42 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -2134,6 +2134,51 @@ static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
>>                                                   errp);
>>   }
>>   
>> +static BdrvDirtyBitmap *do_block_dirty_bitmap_remove(
>> +        const char *node, const char *name, bool release,
>> +        BlockDriverState **bitmap_bs, Error **errp);
>> +
>> +static void block_dirty_bitmap_remove_prepare(BlkActionState *common,
>> +                                              Error **errp)
>> +{
>> +    BlockDirtyBitmap *action;
>> +    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
>> +                                             common, common);
>> +
>> +    if (action_check_completion_mode(common, errp) < 0) {
>> +        return;
>> +    }
>> +
>> +    action = common->action->u.block_dirty_bitmap_remove.data;
>> +
>> +    state->bitmap = do_block_dirty_bitmap_remove(action->node, action->name,
>> +                                                 false, &state->bs, errp);
>> +    if (state->bitmap) {
>> +        bdrv_dirty_bitmap_skip_store(state->bitmap, true);
>> +        bdrv_dirty_bitmap_set_busy(state->bitmap, true);
>> +    }
>> +}
>> +
>> +static void block_dirty_bitmap_remove_abort(BlkActionState *common)
>> +{
>> +    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
>> +                                             common, common);
>> +
>> +    if (state->bitmap) {
> 
> Hmm, interesting, I thought, abort should not be called, if prepare failed, so the
> following may be done unconditionally?
> 

I don't think so:

qmp_transaction:
	...
        state->ops->prepare(state, &local_err);
        if (local_err) {
            error_propagate(errp, local_err);
	    goto delete_and_fail;
	}
	...
delete_and_fail:
    ...
    QTAILQ_FOREACH_REVERSE(state, &snap_bdrv_states, entry) {
        if (state->ops->abort) {
            state->ops->abort(state);
        }
    }

>> +        bdrv_dirty_bitmap_skip_store(state->bitmap, false);
>> +        bdrv_dirty_bitmap_set_busy(state->bitmap, false);
>> +    }
>> +}
>> +
> 
> [..]
> 
> OK, I agree, good idea to reuse BUSY and migration field here and avoid new API.
> Now release-prepare is less "release", but I don't see any real problems with it.
> Maybe, we need something to be noted in docs.
> 
> Hmm, as we are not in a hurry now, we may wait for Nikolay to check this on his
> scenarios.
> 

OK, you have time. These patches are all sitting in my bitmaps branch
and I haven't sent the PR for them yet.

--js

