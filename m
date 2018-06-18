Received: from eggs.gnu.org ([2001:4830:134:3::10]:52022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fUvoO-0007E0-Eq
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fUvoN-0002eW-Bq
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:11:20 -0400
References: <20180613181823.13618-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1ae11d68-a29d-9c83-74a7-e6918fc11038@redhat.com>
Date: Mon, 18 Jun 2018 17:11:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180613181823.13618-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5DyjCIQ0eK1OmxmznUJaMkQXfCR1e6HNl"
Subject: Re: [Qemu-devel] [PATCH v5 00/14] block/mirror: Add active-sync
 mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5DyjCIQ0eK1OmxmznUJaMkQXfCR1e6HNl
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jeff Cody <jcody@redhat.com>
Message-ID: <1ae11d68-a29d-9c83-74a7-e6918fc11038@redhat.com>
Subject: Re: [PATCH v5 00/14] block/mirror: Add active-sync mirroring
References: <20180613181823.13618-1-mreitz@redhat.com>
In-Reply-To: <20180613181823.13618-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-13 20:18, Max Reitz wrote:
> This series implements an active and synchronous mirroring mode.
>=20
> You can read the cover letter of v4 here (I don=E2=80=99t like to copy-=
paste
> that because people who reviewed previous versions know it already and
> this saves them from having to look out for potential changes):
>=20
> http://lists.nongnu.org/archive/html/qemu-block/2018-04/msg00185.html

Applied to my block branch after deciding (with Kevin) that changing
bytes_handled's comment is not really worth it considering it's going to
be removed in a follow-up anyway.

Thank you for all the reviews,

Max


--5DyjCIQ0eK1OmxmznUJaMkQXfCR1e6HNl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsny48ACgkQ9AfbAGHV
z0ClTAf/VQ1GW/+z5EcYstjnLLeRVHvHMkhl/8AjwPzHtd8nfSMc13zgmkhEBgba
mhgakgnD+ld4mIPhSPkytgdBuGCiwEgh7msJoDOs6lZ4Xse6pejOtWry/HkT2Dpf
XQMEOgxul7QhTMkUCCm3tVRuaruDLoYkytm70kc1Vd9bVfbeoCSXoKgNJKGPaReO
aZBVvxZ5ORvyrUMqzZSEyLK9NLiWUSieIb0Monvim7KmrWwLhlnJ3LcsI60+z9sY
h9zKJuFa+ergajT5g5jgnY/pGHgUsI+73XMdoPF6Eh6P88c60xxIYSLp0vxMdvbh
ws6fS6CF1WUPMXhjevO90CsljrzKkw==
=VGXk
-----END PGP SIGNATURE-----

--5DyjCIQ0eK1OmxmznUJaMkQXfCR1e6HNl--
