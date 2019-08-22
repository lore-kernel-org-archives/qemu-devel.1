Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555BEC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7C3233FD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7C3233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0rZX-0004R2-Bb
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 14:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i0rYd-0003xg-4G
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i0rYX-0002J8-TC
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:11:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35512)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i0rYT-0002Gu-Ko; Thu, 22 Aug 2019 14:11:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 916FF307BCC4;
 Thu, 22 Aug 2019 18:11:24 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA39F6092D;
 Thu, 22 Aug 2019 18:11:22 +0000 (UTC)
To: Nir Soffer <nsoffer@redhat.com>
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
 <CAMRbyyt3Ku0Znpfx16FDqFTYbp5oJ1-9DnyxntHnArHsbR1ing@mail.gmail.com>
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
Message-ID: <271a2dd3-9f2b-013d-896f-f4059c804967@redhat.com>
Date: Thu, 22 Aug 2019 20:11:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyyt3Ku0Znpfx16FDqFTYbp5oJ1-9DnyxntHnArHsbR1ing@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Oh14fqOSDnOwkKRFpbAqsqXDCepFQmmdY"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 22 Aug 2019 18:11:24 +0000 (UTC)
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
--Oh14fqOSDnOwkKRFpbAqsqXDCepFQmmdY
Content-Type: multipart/mixed; boundary="3ko067CsIuDOxEgXu6Lky8CaLP6vMAxhD";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <271a2dd3-9f2b-013d-896f-f4059c804967@redhat.com>
Subject: Re: [PATCH] block: posix: Always allocate the first block
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
 <CAMRbyyt3Ku0Znpfx16FDqFTYbp5oJ1-9DnyxntHnArHsbR1ing@mail.gmail.com>
In-Reply-To: <CAMRbyyt3Ku0Znpfx16FDqFTYbp5oJ1-9DnyxntHnArHsbR1ing@mail.gmail.com>

--3ko067CsIuDOxEgXu6Lky8CaLP6vMAxhD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.08.19 18:39, Nir Soffer wrote:
> On Thu, Aug 22, 2019 at 5:28 PM Max Reitz <mreitz@redhat.com
> <mailto:mreitz@redhat.com>> wrote:
>=20
>     On 16.08.19 23:21, Nir Soffer wrote:
>     > When creating an image with preallocation "off" or "falloc", the =
first
>     > block of the image is typically not allocated. When using Gluster=

>     > storage backed by XFS filesystem, reading this block using direct=
 I/O
>     > succeeds regardless of request length, fooling alignment detectio=
n.
>     >
>     > In this case we fallback to a safe value (4096) instead of the op=
timal
>     > value (512), which may lead to unneeded data copying when alignin=
g
>     > requests.=C2=A0 Allocating the first block avoids the fallback.
>     >
>     > When using preallocation=3Doff, we always allocate at least one
>     filesystem
>     > block:
>     >
>     >=C2=A0 =C2=A0 =C2=A0$ ./qemu-img create -f raw test.raw 1g
>     >=C2=A0 =C2=A0 =C2=A0Formatting 'test.raw', fmt=3Draw size=3D107374=
1824
>     >
>     >=C2=A0 =C2=A0 =C2=A0$ ls -lhs test.raw
>     >=C2=A0 =C2=A0 =C2=A04.0K -rw-r--r--. 1 nsoffer nsoffer 1.0G Aug 16=
 23:48 test.raw
