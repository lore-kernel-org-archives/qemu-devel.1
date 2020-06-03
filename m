Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7092EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D17F206A2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D17F206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUgA-0004jx-Dj
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jgUf8-0003tn-8f
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:46:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:45712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jgUf7-0007gV-C2
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:46:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 654AEACA3;
 Wed,  3 Jun 2020 14:46:37 +0000 (UTC)
Subject: Re: [PATCH 1/4] block: Add bdrv_co_get_lba_status
To: Lin Ma <lma@suse.com>, qemu-devel@nongnu.org
References: <20200602074201.10879-1-lma@suse.com>
 <20200602074201.10879-2-lma@suse.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <40137f16-2be0-e9c1-32be-e3567a7a9b82@suse.de>
Date: Wed, 3 Jun 2020 16:46:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200602074201.10879-2-lma@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 22:45:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, pbonzini@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Lin,

just a couple of things, leaving the core aspects to more knowledgeable people in this area to address.

In general, you want all patches in the series to build correctly.

Applying only PATCH 1/4 breaks the build for me with:

/home/claudio/git/qemu/block/io.c:2190:1: error: no previous prototype for ‘bdrv_co_get_lba_status’ [-Werror=missing-prototypes]
 bdrv_co_get_lba_status(BdrvChild *child, int64_t offset, int64_t bytes,
 ^~~~~~~~~~~~~~~~~~~~~~
/home/claudio/git/qemu/block/io.c: In function ‘bdrv_co_get_lba_status’:
/home/claudio/git/qemu/block/io.c:2194:9: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     int ret;
         ^~~
cc1: all warnings being treated as errors

On 6/2/20 9:41 AM, Lin Ma wrote:
> The get lba status wrapper based on the bdrv_block_status. The following
> patches will add GET LBA STATUS 16 support for scsi emulation layer.
> 
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  block/io.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/block/io.c b/block/io.c
> index 121ce17a49..dacc3c2471 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2186,6 +2186,49 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
>                             BDRV_REQ_ZERO_WRITE | flags);
>  }
>  
> +int coroutine_fn
> +bdrv_co_get_lba_status(BdrvChild *child, int64_t offset, int64_t bytes,
> +                       uint32_t *num_blocks, uint32_t *is_deallocated)
> +{
> +    BlockDriverState *bs = child->bs;
> +    int ret;
> +    int64_t target_size, count = 0;
> +    bool first = true;
> +    uint8_t wanted_bit1 = 0;
> +
> +    target_size = bdrv_getlength(bs);
> +    if (target_size < 0) {
> +        return -EIO;
> +    }
> +
> +    if (offset < 0 || bytes < 0) {
> +        return -EIO;
> +    }
> +
> +    for ( ; offset <= target_size - bytes; offset += count) {
> +        ret = bdrv_block_status(bs, offset, bytes, &count, NULL, NULL);
> +        if (ret < 0) {
> +            goto out;
> +        }
> +        if (first) {
> +            if (ret & BDRV_BLOCK_ZERO) {
> +                wanted_bit1 = BDRV_BLOCK_ZERO >> 1;;

extra ; at the end of the line

> +                *is_deallocated = 1;
> +            } else {
> +                wanted_bit1 = 0;
> +            }
> +            first = false;
> +        }
> +        if ((ret & BDRV_BLOCK_ZERO) >> 1 == wanted_bit1) {
> +            (*num_blocks)++;
> +        } else {
> +            break;
> +        }
> +    }
> +out:
> +    return ret;
> +}
> +
>  /*
>   * Flush ALL BDSes regardless of if they are reachable via a BlkBackend or not.
>   */
> 

Ciao,

CLaudio

