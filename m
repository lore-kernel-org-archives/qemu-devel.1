Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE5DC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619202082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619202082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54900 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRlme-0002qP-ND
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:57:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hRlbU-0001Vg-0N
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hRlbS-000647-HD
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hRlbP-0005QA-BK; Fri, 17 May 2019 18:45:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FC14309264C;
	Fri, 17 May 2019 22:45:07 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 32F9D60E3E;
	Fri, 17 May 2019 22:45:05 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190517152111.206494-1-vsementsov@virtuozzo.com>
	<20190517152111.206494-2-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
	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
Message-ID: <e9c48cc9-3208-c111-9669-f6098ec746cd@redhat.com>
Date: Fri, 17 May 2019 18:45:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517152111.206494-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 17 May 2019 22:45:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qapi: support external bitmaps in
 block-dirty-bitmap-merge
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
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, armbru@redhat.com,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/17/19 11:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add new optional parameter making possible to merge bitmaps from
> different nodes. It is needed to maintain external snapshots during
> incremental backup chain history.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json | 22 ++++++++++++++++---
>  block/dirty-bitmap.c |  9 +++++---
>  blockdev.c           | 50 +++++++++++++++++++++++++++++---------------
>  3 files changed, 58 insertions(+), 23 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7ccbfff9d0..dcc935d655 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2003,19 +2003,35 @@
>    'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
>              '*persistent': 'bool', '*autoload': 'bool', '*disabled': 'bool' } }
>  
> +##
> +# @BlockDirtyBitmapMergeSource:
> +#
> +# @local: name of the bitmap, attached to the same node as target bitmap.
> +#
> +# @external: bitmap with specified node
> +#
> +# Since: 4.1
> +##
> +{ 'alternate': 'BlockDirtyBitmapMergeSource',
> +  'data': { 'local': 'str',
> +            'external': 'BlockDirtyBitmap' } }
> +

We might be able to use something more generic to name this type of
thing, but I think such changes are wire compatible, so we can rename it
to be more generic if we decide to use this for something else in the
future, so this is good.

>  ##
>  # @BlockDirtyBitmapMerge:
>  #
> -# @node: name of device/node which the bitmap is tracking
> +# @node: name of device/node which the @target bitmap is tracking
>  #
>  # @target: name of the destination dirty bitmap
>  #
> -# @bitmaps: name(s) of the source dirty bitmap(s)
> +# @bitmaps: name(s) of the source dirty bitmap(s) at @node and/or fully
> +#           specifed BlockDirtyBitmap elements. The latter are supported
> +#           since 4.1.
>  #
>  # Since: 4.0
>  ##
>  { 'struct': 'BlockDirtyBitmapMerge',
> -  'data': { 'node': 'str', 'target': 'str', 'bitmaps': ['str'] } }
> +  'data': { 'node': 'str', 'target': 'str',
> +            'bitmaps': ['BlockDirtyBitmapMergeSource'] } }
>  
>  ##
>  # @block-dirty-bitmap-add:
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 59e6ebb861..49646a30e6 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -816,10 +816,10 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
>  {
>      bool ret;
>  
> -    /* only bitmaps from one bds are supported */
> -    assert(dest->mutex == src->mutex);
> -
>      qemu_mutex_lock(dest->mutex);
> +    if (src->mutex != dest->mutex) {
> +        qemu_mutex_lock(src->mutex);
> +    }
>  
>      if (bdrv_dirty_bitmap_check(dest, BDRV_BITMAP_DEFAULT, errp)) {
>          goto out;
> @@ -845,4 +845,7 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
>  
>  out:
>      qemu_mutex_unlock(dest->mutex);
> +    if (src->mutex != dest->mutex) {
> +        qemu_mutex_unlock(src->mutex);
> +    }
>  }
> diff --git a/blockdev.c b/blockdev.c
> index 79fbac8450..64ccef735b 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2112,11 +2112,10 @@ static void block_dirty_bitmap_disable_abort(BlkActionState *common)
>      }
>  }
>  
> -static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
> -                                                    const char *target,
> -                                                    strList *bitmaps,
> -                                                    HBitmap **backup,
> -                                                    Error **errp);
> +static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(
> +        const char *node, const char *target,
> +        BlockDirtyBitmapMergeSourceList *bitmaps,
> +        HBitmap **backup, Error **errp);
>  
>  static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
>                                               Error **errp)
> @@ -2965,15 +2964,14 @@ void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
>      bdrv_disable_dirty_bitmap(bitmap);
>  }
>  
> -static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
> -                                                    const char *target,
> -                                                    strList *bitmaps,
> -                                                    HBitmap **backup,
> -                                                    Error **errp)
> +static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(
> +        const char *node, const char *target,
> +        BlockDirtyBitmapMergeSourceList *bitmaps,
> +        HBitmap **backup, Error **errp)
>  {
>      BlockDriverState *bs;
>      BdrvDirtyBitmap *dst, *src, *anon;
> -    strList *lst;
> +    BlockDirtyBitmapMergeSourceList *lst;
>      Error *local_err = NULL;
>  
>      dst = block_dirty_bitmap_lookup(node, target, &bs, errp);
> @@ -2988,11 +2986,28 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
>      }
>  
>      for (lst = bitmaps; lst; lst = lst->next) {
> -        src = bdrv_find_dirty_bitmap(bs, lst->value);
> -        if (!src) {
> -            error_setg(errp, "Dirty bitmap '%s' not found", lst->value);
> -            dst = NULL;
> -            goto out;
> +        switch (lst->value->type) {
> +            const char *name, *node;
> +        case QTYPE_QSTRING:
> +            name = lst->value->u.local;
> +            src = bdrv_find_dirty_bitmap(bs, name);
> +            if (!src) {
> +                error_setg(errp, "Dirty bitmap '%s' not found", name);
> +                dst = NULL;
> +                goto out;
> +            }
> +            break;
> +        case QTYPE_QDICT:
> +            node = lst->value->u.external.node;
> +            name = lst->value->u.external.name;
> +            src = block_dirty_bitmap_lookup(node, name, NULL, errp);
> +            if (!src) {
> +                dst = NULL;
> +                goto out;
> +            }
> +            break;
> +        default:
> +            abort();
>          }
>  
>          bdrv_merge_dirty_bitmap(anon, src, NULL, &local_err);
> @@ -3012,7 +3027,8 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
>  }
>  
>  void qmp_block_dirty_bitmap_merge(const char *node, const char *target,
> -                                  strList *bitmaps, Error **errp)
> +                                  BlockDirtyBitmapMergeSourceList *bitmaps,
> +                                  Error **errp)
>  {
>      do_block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
>  }
> 

Reviewed-by: John Snow <jsnow@redhat.com>

