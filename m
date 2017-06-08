Received: from eggs.gnu.org ([2001:4830:134:3::10]:58952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIp4t-0001Yt-LU
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIp4s-0002ug-SD
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:29:47 -0400
Date: Thu, 8 Jun 2017 14:17:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608041739.GY13397@umbus.fritz.box>
References: <20170602031507.29881-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f/XZMZU9ST6S8MjH"
Content-Disposition: inline
In-Reply-To: <20170602031507.29881-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCHv5 0/4] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, clg@kaod.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Cc: abologna@redhat.com, sbobroff@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--f/XZMZU9ST6S8MjH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2017 at 01:15:03PM +1000, David Gibson wrote:
> This is a rebased and revised version of my patches revising CPU
> compatiblity mode handling on ppc, last posted in November.  Since
> then, many of the patches have already been merged (some for 2.9, some
> since).  This is what's left.
>=20
>  * There was conceptual confusion about what a compatibility mode
>    means, and how it interacts with the machine type.  This cleans
>    that up, clarifying that a compatibility mode (as an externally set
>    option) only makes sense on machine types that don't permit the
>    guest hypervisor privilege (i.e. 'pseries')
>=20
>  * It was previously the user's (or management layer's) responsibility
>    to determine compatibility of CPUs on either end for migration.
>    This uses the compatibility modes to check that properly during an
>    incoming migration.

Anyone willing to give some review and/or testing, particularly for
patch 2/4.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f/XZMZU9ST6S8MjH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJZOM/jAAoJEGw4ysog2bOSXrAP+Kt4rk4NsSMyZgQmEMbfrc2n
Bt52dofiZGWkZYY+h8aet1u6AP204b8a/DCh0t5NfA2ceu7SBx0vc1WM/oxpoZ5B
4nHcb9oOmSDPCcCXAWF1/1kOLuco6vYaZyhrG5TNv5g/pEDxss41tmDTc92cM24y
y+3ptIKwjfRkJwZ3uTlayXDMIRzvzK1tWdKlsKC4zNDWa7cZQWCVHlFUzMJqqqG8
ebapcro8+l+TNio6CQC622TltkChFFTjSt90EoHWmrm0CJmXrOazmebsyvZxN901
wZCusJ4sB1j3dsInTqLQzxaeidhXhAYyjOjQlw4ZBbSBB23SAz6HczECid/rXn9s
HNaTA2BPkVMcnKYK7Go6hWFxQUtWkUmdPxYxWRZtJbtDNQldXF2rN/DYOJIn5NDR
VtdT+CPv4uadiDHPQmkPTGDt/E0QxsDo5e5IK4O1k8Y425+uJgmUKiTDE6QZIb5P
676gmcllfP0DWpzZCvloTnb8ShHcaqoKkKCA8OGWq3bOoWy8d6DGPU6yYeRMiKDV
SOI/ramXAsMLOsO4w1WcvBTHIzPrf5i1wAYFM2k+mp4uuXbskjoGGJJZT1nPfb9B
E8Sj31hILLkECZZloBs0xEJuQksn9nSIw4LqKcSfhFopKm53N8JRBGytAO2Foylt
3yO8hnmak8Fpn2Nqht8=
=fd7A
-----END PGP SIGNATURE-----

--f/XZMZU9ST6S8MjH--
