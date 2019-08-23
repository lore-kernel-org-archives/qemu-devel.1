Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B55C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B901A21019
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B901A21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Dlx-0007wW-VC
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i1Dkn-0006rx-Oe
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i1Dkm-0006oy-Ow
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:53:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i1Dkk-0006nM-F6; Fri, 23 Aug 2019 13:53:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C48C4898107;
 Fri, 23 Aug 2019 17:53:32 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-96.brq.redhat.com
 [10.40.204.96])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65A531001947;
 Fri, 23 Aug 2019 17:53:31 +0000 (UTC)
To: Nir Soffer <nsoffer@redhat.com>
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
 <CAMRbyyt3Ku0Znpfx16FDqFTYbp5oJ1-9DnyxntHnArHsbR1ing@mail.gmail.com>
 <271a2dd3-9f2b-013d-896f-f4059c804967@redhat.com>
 <CAMRbyytxF8r9LoX4J_7ca2QPRtnpWgdTtyaKq=p=7ZaoMu-uug@mail.gmail.com>
 <e8db1edb-b1ee-8244-c772-8e08794181f0@redhat.com>
 <CAMRbyytObKSo+spkrQsTurybGJEndDTWP4UJgieP0nVw=CLmag@mail.gmail.com>
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
Message-ID: <5a6cabf2-a284-9f63-da0e-96af26f8e0cd@redhat.com>
Date: Fri, 23 Aug 2019 19:53:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyytObKSo+spkrQsTurybGJEndDTWP4UJgieP0nVw=CLmag@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jPjcCvJ0BydNzknVNd4HI3ZB0zpIkcRlo"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 23 Aug 2019 17:53:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block: posix: Always allocate the first
 block
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Nir Soffer <nirsof@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jPjcCvJ0BydNzknVNd4HI3ZB0zpIkcRlo
Content-Type: multipart/mixed; boundary="cJpxcVdjZW8Mq9qHOqC5aPZsSfVYrdmFJ";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <5a6cabf2-a284-9f63-da0e-96af26f8e0cd@redhat.com>
Subject: Re: [PATCH] block: posix: Always allocate the first block
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
 <CAMRbyyt3Ku0Znpfx16FDqFTYbp5oJ1-9DnyxntHnArHsbR1ing@mail.gmail.com>
 <271a2dd3-9f2b-013d-896f-f4059c804967@redhat.com>
 <CAMRbyytxF8r9LoX4J_7ca2QPRtnpWgdTtyaKq=p=7ZaoMu-uug@mail.gmail.com>
 <e8db1edb-b1ee-8244-c772-8e08794181f0@redhat.com>
 <CAMRbyytObKSo+spkrQsTurybGJEndDTWP4UJgieP0nVw=CLmag@mail.gmail.com>
In-Reply-To: <CAMRbyytObKSo+spkrQsTurybGJEndDTWP4UJgieP0nVw=CLmag@mail.gmail.com>

--cJpxcVdjZW8Mq9qHOqC5aPZsSfVYrdmFJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.08.19 18:48, Nir Soffer wrote:
> On Fri, Aug 23, 2019 at 4:58 PM Max Reitz <mreitz@redhat.com
> <mailto:mreitz@redhat.com>> wrote:

[...]

>     If you have a format layer that truncates the image to a fixed size=
 and
>     does not write anything into the first block itself (say because it=
 uses
>     a footer), then (with O_DIRECT) allocate_first_block() will fail
>     (silently, because while it does return an error value, it is never=

>     checked and there is no comment that explains why we don=E2=80=99t =
check it)
>=20
>=20
> The motivation is that this is an optimization for the special case of =
using
> empty image, so it does not worth failing image creation.
> I will add a comment about that.

Thanks!

[...]

> Thanks for the example.
>=20
> I will need time to play with blockdev and understand the flows when im=
age
> are created. Do you think is would be useful to fix now only image crea=
tion
> via qemu-img, and handle blockdev later?

Well, it isn=E2=80=99t about blockdev, it=E2=80=99s simply about the fact=
 that this
function doesn=E2=80=99t work for O_DIRECT files.  I showed how to reprod=
uce the
issue without blockdev (namely block_resize).  Sure, that is an edge
case, but it is a completely valid case.

Also, it seems to me the fix is rather simple.  Just something like:

static int allocate_first_block(int fd, int64_t max_size)
{
    int write_size =3D MIN(max_size, MAX_BLOCKSIZE);
    void *buf;
    ssize_t n;

    /* Round down to power of two */
    assert(write_size > 0);
    write_size =3D 1 << (31 - clz32(write_size));

    buf =3D qemu_memalign(MAX(getpagesize(), write_size), write_size);
    memset(buf, 0, write_size);

    do {
        n =3D pwrite(fd, buf, write_size, 0);
    } while (n < 0 && errno =3D=3D EINTR);

    qemu_vfree(buf);

    return n < 0 ? -errno : 0;
}

Wouldn=E2=80=99t that work?

Max


--cJpxcVdjZW8Mq9qHOqC5aPZsSfVYrdmFJ--

--jPjcCvJ0BydNzknVNd4HI3ZB0zpIkcRlo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1gKBkACgkQ9AfbAGHV
z0Dtcwf/RxNkfuXZ2/43zlmj62xiTZRq/VQfQFzEUTFyCXbOGi6yqdAorLIUFQaR
8tEoV8WisGG0NNuZkr1y4jAGszKrZlwVBAV2HEt0OHv+CkCn9zYIfnhHkeJqvlSr
8iRvICovRbUS3vATmtxkbJm1A5o2Nw4gFp4+2/7PbcaxoZdzJoXWMMPWrLoxZurn
BOvbzDM1l4vB2PkY+YrhntxbA3EWlD0MsrXS/3x2wuTUXmV+M/IjbP3YtQSnfOjF
1RuerbaAZjEFt0BTK78QL0yy2FPZvO3XpgfEu/rfvIK3K7z+IUG2rscPbI/3mhiN
VC3RQXUKNB83xCjbC+yA281oNC7ejw==
=tcWV
-----END PGP SIGNATURE-----

--jPjcCvJ0BydNzknVNd4HI3ZB0zpIkcRlo--

