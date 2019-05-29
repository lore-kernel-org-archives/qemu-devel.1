Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8A5C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 18:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E2F24032
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 18:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E2F24032
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58838 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW31s-0000Qw-Bu
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 14:10:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hW310-0008VK-QR
	for qemu-devel@nongnu.org; Wed, 29 May 2019 14:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hW30x-0005mD-93
	for qemu-devel@nongnu.org; Wed, 29 May 2019 14:09:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hW30p-0005c8-Si; Wed, 29 May 2019 14:09:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB124307D91E;
	Wed, 29 May 2019 18:08:59 +0000 (UTC)
Received: from [10.18.17.164] (dhcp-17-164.bos.redhat.com [10.18.17.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E672B5D9D6;
	Wed, 29 May 2019 18:08:58 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190523154733.54944-1-vsementsov@virtuozzo.com>
	<20190523154733.54944-4-vsementsov@virtuozzo.com>
	<c63d4dae-6fa5-a47f-9aca-791f36963262@redhat.com>
	<a00207af-97f3-fd24-90a5-2860473ace17@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
	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
Message-ID: <50d29692-51df-3880-58d0-e151deae7471@redhat.com>
Date: Wed, 29 May 2019 14:08:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a00207af-97f3-fd24-90a5-2860473ace17@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 29 May 2019 18:09:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] block/qcow2-bitmap: rewrite bitmap
 reopening logic
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max has picked this thread up for block discussion, so I'm going to
stick to slightly more bitmap related discussion here; we'll resume
block discussion in the other tail of this thread.

On 5/29/19 5:10 AM, Vladimir Sementsov-Ogievskiy wrote:
> 29.05.2019 2:24, John Snow wrote:
>>
>>
>> On 5/23/19 11:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Current logic
>>> =============
>>>
>>> Reopen rw -> ro:
>>>
>>> Store bitmaps and release BdrvDirtyBitmap's.
>>>
>>> Reopen ro -> rw:
>>>
>>> Load bitmap list
>>> Skip bitmaps which for which we don't have BdrvDirtyBitmap [this is
>>>     the worst thing]
>>
>> ...ah.
>>
>>> A kind of fail with error message if we see not readonly bitmap
>>>
>>> This leads to at least the following bug:
>>>
>>> Assume we have bitmap0.
>>
>> Presumably a normal, persistent bitmap.
>>
>>> Create external snapshot
>>>    bitmap0 is stored and therefore removed
>>
>> Written out to the backing file and removed from memory, because we've
>> reopened rw->ro; this is because of the migration "safety" clause where
>> we simply drop these bitmaps.
>>
>> ...Ah, and then we don't actually open them readonly again; that entire
>> stanza in reopen_ro never fires off at all because the bitmaps are
>> already gone.
>>
>>> Commit snapshot
>>>    now we have no bitmaps
>>
>> When we reopen the base as rw as you note, we skipped bitmaps for which
>> we had no in-memory bitmap for -- because the readonly logic was really
>> expecting to have these in-memory.
>>
>> I should probably say that for the sake of migration correctness, the
>> way we flush things to disk and remove it from memory on write is really
>> bothersome to keep correct. The migration logic is so particular that it
>> keeps causing issues elsewhere, of which this is another symptom.
>>
>>> Do some writes from guest (*)
>>>    they are not marked in bitmap
>>
>> Yikes, right.
>>
>>> Shutdown
>>> Start
>>>    bitmap0 is loaded as valid, but it is actually broken! It misses
>>>    writes (*)
>>
>> Yikes; because it was consistent on flush and we skipped it on load,
>> it's not marked as IN_USE and we are free to load it up again.
>>
>>> Incremental backup
>>>    it will be inconsistent
>>>
>>
>> Good writeup, thank you.
>>
>>> New logic
>>> =========
>>>
>>> Reopen rw -> ro:
>>>
>>> Store bitmaps and don't remove them from RAM, only mark them readonly
>>> (the latter is already done, but didn't work properly because of
>>> removing in storing function)
>>>
>>
>> Yes! I like this change.
>>
>>> Reopen to rw (don't filter case with reopen rw -> rw, it is supported
>>> now in qcow2_reopen_bitmaps_rw)
>>>
>>
>> OK, so we allow rw --> rw without trying to be fussy about it. That
>> seems fine to me.
>>
>>> Load bitmap list
>>>
>>> Carefully consider all possible combinations of bitmaps in RAM and in
>>> the image, try to fix corruptions, print corresponding error messages.
>>>
>>> Also, call qcow2_reopen_bitmaps_rw after the whole reopen queue
>>> commited, as otherwise we can't write to the qcow2 file child on reopen
>>> ro -> rw.
>>>
>>
>> I take it this is the change that moved the invocation logic into
>> bdrv_reopen_multiple instead of bdrv_reopen_commit; also notably we no
>> longer check the transition edge which is much simpler.
>>
>> oh, I see why you're doing it there now...
>>
>>> Also, add corresponding test-cases to 255.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   block/qcow2.h              |   5 +-
>>>   include/block/block_int.h  |   2 +-
>>>   block.c                    |  29 ++----
>>>   block/qcow2-bitmap.c       | 197 ++++++++++++++++++++++++++-----------
>>>   block/qcow2.c              |   2 +-
>>>   tests/qemu-iotests/255     |   2 +
>>>   tests/qemu-iotests/255.out |  35 +++++++
>>>   7 files changed, 193 insertions(+), 79 deletions(-)
>>>
>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>> index 8d92ef1fee..5928306e62 100644
>>> --- a/block/qcow2.h
>>> +++ b/block/qcow2.h
>>> @@ -725,9 +725,10 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
>>>                                                   Error **errp);
>>>   int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
>>>                                    Error **errp);
>>> -int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
>>> +void qcow2_reopen_bitmaps_rw(BlockDriverState *bs);
>>>   int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
>>> -void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>>> +void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>> +                                          bool release_stored, Error **errp);
>>>   int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
>>>   bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>>>                                         const char *name,
>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>> index 1eebc7c8f3..9a694f3da0 100644
>>> --- a/include/block/block_int.h
>>> +++ b/include/block/block_int.h
>>> @@ -536,7 +536,7 @@ struct BlockDriver {
>>>        * as rw. This handler should realize it. It also should unset readonly
>>>        * field of BlockDirtyBitmap's in case of success.
>>>        */
>>> -    int (*bdrv_reopen_bitmaps_rw)(BlockDriverState *bs, Error **errp);
>>> +    void (*bdrv_reopen_bitmaps_rw)(BlockDriverState *bs);
>>>       bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs,
>>>                                               const char *name,
>>>                                               uint32_t granularity,
>>> diff --git a/block.c b/block.c
>>> index cb11537029..db1ec0c673 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -3334,6 +3334,16 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
>>>           bdrv_reopen_commit(&bs_entry->state);
>>>       }
>>>   
>>> +    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
>>> +        BlockDriverState *bs = bs_entry->state.bs;
>>> +
>>> +        if (!bdrv_is_writable(bs) || !bs->drv->bdrv_reopen_bitmaps_rw) {
>>> +            continue;
>>> +        }
>>> +
>>> +        bs->drv->bdrv_reopen_bitmaps_rw(bs);
>>> +    }
>>> +
>>
>> OK, so this has been moved up into the main body of the loop because we
>> cannot trust it to run in bdrv_reopen_commit because of the order in
>> which the nodes are reopened might leave us unable to write to our child
>> nodes to issue the IN_USE flag.
>>
>> I have kept out of these discussions in the past; is there a general
>> solution that allows us to sort the block DAG leaf-up to avoid this
>> scenario?
> 
> In Virtuozzo I have a hacking patch, which reverse order of reopen queue
> before commit for reopen-rw. But here is simpler solution.
> 
> I can't find the discussion now, but if I remember correctly Kevin didn't like
> an idea of reverting the queue. He supposed some generic way, in which during
> we have access to both states of reopening node..
> 
>>
>> Anyway, since the block graph organization isn't my problem I will say
>> that I think this is fine by me; but I'm not the one to impress here.
>>
>>>       ret = 0;
>>>   cleanup_perm:
>>>       QSIMPLEQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
>>> @@ -3770,16 +3780,12 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
>>>       BlockDriver *drv;
>>>       BlockDriverState *bs;
>>>       BdrvChild *child;
>>> -    bool old_can_write, new_can_write;
>>>   
>>>       assert(reopen_state != NULL);
>>>       bs = reopen_state->bs;
>>>       drv = bs->drv;
>>>       assert(drv != NULL);
>>>   
>>> -    old_can_write =
>>> -        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
>>> -
>>>       /* If there are any driver level actions to take */
>>>       if (drv->bdrv_reopen_commit) {
>>>           drv->bdrv_reopen_commit(reopen_state);
>>> @@ -3823,21 +3829,6 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
>>>       }
>>>   
>>>       bdrv_refresh_limits(bs, NULL);
>>> -
>>> -    new_can_write =
>>> -        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
>>> -    if (!old_can_write && new_can_write && drv->bdrv_reopen_bitmaps_rw) {
>>> -        Error *local_err = NULL;
>>> -        if (drv->bdrv_reopen_bitmaps_rw(bs, &local_err) < 0) {
>>> -            /* This is not fatal, bitmaps just left read-only, so all following
>>> -             * writes will fail. User can remove read-only bitmaps to unblock
>>> -             * writes.
>>> -             */
>>> -            error_reportf_err(local_err,
>>> -                              "%s: Failed to make dirty bitmaps writable: ",
>>> -                              bdrv_get_node_name(bs));
>>> -        }
>>> -    }
>>>   }
>>>   
>>
>> Certainly the new code is simpler here, which is good.
>>
>>>   /*
>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>> index 2b84bfa007..4e565db11f 100644
>>> --- a/block/qcow2-bitmap.c
>>> +++ b/block/qcow2-bitmap.c
>>> @@ -28,6 +28,7 @@
>>>   #include "qemu/osdep.h"
>>>   #include "qapi/error.h"
>>>   #include "qemu/cutils.h"
>>> +#include "qemu/error-report.h"
>>>   
>>>   #include "block/block_int.h"
>>>   #include "qcow2.h"
>>> @@ -951,6 +952,12 @@ static void set_readonly_helper(gpointer bitmap, gpointer value)
>>>       bdrv_dirty_bitmap_set_readonly(bitmap, (bool)value);
>>>   }
>>>   
>>> +/* for g_slist_foreach for GSList of const char* elements */
>>> +static void error_report_helper(gpointer message, gpointer _unused)
>>> +{
>>> +    error_report("%s", (const char *)message);
>>> +}
>>> +
>>>   /* qcow2_load_dirty_bitmaps()
>>>    * Return value is a hint for caller: true means that the Qcow2 header was
>>>    * updated. (false doesn't mean that the header should be updated by the
>>> @@ -1103,76 +1110,150 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
>>>       return list;
>>>   }
>>>   
>>> -int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
>>> -                                 Error **errp)
>>> +/*
>>> + * qcow2_reopen_bitmaps_rw
>>> + *
>>> + * The function is called in bdrv_reopen_multiple after all calls to
>>> + * bdrv_reopen_commit, when final bs is writable. It is done so, as we need
>>> + * write access to child bs, and with current reopening architecture, when
>>> + * reopen ro -> rw it is possible only after all reopen commits.
>>> + *
>>> + * So, we can't fail here. On the other hand, we may face different kinds of
>>> + * corruptions and/or just can't write IN_USE flags to the image due to EIO.
>>> + *
>>> + * Try to handle as many cases as we can.
>>
>> Hm, I think you're right, but it does make me really uncomfortable that
>> we lose the ability to report errors back up the stack. I guess we
>> already always did ignore them, so this is no worse, but I don't like
>> the idea of adding new error_report_err calls if we can help it.
>>
>> I guess we can't help it, though.
> 
> It's possible to return error and print it in bdrv_reopen_multiple instead, like
> it was pre-patch, but I have two reasons against:
> 
> 1. I wanted to stress that interface is for calling from commit code, and cannot fail.
> 
> 2. I can't implement here clean logic like SUCCESS or (ERROR, nothing changed), as some
> errors, are critical, some are not, we are trying to fix corruptions, so here is difficult
> failure-handling logic, so, it may be simpler to keep it all here, not reporting an error,
> which can't be handled in commit code anyway.
> 
>>
>>> + */
>>> +void qcow2_reopen_bitmaps_rw(BlockDriverState *bs)
>>>   {
>>>       BDRVQcow2State *s = bs->opaque;
>>>       Qcow2BitmapList *bm_list;
>>>       Qcow2Bitmap *bm;
>>> -    GSList *ro_dirty_bitmaps = NULL;
>>> +    GSList *ro_dirty_bitmaps = NULL, *corrupted_bitmaps = NULL;
>>> +    Error *local_err = NULL;
>>>       int ret = 0;
>>> -
>>> -    if (header_updated != NULL) {
>>> -        *header_updated = false;
>>> -    }
>>> +    bool need_update = false, updated_ok = false;
>>>   
>>>       if (s->nb_bitmaps == 0) {
>>>           /* No bitmaps - nothing to do */
>>> -        return 0;
>>> -    }
>>> -
>>> -    if (!can_write(bs)) {
>>> -        error_setg(errp, "Can't write to the image on reopening bitmaps rw");
>>> -        return -EINVAL;
>>> +        return;
>>>       }
>>>   
>>>       bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>>> -                               s->bitmap_directory_size, errp);
>>> +                               s->bitmap_directory_size, &local_err);
>>>       if (bm_list == NULL) {
>>> -        return -EINVAL;
>>> +        error_reportf_err(local_err, "Failed to reopen bitmaps rw: "
>>> +                          "cannot load bitmap list: ");
>>> +        return;
>>>       }
>>>   
>>>       QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>>>           BdrvDirtyBitmap *bitmap = bdrv_find_dirty_bitmap(bs, bm->name);
>>> -        if (bitmap == NULL) {
>>> -            continue;
>>> -        }
>>> +        const char *corruption = NULL;
>>>   
>>> -        if (!bdrv_dirty_bitmap_readonly(bitmap)) {
>>> -            error_setg(errp, "Bitmap %s was loaded prior to rw-reopen, but was "
>>> -                       "not marked as readonly. This is a bug, something went "
>>> -                       "wrong. All of the bitmaps may be corrupted", bm->name);
>>> -            ret = -EINVAL;
>>> -            goto out;
>>> -        }
>>> +        if (bm->flags & BME_FLAG_IN_USE) {
>>> +            if (bitmap == NULL) {
>>> +                /*
>>> +                 * It's an unexpected inconsistent bitmap,
>>> +                 * it is safe to ignore it.
>>> +                 */
>>> +                continue;
>>> +            }
>>
>> This is supposed to be a reopen but we've found a bitmap we didn't load,
>> and it's IN_USE. Should we make any attempt to load it as an
>> inconsistent bitmap so the user can know about it?
> 
> I thought about this and decided to keep it simpler.. But on the other hand,
> why not? So, I don't have strict opinion on this, I can add this logic.
> 

It just seemed to me that if you're going through such efforts to check
consistency in reopen, we might as well do this one too. Maybe it can
make the loop simpler if you can share the code with the (!bitmap) case
below?

In lieu of any proper error pathways, alerting the user to abnormalities
via the API (in the form of +inconsistent bitmaps) seems like one of the
most helpful things we can do.

>>
>> If we're here, it means we DID reopen the image rw, so we ought to have
>> exclusive ownership of this file; the IN_USE flag here signals an
>> inconsistency, no?
>>
>>>   
>>> -        bm->flags |= BME_FLAG_IN_USE;
>>> -        ro_dirty_bitmaps = g_slist_append(ro_dirty_bitmaps, bitmap);
>>> +            /*
>>> +             * It's either an inconsistent bitmap, or we are reopening rw -> rw,
>>> +             * or we just didn't save bitmap for some buggy reason. Still, no
>>> +             * reason to consider in-RAM bitmap inconsistent, than, mark it rw.
>>> +             */
>>
>> I don't understand lines 2-3 of this comment. As far as I can tell:
>>
>> - We might be seeing a legitimately corrupt bitmap. It's fine to mark it
>> as rw, because we can't write to it anyway. (It was marked inconsistent
>> on open.)
>> - We might be seeing a bitmap that's already properly rw. this call is
>> effectively a no-op.
>>
>> Is that right? If that's true, I'd just simply say:
>>
>> "This is either an inconsistent bitmap or we are reopening rw -> rw. It
>> is safe to mark it as not read only in either case."
>>
>> What's the "or we just didn't save bitmap for some buggy reason" you are
>> alluding to?
> 
> I mean, for example, on previous reopen to ro, we failed to store the bitmap and
> therefore failed to drop IN_USE flag. So, we see it now.
> 

