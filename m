Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E02C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E05A20672
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E05A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0PAB-0000Qa-Ih
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1k0P9P-0007yz-JU; Tue, 28 Jul 2020 08:56:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:48878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1k0P9N-0004if-Ts; Tue, 28 Jul 2020 08:56:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 15C65ACB5;
 Tue, 28 Jul 2020 12:56:19 +0000 (UTC)
Subject: Re: [PATCH for-5.1 2/2] iotests/028: Add test for cross-base-EOF reads
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200728120806.265916-1-mreitz@redhat.com>
 <20200728120806.265916-3-mreitz@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <aff4715f-7061-0b50-4975-0cc64db5723f@suse.de>
Date: Tue, 28 Jul 2020 14:56:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200728120806.265916-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 01:54:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, Bruce Rogers <brogers@suse.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Claudio Fontana <cfontana@suse.de>

On 7/28/20 2:08 PM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/028     | 19 +++++++++++++++++++
>  tests/qemu-iotests/028.out | 11 +++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
> index 5d043cef92..6dd3ae09a3 100755
> --- a/tests/qemu-iotests/028
> +++ b/tests/qemu-iotests/028
> @@ -142,6 +142,25 @@ TEST_IMG="${TEST_IMG}.copy" io_zero readv $(( offset + 32 * 1024 )) 512 1024 32
>  
>  _check_test_img
>  
> +echo
> +echo '=== Reading across backing EOF in one operation ==='
> +echo
> +
> +# Use a cluster boundary as the base end here
> +base_size=$((3 * 1024 * 1024 * 1024))
> +
> +TEST_IMG="$TEST_IMG.base" _make_test_img $base_size
> +_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $image_size
> +
> +# Write 16 times 42 at the end of the base image
> +$QEMU_IO -c "write -P 42 $((base_size - 16)) 16" "$TEST_IMG.base" \
> +    | _filter_qemu_io
> +
> +# Read 32 bytes across the base EOF from the top;
> +# should be 16 times 0x2a, then 16 times 0x00
> +$QEMU_IO -c "read -v $((base_size - 16)) 32" "$TEST_IMG" \
> +    | _filter_qemu_io
> +
>  # success, all done
>  echo "*** done"
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/028.out b/tests/qemu-iotests/028.out
> index 12f82c6a6c..5a68de5c46 100644
> --- a/tests/qemu-iotests/028.out
> +++ b/tests/qemu-iotests/028.out
> @@ -730,4 +730,15 @@ read 512/512 bytes at offset 3221257728
>  read 512/512 bytes at offset 3221258752
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  No errors were found on the image.
> +
> +=== Reading across backing EOF in one operation ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=3221225472
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294968832 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
> +wrote 16/16 bytes at offset 3221225456
> +16 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +bffffff0:  2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a  ................
> +c0000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> +read 32/32 bytes at offset 3221225456
> +32 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  *** done
> 


