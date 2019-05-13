Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428C3C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 19:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164C020850
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 19:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164C020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34029 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQGiG-0007qn-8V
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 15:34:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1hQGgL-0006i4-9s
	for qemu-devel@nongnu.org; Mon, 13 May 2019 15:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1hQGgJ-0002Bu-OM
	for qemu-devel@nongnu.org; Mon, 13 May 2019 15:32:17 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:44380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1hQGgJ-0002Ae-HT
	for qemu-devel@nongnu.org; Mon, 13 May 2019 15:32:15 -0400
Received: by mail-oi1-f172.google.com with SMTP id z65so3040520oia.11
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 12:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=KVTe2WOIT1HDg/9VNCr0mTjf9oVbirz2WXQ6fQjyQ8Q=;
	b=PJzoY+0ILqiPYWrM2lpdaYvC2gI04xRVRB/FEvX/B+os9IyUQKH/aB5oVLKv/VKlZd
	DLm2QAJYaZFxdfzKbaXKzfEky29fz84+ofYrclZLL4zrRExBBBjPC1fUgOn8cgbXzQ93
	ckqYsRqJPfCkhAiH7G7Xzyxb9Gs5ErVqFw08tn35I48jaz26Y6S8fFU/uK/Rj5xTNciY
	Un4ICBLt18vTm7zP+W2UOMbOjgp/QQN0vsrVsqJ/KKapU+BvH0wRzIoHfYXBhtb0F503
	NNdN9ZCksXn0oQnyOBFuthIoxZXqfNUP1RQmkGaiDVx2s0szEEF7bkJh3xmxV40jdGeA
	noVA==
X-Gm-Message-State: APjAAAXM4nCTr4DYODfwj6zBGPh9Cs2S9esueSQB+K1LV6DP/oAusgNl
	N+eFrZ4ymvw5DGZeedN86legq3/RoQVsR6e8mnN6Ug==
X-Google-Smtp-Source: APXvYqyrBgUEq0bs6m6bbTqF51JcrfgilNX2XYAiAPWqaROzNUesZy6Kr3GvQwGm73ZoJM814P6qCizVm7m7jtazQtE=
X-Received: by 2002:aca:3d57:: with SMTP id k84mr497640oia.106.1557775932199; 
	Mon, 13 May 2019 12:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190513155254.27773-1-mreitz@redhat.com>
In-Reply-To: <20190513155254.27773-1-mreitz@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 13 May 2019 22:31:59 +0300
Message-ID: <CAMRbyytLLb_+D1KEPz2gUmrzu7NBFFM3=ziNvXdOhpy7S-u6OA@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.167.172
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2] iotests: Filter 175's allocation
 information
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019, 18:52 Max Reitz <mreitz@redhat.com> wrote:

> It is possible for an empty file to take up blocks on a filesystem.
> Make iotest 175 take this into account.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> v2: [Nir]
> - Use a function for filtering
> - s/empty_blocks/extra_blocks/
> ---
>  tests/qemu-iotests/175     | 26 ++++++++++++++++++++++----
>  tests/qemu-iotests/175.out |  8 ++++----
>  2 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
> index d0ffc495c2..b5eb0aa856 100755
> --- a/tests/qemu-iotests/175
> +++ b/tests/qemu-iotests/175
> @@ -28,10 +28,25 @@ status=1    # failure is the default!
>
>  _cleanup()
>  {
> -       _cleanup_test_img
> +    _cleanup_test_img
> +    rm -f "$TEST_DIR/empty"
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>
> +# Some file systems sometimes allocate extra blocks independently of
> +# the file size.  This function hides the resulting difference in the
> +# stat -c '%b' output.
> +# Parameter 1: Number of blocks an empty file occupies
> +# Parameter 2: Image size in bytes
> +_filter_blocks()
> +{
> +    extra_blocks=$1
> +    img_size=$2
> +
> +    sed -e "s/blocks=$extra_blocks/nothing allocated/" \
> +        -e "s/blocks=$((extra_blocks + img_size / 512))/everything
> allocated/"
> +}
> +
>  # get standard environment, filters and checks
>  . ./common.rc
>  . ./common.filter
> @@ -40,18 +55,21 @@ _supported_fmt raw
>  _supported_proto file
>  _supported_os Linux
>
> -size=1m
> +size=$((1 * 1024 * 1024))
> +
> +touch "$TEST_DIR/empty"
> +extra_blocks=$(stat -c '%b' "$TEST_DIR/empty")
>
>  echo
>  echo "== creating image with default preallocation =="
>  _make_test_img $size | _filter_imgfmt
> -stat -c "size=%s, blocks=%b" $TEST_IMG
> +stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks
> $size
>
>  for mode in off full falloc; do
>      echo
>      echo "== creating image with preallocation $mode =="
>      IMGOPTS=preallocation=$mode _make_test_img $size | _filter_imgfmt
> -    stat -c "size=%s, blocks=%b" $TEST_IMG
> +    stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks
> $size
>  done
>
>  # success, all done
> diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
> index 76c02c6a57..6d9a5ed84e 100644
> --- a/tests/qemu-iotests/175.out
> +++ b/tests/qemu-iotests/175.out
> @@ -2,17 +2,17 @@ QA output created by 175
>
>  == creating image with default preallocation ==
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
> -size=1048576, blocks=0
> +size=1048576, nothing allocated
>
>  == creating image with preallocation off ==
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=off
> -size=1048576, blocks=0
> +size=1048576, nothing allocated
>
>  == creating image with preallocation full ==
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=full
> -size=1048576, blocks=2048
> +size=1048576, everything allocated
>
>  == creating image with preallocation falloc ==
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
> preallocation=falloc
> -size=1048576, blocks=2048
> +size=1048576, everything allocated
>   *** done
> --
> 2.21.0


Reviewed-by: Nir Soffer <nsoffer@redhat.com>

>
