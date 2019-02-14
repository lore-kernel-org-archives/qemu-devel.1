Received: from eggs.gnu.org ([209.51.188.92]:33172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guA1G-0007OK-MO
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 00:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu9qg-0001qQ-9w
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 00:46:16 -0500
Received: from ozlabs.org ([203.11.71.1]:36471)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gu9qe-0001pS-V5
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 00:46:14 -0500
Date: Thu, 14 Feb 2019 16:38:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190214053836.GD1884@umbus.fritz.box>
References: <20190214050808.16653-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oDT+BabbEBWcQhh5"
Content-Disposition: inline
In-Reply-To: <20190214050808.16653-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH 0/2] Some small cleanups and corrections to
 PCI-E handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, mdroth@linux.vnet.ibm.com


--oDT+BabbEBWcQhh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 04:08:06PM +1100, David Gibson wrote:
> Here are a couple of cleanups for PCI-E handling which arose out of
> some other work I have in progress.  At least the first of these
> patches has been posted before as part of a different series, but
> wasn't ready to go at the time.

Self NACK.

Sorry, made a sloppy error in my testing and this breaks make check.
I'll repost once I've fixed it.

>=20
> David Gibson (2):
>   pci: Simplify pci_bus_is_root()
>   pcie: Don't allow extended config space access via conventional PCI
>     bridges
>=20
>  hw/pci-bridge/pci_expander_bridge.c |  6 -----
>  hw/pci/pci.c                        | 40 ++++++++++++++++++++++-------
>  hw/virtio/virtio-pci.c              |  1 +
>  include/hw/pci/pci.h                |  5 ++--
>  include/hw/pci/pci_bus.h            | 13 ++++++++++
>  5 files changed, 48 insertions(+), 17 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oDT+BabbEBWcQhh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxk/tcACgkQbDjKyiDZ
s5LS+hAA5kEj8BnbskfFhhFPRwqxYYaFphC2bPUOHCNoQn0w9/Vx2sSJLm55xa75
OlTuI2r4yNDu08/2AV2vgkLkZBlJiv0+JHwjwMo59WXRrS+v9iJ7wW9kCUkofqGo
02OBhHe8VpoGhBoJnJkwv8AxDc9wbqCGadh9aXtdwsoOhGMIf77fOX4hVN2BjrjY
LRL69PdxlbLzpJqsTgpS7RbOj3Zxx5z5KSt80uKP2gjyCZ9J0Wov0gu/NYT1InL/
nbPDQ2x7YKbxpLSPWcRqAy+JThCDfHPhHqj1BaaLdGHA/MrJqco4pBA6myhY/Nmf
eo06bQgn4z5vbeehPnuGCb8bWrgF6bkzRniFEEUNEejIbAvODvHM9Jw/GUBYA+r0
LMfjL5HpXURomgGKRGn3MzGW3JqvgmSGhy0NyDjMVQ3+zzYz0WWglzR554BWHimm
xVqEY98AsK+GDubMfATVPETwj789LFmsICykSY5qeS5ifxGAKbttSXGGYgsXSrpL
Hq7oeiMl23EjluqQg0Hz7mLaAn2CxtyKAnXhF60Rv0bd/3egjCHnto0P2QExPEuz
PjezvKJDE+QH0H/PbTV7vmMgV8+7xKqdWIHi21RKP2IffBKMxI1IHRCTcC19F7Fi
S20D/QWdVQP//c3qKtsdE1UkkLji06UMFCWOqLTNXwjNmK0wWTk=
=CNm9
-----END PGP SIGNATURE-----

--oDT+BabbEBWcQhh5--
