Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA827C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CACF20449
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CACF20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnNBz-0005En-Nw
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 09:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44711)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hnNBp-0004kR-D0
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hnNBo-00023Z-99
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:08:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hnNBl-00020k-LI; Tue, 16 Jul 2019 09:08:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B05063D37;
 Tue, 16 Jul 2019 13:08:12 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B8581C0;
 Tue, 16 Jul 2019 13:08:11 +0000 (UTC)
Message-ID: <1c6b2f9b06bb2d1cfd666a44e913de7d4598b2e0.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 16 Jul 2019 16:08:10 +0300
In-Reply-To: <20190712173600.14554-7-mreitz@redhat.com>
References: <20190712173600.14554-1-mreitz@redhat.com>
 <20190712173600.14554-7-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 16 Jul 2019 13:08:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 6/7] iscsi: Drop
 iscsi_co_create_opts()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-07-12 at 19:35 +0200, Max Reitz wrote:
> The generic fallback implementation effectively does the same.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/iscsi.c | 56 ---------------------------------------------------
>  1 file changed, 56 deletions(-)
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 267f160bf6..0e5729d335 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -2157,58 +2157,6 @@ static int coroutine_fn iscsi_co_truncate(BlockDriverState *bs, int64_t offset,
>      return 0;
>  }
>  
> -static int coroutine_fn iscsi_co_create_opts(const char *filename, QemuOpts *opts,
> -                                             Error **errp)
> -{
> -    int ret = 0;
> -    int64_t total_size = 0;
> -    BlockDriverState *bs;
> -    IscsiLun *iscsilun = NULL;
> -    QDict *bs_options;
> -    Error *local_err = NULL;
> -
> -    bs = bdrv_new();
> -
> -    /* Read out options */
> -    total_size = DIV_ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> -                              BDRV_SECTOR_SIZE);
> -    bs->opaque = g_new0(struct IscsiLun, 1);
> -    iscsilun = bs->opaque;
> -
> -    bs_options = qdict_new();
> -    iscsi_parse_filename(filename, bs_options, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        ret = -EINVAL;
> -    } else {
> -        ret = iscsi_open(bs, bs_options, 0, NULL);
> -    }
> -    qobject_unref(bs_options);
> -
> -    if (ret != 0) {
> -        goto out;
> -    }
> -    iscsi_detach_aio_context(bs);
> -    if (iscsilun->type != TYPE_DISK) {
> -        ret = -ENODEV;
> -        goto out;
> -    }
> -    if (bs->total_sectors < total_size) {
> -        ret = -ENOSPC;
> -        goto out;
> -    }
> -
> -    ret = 0;
> -out:
> -    if (iscsilun->iscsi != NULL) {
> -        iscsi_destroy_context(iscsilun->iscsi);
> -    }
> -    g_free(bs->opaque);
> -    bs->opaque = NULL;
> -    bdrv_unref(bs);
> -    return ret;
> -}
> -
>  static int iscsi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>  {
>      IscsiLun *iscsilun = bs->opaque;
> @@ -2479,8 +2427,6 @@ static BlockDriver bdrv_iscsi = {
>      .bdrv_parse_filename    = iscsi_parse_filename,
>      .bdrv_file_open         = iscsi_open,
>      .bdrv_close             = iscsi_close,
> -    .bdrv_co_create_opts    = iscsi_co_create_opts,
> -    .create_opts            = &iscsi_create_opts,
>      .bdrv_reopen_prepare    = iscsi_reopen_prepare,
>      .bdrv_reopen_commit     = iscsi_reopen_commit,
>      .bdrv_co_invalidate_cache = iscsi_co_invalidate_cache,
> @@ -2518,8 +2464,6 @@ static BlockDriver bdrv_iser = {
>      .bdrv_parse_filename    = iscsi_parse_filename,
>      .bdrv_file_open         = iscsi_open,
>      .bdrv_close             = iscsi_close,
> -    .bdrv_co_create_opts    = iscsi_co_create_opts,
> -    .create_opts            = &iscsi_create_opts,
>      .bdrv_reopen_prepare    = iscsi_reopen_prepare,
>      .bdrv_reopen_commit     = iscsi_reopen_commit,
>      .bdrv_co_invalidate_cache  = iscsi_co_invalidate_cache,


Well, in theory the original code did not zero the first sector, like what the generic code will do now,
but this is OK due to the same reasons the original zeroing code was added.


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky



