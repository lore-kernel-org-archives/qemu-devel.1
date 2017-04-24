Received: from eggs.gnu.org ([2001:4830:134:3::10]:56913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2Vw9-0007oC-Ay
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 00:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2Vw6-0007sJ-92
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 00:49:21 -0400
Date: Mon, 24 Apr 2017 14:25:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170424042558.GC16882@umbus.fritz.box>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
	<149300330317.69.15437780800942889841@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <149300330317.69.15437780800942889841@c05f1edc8ed1>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/47] ppc-for-2.10 queue 20170424
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, famz@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, clg@kaod.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 23, 2017 at 08:08:23PM -0700, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Message-id: 20170424015927.8933-1-david@gibson.dropbear.id.au
> Subject: [Qemu-devel] [PULL 00/47] ppc-for-2.10 queue 20170424
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
> Switched to a new branch 'test'
> 94bea6a target/ppc: Style fixes
> d23eac0 e500, book3s: mfspr 259: Register mapped/aliased SPRG3 user read
> 3a5bd96 target/ppc: Flush TLB on write to PIDR
> 3240e33 spapr-cpu-core: Release ICPState object during CPU unrealization
> ea6341d ppc/pnv: generate an OEM SEL event on shutdown
> 130cf1f ppc/pnv: add initial IPMI sensors for the BMC simulator
> 7e24b32 ppc/pnv: populate device tree for IPMI BT devices
> 6575717 ppc/pnv: populate device tree for serial devices
> 836d562 ppc/pnv: populate device tree for RTC devices
> dca8231 ppc/pnv: scan ISA bus to populate device tree
> 4d631b7 ppc/pnv: enable only one LPC bus
> af22372 ppc/pnv: Add support for POWER8+ LPC Controller
> 2d79b40 spapr: remove the 'nr_servers' field from the machine
> 8fa3c09 target/ppc: Fix size of struct PPCElfPrstatus
> 212f4d7 ipmi: introduce an ipmi_bmc_gen_event() API
> 240da02 ipmi: introduce an ipmi_bmc_sdr_find() API
> 3607ef7 ipmi: provide support for FRUs
> aa873a2 ipmi: use a file to load SDRs
> ef1ce62 ppc: add IPMI support
> 1a8fffd ppc/pnv: Add OCC model stub with interrupt support
> 828bcfa ppc/pnv: Add cut down PSI bridge model and hookup external interr=
upt
> ac8392a ppc/pnv: add memory regions for the ICP registers
> d90ca95 ppc/pnv: add a helper to calculate MMIO addresses registers
> a5a614b ppc/pnv: create the ICP object under PnvCore
> 5f43b5e ppc/pnv: extend the machine with a InterruptStatsProvider interfa=
ce
> 04dfecf ppc/pnv: extend the machine with a XICSFabric interface
> 5b94a0f ppc/pnv: add a PnvICPState object
> 96c645e ppc/xics: add a realize() handler to ICPStateClass
> 4569615 spapr: allocate the ICPState object from under sPAPRCPUCore
> 8257d1e spapr: move the IRQ server number mapping under the machine
> 56d6f91 ppc/xics: introduce an 'intc' backlink under PowerPCCPU
> f024a9a target/ppc: Add ibm, processor-radix-AP-encodings for TCG
> a0d8df3 spapr_pci: Removed unused include
> 7cc7952 spapr_pci: Warn when RAM page size is not enabled in IOMMU page m=
ask
> 2093121 target-ppc/kvm: Enable in-kernel TCE acceleration for multi-tce
> 26538ee spapr: Workaround for broken radix guests
> d2da420 spapr: Enable ISA 3.0 MMU mode selection via CAS
> 50fe08d spapr: move spapr_populate_pa_features()
> d667f21 target/ppc: Implement H_REGISTER_PROCESS_TABLE H_CALL
> 129c199 target/ppc: Add new H-CALL shells for in memory table translation
> d033285 target-ppc: support KVM_CAP_PPC_MMU_RADIX, KVM_CAP_PPC_MMU_HASH_V3
> 38c395b spapr: Add ibm, processor-radix-AP-encodings to the device tree
> 4fe232c target-ppc: kvm: make use of KVM_CREATE_SPAPR_TCE_64
> 90f87ad hw/ppc/pnv: Classify the "PowerNV Chip" devices as CPU devices
> c98837a ppc/spapr: QOM'ify sPAPRRTCState
> 1bc37a7 pseries: Add pseries-2.10 machine type
> 40a726e target/ppc: Improve accuracy of guest HTM availability on P8s
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/47: target/ppc: Improve accuracy of guest HTM availabili=
ty on P8s...
> Checking PATCH 2/47: pseries: Add pseries-2.10 machine type...
> Checking PATCH 3/47: ppc/spapr: QOM'ify sPAPRRTCState...
> Checking PATCH 4/47: hw/ppc/pnv: Classify the "PowerNV Chip" devices as C=
PU devices...
> Checking PATCH 5/47: target-ppc: kvm: make use of KVM_CREATE_SPAPR_TCE_64=
=2E..
> Checking PATCH 6/47: spapr: Add ibm, processor-radix-AP-encodings to the =
device tree...
> Checking PATCH 7/47: target-ppc: support KVM_CAP_PPC_MMU_RADIX, KVM_CAP_P=
PC_MMU_HASH_V3...
> Checking PATCH 8/47: target/ppc: Add new H-CALL shells for in memory tabl=
e translation...
> Checking PATCH 9/47: target/ppc: Implement H_REGISTER_PROCESS_TABLE H_CAL=
L...
> Checking PATCH 10/47: spapr: move spapr_populate_pa_features()...
> Checking PATCH 11/47: spapr: Enable ISA 3.0 MMU mode selection via CAS...
> Checking PATCH 12/47: spapr: Workaround for broken radix guests...
> Checking PATCH 13/47: target-ppc/kvm: Enable in-kernel TCE acceleration f=
or multi-tce...
> Checking PATCH 14/47: spapr_pci: Warn when RAM page size is not enabled i=
n IOMMU page mask...
> Checking PATCH 15/47: spapr_pci: Removed unused include...
> Checking PATCH 16/47: target/ppc: Add ibm, processor-radix-AP-encodings f=
or TCG...
> Checking PATCH 17/47: ppc/xics: introduce an 'intc' backlink under PowerP=
CCPU...
> Checking PATCH 18/47: spapr: move the IRQ server number mapping under the=
 machine...
