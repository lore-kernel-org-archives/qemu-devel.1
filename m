Received: from eggs.gnu.org ([2001:4830:134:3::10]:56714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dzOIh-0001n6-5I
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dzOIb-00054E-JI
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:35:59 -0400
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:37973)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dzOIb-00052N-Ch
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:35:53 -0400
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 1E6B0C107F
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 16:35:50 +0200 (CEST)
References: <150703999112.6139.714822137654210421.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <64737097-ecb3-a2d1-4858-eb15e5abb9d3@kaod.org>
Date: Tue, 3 Oct 2017 16:35:43 +0200
MIME-Version: 1.0
In-Reply-To: <150703999112.6139.714822137654210421.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/ppc: use 0 instead of
 fdt_path_offset(fdt, "/")
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 10/03/2017 04:13 PM, Greg Kurz wrote:
> The offset of the root node is guaranteed to be 0.
>=20
> This doesn't fix anything, it's just trivial cleanup of the two
> remaining places where this was done under hw/ppc.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Looks good to me.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/pnv.c   |    3 +--
>  hw/ppc/spapr.c |    3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index d46d91c76f5c..84b2389ea60b 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -92,8 +92,7 @@ static int get_cpus_node(void *fdt)
>      int cpus_offset =3D fdt_path_offset(fdt, "/cpus");
> =20
>      if (cpus_offset < 0) {
> -        cpus_offset =3D fdt_add_subnode(fdt, fdt_path_offset(fdt, "/")=
,
> -                                      "cpus");
> +        cpus_offset =3D fdt_add_subnode(fdt, 0, "cpus");
>          if (cpus_offset) {
>              _FDT((fdt_setprop_cell(fdt, cpus_offset, "#address-cells",=
 0x1)));
>              _FDT((fdt_setprop_cell(fdt, cpus_offset, "#size-cells", 0x=
0)));
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ff87f155d55e..352ff3d614e8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -353,8 +353,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachi=
neState *spapr)
> =20
>          cpus_offset =3D fdt_path_offset(fdt, "/cpus");
>          if (cpus_offset < 0) {
> -            cpus_offset =3D fdt_add_subnode(fdt, fdt_path_offset(fdt, =
"/"),
> -                                          "cpus");
> +            cpus_offset =3D fdt_add_subnode(fdt, 0, "cpus");
>              if (cpus_offset < 0) {
>                  return cpus_offset;
>              }
>=20
