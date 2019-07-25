Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DE0C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9FE21951
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9FE21951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfhu-0000fP-JN
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48795)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hqfhf-0000CU-2q
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hqfhd-0001a1-Ql
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:30:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hqfhW-0001Uo-OD; Thu, 25 Jul 2019 11:30:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DB8AE30BDE49;
 Thu, 25 Jul 2019 15:30:31 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E1AA60BEC;
 Thu, 25 Jul 2019 15:30:30 +0000 (UTC)
Message-ID: <70f1dff28165e6e2ae4443730f66ec36769c0394.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 18:30:29 +0300
In-Reply-To: <20190724171239.8764-10-mreitz@redhat.com>
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-10-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 25 Jul 2019 15:30:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 09/11] iotests: Convert to preallocated
 encrypted qcow2
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
> Add a test case for converting an empty image (which only returns zeroes
> when read) to a preallocated encrypted qcow2 image.
> qcow2_has_zero_init() should return 0 then, thus forcing qemu-img
> convert to create zero clusters.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tests/qemu-iotests/188     | 20 +++++++++++++++++++-
>  tests/qemu-iotests/188.out |  4 ++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
> index be7278aa65..afca44df54 100755
> --- a/tests/qemu-iotests/188
> +++ b/tests/qemu-iotests/188
> @@ -48,7 +48,7 @@ SECRETALT="secret,id=sec0,data=platypus"
>  
>  _make_test_img --object $SECRET -o "encrypt.format=luks,encrypt.key-secret=sec0,encrypt.iter-time=10" $size
>  
> -IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,encrypt.key-secret=sec0"
> +IMGSPEC="driver=$IMGFMT,encrypt.key-secret=sec0,file.filename=$TEST_IMG"
This change I think doesn't change anything

>  
>  QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
>  
> @@ -68,6 +68,24 @@ echo
>  echo "== verify open failure with wrong password =="
>  $QEMU_IO --object $SECRETALT -c "read -P 0xa 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
>  
> +_cleanup_test_img
> +
> +echo
> +echo "== verify that has_zero_init returns false when preallocating =="
> +
> +# Empty source file
> +if [ -n "$TEST_IMG_FILE" ]; then
> +    TEST_IMG_FILE="${TEST_IMG_FILE}.orig" _make_test_img $size
> +else
> +    TEST_IMG="${TEST_IMG}.orig" _make_test_img $size
> +fi

I wonder why do we have TEST_IMG_FILE and TEST_IMG, I don't know iotests well enough
From the quick look at the code, the TEST_IMG_FILE is an actual file, while TEST_IMG can
be various URL like address.

> +
> +$QEMU_IMG convert -O "$IMGFMT" --object $SECRET \
> +    -o "encrypt.format=luks,encrypt.key-secret=sec0,encrypt.iter-time=10,preallocation=metadata" \
> +    "${TEST_IMG}.orig" "$TEST_IMG"
> +
> +$QEMU_IMG compare --object $SECRET --image-opts "${IMGSPEC}.orig" "$IMGSPEC"
> +
>  
>  # success, all done
>  echo "*** done"
> diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
> index 97b1402671..c568ef3701 100644
> --- a/tests/qemu-iotests/188.out
> +++ b/tests/qemu-iotests/188.out
> @@ -15,4 +15,8 @@ read 16777216/16777216 bytes at offset 0
>  
>  == verify open failure with wrong password ==
>  qemu-io: can't open: Invalid password, cannot unlock any keyslot
> +
> +== verify that has_zero_init returns false when preallocating ==
> +Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=16777216
> +Images are identical.
>  *** done

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky


