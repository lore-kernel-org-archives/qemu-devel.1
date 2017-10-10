Received: from eggs.gnu.org ([2001:4830:134:3::10]:38960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kU2-0004Or-N1
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kU0-0004Wv-As
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:26 -0400
Date: Tue, 10 Oct 2017 13:21:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171010022137.GL2668@umbus.fritz.box>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eWbcAUUbgrfSEG1c"
Content-Disposition: inline
In-Reply-To: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/24] generalize parsing of cpu_model
 (part 3/PPC)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--eWbcAUUbgrfSEG1c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2017 at 09:50:47PM +0200, Igor Mammedov wrote:

Applied to ppc-for-2.11.  There was a small error in 19/24, which
reverted pnv to defaulting to POWER9 v1.0 whereas I've recently
changed it to v2.0.  Rather than requiring a respin I adjusted that
myself, and fixed the minor conflicts in the subsequent patches.

> Changelog:
>   - v2:
>      * rebase on dgibson/ppc-for-2.11 tree
>      * fix typo: s/pvn_chip_core_typename/pnv_chip_core_typename/
>      * fix typo: s/pvn_core_cpu_typename/pnv_core_cpu_typename/
>      * limit setting default cpu type to 'host' type only for spapr machi=
ne
>      * split out ppc_cpu_lookup_alias() movement into separate patch
>      * fix rebase conflict: add newly added power9_v2 core
>      * set "max-cpu-compat" property only if it exists,
>        in practice it should limit 'compat' hack to spapr
>        and allow to avoid including machine/spapr headers
>        in target/ppc/cpu.c
>      * do compat=3D parsing only if machine."max-cpu-compat" exists
>        that would match what current code practically does.
>      * add newline before ppc_cpu_parse_featurestr() definition
>      * pickup Acked-by/Reviewed-by where it's appropriate
>=20
> this series is continuation of effort to remove boards dependency on
> cpu_model parsing and generalizing default cpu type handling.
> For background story look at merged:=20
>=20
>   [PATCH v2 0/5] generalize parsing of cpu_model (x86/arm)
>   https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03564.html
>=20
> Part 3 is independent subset that takes care of all PPC boards.
> Series borrows the 1st 3 patches from earlier posted part 2
>   qom: update doc comment for type_register[_static]()                   =
       =20
>   qom: introduce type_register_static_array()                            =
       =20
