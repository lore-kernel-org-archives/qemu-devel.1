Received: from eggs.gnu.org ([2001:4830:134:3::10]:45892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgk4a-0004MZ-Kg
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:28:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgk4Z-000275-KV
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:28:04 -0500
Date: Thu, 23 Feb 2017 14:27:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223032749.GE12577@umbus.fritz.box>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="95nVhCDQCgPWiQqT"
Content-Disposition: inline
In-Reply-To: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/10] POWER9 TCG enablements - part15
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


--95nVhCDQCgPWiQqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2017 at 05:14:33PM +0530, Nikunj A Dadhania wrote:
> This series contains implentation of CA32 and OV32 bits added to the=20
> ISA 3.0. Various fixed-point arithmetic instructions are updated to take
> care of the newer flags.=20
>=20
> Finally the last patch adds new instruction mcrxrx, that helps reading=20
> the carry (CA and CA32) and the overflow (OV and OV32) flags

I've applied patches 1 & 2 to ppc-for-2.9.

The rest I've left for a resend pending my comments and rth's.

>=20
> Changelog:
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
> Nikunj A Dadhania (10):
>   target/ppc: move cpu_[read, write]_xer to cpu.c
>   target/ppc: optimize gen_write_xer()
>   target/ppc: support for 32-bit carry and overflow
>   target/ppc: update ca32 in arithmetic add
>   target/ppc: update ca32 in arithmetic substract
>   target/ppc: update overflow flags for add/sub
>   target/ppc: use tcg ops for neg instruction
>   target/ppc: add ov32 flag for multiply low insns
>   target/ppc: add ov32 flag in divide operations
>   target/ppc: add mcrxrx instruction
>=20
>  target/ppc/Makefile.objs    |   1 +
>  target/ppc/cpu.c            |  51 ++++++++++++++++++
>  target/ppc/cpu.h            |  21 ++++----
>  target/ppc/int_helper.c     |  53 +++++++-----------
>  target/ppc/translate.c      | 128 ++++++++++++++++++++++++++++++++++++++=
------
>  target/ppc/translate_init.c |   4 +-
>  6 files changed, 194 insertions(+), 64 deletions(-)
>  create mode 100644 target/ppc/cpu.c
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--95nVhCDQCgPWiQqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrla0AAoJEGw4ysog2bOSJuAQAK2vMWPzylQcspQIuiiFUEo0
8hl10pBYDfaD8ncQg/dptCOmEL7zOTvcUvWQCsvEVx2FCmE4kgFifLiAQENBYSKB
9CdXQ4PquTJIxyO1KzXIt0dztZmFz4Wg6dcK21DvlJgnouKcylm8XSFU/cEdy/bA
OkYhwhKIJmoiE10/Vb+LhmemODn/DltahuZfjPZKsiw1F/JjbGKaj9AiXVkwIx1S
CpIPqHVziFdQXjBrWiIwn4Jo3NqQOMl4aipCEiGG5V1X8xr+7jh9iF6RlPdETOxH
mhuBZZTEDWzpfK1BlZQLw6fs5uaxL8dJDZRL9QnQdCe0QZuc7XXeFHQrzUkl0zRY
LZYWmnOQOMFr0f3Li1NFzJCP4DZZPnlIZxEAMgW+bUPM1kuT8p3gkGwPCBbbQaal
1lj2wc3aBq/vNqLXviii5KNZBIWy70m0D28VamnnvVsc9BgDjtV9dymzo7KLAa6b
ApSvECAh3WL8sq5/e40ac1imqsxTqECftlGGGH9mgpc2UmzzQP7sQ0J6DBCjiFid
PODorz24JteRFQ6gHshtf7gzoxPj5JWS4r8jdUHlRg1S+RuJ4bwvYJNOW+F+Lfnm
dC3jDZQbRyFsaQCZZ3NfahxuwdAJIJuT+0OGwlCBSJypi2VZposEXuxwcJ5IEB4E
dTF1lHFSAYEnkvGC/lSB
=Ptqw
-----END PGP SIGNATURE-----

--95nVhCDQCgPWiQqT--
