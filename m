Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C0AC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B97220673
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B97220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEcHe-0000z2-6i
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 12:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc7b-0000N8-IJ
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc7a-0002cF-A4
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:32:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEc7U-0002RA-Fz; Sun, 29 Sep 2019 12:32:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD5D918C4262;
 Sun, 29 Sep 2019 16:32:23 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71EB95C223;
 Sun, 29 Sep 2019 16:32:22 +0000 (UTC)
Message-ID: <b55869998d7f35096615cf5f011b7104ee36940b.camel@redhat.com>
Subject: Re: [PATCH 04/18] iotests: Let _make_test_img parse its parameters
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Sun, 29 Sep 2019 19:32:21 +0300
In-Reply-To: <20190927094242.11152-5-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-5-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Sun, 29 Sep 2019 16:32:23 +0000 (UTC)
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
> This will allow us to add more options than just -b.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/common.rc | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 12b4751848..3e7adc4834 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -282,12 +282,12 @@ _make_test_img()
>      # extra qemu-img options can be added by tests
>      # at least one argument (the image size) needs to be added
>      local extra_img_options=""
> -    local image_size=$*
>      local optstr=""
>      local img_name=""
>      local use_backing=0
>      local backing_file=""
>      local object_options=""
> +    local misc_params=()
>  
>      if [ -n "$TEST_IMG_FILE" ]; then
>          img_name=$TEST_IMG_FILE
> @@ -303,11 +303,23 @@ _make_test_img()
>          optstr=$(_optstr_add "$optstr" "key-secret=keysec0")
>      fi
>  
> -    if [ "$1" = "-b" ]; then
> -        use_backing=1
> -        backing_file=$2
> -        image_size=$3
> -    fi
> +    for param; do
> +        if [ "$use_backing" = "1" -a -z "$backing_file" ]; then
> +            backing_file=$param
> +            continue
> +        fi
> +
> +        case "$param" in
> +            -b)
> +                use_backing=1
> +                ;;
> +
> +            *)
> +                misc_params=("${misc_params[@]}" "$param")
> +                ;;
> +        esac
> +    done
> +
>      if [ \( "$IMGFMT" = "qcow2" -o "$IMGFMT" = "qed" \) -a -n "$CLUSTER_SIZE" ]; then
>          optstr=$(_optstr_add "$optstr" "cluster_size=$CLUSTER_SIZE")
>      fi
> @@ -323,9 +335,9 @@ _make_test_img()
>      # XXX(hch): have global image options?
>      (
>       if [ $use_backing = 1 ]; then
> -        $QEMU_IMG create $object_options -f $IMGFMT $extra_img_options -b "$backing_file" "$img_name" $image_size 2>&1
> +        $QEMU_IMG create $object_options -f $IMGFMT $extra_img_options -b "$backing_file" "$img_name" "${misc_params[@]}" 2>&1
>       else
> -        $QEMU_IMG create $object_options -f $IMGFMT $extra_img_options "$img_name" $image_size 2>&1
> +        $QEMU_IMG create $object_options -f $IMGFMT $extra_img_options "$img_name" "${misc_params[@]}" 2>&1
>       fi
>      ) | _filter_img_create
>  

Look all right as far as I understand that code, and this is a very welcome change.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



