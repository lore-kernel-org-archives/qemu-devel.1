Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6808ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF5C20679
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF5C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIpnO-0007cU-Ns
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 03:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIpmF-0006Py-1C
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIpmE-0001U9-0n
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:55:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIpmB-0001S8-4x; Fri, 11 Oct 2019 03:55:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5F60A4E83C;
 Fri, 11 Oct 2019 07:55:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-40.ams2.redhat.com
 [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A938D1001B08;
 Fri, 11 Oct 2019 07:55:48 +0000 (UTC)
Subject: Re: [PATCH 14/23] iotests/194: Create sockets in $SOCK_DIR
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20191010152457.17713-1-mreitz@redhat.com>
 <20191010152457.17713-15-mreitz@redhat.com>
 <01965c19-f5eb-c1a1-4108-f79b9c76f323@redhat.com>
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
Message-ID: <67a65ece-97b2-c527-eb00-054bc6018bd7@redhat.com>
Date: Fri, 11 Oct 2019 09:55:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <01965c19-f5eb-c1a1-4108-f79b9c76f323@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TwfsDZHOiT2bbsb1yjsozhHQ0tYkWf8UA"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 11 Oct 2019 07:55:50 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TwfsDZHOiT2bbsb1yjsozhHQ0tYkWf8UA
Content-Type: multipart/mixed; boundary="78Q9AxXEVz5P9mrSYtmA6j3exuK1wMGlI"

--78Q9AxXEVz5P9mrSYtmA6j3exuK1wMGlI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.10.19 21:43, Eric Blake wrote:
> On 10/10/19 10:24 AM, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/194 | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
>> index d746ab1e21..72e47e8833 100755
>> --- a/tests/qemu-iotests/194
>> +++ b/tests/qemu-iotests/194
>> @@ -26,8 +26,8 @@ iotests.verify_platform(['linux'])
>> =C2=A0 =C2=A0 with iotests.FilePath('source.img') as source_img_path, =
\
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iotests.FilePath('dest.img') as d=
est_img_path, \
>=20
> Any reason these are still two iotests.FilePath(),
>=20
>> -=C2=A0=C2=A0=C2=A0=C2=A0 iotests.FilePath('migration.sock') as migrat=
ion_sock_path, \
>> -=C2=A0=C2=A0=C2=A0=C2=A0 iotests.FilePath('nbd.sock') as nbd_sock_pat=
h, \
>> +=C2=A0=C2=A0=C2=A0=C2=A0 iotests.FilePaths(['migration.sock', 'nbd.so=
ck'],
>> iotests.sock_dir) as \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [migration_sock_path=
, nbd_sock_path], \
>=20
> while you joined this into one iotests.FilePaths()?=C2=A0 Doesn't affec=
t
> correctness, but does raise a consistency issue (I noticed it again in
> the untouched part of patch 17).

The migration.sock FilePath line would have exceeded 80 characters, so I
would=E2=80=99ve had to wrap it.  Thus I decided I might as well make it =
a
FilePaths.

I didn=E2=80=99t dare touch the surrounding code, because that would have=

required me to explain myself in the commit message. O:-)

Max

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iotests.VM('source') as source_vm=
, \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iotests.VM('dest') as dest_vm:
>> =C2=A0
>=20



--78Q9AxXEVz5P9mrSYtmA6j3exuK1wMGlI--

--TwfsDZHOiT2bbsb1yjsozhHQ0tYkWf8UA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2gNYIACgkQ9AfbAGHV
z0Antwf/YJrmH1gPCxg3IATLyYSGytWnhyCGeMU5Yznaxi6lZIgDLx1hfm8xFinO
1/JFmnKUmTG3Sl5O12nrjVefnj9m5soBgRCCLghZvHOMi9qZAO7/MgDCs4N9/Fm/
BIYbGXavzQOsGZNjcF0QAU8oux4L78C4ANZb0e/pwufw/dxE+AqHjIros8uV7vyb
Te3+Lro/DjsJ3FSs4CGQ4VUZSJhtVt3mmd1sOHmyl/5sihPV+SuA54FyuYAqNuHc
1O9F6ej6K0wkZIjEMzt2wAe3ncMS/4Vf71qyucX0PyS4zW/XDPA2DWvQ1ev3gDnB
b3ehHxIiMyaoD0i/dB9Msi4aiOB8ww==
=2QeL
-----END PGP SIGNATURE-----

--TwfsDZHOiT2bbsb1yjsozhHQ0tYkWf8UA--

