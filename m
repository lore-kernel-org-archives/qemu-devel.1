Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38784C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E4120880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E4120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnNDN-0002lU-Ck
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 09:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45171)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hnNCz-00018k-Cz
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hnNCt-00034T-T5
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:09:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24753)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hnNCr-00031a-9W; Tue, 16 Jul 2019 09:09:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 93E7330842AC;
 Tue, 16 Jul 2019 13:09:20 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 537A95E7A5;
 Tue, 16 Jul 2019 13:09:19 +0000 (UTC)
Message-ID: <ee3e3418c73f31db4ce4fbcd36abd83ab43d2555.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 16 Jul 2019 16:09:18 +0300
In-Reply-To: <20190712173600.14554-6-mreitz@redhat.com>
References: <20190712173600.14554-1-mreitz@redhat.com>
 <20190712173600.14554-6-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 16 Jul 2019 13:09:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/7] file-posix: Drop
 hdev_co_create_opts()
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
>  block/file-posix.c | 67 ----------------------------------------------
>  1 file changed, 67 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 4479cc7ab4..65bd6d3333 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -3325,67 +3325,6 @@ static coroutine_fn int hdev_co_pwrite_zeroes(BlockDriverState *bs,
>      return raw_do_pwrite_zeroes(bs, offset, bytes, flags, true);
>  }
>  
> -static int coroutine_fn hdev_co_create_opts(const char *filename, QemuOpts *opts,
> -                                            Error **errp)
> -{
> -    int fd;
> -    int ret = 0;
> -    struct stat stat_buf;
> -    int64_t total_size = 0;
> -    bool has_prefix;
> -
> -    /* This function is used by both protocol block drivers and therefore either
> -     * of these prefixes may be given.
> -     * The return value has to be stored somewhere, otherwise this is an error
> -     * due to -Werror=unused-value. */
> -    has_prefix =
> -        strstart(filename, "host_device:", &filename) ||
> -        strstart(filename, "host_cdrom:" , &filename);
> -
> -    (void)has_prefix;
> -
> -    ret = raw_normalize_devicepath(&filename, errp);
> -    if (ret < 0) {
> -        return ret;
> -    }
> -
> -    /* Read out options */
> -    total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> -                          BDRV_SECTOR_SIZE);
> -
> -    fd = qemu_open(filename, O_WRONLY | O_BINARY);
> -    if (fd < 0) {
> -        ret = -errno;
> -        error_setg_errno(errp, -ret, "Could not open device");
> -        return ret;
> -    }
> -
> -    if (fstat(fd, &stat_buf) < 0) {
> -        ret = -errno;
> -        error_setg_errno(errp, -ret, "Could not stat device");
> -    } else if (!S_ISBLK(stat_buf.st_mode) && !S_ISCHR(stat_buf.st_mode)) {
> -        error_setg(errp,
> -                   "The given file is neither a block nor a character device");
> -        ret = -ENODEV;
> -    } else if (lseek(fd, 0, SEEK_END) < total_size) {
> -        error_setg(errp, "Device is too small");
> -        ret = -ENOSPC;
> -    }
> -
> -    if (!ret && total_size) {
> -        uint8_t buf[BDRV_SECTOR_SIZE] = { 0 };
> -        int64_t zero_size = MIN(BDRV_SECTOR_SIZE, total_size);
> -        if (lseek(fd, 0, SEEK_SET) == -1) {
> -            ret = -errno;
> -        } else {
> -            ret = qemu_write_full(fd, buf, zero_size);
> -            ret = ret == zero_size ? 0 : -errno;
> -        }
> -    }
> -    qemu_close(fd);
> -    return ret;
> -}
> -
>  static BlockDriver bdrv_host_device = {
>      .format_name        = "host_device",
>      .protocol_name        = "host_device",
> @@ -3398,8 +3337,6 @@ static BlockDriver bdrv_host_device = {
>      .bdrv_reopen_prepare = raw_reopen_prepare,
>      .bdrv_reopen_commit  = raw_reopen_commit,
>      .bdrv_reopen_abort   = raw_reopen_abort,
> -    .bdrv_co_create_opts = hdev_co_create_opts,
> -    .create_opts         = &raw_create_opts,
>      .mutable_opts        = mutable_opts,
>      .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
>      .bdrv_co_pwrite_zeroes = hdev_co_pwrite_zeroes,
> @@ -3525,8 +3462,6 @@ static BlockDriver bdrv_host_cdrom = {
>      .bdrv_reopen_prepare = raw_reopen_prepare,
>      .bdrv_reopen_commit  = raw_reopen_commit,
>      .bdrv_reopen_abort   = raw_reopen_abort,
> -    .bdrv_co_create_opts = hdev_co_create_opts,
> -    .create_opts         = &raw_create_opts,
>      .mutable_opts        = mutable_opts,
>      .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
>  
> @@ -3659,8 +3594,6 @@ static BlockDriver bdrv_host_cdrom = {
>      .bdrv_reopen_prepare = raw_reopen_prepare,
>      .bdrv_reopen_commit  = raw_reopen_commit,
>      .bdrv_reopen_abort   = raw_reopen_abort,
> -    .bdrv_co_create_opts = hdev_co_create_opts,
> -    .create_opts        = &raw_create_opts,
>      .mutable_opts       = mutable_opts,
>  
>      .bdrv_co_preadv         = raw_co_preadv,


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky


