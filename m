Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4E1C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABEFC21852
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEFC21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2HrV-0003UQ-Sh
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 12:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i2HjP-0005xk-TR
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i2HjO-00052x-Oy
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:20:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i2HjK-00051S-N2; Mon, 26 Aug 2019 12:20:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B41688309;
 Mon, 26 Aug 2019 16:20:30 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A233F19D7A;
 Mon, 26 Aug 2019 16:20:28 +0000 (UTC)
To: Nir Soffer <nirsof@gmail.com>
References: <20190825220329.7942-1-nsoffer@redhat.com>
 <20190825220329.7942-2-nsoffer@redhat.com>
 <e4e45496-b867-4e57-5b25-d0f1425d4824@redhat.com>
 <CAMr-obvF9d=ed0hxa0FRCqFU93U8Mi21nZ6zoraYm2EfpgpQag@mail.gmail.com>
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
Message-ID: <b6c4c33e-2b02-6cbc-6a5e-bb024258e889@redhat.com>
Date: Mon, 26 Aug 2019 18:20:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMr-obvF9d=ed0hxa0FRCqFU93U8Mi21nZ6zoraYm2EfpgpQag@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Q543Tb5c1S578Aq7LyDfqq12QN1s39nbW"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 26 Aug 2019 16:20:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] block: posix: Always allocate the
 first block
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q543Tb5c1S578Aq7LyDfqq12QN1s39nbW
Content-Type: multipart/mixed; boundary="uPRJLhd5ppD49UpwlUutbritbrTcA5NTt";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Nir Soffer <nsoffer@redhat.com>
Message-ID: <b6c4c33e-2b02-6cbc-6a5e-bb024258e889@redhat.com>
Subject: Re: [PATCH v2 1/2] block: posix: Always allocate the first block
References: <20190825220329.7942-1-nsoffer@redhat.com>
 <20190825220329.7942-2-nsoffer@redhat.com>
 <e4e45496-b867-4e57-5b25-d0f1425d4824@redhat.com>
 <CAMr-obvF9d=ed0hxa0FRCqFU93U8Mi21nZ6zoraYm2EfpgpQag@mail.gmail.com>
In-Reply-To: <CAMr-obvF9d=ed0hxa0FRCqFU93U8Mi21nZ6zoraYm2EfpgpQag@mail.gmail.com>

--uPRJLhd5ppD49UpwlUutbritbrTcA5NTt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.08.19 17:41, Nir Soffer wrote:
> On Mon, Aug 26, 2019 at 3:31 PM Max Reitz <mreitz@redhat.com> wrote:
>>
>> On 26.08.19 00:03, Nir Soffer wrote:
> ...
>>> +/*
>>> + * Help alignment probing by allocating the first block.
>>> + *
>>> + * When reading with direct I/O from unallocated area on Gluster bac=
ked by XFS,
>>> + * reading succeeds regardless of request length. In this case we fa=
llback to
>>> + * safe alignment which is not optimal. Allocating the first block a=
voids this
>>> + * fallback.
>>> + *
>>> + * fd may be opened with O_DIRECT, but we don't know the buffer alig=
nment or
>>> + * request alignment, so we use safe values.
>>> + *
>>> + * Returns: 0 on success, -errno on failure. Since this is an optimi=
zation,
>>> + * caller may ignore failures.
>>> + */
>>> +static int allocate_first_block(int fd, size_t max_size)
>>> +{
>>> +    size_t write_size =3D MIN(MAX_BLOCKSIZE, max_size);
>>
>> Hm, well, there was a reason why I proposed rounding this down to the
>> next power of two.  If max_size is not a power of two but below
>> MAX_BLOCKSIZE, write_size will not be a power of two, and thus the wri=
te
>> below may fail even if write_size exceeds the physical block size.
>>
>> You can see that in the test case you add by using e.g. 768 as the
>> destination size (provided your test filesystem has a block size of 51=
2).
>>
>> Now I would like to say that it=E2=80=99s stupid to resize an O_DIRECT=
 file to a
>> size that is not a multiple of the block size; but I=E2=80=99ve had a =
bug
>> assigned to me before because that didn=E2=80=99t work.
>>
>> But maybe it=E2=80=99s actually better if it doesn=E2=80=99t work.  I =
don=E2=80=99t know.
>=20
> I tried to avoid complexity that is unlikely to help anyone, but we
> can make the (typical)
> case of 512 bytes sector size work with this:
>=20
>     size_t write_size =3D (max_size < MAX_BLOCKSIZE)
>         ? BDRV_SECTOR_SIZE
>         : MAX_BLOCKSIZE;
>=20
> Unfortunately testing max_size < 4096 will not be reliable since we don=
't know
> that underlying storage sector size.

Hm, well, why not, actually.  That=E2=80=99s simple enough and it should =
work in
all common configurations.

Max


--uPRJLhd5ppD49UpwlUutbritbrTcA5NTt--

--Q543Tb5c1S578Aq7LyDfqq12QN1s39nbW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1kBssACgkQ9AfbAGHV
z0A/AQgAg7VWz+H9Mmbtqob/gtq9ZAoDXl3bO9pmVF0ttYm6mE4fb5wxGcOC3MzZ
qvDjjHzuqP6VJFskc6w+P8c4eshZNvZhUOpo/4BC2G1Z3cEF4Vh7FdflpQ9NWJed
V4DvjwmkQhPcTkpaGK86YlS7OXiWL7y3kNuKG4eM1/HkgwDgvKYhjyOkKwoIG2qs
DAbOD8jYi2ypoYFi35e/jInNOrtnSXi1EIdlczhfpeFPjG+GNuJCF6N3QjvYlfXO
XkKbU/wItnJ4DtyWaU/0qTziN4ZjYsZ3WP9GbtTpUmkCvoKlqWj89fPqow1qUSai
AbeB81B7sFZnQ1xi5YpWalMOnXqrpw==
=zTLi
-----END PGP SIGNATURE-----

--Q543Tb5c1S578Aq7LyDfqq12QN1s39nbW--

