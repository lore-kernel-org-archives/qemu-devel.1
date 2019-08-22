Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6866EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF3A2339F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF3A2339F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0lMV-0001xP-D5
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1i0lIt-0007W1-7J
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1i0lIo-00043X-87
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:30:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1i0lIn-00042q-Ip
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:30:50 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 95F5BC05AA58
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 11:30:48 +0000 (UTC)
Received: by mail-ot1-f69.google.com with SMTP id x1so2949504oto.8
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 04:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pj6o1WBEIggwonL5BmsAF2tJBmF/keEMRhnRbTlTvKE=;
 b=uQI0r2N3aC2ZBn1WT0c0xrG02I8DJOtrv5AkQZw+D6ofjed+aozOr6Hciudeek0gW7
 VZniB4AJxevZ7ViAfouVlJcM9f7ra45A9ar+JpsQ8TppRxpjQqLBfNMknMr9weUYUX1G
 D6pqf39fN/nPfot9VW0ZE0KxTtQWp/ZdDsvmdY8ii0EuSFO5tSIQmzayKeTgC4cJ4x2+
 rdvsIxmCvM0uKnv8e/7945pAtK2k9HOyvWedKgPYfB/WrFxXMiheq/S+6XhLx38LlFbN
 eMayl/uA6DgfqcjeAVIdDUD87YXxJOh6Pi1kjYjDXwtzQw6Rbn0jsysg4+xTmHEyZE5x
 7NtA==
X-Gm-Message-State: APjAAAU5cU1fYp4BcDDqQfOFzSNYCyv0mo7ROYJn64vRLYBjPTLV/LCX
 z7YYHEaTCnTJI0BBTv33yEb0Z4UJ2aPP91K6s6Kh0vB1/aacs5SLkEjZ49KR6t6hbv+7N2TL5Ex
 3ir5OggnNA3swEgtX/BVQDNSFlqKL9So=
X-Received: by 2002:a9d:6303:: with SMTP id q3mr24841192otk.81.1566473447897; 
 Thu, 22 Aug 2019 04:30:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzY4/V7Pz/1stItAFFt+jkXdmSSYaycO3nk3jIYCsWaFEaXHJpdQM+r8SIxE3RqEvWPYybCYhenEjpzdbQeU9k=
X-Received: by 2002:a9d:6303:: with SMTP id q3mr24841168otk.81.1566473447529; 
 Thu, 22 Aug 2019 04:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190816212122.8816-1-nsoffer@redhat.com>
In-Reply-To: <20190816212122.8816-1-nsoffer@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 22 Aug 2019 14:30:36 +0300
Message-ID: <CAMRbyyuUtAOfdENsvb5+24z2Cr_K6=XPCLVsu3dhUwUb520x1w@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] block: posix: Always allocate the first
 block
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max, did you have time to look at this?

On Sat, Aug 17, 2019 at 12:21 AM Nir Soffer <nirsof@gmail.com> wrote:

