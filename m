Received: from eggs.gnu.org ([2001:4830:134:3::10]:34616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwSY-0005AQ-AS
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwSU-00059Y-FE
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:51:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dtwSU-00058w-6e
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:51:34 -0400
References: <20170916010330.10435-1-jsnow@redhat.com>
	<CAFEAcA8un6eescSDzd+P+jqEGuGkuQXgfjm+1=CPOydg6WQSnQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c6099d0b-b0d7-4969-2ebd-0981f2c7d582@redhat.com>
Date: Mon, 18 Sep 2017 08:51:27 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8un6eescSDzd+P+jqEGuGkuQXgfjm+1=CPOydg6WQSnQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rj1LbU7xP6O4rDnAUGVIouXg8ppKXfEU9"
Subject: Re: [Qemu-devel] [PULL 00/11] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rj1LbU7xP6O4rDnAUGVIouXg8ppKXfEU9
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <c6099d0b-b0d7-4969-2ebd-0981f2c7d582@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/11] Ide patches
References: <20170916010330.10435-1-jsnow@redhat.com>
 <CAFEAcA8un6eescSDzd+P+jqEGuGkuQXgfjm+1=CPOydg6WQSnQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8un6eescSDzd+P+jqEGuGkuQXgfjm+1=CPOydg6WQSnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/16/2017 09:34 AM, Peter Maydell wrote:

> Hi; I'm afraid this doesn't build with clang:
>=20
> /home/petmay01/linaro/qemu-for-merges/hw/ide/core.c:70:15: error:
> comparison of unsigned enum expression >=3D 0 is always true
> [-Werror,-Wtautological-compare]
>     if (enval >=3D 0 && enval < IDE_DMA__COUNT) {
>         ~~~~~ ^  ~
> 1 error generated.
>=20
> (It's impdef whether an enum with all positive values is
> a signed type or unsigned type, so just deleting the
> comparison against 0 would also be wrong...)

But if ((unsigned)enval < IDE_DMA__COUNT) {

should work, regardless of the signedness of the enum.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rj1LbU7xP6O4rDnAUGVIouXg8ppKXfEU9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/z2AACgkQp6FrSiUn
Q2qV/Af/Tb2ON87PajGjbiNMGgR7vIvIOsCsDOGMOGKRsgJPvZHRPIj2fmYkSc0P
BeSPqi2C9axGY/0n8kOvxIU6KRK8aXOrJqrTi8jRKOUCjHI+E/kBJrTVtGaSqCpz
FSsEAD7GeArdnyqyKtMsmTTfop/eg9FMjVU5S8hWfTpPGO9zx7m6nGWeL/Vuj/a7
yWs68yANNZT+0YbRik6wJVKhVn35CQDzLWXuARDTCUetc0lYA5q698erPPeE3K0C
OUFNN27oO+6iqpuB1SwSq21GlEpITMKbmES02q8x2FgYeJhuhz95aqCNS+ZIhfYw
lVtsIiZtf/umdHo7R+8toZ6VVdTBSg==
=TYF1
-----END PGP SIGNATURE-----

--rj1LbU7xP6O4rDnAUGVIouXg8ppKXfEU9--
