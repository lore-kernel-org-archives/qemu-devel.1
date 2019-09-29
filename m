Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF95EC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40282081B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40282081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEcUf-0003Y5-PN
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 12:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEcDs-0006Uo-Bw
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEcDr-00039m-2o
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:39:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39112)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEcDo-00034S-L0; Sun, 29 Sep 2019 12:38:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D8A721DB6;
 Sun, 29 Sep 2019 16:38:55 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D6E960606;
 Sun, 29 Sep 2019 16:38:54 +0000 (UTC)
Message-ID: <b43d4d8f8c3b426d5d57dfc4c468c3aa8bfacf71.camel@redhat.com>
Subject: Re: [PATCH 16/18] iotests: Make 198 work with data_file
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Sun, 29 Sep 2019 19:38:53 +0300
In-Reply-To: <20190927094242.11152-17-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-17-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Sun, 29 Sep 2019 16:38:55 +0000 (UTC)
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
> We do not care about the json:{} filenames here, so we can just filter
> them out and thus make the test work both with and without external data
> files.
Same comment as for iotest 110, this is more justification to move this
outside to reduce duplication.

Best regards,
	Maxim Levitsky

> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/198     | 6 ++++--
>  tests/qemu-iotests/198.out | 4 ++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
> index c8f824cfae..d9981942a7 100755
> --- a/tests/qemu-iotests/198
> +++ b/tests/qemu-iotests/198
> @@ -92,13 +92,15 @@ echo
>  echo "== checking image base =="
>  $QEMU_IMG info --image-opts $IMGSPECBASE | _filter_img_info --format-specific \
>      | sed -e "/^disk size:/ D" -e '/refcount bits:/ D' -e '/compat:/ D' \
> -          -e '/lazy refcounts:/ D' -e '/corrupt:/ D'
> +          -e '/lazy refcounts:/ D' -e '/corrupt:/ D' -e '/^\s*data file/ D' \
> +          -e 's#image: json:.*#image: json:{ /* filtered */ }#'
>  
>  echo
>  echo "== checking image layer =="
>  $QEMU_IMG info --image-opts $IMGSPECLAYER | _filter_img_info --format-specific \
>      | sed -e "/^disk size:/ D" -e '/refcount bits:/ D' -e '/compat:/ D' \
> -          -e '/lazy refcounts:/ D' -e '/corrupt:/ D'
> +          -e '/lazy refcounts:/ D' -e '/corrupt:/ D' -e '/^\s*data file/ D' \
> +          -e 's#image: json:.*#image: json:{ /* filtered */ }#'
>  
>  
>  # success, all done
> diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
> index e86b175e39..831ce3a289 100644
> --- a/tests/qemu-iotests/198.out
> +++ b/tests/qemu-iotests/198.out
> @@ -32,7 +32,7 @@ read 16777216/16777216 bytes at offset 0
>  16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  
>  == checking image base ==
> -image: json:{"encrypt.key-secret": "sec0", "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}
> +image: json:{ /* filtered */ }
>  file format: IMGFMT
>  virtual size: 16 MiB (16777216 bytes)
>  Format specific information:
> @@ -74,7 +74,7 @@ Format specific information:
>          master key iters: 1024
>  
>  == checking image layer ==
> -image: json:{"encrypt.key-secret": "sec1", "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}
> +image: json:{ /* filtered */ }
>  file format: IMGFMT
>  virtual size: 16 MiB (16777216 bytes)
>  backing file: TEST_DIR/t.IMGFMT.base



