Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25787C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 11:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0082070B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 11:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0082070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i02gs-0004L6-68
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 07:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i02gB-0003Z4-JD
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 07:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i02gA-000810-J7
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 07:51:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i02g8-0007z7-AZ; Tue, 20 Aug 2019 07:51:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90F37307D965;
 Tue, 20 Aug 2019 11:51:55 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62E733D99;
 Tue, 20 Aug 2019 11:51:54 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-17-mreitz@redhat.com>
 <ddba06a8-0ecd-639a-bd13-5fd98cde6e43@redhat.com>
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
Message-ID: <03996b82-2814-dfc7-d68e-e6723a5d1e0d@redhat.com>
Date: Tue, 20 Aug 2019 13:51:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ddba06a8-0ecd-639a-bd13-5fd98cde6e43@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5EaR3Fruxlu8Dp7MgO5RHjd0oWK9uysEQ"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 20 Aug 2019 11:51:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 16/16] iotests: Test qcow2's snapshot
 table handling
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
--5EaR3Fruxlu8Dp7MgO5RHjd0oWK9uysEQ
Content-Type: multipart/mixed; boundary="C9avAHI2d9Bsv8XAGtn6OxMnpcWPUlJ2i";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <03996b82-2814-dfc7-d68e-e6723a5d1e0d@redhat.com>
Subject: Re: [PATCH v2 16/16] iotests: Test qcow2's snapshot table handling
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-17-mreitz@redhat.com>
 <ddba06a8-0ecd-639a-bd13-5fd98cde6e43@redhat.com>
In-Reply-To: <ddba06a8-0ecd-639a-bd13-5fd98cde6e43@redhat.com>

--C9avAHI2d9Bsv8XAGtn6OxMnpcWPUlJ2i
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.19 22:25, Eric Blake wrote:
> On 8/19/19 1:56 PM, Max Reitz wrote:
>> Add a test how our qcow2 driver handles extra data in snapshot table
>> entries, and how it repairs overly long snapshot tables.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
>> +++ b/tests/qemu-iotests/261.out
>> @@ -0,0 +1,346 @@
>> +QA output created by 261
>> +
>> +=3D=3D=3D Create v2 template =3D=3D=3D
>> +
>> +Formatting 'TEST_DIR/t.IMGFMT.v2.orig', fmt=3DIMGFMT size=3D67108864
>> +No errors were found on the image.
>> +Snapshots in TEST_DIR/t.IMGFMT.v2.orig:
>> +  [0]
>> +    ID: 1
>> +    Name: sn0
>> +    Extra data size: 0
>> +  [1]
>> +    ID: 2
>> +    Name: sn1
>> +    Extra data size: 42
>> +    VM state size: 0
>> +    Disk size: 67108864
>> +    Unknown extra data: very important data
>=20
> Hmm - possibly one more patch to write - but when checking snapshots fo=
r
> accuracy, do we want to insist that the 32-bit truncated VM state size
> is either 0 or matches the low 32-bits of the 64-bit VM state size
> field?  Any mismatch between those fields (other than the 32-bit field
> being left 0 because we knew to use the 64-bit field) might be a hint o=
f
> a possible corruption.  But there's no good way to correct it other tha=
n
> wiping the 32-bit field to 0; and for a v2 image, any change we make to=

> the 32-bit field might actually make the snapshot unusable for an older=

> client that doesn't know how to use the 64-bit field.  So maybe we just=

> overlook that.

The spec clearly says that when the 64-bit field is present, the 32-bit
field is to be ignored.  So there=E2=80=99s at least no standard-complian=
t way
of checking it.

Max


--C9avAHI2d9Bsv8XAGtn6OxMnpcWPUlJ2i--

--5EaR3Fruxlu8Dp7MgO5RHjd0oWK9uysEQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1b3tgACgkQ9AfbAGHV
z0ANFwf6AwfmzatPVhSSV3HStIb3ULlEu0S7nKyVuzcHAvlA7USCGL+/S8JkYVJC
8ZvDkVYmDJdMU+0HlCMDSGCa4EwV/SQgcoUFWPh2b0kaitjqkwM9xQJ1TYvvGhWx
ue55MkV62ySVrHOUJQbWconzJLN7ukml/JB03e3ou/Ny/lKTHGWKhvF18hdWuvH4
PrNw7j+88TvxsKyOrQYgildci8thwE27qw2AN61GwbnBZ6KKnOlJeEo+3T6LhGce
sGYEDJukCXhPVPDdFkSvt0kmsk/S9rHfJCIFJHk7rkFU5dsK129bDgZoRrFQvlAd
H6xa8x/MeUt7fSyUgDifcocpnUOuVw==
=o/7P
-----END PGP SIGNATURE-----

--5EaR3Fruxlu8Dp7MgO5RHjd0oWK9uysEQ--

