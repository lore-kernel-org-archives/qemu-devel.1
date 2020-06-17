Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9CBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4091D208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPndRk+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4091D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYTj-0004a5-IH
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlYSP-0003Ie-KZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:50:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26067
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlYSJ-0007s8-A3
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592401817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4S+ctHmqFnBof0eZqI5W8R6+gaA/Gg2ws1ZFdSeW8pU=;
 b=XPndRk+MmeqskWL7xFOa01XXVqJYVlsdBlHZTjhXp736gYPl7kba3ZCeWVcLnM3FHG9hqd
 Mvmfznaz5WidPWtMFPmVOjYZcGPnT0NsxPoiwATyp2OacTzvAfy2wLse1xUnumoQV9ci9T
 8u+HmlASzjFe3h77ChRfU8PmV7KFLnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-8jypbyNoN2qkdBAM7bUf6w-1; Wed, 17 Jun 2020 09:50:08 -0400
X-MC-Unique: 8jypbyNoN2qkdBAM7bUf6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0415218FE873;
 Wed, 17 Jun 2020 13:50:08 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-111.ams2.redhat.com
 [10.36.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85E325C1D4;
 Wed, 17 Jun 2020 13:50:03 +0000 (UTC)
Subject: Re: [PATCH 1/2] iotests: Make _filter_img_create more active
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20200616131756.1073438-1-mreitz@redhat.com>
 <20200616131756.1073438-2-mreitz@redhat.com>
 <4f74d8201f7b164a9d7139c3562c0bb8f5e60033.camel@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <5ae2cfe8-54ff-22d4-41d3-a53203a57cc6@redhat.com>
Date: Wed, 17 Jun 2020 15:50:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4f74d8201f7b164a9d7139c3562c0bb8f5e60033.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aubxBTOojTEZhP39helXBOreOJeyuRtBF"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aubxBTOojTEZhP39helXBOreOJeyuRtBF
Content-Type: multipart/mixed; boundary="NGl3suDV7aiMGKdnhJyt1OIiF27vIJdPj"

--NGl3suDV7aiMGKdnhJyt1OIiF27vIJdPj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.06.20 13:46, Maxim Levitsky wrote:
> On Tue, 2020-06-16 at 15:17 +0200, Max Reitz wrote:
>> Right now, _filter_img_create just filters out everything that looks
>> format-dependent, and applies some filename filters.  That means that we
>> have to add another filter line every time some format gets a new
>> creation option.  This can be avoided by instead discarding everything
>> and just keeping what we know is format-independent (format, size,
>> backing file, encryption information[1], preallocation) or just
>> interesting to have in the reference output (external data file path).
>>
>> Furthermore, we probably want to sort these options.  Format drivers are
>> not required to define them in any specific order, so the output is
>> effectively random (although this has never bothered us until now).  We
>> need a specific order for our reference outputs, though.  Unfortunately,
>> just using a plain "sort" would change a lot of existing reference
>> outputs, so we have to pre-filter the option keys to keep our existing
>> order (fmt, size, backing*, data, encryption info, preallocation).
>>
>> [1] Actually, the only thing that is really important is whether
>>     encryption is enabled or not.  A patch by Maxim thus removes all
>>     other "encrypt.*" options from the output:
>>     https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00339.ht=
ml
>>     But that patch needs to come later so we can get away with changing
>>     as few reference outputs in this patch here as possible.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/112.out       |   2 +-
>>  tests/qemu-iotests/153           |   9 ++-
>>  tests/qemu-iotests/common.filter | 100 +++++++++++++++++++++++--------
>>  3 files changed, 81 insertions(+), 30 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/112.out b/tests/qemu-iotests/112.out
>> index ae0318cabe..182655dbf6 100644
>> --- a/tests/qemu-iotests/112.out
>> +++ b/tests/qemu-iotests/112.out
>> @@ -5,7 +5,7 @@ QA output created by 112
>>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and =
may not exceed 64 bits
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and =
may not exceed 64 bits
>> -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 refcount_b=
its=3D-1
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and =
may not exceed 64 bits
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and =
may not exceed 64 bits
>> diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
>> index cf961d3609..11e3d28841 100755
>> --- a/tests/qemu-iotests/153
>> +++ b/tests/qemu-iotests/153
>> @@ -167,11 +167,10 @@ done
>> =20
>>  echo
>>  echo "=3D=3D Creating ${TEST_IMG}.[abc] =3D=3D" | _filter_testdir
>> -(
>> -    $QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}"
>> -    $QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}"
>> -    $QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b"
>> -) | _filter_img_create
>> +$QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}" | _filter_im=
g_create
>> +$QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}" | _filter_im=
g_create
>> +$QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b" \
>> +    | _filter_img_create
>> =20
>>  echo
>>  echo "=3D=3D Two devices sharing the same file in backing chain =3D=3D"
>=20
> I guess this is done because now the filter expectes only a single
> qemu-img output.

