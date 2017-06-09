Received: from eggs.gnu.org ([2001:4830:134:3::10]:53718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJ9mW-0007bc-D6
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJ9mV-00013x-Ei
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:36:12 -0400
Date: Fri, 9 Jun 2017 12:28:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170609022813.GF26521@umbus.fritz.box>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Content-Disposition: inline
In-Reply-To: <149692935202.12119.3614006195497745877.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v4 0/6] spapr/xics: fix migration of older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 03:42:32PM +0200, Greg Kurz wrote:
> I've provided answers for all comments from the v3 review that I delibera=
tely
> don't address in v4.

I've merged patches 1-4.  5 & 6 I'm still reviewing.

>=20
> v4: - some patches from v3 got merged
>     - added some more preparatory cleanup in xics (patches 1,2)
>     - merge cpu_setup() handler into realize() (patch 4)
>     - see individual changelog for patches 3 and 6
>=20
> v3: - preparatory cleanup in pnv (patch 1)
>     - rework ICPState realization and vmstate registration (patches 2,3,4)
>     - fix migration using dummy icp/server entries (patch 5)
>=20
> v2: - some patches from v1 are already merged in ppc-for-2.10
>     - added a new fix to a potential memory leak (patch 1)
>     - consolidate dt_id computation (patch 3)
>     - see individual changelogs for patch 2 and 4
>=20
> I could successfully do the following on POWER8 host with full cores (SMT=
8):
>=20
> 1) start a pseries-2.9 machine with QEMU 2.9:
>         -smp cores=3D1,threads=3D2,maxcpus=3D8
> 2) hotplug a core:
>         device_add host-spapr-cpu-core,core-id=3D4
> 3) migrate to QEMU 2.10 configured with core-id 0,4
> 4) hotplug another core:
>         device_add host-spapr-cpu-core,core-id=3D2
> 5) migrate back to QEMU 2.9 configured with core-id 0,4,2
> 6) hotplug the core in the last available slot:
>         device_add host-spapr-cpu-core,core-id=3D6
> 7) migrate to QEMU 2.10 configured with core-id 0,4,2,6
>=20
> I could check that the guest is functional after each migration.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOge8AAoJEGw4ysog2bOS8a0QAIHE9+VxEq4SSDZXPwajm65L
770ywGXw2dYE5keBgqzsNQ38CKOFTPtyzhgDzjV4F3V8YZ42aGCp5hitaTYUoj9n
4VHQySTif/1i2cerujdDVSnYPac2+CVWGGyfxbLpyBfUKlmZjsbkVcoqstpKjD0a
QchiRY4kjVTwvr7q5c2WYqVjVji5gU6aLewUiuxvzyzNhso99ZlWQ2ESHAFxA2ht
V01pwq72rlb7XxEeyQ95s8L1huVKHVu9NWBChxEG//UcDlKjKGAMRHcn5fyKaiiC
PwX6nx0C8F1ysBLuGa/AXU7QE2zj6iQ9wtCYMpiHeJEo4Z9C7scbGPjyfIP19gvC
GvueZd4YaRdVkIOE8ZVAf6su8R9gM0PVLpUC7TP3w2/rmOVngloQr49+3Sou8kzS
j1vnbv9OY40RP3xNdWCIVUdB05EJa/5TGYdHRQic9xvDFJgV17Ax/+Q9KHYgOiN1
1nwvBp3AwV6UsZCDHTdC8iD1HZn72SdZQ4b572VDhy9VeE4A1I+KoNVTppW9/po1
KzW/eMu8HdqdcTj4FxktAzHIkrkPoCj3DOKx3Iha3fcYk764xiMeoLA244cIJ0tb
nwxVVQrDuVdwe127l6Js+pa6/2nRcBnCTvgP35ggoQ0UEIxpKIXdxPvn4+AYxTlo
ZAK3aA0YsBtirQSU0hzT
=jC07
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
