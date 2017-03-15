Received: from eggs.gnu.org ([2001:4830:134:3::10]:49853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1co1NZ-0006Oa-M6
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 01:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1co1NW-00048G-Hx
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 01:21:45 -0400
Date: Wed, 15 Mar 2017 15:53:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170315045344.GB12603@umbus.fritz.box>
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
	<1488970371-8865-2-git-send-email-clg@kaod.org>
	<20170314053856.GH12564@umbus.fritz.box>
	<3136fbfa-938a-679e-0bf6-c1dab315d425@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <3136fbfa-938a-679e-0bf6-c1dab315d425@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/8] ppc/xics: add a
 xics_get_cpu_index_by_pir() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2017 at 06:00:43PM +0100, C=E9dric Le Goater wrote:
> On 03/14/2017 06:38 AM, David Gibson wrote:
> > On Wed, Mar 08, 2017 at 11:52:44AM +0100, C=E9dric Le Goater wrote:
> >> This helper will be used to translate the server number of the XIVE
> >> (which is a PIR) into an ICPState index number (which is a cpu index).
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > This seems a slightly roundabout way of doing things.  Why not just
> > have the vcpu_by_pir() interface, then have the XICSFabric implementor
> > go directly from PIR to xics server state.
>=20
> So what you are saying is that we should try to move the "nature"
> of the 'server' parameter of the xics framework in the icp_get()=20
> handler of the XICSFabric. Correct ? Because at the end, it all=20
> boils down to use a 'server' to look for an ICPState.
>=20
> Each machine would do its conversion :=20
>=20
> 	xics_get_cpu_index_by_dt_id() for spapr
> 	xics_get_cpu_index_by_pir() for powernv

Yes, that's exactly right.  I think it makes sense for the XICSFabric
to be the thing that defines the mapping from XICS server numbers to
whatever other ID is relevant.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYyMjWAAoJEGw4ysog2bOSqEMP/0vnxrZ8gfJ5DIWG8XhzzTdi
LnI2ULGq5JNKjTLF7gmnRYHKK+K4ttiLouqiguCOmiScJ2QgdcyDgqWZiX3BIzzl
v20KezOhEMS8oYjzosMXhDjV4XDoueOCl8Z8oIs1JxmBtmUzs09aa5geKYHicRlR
/316mf2nq49M0HYVOJR2wfhEK50mzyMSNWL/cLRAOmbkY/Z64GR/bpCMSh2C658N
NCYpX7Syxe9HZWQU0xoddyS0J59V4Mv47U8yRjvRJ+Wt376GNsHv1+H6mpn3N86J
+FgRKAlkCWjLkIIdgNADqFar043qHQ+yDfjgoKCRplGnBfTyQMfbGC2sytsx72R7
ftkV+LU5/ogDzt4pwiKXgcVzJXO1qMB5Z4VEby2uuh04Q8RuI5K9UONXSAtB3je5
fHNrnRdi7Z6fksGQnaETdbyhDvpwv0okQbU8qnyetS1IcKxNUKE7kg9N8yI8wTVO
d89IdsvG50O7mWM921XQNMacrO2eK/rPqo2HLXYxvn1fCeQl9McGMrslUXOM76p4
UjXSezmhBPWctzc0IGewduTcov7zqfaXaXdblyvmyfAi8F7qt47H2EAuY7weODMk
HtFT84WCpUAV4SYUQdLvUk18ZZLQTh4XjyfYvMbrj9uwU5Edq3b7TyP31sRyVeyS
VbbtmhTiIZPOTOgDR9e9
=AGjm
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
