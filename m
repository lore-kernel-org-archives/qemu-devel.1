Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B106BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 11:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7752098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 11:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPOcHuVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7752098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlWY0-0005XW-KL
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 07:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jlWX2-0004vE-Ui
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 07:47:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54092
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jlWX0-0003lt-B0
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 07:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592394419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wwo5IqD8QQ9B1U3m4S59M1NmkW9u0Qvueq15vDmfLdc=;
 b=bPOcHuVyT830rWBD6OWeWbklzC4D2QbDiYeUOP4NuGoXs2ugK7Sqpw7MUnBohc0AuxGlMm
 bUwyBJVraQwCACnmj3UhL5RDSMtBppdgN7fkp99uFDBaiucT18znx51DPsELkVasCbjkoe
 a5QlCg8mgSIdHraDgt4whp9J7JkLobE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-lQCKyDQLPcGz2gZU7BOwvw-1; Wed, 17 Jun 2020 07:46:48 -0400
X-MC-Unique: lQCKyDQLPcGz2gZU7BOwvw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A69B080330C;
 Wed, 17 Jun 2020 11:46:47 +0000 (UTC)
Received: from starship (unknown [10.35.206.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30A9D7CCCA;
 Wed, 17 Jun 2020 11:46:45 +0000 (UTC)
Message-ID: <4f74d8201f7b164a9d7139c3562c0bb8f5e60033.camel@redhat.com>
Subject: Re: [PATCH 1/2] iotests: Make _filter_img_create more active
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 17 Jun 2020 14:46:44 +0300
In-Reply-To: <20200616131756.1073438-2-mreitz@redhat.com>
References: <20200616131756.1073438-1-mreitz@redhat.com>
 <20200616131756.1073438-2-mreitz@redhat.com>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-06-16 at 15:17 +0200, Max Reitz wrote:
> Right now, _filter_img_create just filters out everything that looks
> format-dependent, and applies some filename filters.  That means that we
> have to add another filter line every time some format gets a new
> creation option.  This can be avoided by instead discarding everything
> and just keeping what we know is format-independent (format, size,
> backing file, encryption information[1], preallocation) or just
> interesting to have in the reference output (external data file path).
> 
> Furthermore, we probably want to sort these options.  Format drivers are
> not required to define them in any specific order, so the output is
> effectively random (although this has never bothered us until now).  We
> need a specific order for our reference outputs, though.  Unfortunately,
> just using a plain "sort" would change a lot of existing reference
> outputs, so we have to pre-filter the option keys to keep our existing
> order (fmt, size, backing*, data, encryption info, preallocation).
> 
> [1] Actually, the only thing that is really important is whether
>     encryption is enabled or not.  A patch by Maxim thus removes all
>     other "encrypt.*" options from the output:
>     https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00339.html
>     But that patch needs to come later so we can get away with changing
>     as few reference outputs in this patch here as possible.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/112.out       |   2 +-
>  tests/qemu-iotests/153           |   9 ++-
>  tests/qemu-iotests/common.filter | 100 +++++++++++++++++++++++--------
>  3 files changed, 81 insertions(+), 30 deletions(-)
> 
> diff --git a/tests/qemu-iotests/112.out b/tests/qemu-iotests/112.out
> index ae0318cabe..182655dbf6 100644
> --- a/tests/qemu-iotests/112.out
> +++ b/tests/qemu-iotests/112.out
> @@ -5,7 +5,7 @@ QA output created by 112
>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 refcount_bits=-1
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
> diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
> index cf961d3609..11e3d28841 100755
> --- a/tests/qemu-iotests/153
> +++ b/tests/qemu-iotests/153
> @@ -167,11 +167,10 @@ done
>  
>  echo
>  echo "== Creating ${TEST_IMG}.[abc] ==" | _filter_testdir
> -(
> -    $QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}"
> -    $QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}"
> -    $QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b"
> -) | _filter_img_create
> +$QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}" | _filter_img_create
> +$QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}" | _filter_img_create
> +$QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b" \
> +    | _filter_img_create
>  
>  echo
>  echo "== Two devices sharing the same file in backing chain =="

I guess this is done because now the filter expectes only a single
qemu-img output. IMHO this is better anyway.

> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> index 03e4f71808..f104ad7a9b 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -122,38 +122,90 @@ _filter_actual_image_size()
>  # replace driver-specific options in the "Formatting..." line
>  _filter_img_create()
>  {
> -    data_file_filter=()
> -    if data_file=$(_get_data_file "$TEST_IMG"); then
> -        data_file_filter=(-e "s# data_file=$data_file##")
> +    # Keep QMP output unchanged
> +    qmp_pre=''
> +    qmp_post=''
> +    to_filter=''
> +
> +    while read -r line; do
> +        if echo "$line" | grep -q '^{.*}$'; then
> +            if [ -z "$to_filter" ]; then
> +                # Use $'\n' so the newline is not dropped on variable
> +                # expansion
> +                qmp_pre="$qmp_pre$line"$'\n'
> +            else
> +                qmp_post="$qmp_post$line"$'\n'
> +            fi
> +        else
> +            to_filter="$to_filter$line"$'\n'
> +        fi
> +    done

The above code basically assumes that qmp output starts with '{' and ends with '}'
which I guess is fair, and then it assumes that we can have set of qmp commands prior
to qemu-img line and another set of qmp commands after it.
To me it feels like we should have another filter for that, since
qemu-img itself doesn't use qmp.
Which test needs it?

> +
> +    readarray -td '' formatting_line < \
> +        <(echo "$to_filter" | sed -e 's/, fmt=/\x0/')
OK, took me a while to understand what this does, but looks OK.

> +
> +    filename_part=${formatting_line[0]}
> +    if [ -n "${formatting_line[1]}" ]; then
> +        options="fmt=${formatting_line[1]}"
> +    else
> +        options=''
>      fi
> 
OK.

>  
> -    $SED "${data_file_filter[@]}" \
> +    # Set grep_data_file to '\|data_file' to keep it; make it empty
> +    # to drop it.
> +    # We want to drop it if it is part of the global $IMGOPTS, and we
> +    # want to keep it otherwise (if the test specifically wants to
> +    # test data files).
> +    grep_data_file='\|data_file'
> +    if _get_data_file "$TEST_IMG" > /dev/null; then
> +        grep_data_file=''
> +    fi
> +
> +    filename_filters=(
>          -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
>          -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
>          -e "s#$TEST_DIR#TEST_DIR#g" \
>          -e "s#$SOCK_DIR#SOCK_DIR#g" \
>          -e "s#$IMGFMT#IMGFMT#g" \
>          -e 's#nbd:127.0.0.1:[0-9]\\+#TEST_DIR/t.IMGFMT#g' \
> -        -e 's#nbd+unix:///\??socket=SOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g' \
> -        -e "s# encryption=off##g" \
> -        -e "s# cluster_size=[0-9]\\+##g" \
> -        -e "s# table_size=[0-9]\\+##g" \
> -        -e "s# compat=[^ ]*##g" \
> -        -e "s# compat6=\\(on\\|off\\)##g" \
> -        -e "s# static=\\(on\\|off\\)##g" \
> -        -e "s# zeroed_grain=\\(on\\|off\\)##g" \
> -        -e "s# subformat=[^ ]*##g" \
> -        -e "s# adapter_type=[^ ]*##g" \
> -        -e "s# hwversion=[^ ]*##g" \
> -        -e "s# lazy_refcounts=\\(on\\|off\\)##g" \
> -        -e "s# block_size=[0-9]\\+##g" \
> -        -e "s# block_state_zero=\\(on\\|off\\)##g" \
> -        -e "s# log_size=[0-9]\\+##g" \
> -        -e "s# refcount_bits=[0-9]\\+##g" \
> -        -e "s# key-secret=[a-zA-Z0-9]\\+##g" \
> -        -e "s# iter-time=[0-9]\\+##g" \
> -        -e "s# force_size=\\(on\\|off\\)##g" \
> -        -e "s# compression_type=[a-zA-Z0-9]\\+##g"
> +        -e 's#nbd+unix:///\??socket=SOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g'
> +    )
> +
> +    filename_part=$(echo "$filename_part" | $SED "${filename_filters[@]}")
Looks good as well.

> +
> +    # Break the option line before each option (preserving pre-existing
> +    # line breaks by replacing them by \0 and restoring them at the end),
> +    # then filter out the options we want to keep and sort them according
> +    # to some order that all block drivers used at the time of writing
> +    # this function.
> +    options=$(
> +        echo "$options" \
> +        | tr '\n' '\0' \
> +        | sed -e 's/\x0$//' -e 's/ \([a-z0-9_.-]*\)=/\n\1=/g' \
You sometimes use $SED and sometimes sed. Is this intentional?

> +        | grep -ae "^\(fmt\\|size\\|backing\\|preallocation\\|encrypt$grep_data_file\\)" \
> +        | $SED "${filename_filters[@]}" \
> +            -e 's/^\(fmt\)/0-\1/' \
> +            -e 's/^\(size\)/1-\1/' \
> +            -e 's/^\(backing\)/2-\1/' \
> +            -e 's/^\(data_file\)/3-\1/' \
> +            -e 's/^\(encryption\)/4-\1/' \
> +            -e 's/^\(encrypt\.format\)/5-\1/' \
> +            -e 's/^\(encrypt\.key-secret\)/6-\1/' \
> +            -e 's/^\(encrypt\.iter-time\)/7-\1/' \
> +            -e 's/^\(preallocation\)/8-\1/' \
All right, I understand this now, but do we have to do this?
Maybe it is better to just update the outputs once to avoid keeping
the custom sort order?

> +        | sort \
> +        | $SED -e 's/^[0-9]-//' \
> +        | tr '\n\0' ' \n' \
> +        | $SED -e 's/^ *$//' -e 's/ *$//'
> +    )

For the above bash pipeline overall: It was hard to decipher :-), but I must admit
I learned something from it.

> +
> +    echo -n "$qmp_pre"
> +    if [ -n "$options" ]; then
> +        echo "$filename_part, $options"
> +    elif [ -n "$filename_part" ]; then
> +        echo "$filename_part"
> +    fi
> +    echo -n "$qmp_post"
>  }
>  
>  _filter_img_create_size()

Overall I like the idea of this patch.

Best regards,
	Maxim Levitsky



