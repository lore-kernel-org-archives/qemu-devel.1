Received: from eggs.gnu.org ([2001:4830:134:3::10]:43095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWWzG-0001kY-RI
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:37:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWWzC-0007R5-9H
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:37:26 -0500
Date: Tue, 11 Dec 2018 12:37:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181211013710.GC4261@umbus.fritz.box>
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-4-clg@kaod.org>
	<20181210042747.GM4261@umbus.fritz.box>
	<157aa1c9-20a6-e177-eac7-f47f40188df3@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SVeEiVwWO9F1slJ8"
Content-Disposition: inline
In-Reply-To: <157aa1c9-20a6-e177-eac7-f47f40188df3@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v7 03/19] ppc/xive: introduce a simplified
 XIVE presenter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--SVeEiVwWO9F1slJ8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 08:15:40AM +0100, C=E9dric Le Goater wrote:
> On 12/10/18 5:27 AM, David Gibson wrote:
> > On Sun, Dec 09, 2018 at 08:45:54PM +0100, C=E9dric Le Goater wrote:
> >> The last sub-engine of the XIVE architecture is the Interrupt
> >> Virtualization Presentation Engine (IVPE). On HW, the IVRE and the
> >> IVPE share elements, the Power Bus interface (CQ), the routing table
> >> descriptors, and they can be combined in the same HW logic. We do the
> >> same in QEMU and combine both engines in the XiveRouter for
> >> simplicity.
> >>
> >> When the IVRE has completed its job of matching an event source with a
> >> Notification Virtual Target (NVT) to notify, it forwards the event
> >> notification to the IVPE sub-engine. The IVPE scans the thread
> >> interrupt contexts of the Notification Virtual Targets (NVT)
> >> dispatched on the HW processor threads and if a match is found, it
> >> signals the thread. If not, the IVPE escalates the notification to
> >> some other targets and records the notification in a backlog queue.
> >>
> >> The IVPE maintains the thread interrupt context state for each of its
> >> NVTs not dispatched on HW processor threads in the Notification
> >> Virtual Target table (NVTT).
> >>
> >> The model currently only supports single NVT notifications.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Applied.
> >=20
> > I think the tctx_word2() should have the byteswap, rather than having
> > it in the callers, but that can be fixed later.
>=20
> I thought it was better to explicitly show in the code where the=20
> byteswaps were needed. Anyway, this is very localized, so, yes,=20
> we can change it later on.

To clarify my thinking here; the important thing is not knowing where
the byteswaps are, but being able to tell as easily as possible what
endianness a given piece of data is right now.

The convention I'm aiming for here - which is one I try to use most
places is that structures - at least structures which map to specific
in-memory things - are in the required endianness for that stuff in
memory.  However bare integers - uint32_t or uint64_t or whatever -
are, well, numbers, in native endian.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SVeEiVwWO9F1slJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwPFMMACgkQbDjKyiDZ
s5JcnA/+JJdb6Y0InXiG2bk6aoW3lKoGS1O7zusSoBzAc0iRtG9uVSKO8WORgvvU
xyQl9Fd1zzvwPld0L78QIPgEB1PnCxoMZsaiBPKuc3ZLi9ZeUNiMBazQm95+VLei
hv/8YwfS2Ol30bl3DgavZGpU4OUsAn/47ednSrZs6tjICW7q23wvZgB6qPetM54a
O9WBij1sPOkZIZl20J770ZDNrMf8SVawMM4BX6Qvd1lUP8am6ciotHfsEm8rZG+M
AWDnJr7v7EcYNTVX8odVekPBk/LUsDpSRR4ugpj9y9CtnarP6VlqJ03z/P9FJZlu
KgA3Yj5fEIHnLVCqGlQUxwBBDUTOZQGMi8+lBPabb2klf+c7bF5kkoSKCNrcBMtx
SBgbVZxP84wN2xxUqf/sMS9wFAP7fYs5OxJ+VjFXEplkMt4WZ3jim83yNy3q79xK
Ahry8LzsjSc5tALSVUKEKuNmT7SQSAlljX/q1l20g7KdAen5tgjV/RIsuaYLdypQ
ChMU/mGug1xWjlZEhAJx3CCKiywWvNuUtvwgJVBhyh/XLanHSfhwseDpxP4pn4nn
VFYhu76hrFM6/YgXxlx/WVDhI6WUzx/8ewwmyhmjgOy2un69H/Y576gsOdaUpADw
9P/y12fWm4csisJmnYcf5EzSrgbNCYs1MLDgW9NLq16U5CXFYF4=
=8vEd
-----END PGP SIGNATURE-----

--SVeEiVwWO9F1slJ8--
