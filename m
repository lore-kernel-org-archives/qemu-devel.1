Received: from eggs.gnu.org ([2001:4830:134:3::10]:53713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJ9mW-0007bT-2s
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJ9mS-00012m-V2
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:36:12 -0400
Date: Fri, 9 Jun 2017 12:24:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170609022452.GE26521@umbus.fritz.box>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685582923.12025.13700165807436904935.stgit@bahia.lan>
	<20170608020112.GT13397@umbus.fritz.box>
	<20170608104530.65b7d53e@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
Content-Disposition: inline
In-Reply-To: <20170608104530.65b7d53e@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] xics: setup cpu at realize time
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


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 10:45:30AM +0200, Greg Kurz wrote:
> On Thu, 8 Jun 2017 12:01:12 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Jun 07, 2017 at 07:17:09PM +0200, Greg Kurz wrote:
> > > Until recently, spapr used to allocate ICPState objects for the lifet=
ime
> > > of the machine. They would only be associated to vCPUs in xics_cpu_se=
tup()
> > > when plugging a CPU core.
> > >=20
> > > Now that ICPState objects have the same lifecycle as vCPUs, it is
> > > possible to associate them during realization.
> > >=20
> > > This patch hence open-codes xics_cpu_setup() in icp_realize(). The vC=
PU
> > > is passed as a property. Note that vCPU now needs to be realized first
> > > for the IRQs to be allocated. It also needs to resetted before ICPSta=
te
> > > realization in order to synchronize with KVM. =20
> >=20
> > Ok, what enforces those ordering constraints?
> >=20
>=20
> I'm not sure about what you're asking... I had to re-order because
> xics_cpu_setup() used to be called after the vCPU is realized and
> put in PAPR mode.

Duh, sorry, I wasn't thinking to ask about realize order, since that's
manual and you've re-ordered it to be correct.

You also mention that reset order matters, and I'm less clear on what
guarantees that the reset handlers for the components get called in
the right order.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOgbyAAoJEGw4ysog2bOS8PYP/10WSVLPWe0CABYj1V2AcC+B
bMm7Hzu/MciCKF0hFlSUURYN75ZyldkON48YzFJis/EpgQ3uv+YYBzEUa9/qQhi/
HS0F0IJvDS5wZ8Tim/3qFOqSGSOV/ywfQGytYut0qqDRT8MRZTKLduZHcuB8jnWU
rAjq9otMu2GEtSe4BTdWeBP3c78bPyE8+GusiSEU08w46mbLjDLgEGyDmEyVPm13
vCU1kTCzN98n6XI63ddwDT1R1ReNsGVk5kBIbHaHWsxn/uRtJ/OG+s8tpiIZ2yOm
bLv8U13q8n8vqOmi3d+bJh59AVjmmSY0sKMPBoqGf4QJS+fl3Pmfjj2RD/aZPmJZ
/3KQKufOvMTTQV+v9XrcO/R9BXi2f+3LuD4WCyBcHMc6jRTgC1R5DkD3HNSj+9kv
y9v4yUHLRUIi45GSjV6tWxAds2UKpsXHKR2BN0uq8kVaE3N3PWlsGrn2kpGEylhi
EzLV0lACuno7IpgUU2rIG7GYtT+TtZJdrICBK2x1+2EeFT3ZLNyTuOijbzFcAliW
+5Z1pXLFTZS3YDNGcY727zoo7meW8G60mT+VnTnDZXgiNdSsRdFXms7vMjqelk93
vl5eJplKxH5MoIQMlSGvWv69IK5cKKKPS0q5KgAqR3NuKJXbCbkHe5kGMiv760Yl
ZRTaeboz4PNaY/PF2HNe
=M/YN
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--
