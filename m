Received: from eggs.gnu.org ([2001:4830:134:3::10]:42896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsiwl-0003ry-7C
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 01:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsiwi-0003KY-H4
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 01:13:47 -0400
Date: Fri, 15 Sep 2017 15:00:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170915050013.GD5250@umbus.fritz.box>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
	<150544960865.36.15903779803721853515@69b6ddf88678>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <150544960865.36.15903779803721853515@69b6ddf88678>
Subject: Re: [Qemu-devel] [PULL 00/18] ppc-for-2.11 queue 20170915
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org, aik@ozlabs.ru, gkurz@kaod.org, agraf@suse.de, qemu-ppc@nongnu.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 09:26:49PM -0700, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Subject: [Qemu-devel] [PULL 00/18] ppc-for-2.11 queue 20170915
> Message-id: 20170915035130.8354-1-david@gibson.dropbear.id.au
> Type: series
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
>=20
> BASE=3Dbase
> n=3D1
> total=3D$(git log --oneline $BASE.. | wc -l)
> failed=3D0
>=20
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
> Switched to a new branch 'test'
> 872afb4d17 ppc/kvm: use kvm_vm_check_extension() in kvmppc_is_pr()
> 7a25c28fcc spapr_events: use QTAILQ_FOREACH_SAFE() in spapr_clear_pending=
_events()
> 925177495a spapr_cpu_core: cleaning up qdev_get_machine() calls
> e0a96b5c4d spapr_pci: don't create 64-bit MMIO window if we don't need to
> 1851b264d5 spapr_pci: convert sprintf() to g_strdup_printf()
> e62bfeb753 spapr_cpu_core: fail gracefully with non-pseries machine types
> d68c815c09 xics: fix several error leaks
> 165724544b vfio, spapr: Fix levels calculation
> e0d3f60741 spapr_pci: handle FDT creation errors with _FDT()
> 9d82d580aa spapr_pci: use the common _FDT() helper
> fe74e07d9f spapr: fix CAS-generated reset
> 53b3f63411 ppc/xive: fix OV5_XIVE_EXPLOIT bits
> 48ced9b1af spapr: only update SDR1 once per-cpu during CAS
> 868444ad8c spapr_pci: use g_strdup_printf()
> dbfa7f0124 spapr_pci: drop useless check in spapr_populate_pci_child_dt()
> 2d5463163b spapr_pci: drop useless check in spapr_phb_vfio_get_loc_code()
> 0d760c3eed hw/ppc/spapr.c: cleaning up qdev_get_machine() calls
> 2add13654e net: Add SunGEM device emulation as found on Apple UniNorth
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/18: net: Add SunGEM device emulation as found on Apple U=
niNorth...
> Checking PATCH 2/18: hw/ppc/spapr.c: cleaning up qdev_get_machine() calls=
=2E..
> Checking PATCH 3/18: spapr_pci: drop useless check in spapr_phb_vfio_get_=
loc_code()...
> Checking PATCH 4/18: spapr_pci: drop useless check in spapr_populate_pci_=
child_dt()...
> Checking PATCH 5/18: spapr_pci: use g_strdup_printf()...
> Checking PATCH 6/18: spapr: only update SDR1 once per-cpu during CAS...
> Checking PATCH 7/18: ppc/xive: fix OV5_XIVE_EXPLOIT bits...
> Checking PATCH 8/18: spapr: fix CAS-generated reset...
> Checking PATCH 9/18: spapr_pci: use the common _FDT() helper...
> Checking PATCH 10/18: spapr_pci: handle FDT creation errors with _FDT()...
> Checking PATCH 11/18: vfio, spapr: Fix levels calculation...
> Checking PATCH 12/18: xics: fix several error leaks...
> Checking PATCH 13/18: spapr_cpu_core: fail gracefully with non-pseries ma=
chine types...
> Checking PATCH 14/18: spapr_pci: convert sprintf() to g_strdup_printf()...
> Checking PATCH 15/18: spapr_pci: don't create 64-bit MMIO window if we do=
n't need to...
> ERROR: spaces required around that '-' (ctx:VxV)
> #55: FILE: hw/ppc/spapr_pci.c:1625:
> +    if (sphb->mem64_win_pciaddr !=3D (hwaddr)-1) {
>                                             ^
>=20
> ERROR: spaces required around that '-' (ctx:VxV)
> #62: FILE: hw/ppc/spapr_pci.c:1632:
> +        if (sphb->mem64_win_addr !=3D (hwaddr)-1) {
>                                              ^
>

These are false positives, a patch for checkpatch.pl is in the works.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm7XloACgkQbDjKyiDZ
s5Jv/hAAgFAgjRbqyVthkCQ2AO+ngO9IDHbHH0Ct7WYTl9EL84YYz60BA42mU5Ap
pUf/BufQ5I/1xASk14bsta8qE6smXnxin0CtstLaya3xwJnPsxudum8oQrm4Osby
nn5BBZdLxb4E1Z0BEUiWEbgH93g3enjbmpuplgMkZPwVmimfPE/J/ULu6NQrcW5A
W9sjPgSPbBCED7ulLbyduFiVOysm8I7uef8PhVnmVId9/QTf9WD3cOdiyaQ5X3jG
rwkm9jlhbtkrJjtQ47J6ScB3KaujP7ZGz+8FerqgNwFojo+KOIauWKg9PqGYPgQG
27Pe8MyHV3smHasaQl7SMR5DJgENUmMUWNWWVjSWaBNJKWvTdaB2v2X6yU3G2sP6
4+rpuwPQPtMtB01zCsqNHxoth8N51GEIAz06U8KsKECZqehwVH1wrflB9xn4+kLp
4oG2t6Bf+RwyMEs+TqsqHgY/OoWCgryGfFi/6A69n+YbeSw5wpVOD/HXf/YmvQ1w
wg2RGEAEjn1v+WqKywg0+XUAmqTkfyPc62nroOHcz+oRwbLRXUswV7gA5777+5/J
5a0NlRf7RCr3P5XvvBO0+0+uNYWcYyk92ZbaGPKScT8y4O5XCsLy83c8H9NWndjR
lpXXX42kuKU6/mNkX6Rqg1flrs54jw9JIcofkGO1J+iDTMqXL84=
=4UFc
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
