Received: from eggs.gnu.org ([2001:4830:134:3::10]:51424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZsd5-0007ZT-4o
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZsd2-00059F-3K
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:43:35 -0400
Date: Tue, 25 Jul 2017 14:19:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170725041923.GB8978@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-9-git-send-email-clg@kaod.org>
	<20170724043624.GE17228@umbus.fritz.box>
	<1500879657.10674.64.camel@kernel.crashing.org>
	<20170724095052.GO17228@umbus.fritz.box>
	<1500894439.10674.76.camel@kernel.crashing.org>
	<c94d515a-0d8b-921e-1ccb-bd92284c3967@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <c94d515a-0d8b-921e-1ccb-bd92284c3967@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 08/26] ppc/xive: add flags to the XIVE
 interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 01:47:28PM +0200, C=E9dric Le Goater wrote:
> On 07/24/2017 01:07 PM, Benjamin Herrenschmidt wrote:
> > On Mon, 2017-07-24 at 19:50 +1000, David Gibson wrote:
> >> On Mon, Jul 24, 2017 at 05:00:57PM +1000, Benjamin Herrenschmidt wrote:
> >>> On Mon, 2017-07-24 at 14:36 +1000, David Gibson wrote:
> >>>> On Wed, Jul 05, 2017 at 07:13:21PM +0200, C=E9dric Le Goater wrote:
> >>>>> These flags define some characteristics of the source :
> >>>>>
> >>>>>  - XIVE_SRC_H_INT_ESB  the Event State Buffer are controlled with a
> >>>>>                        specific hcall H_INT_ESB
> >>>>
> >>>> What's the other option?
> >>>
> >>> Direct MMIO access. Normally all interrupts use normal MMIOs,
> >>> each interrupts has an associated MMIO page with special MMIOs
> >>> to control the source state (PQ bits). This is something I added
> >>> to the PAPR spec (and the OPAL <-> Linux interface) to allow firmware
> >>> to work around broken HW (which happens on some P9 versions).
> >>
> >> Ok.. and that's something that can be decided at runtime?
> >=20
> > Well, at this point I think nothing will set that flag.... It's there
> > for workaround around HW bugs on some chips. At least in full emu it
> > shouldn't happen unless we try to emulate those bugs. Hopefully direct
> > MMIO will just work.
>=20
> Nevertheless I have added support for the hcall in Linux and QEMU.
> To use, I think we could create a specific source.

So, IIUC, it's host constraints that would make this one way or the
other.  So what happens when a guest migrates from a host which has it
one way to one which has it the other way?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll2xssACgkQbDjKyiDZ
s5KTeA//YolXxPlIW1eLjD+tSZRs8e4XeLMfnJxQv2ZTcqVUFd5ixVKCBtWj5Qj/
Xm26kreYOGGYSbM++ywmSDj00g+teKUsKJhR6IKgV87Hix6pE8Z9HmMHsPWc6gsh
KPdlN7BjCkYDILdolsMCO5hXLpvwC/lOzYi/xH7L5FqmgqgTebTuXFazEHUkxVMY
8oNWhqnEGx8zJCI3Ua5itrA1Ar5Bs1aVuvyNfO0brwk19txAEmScNRV7lHfZvMhk
IjbdYiKm+swGRf0Y3k3Wdp3RBlV+sREpUgBTtXmrKvqdysBRx9jktGMgk/N1PFKl
bH4dfH2WdySp13xPF6bN1KeGES9MpK9mbDrMBroTvRtdceQTZS43SmPf7TiMej1V
YauSf8m/846aqTPLn4YUT318fXb6bWPeG2H1E9UU8xpgzrpDBZ+YiwzeqhQQL1xf
mFpxu7eDzpffm/M6A5914sKbmhG1Zsmoh9ZvwCaeZNrp/YFw+EQpbZHEQNlB1wUv
tylBwi7O5XIkX1SMbb6LxDCHUVOP8/aD2vxNmNhdwPGdWROk0mlsksBeJYC3fnEg
PNQ194/AVvArLj9W8wtD0Fw4moGcEJ1a0s3qJToCmTjnIev4uXeuNKoGWfX0TuMf
jRytvKDqC7uz5UOXlJvxiopUYRsKwIXFwC46oG9dEu0LQBlr/Zw=
=YOux
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
