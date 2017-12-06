Received: from eggs.gnu.org ([2001:4830:134:3::10]:34642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMWkr-0008FT-D6
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMWko-0007ZL-5O
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:16:41 -0500
Date: Wed, 6 Dec 2017 21:03:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171206100346.GZ3057@umbus.fritz.box>
References: <1512488477-209071-1-git-send-email-imammedo@redhat.com>
	<20171206001406.GP3057@umbus.fritz.box>
	<20171206105732.050435da@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E9SPMlsjsjqOlA3h"
Content-Disposition: inline
In-Reply-To: <20171206105732.050435da@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2.12] spapr: replace numa_get_node() with
 lookup in pc-dimm list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, qemu-ppc@nongnu.org


--E9SPMlsjsjqOlA3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 10:57:32AM +0100, Igor Mammedov wrote:
> On Wed, 6 Dec 2017 11:14:06 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Dec 05, 2017 at 04:41:17PM +0100, Igor Mammedov wrote:
> > > SPAPR is the last user of numa_get_node() and a bunch of
> > > supporting code to maintain numa_info[x].addr list.
> > >=20
> > > Get LMB node id from pc-dimm list, which allows to
> > > remove ~80LOC maintaining dynamic address range
> > > lookup list.
> > >=20
> > > It also removes pc-dimm dependency on numa_[un]set_mem_node_id()
> > > and makes pc-dimms a sole source of information about which
> > > node it belongs to and removes duplicate data from global
> > > numa_info.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > > Beside making code simpler, my interest in simplification
> > > lies in allowing calling parse_numa_opts() multiple times,
> > > without complex cleanups in case NUMA config is changed
> > > since startup.
> > >=20
> > > PS:
> > > build tested only
> > > ---
> > >  include/sysemu/numa.h | 10 ------
> > >  hw/mem/pc-dimm.c      |  2 --
> > >  hw/ppc/spapr.c        | 29 +++++++++++++++-
> > >  numa.c                | 94 -----------------------------------------=
----------
> > >  4 files changed, 28 insertions(+), 107 deletions(-) =20
> >=20
> > Applied to ppc-for-2.12.
> Thanks
>=20
> >=20
> > It definitely seems like an improvement over what we have.  Looking
> > back at the DIMM list from QMP in the loop seems a little roundabout
> > though.  Maybe we'd be better stepping through the DIMMs, then
> > stepping through the LMBs within each DIMM, rather than just stepping
> > through the LMBs directly.
> Surely that would be better, maybe someone from ppc side would take care
> of it.

Well, it's now on my vast list of things to look at if I ever have
time..

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E9SPMlsjsjqOlA3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlonwIAACgkQbDjKyiDZ
s5Lw2w/7B8RMODFvYw2stq/gyLRTBl3xoNofMPRKaoasaO5LP2rsQbybPp25brtE
/xBFQZZHgkxf5Cx/ilpnkZSY/5+yEyRXhGEbN6jZasrcDDGQR+V7uC8sWBTxhH6S
E6mta33yg/RpTEQjkTkvl0mraHb87Gx/45DlMopYFAsPZoZbs0vbmlbDNLHbUy0r
aKeTrSFFdG+exia1A9/JcCeuazwwbo0cIvB+9V17dZjz1cN+scYBI9z3NQN2eDS5
nhU+uEP4XSVFMvrCr3YVS8doj6Rmn3/yAXENpDSEUElyVXlC8LhNWg5NXZgqt6YP
+wBWHJxh26cZ223tnuHrI7fwOUZJqoWWHGlIVgHBNj9B+xBzNaFzQJhxUdt0nvZJ
I/5+v/jfiV0I7KKX0VNnFU7AmBDdpXrLFwYeRUEoUgRAiT9wKoUIex8//eQoD1Bm
/FRbtr1Ru7w4uGIySBUpehgEb+s6DZgTxrR86EE1IBliXSkQZ2nIiwd4z3UKwixe
IVRJmqfX4MrGcs/1XAjPc3G+4IwKsAHzZ/znieGOLofKH0ZGwmeyPB7Co9ScxQco
WzeDMD9XRyzmzGspY1tby4PnrhfpIpGFw80dXaeRRqBKLZe7eP5MQwVWNZ2wtP0/
6I3teIVQAbNPTtLQGDEKkEN4My8m+1trfr5tE9YR23vBTlBoiPY=
=YVJy
-----END PGP SIGNATURE-----

--E9SPMlsjsjqOlA3h--
