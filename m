Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F9DC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BC320449
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BC320449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsku1-00084L-11
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 05:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33105)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hsktc-0007aD-CV
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hsktb-0002p2-51
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:27:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hsktY-0002nA-Do; Wed, 31 Jul 2019 05:27:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1FAD5C00233A;
 Wed, 31 Jul 2019 09:27:39 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-44.ams2.redhat.com
 [10.36.117.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8324E600D1;
 Wed, 31 Jul 2019 09:27:35 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-13-mreitz@redhat.com>
 <90984be8-3181-03aa-57e4-7e3c46cec6f8@redhat.com>
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
Message-ID: <e1b18d6a-3ed2-3b87-56ef-81efe4ce2c51@redhat.com>
Date: Wed, 31 Jul 2019 11:27:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <90984be8-3181-03aa-57e4-7e3c46cec6f8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YtcANA2eZCfvrK4uurbzXvTFPthovd7l6"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 31 Jul 2019 09:27:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 12/13] iotests: Add peek_file*
 functions
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
--YtcANA2eZCfvrK4uurbzXvTFPthovd7l6
Content-Type: multipart/mixed; boundary="KPTaYJG0lxkwie8IfNypdqeh80pNPjtbE";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <e1b18d6a-3ed2-3b87-56ef-81efe4ce2c51@redhat.com>
Subject: Re: [PATCH for-4.2 12/13] iotests: Add peek_file* functions
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-13-mreitz@redhat.com>
 <90984be8-3181-03aa-57e4-7e3c46cec6f8@redhat.com>
In-Reply-To: <90984be8-3181-03aa-57e4-7e3c46cec6f8@redhat.com>

--KPTaYJG0lxkwie8IfNypdqeh80pNPjtbE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.19 21:22, Eric Blake wrote:
> On 7/30/19 12:25 PM, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/common.rc | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.=
rc
>> index 5502c3da2f..78decfd5d5 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -53,6 +53,26 @@ poke_file()
>>      printf "$3" | dd "of=3D$1" bs=3D1 "seek=3D$2" conv=3Dnotrunc &>/d=
ev/null
>>  }
>> =20
>> +# peek_file_le 'test.img' 512 2 =3D> 65534
>> +peek_file_le()
>> +{
>> +    # Wrap in echo $() to strip spaces
>> +    echo $(od -j"$2" -N"$3" --endian=3Dlittle -An -vtu"$3" "$1")
>=20
> Requires coreutils' od, but we can patch that later if it proves to be =
a
> problem on other hosts.
>=20
> I used to do something similar in nbdkit (prior to qemu-nbd --list
> making my life a lot easier; see nbdkit commit b228cb40); but there, I
> read a 16-bit value in 2 8-bit chunks and pieced it together myself
> rather than relying on --endian:
>=20
> -    # Protocol is big endian, we want native endian.
> -    # xargs trick to trim whitespace from
> -    # https://stackoverflow.com/a/12973694
> -    eflags_hi=3D$(od -An -N1     -tx1 eflags.out | xargs)
> -    eflags_lo=3D$(od -An -N1 -j1 -tx1 eflags.out | xargs)
> -    eflags=3D$(( 0x$eflags_hi << 8 | 0x$eflags_lo ))
>=20
> But as long as we are using --endian, your version nicely handles 1, 2,=

> 4, and 8-byte reads.
>=20
>> +
>> +# peek_file_raw 'test.img' 512 2 =3D> '\xff\xfe'
>> +peek_file_raw()
>> +{
>> +    dd if=3D"$1" bs=3D1 skip=3D"$2" count=3D"$3" status=3Dnone
>> +}
>=20
> Of course, calling $(peek_file_raw ...) is a bad idea, because it might=

> eat a trailing byte that happened to be a newline; it also doesn't
> handle NUL bytes very well.  Is it worth documenting caveats for using
> this one?

In my experience, it handled NUL bytes so well that I had to tr -d them
away. :-)

I mean, isn=E2=80=99t the problem in the caller, then?

Max

> Reviewed-by: Eric Blake <eblake@redhat.com>


--KPTaYJG0lxkwie8IfNypdqeh80pNPjtbE--

--YtcANA2eZCfvrK4uurbzXvTFPthovd7l6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1BXwYACgkQ9AfbAGHV
z0DfZQgAxIuAfrI/JabZuQh3RX9j3Km1Lh8L7ic70XzZYyfURPVbU/mK+Rd6L8+c
qhDcMWZ/SYagZ3QWzetRHVlnKNhed6jM3tiRboKThpo1DmfBdK4qnM7OZusTH96f
u9rMj7Km0kuENjTCc9lMali3O+9MIKHwtedgrGniOMFhf9UMuD/AyKkzj/yYcrv7
T3+B1J7J+bpaydwObTFhShK7d1tIF8scAo4YmS2ehtM5nvYUqakjmEZ6VN3RjoVs
j5bjz0gQo+8Jmdo+D/3847v/oOGFVtVcwRgVrp7pjZbRZyntWOfV0RMkIYeR6/ur
FPiaDbcVNOrCP3zreX6gt6CPKHx+Gw==
=l+fT
-----END PGP SIGNATURE-----

--YtcANA2eZCfvrK4uurbzXvTFPthovd7l6--

