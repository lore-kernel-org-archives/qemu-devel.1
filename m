Received: from eggs.gnu.org ([2001:4830:134:3::10]:51210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fp2EC-0004Mi-VX
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fp2E9-0002Du-Rd
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:05:04 -0400
Date: Mon, 13 Aug 2018 12:01:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180813020109.GI4079@umbus>
References: <20180810102757.21010-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jQIvE3yXcK9X9HBh"
Content-Disposition: inline
In-Reply-To: <20180810102757.21010-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 0/2] mac: don't use legacy
 fw_cfg_init_mem() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--jQIvE3yXcK9X9HBh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 11:27:55AM +0100, Mark Cave-Ayland wrote:
> Here are a couple of patches to switch the fw_cfg initialisation for
> the Mac Old World and New World machines over to use qdev rather than
> using the legacy fw_cfg_init_mem() function.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-3.1, thanks.

>=20
>=20
> Mark Cave-Ayland (2):
>   mac_oldworld: don't use legacy fw_cfg_init_mem() function
>   mac_newworld: don't use legacy fw_cfg_init_mem() function
>=20
>  hw/ppc/mac_newworld.c | 12 +++++++++++-
>  hw/ppc/mac_oldworld.c | 12 +++++++++++-
>  2 files changed, 22 insertions(+), 2 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jQIvE3yXcK9X9HBh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltw5mUACgkQbDjKyiDZ
s5LW2g//efep2roqBSpFMs+f2ByFa8C10k5qpbksfYn91gcrHJUSifOpGMAauKAp
TaiY0G4OURE4W8OE96P+rebqqFwh2zU7a/9en7hOp/Ir25AOewlU9KudYArhEOXJ
IMoxNq1kDSjgbete9cBcAqoAuKY/ckgomzrOcKqD1SoVUrcpiSMG+jFDaQ/9HKqY
CyhIvGUKQzE+jOnlQbQLjeOxM87mC7OLcjTGvfEV3LbKEwl54/bp5c66xqs2y140
06uTKOuYowToiLqxQ0u6vBEyHdoQgKzbAfVGnAvmrxmtGx4ZqleNc89ANUBBfAIh
Ggv6w1PdLFkxOVcgnTOb8Q49+iEs5pNfkafwY7DsaF5xqFeRzILr/Sk6QdRw4XuO
OQQPPZXSyXb6yAXT/n+qaR4B+q0XxDnopu0u1PphIRi/Rmh5hgHUWSXYF0doPIy3
Uv2lbnEb8P8Ak23SHdBIDRysXjO5ocwx2gSWUbDdh+URvePGJ8MYqCBbLCJMNReI
bWPKfslGt2CGhajj9EndKT8NRcw31Ppuj509igwg3vsNvy+oId5IteM7rMbnnxpE
275k+1jDdENYOzRngIcIlxc/QGAegmFC2DB0Ksyj8wTipXINz77SZT0YmpSyWfuw
Ss1/oH9sZOGluRLYcuac9268f9PWj2ZMnopBg8UORTsdgTq5xd8=
=o9c3
-----END PGP SIGNATURE-----

--jQIvE3yXcK9X9HBh--
