Received: from eggs.gnu.org ([2001:4830:134:3::10]:48675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0dYD-0002n3-9h
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 20:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0dYA-0005ub-6S
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 20:32:53 -0400
Received: from ozlabs.org ([103.22.144.67]:38837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d0dY9-0005tl-EJ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 20:32:50 -0400
Date: Wed, 19 Apr 2017 10:22:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170419002211.GA23273@umbus.fritz.box>
References: <20170418221724.5707-1-ehabkost@redhat.com>
	<20170418221724.5707-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20170418221724.5707-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 1/6] pci: Inline pci_host_bus_register()
 inside pci_bus_init()
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


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 07:17:19PM -0300, Eduardo Habkost wrote:
1;4601;0c> There's no need for a separate function just to append an item to
> pci_host_bridges.
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci/pci.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 259483b1c0..328f36cd21 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -312,13 +312,6 @@ static void pcibus_reset(BusState *qbus)
>      }
>  }
> =20
> -static void pci_host_bus_register(DeviceState *host)
> -{
> -    PCIHostState *host_bridge =3D PCI_HOST_BRIDGE(host);
> -
> -    QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
> -}
> -
>  PCIBus *pci_find_primary_bus(void)
>  {
>      PCIBus *primary_bus =3D NULL;
> @@ -369,6 +362,8 @@ static void pci_bus_init(PCIBus *bus, DeviceState *pa=
rent,
>                           MemoryRegion *address_space_io,
>                           uint8_t devfn_min)
>  {
> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(parent);
> +
>      assert(PCI_FUNC(devfn_min) =3D=3D 0);
>      bus->devfn_min =3D devfn_min;
>      bus->address_space_mem =3D address_space_mem;
> @@ -377,7 +372,7 @@ static void pci_bus_init(PCIBus *bus, DeviceState *pa=
rent,
>      /* host bridge */
>      QLIST_INIT(&bus->child);
> =20
> -    pci_host_bus_register(parent);
> +    QLIST_INSERT_HEAD(&pci_host_bridges, phb, next);
>  }
> =20
>  bool pci_bus_is_express(PCIBus *bus)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9q2wAAoJEGw4ysog2bOSIiUQAMIZHYBZWi62S3xCgaS3M7nO
br5qU5UxOtVWtYAMoOzPYlo1Os0rSkSxI2eMTmPrgOGOXQzlFvwMJG+btiPrYjUy
p7aFfITznLY1var3bZypmKjTeR1Sz3aTgikctbKhyigMGsy+MDktmP183GfEqEci
9dJYUrI45anf+zcaofzWP0j7e/7nJEMoT7wzCUkDPOwUlJBHOXUnLMySU89WaeU+
VIMOSZBE9roMVEYF2XGmSQBzNEE34LsS6swdzMN3MuTM38zfwuOBirCiDNMpz7FB
0D0MZPExgYxFX6RsxREdqSC0hPJYSuYNgHEps4Qei9hL//hrJZXSxHS/Sf2HQ60q
ERcmfJedV3AHIM9tOLGHZT1jBLNmB5GrLYLm8ycNPM/BNIx80h0gH1bP9v7Uh4+6
cmSs5m56qVYQrBU6XzWq3YawIFJIZhgU1mSgV9N4ExQQqbO/vPoY97nQN2OqZVDR
m57Y4k/VHw/lhFEXgkb76r16hf5P59auHcEAm/OINbKvyQ/cjTH8xMk8b25a3jig
iZk59n1DZxZqZSzXF/yNgV+jIkrJ/gxB6sDSpKo0itKU679kQ/pwgr4BRM0d4Huh
yFWJiyHtZCkFPW9nFLhvLKDEz3q7foMUoqtXkz6lPmehhvQ8CnQyem1iDvjtmZ8v
k/DLbLttq1cVREdoCH3i
=oQek
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
