Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C3BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CC022482
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RexeZyLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CC022482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxX5Q-0007SI-94
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jxX4f-0006wk-7M
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:47:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38498
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jxX4b-0007NT-Kb
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595256440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gvkPQs5BjOgOz4GKlt9oJo+Jw6vzamcmygUjzgRGWlY=;
 b=RexeZyLXngW/UhgOoyDd9Z7zHwMsvIOOATEi67rqTFAVrIkAN6ATzIbdxpM8K4GIfGmBxO
 c1ah3wgeO8CdgXYZD+oe0qLKvEu9A96mcfwuChWsHkkamypvK662lsG6rC667lygAbpYQq
 /B9pwiBfxNrI6dLMpCErZovZmiovXho=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-9nWgdXubOfOpZGBMNRcBug-1; Mon, 20 Jul 2020 10:47:18 -0400
X-MC-Unique: 9nWgdXubOfOpZGBMNRcBug-1
Received: by mail-ot1-f72.google.com with SMTP id b22so8277078otp.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 07:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gvkPQs5BjOgOz4GKlt9oJo+Jw6vzamcmygUjzgRGWlY=;
 b=bCLjPpnYnmQnolOnDZ8oO0gpSBnARV9DSqi64Dur7UjNtThOx1pCnJbt0b71CHzhDy
 3lMA4JACYCe7tc+EQNXDQymYmeuVQzS2AkYK2EHKOOWFTe373fd7o+zaNPOKftKpGv0N
 20wBYn9h3aiieHTNUY3nhWnrcfO31NLMttb9xNX7zBtvAJ3a8oYljWShLGpT3nMUOYcy
 dWtRNIswiozubZ8X6ZemH3+HGtv4JdzQVJ0Ytn76ja8qqnB15Qp9rzixb25mSTg5+x/j
 sYF6iaN9ugmJLVK3Qp5yeOh1XLIICdiI1pXF07vlcSbliteH9qnFmVDFFCNfJZNBPEMY
 0aIw==
X-Gm-Message-State: AOAM532RJWKGCqtjBEABOZA6LALRd/ZoHv619s2gRiYthOYzXpn9xbXq
 L5d4iLdn2ggoyVpbE8Z7rRWibomTMsH/arklGjPrFHvFZmzvGDXEVClWJ9+oLNWnZ1SoXZAvwaj
 r9JSKPwzjgJAdEwdjv/E0p13sJf+IzT0=
X-Received: by 2002:aca:5350:: with SMTP id h77mr16969438oib.156.1595256437366; 
 Mon, 20 Jul 2020 07:47:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWuVFWY6UX2/S60dJ7FZxH/IO7V5yjPbIL4v6C3qT3esjzIyDg4eJmF116PU5V2wKIWx6elg9JxkEnCbf+NZM=
X-Received: by 2002:aca:5350:: with SMTP id h77mr16969417oib.156.1595256436959; 
 Mon, 20 Jul 2020 07:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200720131810.177978-1-kwolf@redhat.com>
 <20200720131810.177978-3-kwolf@redhat.com>
In-Reply-To: <20200720131810.177978-3-kwolf@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 20 Jul 2020 17:47:00 +0300
Message-ID: <CAMRbyyswk69PWmpAB3isGDrsbBuVwchhsFGNhiPx2PD3eezPOA@mail.gmail.com>
Subject: Re: [PATCH for-5.1 2/2] iotests: Test sparseness for qemu-img convert
 -n
To: Kevin Wolf <kwolf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 4:18 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/122     | 34 ++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/122.out | 17 +++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
> index dfd1cd05d6..1112fc0730 100755
> --- a/tests/qemu-iotests/122
> +++ b/tests/qemu-iotests/122
> @@ -281,6 +281,40 @@ $QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
>
>  $QEMU_IMG compare "$TEST_IMG" "$TEST_IMG".orig
>
> +echo
> +echo '=== -n to an empty image ==='
> +echo
> +
> +_make_test_img 64M

Why make a test image here? We create it again below twice

> +
> +# Convert with -n, which should not result in a fully allocated image, not even
> +# with compat=0.10 (because the target doesn't have a backing file)
> +TEST_IMG="$TEST_IMG".orig _make_test_img -o compat=1.1 64M
> +$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
> +$QEMU_IMG map --output=json "$TEST_IMG".orig

This looks reversed - "$TEST_IMG".orig is the original image, and "$TEST_IMG"
is the target image. So maybe use "$TEST_IMG".target?

> +
> +TEST_IMG="$TEST_IMG".orig _make_test_img -o compat=0.10 64M
> +$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
> +$QEMU_IMG map --output=json "$TEST_IMG".orig

Since the only difference is the compat, why not use a loop?

for compat in 0.10 1.1; do
...

> +
> +echo
> +echo '=== -n to an empty image with a backing file ==='
> +echo
> +
> +_make_test_img 64M
> +TEST_IMG="$TEST_IMG".base _make_test_img 64M
> +
> +# Convert with -n, which should still not result in a fully allocated image for
> +# compat=1.1 (because it can use zero clusters), but it should be fully
> +# allocated with compat=0.10
> +TEST_IMG="$TEST_IMG".orig _make_test_img -b "$TEST_IMG".base -F $IMGFMT -o compat=1.1 64M
> +$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
> +$QEMU_IMG map --output=json "$TEST_IMG".orig

Do we have a real use case for this convert? Doesn't this hide all the
data in the
backing file by data from source?

Assuming source is:

src-top: A0--
dst-bas: --B0

And destination is:

dst-top: ----
dst-bas: CCCC

After the convert we will have:

dst-top: A0B0
dst-bas: CCCC

So entire backing of dst is hidden.

Nir

> +TEST_IMG="$TEST_IMG".orig _make_test_img -b "$TEST_IMG".base -F $IMGFMT -o compat=0.10 64M
> +$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
> +$QEMU_IMG map --output=json "$TEST_IMG".orig
> +
>  echo
>  echo '=== -n -B to an image without a backing file ==='
>  echo
> diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
> index f1f195ed77..b8028efb1d 100644
> --- a/tests/qemu-iotests/122.out
> +++ b/tests/qemu-iotests/122.out
> @@ -229,6 +229,23 @@ wrote 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  Images are identical.
>
> +=== -n to an empty image ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=67108864
> +[{ "start": 0, "length": 67108864, "depth": 0, "zero": true, "data": false}]
> +Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=67108864
> +[{ "start": 0, "length": 67108864, "depth": 0, "zero": true, "data": false}]
> +
> +=== -n to an empty image with a backing file ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
> +Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
> +[{ "start": 0, "length": 67108864, "depth": 0, "zero": true, "data": false}]
> +Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
> +[{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "data": true, "offset": 327680}]
> +
>  === -n -B to an image without a backing file ===
>
>  Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
> --
> 2.25.4
>


