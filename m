Received: from eggs.gnu.org ([2001:4830:134:3::10]:38309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et4r9-0002ki-5Q
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et4r5-0006UW-Ug
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:09:43 -0500
Date: Tue, 6 Mar 2018 15:39:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180306043947.GW2650@umbus.fritz.box>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
	<152031063968.1383.5566931288498782513@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/iGx3h4bc2ZI981g"
Content-Disposition: inline
In-Reply-To: <152031063968.1383.5566931288498782513@bdbb90650ae5>
Subject: Re: [Qemu-devel] [PULL 00/30] ppc-for-2.12 queue 20180306
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org, groug@kaod.org, qemu-ppc@nongnu.org, agraf@suse.de, surajjs@au1.ibm.com


--/iGx3h4bc2ZI981g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 08:30:40PM -0800, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Type: series
> Message-id: 20180306040154.3669-1-david@gibson.dropbear.id.au
> Subject: [Qemu-devel] [PULL 00/30] ppc-for-2.12 queue 20180306
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
> git config --local diff.algorithm histogram
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
>  * [new tag]               patchew/20180306040154.3669-1-david@gibson.dro=
pbear.id.au -> patchew/20180306040154.3669-1-david@gibson.dropbear.id.au
> Switched to a new branch 'test'
> 710332af72 PowerPC: Add TS bits into msr_mask
> 1d843d531b adb: add trace-events for monitoring keyboard/mouse during bus=
 enumeration
> e0dcafa414 PPC: e500: Fix duplicate kernel load and device tree overlap
> ca32627c89 hw/ppc/spapr, e500: Use new property "stdout-path" for boot co=
nsole
> 7ec999efd1 ppc/spapr-caps: Define the pseries-2.12-sxxm machine type
> c5c9d5e6b5 ppc/spapr-caps: Convert cap-ibs to custom spapr-cap
> d1f8d2a7ec ppc/spapr-caps: Convert cap-sbbc to custom spapr-cap
> dee8ac698b ppc/spapr-caps: Convert cap-cfpc to custom spapr-cap
> be78220976 ppc/spapr-caps: Add support for custom spapr_capabilities
> 41fe6c3234 target/ppc: Check mask when setting cap_ppc_safe_indirect_bran=
ch
> 925dc8c8ab macio: remove macio_init() function
> 0cdc7ef4d3 macio: move setting of CUDA timebase frequency to macio_common=
_realize()
> 333e2d72ae mac_newworld: use object link to pass OpenPIC object to macio
> 6352921fc0 openpic: move OpenPIC state and related definitions to openpic=
=2Eh
> f6528ecaad openpic: move KVM-specific declarations into separate openpic_=
kvm.h file
> ff45ce713e mac_oldworld: use object link to pass heathrow PIC object to m=
acio
> 7a6c79ea44 macio: move macio related structures and defines into separate=
 macio.h file
> 314c9858ad heathrow: change heathrow_pic_init() to return the heathrow de=
vice
> f5b91571dc heathrow: convert to trace-events
> 3045694ed1 heathrow: QOMify heathrow PIC
> ad17492d9b macio: move ESCC device within the macio device
> 777c94a3ee macio: embed DBDMA device directly within macio
> 2ea90e405c spapr: harden code that depends on VSMT
> 00226ad7c9 spapr: register dummy ICPs later
> 7ed96e066b ppc: Add aCube Sam460ex board
> 9abb284ab2 pc-bios: Added u-boot-sam460 firmware binary
> e4cb279fb1 roms: Added git submodule for u-boot-sam460 (firmware for sam4=
60ex)
> a2279cf053 ppc440: Add emulation of plb-pcix controller found in some 440=
 SoCs
> 3e9afde83e ppc440_uc: Fix unintialized variable warning with older gcc
> 8e4c18ae65 spapr: fix missing CPU core nodes in DT when running with TCG
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/30: spapr: fix missing CPU core nodes in DT when running=
 with TCG...
> Checking PATCH 2/30: ppc440_uc: Fix unintialized variable warning with ol=
der gcc...
> Checking PATCH 3/30: ppc440: Add emulation of plb-pcix controller found i=
n some 440 SoCs...
> Checking PATCH 4/30: roms: Added git submodule for u-boot-sam460 (firmwar=
e for sam460ex)...
> Checking PATCH 5/30: pc-bios: Added u-boot-sam460 firmware binary...
> Checking PATCH 6/30: ppc: Add aCube Sam460ex board...
> Checking PATCH 7/30: spapr: register dummy ICPs later...
> Checking PATCH 8/30: spapr: harden code that depends on VSMT...
> Checking PATCH 9/30: macio: embed DBDMA device directly within macio...
> Checking PATCH 10/30: macio: move ESCC device within the macio device...
> Checking PATCH 11/30: heathrow: QOMify heathrow PIC...
> Checking PATCH 12/30: heathrow: convert to trace-events...
> Checking PATCH 13/30: heathrow: change heathrow_pic_init() to return the =
heathrow device...
> Checking PATCH 14/30: macio: move macio related structures and defines in=
to separate macio.h file...
> Checking PATCH 15/30: mac_oldworld: use object link to pass heathrow PIC =
object to macio...
> Checking PATCH 16/30: openpic: move KVM-specific declarations into separa=
te openpic_kvm.h file...
> Checking PATCH 17/30: openpic: move OpenPIC state and related definitions=
 to openpic.h...
> ERROR: "foo * bar" should be "foo *bar"
> #250: FILE: include/hw/ppc/openpic.h:57:
> +#define RAVEN_DBL_IRQ    (RAVEN_IPI_IRQ + (RAVEN_MAX_CPU * RAVEN_MAX_IPI=
))
>=20
> total: 1 errors, 0 warnings, 353 lines checked

