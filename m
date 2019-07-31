Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99014C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D32A20665
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D32A20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsl3r-0007qZ-PC
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 05:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39433)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hsl3S-0007Rd-4c
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hsl2d-0000NL-Nk
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:37:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hsl2N-0008Jq-1Z; Wed, 31 Jul 2019 05:36:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 66BED308FBB1;
 Wed, 31 Jul 2019 09:36:38 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-44.ams2.redhat.com
 [10.36.117.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEE2119C65;
 Wed, 31 Jul 2019 09:36:36 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-14-mreitz@redhat.com>
 <9883f164-3d1a-4d8c-61a4-3f34f9148072@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
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
Message-ID: <c0c7277c-430f-e688-c9e6-61084ffe9f6e@redhat.com>
Date: Wed, 31 Jul 2019 11:36:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9883f164-3d1a-4d8c-61a4-3f34f9148072@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RL1ixNbHLPjOKQKg4E2TzoAz8U7DTNgXC"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 31 Jul 2019 09:36:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 13/13] iotests: Test qcow2's
 snapshot table handling
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
--RL1ixNbHLPjOKQKg4E2TzoAz8U7DTNgXC
Content-Type: multipart/mixed; boundary="azjnC4RYZjbnOe6VFHPvWFnwIVxjMswOS";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <c0c7277c-430f-e688-c9e6-61084ffe9f6e@redhat.com>
Subject: Re: [PATCH for-4.2 13/13] iotests: Test qcow2's snapshot table
 handling
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-14-mreitz@redhat.com>
 <9883f164-3d1a-4d8c-61a4-3f34f9148072@redhat.com>
In-Reply-To: <9883f164-3d1a-4d8c-61a4-3f34f9148072@redhat.com>

--azjnC4RYZjbnOe6VFHPvWFnwIVxjMswOS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.19 21:56, Eric Blake wrote:
> On 7/30/19 12:25 PM, Max Reitz wrote:
>> Add a test how our qcow2 driver handles extra data in snapshot table
>> entries, and how it repairs overly long snapshot tables.
>=20
> May need tweaking if we drop 9 and 10.
>=20
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/261     | 449 ++++++++++++++++++++++++++++++++++++=
+
>>  tests/qemu-iotests/261.out | 321 ++++++++++++++++++++++++++
>>  tests/qemu-iotests/group   |   1 +
>>  3 files changed, 771 insertions(+)
>>  create mode 100755 tests/qemu-iotests/261
>>  create mode 100644 tests/qemu-iotests/261.out
>>
>> +
>> +# Parameters:
>> +#   $1: image filename
>> +#   $2: snapshot table entry offset in the image
>> +snapshot_table_entry_size()
>> +{
>> +    id_len=3D$(peek_file_be "$1" $(($2 + 12)) 2)
>> +    name_len=3D$(peek_file_be "$1" $(($2 + 14)) 2)
>> +    extra_len=3D$(peek_file_be "$1" $(($2 + 36)) 4)
>> +
>> +    full_len=3D$((40 + extra_len + id_len + name_len))
>> +    if [ $((full_len % 8)) =3D 0 ]; then
>> +        echo $full_len
>> +    else
>> +        echo $((full_len + 8 - full_len % 8))
>=20
> Could replace the entire if with:
>  echo $(( (full_len + 7) / 8 * 8 ))
> but what you have works.

Ah, sure.

>> +    fi
>> +}
>> +
>> +# Parameter:
>> +#   $1: image filename
>> +print_snapshot_table()
>> +{
>> +    nb_entries=3D$(peek_file_be "$1" 60 4)
>> +    offset=3D$(peek_file_be "$1" 64 8)
>> +
>> +    echo "Snapshots in $1:" | _filter_testdir | _filter_imgfmt
>=20
> Should a separate patch add support in 'qemu-img info'/'qemu-img
> snapshot -l' for letting users know how much extra info is in each
> snapshot?  It seems useful enough without having to recode this
> low-level iotest introspection.

To me, it doesn=E2=80=99t seem really useful right now, as all qemu-creat=
ed
images (past 1.1) will have the same 16 bytes.

>> +
>> +    for ((i =3D 0; i < nb_entries; i++)); do
>> +        id_len=3D$(peek_file_be "$1" $((offset + 12)) 2)
>> +        name_len=3D$(peek_file_be "$1" $((offset + 14)) 2)
>> +        extra_len=3D$(peek_file_be "$1" $((offset + 36)) 4)
>> +
>> +        extra_ofs=3D$((offset + 40))
>> +        id_ofs=3D$((extra_ofs + extra_len))
>> +        name_ofs=3D$((id_ofs + id_len))
>> +
>> +        echo "  [$i]"
>> +        echo "    ID: $(peek_file_raw "$1" $id_ofs $id_len)"
>> +        echo "    Name: $(peek_file_raw "$1" $name_ofs $name_len)"
>=20
> We're relying on the files having sane strings at those offsets - but
> that's fine for the iotest.
>=20
>> +        echo "    Extra data size: $extra_len"
>> +        if [ $extra_len -ge 8 ]; then
>> +            echo "    VM state size: $(peek_file_be "$1" $extra_ofs 8=
)"
>> +        fi
>> +        if [ $extra_len -ge 16 ]; then
>> +            echo "    Disk size: $(peek_file_be "$1" $((extra_ofs + 8=
)) 8)"
>> +        fi
>> +        if [ $extra_len -gt 16 ]; then
>> +            echo '    Unknown extra data:' \
>> +                "$(peek_file_raw "$1" $((extra_ofs + 16)) $((extra_le=
n - 16)) \
>> +                   | tr -d '\0')"
>=20
> Printing the unknown extra data seems fishy, especially if you are goin=
g
> to sanitize out the NUL bytes.  An od dump of every byte might be more
> useful, but I'd also be happy with just printing the number of unknown
> bytes without actually worrying about printing the contents of those by=
tes.

