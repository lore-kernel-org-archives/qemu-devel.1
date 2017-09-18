Received: from eggs.gnu.org ([2001:4830:134:3::10]:55204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dtlaY-0000qR-Ph
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 22:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dtlaU-0005G7-JF
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 22:15:10 -0400
Date: Mon, 18 Sep 2017 10:26:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170918002607.GB15823@umbus>
References: <cover.1505570561.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <cover.1505570561.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Sam460ex emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2017 at 04:02:41PM +0200, BALATON Zoltan wrote:
> Resending those patches that were reviewed and did not need any
> changes or only rebasing to latest master so these could go in now.
> I'll get back to the other patches that need more changes later.

Applied to ppc-for-2.11, thanks.

> BALATON Zoltan (4):
>   ohci: Allow sysbus version to be used as a companion
>   ehci: Add ppc4xx-ehci for the USB 2.0 controller in embedded PPC SoCs
>   ppc4xx: Add more PLB registers
>   ppc: Add 460EX embedded CPU
>=20
>  hw/ppc/ppc405_uc.c          | 12 +++++++++---
>  hw/usb/hcd-ehci-sysbus.c    | 25 +++++++++++++++++++++++++
>  hw/usb/hcd-ehci.h           |  1 +
>  hw/usb/hcd-ohci.c           | 15 ++++++++++++---
>  target/ppc/cpu-models.c     |  3 +++
>  target/ppc/cpu-models.h     |  1 +
>  target/ppc/translate_init.c | 38 ++++++++++++++++++++++++++++++++++++++
>  7 files changed, 89 insertions(+), 6 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm/Ep0ACgkQbDjKyiDZ
s5JATw//dWwaKHtumAgzbD1Aq4mmttIwn8mHsuHqM8e7YGB5gHYn9A5/MIqNpRF3
dciyAZNIjIJDg+rTvYgatCYBwgvohTec21ejPNcGv2yNRPVsofQBQSNJd/n4CnJZ
RD2QNoFMAlXhsuggnZM19vhNHVsOf6/iUDcvEIkh7Sb33kym/79dM4zKffRjfD3Z
LG/Vhjs+Ec5n/AdxxzNdde0D0FY/cPemXd0Xfdv1F5yqC3GAHl0z2ixJJmnJRWgr
W4+viW7Kb16uNJjfvRhMeinGuKfndtV0QZdPU54JFp4xwBMF+EiDhkyFtxkpiViI
3WtmNdcI5F+nvj5jAFdxqPUXjJ+wXSSoiakv+2V7R9hzc3S9CToCJ+kF+V172uUW
mwmeGag5u0eeBkFCGZ1yNDeMA1GrZG1ui+Fgwc2cuR8BNzZ+hMsdPvCcfhE+/p7h
rqR3op5seAZvx584UAVhlQ2RgW+PN0CMtbyzI8quO2iW/dkCPsDnH2eX5w7q2yvw
Lvvl+26rdf4/fyGbgNWdJ4rjlrMMn2PkTWhMB9Rus8DnMBqM9vFrFEJxVAzShoUn
wYouv7mKRVYdAIyEzti6G7UDT1iJwmk1C4cOAWmi/qimBo5Dlr+2HlXDSdTFEOVn
W5hApVzF2OK+1bcd9hmO1CZc8W3q5NwTrG0f9gsFplqmqs1JZmk=
=E1qT
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
