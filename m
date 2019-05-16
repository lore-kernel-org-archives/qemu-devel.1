Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9436C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4EC2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4EC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57735 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRGUz-0005ic-4e
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 09:32:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hRGTb-00053A-M8
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hRGTY-0001Ib-LH
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:31:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hRGTM-0000Zm-A3; Thu, 16 May 2019 09:31:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 206AA368E6;
	Thu, 16 May 2019 13:30:59 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-34.brq.redhat.com
	[10.40.204.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BA99D1001E78;
	Thu, 16 May 2019 13:30:57 +0000 (UTC)
To: Nir Soffer <nsoffer@redhat.com>
References: <20190513155254.27773-1-mreitz@redhat.com>
	<7886115c-a73e-607d-6487-5cf68a3da756@redhat.com>
	<CAMRbyyvG-Tygjx8U8sDzsmaMaDgmyGWRb0NE_KUhhqBssfaGqA@mail.gmail.com>
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
Message-ID: <d639dcf7-a90a-edea-b892-2bfed20b2b7a@redhat.com>
Date: Thu, 16 May 2019 15:30:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMRbyyvG-Tygjx8U8sDzsmaMaDgmyGWRb0NE_KUhhqBssfaGqA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="y55Wt0p55d1QarygXJUQVCnnLblnrhTUd"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 16 May 2019 13:30:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2] iotests: Filter 175's allocation
 information
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y55Wt0p55d1QarygXJUQVCnnLblnrhTUd
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <d639dcf7-a90a-edea-b892-2bfed20b2b7a@redhat.com>
Subject: Re: [PATCH v2] iotests: Filter 175's allocation information
References: <20190513155254.27773-1-mreitz@redhat.com>
 <7886115c-a73e-607d-6487-5cf68a3da756@redhat.com>
 <CAMRbyyvG-Tygjx8U8sDzsmaMaDgmyGWRb0NE_KUhhqBssfaGqA@mail.gmail.com>
In-Reply-To: <CAMRbyyvG-Tygjx8U8sDzsmaMaDgmyGWRb0NE_KUhhqBssfaGqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.05.19 15:06, Nir Soffer wrote:
> On Thu, May 16, 2019 at 2:03 PM Max Reitz <mreitz@redhat.com
> <mailto:mreitz@redhat.com>> wrote:
>=20
>     On 13.05.19 17:52, Max Reitz wrote:
>     > It is possible for an empty file to take up blocks on a filesyste=
m.
>     > Make iotest 175 take this into account.
>     >
>     > Reported-by: Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.c=
om>>
>     > Signed-off-by: Max Reitz <mreitz@redhat.com
>     <mailto:mreitz@redhat.com>>
>     > ---
>     > v2: [Nir]
>     > - Use a function for filtering
>     > - s/empty_blocks/extra_blocks/
>     > ---
>     >=C2=A0 tests/qemu-iotests/175=C2=A0 =C2=A0 =C2=A0| 26 ++++++++++++=
++++++++++----
>     >=C2=A0 tests/qemu-iotests/175.out |=C2=A0 8 ++++----
>     >=C2=A0 2 files changed, 26 insertions(+), 8 deletions(-)
>     >
>     > diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
>     > index d0ffc495c2..b5eb0aa856 100755
>     > --- a/tests/qemu-iotests/175
>     > +++ b/tests/qemu-iotests/175
>     > @@ -28,10 +28,25 @@ status=3D1=C2=A0 # failure is the default!
>     >=C2=A0
>     >=C2=A0 _cleanup()
>     >=C2=A0 {
>     > -=C2=A0 =C2=A0 =C2=A0_cleanup_test_img
>     > +=C2=A0 =C2=A0 _cleanup_test_img
>     > +=C2=A0 =C2=A0 rm -f "$TEST_DIR/empty"
>     >=C2=A0 }
>     >=C2=A0 trap "_cleanup; exit \$status" 0 1 2 3 15
>     >=C2=A0
>     > +# Some file systems sometimes allocate extra blocks independentl=
y of
>     > +# the file size.=C2=A0 This function hides the resulting differe=
nce in the
>     > +# stat -c '%b' output.
>     > +# Parameter 1: Number of blocks an empty file occupies
>     > +# Parameter 2: Image size in bytes
>     > +_filter_blocks()
>     > +{
>     > +=C2=A0 =C2=A0 extra_blocks=3D$1
>     > +=C2=A0 =C2=A0 img_size=3D$2
>     > +
>     > +=C2=A0 =C2=A0 sed -e "s/blocks=3D$extra_blocks/nothing allocated=
/" \
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/blocks=3D$((extra_blocks + img=
_size /
>     512))/everything allocated/"
>=20
>     Only now got around to creating an FS with similar characteristics =
to
>     Thomas=E2=80=99s.=C2=A0 Turns out this test still fails there becau=
se it prints
>     =E2=80=9Cblocks=3Dnothing allocated050=E2=80=9D...
>=20
>     Unless objections arise, I=E2=80=99ll just add a \$ to each pattern=
 to fix that.
>     =C2=A0(I could also just swap the lines, but that isn=E2=80=99t rea=
lly right.)
>=20
>=20
> Sounds right.
>=20
> Can you share how to create file system which reproduces this?
> Maybe adding the details in the test would be useful.

Sure:

$ mkfs.ext4 -b 1024 -I 128 /dev/loop0

-I 128 is the important one.  The block size just changes the number of
extra blocks (2 with 1024, 8 with 4096).

=2E..I guess I=E2=80=99ll just a v3 now.

Max


--y55Wt0p55d1QarygXJUQVCnnLblnrhTUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzdZgsACgkQ9AfbAGHV
z0DBygf9E3Dkik7PyWYMp75any97M8TKoUY4VkcGprNiLoXftFkxxB8xzml5cjiJ
VjgirkxoiWjzL0kn6RGGmLAWb5SH9uGKYp0aC2fxAE7Zfe+OswGtz7g8WTxi253P
RDwNOKDhpV3ARlOX9INUXiiilGFwK5OjX7TWjUPFKvVm231BmUCiveBGZqLsrsx/
JWT6ELanzJm459HqjB/5KX2aRCaldT0iBsvUFDMbD/N+sc68wJWvRoQM/MHQTX5H
RUxj2nEpBg3lE70pXC38dyMRv/pMnnYION05r8WIwQxQg+1gbofbLzcpp4nUab5b
3zuM6ZeV9iuN1xp/N26KsKPWut15DA==
=xvbK
-----END PGP SIGNATURE-----

--y55Wt0p55d1QarygXJUQVCnnLblnrhTUd--

