Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DB8C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F9F217F5
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F9F217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEcEf-0006Ui-Sd
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 12:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc8T-00019t-Vd
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc8S-0003fp-Mo
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:33:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33666)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEc8P-0003aM-Es; Sun, 29 Sep 2019 12:33:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A6B393082A8B;
 Sun, 29 Sep 2019 16:33:19 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6ADEB5D9C3;
 Sun, 29 Sep 2019 16:33:18 +0000 (UTC)
Message-ID: <5edcc0bc2c3bcce576b23ba887a0198a4ca1e9eb.camel@redhat.com>
Subject: Re: [PATCH 08/18] iotests: Replace IMGOPTS='' by --no-opts
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Sun, 29 Sep 2019 19:33:17 +0300
In-Reply-To: <20190927094242.11152-9-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-9-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Sun, 29 Sep 2019 16:33:19 +0000 (UTC)
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
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/071 | 4 ++--
>  tests/qemu-iotests/174 | 2 +-
>  tests/qemu-iotests/178 | 4 ++--
>  tests/qemu-iotests/197 | 4 ++--
>  tests/qemu-iotests/215 | 4 ++--
>  5 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
> index fab526666b..4e31943244 100755
> --- a/tests/qemu-iotests/071
> +++ b/tests/qemu-iotests/071
> @@ -58,7 +58,7 @@ echo
>  echo "=== Testing blkverify through filename ==="
>  echo
>  
> -TEST_IMG="$TEST_IMG.base" IMGOPTS="" IMGFMT="raw" _make_test_img $IMG_SIZE |\
> +TEST_IMG="$TEST_IMG.base" IMGFMT="raw" _make_test_img --no-opts $IMG_SIZE |\
>      _filter_imgfmt
>  _make_test_img $IMG_SIZE
>  $QEMU_IO -c "open -o driver=raw,file.driver=blkverify,file.raw.filename=$TEST_IMG.base $TEST_IMG" \
> @@ -73,7 +73,7 @@ echo
>  echo "=== Testing blkverify through file blockref ==="
>  echo
>  
> -TEST_IMG="$TEST_IMG.base" IMGOPTS="" IMGFMT="raw" _make_test_img $IMG_SIZE |\
> +TEST_IMG="$TEST_IMG.base" IMGFMT="raw" _make_test_img --no-opts $IMG_SIZE |\
>      _filter_imgfmt
>  _make_test_img $IMG_SIZE
>  $QEMU_IO -c "open -o driver=raw,file.driver=blkverify,file.raw.filename=$TEST_IMG.base,file.test.driver=$IMGFMT,file.test.file.filename=$TEST_IMG" \
> diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
> index 0a952a73fd..e2f14a38c6 100755
> --- a/tests/qemu-iotests/174
> +++ b/tests/qemu-iotests/174
> @@ -40,7 +40,7 @@ _unsupported_fmt raw
>  
>  
>  size=256K
> -IMGFMT=raw IMGKEYSECRET= IMGOPTS= _make_test_img $size | _filter_imgfmt
> +IMGFMT=raw IMGKEYSECRET= _make_test_img --no-opts $size | _filter_imgfmt
>  
>  echo
>  echo "== reading wrong format should fail =="
> diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
> index 21231cadd3..75b5e8f314 100755
> --- a/tests/qemu-iotests/178
> +++ b/tests/qemu-iotests/178
> @@ -62,8 +62,8 @@ $QEMU_IMG measure -O foo "$TEST_IMG" # unknown image file format
>  
>  make_test_img_with_fmt() {
>      # Shadow global variables within this function
> -    local IMGFMT="$1" IMGOPTS=""
> -    _make_test_img "$2"
> +    local IMGFMT="$1"
> +    _make_test_img --no-opts "$2"
>  }
>  
>  qemu_io_with_fmt() {
> diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
> index 1d4f6786db..4d3d08ad6f 100755
> --- a/tests/qemu-iotests/197
> +++ b/tests/qemu-iotests/197
> @@ -66,8 +66,8 @@ if [ "$IMGFMT" = "vpc" ]; then
>  fi
>  _make_test_img 4G
>  $QEMU_IO -c "write -P 55 3G 1k" "$TEST_IMG" | _filter_qemu_io
> -IMGPROTO=file IMGFMT=qcow2 IMGOPTS= TEST_IMG_FILE="$TEST_WRAP" \
> -    _make_test_img -F "$IMGFMT" -b "$TEST_IMG" | _filter_img_create
> +IMGPROTO=file IMGFMT=qcow2 TEST_IMG_FILE="$TEST_WRAP" \
> +    _make_test_img --no-opts -F "$IMGFMT" -b "$TEST_IMG" | _filter_img_create
>  $QEMU_IO -f qcow2 -c "write -z -u 1M 64k" "$TEST_WRAP" | _filter_qemu_io
>  
>  # Ensure that a read of two clusters, but where one is already allocated,
> diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
> index 2eb377d682..55a1874dcd 100755
> --- a/tests/qemu-iotests/215
> +++ b/tests/qemu-iotests/215
> @@ -63,8 +63,8 @@ if [ "$IMGFMT" = "vpc" ]; then
>  fi
>  _make_test_img 4G
>  $QEMU_IO -c "write -P 55 3G 1k" "$TEST_IMG" | _filter_qemu_io
> -IMGPROTO=file IMGFMT=qcow2 IMGOPTS= TEST_IMG_FILE="$TEST_WRAP" \
> -    _make_test_img -F "$IMGFMT" -b "$TEST_IMG" | _filter_img_create
> +IMGPROTO=file IMGFMT=qcow2 TEST_IMG_FILE="$TEST_WRAP" \
> +    _make_test_img --no-opts -F "$IMGFMT" -b "$TEST_IMG" | _filter_img_create
>  $QEMU_IO -f qcow2 -c "write -z -u 1M 64k" "$TEST_WRAP" | _filter_qemu_io
>  
>  # Ensure that a read of two clusters, but where one is already allocated,


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>



