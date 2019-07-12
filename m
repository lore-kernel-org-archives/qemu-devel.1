Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4150BC742B2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D967208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D967208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlsQF-0004L9-7R
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 06:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52779)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hlsQ5-0003we-4I
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hlsQ3-0002ee-1b
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:04:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hlsQ0-0002al-MF; Fri, 12 Jul 2019 06:04:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F37CAC049598;
 Fri, 12 Jul 2019 10:04:43 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B423C600CD;
 Fri, 12 Jul 2019 10:04:40 +0000 (UTC)
Date: Fri, 12 Jul 2019 12:04:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190712100439.GD4514@dhcp-200-226.str.redhat.com>
References: <20190711195804.30703-1-mreitz@redhat.com>
 <20190711195804.30703-4-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711195804.30703-4-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 12 Jul 2019 10:04:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 3/5] block: Fall back to fallback truncate
 function
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.07.2019 um 21:58 hat Max Reitz geschrieben:
> file-posix does not need to basically duplicate our fallback truncate
> implementation; and sheepdog can fall back to it for "shrinking" files.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 21 +--------------------
>  block/sheepdog.c   |  2 +-
>  2 files changed, 2 insertions(+), 21 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index ab05b51a66..bcddfc7fbe 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2031,23 +2031,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>          return raw_regular_truncate(bs, s->fd, offset, prealloc, errp);
>      }

The only thing that is left here is a fstat() check to see that we
really have a regular file here. But since this function is for the
'file' driver, we can just assume this and the function can go away
altogether.

In fact, 'file' with block/character devices has been deprecated since
3.0, so we can just remove support for it now and make it more than just
an assumption.

> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 6f402e5d4d..4af4961cb7 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -2301,7 +2301,7 @@ static int coroutine_fn sd_co_truncate(BlockDriverState *bs, int64_t offset,
>      max_vdi_size = (UINT64_C(1) << s->inode.block_size_shift) * MAX_DATA_OBJS;
>      if (offset < old_size) {
>          error_setg(errp, "shrinking is not supported");
> -        return -EINVAL;
> +        return -ENOTSUP;
>      } else if (offset > max_vdi_size) {
>          error_setg(errp, "too big image size");
>          return -EINVAL;

The image will be unchanged and the guest will keep seeing the old image
size, so is there any use case where having the fallback here makes
sense? The only expected case where an image is shrunk is that the user
explicitly sent block_resize - and in that case returning success, but
doing nothing achieves nothing except confusing the user.

file-posix has the same confusing case, but at least it also has cases
where the fake truncate actually achieves something (such a allowing to
create images on block devices).

Kevin

