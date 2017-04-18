Received: from eggs.gnu.org ([2001:4830:134:3::10]:60369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0KKj-0001uA-PC
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0KKg-0005PS-P9
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:01:41 -0400
Received: from ozlabs.org ([103.22.144.67]:56477)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d0KKg-0005Mt-4z
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:01:38 -0400
Date: Tue, 18 Apr 2017 13:46:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170418034657.GI12235@umbus.fritz.box>
References: <20170417215916.12431-1-ehabkost@redhat.com>
	<20170417215916.12431-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D6z0c4W1rkZNF4Vu"
Content-Disposition: inline
In-Reply-To: <20170417215916.12431-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC 1/7] pci: Change pci_host_bus_register()
 parameter to PCIHostState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>


--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2017 at 06:59:10PM -0300, Eduardo Habkost wrote:
> The function requires a PCI_HOST_BRIDGE object, so change the parameter
> type to reflect that.
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci/pci.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 259483b1c0..25118fb91d 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -312,11 +312,9 @@ static void pcibus_reset(BusState *qbus)
>      }
>  }
> =20
> -static void pci_host_bus_register(DeviceState *host)
> +static void pci_host_bus_register(PCIHostState *phb)
>  {
> -    PCIHostState *host_bridge =3D PCI_HOST_BRIDGE(host);
> -
> -    QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
> +    QLIST_INSERT_HEAD(&pci_host_bridges, phb, next);
>  }
> =20
>  PCIBus *pci_find_primary_bus(void)
> @@ -377,7 +375,7 @@ static void pci_bus_init(PCIBus *bus, DeviceState *pa=
rent,
>      /* host bridge */
>      QLIST_INIT(&bus->child);
> =20
> -    pci_host_bus_register(parent);
> +    pci_host_bus_register(PCI_HOST_BRIDGE(host));
>  }
> =20
>  bool pci_bus_is_express(PCIBus *bus)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--D6z0c4W1rkZNF4Vu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9YwxAAoJEGw4ysog2bOSPMkP/2F7+xOF8fUdG2Dd3w5wtaSi
w8M8AhE6RZ+aVqllELSQxMwKd42ji+EylIRtfOxA98wtA8Gr8Atm05TjHoCjTA+a
LEgRa0K6hb1vmQBVI5GNIbqhNdWCh1u8Znre3bhdYwtoFizQM1arhO/FY4KhUiln
YFlHYGkPhkJNtDoXnALZFPmd/dIBmZGrh+qMFq++OGPEHJr93FxWpffw4DMkJyk1
PQL76jeq/csAistbLFMhw1KmGtFM1jxl6u48+yHsqxPI5gr18aSKiIiGsMgxLTNy
m0ppt2Y94aN2YB7gSY+HTIqCu4UzvLFiM5gJ+hscOSZTshMrAaW2QGEOQwcR4/fz
XDy/186K+o2U+UQqirOFwABiwfCbH5r3OSBxMAUU3edj4naSncnBG+7mPM2l8D2u
ZlKRnDKunOuzwBokfDm0Qic2X5RpzhdcJxa/iieEq81IWla5VnFVl83Hb0Wr1w08
FfqFqlOImQthFAW4Y5jwb9a7iPQGhNn9aT9ZHVzehxZ5vIGxT+3hWwtp3gxDOcGO
zN8gtwae7OZT6KQ333H8fe982rDUWR6B3jJr8YFnsxtHFA8s/LnYUkJ0m2Em6JBD
UkLHFn5STbDCsOPIuZVdL1MrjLsFTfnILBAwjcjjongQHZ15vG+EF+LD+5FTSoAc
LPtJkyh++Ny3hMy1IiAt
=MSvM
-----END PGP SIGNATURE-----

--D6z0c4W1rkZNF4Vu--
