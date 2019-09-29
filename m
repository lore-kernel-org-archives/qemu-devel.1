Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DECC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C64217F5
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C64217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEcBU-0003Ka-Am
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 12:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc8i-0001Kq-Fw
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc8h-0004DO-BW
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:33:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEc8Z-0003nj-Kb; Sun, 29 Sep 2019 12:33:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 639AC8A218D;
 Sun, 29 Sep 2019 16:33:30 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 277B460C05;
 Sun, 29 Sep 2019 16:33:28 +0000 (UTC)
Message-ID: <1c6c86af32c3de1b473b48704cf506694c10c597.camel@redhat.com>
Subject: Re: [PATCH 09/18] iotests: Drop IMGOPTS use in 267
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Sun, 29 Sep 2019 19:33:28 +0300
In-Reply-To: <20190927094242.11152-10-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-10-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Sun, 29 Sep 2019 16:33:30 +0000 (UTC)
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
> Overwriting IMGOPTS means ignoring all user-supplied options, which is
> not what we want.  Replace the current IMGOPTS use by a new BACKING_FILE
> variable.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/267 | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
> index 95f885442f..529f5f9afe 100755
> --- a/tests/qemu-iotests/267
> +++ b/tests/qemu-iotests/267
> @@ -68,7 +68,11 @@ size=128M
>  
>  run_test()
>  {
> -    _make_test_img $size
> +    if [ -n "$BACKING_FILE" ]; then
> +        _make_test_img -b "$BACKING_FILE" $size
> +    else
> +        _make_test_img $size
> +    fi
>      printf "savevm snap0\ninfo snapshots\nloadvm snap0\n" | run_qemu "$@" | _filter_date
>  }
>  
> @@ -119,12 +123,12 @@ echo
>  
>  TEST_IMG="$TEST_IMG.base" _make_test_img $size
>  
> -IMGOPTS="backing_file=$TEST_IMG.base" \
> +BACKING_FILE="$TEST_IMG.base" \
>  run_test -blockdev driver=file,filename="$TEST_IMG.base",node-name=backing-file \
>           -blockdev driver=file,filename="$TEST_IMG",node-name=file \
>           -blockdev driver=$IMGFMT,file=file,backing=backing-file,node-name=fmt
>  
> -IMGOPTS="backing_file=$TEST_IMG.base" \
> +BACKING_FILE="$TEST_IMG.base" \
>  run_test -blockdev driver=file,filename="$TEST_IMG.base",node-name=backing-file \
>           -blockdev driver=$IMGFMT,file=backing-file,node-name=backing-fmt \
>           -blockdev driver=file,filename="$TEST_IMG",node-name=file \
> @@ -141,7 +145,7 @@ echo
>  echo "=== -blockdev with NBD server on the backing file ==="
>  echo
>  
> -IMGOPTS="backing_file=$TEST_IMG.base" _make_test_img $size
> +_make_test_img -b "$TEST_IMG.base" $size
>  cat <<EOF |
>  nbd_server_start unix:$TEST_DIR/nbd
>  nbd_server_add -w backing-fmt

qemu's master (pulled today), don't have iotest 267,
you probably based this on some not yet merged branch.
Or I made some mistake with pulling the master branch.

Best regards,
	Maxim Levitsky


