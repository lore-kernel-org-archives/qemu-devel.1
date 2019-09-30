Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D35C35280
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935DC2086A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935DC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvzB-0005Gy-Gi
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iEvxF-0003yr-Ef
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iEvxE-0007Z9-5R
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:43:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iEvxB-0007Xh-Ae; Mon, 30 Sep 2019 09:43:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90F2110C0933;
 Mon, 30 Sep 2019 13:43:04 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-240.brq.redhat.com
 [10.40.204.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BD415C224;
 Mon, 30 Sep 2019 13:43:03 +0000 (UTC)
Subject: Re: [PATCH 18/18] iotests: Allow check -o data_file
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-19-mreitz@redhat.com>
 <b6e37ff6bc37798d98731b0744f870fcce3dd156.camel@redhat.com>
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
Message-ID: <a3a646e0-7202-3af3-802a-44da48e61b3a@redhat.com>
Date: Mon, 30 Sep 2019 15:43:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <b6e37ff6bc37798d98731b0744f870fcce3dd156.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rgta05bSzL7S00ZAQexzU0xUhbIVBgeoT"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 30 Sep 2019 13:43:04 +0000 (UTC)
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rgta05bSzL7S00ZAQexzU0xUhbIVBgeoT
Content-Type: multipart/mixed; boundary="K1DAtE6IdOMY9p73u0jmUnGeH3SSxpDUO"

--K1DAtE6IdOMY9p73u0jmUnGeH3SSxpDUO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.09.19 18:39, Maxim Levitsky wrote:
> On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
>> The problem with allowing the data_file option is that you want to use=
 a
>> different data file per image used in the test.  Therefore, we need to=

>> allow patterns like -o data_file=3D'$TEST_IMG.data_file'.
>>
>> Then, we need to filter it out from qemu-img map, qemu-img create, and=

>> remove the data file in _rm_test_img.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/common.filter | 21 +++++++++++++++++++--
>>  tests/qemu-iotests/common.rc     | 10 +++++++++-
>>  2 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/com=
mon.filter
>> index 841f7642af..a11f9a8972 100644
>> --- a/tests/qemu-iotests/common.filter
>> +++ b/tests/qemu-iotests/common.filter
>> @@ -115,7 +115,15 @@ _filter_actual_image_size()
>>  # replace driver-specific options in the "Formatting..." line
>>  _filter_img_create()
>>  {
>> -    $SED -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
>> +    data_file_filter=3D()
>> +    if echo "$IMGOPTS" | grep -q 'data_file=3D'; then
>> +        data_file=3D$(echo "$IMGOPTS" | sed -e 's/.*\(data_file=3D[^,=
]*\).*/\1/' \
>> +                                          -e "s#\\\$TEST_IMG#$TEST_IM=
G#")
> Could you maybe add a comment on this regular expression, similar
> to what is in the commit message?
>=20
>> +        data_file_filter=3D(-e "s# $data_file##")
> Why to use array here? A variable would work too I think.

Because I find it to be much simpler to quote correctly.

>> +    fi
>> +
>> +    $SED "${data_file_filter[@]}" \
>> +        -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
>>          -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
>>          -e "s#$TEST_DIR#TEST_DIR#g" \
>>          -e "s#$IMGFMT#IMGFMT#g" \
>> @@ -198,9 +206,18 @@ _filter_img_info()
>>  # human and json output
>>  _filter_qemu_img_map()
>>  {
>> +    data_file_filter=3D()
>> +    if echo "$IMGOPTS" | grep -q 'data_file=3D'; then
>> +        data_file_pattern=3D$(echo "$IMGOPTS" | sed -e 's/.*data_file=
=3D\([^,]*\).*/\1/' \
>> +                                                  -e 's#\$TEST_IMG#\\=
(.*\\)#')
>> +        data_file_filter=3D(-e "s#$data_file_pattern#\\1#")
> Seems to do the same thing, but in slightly different way.

It does a very different thing, in that it creates a sed pattern.

I=E2=80=99d first need to get comfortable with the thought of having a co=
mmon
function _data_file_from_imgopts and then pass a '\(.*\)' to it, which
would look weird.

Or maybe even a '\\(.*\\)', because I=E2=80=99d still have to take the se=
d
escaping into account, even in that function=E2=80=99s caller, which is w=
eird, too.

> Maybe make a function to avoid duplication?
> I am not 100% sure though.
>=20
>> +    fi
>> +
>>      $SED -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
>>          -e 's/"offset": [0-9]\+/"offset": OFFSET/g' \
>> -        -e 's/Mapped to *//' | _filter_testdir | _filter_imgfmt
>> +        -e 's/Mapped to *//' \
>> +        "${data_file_filter[@]}" \
>> +        | _filter_testdir | _filter_imgfmt
>>  }
>> =20
>>  _filter_nbd()
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.=
rc
>> index f3784077de..834ece12e4 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -297,7 +297,8 @@ _make_test_img()
>>      fi
>> =20
>>      if [ -n "$IMGOPTS" ]; then
>> -        optstr=3D$(_optstr_add "$optstr" "$IMGOPTS")
>> +        imgopts_expanded=3D$(echo "$IMGOPTS" | sed -e "s#\\\$TEST_IMG=
#$img_name#")
>> +        optstr=3D$(_optstr_add "$optstr" "$imgopts_expanded")
> Also a comment explaining why this is needed would be welcome.
>=20
>>      fi
>>      if [ -n "$IMGKEYSECRET" ]; then
>>          object_options=3D"--object secret,id=3Dkeysec0,data=3D$IMGKEY=
SECRET"
>> @@ -376,6 +377,13 @@ _rm_test_img()
>>          # Remove all the extents for vmdk
>>          "$QEMU_IMG" info "$img" 2>/dev/null | grep 'filename:' | cut =
-f 2 -d: \
>>              | xargs -I {} rm -f "{}"
>> +    elif [ "$IMGFMT" =3D "qcow2" ]; then
>> +        # Remove external data file
>> +        if echo "$IMGOPTS" | grep -q 'data_file=3D'; then
>> +            data_file=3D$(echo "$IMGOPTS" | sed -e 's/.*data_file=3D\=
([^,]*\).*/\1/' \
>> +                                              -e "s#\\\$TEST_IMG#$img=
#")
> Same here, even more evidence that it would be nice to move this to a c=
ommon function.

I=E2=80=99m not sure whether it=E2=80=99s more evidence because it would =
increase LoC.
I may or may not do it.

Max

> Again, I am not 100% sure that this is the same regex, but it looks lik=
e that.
>=20
>> +            rm -f "$data_file"
>> +        fi
>>      fi
>>      rm -f "$img"
>>  }
>=20
>=20
> Best regards,
> 	Maxim Levitsky
>=20



--K1DAtE6IdOMY9p73u0jmUnGeH3SSxpDUO--

--rgta05bSzL7S00ZAQexzU0xUhbIVBgeoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2SBmUACgkQ9AfbAGHV
z0CWmAf/byMQjcMdiLw5ICtikKV60RqvZT8yRTcOsncQkCAagQj23ibwZPgJ+Rx7
PY75mEmJLfFKjH0rJ2X8+nhp7R6GoMoQLDJ83At3TK2tOPkT2zeAhQFUhnfjX/KN
ppG5ToHSLonB9QarCXi/hX2wAuYgO5qFM4OljPKg2OLI6fZL8wNmJdb6c12pOklZ
Y1aDh4VcbOdBXI43TaSh8slnSXlcyre7Lwb2W60Sb/z0Hk+qJgJ6g8t5FMNsZpjX
4DQKqgz6BnnBBgieGhGTWLUy8WlZHwCkpLgHyZJ6PVrnzKlZaSTa3OudehAaG1+9
D4WKjqVu4k3GE42fUJWgdS7dzIm4xQ==
=n1w0
-----END PGP SIGNATURE-----

--rgta05bSzL7S00ZAQexzU0xUhbIVBgeoT--

