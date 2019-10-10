Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2323C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8B8206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8B8206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIbP3-0006wU-Bp
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iIbFU-0005ay-7J
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iIbFS-0004Tg-S0
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:25:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iIbFP-0004Sm-Sp; Thu, 10 Oct 2019 12:25:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1832818C426D;
 Thu, 10 Oct 2019 16:25:03 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFBDF60C05;
 Thu, 10 Oct 2019 16:25:02 +0000 (UTC)
Subject: Re: [PATCH 2/2] iotests: Test large write request to qcow2 file
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191010100858.1261-1-mreitz@redhat.com>
 <20191010100858.1261-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <462986b3-2014-a611-5bd4-e7fdf8fef6d5@redhat.com>
Date: Thu, 10 Oct 2019 11:25:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191010100858.1261-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Thu, 10 Oct 2019 16:25:03 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 5:08 AM, Max Reitz wrote:
> Without HEAD^, the following happens when you attempt a large write
> request to a qcow2 file such that the number of bytes covered by all
> clusters involved in a single allocation will exceed INT_MAX:
> 
> (A) handle_alloc_space() decides to fill the whole area with zeroes and
>      fails because bdrv_co_pwrite_zeroes() fails (the request is too
>      large).
> 
> (B) If handle_alloc_space() does not do anything, but merge_cow()
>      decides that the requests can be merged, it will create a too long
>      IOV that later cannot be written.
> 
> (C) Otherwise, all parts will be written separately, so those requests
>      will work.
> 
> In either B or C, though, qcow2_alloc_cluster_link_l2() will have an
> overflow: We use an int (i) to iterate over nb_clusters, and then
> calculate the L2 entry based on "i << s->cluster_bits" -- which will
> overflow if the range covers more than INT_MAX bytes.  This then leads
> to image corruption because the L2 entry will be wrong (it will be
> recognized as a compressed cluster).
> 
> Even if that were not the case, the .cow_end area would be empty
> (because handle_alloc() will cap avail_bytes and nb_bytes at INT_MAX, so
> their difference (which is the .cow_end size) will be 0).
> 
> So this test checks that on such large requests, the image will not be
> corrupted.  Unfortunately, we cannot check whether COW will be handled
> correctly, because that data is discarded when it is written to null-co
> (but we have to use null-co, because writing 2 GB of data in a test is
> not quite reasonable).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/268     | 83 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/268.out |  9 +++++
>   tests/qemu-iotests/group   |  1 +
>   3 files changed, 93 insertions(+)
>   create mode 100755 tests/qemu-iotests/268
>   create mode 100644 tests/qemu-iotests/268.out
> 
> diff --git a/tests/qemu-iotests/268 b/tests/qemu-iotests/268
> new file mode 100755
> index 0000000000..b9a12b908c
> --- /dev/null
> +++ b/tests/qemu-iotests/268

> +# We want a null-co as the data file, because it allows us to quickly
> +# "write" 2G of data without using any space.
> +# (qemu-img create does not like it, though, because null-co does not
> +# support image creation.)
> +$QEMU_IMG amend -o data_file="json:{'driver':'null-co',,'size':'4294967296'}" \
> +    "$TEST_IMG"
> +

A bit awkward, but works.

> +# This gives us a range of:
> +#   2^31 - 512 + 768 - 1 = 2^31 + 255 > 2^31
> +# until the beginning of the end COW block.  (The total allocation
> +# size depends on the cluster size, but all that is important is that
> +# it exceeds INT_MAX.)
> +#
> +# 2^31 - 512 is the maximum request size.  We want this to result in a
> +# single allocation, and because the qcow2 driver splits allocations
> +# on L2 boundaries, we need large L2 tables; hence the cluster size of
> +# 2 MB.  (Anything from 256 kB should work, though, because then one L2
> +# table covers 8 GB.)
> +$QEMU_IO -c "write 768 $((2 ** 31 - 512))" "$TEST_IMG" | _filter_qemu_io

Yep, that causes the rounding issue that requires being able to handle > 
2G gracefully.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

