Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77124C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 21:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22130206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 21:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22130206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hykER-0002ki-B0
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 17:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hykDj-0002Gk-BL
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 17:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hykDh-0008WM-6p
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 17:57:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hykDc-0008Uf-U9; Fri, 16 Aug 2019 17:57:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 194EF81DF2;
 Fri, 16 Aug 2019 21:57:07 +0000 (UTC)
Received: from [10.18.17.187] (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56DA418668;
 Fri, 16 Aug 2019 21:57:06 +0000 (UTC)
To: Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org
References: <20190816212122.8816-1-nsoffer@redhat.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b24959b4-f2b2-d720-f8b5-4adc25b89278@redhat.com>
Date: Fri, 16 Aug 2019 17:57:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816212122.8816-1-nsoffer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 16 Aug 2019 21:57:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: posix: Always allocate
 the first block
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/16/19 5:21 PM, Nir Soffer wrote:
> When creating an image with preallocation "off" or "falloc", the first
> block of the image is typically not allocated. When using Gluster
> storage backed by XFS filesystem, reading this block using direct I/O
> succeeds regardless of request length, fooling alignment detection.
> 
> In this case we fallback to a safe value (4096) instead of the optimal
> value (512), which may lead to unneeded data copying when aligning
> requests.  Allocating the first block avoids the fallback.
> 

Where does this detection/fallback happen? (Can it be improved?)

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

That seems like a pretty big difference for just having pre-allocated a
single block. What was the actual command line / block graph for that test?

Was this over a network that could explain the variance?

> The second test was cloning the installation image with qemu-img
> convert, doing 10 runs:
> 
>     for i in $(seq 10); do
>         rm -f dst.raw
>         sleep 10
>         time ./qemu-img convert -f raw -O raw -t none -T none src.raw dst.raw
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

Hard to argue much with that. I feel a little strange trying to force
the allocation of the first block, but I suppose in practice "almost no
preallocation" is indistinguishable from "exactly no preallocation" if
you squint.

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
> + * When reading with direct I/O from unallocated area on Gluster backed by XFS,
> + * reading succeeds regardless of request length. In this case we fallback to
> + * safe aligment which is not optimal. Allocating the first block avoids this
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
>      $QEMU_IMG dd if="$TEST_IMG" of="$TEST_IMG.out" skip="$skip" -O "$IMGFMT" \
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
> -        -e "s/blocks=$((extra_blocks + img_size / 512))\\(\$\\|[^0-9]\\)/everything allocated/"
> +    sed -e "s/blocks=$((extra_blocks + min_blocks))\\(\$\\|[^0-9]\\)/min allocation/" \
> +        -e "s/blocks=$((extra_blocks + img_size / 512))\\(\$\\|[^0-9]\\)/max allocation/"
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
> -stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $size
> +stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $min_blocks $size
>  
>  for mode in off full falloc; do
>      echo
>      echo "== creating image with preallocation $mode =="
>      IMGOPTS=preallocation=$mode _make_test_img $size | _filter_imgfmt
> -    stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $size
> +    stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $min_blocks $size
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
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=falloc
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
> -[{ "start": 0, "length": 66048, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
> -[{ "start": 0, "length": 66048, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
> +{ "start": 4096, "length": 61952, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
> +{ "start": 4096, "length": 61952, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
>  wrote 1/1 bytes at offset 65536
>  1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 65536, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
> +{ "start": 4096, "length": 61440, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
>  { "start": 65536, "length": 1, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
>  { "start": 65537, "length": 511, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
> -[{ "start": 0, "length": 65536, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
> +{ "start": 4096, "length": 61440, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
>  { "start": 65536, "length": 1, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
>  { "start": 65537, "length": 511, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
>  *** done
> diff --git a/tests/qemu-iotests/253.out b/tests/qemu-iotests/253.out
> index 607c0baa0b..3d08b305d7 100644
> --- a/tests/qemu-iotests/253.out
> +++ b/tests/qemu-iotests/253.out
> @@ -3,12 +3,16 @@ QA output created by 253
>  === Check mapping of unaligned raw image ===
>  
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048575
> -[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
> -[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
> +{ "start": 4096, "length": 1044480, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
> +{ "start": 4096, "length": 1044480, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
>  wrote 65535/65535 bytes at offset 983040
>  63.999 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 983040, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
> +{ "start": 4096, "length": 978944, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
>  { "start": 983040, "length": 65536, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
> -[{ "start": 0, "length": 983040, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
> +[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
> +{ "start": 4096, "length": 978944, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
>  { "start": 983040, "length": 65536, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
>  *** done
> 

