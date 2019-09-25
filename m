Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338A6C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05FC62146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FC62146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDEs6-0001W2-2l
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 17:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iDEqS-0008JV-Ip
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iDEqR-000835-D0
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:29:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45456)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iDEq9-0007mr-Oa; Wed, 25 Sep 2019 17:28:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 76B00308212F;
 Wed, 25 Sep 2019 21:28:45 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0717E1001B00;
 Wed, 25 Sep 2019 21:28:44 +0000 (UTC)
Subject: Re: [PATCH 2/3] iotests: Disable 125 on broken XFS versions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190925183231.11196-1-mreitz@redhat.com>
 <20190925183231.11196-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ed2e18dc-1217-7825-aebd-af48e440ef96@redhat.com>
Date: Wed, 25 Sep 2019 16:28:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925183231.11196-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 25 Sep 2019 21:28:45 +0000 (UTC)
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

On 9/25/19 1:32 PM, Max Reitz wrote:
> And by that I mean all XFS versions, as far as I can tell.  All details
> are in the comment below.
> 
> We never noticed this problem because we only read the first number from
> qemu-img info's "disk size" output -- and that is effectively useless,
> because qemu-img prints a human-readable value (which generally includes
> a decimal point).  That will be fixed in the next patch.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/125 | 40 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
> index df328a63a6..0ef51f1e21 100755
> --- a/tests/qemu-iotests/125
> +++ b/tests/qemu-iotests/125
> @@ -49,6 +49,46 @@ if [ -z "$TEST_IMG_FILE" ]; then
>       TEST_IMG_FILE=$TEST_IMG
>   fi
>   
> +# Test whether we are running on a broken XFS version.  There is this
> +# bug:
> +
> +# $ rm -f foo
> +# $ touch foo
> +# $ block_size=4096 # Your FS's block size
> +# $ fallocate -o $((block_size / 2)) -l $block_size foo
> +# $ LANG=C xfs_bmap foo | grep hole
> +#         1: [8..15]: hole
> +#
> +# The problem is that the XFS driver rounds down the offset and
> +# rounds up the length to the block size, but independently.

Eww. I concur you uncovered a bug.  Have you reported this to xfs folks?

> +
> +touch "$TEST_IMG_FILE"
> +# Assuming there is no FS with a block size greater than 64k
> +fallocate -o 65535 -l 2 "$TEST_IMG_FILE"
> +len0=$(get_image_size_on_host)
> +
> +# Write to something that in theory we have just fallocated
> +# (Thus, the on-disk size should not increase)
> +poke_file "$TEST_IMG_FILE" 65536 42
> +len1=$(get_image_size_on_host)
> +
> +if [ $len1 -gt $len0 ]; then
> +    _notrun "the test filesystem's fallocate() is broken"
> +fi
> +
> +rm -f "$TEST_IMG_FILE"

Reviewed-by: Eric Blake <eblake@redhat.com>

> +
>   # Generally, we create some image with or without existing preallocation and
>   # then resize it. Then we write some data into the image and verify that its
>   # size does not change if we have used preallocation.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

