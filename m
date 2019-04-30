Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60296C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED2F2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED2F2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42779 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPzu-0001oo-SR
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 06:28:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLPq7-0001iV-9s
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLPbk-0002Hl-AR
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:03:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLPbj-0002Go-00; Tue, 30 Apr 2019 06:03:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0ED2C99CE3;
	Tue, 30 Apr 2019 10:03:26 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C7E281001E95;
	Tue, 30 Apr 2019 10:03:24 +0000 (UTC)
Date: Tue, 30 Apr 2019 12:03:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Message-ID: <20190430100322.GB5607@linux.fritz.box>
References: <cover.1556562150.git.berto@igalia.com>
	<e5e1571c583874454760dc738ef3ea3470ea96e7.1556562150.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <e5e1571c583874454760dc738ef3ea3470ea96e7.1556562150.git.berto@igalia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 30 Apr 2019 10:03:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/5] vdi: Replace bdrv_{read,
 write}() with bdrv_{pread, pwrite}()
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430100322.KJO0XpiJWvIbJNIUk9i3GloVJjrrvToEVFT6exmGYOY@z>

Am 29.04.2019 um 20:42 hat Alberto Garcia geschrieben:
> There's only a couple of bdrv_read() and bdrv_write() calls left in
> the vdi code, and they can be trivially replaced with the byte-based
> bdrv_pread() and bdrv_pwrite().
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/vdi.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/block/vdi.c b/block/vdi.c
> index e1c42ad732..8d849b2754 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -384,7 +384,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
>  
>      logout("\n");
>  
> -    ret = bdrv_read(bs->file, 0, (uint8_t *)&header, 1);
> +    ret = bdrv_pread(bs->file, 0, (uint8_t *)&header, sizeof(header));

Maybe worth adding this after the VdiHeader declaration?

QEMU_BUILD_BUG_ON(sizeof(VdiHeader) != 512);

>      if (ret < 0) {
>          goto fail;
>      }
> @@ -484,8 +484,8 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
>          goto fail;
>      }
>  
> -    ret = bdrv_read(bs->file, s->bmap_sector, (uint8_t *)s->bmap,
> -                    bmap_size);
> +    ret = bdrv_pread(bs->file, header.offset_bmap, (uint8_t *)s->bmap,
> +                     bmap_size * SECTOR_SIZE);
>      if (ret < 0) {
>          goto fail_free_bmap;
>      }
> @@ -704,7 +704,7 @@ nonallocating_write:
>          assert(VDI_IS_ALLOCATED(bmap_first));
>          *header = s->header;
>          vdi_header_to_le(header);
> -        ret = bdrv_write(bs->file, 0, block, 1);
> +        ret = bdrv_pwrite(bs->file, 0, block, sizeof(*block));

block is uint8_t*, so sizeof(*block) == 1. This is not what you want.
(qemu-iotests catches this pretty early.)

>          g_free(block);
>          block = NULL;
>  
> @@ -722,7 +722,8 @@ nonallocating_write:
>          base = ((uint8_t *)&s->bmap[0]) + bmap_first * SECTOR_SIZE;
>          logout("will write %u block map sectors starting from entry %u\n",
>                 n_sectors, bmap_first);
> -        ret = bdrv_write(bs->file, offset, base, n_sectors);
> +        ret = bdrv_pwrite(bs->file, offset * SECTOR_SIZE, base,
> +                          n_sectors * SECTOR_SIZE);
>      }
>  
>      return ret;

Let's avoid returning a non-zero positive number in the success case
here. bdrv_driver_pwritev() checks ret == 0 for BDRV_REQ_FUA emulation,
and its callers don't expect positive results either.

Maybe we should actually assert() in bdrv_driver_preadv/pwritev() that
the result is <= 0.

Kevin

