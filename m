Received: from eggs.gnu.org ([2001:4830:134:3::10]:33696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5kud-0006WN-VX
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5kuc-0003tB-Sv
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:29:43 -0400
Date: Tue, 10 Apr 2018 14:24:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180410042432.GI3361@umbus.fritz.box>
References: <1522938923-96058-1-git-send-email-spopovyc@redhat.com>
	<20180406102136.57efebb1@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mXDO3udm/xYWQeMQ"
Content-Disposition: inline
In-Reply-To: <20180406102136.57efebb1@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for 2.13 0/2] target/ppc:
 Support adding memory to initially memory-less NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Serhii Popovych <spopovyc@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--mXDO3udm/xYWQeMQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 06, 2018 at 10:21:36AM +0200, Greg Kurz wrote:
> On Thu,  5 Apr 2018 10:35:21 -0400
> Serhii Popovych <spopovyc@redhat.com> wrote:
>=20
> > Now PowerPC Linux kernel supports hot-add to NUMA nodes not populated
> > initially with memory we can enable such support in qemu. This requires
> > two changes:
> >=20
> >   o Add device tree property "ibm,max-associativity-domains" to let
> >     guest kernel chance to find max possible NUMA node
> >=20
> >   o Revert  commit b556854bd852 ("spapr: Don't allow memory hotplug to
> >     memory less nodes") to remove check for hot-add to memory-less node.
> >=20
>=20
> But the series do the changes in the opposite order...=20

Right, the patches should go in the reverse order to avoid breaking
bisections.

> IIUC correctly a recent kernel will mis-behave as before linux commit
> a346137e9142 if the property is not present... ie, patch 2 should come
> first.
>=20
> > See description messges for individual changes for more details.
> >=20
> > Serhii Popovych (2):
> >   Revert "spapr: Don't allow memory hotplug to memory less nodes"
> >   spapr: Add ibm,max-associativity-domains property
> >=20
> >  hw/ppc/spapr.c | 33 +++++++++++----------------------
> >  1 file changed, 11 insertions(+), 22 deletions(-)
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mXDO3udm/xYWQeMQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrMPIAACgkQbDjKyiDZ
s5LguxAAxrjgsU3d2l9eJ0zUWDmAWdbHlHPdNvSh4clNQA9BitjgJ2b3aZD0RF1N
mwNMT8Z2Jb5xS9sU7MgizwYwoDes3kGOcUS4pe/RiGtXAdYLAjMNvmF99YUerCrA
MMYgltYEwmbHD8G+H4YIsBo5UxZJL2Quq9YcZ2u0CVewJZBDqc3EWuP4kjDCfqyU
tTkgkL4FlrKJ43IxJKNv05PoamaNCPknF7YyEJeSw6kIXzme80vuTrplN2ygGfRU
CTjof2cjRXZkQfzCy+iKha5gHVW6wbqk14t04pRLHeonTSZL03nZsrkWTDZkI+0o
aJAud8PE1e4Cmo4HTd68u+/8k8faTXJf74pQLAG7R/CS3F2LcVuo6veKPYEiSSmd
IvtPHAIv5d8KOUWPDY1SrDjvor4MKXQvWki4KhyQQmTtzviN66eBtMx/RldKPCVW
PftIFP5O/QMXyTpNrwujucC1HV8ux7lCfoXb+mygfP+Km/TqSYgCNnZnyc/f/wBB
DMujeX92S1cuGqacu3kvlUHkSug/yKaIS4k1Ye4IC/3UR+BJCF4Fr+ciSGefnAu3
nrBPcXXNdGPX61kfVXZ2rFdOnZ/n4DexqxN8TjbbwsZhCHFClJy7N/UKXNEs5Oqo
tnrr/OZfBTBQwj+8ypwKAD1f9V/T6gwvNLaA8Cktt3WDwY3uhFA=
=p2Z8
-----END PGP SIGNATURE-----

--mXDO3udm/xYWQeMQ--
