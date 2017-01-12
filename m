Received: from eggs.gnu.org ([2001:4830:134:3::10]:34754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRp0I-0008FV-JO
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRp0H-00022e-Ak
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:41:58 -0500
Date: Fri, 13 Jan 2017 10:36:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170112233648.GH13656@umbus.fritz.box>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
	<148419252309.208.2771983577120071954@790289a7ca88>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9sSKoi6Rw660DLir"
Content-Disposition: inline
In-Reply-To: <148419252309.208.2771983577120071954@790289a7ca88>
Subject: Re: [Qemu-devel] [PULL 00/67] ppc-for-2.9 queue 20170112
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org, lvivier@redhat.com, thuth@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, agraf@suse.de, qemu-ppc@nongnu.org


--9sSKoi6Rw660DLir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2017 at 07:42:04PM -0800, no-reply@patchew.org wrote:
> Hi,
>=20
> Your series seems to have some coding style problems. See output below for
> more information:

I don't think this is a real problem:

> Checking PATCH 46/67: target-ppc: Add xxextractuw instruction...
> ERROR: Macros with complex values should be enclosed in parenthesis
> #110: FILE: target/ppc/translate/vsx-ops.inc.c:52:
> +#define GEN_XX2FORM_EXT(name, opc2, opc3, fl2)                          \
> +GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0, opc3, 0x00100000, PPC_NONE, =
fl2), \
> +GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 0x00100000, PPC_NONE, =
fl2)
>=20
> total: 1 errors, 0 warnings, 92 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

This is the standard problem with checkpatch getting confused by the
ugly, ugly macros in the instruction decode stuff.  Maybe we'll fix
that one day, but it's not a priority, and it's definitely out of
scope for this patch.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9sSKoi6Rw660DLir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYeBMQAAoJEGw4ysog2bOStmcP/ibqPz0++Pn3pxdtaT9N0wF8
DUBitBpaPQgkLHx+nKvb9kBCMh+KCLmPgRG8qxPR7B1SMm95IiI5GGxpWAHo5wXI
bQoq9pMIHR6Sd6J/6ENUtcKFdzahuHyT2wUyAwJt8Z67S5SeoVy3R5h1LUnUslBy
LBMIAQZSqhkG5ys/fwbgSExgouTzHJnn0pzcBw4LPrDvPsTW+encS13QVECG4ODK
A4VZGjy0kJ4BjF3mCZtE0cInzJXTes0xwZUelNaYI3yWeiiPF46zUWgY9P4u0TmQ
9FPZl7A3UtolpMe//5TED3NqB3WVmLu+Epv02iT8WtxnHW8uBfZksK/UH92zXa3i
AHgA61QCcEr67mZmIvXKkAWMfTl/utL6AkmuYZ2xfUxMf+cbm26S7Q8C55AU4+0K
YOuDcEZM22gc+dukgrMNJjpyD8l2MMNosyhvnOt7n7XNi39sVjZNooEo9LArgnJX
Hq3KnHP1ogRpsD/9QU3PfqDlq0qk6z+wFVr0KJEU7BKJgTmVCvMT0OObjDsnHYxy
TnxB6llSMkk4hkEyg0qwPlqg/51+sJ9yeFBGPxoq94UrNJr1NtsUc67cnKin+qGH
0lGz3pnW9SXa4e8CnEy5kmJHCljE3/w4gPbwTO/+Is7MUBYXykiO/dAhVreXIclv
sRcip7nNQwJ8moV6Ntfj
=73Fj
-----END PGP SIGNATURE-----

--9sSKoi6Rw660DLir--
