Received: from eggs.gnu.org ([2001:4830:134:3::10]:35243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cwiqB-0001P3-7m
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 01:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cwiq8-0004Vb-0V
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 01:23:15 -0400
Date: Sat, 8 Apr 2017 12:14:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170408021420.GE27571@umbus>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-5-git-send-email-clg@kaod.org>
	<20170406042318.GA12179@umbus>
	<6e24736f-5a64-ea4a-f9bb-6ebed5acca4a@kaod.org>
	<1491470207.4166.107.camel@kernel.crashing.org>
	<9a5826c0-5940-f668-fbef-f90f277408e0@kaod.org>
	<1491480116.4166.108.camel@kernel.crashing.org>
	<78f1dc04-9c48-1870-9fdc-ff872fecd0de@kaod.org>
	<1491515614.4166.126.camel@kernel.crashing.org>
	<7dce9c3b-1cb2-3cec-5f55-51849ca313d0@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline
In-Reply-To: <7dce9c3b-1cb2-3cec-5f55-51849ca313d0@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 04/21] ppc/pnv: enable only one LPC bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 08:14:36AM +0200, C=E9dric Le Goater wrote:
> On 04/06/2017 11:53 PM, Benjamin Herrenschmidt wrote:
> > On Thu, 2017-04-06 at 14:35 +0200, C=E9dric Le Goater wrote:
> >> but real HW (2 sockets OpenPOWER systems, garrison and firestone)
> >> does=20
> >> not expose the LPC bus on the second chip, should we do so in qemu ?
> >=20
> > It's not so much HW as it it HostBoot. Not a huge deal.
>=20
> So let's have QEMU populate the second LPC bus without the "primary"
> prop then. It's a different approach than hostboot, but it's good for
> testing anyhow.

Works for me.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY6Ed5AAoJEGw4ysog2bOS7K4QAMmDLFoxAsiklQwPghHU8lt7
g5rH7jVXBcS0qyBx6h2BZ28lsv/yazVZBC3cDMg0LUoxsGkPOJXyWX1GNVlvH+hT
urvk6k+6/r0WRn49de1CILeh/sdf1XcLRQyaD6mHsb8UNNvH6juwJWA4Ne4tYwmH
TQQ48rXb2Qq6jAn7ApnFXBjqD5tU8OYUYTqk3dHkm/tpSJs2dh/0KgE9ppDoUmtk
X4JYs3VaXxosIPlA5wCnJQZXR84Fh0sBVCY+EciozV3xkJjAEKSnJd6TRoycHYmi
16b9QYhLtfTL+d4RqMs3TEt0uwqsHFjVF/PJQ8EvI7ijKSEnvriIhkkV8ohIkecH
aN8pzNRmXX9XRLKoKtoCYXjX4VqMQWiLZAtNHJAwfMllsJUiyIsh2Wbre3tKAuXA
15DvZ6ZyoedB8SS4iBIHogOR+j0I6UnMnn2zNxwSO2Z0M/JaxsJ6agujq5G2S3v8
aqUR5rvgaw5Dzf9W998tBL4ZlUb0npGvWSQBhalWZbsmJBuJBcVMFMHAowvYbiaD
0XY7r6k/v4Rs/UfikGlaBx4lv1hsBf6vzZMb9g+dOjfpA0XWlIDL36w+knBvKl7b
/qn5tKMlSfxAD2VRFnmI6bRByp3UHT7oDX71F7N0gjY0t11j9Tct6gMJkO8fEcOb
/XIner54C2es0A6+60FW
=HySJ
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