Oh, okay. Understood.

>>
>>> +            bdrv_dirty_bitmap_set_readonly(bitmap, false);
>>> +        } else {
>>> +            /*
>>> +             * In-image bitmap not marked IN_USE
>>> +             *
>>> +             * The only valid case is
>>> +             *     bitmap && bdrv_dirty_bitmap_readonly(bitmap) &&
>>> +             *        !bdrv_dirty_bitmap_inconsistent(bitmap))
>>> +             *
>>> +             * which means reopen ro -> rw of consistent bitmap.
>>> +             *
>>> +             * Other cases a different kinds of corruptions:
>>> +             */
>>> +            if (!bitmap) {
>>> +                corruption =
>>> +                    "Corruption: unexpected valid bitmap '%s' is found in the "
>>> +                    "image '%s' on reopen rw. Will try to set IN_USE flag.";
>>> +
>>
>> In this case, we find a valid bitmap we expected to have a readonly copy
>> of in memory, but didn't. We attempt to load it.
>>
>>> +                bitmap = load_bitmap(bs, bm, NULL);
>>> +                if (!bitmap) {
>>> +                    bitmap = bdrv_create_dirty_bitmap(
>>> +                            bs, bdrv_get_default_bitmap_granularity(bs),
>>> +                            bm->name, NULL);
>>> +                }
>>> +
>>> +                if (bitmap) {
>>> +                    bdrv_dirty_bitmap_set_persistence(bitmap, true);
>>> +                    bdrv_dirty_bitmap_set_readonly(bitmap, true);
>>> +                    bdrv_dirty_bitmap_set_inconsistent(bitmap);
>>
>> And we mark it as inconsistent because we're not sure how we missed it
>> earlier. OK.
>>
>>> +                }
>>> +            } else if (!bdrv_dirty_bitmap_readonly(bitmap)) {
>>> +                corruption =
>>> +                    "Corruption: bitmap '%s' is not marked IN_USE in the "
>>> +                    "image '%s' and not marked readonly in RAM. Will try to "
>>> +                    "set IN_USE flag.";
>>> +
>>
>> And in this case, we find the bitmap but it's not marked readonly for
>> some reason.
>>
>>> +                bdrv_dirty_bitmap_set_readonly(bitmap, true);
>>
>> Why set it readonly again?
> 
> It is because inconsistance is not synced to the image. "readonly" exactly
> means, that for some reasons we did not marked bitmap IN_USE in the image and
> therefore must not write to it.
> 

That's one way of looking at what readonly means. Another was: "The
image this bitmap is attached to is read only, and any writes to this
bitmap are a logistical error."

> So, yes, here occurs new thing: readonly-inconsistent bitmap. It blocks guest
> writes until we sync it somehow to the image or remove. And we are going to sync
> it at the end of this function.
> 

Right, we've not really used readonly in this way before. It makes sense
to a point, but it's a bit of a semantic overload -- the disk is
actually RW but the bitmap is RO; the problem that I have with this is
that we guard RO bitmaps with assertions and not errors, so it seems
feasible to me that the reopen-rw will succeed, a guest will write, and
then we'll abort because of these "readonly corrupt" bitmaps.

In other words, we don't *really* support the idea of having readonly
bitmaps on readwrite nodes.

I think given that this is an error state to begin with that simply
marking the bitmap as inconsistent in memory (and trying to write the
IN_USE flag to its header) is sufficient, it will skip any new writes
and prohibit its use for any backup operations.

>>
>>> +                bdrv_dirty_bitmap_set_inconsistent(bitmap);
>>
>> And just in case, we mark it inconsistent. (It's my impression that any
>> such write would have failed earlier, but maybe not.)
> 
> hm, which write?
> 

You know, I was thinking we'd have been in RO mode before this, but I
forgot that's not true anymore. Disregard this comment.

>>
>>> +            } else if (bdrv_dirty_bitmap_inconsistent(bitmap)) {
>>> +                corruption =
>>> +                    "Corruption: bitmap '%s' is inconsistent but is not marked "
>>> +                    "IN_USE in the image. Will try to set IN_USE flag.";
>>> +
>>> +                bdrv_dirty_bitmap_set_readonly(bitmap, true);
>>
>> This one is weirder. We have an inconsistent bitmap but it's not IN_USE;
>> so we set it readonly again? Why?
> 
> Same here, as "inconsitance" is not synced to the image. We'll drop readonly flag if
> we sync it successfully.
> 
>>
>>> +            }
>>> +
>>> +            if (bitmap) {
>>> +                ro_dirty_bitmaps = g_slist_append(ro_dirty_bitmaps, bitmap);
>>
>> Oh, all those bitmaps we just set readonly we're going to mark as not
>> readonly again?
> 
> yes, if successfully sync IN_USE flags
> 
>>
>>> +            }
>>> +            bm->flags |= BME_FLAG_IN_USE;
>>> +            need_update = true;
>>> +            if (corruption) {
>>> +                error_report(corruption, bm->name, bs->filename);
>>> +                corrupted_bitmaps = g_slist_append(corrupted_bitmaps, bm->name);
>>> +            }
>>> +        }
>>>       }
>>>   
>>> -    if (ro_dirty_bitmaps != NULL) {
>>> +    if (need_update) {
>>> +        if (!can_write(bs->file->bs)) {
>>
>> I genuinely don't know: is it legitimate to check your child's write
>> permission in this way? will we always have bs->file->bs?
> 
> Hmm.. but we are going to write to it very soon, I think it should exist.
> 

Apparently Max is adding a bdrv_storage_bs() helper for this exact
thing, in an upcoming patch. I just get nervous when I see double
indirections.

>>
>>> +            error_report("Failed to reopen bitmaps rw: cannot write to "
>>> +                         "the protocol file");
>>> +            goto handle_corrupted;
>>> +        }
>>> +
>>>           /* in_use flags must be updated */
>>>           ret = update_ext_header_and_dir_in_place(bs, bm_list);
>>>           if (ret < 0) {
>>> -            error_setg_errno(errp, -ret, "Can't update bitmap directory");
>>> -            goto out;
>>> -        }
>>> -        if (header_updated != NULL) {
>>> -            *header_updated = true;
>>> +            error_report("Cannot update bitmap directory: %s", strerror(-ret));
>>> +            goto handle_corrupted;
>>>           }
>>> +        updated_ok = true;
>>>           g_slist_foreach(ro_dirty_bitmaps, set_readonly_helper, false);
>>>       }
>>
>> And then here at the end the bulk of the work: we re-write the header if
>> necessary back out to disk to mark everything as IN_USE.
>>
>> It seems strange that you are trying to maintain the invariant that we
>> won't set readonly to false if we fail, because this function "cannot fail."
> 
> Yes, if we fail, bitmaps remains readonly, and it is preexisting behavior. User
> can try reopen again or try to remove bitmaps.. It shouldn't happen often in
> practice, but we must do everything we can to prevent appearing in the image
> invalid bitmap not marked IN_USE, as it will lead to inconsistent backup.
> 
> Hmm, of-course, best thing is to do it all in commit-prepare, where we can fail
> legally. But then we'll need write-access to child already in prepare, when now
> we don't have it even in commit, I don't know how to achieve it.
> 

I've talked to Max and I think he has some opinions about how we might
be able to do this, but it might rely on some of his pending series.

>>
>>>   
>>> -out:
>>> +handle_corrupted:
>>> +    if (corrupted_bitmaps) {
>>> +        if (updated_ok) {
>>> +            error_report("Corrupted bitmaps in '%s' successfully marked "
>>> +                         "IN_USE", bs->filename);
>>> +        } else {
>>> +            error_report("Failed to mark IN_USE the following corrupted "
>>> +                         "bitmaps in '%s', DO NOT USE THEM:", bs->filename);
>>> +            g_slist_foreach(corrupted_bitmaps, error_report_helper, NULL);
>>> +        }
>>> +    }
>>> +
>>>       g_slist_free(ro_dirty_bitmaps);
>>> +    g_slist_free(corrupted_bitmaps);
>>>       bitmap_list_free(bm_list);
>>> -
>>> -    return ret;
>>> -}
>>> -
>>
>> I just don't know; for how much error checking this function is doing
>> now, it seems wrong to be behind an interface that cannot fail and will
>> actually do different things to the bitmaps depending on what it sees
>> with no return code to help the caller understand the cases.
>>
>> It even has a bit at the end where it tries to print in uppercase to
>> manually scare a user into taking action, which says to me that there is
>> a deeper problem we need to be able to address without intervention from
>> the user.
>>
>> That said, the patch does seem correct otherwise; and it does fix a
>> nasty bug which lets us use bitmaps with snapshots. I want this in for
>> 4.1 if I can help it. I will talk to Kevin and Max and see if there's
>> some opinion here.
> 
> Yes. In short, it was bad, it still bad, but at least one bug is fixed :)
> 

