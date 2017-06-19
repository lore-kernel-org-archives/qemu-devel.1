Received: from eggs.gnu.org ([2001:4830:134:3::10]:44000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dN7Vw-0006ch-IF
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dN7Vt-0005L4-HH
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:59:28 -0400
Date: Tue, 20 Jun 2017 03:51:52 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170619195152.GJ22449@umbus>
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z8yxTSU1mh2gsre7"
Content-Disposition: inline
In-Reply-To: <20170608050930.2613-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH 0/6] spapr: DRC cleanups (part IV)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Z8yxTSU1mh2gsre7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 03:09:24PM +1000, David Gibson wrote:
> This fourth isntallment of cleanups to the DRC code introduces the
> first changes to the fundamental state handling.  We change the
> initial states in the reset code and attach code for PCI devices, and
> are able to remove the 'signalled' state variable with those fixes.
>=20
> There are also some more mechanical cleanups in preparation for
> further cleanups and fixes to the state management.

Merged to ppc-for-2.10.

>=20
> David Gibson (6):
>   spapr: Start hotplugged PCI devices in ISOLATED state
>   spapr: Eliminate DRC 'signalled' state variable
>   spapr: Split DRC release from DRC detach
>   spapr: Make DRC reset force DRC into known state
>   spapr: Clean up DRC set_allocation_state path
>   spapr: Clean up DRC set_isolation_state() path
>=20
>  hw/ppc/spapr.c             |  15 --
>  hw/ppc/spapr_drc.c         | 363 +++++++++++++++++++++++----------------=
------
>  hw/ppc/spapr_events.c      |  10 --
>  include/hw/ppc/spapr_drc.h |  10 +-
>  4 files changed, 188 insertions(+), 210 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Z8yxTSU1mh2gsre7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZSCtVAAoJEGw4ysog2bOSxZEP/09gU4WCZflEBfu+FQ4K85XW
e9J/1GxiURINY97C34ur0TZCyMrRHF/vM/Q1u6HjH8hyoMdWBTc83QzkKXF9ucdI
RiApQWMz/L1HK6wjVtQ8IL5UNEo/xTGjWPuygPPKLa4eRSQy6GaytBfhBmlEkrsz
STjVazn/J9yaP5sHRncXAKdNkEnVCEvPN+aeSrAuBdaemhmCHE3XCPWeudsRYHlm
dcQczrX7Ggnly+v/MtSZOkX+/PzehmoFd0cdvIvkYWPrMxUSNPoTYAD0cZcxGANW
x9hQTBnZY8X7Dn62+ClAp489RR+M1O0dfyDGLnXISHqVrANQih2y4wkT6HUwcMsi
JLewbnJt//03L6GjiAv8AGwjtOKRAgGaz1BVgg/rKE5GwA5kYReRZ5dMKeDyWqQB
Kp8aIkQa6Y1anymYze5zrAikishfj3B5ic4IkjZe4r9oDrMlPAjqVAmmHkVlbZuO
8aaC+7AJyvQLX/L0rrPwcUYUgSEycVd+6Nxg5pxrxwlGm/8dzkPgjDRmc3nOLHSj
Z2Gs48HkgEhIPkkyPcOBG6ckh3dQc6qFCrBC8O1kr6SsgSqVS71JEAwm+XkVBHD/
eCM3V/IYiMQi9lYy5WxDk7FEGG1KPDTX/RkpEpOn2hUkgumnWZQQx6OvtEIvCggU
cL8SmZ1tP9sd6vyxTW8Z
=nAgq
-----END PGP SIGNATURE-----

--Z8yxTSU1mh2gsre7--
