Received: from eggs.gnu.org ([2001:4830:134:3::10]:50695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKH1A-0005PH-5s
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKH16-0005ab-Vw
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:04:12 -0500
Date: Thu, 30 Nov 2017 15:26:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171130042624.GZ3023@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-11-clg@kaod.org>
	<20171128063827.GP11775@umbus.fritz.box>
	<e9b1f002-671b-7ba5-2b5b-34715d63585c@kaod.org>
	<20171129045941.GH3023@umbus.fritz.box>
	<512a0e63-43c1-bf8c-3060-66ab52bc054f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AAiVQQES42Kk67ff"
Content-Disposition: inline
In-Reply-To: <512a0e63-43c1-bf8c-3060-66ab52bc054f@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 10/25] spapr: add MMIO handlers for the
 XIVE interrupt sources
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


--AAiVQQES42Kk67ff
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 02:56:39PM +0100, C=E9dric Le Goater wrote:
> >>>> +    switch (offset) {
> >>>> +    case 0:
> >>>> +        spapr_xive_source_eoi(xive, lisn);
> >>>
> >>> Hrm.  I don't love that you're dealing with clearing that LSI bit
> >>> here, but setting it at a different level.
> >>>
> >>> The state machines are doing my head in a bit, is there any way
> >>> you could derive the STATUS_SENT bit from the PQ bits?
> >>
> >> Yes. I should.=20
> >>
> >> I am also lacking a guest driver to exercise these LSIs so I didn't
> >> pay a lot of attention to level interrupts. Any idea ?
> >=20
> > How about an old-school emulated PCI device?  Maybe rtl8139?
>=20
> Perfect. The current model is working but I will see how I can=20
> improve it to use the PQ bits instead.
>=20
> I also found a couple of issues on the way.=20
>=20
> We do need the "#interrupt-cells" and "interrupt-controller"=20
> properties. They are missing from the XIVE sPAPR specs but there
> is no other way to find the parent controller for the LSIs ...=20
> I have re-asked the pHyp team to include them in the specs and=20
> fixed the QEMU model.

Told ya so :).

> Linux thinks the interrupt type is an "edge" and not a "level" one :

Right "edge" and message interrupts work basically the same way.

>   (initramfs) cat /proc/interrupts=20
>              CPU0      =20
>    16:          0  XIVE-IPI    0 Edge      IPI
>    17:         14  XIVE-IRQ 4100 Edge      enp0s0
>    18:          0  XIVE-IRQ 4097 Edge      RAS_HOTPLUG
>    19:          0  XIVE-IRQ 4096 Edge      RAS_EPOW
>    20:         20  XIVE-IRQ 4098 Edge      hvc_console
>=20
> and XIVE complains :
>=20
>   [    8.319970] xive: Interrupt 17 (HW 0x1004) type mismatch, Linux says=
 Edge, FW says Level
>=20
> I am digging this one.
>=20
> Thanks.
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AAiVQQES42Kk67ff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlofiHAACgkQbDjKyiDZ
s5ItQQ//ULFw43JHCS3vAp1k2uy5uLqQ1rcZ0tJzao7hwQBElqHciHwGJBsXqmFy
cwJKLOln2pj5valr9KgD1vcJKCiJ+itQbC/UwuUsy3K1vHL2uWgEBqkYIvHWM7LM
1OWtwnbpIfzbD4Q8FMMMahyNT5lAKc2M7b05HINXKwLdwy59lbyc8eyagBcU6gFQ
9vUfoI7e9THlxcOCHW/TVOOboIEZ1wiLg8WVLff5ixOPmD4C6fXaJnJf5irDJYeM
xjupc1vuNolwXQsfxHg0s0ojrUjZ3eAlHHvahkqnCmKAk9in24bhYKcGw8IwcJbc
5DzpQ4p9rrhINZzlv9xHSq1K3JVJ5o/k/odtEMWFVCRftX3wniLQAGENnOS93d5G
d2uUlKit8JWYfjdw31/6BnN288RwukbQzpMu21hoGCKu7CgNbyD+ukgUicih5xNU
2ZdlXz6NuBVcmlqsWYkXF4rbbq7xNcbxCB6Xxku3kUiVry9jq1nBrI8ob+Bgdf0y
UjWHUkpQpqsa5VSa+BIBbFKxex+6uUqiZOwgxmXTBvAHBSRBA1GUD0ADZOLj1pCw
1DSkeEINBiWf5/Npj4kPSWkQgKxQSzMSBzsC1UaFW3RoNa3FbSgCkmhAdbaPbhI5
+8y1+Yjh4HPAEcR2ZKG8bxn0lAy3K7K1P56KyJpoAudAOhMVc6U=
=6E//
-----END PGP SIGNATURE-----

--AAiVQQES42Kk67ff--