Hahaha! Very good summary. Let's discuss the block implications with
Max, Berto and Kevin. Until then, do you think it's OK to split out the
release_bitmaps boolean as its own patch to "lessen" the severity of the
bug?

It looks like the reopen infrastructural changes might be a bit harder.

>>
>> Thanks!
>>
>>> -int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
>>> -{
>>> -    return qcow2_reopen_bitmaps_rw_hint(bs, NULL, errp);
>>>   }
>>>   
>>>   /* Checks to see if it's safe to resize bitmaps */
>>> @@ -1446,7 +1527,8 @@ fail:
>>>       bitmap_list_free(bm_list);
>>>   }
>>>   
>>> -void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>> +void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>> +                                          bool release_stored, Error **errp)
>>>   {
>>>       BdrvDirtyBitmap *bitmap;
>>>       BDRVQcow2State *s = bs->opaque;
>>> @@ -1559,20 +1641,23 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>>           g_free(tb);
>>>       }
>>>   
>>> -    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>>> -        /* For safety, we remove bitmap after storing.
>>> -         * We may be here in two cases:
>>> -         * 1. bdrv_close. It's ok to drop bitmap.
>>> -         * 2. inactivation. It means migration without 'dirty-bitmaps'
>>> -         *    capability, so bitmaps are not marked with
>>> -         *    BdrvDirtyBitmap.migration flags. It's not bad to drop them too,
>>> -         *    and reload on invalidation.
>>> -         */
>>> -        if (bm->dirty_bitmap == NULL) {
>>> -            continue;
>>> -        }
>>> +    if (release_stored) {
>>> +        QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>>> +            /*
>>> +             * For safety, we remove bitmap after storing.
>>> +             * We may be here in two cases:
>>> +             * 1. bdrv_close. It's ok to drop bitmap.
>>> +             * 2. inactivation. It means migration without 'dirty-bitmaps'
>>> +             *    capability, so bitmaps are not marked with
>>> +             *    BdrvDirtyBitmap.migration flags. It's not bad to drop them
>>> +             *    too, and reload on invalidation.
>>> +             */
>>
>> While we're here, I might touch up the comment.
>>
>> For safety, the BdrvDirtyBitmap can be dropped after storing.
>> We may be here in two cases, both via qcow2_inactivate:
>> 1. bdrv_close: It's correct to remove bitmaps on close.
>> 2. migration: This implies we are migrating without the
>>     'dirty-bitmaps' capability, because bitmap->migration was unset.
> 
> I'm not sure in my understanding of English "because", but bitmap->migration
> is a consequence, not a reason of not enabling this capability.
> 

The fun thing about English is that there are definitely no rules and it
never makes sense. The other fun thing about English is that I am fairly
certain I don't know how to speak it.

In this case, I mean to say: "bitmap->migration is unset. since it is
unset, we can deduce that we are not running in a context where we are
doing a dirty-bitmaps migration."

Or, "migration: The implication (that we are migration without the
'dirty-bitmaps' capability) follows from {bitmap->migration being unset}."

