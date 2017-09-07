Received: from eggs.gnu.org ([2001:4830:134:3::10]:47068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dptkH-0006hS-Bq
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dptkG-00050C-A0
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:09:13 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:51971)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dptkF-0004z2-Ty
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:09:12 -0400
Date: Thu, 7 Sep 2017 20:08:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170907100848.GL2735@umbus.fritz.box>
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907095142.GA2194@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qo7zVO9a9OQ5oQtr"
Content-Disposition: inline
In-Reply-To: <20170907095142.GA2194@work-vm>
Subject: Re: [Qemu-devel] [RFC PATCH qemu 0/4] memory: Reduce memory use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>


--qo7zVO9a9OQ5oQtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2017 at 10:51:42AM +0100, Dr. David Alan Gilbert wrote:
> * Alexey Kardashevskiy (aik@ozlabs.ru) wrote:
> > This was inspired by https://bugzilla.redhat.com/show_bug.cgi?id=3D1481=
593
> >=20
> > What happens ithere is that every virtio block device creates 2 address
> > spaces - for modern config space (called "virtio-pci-cfg-as") and
> > for busmaster (common pci thing, called after the device name,
> > in my case "virtio-blk-pci").
> >=20
> > Each address_space_init() updates topology for every address space.
> > Every topology update (address_space_update_topology()) creates a new
> > dispatch tree - AddressSpaceDispatch with nodes (1KB) and
> > sections (48KB) and destroys the old one.
> >=20
> > However the dispatch destructor is postponed via RCU which does not
> > get a chance to execute until the machine is initialized but before
> > we get there, memory is not returned to the pool, and this is a lot
> > of memory which grows n^2.
> >=20
> > These patches are trying to address the memory use and boot time
> > issues but tbh only the first one provides visible outcome.
>=20
> Do you have a feel for how much memory is saved?

I think that's a bit hard to answer.

As noted above there's O(n^2) (or more) space complexity here - one
which shouldn't be required by the data we actually have to track.
That means the amount of "excess" memory depends on how many devices
there are.

I haven't yet looked at these patches in detail, to know if it truly
fixes that O(n^2) or just pares the constant.  If it does fix the
O(n^2) then the amount is going to vary from "probably not enough to
worry about" in normal use cases to hundreds of gigabytes in cases
with many devices.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qo7zVO9a9OQ5oQtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmxGrAACgkQbDjKyiDZ
s5LOJRAAsLuVP7iGPDcX4ixYKtwrrnt5oECgO+SY4IbcomaQ969PtgG8lTtO6x81
Hy7gMBjoAZSj0ZIBj8GhXYOmlEdOhVc7Z7kuo7EsnWN6wP8ixZi1nXlh6tvWzpW1
B3ItNZbQtmzH7fgYkY7TniQ5sq2knS72FtG3kdVw/1BrPWDtwbbQ3M+yFx+qGA0Y
/ry4sbjBDwcED7MXC8Uip+yPjphW4Uc/DjzXoEOEhmtiQqLXWMY/CW8sLdrAE8BR
INDKsjq4c9CSii4USNXz85a13jxV1d1gck0B1I6D+Tr/TUGS4pDrXDyOryDF+nnE
GCFNLtoWOKA6aaxDOfiqVLt0mjOJVzOhuNOaddgllj2kl1fx6Vv2vSsY1JqV0Ozi
odBw9P43fx4INPZDJUM6aihPLJVF9lpux1QG+NYZ6OUx5WlCBooBWZcs4ymxwJtB
/l/dmgpwmFh/SU+Xe/qk8Sd2IfISdW4T7TgAOZMYybyaQaCDRe3zi5b8T2ZlBNFX
PCaJZPD4gGHC+N9zB/7nuSa0UwXa08Ub8JuD2Q4OVVgZn2/EFaH5GLGy6TWj4h5M
tD9lAJP45iRykgRyDlot7/g1hS4Jm4DszHg9BTsq0waUZmFmU4Tg3kFC8Wfsvl0a
h5pu3bq1cEWd9VBkxD2OMEc2xilQTYCDYdX6rf4sfJqJhluonD0=
=/os0
-----END PGP SIGNATURE-----

--qo7zVO9a9OQ5oQtr--
