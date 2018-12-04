Received: from eggs.gnu.org ([2001:4830:134:3::10]:37369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTzzm-0004yN-5A
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 20:59:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTzzk-00057p-Rf
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 20:59:29 -0500
Date: Tue, 4 Dec 2018 12:59:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181204015905.GH1682@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-28-clg@kaod.org>
	<20181129040917.GF14697@umbus.fritz.box>
	<8416d567-6e9e-6124-7b7c-a620429af8b5@kaod.org>
	<faca523e-aa5a-788e-bd99-66d890e047bc@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <faca523e-aa5a-788e-bd99-66d890e047bc@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 27/36] sysbus: add a sysbus_mmio_unmap()
 helper
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


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 04:52:46PM +0100, C=E9dric Le Goater wrote:
> On 11/29/18 5:36 PM, C=E9dric Le Goater wrote:
> > On 11/29/18 5:09 AM, David Gibson wrote:
> >> On Fri, Nov 16, 2018 at 11:57:20AM +0100, C=E9dric Le Goater wrote:
> >>> This will be used to remove the MMIO regions of the POWER9 XIVE
> >>> interrupt controller when the sPAPR machine is reseted.
> >>>
> >>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>
> >> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>
> >> Since the code looks sane.
> >>
> >> Hoever, I think using memory_region_set_enabled() would be a better
> >> idea for our purposes than actually adding/deleting the subregion.
> >=20
> > Yes and we might not need this one anymore.=20
>=20
> As we are destroying the KVM device, we also need to remove the mmap=20
> in QEMU, else we will have a VMA with a page fault handler pointing
> on a bogus KVM device.  which means destroying the memory region, so
> we can not use  memory_region_set_enabled().=20
>=20
> Anyhow mapping/unmapping works well.

Ah, ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwF32kACgkQbDjKyiDZ
s5IXkg//cXMwqgLGhs2iHeeU4A+7w0/HKnJLtsl8xEIcKnTWf9gkueh1hGDUY3bt
8TBG7r9ofXVr0NEJH0JY/T79q7zwH4aeFMA0oIKmKL6/6sWXSr64XaocQSyPHcYz
HbCuTs74kE4kq0ncJXalSaARJqidjZn8Mg49AG6I6xkx10H25c4YH9XZKH0W3ELM
2Y7F/mFg4rH+eyPsyXKknfpKC6yGOVX1rJQOTlPe/CM7dp0e4x7Q5khexxY4bSOa
ytRJuuhhMaNfPXghHTHf6M4FscpSIpeawWAYbTzCGiwNkU04Zk66KUpGd84oBKF8
kGHYHkAuDw3hGhn3vuGMx92KxYR+9cO696RJqgzIlTZ+oYRytx5fVgJCe7x4/XN1
tEbr2uXMSNfrqS9foS05G1zBoNrQrTJy9wY6GjFsTx0MUdaJydJV6s4dh1F8V5dw
oDPMX1/Jvv5RlTBQDFpvRpfEYsPCSAVcwmQO/BBjK583387Wu5YwEkftI+dihpMx
jlcv6+aQgPT2pHq1zETpqGv/VQmClkhhL6apu9t5yFTd6BGAvFL6qD3dy/8jMsjT
NWXtgPaL43OGZwVXZdIyQ01mfLgVYeJCNm220hLsIKZnXx6EWq7pIpQD3EFN/bSW
8UzrL8eQW6v2AEiJ+wssoDSS3Olq4i4TWSeKAz8S3kImNLZ74lg=
=OEyP
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