>   qom: add helper macro DEFINE_TYPES()
> to avoid interdependency, hopefully this 3 will be merged via machine-nex=
t,
> but it's fine for them to go via any tree (whichever first)
>=20
> Beside of switching to generic cpu_model parsing series contains a bunch
> of cleanups/simplifications which reduces code a bit and normalizes
> code that I've happend to touch to a typical QEMU patterns.
>=20
> git tree for testing:
>   https://github.com/imammedo/qemu/branches cpu_init_removal_ppc_part3_v2
>=20
> Refference to v1:
>   https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg01087.html
>=20
>=20
> CC: Alexander Graf <agraf@suse.de> (supporter:ppce500)
> CC: David Gibson <david@gibson.dropbear.id.au> (maintainer:PowerPC)
> CC: "Herv=E9 Poussineau" <hpoussin@reactos.org> (maintainer:PReP)
> CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com> (odd fixer:virtex_ml50=
7)
> CC: qemu-ppc@nongnu.org (open list:ppce500)
>=20
> Igor Mammedov (24):
>   qom: update doc comment for type_register[_static]()
>   qom: introduce type_register_static_array()
>   qom: add helper macro DEFINE_TYPES()
>   ppc: mpc8544ds/e500plat: use generic cpu_model parsing
>   ppc: mac_newworld: use generic cpu_model parsing
>   ppc: mac_oldworld: use generic cpu_model parsing
>   ppc: bamboo: use generic cpu_model parsing
>   ppc: replace cpu_model with cpu_type on ref405ep,taihu boards
>   ppc: virtex-ml507: replace cpu_model with cpu_type
>   ppc: 40p/prep: replace cpu_model with cpu_type
>   ppc: spapr: replace ppc_cpu_parse_features() with
>     cpu_parse_cpu_model()
>   ppc: move '-cpu foo,compat=3Dxxx' parsing into
>     ppc_cpu_parse_featurestr()
>   ppc: spapr: define core types statically
>   ppc: spapr: use cpu type name directly
>   ppc: spapr: register 'host' core type along with the rest of core
>     types
>   ppc: spapr: use cpu model names as tcg defaults instead of aliases
>   ppc: move ppc_cpu_lookup_alias() before its first user
>   ppc: spapr: use generic cpu_model parsing
>   ppc: pnv: use generic cpu_model parsing
>   ppc: pnv: normalize core/chip type names
>   ppc: pnv: drop PnvCoreClass::cpu_oc field
>   ppc: pnv: define core types statically
>   ppc: pnv: drop PnvChipClass::cpu_model field
>   ppc: pnv: consolidate type definitions and batch register them
>=20
>  include/hw/ppc/pnv.h            |  12 +--
>  include/hw/ppc/pnv_core.h       |   4 +-
>  include/hw/ppc/ppc.h            |   2 -
>  include/hw/ppc/spapr.h          |   2 -
>  include/hw/ppc/spapr_cpu_core.h |   7 +-
>  include/qom/object.h            |  50 ++++++++++-
>  target/ppc/cpu-qom.h            |   1 +
>  target/ppc/cpu.h                |   1 -
>  hw/ppc/e500.c                   |   8 +-
>  hw/ppc/e500plat.c               |   1 +
>  hw/ppc/mac_newworld.c           |  15 ++--
>  hw/ppc/mac_oldworld.c           |   6 +-
>  hw/ppc/mpc8544ds.c              |   2 +
>  hw/ppc/pnv.c                    | 131 ++++++++++++----------------
>  hw/ppc/pnv_core.c               |  67 +++++++--------
>  hw/ppc/ppc.c                    |  25 ------
>  hw/ppc/ppc405_uc.c              |   6 +-
>  hw/ppc/ppc440_bamboo.c          |   7 +-
>  hw/ppc/ppc4xx_devs.c            |   4 +-
>  hw/ppc/prep.c                   |  12 +--
>  hw/ppc/spapr.c                  |  22 ++---
>  hw/ppc/spapr_cpu_core.c         | 184 ++++++++++------------------------=
------
>  hw/ppc/virtex_ml507.c           |  11 +--
>  qom/object.c                    |   9 ++
>  target/ppc/kvm.c                |  22 ++---
>  target/ppc/translate_init.c     |  69 +++++++++++++--
>  26 files changed, 305 insertions(+), 375 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eWbcAUUbgrfSEG1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlncLq8ACgkQbDjKyiDZ
s5KqcxAAusKKGIosnN0bXXenuHJlcS7ZgHhYx7QiGIL2w5P7fS6+0dnbz4eRG92S
T75oG3q6lPCBEq7TIs4UTGus+7SwC5abdy/QzldVrnO8Dg4t6WjZr4AuxjdqdWSF
6f59Z1yw6XFpu6Mn5qEMHkkmrktK0k2VT2exm2OxEYDtfo2NxM1wEgd5uWbENHOF
CxRe1ybTnCc2seexJmoZm8A47UYM3I9s9RvbbUxSwG3pHnl2k+hqXX8DK7gTebP+
czkiLHPcPu3KBOmQJ7rxwbZPgeNPIM822noVe5RqIfoAzYkc7QJxD6vgVSUj2WJw
LCiE6hKf5KPhSSbrb/3wZ2bf3plwufC5ZQYLW4uU3tVsgkuN0h8BkoG2CwSzH8Hf
lLZ7cvy9CiYjzv0Via6Lab/TpBk4jXVPIGmgZAw5CazlSx6+nP/VxqirmtWaLVjM
/HVjTEb2PldrBFYOFy+Y9HSxLqFmkxCR8lcPbRmSkx6o84aDUxzqRkNxTMijcWrD
obErpia68Zm2T3TDNdgahi0xekQalHqo0HhRb9PXZW2eLS+2YLOK+AD3xQBBI7Xi
LYZnV0Oo6gHlvMahke02qSrkdb0rEHgZtK2OuSBlO6y+6R2ziony4LkTbc2KuJRq
k11jd4vQDtv68eRM3CdlqDgUbO6+ZQJiGsSx0nC1jlz0efOuzLQ=
=AHX0
-----END PGP SIGNATURE-----

--eWbcAUUbgrfSEG1c--
