Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECA4C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9798621951
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9798621951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfi7-0001WO-RP
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48847)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hqfho-0000Xe-3V
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hqfhn-0001dI-0x
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:30:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hqfhj-0001cA-Vk; Thu, 25 Jul 2019 11:30:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 498ED3082B4B;
 Thu, 25 Jul 2019 15:30:51 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D897979402;
 Thu, 25 Jul 2019 15:30:49 +0000 (UTC)
Message-ID: <434009d7c271cdca755cd3db95a4977c9e09f12d.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 18:30:48 +0300
In-Reply-To: <20190724171239.8764-11-mreitz@redhat.com>
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-11-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 25 Jul 2019 15:30:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 10/11] iotests: Test convert -n to
 pre-filled image
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
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-07-24 at 19:12 +0200, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/122     | 17 +++++++++++++++++
>  tests/qemu-iotests/122.out |  8 ++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
> index 85c3a8d047..059011ebb1 100755
> --- a/tests/qemu-iotests/122
> +++ b/tests/qemu-iotests/122
> @@ -257,6 +257,23 @@ for min_sparse in 4k 8k; do
>      $QEMU_IMG map --output=json "$TEST_IMG".orig | _filter_qemu_img_map
>  done
>  
> +
> +echo
> +echo '=== -n to a non-zero image ==='
> +echo
> +
> +# Keep source zero
> +_make_test_img 64M
> +
> +# Output is not zero, but has bdrv_has_zero_init() == 1
> +TEST_IMG="$TEST_IMG".orig _make_test_img 64M
> +$QEMU_IO -c "write -P 42 0 64k" "$TEST_IMG".orig | _filter_qemu_io
> +
> +# Convert with -n, which should not assume that the target is zeroed
> +$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
> +
> +$QEMU_IMG compare "$TEST_IMG" "$TEST_IMG".orig
> +
>  # success, all done
>  echo '*** done'
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
> index c576705284..849b6cc2ef 100644
> --- a/tests/qemu-iotests/122.out
> +++ b/tests/qemu-iotests/122.out
> @@ -220,4 +220,12 @@ convert -c -S 8k
>  { "start": 9216, "length": 8192, "depth": 0, "zero": true, "data": false},
>  { "start": 17408, "length": 1024, "depth": 0, "zero": false, "data": true},
>  { "start": 18432, "length": 67090432, "depth": 0, "zero": true, "data": false}]
> +
> +=== -n to a non-zero image ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=67108864
> +wrote 65536/65536 bytes at offset 0
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Images are identical.
>  *** done


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky



