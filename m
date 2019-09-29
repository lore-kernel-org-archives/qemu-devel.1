Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C28AC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B5B217F5
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B5B217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEcF7-000717-9h
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 12:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc8R-00014c-Gx
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc8M-0003ZW-KA
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:33:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEc8A-0003KO-DO; Sun, 29 Sep 2019 12:33:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F8411DB6;
 Sun, 29 Sep 2019 16:33:05 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D12445D9C3;
 Sun, 29 Sep 2019 16:33:03 +0000 (UTC)
Message-ID: <e31504bf97e8944b9317546ebad75a669c6a2b90.camel@redhat.com>
Subject: Re: [PATCH 07/18] iotests: Replace IMGOPTS= by -o
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Sun, 29 Sep 2019 19:33:02 +0300
In-Reply-To: <20190927094242.11152-8-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-8-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Sun, 29 Sep 2019 16:33:05 +0000 (UTC)
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
> Tests should not overwrite all user-supplied image options, but only add
> to it (which will effectively overwrite conflicting values).  Accomplish
> this by passing options to _make_test_img via -o instead of $IMGOPTS.
> 
> For some tests, there is no functional change because they already only
> appended options to IMGOPTS.  For these, this patch is just a
> simplification.
> 
> For others, this is a change, so they now heed user-specified $IMGOPTS.
> Some of those tests do not work with all image options, though, so we
> need to disable them accordingly.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/031 |  9 ++++---
>  tests/qemu-iotests/039 | 24 ++++++------------
>  tests/qemu-iotests/059 | 18 ++++++-------
>  tests/qemu-iotests/060 |  6 ++---
>  tests/qemu-iotests/061 | 57 ++++++++++++++++++++++--------------------
>  tests/qemu-iotests/079 |  3 +--
>  tests/qemu-iotests/106 |  2 +-
>  tests/qemu-iotests/108 |  2 +-
>  tests/qemu-iotests/112 | 32 ++++++++++++------------
>  tests/qemu-iotests/115 |  3 +--
>  tests/qemu-iotests/121 |  6 ++---
>  tests/qemu-iotests/125 |  2 +-
>  tests/qemu-iotests/137 |  2 +-
>  tests/qemu-iotests/138 |  3 +--
>  tests/qemu-iotests/175 |  2 +-
>  tests/qemu-iotests/190 |  2 +-
>  tests/qemu-iotests/191 |  3 +--
>  tests/qemu-iotests/220 |  4 ++-
>  tests/qemu-iotests/243 |  6 +++--
>  tests/qemu-iotests/244 | 10 +++++---
>  tests/qemu-iotests/250 |  3 +--
>  tests/qemu-iotests/265 |  2 +-
>  22 files changed, 100 insertions(+), 101 deletions(-)
> 
> diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
> index a3c25ec237..c44fcf91bb 100755
> --- a/tests/qemu-iotests/031
> +++ b/tests/qemu-iotests/031
> @@ -40,19 +40,22 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  # This tests qcow2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto file
> +# We want to test compat=0.10, which does not support refcount widths
> +# other than 16
> +_unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)'
OK
>  
>  CLUSTER_SIZE=65536
>  
>  # qcow2.py output depends on the exact options used, so override the command
>  # line here as an exception
> -for IMGOPTS in "compat=0.10" "compat=1.1"; do
> +for compat in "compat=0.10" "compat=1.1"; do
>  
>      echo
> -    echo ===== Testing with -o $IMGOPTS =====
> +    echo ===== Testing with -o $compat =====
>      echo
>      echo === Create image with unknown header extension ===
>      echo
> -    _make_test_img 64M
> +    _make_test_img -o $compat 64M
>      $PYTHON qcow2.py "$TEST_IMG" add-header-ext 0x12345678 "This is a test header extension"
>      $PYTHON qcow2.py "$TEST_IMG" dump-header
>      _check_test_img
> diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
> index 325da63a4c..99563bf126 100755
> --- a/tests/qemu-iotests/039
> +++ b/tests/qemu-iotests/039
> @@ -50,8 +50,7 @@ size=128M
>  echo
>  echo "== Checking that image is clean on shutdown =="
>  
> -IMGOPTS="compat=1.1,lazy_refcounts=on"
> -_make_test_img $size
> +_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
Any reason for compat=1.1 here? Other that it was before like that.

>  
>  $QEMU_IO -c "write -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
>  
> @@ -62,8 +61,7 @@ _check_test_img
>  echo
>  echo "== Creating a dirty image file =="
>  
> -IMGOPTS="compat=1.1,lazy_refcounts=on"
> -_make_test_img $size
> +_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
>  
>  _NO_VALGRIND \
>  $QEMU_IO -c "write -P 0x5a 0 512" \
> @@ -98,8 +96,7 @@ $QEMU_IO -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
>  echo
>  echo "== Opening a dirty image read/write should repair it =="
>  
> -IMGOPTS="compat=1.1,lazy_refcounts=on"
> -_make_test_img $size
> +_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
>  
>  _NO_VALGRIND \
>  $QEMU_IO -c "write -P 0x5a 0 512" \
> @@ -117,8 +114,7 @@ $PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>  echo
>  echo "== Creating an image file with lazy_refcounts=off =="
>  
> -IMGOPTS="compat=1.1,lazy_refcounts=off"
> -_make_test_img $size
> +_make_test_img -o "compat=1.1,lazy_refcounts=off" $size
>  
>  _NO_VALGRIND \
>  $QEMU_IO -c "write -P 0x5a 0 512" \
> @@ -132,11 +128,9 @@ _check_test_img
>  echo
>  echo "== Committing to a backing file with lazy_refcounts=on =="
>  
> -IMGOPTS="compat=1.1,lazy_refcounts=on"
> -TEST_IMG="$TEST_IMG".base _make_test_img $size
> +TEST_IMG="$TEST_IMG".base _make_test_img -o "compat=1.1,lazy_refcounts=on" $size
>  
> -IMGOPTS="compat=1.1,lazy_refcounts=on,backing_file=$TEST_IMG.base"
> -_make_test_img $size
> +_make_test_img -o "compat=1.1,lazy_refcounts=on,backing_file=$TEST_IMG.base" $size
>  
>  $QEMU_IO -c "write 0 512" "$TEST_IMG" | _filter_qemu_io
>  $QEMU_IMG commit "$TEST_IMG"
> @@ -151,8 +145,7 @@ TEST_IMG="$TEST_IMG".base _check_test_img
>  echo
>  echo "== Changing lazy_refcounts setting at runtime =="
>  
> -IMGOPTS="compat=1.1,lazy_refcounts=off"
> -_make_test_img $size
> +_make_test_img -o "compat=1.1,lazy_refcounts=off" $size
>  
>  _NO_VALGRIND \
>  $QEMU_IO -c "reopen -o lazy-refcounts=on" \
> @@ -164,8 +157,7 @@ $QEMU_IO -c "reopen -o lazy-refcounts=on" \
>  $PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>  _check_test_img
>  
> -IMGOPTS="compat=1.1,lazy_refcounts=on"
> -_make_test_img $size
> +_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
>  
>  _NO_VALGRIND \
>  $QEMU_IO -c "reopen -o lazy-refcounts=off" \
> diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
> index 10bfbaecec..3941c3f0c2 100755
> --- a/tests/qemu-iotests/059
> +++ b/tests/qemu-iotests/059
> @@ -70,18 +70,18 @@ poke_file "$TEST_IMG" "$grain_table_size_offset" "\x01\x00\x00\x00"
>  
>  echo
>  echo "=== Testing monolithicFlat creation and opening ==="
> -IMGOPTS="subformat=monolithicFlat" _make_test_img 2G
> +_make_test_img -o "subformat=monolithicFlat" 2G
>  _img_info
>  _cleanup_test_img
>  
>  echo
>  echo "=== Testing monolithicFlat with zeroed_grain ==="
> -IMGOPTS="subformat=monolithicFlat,zeroed_grain=on" _make_test_img 2G
> +_make_test_img -o "subformat=monolithicFlat,zeroed_grain=on" 2G
>  _cleanup_test_img
>  
>  echo
>  echo "=== Testing big twoGbMaxExtentFlat ==="
> -IMGOPTS="subformat=twoGbMaxExtentFlat" _make_test_img 1000G
> +_make_test_img -o "subformat=twoGbMaxExtentFlat" 1000G
>  $QEMU_IMG info $TEST_IMG | _filter_testdir | sed -e 's/cid: [0-9]*/cid: XXXXXXXX/'
>  _cleanup_test_img
>  
> @@ -101,13 +101,13 @@ _img_info
>  
>  echo
>  echo "=== Testing truncated sparse ==="
> -IMGOPTS="subformat=monolithicSparse" _make_test_img 100G
> +_make_test_img -o "subformat=monolithicSparse" 100G
>  truncate -s 10M $TEST_IMG
>  _img_info
>  
>  echo
>  echo "=== Converting to streamOptimized from image with small cluster size==="
> -TEST_IMG="$TEST_IMG.qcow2" IMGFMT=qcow2 IMGOPTS="cluster_size=4096" _make_test_img 1G
> +TEST_IMG="$TEST_IMG.qcow2" IMGFMT=qcow2 _make_test_img -o "cluster_size=4096" 1G
>  $QEMU_IO -f qcow2 -c "write -P 0xa 0 512" "$TEST_IMG.qcow2" | _filter_qemu_io
>  $QEMU_IO -f qcow2 -c "write -P 0xb 10240 512" "$TEST_IMG.qcow2" | _filter_qemu_io
>  $QEMU_IMG convert -f qcow2 -O vmdk -o subformat=streamOptimized "$TEST_IMG.qcow2" "$TEST_IMG" 2>&1
> @@ -117,7 +117,7 @@ echo "=== Testing monolithicFlat with internally generated JSON file name ==="
>  
>  echo '--- blkdebug ---'
>  # Should work, because bdrv_dirname() works fine with blkdebug
> -IMGOPTS="subformat=monolithicFlat" _make_test_img 64M
> +_make_test_img -o "subformat=monolithicFlat" 64M
>  $QEMU_IO -c "open -o driver=$IMGFMT,file.driver=blkdebug,file.image.filename=$TEST_IMG,file.inject-error.0.event=read_aio" \
>           -c info \
>      2>&1 \
> @@ -126,7 +126,7 @@ _cleanup_test_img
>  
>  echo '--- quorum ---'
>  # Should not work, because bdrv_dirname() does not work with quorum
> -IMGOPTS="subformat=monolithicFlat" _make_test_img 64M
> +_make_test_img -o "subformat=monolithicFlat" 64M
>  cp "$TEST_IMG" "$TEST_IMG.orig"
>  
>  filename="json:{
> @@ -161,7 +161,7 @@ _cleanup_test_img
>  
>  echo
>  echo "=== Testing 4TB monolithicFlat creation and IO ==="
> -IMGOPTS="subformat=monolithicFlat" _make_test_img 4T
> +_make_test_img -o "subformat=monolithicFlat" 4T
>  _img_info
>  $QEMU_IO -c "write -P 0xa 900G 512" "$TEST_IMG" | _filter_qemu_io
>  $QEMU_IO -c "read -v 900G 1024" "$TEST_IMG" | _filter_qemu_io
> @@ -170,7 +170,7 @@ _cleanup_test_img
>  echo
>  echo "=== Testing qemu-img map on extents ==="
>  for fmt in monolithicSparse twoGbMaxExtentSparse; do
> -    IMGOPTS="subformat=$fmt" _make_test_img 31G
> +    _make_test_img -o "subformat=$fmt" 31G
>      $QEMU_IO -c "write 65024 1k" "$TEST_IMG" | _filter_qemu_io
>      $QEMU_IO -c "write 2147483136 1k" "$TEST_IMG" | _filter_qemu_io
>      $QEMU_IO -c "write 5G 1k" "$TEST_IMG" | _filter_qemu_io
> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
> index 9c2ef42522..92243c2edd 100755
> --- a/tests/qemu-iotests/060
> +++ b/tests/qemu-iotests/060
> @@ -158,7 +158,7 @@ $QEMU_IO -c 'write 0k 64k' "$BACKING_IMG" | _filter_qemu_io
>  # compat=0.10 is required in order to make the following discard actually
>  # unallocate the sector rather than make it a zero sector - we want COW, after
>  # all.
> -IMGOPTS='compat=0.10' _make_test_img -b "$BACKING_IMG" 1G
> +_make_test_img -o 'compat=0.10' -b "$BACKING_IMG" 1G
>  # Write two clusters, the second one enforces creation of an L2 table after
>  # the first data cluster.
>  $QEMU_IO -c 'write 0k 64k' -c 'write 512M 64k' "$TEST_IMG" | _filter_qemu_io
> @@ -398,7 +398,7 @@ echo
>  echo "=== Discarding a non-covered in-bounds refblock ==="
>  echo
>  
> -IMGOPTS='refcount_bits=1' _make_test_img 64M
> +_make_test_img -o 'refcount_bits=1' 64M
>  
>  # Pretend there's a refblock somewhere where there is no refblock to
>  # cover it (but the covering refblock has a valid index in the
> @@ -422,7 +422,7 @@ echo
>  echo "=== Discarding a refblock covered by an unaligned refblock ==="
>  echo
>  
> -IMGOPTS='refcount_bits=1' _make_test_img 64M
> +_make_test_img -o 'refcount_bits=1' 64M
>  
>  # Same as above
>  poke_file "$TEST_IMG" "$(($rt_offset+8))" "\x00\x00\x00\x10\x00\x00\x00\x00"
> diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
> index 4eac5b83bd..0480be0141 100755
> --- a/tests/qemu-iotests/061
> +++ b/tests/qemu-iotests/061
> @@ -41,11 +41,14 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
> +# Conversion between different compat versions can only really work
> +# with refcount_bits=16
> +_unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)'
>  
>  echo
>  echo "=== Testing version downgrade with zero expansion ==="
>  echo
> -IMGOPTS="compat=1.1,lazy_refcounts=on" _make_test_img 64M
> +_make_test_img -o "compat=1.1,lazy_refcounts=on" 64M
>  $QEMU_IO -c "write -z 0 128k" "$TEST_IMG" | _filter_qemu_io
>  $PYTHON qcow2.py "$TEST_IMG" dump-header
>  $QEMU_IMG amend -o "compat=0.10" "$TEST_IMG"
> @@ -56,7 +59,7 @@ _check_test_img
>  echo
>  echo "=== Testing version downgrade with zero expansion and 4K cache entries ==="
>  echo
> -IMGOPTS="compat=1.1,lazy_refcounts=on" _make_test_img 64M
> +_make_test_img -o "compat=1.1,lazy_refcounts=on" 64M
>  $QEMU_IO -c "write -z 0 128k" "$TEST_IMG" | _filter_qemu_io
>  $QEMU_IO -c "write -z 32M 128k" "$TEST_IMG" | _filter_qemu_io
>  $QEMU_IO -c map "$TEST_IMG" | _filter_qemu_io
> @@ -72,7 +75,7 @@ _check_test_img
>  echo
>  echo "=== Testing dirty version downgrade ==="
>  echo
> -IMGOPTS="compat=1.1,lazy_refcounts=on" _make_test_img 64M
> +_make_test_img -o "compat=1.1,lazy_refcounts=on" 64M
>  _NO_VALGRIND \
>  $QEMU_IO -c "write -P 0x2a 0 128k" -c flush \
>           -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 | _filter_qemu_io
> @@ -85,7 +88,7 @@ _check_test_img
>  echo
>  echo "=== Testing version downgrade with unknown compat/autoclear flags ==="
>  echo
> -IMGOPTS="compat=1.1" _make_test_img 64M
> +_make_test_img -o "compat=1.1" 64M
>  $PYTHON qcow2.py "$TEST_IMG" set-feature-bit compatible 42
>  $PYTHON qcow2.py "$TEST_IMG" set-feature-bit autoclear 42
>  $PYTHON qcow2.py "$TEST_IMG" dump-header
> @@ -96,7 +99,7 @@ _check_test_img
>  echo
>  echo "=== Testing version upgrade and resize ==="
>  echo
> -IMGOPTS="compat=0.10" _make_test_img 64M
> +_make_test_img -o "compat=0.10" 64M
>  $QEMU_IO -c "write -P 0x2a 42M 64k" "$TEST_IMG" | _filter_qemu_io
>  $PYTHON qcow2.py "$TEST_IMG" dump-header
>  $QEMU_IMG amend -o "compat=1.1,lazy_refcounts=on,size=128M" "$TEST_IMG"
> @@ -107,7 +110,7 @@ _check_test_img
>  echo
>  echo "=== Testing dirty lazy_refcounts=off ==="
>  echo
> -IMGOPTS="compat=1.1,lazy_refcounts=on" _make_test_img 64M
> +_make_test_img -o "compat=1.1,lazy_refcounts=on" 64M
>  _NO_VALGRIND \
>  $QEMU_IO -c "write -P 0x2a 0 128k" -c flush \
>           -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 | _filter_qemu_io
> @@ -120,8 +123,8 @@ _check_test_img
>  echo
>  echo "=== Testing backing file ==="
>  echo
> -IMGOPTS="compat=1.1" _make_test_img 64M
> -IMGOPTS="compat=1.1" TEST_IMG="$TEST_IMG.base" _make_test_img 64M
> +_make_test_img -o "compat=1.1" 64M
> +TEST_IMG="$TEST_IMG.base" _make_test_img -o "compat=1.1" 64M
>  $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG.base" | _filter_qemu_io
>  $QEMU_IO -c "read -P 0 0 128k" "$TEST_IMG" | _filter_qemu_io
>  $QEMU_IMG amend -o "backing_file=$TEST_IMG.base,backing_fmt=qcow2" "$TEST_IMG"
> @@ -131,7 +134,7 @@ _check_test_img
>  echo
>  echo "=== Testing invalid configurations ==="
>  echo
> -IMGOPTS="compat=0.10" _make_test_img 64M
> +_make_test_img -o "compat=0.10" 64M
>  $QEMU_IMG amend -o "lazy_refcounts=on" "$TEST_IMG"
>  $QEMU_IMG amend -o "compat=1.1" "$TEST_IMG" # actually valid
>  $QEMU_IMG amend -o "compat=0.10,lazy_refcounts=on" "$TEST_IMG"
> @@ -144,7 +147,7 @@ $QEMU_IMG amend -o "preallocation=on" "$TEST_IMG"
>  echo
>  echo "=== Testing correct handling of unset value ==="
>  echo
> -IMGOPTS="compat=1.1,cluster_size=1k" _make_test_img 64M
> +_make_test_img -o "compat=1.1,cluster_size=1k" 64M
>  echo "Should work:"
>  $QEMU_IMG amend -o "lazy_refcounts=on" "$TEST_IMG"
>  echo "Should not work:" # Just to know which of these tests actually fails
> @@ -153,7 +156,7 @@ $QEMU_IMG amend -o "cluster_size=64k" "$TEST_IMG"
>  echo
>  echo "=== Testing zero expansion on inactive clusters ==="
>  echo
> -IMGOPTS="compat=1.1" _make_test_img 64M
> +_make_test_img -o "compat=1.1" 64M
>  $QEMU_IO -c "write -z 0 128k" "$TEST_IMG" | _filter_qemu_io
>  $QEMU_IMG snapshot -c foo "$TEST_IMG"
>  $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG" | _filter_qemu_io
> @@ -167,7 +170,7 @@ $QEMU_IO -c "read -P 0 0 128k" "$TEST_IMG" | _filter_qemu_io
>  echo
>  echo "=== Testing zero expansion on shared L2 table ==="
>  echo
> -IMGOPTS="compat=1.1" _make_test_img 64M
> +_make_test_img -o "compat=1.1" 64M
>  $QEMU_IO -c "write -z 0 128k" "$TEST_IMG" | _filter_qemu_io
>  $QEMU_IMG snapshot -c foo "$TEST_IMG"
>  $QEMU_IMG amend -o "compat=0.10" "$TEST_IMG"
> @@ -180,9 +183,9 @@ $QEMU_IO -c "read -P 0 0 128k" "$TEST_IMG" | _filter_qemu_io
>  echo
>  echo "=== Testing zero expansion on backed image ==="
>  echo
> -IMGOPTS="compat=1.1" TEST_IMG="$TEST_IMG.base" _make_test_img 64M
> +TEST_IMG="$TEST_IMG.base" _make_test_img -o "compat=1.1" 64M
>  $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG.base" | _filter_qemu_io
> -IMGOPTS="compat=1.1" _make_test_img -b "$TEST_IMG.base" 64M
> +_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" 64M
>  $QEMU_IO -c "read -P 0x2a 0 128k" -c "write -z 0 64k" "$TEST_IMG" | _filter_qemu_io
>  $QEMU_IMG amend -o "compat=0.10" "$TEST_IMG"
>  _check_test_img
> @@ -191,9 +194,9 @@ $QEMU_IO -c "read -P 0 0 64k" -c "read -P 0x2a 64k 64k" "$TEST_IMG" | _filter_qe
>  echo
>  echo "=== Testing zero expansion on backed inactive clusters ==="
>  echo
> -IMGOPTS="compat=1.1" TEST_IMG="$TEST_IMG.base" _make_test_img 64M
> +TEST_IMG="$TEST_IMG.base" _make_test_img -o "compat=1.1" 64M
>  $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG.base" | _filter_qemu_io
> -IMGOPTS="compat=1.1" _make_test_img -b "$TEST_IMG.base" 64M
> +_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" 64M
>  $QEMU_IO -c "write -z 0 64k" "$TEST_IMG" | _filter_qemu_io
>  $QEMU_IMG snapshot -c foo "$TEST_IMG"
>  $QEMU_IO -c "write -P 0x42 0 128k" "$TEST_IMG" | _filter_qemu_io
> @@ -207,9 +210,9 @@ $QEMU_IO -c "read -P 0 0 64k" -c "read -P 0x2a 64k 64k" "$TEST_IMG" | _filter_qe
>  echo
>  echo "=== Testing zero expansion on backed image with shared L2 table ==="
>  echo
> -IMGOPTS="compat=1.1" TEST_IMG="$TEST_IMG.base" _make_test_img 64M
> +TEST_IMG="$TEST_IMG.base" _make_test_img -o "compat=1.1" 64M
>  $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG.base" | _filter_qemu_io
> -IMGOPTS="compat=1.1" _make_test_img -b "$TEST_IMG.base" 64M
> +_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" 64M
>  $QEMU_IO -c "write -z 0 128k" "$TEST_IMG" | _filter_qemu_io
>  $QEMU_IMG snapshot -c foo "$TEST_IMG"
>  $QEMU_IMG amend -o "compat=0.10" "$TEST_IMG"
> @@ -222,7 +225,7 @@ $QEMU_IO -c "read -P 0 0 128k" "$TEST_IMG" | _filter_qemu_io
>  echo
>  echo "=== Testing preallocated zero expansion on full image ==="
>  echo
> -IMGOPTS="compat=1.1" TEST_IMG="$TEST_IMG" _make_test_img 64M
> +TEST_IMG="$TEST_IMG" _make_test_img -o "compat=1.1" 64M
>  $QEMU_IO -c "write -P 0x2a 0 64M" "$TEST_IMG" -c "write -z 0 64M" | _filter_qemu_io
>  $QEMU_IMG amend -o "compat=0.10" "$TEST_IMG"
>  _check_test_img
> @@ -231,8 +234,8 @@ $QEMU_IO -c "read -P 0 0 64M" "$TEST_IMG" | _filter_qemu_io
>  echo
>  echo "=== Testing progress report without snapshot ==="
>  echo
> -IMGOPTS="compat=1.1" TEST_IMG="$TEST_IMG.base" _make_test_img 4G
> -IMGOPTS="compat=1.1" _make_test_img -b "$TEST_IMG.base" 4G
> +TEST_IMG="$TEST_IMG.base" _make_test_img -o "compat=1.1" 4G
> +_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" 4G
>  $QEMU_IO -c "write -z 0  64k" \
>           -c "write -z 1G 64k" \
>           -c "write -z 2G 64k" \
> @@ -243,8 +246,8 @@ _check_test_img
>  echo
>  echo "=== Testing progress report with snapshot ==="
>  echo
> -IMGOPTS="compat=1.1" TEST_IMG="$TEST_IMG.base" _make_test_img 4G
> -IMGOPTS="compat=1.1" _make_test_img -b "$TEST_IMG.base" 4G
> +TEST_IMG="$TEST_IMG.base" _make_test_img -o "compat=1.1" 4G
> +_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" 4G
>  $QEMU_IO -c "write -z 0  64k" \
>           -c "write -z 1G 64k" \
>           -c "write -z 2G 64k" \
> @@ -256,7 +259,7 @@ _check_test_img
>  echo
>  echo "=== Testing version downgrade with external data file ==="
>  echo
> -IMGOPTS="compat=1.1,data_file=$TEST_IMG.data" _make_test_img 64M
> +_make_test_img -o "compat=1.1,data_file=$TEST_IMG.data" 64M
>  $QEMU_IMG amend -o "compat=0.10" "$TEST_IMG"
>  _img_info --format-specific
>  _check_test_img
> @@ -264,11 +267,11 @@ _check_test_img
>  echo
>  echo "=== Try changing the external data file ==="
>  echo
> -IMGOPTS="compat=1.1" _make_test_img 64M
> +_make_test_img -o "compat=1.1" 64M
>  $QEMU_IMG amend -o "data_file=foo" "$TEST_IMG"
>  
>  echo
> -IMGOPTS="compat=1.1,data_file=$TEST_IMG.data" _make_test_img 64M
> +_make_test_img -o "compat=1.1,data_file=$TEST_IMG.data" 64M
>  $QEMU_IMG amend -o "data_file=foo" "$TEST_IMG"
>  _img_info --format-specific
>  TEST_IMG="data-file.filename=$TEST_IMG.data,file.filename=$TEST_IMG" _img_info --format-specific --image-opts
> @@ -281,7 +284,7 @@ TEST_IMG="data-file.filename=$TEST_IMG.data,file.filename=$TEST_IMG" _img_info -
>  echo
>  echo "=== Clearing and setting data-file-raw ==="
>  echo
> -IMGOPTS="compat=1.1,data_file=$TEST_IMG.data,data_file_raw=on" _make_test_img 64M
> +_make_test_img -o "compat=1.1,data_file=$TEST_IMG.data,data_file_raw=on" 64M
>  $QEMU_IMG amend -o "data_file_raw=on" "$TEST_IMG"
>  _img_info --format-specific
>  _check_test_img
> diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
> index 81f0c21f53..162355b29a 100755
> --- a/tests/qemu-iotests/079
> +++ b/tests/qemu-iotests/079
> @@ -44,8 +44,7 @@ echo
>  cluster_sizes="16384 32768 65536 131072 262144 524288 1048576 2097152 4194304"
>  
>  for s in $cluster_sizes; do
> -    IMGOPTS=$(_optstr_add "$IMGOPTS" "preallocation=metadata,cluster_size=$s") \
> -        _make_test_img 4G
> +    _make_test_img -o "preallocation=metadata,cluster_size=$s" 4G
>  done
>  
>  # success, all done
> diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
> index ac47eaa0f5..b5d1ec4078 100755
> --- a/tests/qemu-iotests/106
> +++ b/tests/qemu-iotests/106
> @@ -51,7 +51,7 @@ for create_mode in off falloc full; do
>          echo
>          echo "--- create_mode=$create_mode growth_mode=$growth_mode ---"
>  
> -        IMGOPTS="preallocation=$create_mode" _make_test_img ${CREATION_SIZE}K
> +        _make_test_img -o "preallocation=$create_mode" ${CREATION_SIZE}K
>          $QEMU_IMG resize -f "$IMGFMT" --preallocation=$growth_mode "$TEST_IMG" +${GROWTH_SIZE}K
>  
>          expected_size=0
> diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
> index 9c08172237..b0a6ae597b 100755
> --- a/tests/qemu-iotests/108
> +++ b/tests/qemu-iotests/108
> @@ -65,7 +65,7 @@ echo
>  echo '=== Repairing unreferenced data cluster in new refblock area ==='
>  echo
>  
> -IMGOPTS='cluster_size=512' _make_test_img 64M
> +_make_test_img -o 'cluster_size=512' 64M
>  # Allocate the first 128 kB in the image (first refblock)
>  $QEMU_IO -c 'write 0 0x1b200' "$TEST_IMG" | _filter_qemu_io
>  # should be 131072 == 0x20000
> diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
> index 706c10b600..6850225939 100755
> --- a/tests/qemu-iotests/112
> +++ b/tests/qemu-iotests/112
> @@ -53,20 +53,20 @@ echo '=== refcount_bits limits ==='
>  echo
>  
>  # Must be positive (non-zero)
> -IMGOPTS="$IMGOPTS,refcount_bits=0" _make_test_img 64M
> +_make_test_img -o "refcount_bits=0" 64M
>  # Must be positive (non-negative)
> -IMGOPTS="$IMGOPTS,refcount_bits=-1" _make_test_img 64M
> +_make_test_img -o "refcount_bits=-1" 64M
>  # May not exceed 64
> -IMGOPTS="$IMGOPTS,refcount_bits=128" _make_test_img 64M
> +_make_test_img -o "refcount_bits=128" 64M
>  # Must be a power of two
> -IMGOPTS="$IMGOPTS,refcount_bits=42" _make_test_img 64M
> +_make_test_img -o "refcount_bits=42" 64M
>  
>  # 1 is the minimum
> -IMGOPTS="$IMGOPTS,refcount_bits=1" _make_test_img 64M
> +_make_test_img -o "refcount_bits=1" 64M
>  print_refcount_bits
>  
>  # 64 is the maximum
> -IMGOPTS="$IMGOPTS,refcount_bits=64" _make_test_img 64M
> +_make_test_img -o "refcount_bits=64" 64M
>  print_refcount_bits
>  
>  # 16 is the default
> @@ -78,19 +78,19 @@ echo '=== refcount_bits and compat=0.10 ==='
>  echo
>  
>  # Should work
> -IMGOPTS="$IMGOPTS,compat=0.10,refcount_bits=16" _make_test_img 64M
> +_make_test_img -o "compat=0.10,refcount_bits=16" 64M
>  print_refcount_bits
>  
>  # Should not work
> -IMGOPTS="$IMGOPTS,compat=0.10,refcount_bits=1" _make_test_img 64M
> -IMGOPTS="$IMGOPTS,compat=0.10,refcount_bits=64" _make_test_img 64M
> +_make_test_img -o "compat=0.10,refcount_bits=1" 64M
> +_make_test_img -o "compat=0.10,refcount_bits=64" 64M
>  
>  
>  echo
>  echo '=== Snapshot limit on refcount_bits=1 ==='
>  echo
>  
> -IMGOPTS="$IMGOPTS,refcount_bits=1" _make_test_img 64M
> +_make_test_img -o "refcount_bits=1" 64M
>  print_refcount_bits
>  
>  $QEMU_IO -c 'write 0 512' "$TEST_IMG" | _filter_qemu_io
> @@ -106,7 +106,7 @@ echo
>  echo '=== Snapshot limit on refcount_bits=2 ==='
>  echo
>  
> -IMGOPTS="$IMGOPTS,refcount_bits=2" _make_test_img 64M
> +_make_test_img -o "refcount_bits=2" 64M
>  print_refcount_bits
>  
>  $QEMU_IO -c 'write 0 512' "$TEST_IMG" | _filter_qemu_io
> @@ -124,7 +124,7 @@ echo
>  echo '=== Compressed clusters with refcount_bits=1 ==='
>  echo
>  
> -IMGOPTS="$IMGOPTS,refcount_bits=1" _make_test_img 64M
> +_make_test_img -o "refcount_bits=1" 64M
>  print_refcount_bits
>  
>  # Both should fit into a single host cluster; instead of failing to increase the
> @@ -140,7 +140,7 @@ echo
>  echo '=== MSb set in 64 bit refcount ==='
>  echo
>  
> -IMGOPTS="$IMGOPTS,refcount_bits=64" _make_test_img 64M
> +_make_test_img -o "refcount_bits=64" 64M
>  print_refcount_bits
>  
>  $QEMU_IO -c 'write 0 512' "$TEST_IMG" | _filter_qemu_io
> @@ -158,7 +158,7 @@ echo
>  echo '=== Snapshot on maximum 64 bit refcount value ==='
>  echo
>  
> -IMGOPTS="$IMGOPTS,refcount_bits=64" _make_test_img 64M
> +_make_test_img -o "refcount_bits=64" 64M
>  print_refcount_bits
>  
>  $QEMU_IO -c 'write 0 512' "$TEST_IMG" | _filter_qemu_io
> @@ -239,7 +239,7 @@ echo
>  echo '=== Testing too many references for check ==='
>  echo
>  
> -IMGOPTS="$IMGOPTS,refcount_bits=1" _make_test_img 64M
> +_make_test_img -o "refcount_bits=1" 64M
>  print_refcount_bits
>  
>  # This cluster should be created at 0x50000
> @@ -262,7 +262,7 @@ echo
>  echo '=== Multiple walks necessary during amend ==='
>  echo
>  
> -IMGOPTS="$IMGOPTS,refcount_bits=1,cluster_size=512" _make_test_img 64k
> +_make_test_img -o "refcount_bits=1,cluster_size=512" 64k
>  
>  # Cluster 0 is the image header, clusters 1 to 4 are used by the L1 table, a
>  # single L2 table, the reftable and a single refblock. This creates 58 data
> diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
> index 9ed3cb6a83..d254b18342 100755
> --- a/tests/qemu-iotests/115
> +++ b/tests/qemu-iotests/115
> @@ -64,8 +64,7 @@ echo
>  # least 256 MB. We can achieve that by using preallocation=metadata for an image
>  # which has a guest disk size of 256 MB.
>  
> -IMGOPTS="$IMGOPTS,refcount_bits=64,cluster_size=512,preallocation=metadata" \
> -    _make_test_img 256M
> +_make_test_img -o "refcount_bits=64,cluster_size=512,preallocation=metadata" 256M
>  
>  # We know for sure that the L1 and refcount tables do not overlap with any other
>  # structure because the metadata overlap checks would have caught that case.
> diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
> index 90a0424edb..10db813d94 100755
> --- a/tests/qemu-iotests/121
> +++ b/tests/qemu-iotests/121
> @@ -50,7 +50,7 @@ echo
>  # Preallocation speeds up the write operation, but preallocating everything will
>  # destroy the purpose of the write; so preallocate one KB less than what would
>  # cause a reftable growth...
> -IMGOPTS='preallocation=metadata,cluster_size=1k' _make_test_img 64512K
> +_make_test_img -o 'preallocation=metadata,cluster_size=1k' 64512K
>  # ...and make the image the desired size afterwards.
>  $QEMU_IMG resize "$TEST_IMG" 65M
>  
> @@ -73,7 +73,7 @@ echo
>  echo '--- Test 2 ---'
>  echo
>  
> -IMGOPTS='preallocation=metadata,cluster_size=1k' _make_test_img 64513K
> +_make_test_img -o 'preallocation=metadata,cluster_size=1k' 64513K
>  # This results in an L1 table growth which in turn results in some clusters at
>  # the start of the image becoming free
>  $QEMU_IMG resize "$TEST_IMG" 65M
> @@ -96,7 +96,7 @@ echo
>  echo '=== Allocating a new refcount block must not leave holes in the image ==='
>  echo
>  
> -IMGOPTS='cluster_size=512,refcount_bits=16' _make_test_img 1M
> +_make_test_img -o 'cluster_size=512,refcount_bits=16' 1M
>  
>  # This results in an image with 256 used clusters: the qcow2 header,
>  # the refcount table, one refcount block, the L1 table, four L2 tables
> diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
> index 4e31aa4e5f..d510984045 100755
> --- a/tests/qemu-iotests/125
> +++ b/tests/qemu-iotests/125
> @@ -114,7 +114,7 @@ for GROWTH_SIZE in 16 48 80; do
>          for growth_mode in off metadata falloc full; do
>              echo "--- cluster_size=$cluster_size growth_size=$GROWTH_SIZE create_mode=$create_mode growth_mode=$growth_mode ---"
>  
> -            IMGOPTS="preallocation=$create_mode,cluster_size=$cluster_size" _make_test_img ${CREATION_SIZE}
> +            _make_test_img -o "preallocation=$create_mode,cluster_size=$cluster_size" ${CREATION_SIZE}
>              $QEMU_IMG resize -f "$IMGFMT" --preallocation=$growth_mode "$TEST_IMG" +${GROWTH_SIZE}K
>  
>              host_size_0=$(get_image_size_on_host)
> diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
> index 089821da0c..6cf2997577 100755
> --- a/tests/qemu-iotests/137
> +++ b/tests/qemu-iotests/137
> @@ -117,7 +117,7 @@ $QEMU_IO \
>      -c "reopen -o cache-clean-interval=-1" \
>      "$TEST_IMG" | _filter_qemu_io
>  
> -IMGOPTS="cluster_size=256k" _make_test_img 32P
> +_make_test_img -o "cluster_size=256k" 32P
>  $QEMU_IO \
>      -c "reopen -o l2-cache-entry-size=512,l2-cache-size=1T" \
>      "$TEST_IMG" | _filter_qemu_io
> diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
> index 6a731370db..66ae9d5e78 100755
> --- a/tests/qemu-iotests/138
> +++ b/tests/qemu-iotests/138
> @@ -45,8 +45,7 @@ echo
>  echo '=== Check on an image with a multiple of 2^32 clusters ==='
>  echo
>  
> -IMGOPTS=$(_optstr_add "$IMGOPTS" "cluster_size=512") \
> -    _make_test_img 512
> +_make_test_img -o "cluster_size=512" 512
>  
>  # Allocate L2 table
>  $QEMU_IO -c 'write 0 512' "$TEST_IMG" | _filter_qemu_io
> diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
> index 55db2803ed..020ed8e61f 100755
> --- a/tests/qemu-iotests/175
> +++ b/tests/qemu-iotests/175
> @@ -95,7 +95,7 @@ stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $min_block
>  for mode in off full falloc; do
>      echo
>      echo "== creating image with preallocation $mode =="
> -    IMGOPTS=preallocation=$mode _make_test_img $size | _filter_imgfmt
> +    _make_test_img -o preallocation=$mode $size | _filter_imgfmt
>      stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $min_blocks $size
>  done
>  
> diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
> index eb766ad09f..5890ff9cfc 100755
> --- a/tests/qemu-iotests/190
> +++ b/tests/qemu-iotests/190
> @@ -45,7 +45,7 @@ _supported_proto file
>  echo "== Huge file =="
>  echo
>  
> -IMGOPTS='cluster_size=2M' _make_test_img 2T
> +_make_test_img -o 'cluster_size=2M' 2T
>  
>  $QEMU_IMG measure -O raw -f qcow2 "$TEST_IMG"
>  $QEMU_IMG measure -O qcow2 -o cluster_size=64k -f qcow2 "$TEST_IMG"
> diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
> index 528022e8d8..21c16a32cb 100755
> --- a/tests/qemu-iotests/191
> +++ b/tests/qemu-iotests/191
> @@ -51,8 +51,7 @@ echo === Preparing and starting VM ===
>  echo
>  
>  TEST_IMG="${TEST_IMG}.base" _make_test_img $size
> -IMGOPTS=$(_optstr_add "$IMGOPTS" "backing_fmt=$IMGFMT") \
> -    TEST_IMG="${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base"
> +TEST_IMG="${TEST_IMG}.mid" _make_test_img -o "backing_fmt=$IMGFMT" -b "${TEST_IMG}.base"
>  _make_test_img -b "${TEST_IMG}.mid"
>  TEST_IMG="${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid"
>  
> diff --git a/tests/qemu-iotests/220 b/tests/qemu-iotests/220
> index 2d62c5dcac..3769f372cb 100755
> --- a/tests/qemu-iotests/220
> +++ b/tests/qemu-iotests/220
> @@ -37,6 +37,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
> +# To use a different refcount width but 16 bits we need compat=1.1
> +_unsupported_imgopts 'compat=0.10'
>  
>  echo "== Creating huge file =="
>  
> @@ -46,7 +48,7 @@ if ! truncate --size=513T "$TEST_IMG"; then
>      _notrun "file system on $TEST_DIR does not support large enough files"
>  fi
>  rm "$TEST_IMG"
> -IMGOPTS='cluster_size=2M,refcount_bits=1' _make_test_img 513T
> +_make_test_img -o 'cluster_size=2M,refcount_bits=1' 513T
>  
>  echo "== Populating refcounts =="
>  # We want an image with 256M refcounts * 2M clusters = 512T referenced.
> diff --git a/tests/qemu-iotests/243 b/tests/qemu-iotests/243
> index e563761307..2b84b896db 100755
> --- a/tests/qemu-iotests/243
> +++ b/tests/qemu-iotests/243
> @@ -40,6 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
> +# External data files do not work with compat=0.10
> +_unsupported_imgopts 'compat=0.10'
>  
>  for mode in off metadata falloc full; do
>  
> @@ -47,7 +49,7 @@ for mode in off metadata falloc full; do
>      echo "=== preallocation=$mode ==="
>      echo
>  
> -    IMGOPTS="preallocation=$mode" _make_test_img 64M
> +    _make_test_img -o "preallocation=$mode" 64M
>  
>      printf "File size: "
>      du -b $TEST_IMG | cut -f1
> @@ -64,7 +66,7 @@ for mode in off metadata falloc full; do
>      echo "=== External data file: preallocation=$mode ==="
>      echo
>  
> -    IMGOPTS="data_file=$TEST_IMG.data,preallocation=$mode" _make_test_img 64M
> +    _make_test_img -o "data_file=$TEST_IMG.data,preallocation=$mode" 64M
>  
>      echo -n "qcow2 file size: "
>      du -b $TEST_IMG | cut -f1
> diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
> index 13978f93d2..0375bc12d4 100755
> --- a/tests/qemu-iotests/244
> +++ b/tests/qemu-iotests/244
> @@ -41,13 +41,15 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
> +# External data files do not work with compat=0.10
> +_unsupported_imgopts 'compat=0.10'
>  
>  echo
>  echo "=== Create and open image with external data file ==="
>  echo
>  
>  echo "With data file name in the image:"
> -IMGOPTS="data_file=$TEST_IMG.data" _make_test_img 64M
> +_make_test_img -o "data_file=$TEST_IMG.data" 64M
>  _check_test_img
>  
>  $QEMU_IO -c "open $TEST_IMG" -c "read -P 0 0 64k" 2>&1 | _filter_qemu_io | _filter_testdir
> @@ -104,7 +106,7 @@ echo
>  echo "=== Standalone image with external data file (efficient) ==="
>  echo
>  
> -IMGOPTS="data_file=$TEST_IMG.data" _make_test_img 64M
> +_make_test_img -o "data_file=$TEST_IMG.data" 64M
>  
>  echo -n "qcow2 file size before I/O: "
>  du -b $TEST_IMG | cut -f1
> @@ -154,7 +156,7 @@ echo
>  echo "=== Standalone image with external data file (valid raw) ==="
>  echo
>  
> -IMGOPTS="data_file=$TEST_IMG.data,data_file_raw=on" _make_test_img 64M
> +_make_test_img -o "data_file=$TEST_IMG.data,data_file_raw=on" 64M
>  
>  echo -n "qcow2 file size before I/O: "
>  du -b $TEST_IMG | cut -f1
> @@ -187,7 +189,7 @@ echo
>  echo "=== bdrv_co_block_status test for file and offset=0 ==="
>  echo
>  
> -IMGOPTS="data_file=$TEST_IMG.data" _make_test_img 64M
> +_make_test_img -o "data_file=$TEST_IMG.data" 64M
>  
>  $QEMU_IO -c 'write -P 0x11 0 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
>  $QEMU_IO -c 'read -P 0x11 0 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
> diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
> index c9c0a84a5a..670cf19076 100755
> --- a/tests/qemu-iotests/250
> +++ b/tests/qemu-iotests/250
> @@ -55,9 +55,8 @@ disk_usage()
>  }
>  
>  size=2100M
> -IMGOPTS="cluster_size=1M,preallocation=metadata"
>  
> -_make_test_img $size
> +_make_test_img -o "cluster_size=1M,preallocation=metadata" $size
>  $QEMU_IO -c 'discard 0 10M' -c 'discard 2090M 10M' \
>           -c 'write 2090M 10M' -c 'write 0 10M' "$TEST_IMG" | _filter_qemu_io
>  
> diff --git a/tests/qemu-iotests/265 b/tests/qemu-iotests/265
> index dce6f77be3..00f2ec769e 100755
> --- a/tests/qemu-iotests/265
> +++ b/tests/qemu-iotests/265
> @@ -41,7 +41,7 @@ _supported_os Linux
>  echo '--- Writing to the image ---'
>  
>  # Reduce cluster size so we get more and quicker I/O
> -IMGOPTS='cluster_size=4096' _make_test_img 1M
> +_make_test_img -o 'cluster_size=4096' 1M
>  (for ((kb = 1024 - 4; kb >= 0; kb -= 4)); do \
>       echo "aio_write -P 42 $((kb + 1))k 2k"; \
>   done) \



Looks all right, but the patch is large, and I might have missed something.
I don't know the iotests well enough to be sure.

Best regards,
	Maxim Levitsky