Yes, that=E2=80=99s right.

> IMHO this is better anyway.
>=20
>> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/commo=
n.filter
>> index 03e4f71808..f104ad7a9b 100644
>> --- a/tests/qemu-iotests/common.filter
>> +++ b/tests/qemu-iotests/common.filter
>> @@ -122,38 +122,90 @@ _filter_actual_image_size()
>>  # replace driver-specific options in the "Formatting..." line
>>  _filter_img_create()
>>  {
>> -    data_file_filter=3D()
>> -    if data_file=3D$(_get_data_file "$TEST_IMG"); then
>> -        data_file_filter=3D(-e "s# data_file=3D$data_file##")
>> +    # Keep QMP output unchanged
>> +    qmp_pre=3D''
>> +    qmp_post=3D''
>> +    to_filter=3D''
>> +
>> +    while read -r line; do
>> +        if echo "$line" | grep -q '^{.*}$'; then
>> +            if [ -z "$to_filter" ]; then
>> +                # Use $'\n' so the newline is not dropped on variable
>> +                # expansion
>> +                qmp_pre=3D"$qmp_pre$line"$'\n'
>> +            else
>> +                qmp_post=3D"$qmp_post$line"$'\n'
>> +            fi
>> +        else
>> +            to_filter=3D"$to_filter$line"$'\n'
>> +        fi
>> +    done
>=20
> The above code basically assumes that qmp output starts with '{' and ends=
 with '}'
> which I guess is fair, and then it assumes that we can have set of qmp co=
mmands prior
> to qemu-img line and another set of qmp commands after it.
> To me it feels like we should have another filter for that, since
> qemu-img itself doesn't use qmp.

Yes, but drive-backup and drive-mirror with mode=3Dabsolute-paths use
bdrv_img_create() (quiet=3Dfalse), which emits the =E2=80=9CFormatting=E2=
=80=9D line, too.
 So some QMP commands may emit it and then require the same filtering as
qemu-img create.

Not having to do that would certainly make things simpler.

> Which test needs it?

141.

>> +
>> +    readarray -td '' formatting_line < \
>> +        <(echo "$to_filter" | sed -e 's/, fmt=3D/\x0/')
> OK, took me a while to understand what this does, but looks OK.

Maybe I should at least put a comment like =E2=80=9CSplit $to_filter into t=
he
pre-options part (before ", fmt=3D") and the options part (starting with
"fmt=3D").

>> +
>> +    filename_part=3D${formatting_line[0]}
>> +    if [ -n "${formatting_line[1]}" ]; then
>> +        options=3D"fmt=3D${formatting_line[1]}"
>> +    else
>> +        options=3D''
>>      fi
>>
> OK.
>=20
>> =20
>> -    $SED "${data_file_filter[@]}" \
>> +    # Set grep_data_file to '\|data_file' to keep it; make it empty
>> +    # to drop it.
>> +    # We want to drop it if it is part of the global $IMGOPTS, and we
>> +    # want to keep it otherwise (if the test specifically wants to
>> +    # test data files).
>> +    grep_data_file=3D'\|data_file'
>> +    if _get_data_file "$TEST_IMG" > /dev/null; then
>> +        grep_data_file=3D''
>> +    fi
>> +
>> +    filename_filters=3D(
>>          -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
>>          -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
>>          -e "s#$TEST_DIR#TEST_DIR#g" \
>>          -e "s#$SOCK_DIR#SOCK_DIR#g" \
>>          -e "s#$IMGFMT#IMGFMT#g" \
>>          -e 's#nbd:127.0.0.1:[0-9]\\+#TEST_DIR/t.IMGFMT#g' \
>> -        -e 's#nbd+unix:///\??socket=3DSOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g'=
 \
>> -        -e "s# encryption=3Doff##g" \
>> -        -e "s# cluster_size=3D[0-9]\\+##g" \
>> -        -e "s# table_size=3D[0-9]\\+##g" \
>> -        -e "s# compat=3D[^ ]*##g" \
>> -        -e "s# compat6=3D\\(on\\|off\\)##g" \
>> -        -e "s# static=3D\\(on\\|off\\)##g" \
>> -        -e "s# zeroed_grain=3D\\(on\\|off\\)##g" \
>> -        -e "s# subformat=3D[^ ]*##g" \
>> -        -e "s# adapter_type=3D[^ ]*##g" \
>> -        -e "s# hwversion=3D[^ ]*##g" \
>> -        -e "s# lazy_refcounts=3D\\(on\\|off\\)##g" \
>> -        -e "s# block_size=3D[0-9]\\+##g" \
>> -        -e "s# block_state_zero=3D\\(on\\|off\\)##g" \
>> -        -e "s# log_size=3D[0-9]\\+##g" \
>> -        -e "s# refcount_bits=3D[0-9]\\+##g" \
>> -        -e "s# key-secret=3D[a-zA-Z0-9]\\+##g" \
>> -        -e "s# iter-time=3D[0-9]\\+##g" \
>> -        -e "s# force_size=3D\\(on\\|off\\)##g" \
>> -        -e "s# compression_type=3D[a-zA-Z0-9]\\+##g"
>> +        -e 's#nbd+unix:///\??socket=3DSOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g'
>> +    )
>> +
>> +    filename_part=3D$(echo "$filename_part" | $SED "${filename_filters[=
@]}")
> Looks good as well.
>=20
>> +
>> +    # Break the option line before each option (preserving pre-existing
>> +    # line breaks by replacing them by \0 and restoring them at the end=
),
>> +    # then filter out the options we want to keep and sort them accordi=
ng
>> +    # to some order that all block drivers used at the time of writing
>> +    # this function.
>> +    options=3D$(
>> +        echo "$options" \
>> +        | tr '\n' '\0' \
>> +        | sed -e 's/\x0$//' -e 's/ \([a-z0-9_.-]*\)=3D/\n\1=3D/g' \
> You sometimes use $SED and sometimes sed. Is this intentional?

Oops, no.  It should be $SED everywhere.

>> +        | grep -ae "^\(fmt\\|size\\|backing\\|preallocation\\|encrypt$g=
rep_data_file\\)" \
>> +        | $SED "${filename_filters[@]}" \
>> +            -e 's/^\(fmt\)/0-\1/' \
>> +            -e 's/^\(size\)/1-\1/' \
>> +            -e 's/^\(backing\)/2-\1/' \
>> +            -e 's/^\(data_file\)/3-\1/' \
>> +            -e 's/^\(encryption\)/4-\1/' \
>> +            -e 's/^\(encrypt\.format\)/5-\1/' \
>> +            -e 's/^\(encrypt\.key-secret\)/6-\1/' \
>> +            -e 's/^\(encrypt\.iter-time\)/7-\1/' \
>> +            -e 's/^\(preallocation\)/8-\1/' \
> All right, I understand this now, but do we have to do this?
> Maybe it is better to just update the outputs once to avoid keeping
> the custom sort order?

