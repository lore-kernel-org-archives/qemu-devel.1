Received: from eggs.gnu.org ([209.51.188.92]:43726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1glNAo-0004Qv-GE
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 19:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1glNAn-0003b3-L2
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 19:10:42 -0500
References: <20190120055558.32984-1-liq3ea@163.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <858c1f7f-d48e-a946-309d-1a7afdaf4aca@redhat.com>
Date: Mon, 21 Jan 2019 01:10:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190120055558.32984-1-liq3ea@163.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3iFt62yo2urRl3GZstvT1Uk0q49WKz5c0"
Subject: Re: [Qemu-devel] [PATCH 0/3] nvme small fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, keith.busch@intel.com, kwolf@redhat.com, philmd@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3iFt62yo2urRl3GZstvT1Uk0q49WKz5c0
From: Max Reitz <mreitz@redhat.com>
To: Li Qiang <liq3ea@163.com>, keith.busch@intel.com, kwolf@redhat.com,
 philmd@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <858c1f7f-d48e-a946-309d-1a7afdaf4aca@redhat.com>
Subject: Re: [PATCH 0/3] nvme small fix
References: <20190120055558.32984-1-liq3ea@163.com>
In-Reply-To: <20190120055558.32984-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.01.19 06:55, Li Qiang wrote:
> This patchset contains small fix.
>=20
> Change since v2:
> For patch 2:
> 1. add nvme command
> 2. check num_queues first
>=20
> Change since v1:=20
>=20
> 1. drop the patch of checking return value of msix_init_exclusive_bar
> 2. return when nvme's num_queues configuration is 0
>=20
> Li Qiang (3):
>   nvme: use TYPE_NVME instead of constant string
>   nvme: ensure the num_queues is not zero
>   nvme: use pci_dev directly in nvme_realize
>=20
>  hw/block/nvme.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--3iFt62yo2urRl3GZstvT1Uk0q49WKz5c0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxFDeoACgkQ9AfbAGHV
z0C1uQf/WlvFJnbLEf8ShRrMLvQZ2Czk4JWqXDPRfwNxSPh73UFBjxri8WJnBbVF
icbXpF+qc3bUgt8nNIGhDLE0zCH1TPeVCK+k27psimnA4onz8BpT1MlzqFpOFniP
eRMZdxald0lALAAzTULUXwdcAq+Ef7/UaC0yKgQPrPTUnQpwUvKpCXm8qIkyw4gH
9dE+LIXc5tCC5fHfrjVP70qX9HpjiUwx1i9RXPiPygl46z7hFd/TBjy5neMMJ9Xj
DqaGQ6QoNfn1jgKsen8hOa8jn5XGL32unR0i5L7nAxLqAYrJ/V2F/2yiW6G49f0+
5pX6oHDJo433fpk8C3MKBIXxRlezhw==
=xCSS
-----END PGP SIGNATURE-----

--3iFt62yo2urRl3GZstvT1Uk0q49WKz5c0--
