Received: from eggs.gnu.org ([2001:4830:134:3::10]:57645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch8Cn-0006Hl-Do
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch8Cm-0004kP-6u
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:14:09 -0500
Date: Fri, 24 Feb 2017 16:02:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170224050242.GA17615@umbus.fritz.box>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Gv4AD2GulCTyUAWX"
Content-Disposition: inline
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/15] POWER9 TCG enablements - part15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--Gv4AD2GulCTyUAWX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 01:26:25AM +0530, Nikunj A Dadhania wrote:
> Patches:
> 01-06  Cleans up the XER split out variables and now the=20
>        flag bits are stored in XER at their respective places=20
>=20
> 07-14  Contains implentation of CA32 and OV32 bits added to the=20
>        ISA 3.0. Various fixed-point arithmetic instructions are=20
>        updated to take care of the newer flags.
> =20
> 15     Finally the last patch adds new instruction mcrxrx, that helps
>        reading the carry (CA and CA32) and the overflow (OV and OV32) fla=
gs

I've applied 1/15, I've rest the left pending correction of 2/15 and
discussions on the rest.

>=20
>=20
> Booted the POWER8 guest fine, needs more testing as changes are=20
> intrusive in nature.
>=20
> Changelog:
> v3:
> * Get rid of cpu_ca, cpu_ov, cpu_so split out variables
> * As most of the patches under went changes, dropped the=20
>   reviewed-bys(except neg[.] patch)
>=20
> v2:=20
> * Add missing condition in narrow mode(add/subf), multiply and divide
> * Drop nego patch, subf implementation is sufficient for setting OV and O=
V32
> * Retaining neg[.], as the code is simplified.
> * Fix OV resetting in compute_ov()
>=20
> v1:=20
> * Use these ISA 3.0 flag to enable CA32 and OV32
> * Re-write ca32 compute routine
> * Add setting of flags for "neg." and "nego."
>=20
> Nikunj A Dadhania (15):
>   target/ppc: introduce helper_update_ov_legacy
>   target/ppc: update ov flag from remaining paths
>   target/ppc: introduce helper_update_ca_legacy
>   target/ppc: add gen_op_update_ca_legacy() helper
>   target/ppc: add gen_op_update_ov_legacy() helper
>   target/ppc: remove xer split-out flags(so, ov, ca)
>   target/ppc: support for 32-bit carry and overflow
>   target/ppc: update ca32 in arithmetic add
>   target/ppc: update ca32 in arithmetic substract
>   target/ppc: add gen_op_update_ov_isa300()
>   target/ppc: update OV/OV32 for mull[d,w] insns
>   target/ppc: update OV/OV32 for divide operations
>   target/ppc: update OV/OV32 flags for add/sub
>   target/ppc: use tcg ops for neg instruction
>   target/ppc: add mcrxrx instruction
>=20
>  target/ppc/cpu.c        |   8 +-
>  target/ppc/cpu.h        |  33 ++--
>  target/ppc/int_helper.c |  90 ++++++-----
>  target/ppc/translate.c  | 396 +++++++++++++++++++++++++++++++++++-------=
------
>  4 files changed, 371 insertions(+), 156 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Gv4AD2GulCTyUAWX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr75yAAoJEGw4ysog2bOSOXsQAMvLR9KgDLrMxRMY5mdZ7H+b
94qK0zxSiOG3yJN464MjOSvyqhbWPnXx3xJ/Rw2nXI71wi72TnFlDS40rqTSP6HP
9krvellc9lEbU7NUMBsGv3Pz7iPyHD/UubARkM/k4y+RNMDxSmBDWOPVRIyD/xT0
ZnAcdXZJXEeNRWL2DFPUfZ2a6l+Uyea8bJJHoWPoIOejEeK7GYCjEVhJEVq8DOhG
GZ9K1Lu4tJUYg2kpFroc2jtTEkG9BeYwbDwJNKWmUndjW+QnduF92OAcC8v3iUES
vYYw56mK430ZFbv+xmrOoveIyAg2Xfu877cvirhJjOO67P6QnhU/6hpozJANamuG
RiSl5JEi4VMRnx+jhLkp3U/9sSjmKBNqw4xgrScUGL4T78+kqYP0Ydl2OnQJ39k9
rwub/6NFk+D/hIaZe3yiXB/2GlD1Qy7VTDqMiMpWl1ewymKQmwhWrCpTpEUEz+YX
rWSEDzU7iPNpe9mu2hTMOZJnhcYeeohBpRUO9J7XQrjYasB52ISMcM+KkFO9g1UJ
SBkbWyu++mSWCjjoB4i7ijE2Kzqme3x2QCCNtGk+BeH4BSKSm+iDg/lNRQq176A2
Gmt9NjezxE91yPmBobqRPR5TofPhQdA2+zr2uXGpMcOFslgecLoXqBGWDbDUTbbl
AcxxRJjejENe2mQPrqBs
=XLaR
-----END PGP SIGNATURE-----

--Gv4AD2GulCTyUAWX--
