Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E193C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D4E217F5
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D4E217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEc9q-0001b5-A0
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 12:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc72-0008J8-7l
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc71-00025E-42
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:31:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEc6x-0001yG-5w; Sun, 29 Sep 2019 12:31:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D7E4A8AC6E0;
 Sun, 29 Sep 2019 16:31:48 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 809E7600F8;
 Sun, 29 Sep 2019 16:31:47 +0000 (UTC)
Message-ID: <f8db846b4dba5cd8febc09e871a932c7999f5403.camel@redhat.com>
Subject: Re: [PATCH 01/18] iotests: Filter refcount_order in 036
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Sun, 29 Sep 2019 19:31:46 +0300
In-Reply-To: <20190927094242.11152-2-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-2-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Sun, 29 Sep 2019 16:31:49 +0000 (UTC)
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
> This test can run just fine with other values for refcount_bits, so we
> should filter the value from qcow2.py's dump-header.
> 
> (036 currently ignores user-specified image options, but that will be
> fixed in the next patch.)
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/036     | 9 ++++++---
>  tests/qemu-iotests/036.out | 6 +++---
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
> index f06ff67408..69d0f9f903 100755
> --- a/tests/qemu-iotests/036
> +++ b/tests/qemu-iotests/036
> @@ -55,7 +55,8 @@ $PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible 63
>  
>  # Without feature table
>  $PYTHON qcow2.py "$TEST_IMG" del-header-ext 0x6803f857
> -$PYTHON qcow2.py "$TEST_IMG" dump-header
> +$PYTHON qcow2.py "$TEST_IMG" dump-header \
> +    | sed -e 's/^\(refcount_order\s*\).*/\1(filtered)/'
>  _img_info
>  
>  # With feature table containing bit 63
> @@ -103,14 +104,16 @@ echo === Create image with unknown autoclear feature bit ===
>  echo
>  _make_test_img 64M
>  $PYTHON qcow2.py "$TEST_IMG" set-feature-bit autoclear 63
> -$PYTHON qcow2.py "$TEST_IMG" dump-header
> +$PYTHON qcow2.py "$TEST_IMG" dump-header \
> +    | sed -e 's/^\(refcount_order\s*\).*/\1(filtered)/'
>  
>  echo
>  echo === Repair image ===
>  echo
>  _check_test_img -r all
>  
> -$PYTHON qcow2.py "$TEST_IMG" dump-header
> +$PYTHON qcow2.py "$TEST_IMG" dump-header \
> +    | sed -e 's/^\(refcount_order\s*\).*/\1(filtered)/'
>  
>  # success, all done
>  echo "*** done"
> diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
> index e489b44386..998c2a8a35 100644
> --- a/tests/qemu-iotests/036.out
> +++ b/tests/qemu-iotests/036.out
> @@ -19,7 +19,7 @@ snapshot_offset           0x0
>  incompatible_features     0x8000000000000000
>  compatible_features       0x0
>  autoclear_features        0x0
> -refcount_order            4
> +refcount_order            (filtered)
>  header_length             104
>  
>  qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature(s): Unknown incompatible feature: 8000000000000000
> @@ -53,7 +53,7 @@ snapshot_offset           0x0
>  incompatible_features     0x0
>  compatible_features       0x0
>  autoclear_features        0x8000000000000000
> -refcount_order            4
> +refcount_order            (filtered)
>  header_length             104
>  
>  Header extension:
> @@ -81,7 +81,7 @@ snapshot_offset           0x0
>  incompatible_features     0x0
>  compatible_features       0x0
>  autoclear_features        0x0
> -refcount_order            4
> +refcount_order            (filtered)
>  header_length             104
>  
>  Header extension:

Minor notes:

1. Maybe put the sed command into a function to avoid duplication?
2. As I understand the test, it only checks the feature bits.
   So maybe instead of blacklisting some of the values, white list
   only the feature bits in the output?

Best regards,
	Maxim Levitsky



