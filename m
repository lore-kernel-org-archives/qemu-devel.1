Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F77FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 18:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45FC20899
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 18:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SL9pi90A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45FC20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je0qI-0002lj-1J
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 14:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1je0on-00021v-KO
 for qemu-devel@nongnu.org; Wed, 27 May 2020 14:30:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53060
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1je0ok-0003PG-Pm
 for qemu-devel@nongnu.org; Wed, 27 May 2020 14:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590604216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/BtClsDUYoQMlsHrFQYWzyalWYUj/sszP5ezPK2xMr0=;
 b=SL9pi90A1XR41VzPFPb0KeoS5/XDwUy5B+pmoO5/awd+EvgHOGMNFJ2EsUq9Hk04apBPQ4
 LJk26ui3xGtZcYR/nmrdOjqzdUlLWCmwoevipVswHBliQYzb9KQ0xDFHVKZuwB1YWxvLrD
 /xagYprlEwg7xxAeKO+gY8+Ep1W9MMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-IrBTxE65No-GKBr3sUv8mg-1; Wed, 27 May 2020 14:30:10 -0400
X-MC-Unique: IrBTxE65No-GKBr3sUv8mg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1FEA1005510;
 Wed, 27 May 2020 18:30:08 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1E552856C;
 Wed, 27 May 2020 18:30:06 +0000 (UTC)
Subject: Re: [PATCH v7 32/32] iotests: Add tests for qcow2 images with
 extended L2 entries
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1590429901.git.berto@igalia.com>
 <117ba99f5a1fbea62cfed60fe74a460cc628948f.1590429902.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c2bb44f3-bb7e-7bb0-dbbf-ef1d3273802d@redhat.com>
Date: Wed, 27 May 2020 13:30:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <117ba99f5a1fbea62cfed60fe74a460cc628948f.1590429902.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 1:08 PM, Alberto Garcia wrote:
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   tests/qemu-iotests/271     | 705 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/271.out | 603 +++++++++++++++++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 1309 insertions(+)
>   create mode 100755 tests/qemu-iotests/271
>   create mode 100644 tests/qemu-iotests/271.out
> 

> +_cleanup()
> +{
> +	_cleanup_test_img
> +        rm -f "$TEST_IMG.raw"

TAB damage.


> +
> +l2_offset=262144 # 0x40000

If desired, you could write:

l2_offset=$((0x40000))

if that is more legible.

> +
> +_verify_img()
> +{
> +    $QEMU_IMG compare "$TEST_IMG" "$TEST_IMG.raw" | grep -v 'Images are identical'
> +    $QEMU_IMG check "$TEST_IMG" | _filter_qemu_img_check | \
> +        grep -v 'No errors were found on the image'
> +}
> +
> +# Compare the bitmap of an extended L2 entry against an expected value
> +_verify_l2_bitmap()
> +{
> +    entry_no="$1"            # L2 entry number, starting from 0
> +    expected_alloc="$alloc"  # Space-separated list of allocated subcluster indexes
> +    expected_zero="$zero"    # Space-separated list of zero subcluster indexes
> +
> +    offset=$(($l2_offset + $entry_no * 16))
> +    entry=`peek_file_be "$TEST_IMG" $offset 8`

I find $() easier to read than ``.

> +    offset=$(($offset + 8))
> +    bitmap=`peek_file_be "$TEST_IMG" $offset 8`
> +
> +    expected_bitmap=0
> +    for bit in $expected_alloc; do
> +        expected_bitmap=$(($expected_bitmap | (1 << $bit)))
> +    done
> +    for bit in $expected_zero; do
> +        expected_bitmap=$(($expected_bitmap | (1 << (32 + $bit))))
> +    done
> +    expected_bitmap=`printf "%llu" $expected_bitmap`

Dead statement - expected_bitmap is already a 64-bit decimal number 
without reprinting it to itself.

> +
> +    printf "L2 entry #%d: 0x%016lx %016lx\n" "$entry_no" "$entry" "$bitmap"
> +    if [ "$bitmap" != "$expected_bitmap" ]; then
> +        printf "ERROR: expecting bitmap       0x%016lx\n" "$expected_bitmap"
> +    fi
> +}
> +
> +_test_write()
> +{
> +    cmd="$1"
> +    l2_entry_idx="$2"
> +    [ -n "$l2_entry_idx" ] || l2_entry_idx=0

Could shorten these two lines into the one-liner:

l2_entry_idx=${2:-0}

> +    raw_cmd=`echo $cmd | sed s/-c//` # Raw images don't support -c
> +    echo "$cmd"
> +    $QEMU_IO -c "$cmd" "$TEST_IMG" | _filter_qemu_io
> +    $QEMU_IO -c "$raw_cmd" -f raw "$TEST_IMG.raw" | _filter_qemu_io
> +    _verify_img
> +    _verify_l2_bitmap "$l2_entry_idx"
> +}
> +
> +_reset_img()
> +{
> +    size="$1"
> +    $QEMU_IMG create -f raw "$TEST_IMG.raw" "$size" | _filter_img_create
> +    if [ "$use_backing_file" = "yes" ]; then
> +        $QEMU_IMG create -f raw "$TEST_IMG.base" "$size" | _filter_img_create
> +        $QEMU_IO -c "write -q -P 0xFF 0 $size" -f raw "$TEST_IMG.base" | _filter_qemu_io
> +        $QEMU_IO -c "write -q -P 0xFF 0 $size" -f raw "$TEST_IMG.raw" | _filter_qemu_io
> +        _make_test_img -o extended_l2=on -b "$TEST_IMG.base" "$size"

Semantic conflict with my patches to deprecate omitting -F when creating 
images with -b.  If you don't add '-F $IMGFMT' here, then my series will 
have to do it.

> +    else
> +        _make_test_img -o extended_l2=on "$size"
> +    fi
> +}
> +
> +# Test that writing to an image with subclusters produces the expected
> +# results, in images with and without backing files
> +for use_backing_file in yes no; do
> +    echo
> +    echo "### Standard write tests (backing file: $use_backing_file) ###"
> +    echo
> +    _reset_img 1M
> +    ### Write subcluster #0 (beginning of subcluster) ###
> +    alloc="0"; zero=""
> +    _test_write 'write -q -P 1 0 1k'
> +
> +    ### Write subcluster #1 (middle of subcluster) ###
> +    alloc="0 1"; zero=""
> +    _test_write 'write -q -P 2 3k 512'
> +
> +    ### Write subcluster #2 (end of subcluster) ###
> +    alloc="0 1 2"; zero=""
> +    _test_write 'write -q -P 3 5k 1k'
> +
> +    ### Write subcluster #3 (full subcluster) ###
> +    alloc="0 1 2 3"; zero=""
> +    _test_write 'write -q -P 4 6k 2k'
> +
> +    ### Write subclusters #4-6 (full subclusters) ###
> +    alloc="`seq 0 6`"; zero=""

More places where `` could be changed to $()

> +    _test_write 'write -q -P 5 8k 6k'
> +
> +    ### Write subclusters #7-9 (partial subclusters) ###
> +    alloc="`seq 0 9`"; zero=""
> +    _test_write 'write -q -P 6 15k 4k'
> +
> +    ### Write subcluster #16 (partial subcluster) ###
> +    alloc="`seq 0 9` 16"; zero=""
> +    _test_write 'write -q -P 7 32k 1k'
> +
> +    ### Write subcluster #31-#33 (cluster overlap) ###
> +    alloc="`seq 0 9` 16 31"; zero=""
> +    _test_write 'write -q -P 8 63k 4k'
> +    alloc="0 1" ; zero=""
> +    _verify_l2_bitmap 1
> +
> +    ### Zero subcluster #1
> +    alloc="0 `seq 2 9` 16 31"; zero="1"
> +    _test_write 'write -q -z 2k 2k'
> +
> +    ### Zero cluster #0
> +    alloc=""; zero="`seq 0 31`"
> +    _test_write 'write -q -z 0 64k'
> +
> +    ### Fill cluster #0 with data
> +    alloc="`seq 0 31`"; zero=""
> +    _test_write 'write -q -P 9 0 64k'
> +
> +    ### Zero and unmap half of cluster #0 (this won't unmap it)
> +    alloc="`seq 16 31`"; zero="`seq 0 15`"
> +    _test_write 'write -q -z -u 0 32k'
> +
> +    ### Zero and unmap cluster #0
> +    alloc=""; zero="`seq 0 31`"
> +    _test_write 'write -q -z -u 0 64k'
> +
> +    ### Write subcluster #1 (middle of subcluster)
> +    alloc="1"; zero="0 `seq 2 31`"
> +    _test_write 'write -q -P 10 3k 512'
> +
> +    ### Fill cluster #0 with data
> +    alloc="`seq 0 31`"; zero=""
> +    _test_write 'write -q -P 11 0 64k'
> +
> +    ### Discard cluster #0
> +    alloc=""; zero="`seq 0 31`"
> +    _test_write 'discard -q 0 64k'
> +
> +    ### Write compressed data to cluster #0
> +    alloc=""; zero=""
> +    _test_write 'write -q -c -P 12 0 64k'
> +
> +    ### Write subcluster #2 (middle of subcluster)
> +    alloc="`seq 0 31`"; zero=""
> +    _test_write 'write -q -P 13 3k 512'
> +done

Looks like a nice sequence to give a lot of coverage to the various cases.

> +
> +# calculate_l2_meta() checks if none of the clusters affected by a
> +# write operation need COW or changes to their L2 metadata and simply
> +# returns when they don't. This is a test for that optimization.
> +# Here clusters #0-#3 are overwritten but only #1 and #2 need changes.
> +echo
> +echo '### Overwriting several clusters without COW ###'
> +echo
> +use_backing_file="no" _reset_img 1M
> +# Write cluster #0, subclusters #12-#31
> +alloc="`seq 12 31`"; zero=""
> +_test_write 'write -q 24k 40k' 0
> +
> +# Write cluster #1, subcluster #13
> +alloc="13"; zero=""
> +_test_write 'write -q 90k 2k' 1
> +
> +# Zeroize cluster #2, subcluster #14
> +alloc="14"; zero=""
> +_test_write 'write -q 156k 2k' 2
> +alloc=""; zero="14"
> +_test_write 'write -q -z 156k 2k' 2
> +
> +# Write cluster #3, subclusters #15-#31
> +alloc="`seq 0 16`"; zero=""
> +_test_write 'write -q 192k 34k' 3
> +
> +# Write from cluster #0, subcluster #12 to cluster #3, subcluster #11
> +alloc="`seq 12 31`"; zero=""
> +_test_write 'write -q 24k 192k' 0
> +
> +alloc="`seq 0 31`"; zero=""
> +_verify_l2_bitmap 1
> +_verify_l2_bitmap 2
> +
> +alloc="`seq 0 16`"; zero=""
> +_verify_l2_bitmap 3
> +
> +# Test different patterns of writing zeroes
> +for use_backing_file in yes no; do
> +    echo
> +    echo "### Writing zeroes 1: unallocated clusters (backing file: $use_backing_file) ###"
> +    echo
> +    # Note that the image size is not a multiple of the cluster size
> +    _reset_img 2083k
> +
> +    # Cluster-aligned request from clusters #0 to #2
> +    alloc=""; zero="`seq 0 31`"
> +    _test_write 'write -q -z 0 192k' 0
> +    _verify_l2_bitmap 1
> +    _verify_l2_bitmap 2
> +
> +    # Subcluster-aligned request from clusters #3 to #5
> +    alloc=""; zero="`seq 16 31`"
> +    _test_write 'write -q -z 224k 128k' 3
> +    alloc=""; zero="`seq 0 31`"
> +    _verify_l2_bitmap 4
> +    alloc=""; zero="`seq 0 15`"
> +    _verify_l2_bitmap 5
> +
> +    # Unaligned request from clusters #6 to #8
> +    if [ "$use_backing_file" = "yes" ]; then
> +        alloc="15"; zero="`seq 16 31`" # copy-on-write happening here
> +    else
> +        alloc=""; zero="`seq 15 31`"
> +    fi
> +    _test_write 'write -q -z 415k 128k' 6
> +    alloc=""; zero="`seq 0 31`"
> +    _verify_l2_bitmap 7
> +    if [ "$use_backing_file" = "yes" ]; then
> +        alloc="15"; zero="`seq 0 14`" # copy-on-write happening here
> +    else
> +        alloc=""; zero="`seq 0 15`"
> +    fi
> +    _verify_l2_bitmap 8
> +
> +    echo
> +    echo "### Writing zeroes 2: allocated clusters (backing file: $use_backing_file) ###"
> +    echo
> +    alloc="`seq 0 31`"; zero=""
> +    _test_write 'write -q -P 1 576k 576k' 9
> +    _verify_l2_bitmap 10
> +    _verify_l2_bitmap 11
> +    _verify_l2_bitmap 12
> +    _verify_l2_bitmap 13
> +    _verify_l2_bitmap 14
> +    _verify_l2_bitmap 15
> +    _verify_l2_bitmap 16
> +    _verify_l2_bitmap 17
> +
> +    # Cluster-aligned request from clusters #9 to #11
> +    alloc=""; zero="`seq 0 31`"
> +    _test_write 'write -q -z 576k 192k' 9
> +    _verify_l2_bitmap 10
> +    _verify_l2_bitmap 11
> +
> +    # Subcluster-aligned request from clusters #12 to #14
> +    alloc="`seq 0 15`"; zero="`seq 16 31`"
> +    _test_write 'write -q -z 800k 128k' 12
> +    alloc=""; zero="`seq 0 31`"
> +    _verify_l2_bitmap 13
> +    alloc="`seq 16 31`"; zero="`seq 0 15`"
> +    _verify_l2_bitmap 14
> +
> +    # Unaligned request from clusters #15 to #17
> +    alloc="`seq 0 15`"; zero="`seq 16 31`"
> +    _test_write 'write -q -z 991k 128k' 15
> +    alloc=""; zero="`seq 0 31`"
> +    _verify_l2_bitmap 16
> +    alloc="`seq 15 31`"; zero="`seq 0 14`"
> +    _verify_l2_bitmap 17
> +
> +    echo
> +    echo "### Writing zeroes 3: compressed clusters (backing file: $use_backing_file) ###"
> +    echo
> +    alloc=""; zero=""
> +    for c in `seq 18 28`; do
> +        _test_write "write -q -c -P 2 $(($c*64))k 64k" $c
> +    done
> +
> +    # Cluster-aligned request from clusters #18 to #20
> +    alloc=""; zero="`seq 0 31`"
> +    _test_write 'write -q -z 1152k 192k' 18
> +    _verify_l2_bitmap 19
> +    _verify_l2_bitmap 20
> +
> +    # Subcluster-aligned request from clusters #21 to #23.
> +    # We cannot partially zero a compressed cluster so the code
> +    # returns -ENOTSUP, which means copy-on-write of the compressed
> +    # data and fill the rest with actual zeroes on disk.
> +    # TODO: cluster #22 should use the 'all zeroes' bits.
> +    alloc="`seq 0 31`"; zero=""
> +    _test_write 'write -q -z 1376k 128k' 21
> +    _verify_l2_bitmap 22
> +    _verify_l2_bitmap 23

Hmm - this matches the question in 28/32 about whether we are handling 
sub-cluster-aligned requests correctly.  Is it merely a case that we 
aren't telling the block layer our correct preferred alignment for zero 
requests?
[...]

> +    # Unaligned request from clusters #24 to #26
> +    # In this case QEMU internally sends a 1k request followed by a
> +    # subcluster-aligned 128k request. The first request decompresses
> +    # cluster #24, but that's not enough to perform efficiently the
> +    # second request because it partially writes to cluster #26 (which

s/perform efficiently the second request/perform the second request 
efficiently/

> +
> +# Test that corrupted L2 entries are detected in both read and write
> +# operations
> +for corruption_test_cmd in read write; do
> +    echo
> +    echo "### Corrupted L2 entries - $corruption_test_cmd test (allocated) ###"
> +    echo
> +    echo "# 'cluster is zero' bit set on the standard cluster descriptor"
> +    echo
> +    # We actually don't consider this a corrupted image.
> +    # The 'cluster is zero' bit is unused is unused in extended L2 entries

doubled 'is unused'

> +    # so QEMU ignores it.
> +    # TODO: maybe treat the image as corrupted and make qemu-img check fix it?
> +    _make_test_img -o extended_l2=on 1M
> +    $QEMU_IO -c 'write -q -P 0x11 0 2k' "$TEST_IMG"
> +    poke_file "$TEST_IMG" $(($l2_offset+7)) "\x01"
> +    alloc="0"; zero=""
> +    _verify_l2_bitmap 0
> +    $QEMU_IO -c "$corruption_test_cmd -q -P 0x11 0 1k" "$TEST_IMG"
> +    if [ "$corruption_test_cmd" = "write" ]; then
> +        alloc="0"; zero=""
> +    fi
> +    _verify_l2_bitmap 0
> +
> +    echo
> +    echo "# Both 'subcluster is zero' and 'subcluster is allocated' bits set"
> +    echo
> +    _make_test_img -o extended_l2=on 1M
> +    # Write from the middle of cluster #0 to the middle of cluster #2
> +    $QEMU_IO -c 'write -q 32k 128k' "$TEST_IMG"
> +    # Corrupt the L2 entry from cluster #1
> +    poke_file "$TEST_IMG" $(($l2_offset+24)) "\x00\x00\x00\x01"
> +    alloc="`seq 0 31`"; zero="0"
> +    _verify_l2_bitmap 1
> +    $QEMU_IO -c "$corruption_test_cmd 0 192k" "$TEST_IMG"
> +
> +    echo
> +    echo "### Corrupted L2 entries - $corruption_test_cmd test (unallocated) ###"
> +    echo
> +    echo "# 'cluster is zero' bit set on the standard cluster descriptor"
> +    echo
> +    # We actually don't consider this a corrupted image.
> +    # The 'cluster is zero' bit is unused is unused in extended L2 entries

and again

> +    # so QEMU ignores it.
> +    # TODO: maybe treat the image as corrupted and make qemu-img check fix it?
> +    _make_test_img -o extended_l2=on 1M
> +    # We want to modify the (empty) L2 entry from cluster #0,
> +    # but we write to #4 in order to initialize the L2 table first
> +    $QEMU_IO -c 'write -q 256k 1k' "$TEST_IMG"
> +    poke_file "$TEST_IMG" $(($l2_offset+7)) "\x01"
> +    alloc=""; zero=""
> +    _verify_l2_bitmap 0
> +    $QEMU_IO -c "$corruption_test_cmd -q 0 1k" "$TEST_IMG"
> +    if [ "$corruption_test_cmd" = "write" ]; then
> +        alloc="0"; zero=""
> +    fi
> +    _verify_l2_bitmap 0
> +
> +    echo
> +    echo "# 'subcluster is allocated' bit set"
> +    echo
> +    _make_test_img -o extended_l2=on 1M
> +    # We want to corrupt the (empty) L2 entry from cluster #0,
> +    # but we write to #4 in order to initialize the L2 table first
> +    $QEMU_IO -c 'write -q 256k 1k' "$TEST_IMG"
> +    poke_file "$TEST_IMG" $(($l2_offset+15)) "\x01"
> +    alloc="0"; zero=""
> +    _verify_l2_bitmap 0
> +    $QEMU_IO -c "$corruption_test_cmd 0 1k" "$TEST_IMG"
> +
> +    echo
> +    echo "# Both 'subcluster is zero' and 'subcluster is allocated' bits set"
> +    echo
> +    _make_test_img -o extended_l2=on 1M
> +    # We want to corrupt the (empty) L2 entry from cluster #1,
> +    # but we write to #4 in order to initialize the L2 table first
> +    $QEMU_IO -c 'write -q 256k 1k' "$TEST_IMG"
> +    # Corrupt the L2 entry from cluster #1
> +    poke_file "$TEST_IMG" $(($l2_offset+24)) "\x00\x00\x00\x01\x00\x00\x00\x01"

would statements like this be any easier with poke_file_be?

> +    alloc="0"; zero="0"
> +    _verify_l2_bitmap 1
> +    $QEMU_IO -c "$corruption_test_cmd 0 192k" "$TEST_IMG"
> +
> +    echo
> +    echo "### Compressed cluster with subcluster bitmap != 0 - $corruption_test_cmd test ###"
> +    echo
> +    # We actually don't consider this a corrupted image.
> +    # The bitmap in compressed clusters is unused so QEMU should just ignore it.
> +    _make_test_img -o extended_l2=on 1M
> +    $QEMU_IO -c 'write -q -P 11 -c 0 64k' "$TEST_IMG"
> +    # Change the L2 bitmap to allocate subcluster #31 and zeroize subcluster #0
> +    poke_file "$TEST_IMG" $(($l2_offset+11)) "\x01\x80"
> +    alloc="31"; zero="0"
> +    _verify_l2_bitmap 0
> +    $QEMU_IO -c "$corruption_test_cmd -P 11 0 64k" "$TEST_IMG" | _filter_qemu_io
> +    # Writing allocates a new uncompressed cluster so we get a new bitmap
> +    if [ "$corruption_test_cmd" = "write" ]; then
> +        alloc="`seq 0 31`"; zero=""
> +    fi
> +    _verify_l2_bitmap 0
> +done
> +
> +echo
> +echo "### Image creation options ###"
> +echo
> +echo "# cluster_size < 16k"
> +_make_test_img -o extended_l2=on,cluster_size=8k 1M
> +
> +# TODO: allow preallocation with backing files when subclusters are used
> +echo "# backing file and preallocation=metadata"
> +_make_test_img -o extended_l2=on,preallocation=metadata -b "$TEST_IMG.base" 1M
> +
> +echo "# backing file and preallocation=falloc"
> +_make_test_img -o extended_l2=on,preallocation=falloc -b "$TEST_IMG.base" 1M
> +
> +echo "# backing file and preallocation=full"
> +_make_test_img -o extended_l2=on,preallocation=full -b "$TEST_IMG.base" 1M
> +
> +echo
> +echo "### qemu-img measure ###"
> +echo
> +echo "# 512MB, extended_l2=off" # This needs one L2 table
> +$QEMU_IMG measure --size 512M -O qcow2 -o extended_l2=off
> +echo "# 512MB, extended_l2=on"  # This needs two L2 tables
> +$QEMU_IMG measure --size 512M -O qcow2 -o extended_l2=on
> +
> +echo "# 16K clusters, 64GB, extended_l2=off" # This needs one full L1 table cluster
> +$QEMU_IMG measure --size 64G -O qcow2 -o cluster_size=16k,extended_l2=off
> +echo "# 16K clusters, 64GB, extended_l2=on"  # This needs two full L2 table clusters
> +$QEMU_IMG measure --size 64G -O qcow2 -o cluster_size=16k,extended_l2=on
> +
> +echo "# 8k clusters" # This should fail
> +$QEMU_IMG measure --size 1M -O qcow2 -o cluster_size=8k,extended_l2=on
> +
> +echo "# 1024 TB" # Maximum allowed size with extended_l2=on and 64K clusters
> +$QEMU_IMG measure --size 1024T -O qcow2 -o extended_l2=on
> +echo "# 1025 TB" # This should fail
> +$QEMU_IMG measure --size 1025T -O qcow2 -o extended_l2=on
> +
> +echo
> +echo "### qemu-img amend ###"
> +echo
> +_make_test_img -o extended_l2=on 1M
> +$QEMU_IMG amend -o extended_l2=off "$TEST_IMG"
> +
> +_make_test_img -o extended_l2=off 1M
> +$QEMU_IMG amend -o extended_l2=on "$TEST_IMG"

When we know we currently fail, should we write:

$QEMU_IMG ... && echo "unexpected pass"

to track exit status in addition to output comparison?

> +
> +echo
> +echo "### Test copy-on-write on an image with snapshots ###"
> +echo
> +_make_test_img -o extended_l2=on 1M
> +
> +# For each cluster from #0 to #9 this loop zeroes subcluster #7
> +# and allocates subclusters #13 and #18.
> +alloc="13 18"; zero="7"
> +for c in `seq 0 9`; do
> +    $QEMU_IO -c "write -q -z $((64*$c+14))k 2k" \
> +             -c "write -q -P $((0xd0+$c)) $((64*$c+26))k 2k" \
> +             -c "write -q -P $((0xe0+$c)) $((64*$c+36))k 2k" "$TEST_IMG"
> +    _verify_l2_bitmap "$c"
> +done
> +
> +# Create a snapshot and set l2_offset to the new L2 table
> +$QEMU_IMG snapshot -c snap1 "$TEST_IMG"
> +l2_offset=1114112 # 0x110000
> +
> +# Write different patterns to each one of the clusters
> +# in order to see how copy-on-write behaves in each case.
> +$QEMU_IO -c "write -q -P 0xf0 $((64*0+30))k 1k" \
> +         -c "write -q -P 0xf1 $((64*1+20))k 1k" \
> +         -c "write -q -P 0xf2 $((64*2+40))k 1k" \
> +         -c "write -q -P 0xf3 $((64*3+26))k 1k" \
> +         -c "write -q -P 0xf4 $((64*4+14))k 1k" \
> +         -c "write -q -P 0xf5 $((64*5+1))k  1k" \
> +         -c "write -q -z      $((64*6+30))k 3k" \
> +         -c "write -q -z      $((64*7+26))k 2k" \
> +         -c "write -q -z      $((64*8+26))k 1k" \
> +         -c "write -q -z      $((64*9+12))k 1k" \
> +         "$TEST_IMG"
> +alloc="`seq 13 18`"; zero="7" _verify_l2_bitmap 0
> +alloc="`seq 10 18`"; zero="7" _verify_l2_bitmap 1
> +alloc="`seq 13 20`"; zero="7" _verify_l2_bitmap 2
> +alloc="`seq 13 18`"; zero="7" _verify_l2_bitmap 3
> +alloc="`seq 7 18`";  zero=""  _verify_l2_bitmap 4
> +alloc="`seq 0 18`";  zero=""  _verify_l2_bitmap 5
> +alloc="13 18"; zero="7 15 16" _verify_l2_bitmap 6
> +alloc="18";       zero="7 13" _verify_l2_bitmap 7
> +alloc="`seq 13 18`"; zero="7" _verify_l2_bitmap 8
> +alloc="13 18";     zero="6 7" _verify_l2_bitmap 9
> +

Nice - overall pretty thorough!

> +# success, all done
> +echo "*** done"
> +rm -f $seq.full
> +status=0
> diff --git a/tests/qemu-iotests/271.out b/tests/qemu-iotests/271.out
> new file mode 100644
> index 0000000000..6ac53d5e10
> --- /dev/null


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


