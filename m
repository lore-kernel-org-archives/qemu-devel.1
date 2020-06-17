Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F98C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A60206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IzOVPFn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A60206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYxD-0008OQ-G8
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlYwH-0007K6-A0
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:21:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23613
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlYwE-0005An-Ro
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592403673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3chSIl8vzFRlNgJ64fnwA/PTDd/9BgckXEuQCV0jhBQ=;
 b=IzOVPFn24vt7hdPFTuM9EUbve9csqaUD0I3lMkZ4ZEhKpGWZh95wJOKcfDGpE1n0Jh38wb
 jxrn+SisU297iCSRRMW56B1wkeVzBRfcwuNYN/iZZrw6JjOOrjaCHQTjaGuZdh9vZ3eDoZ
 O40yQqijYjDbhKcTl8iiBqCqWhYAjA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-Ho4-xBAOPvyo-FkL52n8dw-1; Wed, 17 Jun 2020 10:21:03 -0400
X-MC-Unique: Ho4-xBAOPvyo-FkL52n8dw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF4AAEC1A4;
 Wed, 17 Jun 2020 14:21:01 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-111.ams2.redhat.com
 [10.36.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88C625C1D6;
 Wed, 17 Jun 2020 14:21:00 +0000 (UTC)
Subject: Re: [PATCH 1/2] iotests: Make _filter_img_create more active
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20200616131756.1073438-1-mreitz@redhat.com>
 <20200616131756.1073438-2-mreitz@redhat.com>
 <4f74d8201f7b164a9d7139c3562c0bb8f5e60033.camel@redhat.com>
 <5ae2cfe8-54ff-22d4-41d3-a53203a57cc6@redhat.com>
 <a40229992488e26ebafd04215cbdd31acf9a35ea.camel@redhat.com>
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
Message-ID: <e4710282-d6c7-ee26-9174-780bf1c8eb27@redhat.com>
Date: Wed, 17 Jun 2020 16:20:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a40229992488e26ebafd04215cbdd31acf9a35ea.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7NlkVAWbRRixBRKrs7YOnHYdcMkKZK5Vv"
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
--7NlkVAWbRRixBRKrs7YOnHYdcMkKZK5Vv
Content-Type: multipart/mixed; boundary="Pxta0MIgIZ3qyPD334Q7HkSx3OUMEjmBz"

--Pxta0MIgIZ3qyPD334Q7HkSx3OUMEjmBz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.06.20 16:02, Maxim Levitsky wrote:
> On Wed, 2020-06-17 at 15:50 +0200, Max Reitz wrote:
>> On 17.06.20 13:46, Maxim Levitsky wrote:
>>> On Tue, 2020-06-16 at 15:17 +0200, Max Reitz wrote:
>>>> Right now, _filter_img_create just filters out everything that looks
>>>> format-dependent, and applies some filename filters.  That means that =
we
>>>> have to add another filter line every time some format gets a new
>>>> creation option.  This can be avoided by instead discarding everything
>>>> and just keeping what we know is format-independent (format, size,
>>>> backing file, encryption information[1], preallocation) or just
>>>> interesting to have in the reference output (external data file path).
>>>>
>>>> Furthermore, we probably want to sort these options.  Format drivers a=
re
>>>> not required to define them in any specific order, so the output is
>>>> effectively random (although this has never bothered us until now).  W=
e
>>>> need a specific order for our reference outputs, though.  Unfortunatel=
y,
>>>> just using a plain "sort" would change a lot of existing reference
>>>> outputs, so we have to pre-filter the option keys to keep our existing
>>>> order (fmt, size, backing*, data, encryption info, preallocation).
>>>>
>>>> [1] Actually, the only thing that is really important is whether
>>>>     encryption is enabled or not.  A patch by Maxim thus removes all
>>>>     other "encrypt.*" options from the output:
>>>>     https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00339.=
html
>>>>     But that patch needs to come later so we can get away with changin=
g
>>>>     as few reference outputs in this patch here as possible.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  tests/qemu-iotests/112.out       |   2 +-
>>>>  tests/qemu-iotests/153           |   9 ++-
>>>>  tests/qemu-iotests/common.filter | 100 +++++++++++++++++++++++-------=
-
>>>>  3 files changed, 81 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/tests/qemu-iotests/112.out b/tests/qemu-iotests/112.out
>>>> index ae0318cabe..182655dbf6 100644
>>>> --- a/tests/qemu-iotests/112.out
>>>> +++ b/tests/qemu-iotests/112.out
>>>> @@ -5,7 +5,7 @@ QA output created by 112
>>>>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two an=
d may not exceed 64 bits
>>>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>>>>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two an=
d may not exceed 64 bits
>>>> -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 refcount=
_bits=3D-1
>>>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>>>>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two an=
d may not exceed 64 bits
>>>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>>>>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two an=
d may not exceed 64 bits
>>>> diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
>>>> index cf961d3609..11e3d28841 100755
>>>> --- a/tests/qemu-iotests/153
>>>> +++ b/tests/qemu-iotests/153
>>>> @@ -167,11 +167,10 @@ done
>>>> =20
>>>>  echo
>>>>  echo "=3D=3D Creating ${TEST_IMG}.[abc] =3D=3D" | _filter_testdir
>>>> -(
>>>> -    $QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}"
>>>> -    $QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}"
>>>> -    $QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b"
>>>> -) | _filter_img_create
>>>> +$QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}" | _filter_=
img_create
>>>> +$QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}" | _filter_=
img_create
>>>> +$QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b" \
>>>> +    | _filter_img_create
>>>> =20
>>>>  echo
>>>>  echo "=3D=3D Two devices sharing the same file in backing chain =3D=
=3D"
>>>
>>> I guess this is done because now the filter expectes only a single
>>> qemu-img output.
>>
>> Yes, that=E2=80=99s right.
>>
>>> IMHO this is better anyway.
>>>
>>>> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/com=
mon.filter
>>>> index 03e4f71808..f104ad7a9b 100644
>>>> --- a/tests/qemu-iotests/common.filter
>>>> +++ b/tests/qemu-iotests/common.filter
>>>> @@ -122,38 +122,90 @@ _filter_actual_image_size()
>>>>  # replace driver-specific options in the "Formatting..." line
>>>>  _filter_img_create()
>>>>  {
>>>> -    data_file_filter=3D()
>>>> -    if data_file=3D$(_get_data_file "$TEST_IMG"); then
>>>> -        data_file_filter=3D(-e "s# data_file=3D$data_file##")
>>>> +    # Keep QMP output unchanged
>>>> +    qmp_pre=3D''
>>>> +    qmp_post=3D''
>>>> +    to_filter=3D''
>>>> +
>>>> +    while read -r line; do
>>>> +        if echo "$line" | grep -q '^{.*}$'; then
>>>> +            if [ -z "$to_filter" ]; then
>>>> +                # Use $'\n' so the newline is not dropped on variable
>>>> +                # expansion
>>>> +                qmp_pre=3D"$qmp_pre$line"$'\n'
>>>> +            else
>>>> +                qmp_post=3D"$qmp_post$line"$'\n'
>>>> +            fi
>>>> +        else
>>>> +            to_filter=3D"$to_filter$line"$'\n'
>>>> +        fi
>>>> +    done
>>>
>>> The above code basically assumes that qmp output starts with '{' and en=
ds with '}'
>>> which I guess is fair, and then it assumes that we can have set of qmp =
commands prior
>>> to qemu-img line and another set of qmp commands after it.
>>> To me it feels like we should have another filter for that, since
>>> qemu-img itself doesn't use qmp.
>>
>> Yes, but drive-backup and drive-mirror with mode=3Dabsolute-paths use
>> bdrv_img_create() (quiet=3Dfalse), which emits the =E2=80=9CFormatting=
=E2=80=9D line, too.
>>  So some QMP commands may emit it and then require the same filtering as
>> qemu-img create.
>=20
> Ah. Do we need this though?=20
> Assuming yes, maybe we should create a new filter called something like _=
filter_drive_backup_mirror
> or something like that that would filter qmp output, and pipe the 'Format=
ting' line
> to _filter_img_create which then can have the qmp parsing part removed?

Hm.  I don=E2=80=99t think it would be that much more simpler.  (Instead of=
 just
putting it into this function.)  But perhaps cleaner.

One of the problems is that I don=E2=80=99t want to actually parse JSON her=
e.
That leaves us with the problem of what to do with line breaks.  Both
QMP stuff and any Formatting line may contain line breaks (and there
actually are iotests that have line breaks in their Formatting line).

In this function, I opted to allow line breaks in Formatting lines, but
not in QMP.  If we had a separate function specifically for Formatting
stuff in QMP, I think it should probably work the other way around.

So what this other function would do is probably to just echo all lines
that don=E2=80=99t start with Formatting, and filter those Formatting line(=
s)
through _filter_img_create.  (I don=E2=80=99t think we need to support
multi-line Formatting lines in QMP output.)

I think that should work.  And it=E2=80=99s probably indeed cleaner than pu=
tting
both into a single function.  I=E2=80=99ll try my hands on it.

[...]

>>>> +        | grep -ae "^\(fmt\\|size\\|backing\\|preallocation\\|encrypt=
$grep_data_file\\)" \
>>>> +        | $SED "${filename_filters[@]}" \
>>>> +            -e 's/^\(fmt\)/0-\1/' \
>>>> +            -e 's/^\(size\)/1-\1/' \
>>>> +            -e 's/^\(backing\)/2-\1/' \
>>>> +            -e 's/^\(data_file\)/3-\1/' \
>>>> +            -e 's/^\(encryption\)/4-\1/' \
>>>> +            -e 's/^\(encrypt\.format\)/5-\1/' \
>>>> +            -e 's/^\(encrypt\.key-secret\)/6-\1/' \
>>>> +            -e 's/^\(encrypt\.iter-time\)/7-\1/' \
>>>> +            -e 's/^\(preallocation\)/8-\1/' \
>>> All right, I understand this now, but do we have to do this?
>>> Maybe it is better to just update the outputs once to avoid keeping
>>> the custom sort order?
>>
>> Well.  I don=E2=80=99t know.  The advantage of doing this is that I can=
=E2=80=99t
>> accidentally miss updating any reference outputs that aren=E2=80=99t use=
d on my
>> machine (like 026.out.nocache or 051.out).
>=20
> Fair enough. A follow up patch can always be made to fix this.

