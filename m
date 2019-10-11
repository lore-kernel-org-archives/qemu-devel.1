Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C9FECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43876206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43876206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ0QO-0000Ul-Nc
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iJ0OI-0007oo-R4
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iJ0OG-00031w-OO
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:15:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iJ0O7-0002xE-Pv; Fri, 11 Oct 2019 15:15:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E3D9018CB90E;
 Fri, 11 Oct 2019 19:15:42 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03F3B5D6C8;
 Fri, 11 Oct 2019 19:15:39 +0000 (UTC)
Subject: Re: [RFC v5 067/126] block: introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-68-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b8300515-2541-e8a3-0a81-b09d6c4ede08@redhat.com>
Date: Fri, 11 Oct 2019 14:15:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-68-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 11 Oct 2019 19:15:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Greg Kurz <groug@kaod.org>, armbru@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 11:04 AM, Vladimir Sementsov-Ogievskiy wrote:
> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp == &fatal_err
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
> 
> If we want to check error after errp-function call, we need to
> introduce local_err and than propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>     &error_fatel, this means that we don't break error_abort
>     (we'll abort on error_set, not on error_propagate)
> 

> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

>   17 files changed, 287 insertions(+), 381 deletions(-)

A bit large, but still manageable for manually checking.

> +++ b/block.c

> @@ -1565,6 +1558,7 @@ fail_opts:
>   
>   static QDict *parse_json_filename(const char *filename, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       QObject *options_obj;
>       QDict *options;
>       int ret;

Not shown in the diff, but this one is correct because of the use of 
error_prepend().

It does make me wonder if separating the error_prepend/error_hint vs. 
error_propagate into two separate cleanups (by incrementally amending 
the .cocci script between two series of generated patches) makes the 
overall review easier or harder.  But don't respin the series just 
because of me - wait for feedback from Markus as well on the best path 
forward.


> +++ b/block/backup.c
> @@ -583,6 +583,7 @@ static const BlockJobDriver backup_job_driver = {
>   static int64_t backup_calculate_cluster_size(BlockDriverState *target,
>                                                Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       int ret;
>       BlockDriverInfo bdi;
>   

Here, the diff is correct because of error_append_hint.

> +++ b/block/dirty-bitmap.c
> @@ -237,6 +237,7 @@ static bool bdrv_dirty_bitmap_recording(BdrvDirtyBitmap *bitmap)
>   int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitmap, uint32_t flags,
>                               Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       if ((flags & BDRV_BITMAP_BUSY) && bdrv_dirty_bitmap_busy(bitmap)) {
>           error_setg(errp, "Bitmap '%s' is currently in use by another"
>                      " operation and cannot be used", bitmap->name);

and here

> +++ b/block/qapi.c
> @@ -44,6 +44,7 @@
>   BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>                                           BlockDriverState *bs, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       ImageInfo **p_image_info;
>       BlockDriverState *bs0;
>       BlockDeviceInfo *info;
> @@ -148,10 +149,8 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>       p_image_info = &info->image;
>       info->backing_file_depth = 0;
>       while (1) {
> -        Error *local_err = NULL;
> -        bdrv_query_image_info(bs0, p_image_info, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +        bdrv_query_image_info(bs0, p_image_info, errp);
> +        if (*errp) {
>               qapi_free_BlockDeviceInfo(info);
>               return NULL;
>           }

I'm a bit wary of auto-propagate at the top level, but a local variable 
declared inside a loop - if the loop repeats more than once, we need to 
make sure that no subsequent iteration of the loop gets handed an 
already-set errp from an earlier iteration.  In this case, we're safe 
(the loop exits early due to return), but it's something to look out for 
in other patches.

> +++ b/hw/block/onenand.c

A bit odd to group this with the others.  But not the end of the world.

Reviewed-by: Eric Blake <eblake@redhat.com>

So far, however, I have not tried rerunning the Coccinelle script, or 
checking (perhaps by sed) whether there are missed opportunities in 
these files that Coccinelle missed.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

