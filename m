Received: from eggs.gnu.org ([209.51.188.92]:54008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbX-0005dG-G1
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbO-0003cQ-MC
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:24 -0500
Date: Wed, 20 Feb 2019 14:30:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190220033053.GO9345@umbus.fritz.box>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8+odlFQADydc3R4z"
Content-Disposition: inline
In-Reply-To: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/17] spapr: Add support for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--8+odlFQADydc3R4z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 06:17:33PM +0100, Greg Kurz wrote:
> This allows to hotplug/unplug PHBs. I could successfully test:
> - using in-kernel XICS, emulated XICS and XIVE
> - hotplug/unplug with e1000 device to validate LSIs
> - hotplug/unplug with virtio-net device to validate MSIs
> - some simple migration scenarios
>=20
> Based on David's ppc-for-4.0 branch SHA1:

Applied!

>=20
> 6f585625d0d1 target/ppc: Basic POWER9 bare-metal radix MMU support
>=20
> Please comment.
>=20
> Changes in v5:
> - all DRC subtypes generate FDT fragment at configure connector time
> - Drop all the LSI bitmap and allocation/typing disintricate stuff
> - set IRQ type in KVM at claim time
> - fix hotplug call chain
> - added PHB unplug test to tests/device-plug-test
>=20
> Changes in v4:
> - added a LSI bitmap to XICS
> - no longer need compat property in XICS
> - simplified the patches to access the name and the phandle of the
>   interrupt controller
> - delay the creation of the PHB drc->fdt to RTAS ibm,configure-connector
>=20
> Change in v3:
> - reworked phandle related code some more
> - disintricate allocation/"type setting" of interrupts
> - identify LSIs at machine init
>=20
> Changes in v2:
> - rebased on current ppc-for-4.0
> - added some preliminary cleanup
> - call unrealize from realize error path
> - advertise PHB hotplug in last patch
> - reworked phandle related code
> - sync LSIs to KVM
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8+odlFQADydc3R4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxsye0ACgkQbDjKyiDZ
s5La6BAAidbqtFSX3xaPlZGFWz95GUQ3xGmy8s0OD/R7U0DK5Q2jO/9Dx4rNrksu
6U3I3cAo7X/ZDsrWqo+osOuxKmnuo76Fr0TGRnM0YuwWYy/nTEzG8mrH5XU8ekrw
6Hd0et9pTjPNdf0fJhALBZEHLOsCLZTtCKSPCX97X7ZYYIkd05iCYNA77jaZnJ0A
jI0cL65NF2lJvQ4BmOP5pK+8PZDDoTk/rsc8fjYR8rZ4JH3M6RoMAIdYTQsQKUQc
U02pT4ComgQic4Rb+occFemCuBqhZYkgP65lHr4fPiJxpY6am3/nmYcDatTHVaeF
IpUP/hGFoj5fD9IoHWeuEQ1x1UO+bSu45QaNG3fl0be2PAoLlGZpgLY5/HVn4Bbs
FrIiKxgmyE0jAchvmopUguhLLkqusigrzAkL2JZt9CqtYn2fOpIOlhG7WixoL3ro
y7eeL3SHI6rQhTRJc7LAWd/XqvTKTIGYyDpE56cJpfkLc8unqyALtWbNcZCPMOX5
OzAsO9c/V1D/yFP9u7JRONFl+bsSMuWvHWkVkKX2DTRTWBgyObIILUAlGjSvCU98
SrfptiiGpvkG06JfCExMgmQOuXuAtES/9ODaj9MGM+Hng5mYxHcD+yMIVclXucoz
NjhmA0Ldbe9bwPxmMQhwuR1M09ftCs+fI3DR0nc10xb8oLxTksM=
=KHqL
-----END PGP SIGNATURE-----

--8+odlFQADydc3R4z--
