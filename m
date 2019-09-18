Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21922C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 20:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E861A20665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 20:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E861A20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAgxy-00081h-Vb
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 16:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iAguK-0004MN-GL
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iAguJ-0007d6-AE
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:50:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39594)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iAguG-0007cB-RC; Wed, 18 Sep 2019 16:50:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A84C8667D;
 Wed, 18 Sep 2019 20:50:32 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CADE810018F8;
 Wed, 18 Sep 2019 20:50:27 +0000 (UTC)
Message-ID: <fb155f86e86822ea2e7f4e41932b967878a99716.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 18 Sep 2019 23:50:26 +0300
In-Reply-To: <20190918095144.955-4-mreitz@redhat.com>
References: <20190918095144.955-1-mreitz@redhat.com>
 <20190918095144.955-4-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 18 Sep 2019 20:50:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/8] block: Do not truncate file node when
 formatting
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
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-09-18 at 11:51 +0200, Max Reitz wrote:
> There is no reason why the format drivers need to truncate the protocol
> node when formatting it.  When using the old .bdrv_co_create_ops()
> interface, the file will be created with no size option anyway, which
> generally gives it a size of 0.  (Exceptions are block devices, which
> cannot be truncated anyway.)
> 
> When using blockdev-create, the user must have given the file node some
> size anyway, so there is no reason why we should override that.
> 
> qed is an exception, it needs the file to start completely empty (as
> explained by c743849bee7333c7ef256b7e12e34ed6f907064f).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/parallels.c | 5 -----
>  block/qcow.c      | 5 -----
>  block/qcow2.c     | 6 ------
>  3 files changed, 16 deletions(-)
> 
> diff --git a/block/parallels.c b/block/parallels.c
> index 7cd2714b69..905cac35c6 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -563,11 +563,6 @@ static int coroutine_fn parallels_co_create(BlockdevCreateOptions* opts,
>      blk_set_allow_write_beyond_eof(blk, true);
>  
>      /* Create image format */
> -    ret = blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
> -    if (ret < 0) {
> -        goto out;
> -    }
> -
>      bat_entries = DIV_ROUND_UP(total_size, cl_size);
>      bat_sectors = DIV_ROUND_UP(bat_entry_off(bat_entries), cl_size);
>      bat_sectors = (bat_sectors *  cl_size) >> BDRV_SECTOR_BITS;
> diff --git a/block/qcow.c b/block/qcow.c
> index 5bdf72ba33..17705015ca 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -858,11 +858,6 @@ static int coroutine_fn qcow_co_create(BlockdevCreateOptions *opts,
>      blk_set_allow_write_beyond_eof(qcow_blk, true);
>  
>      /* Create image format */
> -    ret = blk_truncate(qcow_blk, 0, PREALLOC_MODE_OFF, errp);
> -    if (ret < 0) {
> -        goto exit;
> -    }
> -
>      memset(&header, 0, sizeof(header));
>      header.magic = cpu_to_be32(QCOW_MAGIC);
>      header.version = cpu_to_be32(QCOW_VERSION);
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 4d16393e61..4978ccc7be 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3186,12 +3186,6 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>      }
>      blk_set_allow_write_beyond_eof(blk, true);
>  
> -    /* Clear the protocol layer and preallocate it if necessary */
> -    ret = blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
> -    if (ret < 0) {
> -        goto out;
> -    }
> -
>      /* Write the header */
>      QEMU_BUILD_BUG_ON((1 << MIN_CLUSTER_BITS) < sizeof(*header));
>      header = g_malloc0(cluster_size);

As long as bdrv_co_create_ops still creates the underlying file with bdrv_create_file or so,
I also don't see a reason to truncate it to 0 afterward.
Especially for block devices...
So,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


