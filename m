Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE916C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12F921835
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12F921835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEcA5-0001yH-4J
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 12:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc7B-0008SG-MQ
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc7A-00029u-5t
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:32:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEc77-00026l-4U; Sun, 29 Sep 2019 12:32:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 58DAB308FC22;
 Sun, 29 Sep 2019 16:32:00 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C0B819C78;
 Sun, 29 Sep 2019 16:31:58 +0000 (UTC)
Message-ID: <456ed2bf18ee3033aa2115cc3b31bde1e0833348.camel@redhat.com>
Subject: Re: [PATCH 02/18] iotests: Replace IMGOPTS by _unsupported_imgopts
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Sun, 29 Sep 2019 19:31:58 +0300
In-Reply-To: <20190927094242.11152-3-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-3-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Sun, 29 Sep 2019 16:32:00 +0000 (UTC)
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

On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
> Some tests require compat=1.1 and thus set IMGOPTS='compat=1.1'
> globally.  That is not how it should be done; instead, they should
> simply set _unsupported_imgopts to compat=0.10 (compat=1.1 is the
> default anyway).
> 
> This makes the tests heed user-specified $IMGOPTS.  Some do not work
> with all image options, though, so we need to disable them accordingly.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/036 | 3 +--
>  tests/qemu-iotests/060 | 4 ++--
>  tests/qemu-iotests/062 | 3 ++-
>  tests/qemu-iotests/066 | 3 ++-
>  tests/qemu-iotests/068 | 3 ++-
>  tests/qemu-iotests/098 | 3 +--
>  6 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
> index 69d0f9f903..57dda23b02 100755
> --- a/tests/qemu-iotests/036
> +++ b/tests/qemu-iotests/036
> @@ -43,9 +43,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  # This tests qcow2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto file
> -
>  # Only qcow2v3 and later supports feature bits
> -IMGOPTS="compat=1.1"
> +_unsupported_imgopts 'compat=0.10'
>  
>  echo
>  echo === Image with unknown incompatible feature bit ===
> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
> index b91d8321bb..9c2ef42522 100755
> --- a/tests/qemu-iotests/060
> +++ b/tests/qemu-iotests/060
> @@ -48,6 +48,8 @@ _filter_io_error()
>  _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
> +# These tests only work for compat=1.1 images with refcount_bits=16
> +_unsupported_imgopts 'compat=0.10' 'refcount_bits=\([^1]\|.\([^6]\|$\)\)'
>  
>  rt_offset=65536  # 0x10000 (XXX: just an assumption)
>  rb_offset=131072 # 0x20000 (XXX: just an assumption)
> @@ -55,8 +57,6 @@ l1_offset=196608 # 0x30000 (XXX: just an assumption)
>  l2_offset=262144 # 0x40000 (XXX: just an assumption)
>  l2_offset_after_snapshot=524288 # 0x80000 (XXX: just an assumption)
>  
> -IMGOPTS="compat=1.1"
> -
>  OPEN_RW="open -o overlap-check=all $TEST_IMG"
>  # Overlap checks are done before write operations only, therefore opening an
>  # image read-only makes the overlap-check option irrelevant
> diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
> index d5f818fcce..ac0d2a9a3b 100755
> --- a/tests/qemu-iotests/062
> +++ b/tests/qemu-iotests/062
> @@ -40,8 +40,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  # This tests qocw2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto generic
> +# We need zero clusters and snapshots
> +_unsupported_imgopts 'compat=0.10' 'refcount_bits=1[^0-9]'
>  
> -IMGOPTS="compat=1.1"
>  IMG_SIZE=64M
>  
>  echo
> diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
> index 28f8c98412..9a15ba8027 100755
> --- a/tests/qemu-iotests/066
> +++ b/tests/qemu-iotests/066
> @@ -39,9 +39,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  # This tests qocw2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto generic
> +# Weneed zero clusters and snapshots
Typo
> +_unsupported_imgopts 'compat=0.10' 'refcount_bits=1[^0-9]'
>  
>  # Intentionally create an unaligned image
> -IMGOPTS="compat=1.1"
>  IMG_SIZE=$((64 * 1024 * 1024 + 512))
>  
>  echo
> diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
> index 22f5ca3ba6..65650fca9a 100755
> --- a/tests/qemu-iotests/068
> +++ b/tests/qemu-iotests/068
> @@ -39,8 +39,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  # This tests qocw2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto generic
> +# Internal snapshots are (currently) impossible with refcount_bits=1
Why currently? 1 bit will only allow to mark a cluser as used/unused which
is not enough for any snapshots?

> +_unsupported_imgopts 'compat=0.10' 'refcount_bits=1[^0-9]'
>  
> -IMGOPTS="compat=1.1"
>  IMG_SIZE=128K
>  
>  case "$QEMU_DEFAULT_MACHINE" in
> diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
> index 1c1d1c468f..2d68dc7d6c 100755
> --- a/tests/qemu-iotests/098
> +++ b/tests/qemu-iotests/098
> @@ -40,8 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  
>  _supported_fmt qcow2
>  _supported_proto file
> -
> -IMGOPTS="compat=1.1"
> +_unsupported_imgopts 'compat=0.10'
Any idea why? I am not familiar with qcow2 well enought to
know but this misses a comment with justification.


>  
>  for event in l1_update empty_image_prepare reftable_update refblock_alloc; do
>  


Best regards,
	Maxim Levitsky


