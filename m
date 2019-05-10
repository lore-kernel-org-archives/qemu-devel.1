Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D95EC04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3476120989
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3476120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50449 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPDM2-0007kn-9U
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 17:46:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1hPDKb-000718-Hk
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1hPDKa-0005VZ-5w
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:45:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1hPDKZ-0005VI-Vl
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:45:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id g24so2351626otq.2
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 14:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=43NYLwxONwClH8AZ1JUyLaHaDe7yyRR4mnz83zjnBaU=;
	b=K6ZBNi161Z8L+KSfpod09ZXc3G3Ugsr/xXZ6MCBcQ5UXgYV4bRNxLq2R6hVIoWq+bN
	4mfLWB8UOUhEMcZ1J46zdsypQoXY0yvmw8h/ITowwt6vZuVBi1DD6jptnchvu6q2u+MO
	7ODM2gobuHeZDZcMjTp+ZBKuVGANWdOYmrBE2tTIMAzP3XQ0+FNusxqt235gH9sCQZ0D
	EXazgW4BVbE+O8vnF0z3FxsURW2MwxLqWbVEGiAee5PMv7b4chPz8bUM8/LuF2aOcmne
	ZH28GeulPQbPuHq3I1eWdohLhzgZv0xSqd2WejI751E5y68O949fRYu6caFko+jdzNTU
	FisA==
X-Gm-Message-State: APjAAAUTpjlogyXN5VfviSORK96IIdDjQEKSI6S+V5CxUqQdBpJy+Fkl
	ijHmgyrmfaJwy7pRHWq78AdD+RiYKODm6PchT5lkTw==
X-Google-Smtp-Source: APXvYqzgRLi0sSofV73+liDfsHh22wSs0Y4BGB2Ssig250BfJM7uXtgOiI7ZK+0ymrqY/MdyGlBTsE7HRPSIMn6DI4Q=
X-Received: by 2002:a9d:361:: with SMTP id 88mr8202852otv.361.1557524726824;
	Fri, 10 May 2019 14:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190510211954.29574-1-mreitz@redhat.com>
In-Reply-To: <20190510211954.29574-1-mreitz@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sat, 11 May 2019 00:45:13 +0300
Message-ID: <CAMRbyytDVz=tTgPKOxZNBR=suohjw6bi7EsP=u5682ZRCsHfag@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.65
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] iotests: Filter 175's allocation
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

On Sat, May 11, 2019 at 12:19 AM Max Reitz <mreitz@redhat.com> wrote:

> It is possible for an empty file to take up blocks on a filesystem.
> Make iotest 175 take this into account.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/175     | 15 +++++++++++----
>  tests/qemu-iotests/175.out |  8 ++++----
>  2 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
> index d0ffc495c2..b5652a3889 100755
> --- a/tests/qemu-iotests/175
> +++ b/tests/qemu-iotests/175
> @@ -28,7 +28,8 @@ status=1      # failure is the default!
>
>  _cleanup()
>  {
> -       _cleanup_test_img
> +    _cleanup_test_img
> +    rm -f "$TEST_DIR/empty"
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>
> @@ -40,18 +41,24 @@ _supported_fmt raw
>  _supported_proto file
>  _supported_os Linux
>
> -size=1m
> +size=$((1 * 1024 * 1024))

+
> +touch "$TEST_DIR/empty"
> +empty_blocks=$(stat -c '%b' "$TEST_DIR/empty")
>

Maybe extra_blocks?

 echo
>  echo "== creating image with default preallocation =="
>  _make_test_img $size | _filter_imgfmt
> -stat -c "size=%s, blocks=%b" $TEST_IMG
> +stat -c "size=%s, blocks=%b" $TEST_IMG \
> +    | sed -e "s/blocks=$empty_blocks/nothing allocated/"
>
>  for mode in off full falloc; do
>      echo
>      echo "== creating image with preallocation $mode =="
>      IMGOPTS=preallocation=$mode _make_test_img $size | _filter_imgfmt
> -    stat -c "size=%s, blocks=%b" $TEST_IMG
> +    stat -c "size=%s, blocks=%b" $TEST_IMG \
> +        | sed -e "s/blocks=$empty_blocks/nothing allocated/" \
> +        | sed -e "s/blocks=$((empty_blocks + size / 512))/everything
> allocated/"
>

"fully allocated"?

Maybe add a helper like this:

_filter_blocks() {
        # Some file systems sometimes allocate extra blocks
        sed -e "s/blocks=$empty_blocks/nothing allocated/" \
               -e "s/blocks=$((empty_blocks + size / 512))/everything
allocated/"
}

So we can do:

    stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks

And it is also clear why we need to run sed without looking up the commit
message.


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
>

Otherwise looks good.

Nir
