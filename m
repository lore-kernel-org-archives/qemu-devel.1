Received: from eggs.gnu.org ([2001:4830:134:3::10]:40640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dlEgH-0003AO-JF
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dlEgD-0005mR-KL
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:29:49 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dlEgD-0005l9-85
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:29:45 -0400
Date: Fri, 25 Aug 2017 23:19:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170825131956.GK2772@umbus.fritz.box>
References: <20170824123006.GK5379@umbus.fritz.box>
	<20170825083123.47432-1-aik@ozlabs.ru>
	<4608a2c1-5c74-efea-d901-3b5cfa0519e6@redhat.com>
	<CAFEAcA_Z3wWv3_x0kCqD0tEwP=GTV-uoCLmUr5YpWjdD1GyMew@mail.gmail.com>
	<0e7817c4-4189-c620-e71c-d935076286ad@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nzri8VXeXB/g5ayr"
Content-Disposition: inline
In-Reply-To: <0e7817c4-4189-c620-e71c-d935076286ad@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH qemu] exec: Destroy dispatch immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>


--nzri8VXeXB/g5ayr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2017 at 11:57:26AM +0200, Paolo Bonzini wrote:
> On 25/08/2017 11:22, Peter Maydell wrote:
> > On 25 August 2017 at 09:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> The solution is to: 1) share the FlatView structures if they refer to
> >> the same root memory region; 2) have one AddressSpaceDispatch per
> >> FlatView instead of one per AddressSpace, so that FlatView reference
> >> counting takes care of clearing the AddressSpaceDispatch too.  Neither
> >> is particularly hard.
> > If we did this we could get rid of address_space_init_shareable(),
> > right? (It's a bit of a cheesy hack aimed at avoiding having duplicate
> > address space structures for the same root memory region, but if
> > the underlying code is better at not duplicating all the data
> > structures unless necessary then the benefit of having the
> > separate API goes away I think.)
>=20
> Yes, indeed.

Hm.  Why do we need to construct full ASes for virtio-blk, rather than
just MRs?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nzri8VXeXB/g5ayr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmgI/wACgkQbDjKyiDZ
s5KlzQ//cQom896baFU+dZUAQjP1OyvqLNXGI/LD3hIyLhYI4373h7P6IfpMi6eS
bPvGBp37HZnH5zQwxAlvH+m/Oa/pj2ohFXa00oW+lcqEZTlCTS0E/gIu+m8tMdpY
YFN+FRKf209EPbSAASUfd7Kg+iZHLstwXjtGgL7gLHyDoG4e+/hqt43Hspt7R9/v
mjRuKEkDmeUGlywEM07rPLdChh4rnwhbygSquLPXbsp+4XVez8oZxughBLg83QOc
9P/IFIfDds+ZgQhs9+Fe40LnhuBO5P8uTDV692x8tD+R6F1rV9p7+K0aw3VDvm2S
GCnlD40UgOrsvXgmBQKG1hGjPtrSWohvmmycwXR/EfIApsz2TY5ac+9MYvwxCLNZ
3egXhJ4fff4E90lqSD1C6+S7aqLYjlEyOj518i+RZBgis2V5exaDkGyGzeQgAJzW
TllOxAS3rc20zki+XxajUbnuT6apbxnbK0d6o0cKAmeHdwhPx/ke/9nNNAwZwrJG
jP0GaZJxkbOLeN4mpTB/69hKJgCZHqKZd1xvHN3SLNJixqQw3zYP+13o52LZWyMw
xEKAFiNNrVLmZ5rvqYkkJpaHDoyBJUxz4mrBP3csoEfHRtbuKe5IapODvihmU1Ec
YfSn8HzL7zFO2Ha88hfQiSXIWsSTyuy/KruSYqho5ItkXNbr0aw=
=vDCy
-----END PGP SIGNATURE-----

--nzri8VXeXB/g5ayr--