Well.  I don=E2=80=99t know.  The advantage of doing this is that I can=E2=
=80=99t
accidentally miss updating any reference outputs that aren=E2=80=99t used o=
n my
machine (like 026.out.nocache or 051.out).

So we don=E2=80=99t strictly have to do this, but I found this to be simple=
r.
If someone wants to drop this and in turn update all reference outputs,
they=E2=80=99ll be my guest, but I preferred not to do that myself.

>> +        | sort \
>> +        | $SED -e 's/^[0-9]-//' \
>> +        | tr '\n\0' ' \n' \
>> +        | $SED -e 's/^ *$//' -e 's/ *$//'
>> +    )
>=20
> For the above bash pipeline overall: It was hard to decipher :-), but I m=
ust admit
> I learned something from it.

I definitely learned something while working on this, too.  I=E2=80=99m not=
 sure
whether I also gained any useful knowledge, though. O:)

>> +
>> +    echo -n "$qmp_pre"
>> +    if [ -n "$options" ]; then
>> +        echo "$filename_part, $options"
>> +    elif [ -n "$filename_part" ]; then
>> +        echo "$filename_part"
>> +    fi
>> +    echo -n "$qmp_post"
>>  }
>> =20
>>  _filter_img_create_size()
>=20
> Overall I like the idea of this patch.

Good!

Thanks for reviewing! :)


--NGl3suDV7aiMGKdnhJyt1OIiF27vIJdPj--

--aubxBTOojTEZhP39helXBOreOJeyuRtBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7qH4kACgkQ9AfbAGHV
z0CTIQf+N25qtbceEbTEouSIaSNvsl/C1ZK4md3geGpR99n4x2OFTMX7V4mQ31xR
6+bEcgVDaIZXwDV04lHRNXTpAMpqIWeYKcPqVoQj1nhHT0qSTe2IWM9XXfg93ZNo
aGLSb9aWwKng1fxyd0adKAf+5Z7RLlC3VHNV8CGlZ9Fo5xHDaIVpIJd2tePzy8pt
w7/0y4C7Jq9e1gLXdByjhWVkUus0haFqsolIrEMnXu3MPCGCevW05rmXs+9MklFC
6R1otdpkL7k6iIq/zeGFsWZ91v3f7riJr09NGcJIlxf7Tw1lMy8wM/zBJLsWKGj5
tfaKARvqUdTno6KPZTAeJsn3RAU73Q==
=OHLu
-----END PGP SIGNATURE-----

--aubxBTOojTEZhP39helXBOreOJeyuRtBF--