>     >
>     > I did quick performance tests for these flows:
>     > - Provisioning a VM with a new raw image.
>     > - Copying disks with qemu-img convert to new raw target image
>     >
>     > I installed Fedora 29 server on raw sparse image, measuring the t=
ime
>     > from clicking "Begin installation" until the "Reboot" button appe=
ars:
>     >
>     > Before(s)=C2=A0 After(s)=C2=A0 =C2=A0 =C2=A0Diff(%)
>     > -------------------------------
>     >=C2=A0 =C2=A0 =C2=A0 356=C2=A0 =C2=A0 =C2=A0 =C2=A0 389=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 +8.4
>     >
>     > I ran this only once, so we cannot tell much from these results.
>=20
>     So you=E2=80=99d expect it to be fast but it was slower?=C2=A0 Well=
, you only ran it
>     once and it isn=E2=80=99t really a precise benchmark...
>=20
>     > The second test was cloning the installation image with qemu-img
>     > convert, doing 10 runs:
>     >
>     >=C2=A0 =C2=A0 =C2=A0for i in $(seq 10); do
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f dst.raw
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 10
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time ./qemu-img convert -f raw -=
O raw -t none -T none
>     src.raw dst.raw
>     >=C2=A0 =C2=A0 =C2=A0done
>     >
>     > Here is a table comparing the total time spent:
>     >
>     > Type=C2=A0 =C2=A0 Before(s)=C2=A0 =C2=A0After(s)=C2=A0 =C2=A0 Dif=
f(%)
>     > ---------------------------------------
>     > real=C2=A0 =C2=A0 =C2=A0 530.028=C2=A0 =C2=A0 469.123=C2=A0 =C2=A0=
 =C2=A0 -11.4
>     > user=C2=A0 =C2=A0 =C2=A0 =C2=A017.204=C2=A0 =C2=A0 =C2=A010.768=C2=
=A0 =C2=A0 =C2=A0 -37.4
>     > sys=C2=A0 =C2=A0 =C2=A0 =C2=A0 17.881=C2=A0 =C2=A0 =C2=A0 7.011=C2=
=A0 =C2=A0 =C2=A0 -60.7
>     >
>     > Here we see very clear improvement in CPU usage.
>     >
>     > Signed-off-by: Nir Soffer <nsoffer@redhat.com
>     <mailto:nsoffer@redhat.com>>
>     > ---
>     >=C2=A0 block/file-posix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 25 ++=
+++++++++++++++++++++++
>     >=C2=A0 tests/qemu-iotests/150.out |=C2=A0 1 +
>     >=C2=A0 tests/qemu-iotests/160=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++++
>     >=C2=A0 tests/qemu-iotests/175=C2=A0 =C2=A0 =C2=A0| 19 ++++++++++++=
+------
>     >=C2=A0 tests/qemu-iotests/175.out |=C2=A0 8 ++++----
>     >=C2=A0 tests/qemu-iotests/221.out | 12 ++++++++----
>     >=C2=A0 tests/qemu-iotests/253.out | 12 ++++++++----
>     >=C2=A0 7 files changed, 63 insertions(+), 18 deletions(-)
>     >
>     > diff --git a/block/file-posix.c b/block/file-posix.c
>     > index b9c33c8f6c..3964dd2021 100644
>     > --- a/block/file-posix.c
>     > +++ b/block/file-posix.c
>     > @@ -1755,6 +1755,27 @@ static int handle_aiocb_discard(void *opaq=
ue)
>     >=C2=A0 =C2=A0 =C2=A0 return ret;
>     >=C2=A0 }
>     >=C2=A0
>     > +/*
>     > + * Help alignment detection by allocating the first block.
>     > + *
>     > + * When reading with direct I/O from unallocated area on Gluster=

>     backed by XFS,
>     > + * reading succeeds regardless of request length. In this case w=
e
>     fallback to
>     > + * safe aligment which is not optimal. Allocating the first bloc=
k
>     avoids this
>     > + * fallback.
>     > + *
>     > + * Returns: 0 on success, -errno on failure.
>     > + */
>     > +static int allocate_first_block(int fd)
>     > +{
>     > +=C2=A0 =C2=A0 ssize_t n;
>     > +
>     > +=C2=A0 =C2=A0 do {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D pwrite(fd, "\0", 1, 0);
>=20
>     This breaks when fd has been opened with O_DIRECT.
>=20
>=20
> It seems that we always open images without O_DIRECT when creating an i=
mage
> in qemu-img create, or when creating a target image in qemu-img convert=
=2E

Yes.  But you don=E2=80=99t call this function directly from image creati=
on code
but instead from the truncation function.  (The former also calls the
latter, but truncating is also an operation on its own.)

[...]

>     (Which happens when you open some file with cache.direct=3Don, and =
then
>     use e.g. QMP=E2=80=99s block_resize.)
>=20
>=20
> What would be a command triggering this? I can add a test.

block_resize, as I=E2=80=99ve said:

$ ./qemu-img create -f raw empty.img 0
$ x86_64-softmmu/qemu-system-x86_64 \
    -qmp stdio \
    -blockdev file,node-name=3Dfile,filename=3Dempty.img,cache.direct=3Do=
n \
     <<EOF
{'execute':'qmp_capabilities'}
{'execute':'block_resize',
 'arguments':{'node-name':'file',
              'size':1048576}}
EOF
$ ./qemu-img map empty.img
Offset          Length          Mapped to       File

(You=E2=80=99d expect a data chunk here.)

I suppose you can get the same effect with blockdev-create and some
format that explicitly resizes the file to some target length (LUKS does
this, I think), but this is the most direct route.

>=20
>     It isn=E2=80=99t that bad because eventually you simply ignore the =
error.=C2=A0 But
>     it still makes me wonder whether we shouldn=E2=80=99t write like th=
e biggest
>     power of two that does not exceed the new file length or MAX_BLOCKS=
IZE.
>=20
>=20
> It makes sense if there is a way to cause qemu-img to use O_DIRECT when=

> creating an image.
>=20
>     > +=C2=A0 =C2=A0 } while (n =3D=3D -1 && errno =3D=3D EINTR);
>     > +
>     > +=C2=A0 =C2=A0 return (n =3D=3D -1) ? -errno : 0;
>     > +}
>     > +
>     >=C2=A0 static int handle_aiocb_truncate(void *opaque)
>     >=C2=A0 {
>     >=C2=A0 =C2=A0 =C2=A0 RawPosixAIOData *aiocb =3D opaque;
>     > @@ -1794,6 +1815,8 @@ static int handle_aiocb_truncate(void *opaq=
ue)
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
posix_fallocate() doesn't set errno. */
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err=
or_setg_errno(errp, -result,
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Could not pre=
allocate new data");
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (current_len=
gth =3D=3D 0) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 allocate=
_first_block(fd);
>=20
>     Should posix_fallocate() not take care of precisely this?
>=20
>=20
> Only if the filesystem does not support fallocate() (e.g. NFS < 4.2).
>=20
> In this case posix_fallocate() is doing:
>=20
> =C2=A0 for (offset +=3D (len - 1) % increment; len > 0; offset +=3D inc=
rement)
> =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 len -=3D increment;
> =C2=A0 =C2=A0 =C2=A0 if (offset < st.st_size)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char c;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ssize_t rsize =3D __pread (fd, &c, 1=
, offset);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rsize < 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return errno;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If there is a non-zero byte, the =
block must have been
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0allocated already. =C2=A0=
*/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (rsize =3D=3D 1 && c !=3D 0)=

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 if (__pwrite (fd, "", 1, offset) !=3D 1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return errno;
> =C2=A0 =C2=A0 }
>=20
> https://code.woboq.org/userspace/glibc/sysdeps/posix/posix_fallocate.c.=
html#96
>=20
> So opening a file with O_DIRECT will break preallocation=3Dfalloc on su=
ch
> filesystems,

But won=E2=80=99t the function above just fail with EINVAL?
allocate_first_block() is executed only in case of success.

> and writing one byte in allocate_first_block() is safe.
>=20
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D 0;
>=20
>     [...]
>=20
>     > diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
>     > index df89d3864b..ad2d054a47 100755
>     > --- a/tests/qemu-iotests/160
>     > +++ b/tests/qemu-iotests/160
>     > @@ -57,6 +57,10 @@ for skip in $TEST_SKIP_BLOCKS; do
>     >=C2=A0 =C2=A0 =C2=A0 $QEMU_IMG dd if=3D"$TEST_IMG" of=3D"$TEST_IMG=
=2Eout" skip=3D"$skip"
>     -O "$IMGFMT" \
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2> /dev/null
>     >=C2=A0 =C2=A0 =C2=A0 TEST_IMG=3D"$TEST_IMG.out" _check_test_img
>     > +
>     > +=C2=A0 =C2=A0 # We always write the first byte of an image.
>     > +=C2=A0 =C2=A0 printf "\0" > "$TEST_IMG.out.dd"
>     > +
>     >=C2=A0 =C2=A0 =C2=A0 dd if=3D"$TEST_IMG" of=3D"$TEST_IMG.out.dd" s=
kip=3D"$skip" status=3Dnone
>=20
>     Won=E2=80=99t this dd completely overwrite $TEST_IMG.out.dd (especi=
ally given
>     the lack of conv=3Dnotrunc)?
>=20
>=20
> There is an issue only if dd open the file with O_TRUNC.

It isn=E2=80=99t an issue, I just don=E2=80=99t understand why the printf=
 would be
necessary at all.

dd should always truncate the output image unless conv=3Dnotrunc is
specified.  But even if it didn=E2=80=99t do that, in all of these test c=
ases it
should copy some data from $TEST_IMG to the output, and thus should
always overwrite the first byte anyway.

> I will test
> this again.
>=20
>     >=C2=A0
>     >=C2=A0 =C2=A0 =C2=A0 echo
>     > diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
>     > index 51e62c8276..c6a3a7bb1e 100755
>     > --- a/tests/qemu-iotests/175
>     > +++ b/tests/qemu-iotests/175
>     > @@ -37,14 +37,16 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>     >=C2=A0 # the file size.=C2=A0 This function hides the resulting di=
fference in the
>     >=C2=A0 # stat -c '%b' output.
>     >=C2=A0 # Parameter 1: Number of blocks an empty file occupies
>     > -# Parameter 2: Image size in bytes
>     > +# Parameter 2: Minimal number of blocks in an image
>     > +# Parameter 3: Image size in bytes
>     >=C2=A0 _filter_blocks()
>     >=C2=A0 {
>     >=C2=A0 =C2=A0 =C2=A0 extra_blocks=3D$1
>     > -=C2=A0 =C2=A0 img_size=3D$2
>     > +=C2=A0 =C2=A0 min_blocks=3D$2
>     > +=C2=A0 =C2=A0 img_size=3D$3
>     >=C2=A0
>     > -=C2=A0 =C2=A0 sed -e "s/blocks=3D$extra_blocks\\(\$\\|[^0-9]\\)/=
nothing
>     allocated/" \
>     > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/blocks=3D$((extra_blocks + img=
_size /
>     512))\\(\$\\|[^0-9]\\)/everything allocated/"
>     > +=C2=A0 =C2=A0 sed -e "s/blocks=3D$((extra_blocks +
>     min_blocks))\\(\$\\|[^0-9]\\)/min allocation/" \
>=20
>     I don=E2=80=99t think adding extra_blocks to min_blocks makes sense=
=2E=C2=A0 Just
>     min_blocks alone should be what we want here.
>=20
>=20
> We had failing tests (in vdsm) showing that filesystem may return more
> blocs than
> expected even for non-empty files, so this may be needed.

But min_blocks is exactly the number of blocks of a file that has one
allocated block.  I don=E2=80=99t see how adding the number of blocks an =
empty
file occupies makes sense.

Max


--3ko067CsIuDOxEgXu6Lky8CaLP6vMAxhD--

--Oh14fqOSDnOwkKRFpbAqsqXDCepFQmmdY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1e2skACgkQ9AfbAGHV
z0BNfgf7BcwILzKqGp+Satnpuz+C7IIu2jDC9tJEdvWe1qp/HXZqla6XCCf4fhRr
3VnvCYzjE3FWlLWwR9m/TxorVTMCFn4UO4yLxKEg98KZG6emINSx0KL2HvYTjTqW
B6GaiY7g0f/T3hi/I3vTY7Zb5arDmE2uyO21cJGpE7QEtg8ndXTKO4sIg+65UdSQ
XrUvS8kTYzsoSoRTVTesJiJ5dD4yE12BkzJ4acux03VOvgC2zEakpMjuAHmd3Qmf
UY7bKs0bBJV6C7Vbt2EUKGM5t/CDixF/5Jq4lz5Yl2TXv8DYpSaqvJrqM0HCkCso
vYZrDYsYm91UJo+Mbaw7L265cABOLg==
=oFNZ
-----END PGP SIGNATURE-----

--Oh14fqOSDnOwkKRFpbAqsqXDCepFQmmdY--

