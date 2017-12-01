Received: from eggs.gnu.org ([2001:4830:134:3::10]:53885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKnvL-0006r2-8Y
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:13:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKnuc-0007a0-QY
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:12:23 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:57151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eKnub-0007Se-3k
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:11:38 -0500
Date: Fri, 1 Dec 2017 15:25:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171201042510.GH30161@umbus.fritz.box>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-5-david@gibson.dropbear.id.au>
	<20171130062345.GC22901@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tcC6YSqBgqqkz7Sb"
Content-Disposition: inline
In-Reply-To: <20171130062345.GC22901@xz-mi>
Subject: Re: [Qemu-devel] [for-2.12 4/7] pci: Simplify pci_bus_is_root()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2017 at 02:23:45PM +0800, Peter Xu wrote:
> On Wed, Nov 29, 2017 at 07:46:25PM +1100, David Gibson wrote:
>=20
> [...]
>=20
> >  struct PCIBus {
> >      BusState qbus;
> > +    enum PCIBusFlags flags;
> >      PCIIOMMUFunc iommu_fn;
> >      void *iommu_opaque;
> >      uint8_t devfn_min;
> > @@ -440,8 +446,12 @@ struct PCIBus {
> >      Notifier machine_done;
> >  };
>=20
> I would prefer directly defining flags as uint64_t then it's more
> clear that it's a bitmask (enum let me think of only one flag will be
> set, but I may be wrong), but it's fine too to me.

In most languages an enum would only allow one value to be set, but C
enums are weird - they're basically just a funny way of defining
integer constants.

I'm not particularly bothered either way: using the enum type makes it
clear the right set of constants to use with this field, using an int
makes it clearer that bit flags can be set.  So both options are
slightly misleading in different ways.

If there's another vote for uint64_t over using the enum, I'll change
it.

> Reviewed-by: Peter Xu <peterx@redhat.com>
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlog2aUACgkQbDjKyiDZ
s5L3EA/+KmWzRWeVn78I/oib6iLj57gHpRjvnFVT3loKaNpqVAjXIomxG2O3+iux
5cuIXifTNBCCk9SIiZLTT4vWIQD5zI0v3aky7OCEuCq3/dbbCjXBB7Jnl9vSMq++
Hhmau3KlZ+b8Rl4i0fF/92p3W1H/k4yamPN2ob+b5uW1oDj56Z85vhexOR+7aJL1
iZxl/beW361wNHL6P9scaB6pBm1IeUpDSrdg55T9lPrCG55iHQMGz74jyKKBtbYO
hVnQeo5JlZG2HqIT6khE71wTHOrz5zzeUlanOh0YE39v+KisNttnAD6E71ciFPpc
E5S9ILGEhO/Z8/ro4wyOpGGZXRb0YDHlosLpo1EG9yxR7kziVK2xkysdUMjvYipP
2Bp4/2HN95dBbcGwtnKuuPo0A0E2kdXFLMrSmh9SLMA8dAyLuy7AELGvt17Lm5bM
DX31sRAmeK1mj8EvZfjHT/k+ZdJkfJmZ33T65+Sj5WPU8EquHcnQSmZ0ivC2AYMx
qA8DcXTmJ3Ed2avHNtk44EKAZ4fMCLPWw0n1LoGFR0Awa905kIEnrnIexj/t/ZW4
UXEBsic8brXJV2cTBoqjFIKA1DVo4q9mFmnndB6vqNphrLzErTYpvRXD5nnSxi7E
fAbk9bz8flOuTz9EAuXIRsYw6rHPeLzWAOHL2ItzvFmFma9yv3Q=
=5tte
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--
