Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B98C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFEFD20673
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEFD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEcJh-0002tk-Cw
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 12:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc8n-0001RY-3I
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc8l-0004Qb-R2
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:33:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEc8i-0004H6-Q2; Sun, 29 Sep 2019 12:33:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 126EC10C0932;
 Sun, 29 Sep 2019 16:33:40 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC4025C223;
 Sun, 29 Sep 2019 16:33:38 +0000 (UTC)
Message-ID: <96791fcb8157f8512a9eb8d873b540b06ccd96a7.camel@redhat.com>
Subject: Re: [PATCH 10/18] iotests: Avoid qemu-img create
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Sun, 29 Sep 2019 19:33:37 +0300
In-Reply-To: <20190927094242.11152-11-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-11-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Sun, 29 Sep 2019 16:33:40 +0000 (UTC)
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
> Use _make_test_img whenever possible.  This way, we will not ignore
> user-specified image options.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/094 | 2 +-
>  tests/qemu-iotests/111 | 3 +--
>  tests/qemu-iotests/123 | 2 +-
>  tests/qemu-iotests/153 | 2 +-
>  tests/qemu-iotests/200 | 4 ++--
>  5 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
> index 9343e09492..d645952d54 100755
> --- a/tests/qemu-iotests/094
> +++ b/tests/qemu-iotests/094
> @@ -45,7 +45,7 @@ _supported_proto nbd
>  _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat"
>  
>  _make_test_img 64M
> -$QEMU_IMG create -f $IMGFMT "$TEST_DIR/source.$IMGFMT" 64M | _filter_img_create
> +TEST_IMG_FILE="$TEST_DIR/source.$IMGFMT" IMGPROTO=file _make_test_img 64M
>  
>  _launch_qemu -drive if=none,id=src,file="$TEST_DIR/source.$IMGFMT",format=raw \
>               -nodefaults
> diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
> index 490a5bbcb5..3b43d1bd83 100755
> --- a/tests/qemu-iotests/111
> +++ b/tests/qemu-iotests/111
> @@ -41,8 +41,7 @@ _supported_fmt qed qcow qcow2 vmdk
>  _supported_proto file
>  _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat"
>  
> -$QEMU_IMG create -f $IMGFMT -b "$TEST_IMG.inexistent" "$TEST_IMG" 2>&1 \
> -    | _filter_testdir | _filter_imgfmt
> +_make_test_img -b "$TEST_IMG.inexistent"
>  
>  # success, all done
>  echo '*** done'
> diff --git a/tests/qemu-iotests/123 b/tests/qemu-iotests/123
> index d33950eb54..74d40d0478 100755
> --- a/tests/qemu-iotests/123
> +++ b/tests/qemu-iotests/123
> @@ -44,7 +44,7 @@ _supported_os Linux
>  SRC_IMG="$TEST_DIR/source.$IMGFMT"
>  
>  _make_test_img 1M
> -$QEMU_IMG create -f $IMGFMT "$SRC_IMG" 1M | _filter_img_create
> +TEST_IMG_FILE=$SRC_IMG IMGPROTO=file _make_test_img 1M
>  
>  $QEMU_IO -c 'write -P 42 0 1M' "$SRC_IMG" | _filter_qemu_io
>  
> diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
> index c969a1a16f..e59090259c 100755
> --- a/tests/qemu-iotests/153
> +++ b/tests/qemu-iotests/153
> @@ -98,7 +98,7 @@ for opts1 in "" "read-only=on" "read-only=on,force-share=on"; do
>  
>      echo
>      echo "== Creating test image =="
> -    $QEMU_IMG create -f $IMGFMT "${TEST_IMG}" -b ${TEST_IMG}.base | _filter_img_create
> +    _make_test_img -b "${TEST_IMG}.base"
>  
>      echo
>      echo "== Launching QEMU, opts: '$opts1' =="
> diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
> index 72d431f251..d904885136 100755
> --- a/tests/qemu-iotests/200
> +++ b/tests/qemu-iotests/200
> @@ -46,8 +46,8 @@ _supported_proto file
>  BACKING_IMG="${TEST_DIR}/backing.img"
>  TEST_IMG="${TEST_DIR}/test.img"
>  
> -${QEMU_IMG} create -f $IMGFMT "${BACKING_IMG}" 512M | _filter_img_create
> -${QEMU_IMG} create -f $IMGFMT -F $IMGFMT "${TEST_IMG}" -b "${BACKING_IMG}" 512M | _filter_img_create
> +TEST_IMG="$BACKING_IMG" _make_test_img 512M
> +_make_test_img -F $IMGFMT -b "$BACKING_IMG" 512M
>  
>  ${QEMU_IO} -c "write -P 0xa5 512 300M" "${BACKING_IMG}" | _filter_qemu_io
>  
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>