I mean to say that the implication/deduction is what follows from the
boolean being unset. Of course, the boolean being unset is itself the
consequence from the fact that we are not in such a migration.

Clear as mud?

Let's say this:

"2. migration: We know we are migrating without the 'dirty-bitmaps'
capability, since bitmap->migration was found false above."

Hopefully this clarifies that migration was "set false" means not when
it was assigned false, but was "found to be set to false".

Sorry about my language.

(Well, not *my* language, but the one I happen to speak.)

>>     If needed, these bitmaps will be reloaded on invalidation.
>>
>> I just wanted to clarify these points:
>>
>> - The new boolean obviously means we don't /always/ drop them
>> - qcow2_inactivate is the only caller that instructs us to drop them
>> - both cases in the comment are through qcow2_inactivate.
> 
> Agree.
> 
>>
>> you can take any or none of my wording suggestions as you feel is
>> appropriate.
> 
> Thank you! And for reviewing this complicated patch! I know, two words "Also"
> in commit message are never followed by good clean design, and this is not an
> exclusion.
> 

Thanks for tackling it. It's always nice to see clear examples of
limitations of the current infrastructure.

(Well, not "nice" but certainly "helpful".)

>>
>>> +            if (bm->dirty_bitmap == NULL) {
>>> +                continue;
>>> +            }
>>>   
>>> -        bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
>>> +            bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
>>> +        }
>>>       }
>>>   
>>>   success:
>>> @@ -1600,7 +1685,7 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
>>>       BdrvDirtyBitmap *bitmap;
>>>       Error *local_err = NULL;
>>>   
>>> -    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
>>> +    qcow2_store_persistent_dirty_bitmaps(bs, false, &local_err);
>>>       if (local_err != NULL) {
>>>           error_propagate(errp, local_err);
>>>           return -EINVAL;
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index d39882785d..f0a8479874 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -2273,7 +2273,7 @@ static int qcow2_inactivate(BlockDriverState *bs)
>>>       int ret, result = 0;
>>>       Error *local_err = NULL;
>>>   
>>> -    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
>>> +    qcow2_store_persistent_dirty_bitmaps(bs, true, &local_err);
>>>       if (local_err != NULL) {
>>>           result = -EINVAL;
>>>           error_reportf_err(local_err, "Lost persistent bitmaps during "
>>> diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
>>> index 36712689d3..e8b0c9d4bb 100755
>>> --- a/tests/qemu-iotests/255
>>> +++ b/tests/qemu-iotests/255
>>> @@ -79,3 +79,5 @@ def test(persistent, restart):
>>>   
>>>   
>>>   test(persistent=False, restart=False)
>>> +test(persistent=True, restart=False)
>>> +test(persistent=True, restart=True)
>>> diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
>>> index 2bffb486d2..46e2e3ad4e 100644
>>> --- a/tests/qemu-iotests/255.out
>>> +++ b/tests/qemu-iotests/255.out
>>> @@ -15,3 +15,38 @@ check, that no bitmaps in snapshot: not found
>>>   {"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>>>   check merged bitmap: name=bitmap0 dirty-clusters=2
>>>   check updated bitmap: name=bitmap0 dirty-clusters=3
>>> +
>>> +Testcase persistent without restart
>>> +
>>> +{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "drive0", "persistent": true}}
>>> +{"return": {}}
>>> +initial bitmap: name=bitmap0 dirty-clusters=1
>>> +{"execute": "blockdev-snapshot-sync", "arguments": {"device": "drive0", "format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
>>> +{"return": {}}
>>> +check, that no bitmaps in snapshot: not found
>>> +{"execute": "block-commit", "arguments": {"device": "drive0", "top": "TEST_DIR/PID-top"}}
>>> +{"return": {}}
>>> +{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>>> +{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
>>> +{"return": {}}
>>> +{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>>> +check merged bitmap: name=bitmap0 dirty-clusters=2
>>> +check updated bitmap: name=bitmap0 dirty-clusters=3
>>> +
>>> +Testcase persistent with restart
>>> +
>>> +{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "drive0", "persistent": true}}
>>> +{"return": {}}
>>> +initial bitmap: name=bitmap0 dirty-clusters=1
>>> +{"execute": "blockdev-snapshot-sync", "arguments": {"device": "drive0", "format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
>>> +{"return": {}}
>>> +check, that no bitmaps in snapshot: not found
>>> +... Restart ...
>>> +{"execute": "block-commit", "arguments": {"device": "drive0", "top": "TEST_DIR/PID-top"}}
>>> +{"return": {}}
>>> +{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>>> +{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
>>> +{"return": {}}
>>> +{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>>> +check merged bitmap: name=bitmap0 dirty-clusters=2
>>> +check updated bitmap: name=bitmap0 dirty-clusters=3
>>>
>>
> 
> 