This is a false positive.  For some reason it's misidentifying a
multiply as a dereference.

>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> Checking PATCH 18/30: mac_newworld: use object link to pass OpenPIC objec=
t to macio...
> Checking PATCH 19/30: macio: move setting of CUDA timebase frequency to m=
acio_common_realize()...
> Checking PATCH 20/30: macio: remove macio_init() function...
> Checking PATCH 21/30: target/ppc: Check mask when setting cap_ppc_safe_in=
direct_branch...
> Checking PATCH 22/30: ppc/spapr-caps: Add support for custom spapr_capabi=
lities...
> Checking PATCH 23/30: ppc/spapr-caps: Convert cap-cfpc to custom spapr-ca=
p...
> Checking PATCH 24/30: ppc/spapr-caps: Convert cap-sbbc to custom spapr-ca=
p...
> Checking PATCH 25/30: ppc/spapr-caps: Convert cap-ibs to custom spapr-cap=
=2E..
> Checking PATCH 26/30: ppc/spapr-caps: Define the pseries-2.12-sxxm machin=
e type...
> Checking PATCH 27/30: hw/ppc/spapr, e500: Use new property "stdout-path" =
for boot console...
> Checking PATCH 28/30: PPC: e500: Fix duplicate kernel load and device tre=
e overlap...
> Checking PATCH 29/30: adb: add trace-events for monitoring keyboard/mouse=
 during bus enumeration...
> Checking PATCH 30/30: PowerPC: Add TS bits into msr_mask...
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

--/iGx3h4bc2ZI981g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqeG5EACgkQbDjKyiDZ
s5Kq8RAA38DEem2PsMxtrjdC8yC5jvtN/AuRZDGZ7k0uYJPHgNB+uGIW3/3Zn9kT
xl4aOyRn7OCf2jfZfGs4V/NP986vGSc9zRQ+kGRzSxt6tA661xk/6jbHyJ5QS3Gn
FW7IHC1418WCwP6MTurDjhl9UK5su//b5l9e0Xxtfh4J5C9WiH13j5bUGfNRr82N
4pQiU3Ig8+LiRggghVEmIKeyVCQmx/8hM2re3HDSspEFdD2XvjrtQZc/5u3bUZKe
vUu2P7UBAHXbRILYaqLIVGxDdUYvcjzGSPseLSe2tyzb6cAOJV0oFqM2dEZAZnKh
9OEGCHY7rJeRpuCjaCnEcpmpmMNSni+CCjZj5WuB/KBpFf6INZXRyLbFtm+5SNQU
f0kfR5SupjKlkUFcUJAYevFZwHPUWckONID0Z+yN8AohthcQF+1PBRHVpqordPzY
9rZPKHT37hYXIppORwffnpBMypbuX3l7ubfx7XjzP3chX+FZaizkpV5hkJyy5x1L
XnOCgQAI/mzDEgMFO0IcsuBj+O3g4fW8E6M4kIZ0b3t0JhrDRhuNEjztxMrOYVHa
dtDWpwNhhb0FQQL+f/bO7zd5Hq5tnWyTZsTNrLbzxKGM1C+hACnVB4sQG98rCC5q
Xcs9OpadMKvNjXrCJjAbSWDaaEmcUR4V/8hyQIWkfte9RT+Dktg=
=ngdE
-----END PGP SIGNATURE-----

--/iGx3h4bc2ZI981g--