> When creating an image with preallocation "off" or "falloc", the first
> block of the image is typically not allocated. When using Gluster
> storage backed by XFS filesystem, reading this block using direct I/O
> succeeds regardless of request length, fooling alignment detection.
>
> In this case we fallback to a safe value (4096) instead of the optimal
> value (512), which may lead to unneeded data copying when aligning
> requests.  Allocating the first block avoids the fallback.
>
> When using preallocation=off, we always allocate at least one filesystem
> block:
>
>     $ ./qemu-img create -f raw test.raw 1g
>     Formatting 'test.raw', fmt=raw size=1073741824
>
>     $ ls -lhs test.raw
>     4.0K -rw-r--r--. 1 nsoffer nsoffer 1.0G Aug 16 23:48 test.raw
>
> I did quick performance tests for these flows:
> - Provisioning a VM with a new raw image.
> - Copying disks with qemu-img convert to new raw target image
>
> I installed Fedora 29 server on raw sparse image, measuring the time
> from clicking "Begin installation" until the "Reboot" button appears:
>
> Before(s)  After(s)     Diff(%)
> -------------------------------
>      356        389        +8.4
>
> I ran this only once, so we cannot tell much from these results.
>
> The second test was cloning the installation image with qemu-img
> convert, doing 10 runs:
>
>     for i in $(seq 10); do
>         rm -f dst.raw
>         sleep 10
>         time ./qemu-img convert -f raw -O raw -t none -T none src.raw
> dst.raw
>     done
>
> Here is a table comparing the total time spent:
>
> Type    Before(s)   After(s)    Diff(%)
> ---------------------------------------
> real      530.028    469.123      -11.4
> user       17.204     10.768      -37.4
> sys        17.881      7.011      -60.7
>
> Here we see very clear improvement in CPU usage.
>
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>  block/file-posix.c         | 25 +++++++++++++++++++++++++
>  tests/qemu-iotests/150.out |  1 +
>  tests/qemu-iotests/160     |  4 ++++
>  tests/qemu-iotests/175     | 19 +++++++++++++------
>  tests/qemu-iotests/175.out |  8 ++++----
>  tests/qemu-iotests/221.out | 12 ++++++++----
>  tests/qemu-iotests/253.out | 12 ++++++++----
>  7 files changed, 63 insertions(+), 18 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index b9c33c8f6c..3964dd2021 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1755,6 +1755,27 @@ static int handle_aiocb_discard(void *opaque)
>      return ret;
>  }
>
> +/*
> + * Help alignment detection by allocating the first block.
> + *
> + * When reading with direct I/O from unallocated area on Gluster backed
> by XFS,
> + * reading succeeds regardless of request length. In this case we
> fallback to
> + * safe aligment which is not optimal. Allocating the first block avoids
> this
> + * fallback.
> + *
> + * Returns: 0 on success, -errno on failure.
> + */
> +static int allocate_first_block(int fd)
> +{
> +    ssize_t n;
> +
> +    do {
> +        n = pwrite(fd, "\0", 1, 0);
> +    } while (n == -1 && errno == EINTR);
> +
> +    return (n == -1) ? -errno : 0;
> +}
> +
>  static int handle_aiocb_truncate(void *opaque)
>  {
>      RawPosixAIOData *aiocb = opaque;
> @@ -1794,6 +1815,8 @@ static int handle_aiocb_truncate(void *opaque)
>                  /* posix_fallocate() doesn't set errno. */
>                  error_setg_errno(errp, -result,
>                                   "Could not preallocate new data");
> +            } else if (current_length == 0) {
> +                allocate_first_block(fd);
>              }
>          } else {
>              result = 0;
> @@ -1855,6 +1878,8 @@ static int handle_aiocb_truncate(void *opaque)
>          if (ftruncate(fd, offset) != 0) {
>              result = -errno;
>              error_setg_errno(errp, -result, "Could not resize file");
> +        } else if (current_length == 0 && offset > current_length) {
> +            allocate_first_block(fd);
>          }
>          return result;
>      default:
> diff --git a/tests/qemu-iotests/150.out b/tests/qemu-iotests/150.out
> index 2a54e8dcfa..3cdc7727a5 100644
> --- a/tests/qemu-iotests/150.out
> +++ b/tests/qemu-iotests/150.out
> @@ -3,6 +3,7 @@ QA output created by 150
>  === Mapping sparse conversion ===
>
>  Offset          Length          File
> +0               0x1000          TEST_DIR/t.IMGFMT
>
>  === Mapping non-sparse conversion ===
>
> diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
> index df89d3864b..ad2d054a47 100755
> --- a/tests/qemu-iotests/160
> +++ b/tests/qemu-iotests/160
> @@ -57,6 +57,10 @@ for skip in $TEST_SKIP_BLOCKS; do
>      $QEMU_IMG dd if="$TEST_IMG" of="$TEST_IMG.out" skip="$skip" -O
> "$IMGFMT" \
>          2> /dev/null
>      TEST_IMG="$TEST_IMG.out" _check_test_img
> +
> +    # We always write the first byte of an image.
> +    printf "\0" > "$TEST_IMG.out.dd"
> +
>      dd if="$TEST_IMG" of="$TEST_IMG.out.dd" skip="$skip" status=none
>
>      echo
> diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
> index 51e62c8276..c6a3a7bb1e 100755
> --- a/tests/qemu-iotests/175
> +++ b/tests/qemu-iotests/175
> @@ -37,14 +37,16 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  # the file size.  This function hides the resulting difference in the
>  # stat -c '%b' output.
>  # Parameter 1: Number of blocks an empty file occupies
> -# Parameter 2: Image size in bytes
> +# Parameter 2: Minimal number of blocks in an image
> +# Parameter 3: Image size in bytes
>  _filter_blocks()
>  {
>      extra_blocks=$1
> -    img_size=$2
> +    min_blocks=$2
> +    img_size=$3
>
> -    sed -e "s/blocks=$extra_blocks\\(\$\\|[^0-9]\\)/nothing allocated/" \
> -        -e "s/blocks=$((extra_blocks + img_size /
> 512))\\(\$\\|[^0-9]\\)/everything allocated/"
> +    sed -e "s/blocks=$((extra_blocks + min_blocks))\\(\$\\|[^0-9]\\)/min
> allocation/" \
> +        -e "s/blocks=$((extra_blocks + img_size /
> 512))\\(\$\\|[^0-9]\\)/max allocation/"
>  }
>
>  # get standard environment, filters and checks
> @@ -60,16 +62,21 @@ size=$((1 * 1024 * 1024))
>  touch "$TEST_DIR/empty"
>  extra_blocks=$(stat -c '%b' "$TEST_DIR/empty")
>
> +# We always write the first byte; check how many blocks this filesystem
> +# allocates to match empty image alloation.
> +printf "\0" > "$TEST_DIR/empty"
> +min_blocks=$(stat -c '%b' "$TEST_DIR/empty")
> +
>  echo
>  echo "== creating image with default preallocation =="
>  _make_test_img $size | _filter_imgfmt
> -stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks
> $size
> +stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks
> $min_blocks $size
>
>  for mode in off full falloc; do
>      echo
>      echo "== creating image with preallocation $mode =="
>      IMGOPTS=preallocation=$mode _make_test_img $size | _filter_imgfmt
> -    stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks
> $size
> +    stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks
> $min_blocks $size
>  done
>
>  # success, all done
> diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
> index 6d9a5ed84e..263e521262 100644
> --- a/tests/qemu-iotests/175.out
> +++ b/tests/qemu-iotests/175.out
> @@ -2,17 +2,17 @@ QA output created by 175
>
>  == creating image with default preallocation ==
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
> -size=1048576, nothing allocated
> +size=1048576, min allocation
>
>  == creating image with preallocation off ==
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=off
> -size=1048576, nothing allocated
> +size=1048576, min allocation
>
>  == creating image with preallocation full ==
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=full
> -size=1048576, everything allocated
> +size=1048576, max allocation
>
>  == creating image with preallocation falloc ==
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
> preallocation=falloc
> -size=1048576, everything allocated
> +size=1048576, max allocation
>   *** done
> diff --git a/tests/qemu-iotests/221.out b/tests/qemu-iotests/221.out
> index 9f9dd52bb0..dca024a0c3 100644
> --- a/tests/qemu-iotests/221.out
> +++ b/tests/qemu-iotests/221.out
> @@ -3,14 +3,18 @@ QA output created by 221
>  === Check mapping of unaligned raw image ===
>
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65537
> -[{ "start": 0, "length": 66048, "depth": 0, "zero": true, "data": false,
> "offset": OFFSET}]
> -[{ "start": 0, "length": 66048, "depth": 0, "zero": true, "data": false,
> "offset": OFFSET}]
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true,
> "offset": OFFSET},
> +{ "start": 4096, "length": 61952, "depth": 0, "zero": true, "data":
> false, "offset": OFFSET}]
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true,
> "offset": OFFSET},
> +{ "start": 4096, "length": 61952, "depth": 0, "zero": true, "data":
> false, "offset": OFFSET}]
>  wrote 1/1 bytes at offset 65536
>  1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 65536, "depth": 0, "zero": true, "data": false,
> "offset": OFFSET},
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true,
> "offset": OFFSET},
> +{ "start": 4096, "length": 61440, "depth": 0, "zero": true, "data":
> false, "offset": OFFSET},
>  { "start": 65536, "length": 1, "depth": 0, "zero": false, "data": true,
> "offset": OFFSET},
>  { "start": 65537, "length": 511, "depth": 0, "zero": true, "data": false,
> "offset": OFFSET}]
> -[{ "start": 0, "length": 65536, "depth": 0, "zero": true, "data": false,
> "offset": OFFSET},
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true,
> "offset": OFFSET},
> +{ "start": 4096, "length": 61440, "depth": 0, "zero": true, "data":
> false, "offset": OFFSET},
>  { "start": 65536, "length": 1, "depth": 0, "zero": false, "data": true,
> "offset": OFFSET},
>  { "start": 65537, "length": 511, "depth": 0, "zero": true, "data": false,
> "offset": OFFSET}]
>  *** done
> diff --git a/tests/qemu-iotests/253.out b/tests/qemu-iotests/253.out
> index 607c0baa0b..3d08b305d7 100644
> --- a/tests/qemu-iotests/253.out
> +++ b/tests/qemu-iotests/253.out
> @@ -3,12 +3,16 @@ QA output created by 253
>  === Check mapping of unaligned raw image ===
>
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048575
> -[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data":
> false, "offset": OFFSET}]
> -[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data":
> false, "offset": OFFSET}]
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true,
> "offset": OFFSET},
> +{ "start": 4096, "length": 1044480, "depth": 0, "zero": true, "data":
> false, "offset": OFFSET}]
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true,
> "offset": OFFSET},
> +{ "start": 4096, "length": 1044480, "depth": 0, "zero": true, "data":
> false, "offset": OFFSET}]
>  wrote 65535/65535 bytes at offset 983040
>  63.999 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 983040, "depth": 0, "zero": true, "data": false,
> "offset": OFFSET},
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true,
> "offset": OFFSET},
> +{ "start": 4096, "length": 978944, "depth": 0, "zero": true, "data":
> false, "offset": OFFSET},
>  { "start": 983040, "length": 65536, "depth": 0, "zero": false, "data":
> true, "offset": OFFSET}]
> -[{ "start": 0, "length": 983040, "depth": 0, "zero": true, "data": false,
> "offset": OFFSET},
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true,
> "offset": OFFSET},
> +{ "start": 4096, "length": 978944, "depth": 0, "zero": true, "data":
> false, "offset": OFFSET},
>  { "start": 983040, "length": 65536, "depth": 0, "zero": false, "data":
> true, "offset": OFFSET}]
>  *** done
> --
> 2.20.1
>
>
