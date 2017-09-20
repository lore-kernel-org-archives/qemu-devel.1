Received: from eggs.gnu.org ([2001:4830:134:3::10]:36190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duX1E-0007wM-IR
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duX1B-0001JT-Ao
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:53:52 -0400
Date: Wed, 20 Sep 2017 14:33:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170920043308.GE5520@umbus.fritz.box>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-4-clg@kaod.org>
	<20170919023943.GI27153@umbus>
	<09082408-6f2f-4bd8-d6c6-69734fe7de44@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline
In-Reply-To: <09082408-6f2f-4bd8-d6c6-69734fe7de44@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 03/21] ppc/xive: define the XIVE
 internal tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2017 at 03:46:20PM +0200, C=E9dric Le Goater wrote:
> On 09/19/2017 04:39 AM, David Gibson wrote:
> > On Mon, Sep 11, 2017 at 07:12:17PM +0200, C=E9dric Le Goater wrote:
> >> The XIVE interrupt controller of the POWER9 uses a set of tables to
> >> redirect exception from event sources to CPU threads. Among which we
> >> choose to model :
> >>
> >>  - the State Bit Entries (SBE), also known as Event State Buffer
> >>    (ESB). This is a two bit state machine for each event source which
> >>    is used to trigger events. The bits are named "P" (pending) and "Q"
> >>    (queued) and can be controlled by MMIO.
> >>
> >>  - the Interrupt Virtualization Entry (IVE) table, also known as Event
> >>    Assignment Structure (EAS). This table is indexed by the IRQ number
> >>    and is looked up to find the Event Queue associated with a
> >>    triggered event.
> >=20
> > Both the above are one entry per irq source, yes?  What's the
> > rationale for having them as parallel tables, rather than bits in a
> > single per-source structure?
>=20
> For the sPAPR machines, yes, we could use a struct to hold both=20
> information. But these tables are defined in the HW specs and=20
> are used as such by the PowerNV platform in skiboot. They are=20
> registered by the firmware for the use of the XIVE interrupt=20
> controller.  =20
>=20
> When we model XIVE for PowerNV, it would be preferable to have=20
> common definitions for these tables I think.

Ok, that seems like a reasonable case.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnB74QACgkQbDjKyiDZ
s5KQKQ/+O48QkF7iuSi9czhjD8wLiiPtXByGYkjc3H5hE3GWTKew0M+bFMe3IpOx
Egg3mQm9Vcj7kidH+ygnFH4sBg18Gyb1Hz0pS0bVirOPV3AFpbAYqduiE2tqzPMP
QVNrq1LEhG/yA+9+HwjeTG05+ZYuWyhDejFVwooPiTwefJtCxhd3dp9uWCT+G36F
KthzBMrjAkDcuTMoES78naa2RTVxzAbCjfjYtOZIav7turAicGuckrN1L0CnbCPj
e0bBZyozhSn4SuXY40p3gqXT5hAQC6/rOi8Ue+4B4QYWOsATRGh6PdElKcTizcub
XUR97EXIzM9x5My+O3RA/sivfWKeNZz6yHHyuA0aK2gjL4WKjRuIln15wT/aoP85
Ee++aEBuTc5nNnDyg6giwUQtb2FdfiYEow3XcP0seylhj2cT7GRR8NYhzPmSGgUC
dfRanVQYWSHTsYvdTuzn+OpZwCLJrev9gUK7FLl4Xoc5rA/Y5rw5+FqAXdzA4f8g
jmCb71nBRk5BW+Hw5Iksfrb0sIpy/CETXqOSxoL423kQhz7ZAbPhDcTp+FydMxJD
QOW06/+O2j6rVjpRSLr/e284yAoyPL/JC5ek9rmnPGu6jPUR8YGHEZKE+xM+a7Vu
hHQv8A/xxFGigrg4FPiNvgqYUMsZGTVBlvnJuaFD5m5paTct9+U=
=z3lp
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--