It=E2=80=99s a test, I know exactly what the extra data is (supposed to b=
e).

(namely =E2=80=9Cvery important data\0\0\0\0\0\0\0=E2=80=9D)

[...]

>> +# We only need the fixed part, though.
>> +truncate -s 40 "$TEST_DIR/sn0"
>> +
>> +# 65535-char ID string
>> +poke_file "$TEST_DIR/sn0" 12 '\xff\xff'
>> +# 65535-char name
>> +poke_file "$TEST_DIR/sn0" 14 '\xff\xff'
>=20
> Do we care that there are NUL bytes in the id and name?  (The spec is
> clear that id and name are not NUL-terminated, but does not actually
> seem to forbid the use of arbitrary binary values as names...)

Right now we don=E2=80=99t care.  Which is good for me, because anything =
else
would make this test even slower than it already is (writing a different
name and ID into every snapshot would be a pain).

(It=E2=80=99s even worse for the next case.  There is a reason I do it fo=
r v2
only, where fully-zero snapshot table entries are valid.  It takes a
long time just to write a '16' into every one of >65536 entries.)

Max

[...]

> Overall, looks like a nice test.  I'm comfortable giving:
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Again, thanks for reviewing!


--azjnC4RYZjbnOe6VFHPvWFnwIVxjMswOS--

--RL1ixNbHLPjOKQKg4E2TzoAz8U7DTNgXC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1BYSIACgkQ9AfbAGHV
z0BNgwf/foPDcu0RQ6f75EiF6d0ojyNO32SVvhNNsrHAl1jYaQ2jVk6xxJYIyR8L
/uDrhjBrZxU2F6d74F0mkEodez15J5ez6v/9YyWqzB+UucSftVr3VnETqRBzLsy0
lYITIwDvRu2Zt5csD/QjefqYUgfCRhwd+L40dI9hVsI3CQfl/1RFEhAHiM6ZZ5yA
1jVWk91bz/rZdH69MeYHaZnTk+FFOrp1QXEbwPox2+OieejMSHWhe04gqmba0PGK
PbMJluitKw6vU2HuvCbNp+kO6glibqeXg1g/lU/903gN/d3IhgJcSSG6f7yFpar/
6h2ySD0FF8q4XiGmBm5eVZktZahw+A==
=lmsf
-----END PGP SIGNATURE-----

--RL1ixNbHLPjOKQKg4E2TzoAz8U7DTNgXC--

