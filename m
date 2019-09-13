Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2832AC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 22:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2DF206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 22:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2DF206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8teT-0000Ku-0t
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 18:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i8tdG-0008Cq-73
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 18:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i8tdE-0000Nm-SS
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 18:01:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1i8td9-0000MU-Uz; Fri, 13 Sep 2019 18:01:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A30330860BD;
 Fri, 13 Sep 2019 22:01:26 +0000 (UTC)
Received: from [10.18.17.38] (dhcp-17-38.bos.redhat.com [10.18.17.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2280D5D9D3;
 Fri, 13 Sep 2019 22:01:22 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190911150054.90936-1-vsementsov@virtuozzo.com>
 <20190911150054.90936-3-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <717dad2d-3a78-e64d-6155-a062cd2b0df1@redhat.com>
Date: Fri, 13 Sep 2019 18:01:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911150054.90936-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 13 Sep 2019 22:01:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block/dirty-bitmap: return int from
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/11/19 11:00 AM, Vladimir Sementsov-Ogievskiy wrote:
> It's more comfortable to not deal with local_err.
> 

I agree.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.h                |  5 ++---
>  include/block/block_int.h    |  6 +++---
>  include/block/dirty-bitmap.h |  5 ++---
>  block/dirty-bitmap.c         |  9 +++++----
>  block/qcow2-bitmap.c         | 20 +++++++++++---------
>  blockdev.c                   |  7 +++----
>  6 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 998bcdaef1..99ee88f802 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -747,9 +747,8 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>                                        const char *name,
>                                        uint32_t granularity,
>                                        Error **errp);
> -void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
> -                                          const char *name,
> -                                          Error **errp);
> +int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
> +                                         Error **errp);
>  
>  ssize_t coroutine_fn
>  qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 0422acdf1c..503ac9e3cd 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -556,9 +556,9 @@ struct BlockDriver {
>                                              const char *name,
>                                              uint32_t granularity,
>                                              Error **errp);
> -    void (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
> -                                                const char *name,
> -                                                Error **errp);
> +    int (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
> +                                               const char *name,
> +                                               Error **errp);
>  
>      /**
>       * Register/unregister a buffer for I/O. For example, when the driver is
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 4b4b731b46..07503b03b5 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -37,9 +37,8 @@ int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitmap, uint32_t flags,
>                              Error **errp);
>  void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap);
>  void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
> -void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
> -                                         const char *name,
> -                                         Error **errp);
> +int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
> +                                        Error **errp);
>  void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
>  void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
>  void bdrv_enable_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap);
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 8f42015db9..a52b83b619 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -455,13 +455,14 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
>   * not fail.
>   * This function doesn't release corresponding BdrvDirtyBitmap.
>   */
> -void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
> -                                         const char *name,
> -                                         Error **errp)
> +int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
> +                                        Error **errp)
>  {
>      if (bs->drv && bs->drv->bdrv_remove_persistent_dirty_bitmap) {
> -        bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
> +        return bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
>      }
> +

But is it a problem if we return an error code without setting errp now?
If this is for the sake of not having to deal with local_err, we should
make sure that a non-zero return means that errp is set. Right?

> +    return -ENOTSUP;
>  }
>  
>  bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index b2487101ed..1aaedb3b55 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1404,11 +1404,10 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2BitmapList *bm_list,
>      return NULL;
>  }
>  
> -void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
> -                                          const char *name,
> -                                          Error **errp)
> +int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
> +                                         Error **errp)
>  {
> -    int ret;
> +    int ret = 0;

I was going to say I'd rather not initialize this, but is this related
to ubsan linting?

>      BDRVQcow2State *s = bs->opaque;
>      Qcow2Bitmap *bm;
>      Qcow2BitmapList *bm_list;
> @@ -1416,18 +1415,19 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>      if (s->nb_bitmaps == 0) {
>          /* Absence of the bitmap is not an error: see explanation above
>           * bdrv_remove_persistent_dirty_bitmap() definition. */
> -        return;
> +        return 0;
>      }
>  
>      bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>                                 s->bitmap_directory_size, errp);
>      if (bm_list == NULL) {
> -        return;
> +        return -EIO;
>      }
>  
>      bm = find_bitmap_by_name(bm_list, name);
>      if (bm == NULL) {
> -        goto fail;
> +        ret = -EINVAL;
> +        goto out;
>      }
>  
>      QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
> @@ -1435,14 +1435,16 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>      ret = update_ext_header_and_dir(bs, bm_list);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "Failed to update bitmap extension");
> -        goto fail;
> +        goto out;
>      }
>  
>      free_bitmap_clusters(bs, &bm->table);
>  
> -fail:
> +out:
>      bitmap_free(bm);
>      bitmap_list_free(bm_list);
> +
> +    return ret;
>  }
>  
>  void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
> diff --git a/blockdev.c b/blockdev.c
> index fbef6845c8..0813adfb2b 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2940,15 +2940,14 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_remove(
>      }
>  
>      if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
> +        int ret;
>          AioContext *aio_context = bdrv_get_aio_context(bs);
> -        Error *local_err = NULL;
>  
>          aio_context_acquire(aio_context);
> -        bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
> +        ret = bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
>          aio_context_release(aio_context);
>  
> -        if (local_err != NULL) {
> -            error_propagate(errp, local_err);
> +        if (ret < 0) {
>              return NULL;
>          }
>      }
> 

