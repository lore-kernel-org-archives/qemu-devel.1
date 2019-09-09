Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9824BC433EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 10:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F18A21479
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 10:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F18A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7HDo-000571-F3
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 06:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7HCn-0004bi-MB
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7HCl-0004Dz-VF
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:47:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7HCh-00048Z-RV; Mon, 09 Sep 2019 06:47:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED4291918652;
 Mon,  9 Sep 2019 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 841AA5D6A7;
 Mon,  9 Sep 2019 10:47:25 +0000 (UTC)
Date: Mon, 9 Sep 2019 12:47:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190909104724.GD17606@localhost.localdomain>
References: <135df452-397a-30bb-7518-2184fa5971aa@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <135df452-397a-30bb-7518-2184fa5971aa@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Mon, 09 Sep 2019 10:47:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] qcow2 lock
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
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.09.2019 um 12:13 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Hi!
> 
> I have a (may be stupid) question: what is BDRVQcow2State.lock for and when should it be locked?
> 
> 
> I faced SIGSEGV here:
> 
> #0  qcow2_process_discards (bs=bs@entry=0x564b93bc8000, ret=ret@entry=0) at block/qcow2-refcount.c:737
> #1  0x0000564b90e9f15f in qcow2_cluster_discard (bs=bs@entry=0x564b93bc8000, offset=0, offset@entry=3062890496, bytes=bytes@entry=134217728, type=type@entry=QCOW2_DISCARD_REQUEST,
>      full_discard=full_discard@entry=false) at block/qcow2-cluster.c:1853
> #2  0x0000564b90e8f720 in qcow2_co_pdiscard (bs=0x564b93bc8000, offset=3062890496, bytes=134217728) at block/qcow2.c:3749
> #3  0x0000564b90ec565d in bdrv_co_pdiscard (bs=0x564b93bc8000, offset=3062890496, bytes=134217728) at block/io.c:2939
> #4  0x0000564b90eb5c04 in blk_aio_pdiscard_entry (opaque=0x564b94f968c0) at block/block-backend.c:1527
> #5  0x0000564b90f681ea in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at util/coroutine-ucontext.c:116
> 
> SIGSEGV is on QTAILQ_REMOVE in qcow2_process_discards:
> (gdb) list
> 732     {
> 733         BDRVQcow2State *s = bs->opaque;
> 734         Qcow2DiscardRegion *d, *next;
> 735
> 736         QTAILQ_FOREACH_SAFE(d, &s->discards, next, next) {
> 737             QTAILQ_REMOVE(&s->discards, d, next);
> 738
> 739             /* Discard is optional, ignore the return value */
> 740             if (ret >= 0) {
> 741                 bdrv_pdiscard(bs->file->bs, d->offset, d->bytes);
> 
> 
> (you see bs->file->bs, yes it's old code based on 2.12, but still,
> I need some help on the following)
> 
> and problem is that d is already deleted:
> (gdb) p d->next
> $50 = {tqe_next = 0x564b94b0b140, tqe_prev = 0x0}
> 
> Such problems may occur when there is an interleaving of such
> removing loops with other usage of the queue. And this is possible,
> as we call bdrv_pdiscard inside the loop which may yield.
> 
> go to frame #5, and print co->caller stack:
> 
> #0  0x0000564b90f68180 in qemu_coroutine_switch ()
> #1  0x0000564b90f66c84 in qemu_aio_coroutine_enter ()
> #2  0x0000564b90f50764 in aio_co_enter ()
> #3  0x0000564b90f50ea9 in thread_pool_completion_bh ()
> #4  0x0000564b90f500d1 in aio_bh_poll ()
> #5  0x0000564b90f5360b in aio_poll ()
> #6  0x0000564b90ec59cd in bdrv_pdiscard ()
> #7  0x0000564b90e96a36 in qcow2_process_discards ()
> #8  0x0000564b90e97785 in update_refcount ()
> #9  0x0000564b90e96bdd in qcow2_free_clusters ()
> #10 0x0000564b90ea29c7 in update_ext_header_and_dir ()
> #11 0x0000564b90ea3a14 in qcow2_remove_persistent_dirty_bitmap ()
> #12 0x0000564b90ce7bce in qmp_block_dirty_bitmap_remove ()
> #13 0x0000564b90cf5390 in qmp_marshal_block_dirty_bitmap_remove ()
> #14 0x0000564b90f46080 in qmp_dispatch ()
> #15 0x0000564b90bedc74 in monitor_qmp_dispatch_one ()
> #16 0x0000564b90bee04a in monitor_qmp_bh_dispatcher ()
> #17 0x0000564b90f500d1 in aio_bh_poll ()
> #18 0x0000564b90f53430 in aio_dispatch ()
> #19 0x0000564b90f4ffae in aio_ctx_dispatch ()
> #20 0x00007f0a8e3e9049 in g_main_context_dispatch () from /lib64/libglib-2.0.so.0
> #21 0x0000564b90f52727 in main_loop_wait ()
> #22 0x0000564b90ba0c07 in main ()
> 
> 
> And this (at least partly) confirms my guess.
> 
> So, my actual question is, what should be fixed here:
> 
> 1. yielding in qcow2_process_discards, like this:
> 
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -732,9 +732,13 @@ void qcow2_process_discards(BlockDriverState *bs, int ret)
>   {
>       BDRVQcow2State *s = bs->opaque;
>       Qcow2DiscardRegion *d, *next;
> +    QTAILQ_HEAD (, Qcow2DiscardRegion) discards;
> 
> -    QTAILQ_FOREACH_SAFE(d, &s->discards, next, next) {
> -        QTAILQ_REMOVE(&s->discards, d, next);
> +    discards = s->discards;
> +    QTAILQ_INIT(&s->discards);
> +
> +    QTAILQ_FOREACH_SAFE(d, &discards, next, next) {
> +        QTAILQ_REMOVE(&discards, d, next);
> 
>           /* Discard is optional, ignore the return value */
>           if (ret >= 0) {

I think this is not enough.

If you don't hold s->lock here, concurrent requests could (re-)allocate
the clusters to be discarded and then you'd discard new data instead of
the old one.

So I believe that qcow2_process_discards() must always be called before
the image can be unlocked after adding something to the discard queue.

> or
> 2. calling qcow2_remove_persistent_dirty_bitmap without taking lock, like this:
> 
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1359,8 +1359,8 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>   {
>       int ret;
>       BDRVQcow2State *s = bs->opaque;
> -    Qcow2Bitmap *bm;
> -    Qcow2BitmapList *bm_list;
> +    Qcow2Bitmap *bm = NULL;
> +    Qcow2BitmapList *bm_list = NULL;
> 
>       if (s->nb_bitmaps == 0) {
>           /* Absence of the bitmap is not an error: see explanation above
> @@ -1368,15 +1368,17 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>           return;
>       }
> 
> +    qemu_co_mutex_lock(&s->lock);
> +
>       bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>                                  s->bitmap_directory_size, errp);
>       if (bm_list == NULL) {
> -        return;
> +        goto out;
>       }
> 
>       bm = find_bitmap_by_name(bm_list, name);
>       if (bm == NULL) {
> -        goto fail;
> +        goto out;
>       }
> 
>       QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
> @@ -1384,12 +1386,14 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>       ret = update_ext_header_and_dir(bs, bm_list);
>       if (ret < 0) {
>           error_setg_errno(errp, -ret, "Failed to update bitmap extension");
> -        goto fail;
> +        goto out;
>       }
> 
>       free_bitmap_clusters(bs, &bm->table);
> 
> -fail:
> +out:
> +    qemu_co_mutex_unlock(&s->lock);
> +
>       bitmap_free(bm);
>       bitmap_list_free(bm_list);
>   }
> 
> And in this case, I'm afraid that locking is missed in some other
> bitmap related qcow2 codes :(

Then we should probably add locking to all of it. I don't know enough
about the bitmap code to tell whether it's the full solution, and maybe
not all of the code actually needs it, but the bitmap management
functions are a slow path anyway, so just locking s->lock is certainly a
good idea.

> or
> 3. Just backport from upstream John's fix 0a6c86d024c52b, which
> acquires aio context around bdrv_remove_persistent_dirty_bitmap call?
> Is it enough, or we still need locking inside qcow2?

It protects only again other threads accessing the same data structures
concurrently, but when you yield, both the AioContext lock is dropped
and the same thread can start a concurrent operation, so this is not
enough.

Kevin

