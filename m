Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D10C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 13:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7B620820
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 13:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7B620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4m4C-0006W8-PR
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 09:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i4m39-00060o-4d
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 09:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i4m37-0005Xw-3N
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 09:07:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i4m32-0005J4-AW; Mon, 02 Sep 2019 09:07:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8683110F23EE;
 Mon,  2 Sep 2019 13:07:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-189.ams2.redhat.com
 [10.36.116.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE9EC5D6B7;
 Mon,  2 Sep 2019 13:07:02 +0000 (UTC)
Date: Mon, 2 Sep 2019 15:07:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Lieven <pl@kamp.de>
Message-ID: <20190902130701.GE13140@localhost.localdomain>
References: <20190829133615.29873-1-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829133615.29873-1-pl@kamp.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 02 Sep 2019 13:07:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block/vhdx: add check for truncated image
 files
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
Cc: codyprime@gmail.com, Jan-Hendrik Frintrop <jhf@kamp.de>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 29.08.2019 um 15:36 hat Peter Lieven geschrieben:
> qemu is currently not able to detect truncated vhdx image files.
> Add a basic check if all allocated blocks are reachable to vhdx_co_check.
> 
> Signed-off-by: Jan-Hendrik Frintrop <jhf@kamp.de>
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/vhdx.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 6a09d0a55c..4382b1375d 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -2068,10 +2068,29 @@ static int coroutine_fn vhdx_co_check(BlockDriverState *bs,
>                                        BdrvCheckMode fix)
>  {
>      BDRVVHDXState *s = bs->opaque;
> +    VHDXSectorInfo sinfo;
> +    int64_t file_size = bdrv_get_allocated_file_size(bs);

Don't you mean bdrv_getlength()?

bdrv_get_allocated_file_size() is only the allocated size, i.e. without
holes. So a higher offset may actually be present.

> +    int64_t sector_num;
>  
>      if (s->log_replayed_on_open) {
>          result->corruptions_fixed++;
>      }
> +
> +    for (sector_num = 0; sector_num < bs->total_sectors;
> +         sector_num += s->block_size / BDRV_SECTOR_SIZE) {
> +        int nb_sectors = MIN(bs->total_sectors - sector_num,
> +                             s->block_size / BDRV_SECTOR_SIZE);
> +        vhdx_block_translate(s, sector_num, nb_sectors, &sinfo);
> +        if ((s->bat[sinfo.bat_idx] & VHDX_BAT_STATE_BIT_MASK) ==
> +            PAYLOAD_BLOCK_FULLY_PRESENT) {
> +            if (sinfo.file_offset +
> +                sinfo.sectors_avail * BDRV_SECTOR_SIZE > file_size) {

Do we need to protect against integer overflows here? I think
sinfo.file_offset comes directly from the image file and might be
corrupted.

Or has it already been check somewhere?

> +                /* block is past the end of file, image has been truncated. */
> +                result->corruptions++;

I think we should print an error message like other formats do, so that
the user knows which kind of corruption 'qemu-img check' found (include
the guest and host offset of the invalid block).

> +            }
> +        }
> +    }
> +
>      return 0;
>  }

Kevin