Right.

>> So we don=E2=80=99t strictly have to do this, but I found this to be sim=
pler.
>> If someone wants to drop this and in turn update all reference outputs,
>> they=E2=80=99ll be my guest, but I preferred not to do that myself.
>>
>>>> +        | sort \
>>>> +        | $SED -e 's/^[0-9]-//' \
>>>> +        | tr '\n\0' ' \n' \
>>>> +        | $SED -e 's/^ *$//' -e 's/ *$//'
>>>> +    )
>>>
>>> For the above bash pipeline overall: It was hard to decipher :-), but I=
 must admit
>>> I learned something from it.
>>
>> I definitely learned something while working on this, too.  I=E2=80=99m =
not sure
>> whether I also gained any useful knowledge, though. O:)
>=20
> In my past experience, any knowelege eventually turns out to be useful.

In my experience, some knowledge can turn out harmful, because suddenly
you=E2=80=99re the expert on it. O:)

(I really don=E2=80=99t want to be the expert on bash.  Luckily, though, we=
 have
Eric who fills that role quite nicely already.)


--Pxta0MIgIZ3qyPD334Q7HkSx3OUMEjmBz--

--7NlkVAWbRRixBRKrs7YOnHYdcMkKZK5Vv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7qJssACgkQ9AfbAGHV
z0CZCAgAqIIMrSD9izNHsH28HwA0CR90jlrreXcI3r1AZr4xBsGaUkacU2hlcdjS
cK2vQltmpSXIVfGIXdD7ekQ74eTIvyYRQawOBbkUl0QPy9VoSMUJkleVfBJwDRbO
DPlD24BTGXOgirv7uKHM3bBprVV//9/tW5db8ICXV/Pzw3Q7WxO7s1FI9oo8iV22
1eDSBD73q0w/PYPCFQlSOAnjCauWG5bHxfsWYrGBTuwGMIc5ZCeBmFJNmKkssWzl
enzOW0s07ql2ixJyI5lmLHM1kkXKqgk+V/UHwzboK0qQA33W93uZ6P2fiyS7S+ts
vWSXtWkgEIiNeVsoQhEHhVZM9/88nw==
=VYn4
-----END PGP SIGNATURE-----

--7NlkVAWbRRixBRKrs7YOnHYdcMkKZK5Vv--


