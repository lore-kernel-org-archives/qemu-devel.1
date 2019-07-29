Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81600C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B625206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B625206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs5ey-00055n-Fx
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42911)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hs5eW-0004XU-0n
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hs5eV-0004yR-3M
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:25:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25972)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hs5eS-0004w1-S8; Mon, 29 Jul 2019 09:25:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D0649308FEDF;
 Mon, 29 Jul 2019 13:25:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-55.ams2.redhat.com
 [10.36.117.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 041795D9C3;
 Mon, 29 Jul 2019 13:25:16 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190722172616.28797-1-mreitz@redhat.com>
 <20190722172616.28797-3-mreitz@redhat.com>
 <CAFEAcA-JfzfR258pgNxEc=x7NqDncUrvQMtyCZ6FVm0PaZdv+A@mail.gmail.com>
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
Message-ID: <e8da41f1-8e8c-c9b2-b34f-545c6e2c2ce0@redhat.com>
Date: Mon, 29 Jul 2019 15:25:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-JfzfR258pgNxEc=x7NqDncUrvQMtyCZ6FVm0PaZdv+A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C0ZtEE1ff3XCKVgXCqwOFXHRHFf6rvqbE"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 29 Jul 2019 13:25:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 2/5] block/nvme: support larger that 512
 bytes sector devices
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C0ZtEE1ff3XCKVgXCqwOFXHRHFf6rvqbE
Content-Type: multipart/mixed; boundary="AGHzqI7y3ND0AaEkzYwp2cLGNIsWIgQdj";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <e8da41f1-8e8c-c9b2-b34f-545c6e2c2ce0@redhat.com>
Subject: Re: [PULL 2/5] block/nvme: support larger that 512 bytes sector
 devices
References: <20190722172616.28797-1-mreitz@redhat.com>
 <20190722172616.28797-3-mreitz@redhat.com>
 <CAFEAcA-JfzfR258pgNxEc=x7NqDncUrvQMtyCZ6FVm0PaZdv+A@mail.gmail.com>
In-Reply-To: <CAFEAcA-JfzfR258pgNxEc=x7NqDncUrvQMtyCZ6FVm0PaZdv+A@mail.gmail.com>

--AGHzqI7y3ND0AaEkzYwp2cLGNIsWIgQdj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.07.19 15:16, Peter Maydell wrote:
> On Mon, 22 Jul 2019 at 18:26, Max Reitz <mreitz@redhat.com> wrote:
>>
>> From: Maxim Levitsky <mlevitsk@redhat.com>
>>
>> Currently the driver hardcodes the sector size to 512,
>> and doesn't check the underlying device. Fix that.
>>
>> Also fail if underlying nvme device is formatted with metadata
>> as this needs special support.
>>
>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Message-id: 20190716163020.13383-3-mlevitsk@redhat.com
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
>> +static int64_t nvme_get_blocksize(BlockDriverState *bs)
>> +{
>> +    BDRVNVMeState *s =3D bs->opaque;
>> +    assert(s->blkshift >=3D BDRV_SECTOR_BITS);
>> +    return 1 << s->blkshift;
>> +}
>=20
> Hi -- Coverity points out here that we calculate the
> "1 << s->blkshift" as a 32-bit shift, but then return an
> int64_t type (CID 1403771).
>=20
> Can the blkshift ever really be 31 or more ?
>=20
> The types here seem weird anyway -- we return an int64_t,
> but the only user of this is nvme_probe_blocksizes(),
> which uses the value only to set BlockSizes::phys and ::log,
> both of which are of type "uint32_t". That leads me to think
> that the right return type for the function is uint32_t.
>=20
> PS: this is the only Coverity issue currently outstanding so
> if it's a trivial fix it might be nice to put it into rc3.

Maxim, what do you think?

How about we let nvme_identify() limit blkshift to something sane and
then return a uint32_t here?

In theory it would be limited by page_size, and that has a maximum value
of 2^27.  In practice, though, that limit is checked by another 32-bit
shift...

Max


--AGHzqI7y3ND0AaEkzYwp2cLGNIsWIgQdj--

--C0ZtEE1ff3XCKVgXCqwOFXHRHFf6rvqbE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0+87sACgkQ9AfbAGHV
z0DVDAf8CKyZHbhOtFf/3LErB1kcGDaN/u3JU8g3vTgcn5X06fSPeN4mYTMtn+gG
ZC+ebBbZNMOvSRXVZsANoxfzIbHeIZD484oTSBrn74zQRj/H8BmXx7iKGlBGv1LP
YcOSOLqG5tMeAs0dTB7oLmZI4uYOm+zDKj20avOvK/S3DeZCOYGhG5psEGjWafFS
Lhbbr2FiusVLAB7iUIqNLOgyb3xhTQyH58FECV6p9rQS4gWp5mGiOP91FYZEaxyM
280Ms8HjGvVW8tmEaZQ5wRDDpkZwRkBn06CY5P4TEb7tUP7wJ/PT5dCKIm0ylpTp
cS0qsbDVsZR+oCY3RYyzuC0D/l1uOA==
=JAPE
-----END PGP SIGNATURE-----

--C0ZtEE1ff3XCKVgXCqwOFXHRHFf6rvqbE--

