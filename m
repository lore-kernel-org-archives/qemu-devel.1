Received: from eggs.gnu.org ([2001:4830:134:3::10]:54697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjegL-0002LQ-0D
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 23:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjegH-0003sE-O9
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 23:19:04 -0500
Date: Fri, 3 Mar 2017 15:18:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170303041811.GA667@umbus.fritz.box>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
	<148851245749.285.4274943456379606580@0e2666bad730>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <148851245749.285.4274943456379606580@0e2666bad730>
Subject: Re: [Qemu-devel] [PULL 00/17] ppc-for-2.9 queue 20170303
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org, lvivier@redhat.com, thuth@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, agraf@suse.de, qemu-ppc@nongnu.org, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2017 at 07:40:58PM -0800, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Message-id: 20170303032507.16142-1-david@gibson.dropbear.id.au
> Type: series
> Subject: [Qemu-devel] [PULL 00/17] ppc-for-2.9 queue 20170303
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
>=20
> BASE=3Dbase
> n=3D1
> total=3D$(git log --oneline $BASE.. | wc -l)
> failed=3D0
>=20
> # Useful git options
> git config --local diff.renamelimit 0
> git config --local diff.renames True
>=20
> commits=3D"$(git log --format=3D%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c)..."
>     if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --mailbac=
k -; then
>         failed=3D1
>         echo
>     fi
>     n=3D$((n+1))
> done
>=20
> exit $failed
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/20170303032507.16142-1-david@gibson.dropbear=
=2Eid.au -> patchew/20170303032507.16142-1-david@gibson.dropbear.id.au
> Switched to a new branch 'test'
> 3246067 target/ppc: rewrite f[n]m[add, sub] using float64_muladd
> 2043060 spapr: Small cleanup of PPC MMU enums
> 50dc395 spapr_pci: Advertise access to PCIe extended config space
> c68d6be target/ppc: Rework hash mmu page fault code and add defines for c=
larity
> 809a3f5 target/ppc: Move no-execute and guarded page checking into new fu=
nction
> cbddae7 target/ppc: Add execute permission checking to access authority c=
heck
> 5438e36 target/ppc: Add Instruction Authority Mask Register Check
> 8f0f27f hw/ppc/spapr: Add POWER9 to pseries cpu models
> a6391c2 target/ppc/POWER9: Add cpu_has_work function for POWER9
> 1dfd4de target/ppc/POWER9: Add POWER9 pa-features definition
> 8bd6f88 target/ppc/POWER9: Add POWER9 mmu fault handler
> fcbb600 target/ppc: Don't gen an SDR1 on POWER9 and rework register creat=
ion
> 98f9781 target/ppc: Add patb_entry to sPAPRMachineState
> 26b2ad3 target/ppc/POWER9: Add POWERPC_MMU_V3 bit
> 7b77fce powernv: Don't test POWER9 CPU yet
> a076e26 exec, kvm, target-ppc: Move getrampagesize() to common code
> c53f459 target/ppc: Add POWER9/ISAv3.00 to compat_table
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/17: target/ppc: Add POWER9/ISAv3.00 to compat_table...
> Checking PATCH 2/17: exec, kvm, target-ppc: Move getrampagesize() to comm=
on code...
> WARNING: architecture specific defines should be avoided
> #117: FILE: exec.c:1341:
> +#ifdef __linux__
>=20
> total: 0 errors, 1 warnings, 287 lines checked

This is just a code motion, so not a new warning.

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 3/17: powernv: Don't test POWER9 CPU yet...
> ERROR: if this code is redundant consider removing it
> #42: FILE: tests/pnv-xscom-test.c:45:
> +#if 0 /* POWER9 support is not ready yet */
>=20
> total: 1 errors, 0 warnings, 25 lines checked

And the #if 0ed code here will be useful in future.

So I think it's reasonable to overlook these two style warnings.

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> Checking PATCH 4/17: target/ppc/POWER9: Add POWERPC_MMU_V3 bit...
> Checking PATCH 5/17: target/ppc: Add patb_entry to sPAPRMachineState...
> Checking PATCH 6/17: target/ppc: Don't gen an SDR1 on POWER9 and rework r=
egister creation...
> Checking PATCH 7/17: target/ppc/POWER9: Add POWER9 mmu fault handler...
> Checking PATCH 8/17: target/ppc/POWER9: Add POWER9 pa-features definition=
=2E..
> Checking PATCH 9/17: target/ppc/POWER9: Add cpu_has_work function for POW=
ER9...
> Checking PATCH 10/17: hw/ppc/spapr: Add POWER9 to pseries cpu models...
> Checking PATCH 11/17: target/ppc: Add Instruction Authority Mask Register=
 Check...
> Checking PATCH 12/17: target/ppc: Add execute permission checking to acce=
ss authority check...
> Checking PATCH 13/17: target/ppc: Move no-execute and guarded page checki=
ng into new function...
> Checking PATCH 14/17: target/ppc: Rework hash mmu page fault code and add=
 defines for clarity...
> Checking PATCH 15/17: spapr_pci: Advertise access to PCIe extended config=
 space...
> Checking PATCH 16/17: spapr: Small cleanup of PPC MMU enums...
> Checking PATCH 17/17: target/ppc: rewrite f[n]m[add, sub] using float64_m=
uladd...
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYuO6DAAoJEGw4ysog2bOSDUUQAJJtZWt8juIE8ob3J4573ecS
d6+GLCtwTSgaNkQ6xhgAL59IqKRCpIsx+OzE7w1IVnGWjhjp/9H5pww7LkiRN9gp
7vOJxgdUIHYgAQWn/EvHJ1t3IQY4RH6cSDdYdDfB2v39HMU0Njx8JNyV5EAHnWqt
/zp/iR5DFXhIoJYvTONfHsgCGA9oiEc0DH4hxEthKItRcThjSFEQyYjudHLEXPxn
kgH2G3f7ymaCEJAkPf5KfhO1Yy47Hz1eXoYhGFWtqVQCdQUHPD02oGXlXuKiMm3O
F2evBrtSAeQjX4EcsBSYaNniftfA12Y5WP0WGyxvK0IwdMafbTWb237/CHkfASCW
r5Hu17rekYV7cPiXvfiPgxiwKJzMnob7VfduKsGMNeAQO8eACogwPNtGf/Rwgxrm
WAZDx2mAAGrVE1UYsi77OIkfy0eZsLuCb8pFfNiBZFOdCds/C8sAnri6FEQcrj9c
ga+Gemogw8NNxQAFZXLyH7PkcZ7hryQKVhGiya6SmjIekO6UmIPAi/mHtZv4DIPe
LUa2lx/UoY1e/SkMK0vBm5A73+l+4XdYhiQkxjfSL/mNkWx3vcraCWKcm3sH7rwa
MrZwHDc+WXQYbCS90C7x+Tnmlm4ejI3a5T5Apjzs4Edq3Q3uvAQ1V9UBcL3BwbgA
Q0jGWy5sTD0tA0QkQWUH
=h8Od
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