> Checking PATCH 19/47: spapr: allocate the ICPState object from under sPAP=
RCPUCore...
> Checking PATCH 20/47: ppc/xics: add a realize() handler to ICPStateClass.=
=2E.
> Checking PATCH 21/47: ppc/pnv: add a PnvICPState object...
> Checking PATCH 22/47: ppc/pnv: extend the machine with a XICSFabric inter=
face...
> Checking PATCH 23/47: ppc/pnv: extend the machine with a InterruptStatsPr=
ovider interface...
> Checking PATCH 24/47: ppc/pnv: create the ICP object under PnvCore...
> Checking PATCH 25/47: ppc/pnv: add a helper to calculate MMIO addresses r=
egisters...
> Checking PATCH 26/47: ppc/pnv: add memory regions for the ICP registers...
> Checking PATCH 27/47: ppc/pnv: Add cut down PSI bridge model and hookup e=
xternal interrupt...
> Checking PATCH 28/47: ppc/pnv: Add OCC model stub with interrupt support.=
=2E.
> Checking PATCH 29/47: ppc: add IPMI support...
> Checking PATCH 30/47: ipmi: use a file to load SDRs...
> Checking PATCH 31/47: ipmi: provide support for FRUs...
> Checking PATCH 32/47: ipmi: introduce an ipmi_bmc_sdr_find() API...
> Checking PATCH 33/47: ipmi: introduce an ipmi_bmc_gen_event() API...
> Checking PATCH 34/47: target/ppc: Fix size of struct PPCElfPrstatus...
> Checking PATCH 35/47: spapr: remove the 'nr_servers' field from the machi=
ne...
> Checking PATCH 36/47: ppc/pnv: Add support for POWER8+ LPC Controller...
> Checking PATCH 37/47: ppc/pnv: enable only one LPC bus...
> Checking PATCH 38/47: ppc/pnv: scan ISA bus to populate device tree...
> Checking PATCH 39/47: ppc/pnv: populate device tree for RTC devices...
> Checking PATCH 40/47: ppc/pnv: populate device tree for serial devices...
> Checking PATCH 41/47: ppc/pnv: populate device tree for IPMI BT devices...
> Checking PATCH 42/47: ppc/pnv: add initial IPMI sensors for the BMC simul=
ator...
> Checking PATCH 43/47: ppc/pnv: generate an OEM SEL event on shutdown...
> Checking PATCH 44/47: spapr-cpu-core: Release ICPState object during CPU =
unrealization...
> Checking PATCH 45/47: target/ppc: Flush TLB on write to PIDR...
> Checking PATCH 46/47: e500, book3s: mfspr 259: Register mapped/aliased SP=
RG3 user read...
> ERROR: space prohibited between function name and open parenthesis '('
> #51: FILE: target/ppc/translate_init.c:1643:
> +static void gen_spr_usprg3 (CPUPPCState *env)
>=20
> total: 1 errors, 0 warnings, 28 lines checked

This style error is a case of matching the surrounding style instead
of the official style.  In any case I fixed this instance - along with
the rest of that particular style violation - in 47/47.

>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> Checking PATCH 47/47: target/ppc: Style fixes...
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

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY/X5UAAoJEGw4ysog2bOS08AQAMOnINjAAox9kJmMxOn0p3W4
fbClMZfQAfGJCnpSxG9RHnAohg1+r8i+UuUfRp/FP//sybSQvbtWefVgcKW6nTs+
YmEj+OBh7yCMi3XHhkeiSh7mZOTntU+Z7fc4UwTgWwAvw5hZK2JlANHsWJ7esOaC
FchsItmI+n7jEiU9+AflZKCxgSYjuN8VYtrMGwnZGrXWN90+kJCd2aUdQatiuVCm
+qeLiOV3CtfaTNN0c7M47aDdCdDK13gD99tfSYysFerBVf2JI4SoqMUZqc05+lDU
laXVVBUcAEcnJO/c1dOi2ma3kiKuBCW3DeVkQp0riOzDalattPGAm43Fz8WIkKv9
8C3rbwO5nQDXGLytjSv59I75lfE6GqwhHMbQw7H2wiMytEwPu4uMDWTNbcNSxX+S
l3L7uhie/iUdPsytDURX0CkkCrOtynpzQO8C8IkGTdWwpOodivHP1gFuPVin0SGL
Anax785FOipQPhJ8LFhW+HdAn6wRkhQtbk4lpuCNIKifY2ZKjPOAk6IAPnFUsvaK
aXiaZ0Ex71pMvYpUosQ360GH7RSHtUWwt4T0xzplvEn4L0e9Zuwd6y2bgw2hvDP8
710BxtxANS/nR7CEw6Umf95znlQaIBU1GUTotcoJQNdA4McVCm2pSU9ZfylrH1vR
kgbd59vwp5tCDvYwIR+s
=HyMN
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
