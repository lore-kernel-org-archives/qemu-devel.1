Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5987C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892FD2086A
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892FD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEcPD-0007Gg-2X
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 12:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEcEH-0006gw-Nn
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEcEE-0003Un-Fl
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:39:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51044)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEcE9-0003Ov-Ps; Sun, 29 Sep 2019 12:39:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 98BAB10DCC8A;
 Sun, 29 Sep 2019 16:39:16 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D9985D9C3;
 Sun, 29 Sep 2019 16:39:15 +0000 (UTC)
Message-ID: <b6e37ff6bc37798d98731b0744f870fcce3dd156.camel@redhat.com>
Subject: Re: [PATCH 18/18] iotests: Allow check -o data_file
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Sun, 29 Sep 2019 19:39:14 +0300
In-Reply-To: <20190927094242.11152-19-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-19-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Sun, 29 Sep 2019 16:39:16 +0000 (UTC)
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
> The problem with allowing the data_file option is that you want to use a
> different data file per image used in the test.  Therefore, we need to
> allow patterns like -o data_file='$TEST_IMG.data_file'.
> 
> Then, we need to filter it out from qemu-img map, qemu-img create, and
> remove the data file in _rm_test_img.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/common.filter | 21 +++++++++++++++++++--
>  tests/qemu-iotests/common.rc     | 10 +++++++++-
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> index 841f7642af..a11f9a8972 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -115,7 +115,15 @@ _filter_actual_image_size()
>  # replace driver-specific options in the "Formatting..." line
>  _filter_img_create()
>  {
> -    $SED -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
> +    data_file_filter=()
> +    if echo "$IMGOPTS" | grep -q 'data_file='; then
> +        data_file=$(echo "$IMGOPTS" | sed -e 's/.*\(data_file=[^,]*\).*/\1/' \
> +                                          -e "s#\\\$TEST_IMG#$TEST_IMG#")
Could you maybe add a comment on this regular expression, similar
to what is in the commit message?

> +        data_file_filter=(-e "s# $data_file##")
Why to use array here? A variable would work too I think.
> +    fi
> +
> +    $SED "${data_file_filter[@]}" \
> +        -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
>          -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
>          -e "s#$TEST_DIR#TEST_DIR#g" \
>          -e "s#$IMGFMT#IMGFMT#g" \
> @@ -198,9 +206,18 @@ _filter_img_info()
>  # human and json output
>  _filter_qemu_img_map()
>  {
> +    data_file_filter=()
> +    if echo "$IMGOPTS" | grep -q 'data_file='; then
> +        data_file_pattern=$(echo "$IMGOPTS" | sed -e 's/.*data_file=\([^,]*\).*/\1/' \
> +                                                  -e 's#\$TEST_IMG#\\(.*\\)#')
> +        data_file_filter=(-e "s#$data_file_pattern#\\1#")
Seems to do the same thing, but in slightly different way.
Maybe make a function to avoid duplication?
I am not 100% sure though.

> +    fi
> +
>      $SED -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
>          -e 's/"offset": [0-9]\+/"offset": OFFSET/g' \
> -        -e 's/Mapped to *//' | _filter_testdir | _filter_imgfmt
> +        -e 's/Mapped to *//' \
> +        "${data_file_filter[@]}" \
> +        | _filter_testdir | _filter_imgfmt
>  }
>  
>  _filter_nbd()
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index f3784077de..834ece12e4 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -297,7 +297,8 @@ _make_test_img()
>      fi
>  
>      if [ -n "$IMGOPTS" ]; then
> -        optstr=$(_optstr_add "$optstr" "$IMGOPTS")
> +        imgopts_expanded=$(echo "$IMGOPTS" | sed -e "s#\\\$TEST_IMG#$img_name#")
> +        optstr=$(_optstr_add "$optstr" "$imgopts_expanded")
Also a comment explaining why this is needed would be welcome.

>      fi
>      if [ -n "$IMGKEYSECRET" ]; then
>          object_options="--object secret,id=keysec0,data=$IMGKEYSECRET"
> @@ -376,6 +377,13 @@ _rm_test_img()
>          # Remove all the extents for vmdk
>          "$QEMU_IMG" info "$img" 2>/dev/null | grep 'filename:' | cut -f 2 -d: \
>              | xargs -I {} rm -f "{}"
> +    elif [ "$IMGFMT" = "qcow2" ]; then
> +        # Remove external data file
> +        if echo "$IMGOPTS" | grep -q 'data_file='; then
> +            data_file=$(echo "$IMGOPTS" | sed -e 's/.*data_file=\([^,]*\).*/\1/' \
> +                                              -e "s#\\\$TEST_IMG#$img#")
Same here, even more evidence that it would be nice to move this to a common function.
Again, I am not 100% sure that this is the same regex, but it looks like that.

> +            rm -f "$data_file"
> +        fi
>      fi
>      rm -f "$img"
>  }


Best regards,
	Maxim Levitsky


