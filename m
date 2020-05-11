Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9D3C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143F0207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QZhc36X1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143F0207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY266-00039E-7P
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 02:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jY23b-0007uU-8z; Mon, 11 May 2020 02:36:55 -0400
Received: from ozlabs.org ([203.11.71.1]:59519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jY23Z-000744-5V; Mon, 11 May 2020 02:36:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49LB6k4wqbz9sT8; Mon, 11 May 2020 16:36:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589179006;
 bh=T1NDT/vJJZiLN9+DqFfiBJD8XAlVNNKrDy7TbV2ti6c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QZhc36X1fhm2uic7M08TExZiYEUqlgY+XKEvX3trMNNSvGFRANoN3L58rhhxSIm9/
 gCO62zA/vcbgbjPwnRBTps+C1C6PnmGHYHzo4WKgJ2wZXwOlDXDmxa/K/Knk1ro/ba
 wcKXF3S2WIRv1nQksPKiD+/YxYYqn7qsAJv01qLY=
Date: Mon, 11 May 2020 16:17:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Reza Arbab <arbab@linux.ibm.com>
Subject: Re: [PATCH] spapr: Add a new level of NUMA for GPUs
Message-ID: <20200511061745.GP2183@umbus.fritz.box>
References: <20200508175927.21791-1-arbab@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zn4k3Q+N5puqXur4"
Content-Disposition: inline
In-Reply-To: <20200508175927.21791-1-arbab@linux.ibm.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:36:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Daniel Henrique Barboza <danielhb@linux.ibm.com>,
 Leonardo Augusto Guimaraes Garcia <lagarcia@linux.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--zn4k3Q+N5puqXur4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2020 at 12:59:27PM -0500, Reza Arbab wrote:
> NUMA nodes corresponding to GPU memory currently have the same
> affinity/distance as normal memory nodes. Add a third NUMA associativity
> reference point enabling us to give GPU nodes more distance.
>=20
> Before, `numactl -H` output in a guest with 4 GPUs (nodes 2-5):
>=20
> node distances:
> node   0   1   2   3   4   5
>   0:  10  40  40  40  40  40
>   1:  40  10  40  40  40  40
>   2:  40  40  10  40  40  40
>   3:  40  40  40  10  40  40
>   4:  40  40  40  40  10  40
>   5:  40  40  40  40  40  10
>=20
> After:
>=20
> node distances:
> node   0   1   2   3   4   5
>   0:  10  40  80  80  80  80
>   1:  40  10  80  80  80  80
>   2:  80  80  10  80  80  80
>   3:  80  80  80  10  80  80
>   4:  80  80  80  80  10  80
>   5:  80  80  80  80  80  10
>=20
> These are the same distances as on the host, mirroring the change made
> to host firmware in skiboot commit f845a648b8cb ("numa/associativity:
> Add a new level of NUMA for GPU's").

Urgh.  I have a numnber of thoughts on this.

1)

This would all be much simpler, if PAPR's representation of NUMA
distances weren't so awful.  Somehow it manages to be both so complex
that it's very hard to understand, and yet very limited in that it
has no way to represent distances in any absolute units, or even
specific ratios between distances.

Both qemu and the guest kernel can have an arbitrary set of nodes,
with an arbitrary matrix of distances between each pair, which we then
have to lossily encode into this PAPR nonsense.

2)

Alas, I don't think we can simply change this information.  We'll have
to do it conditionally on a new machine type.  This is guest visible
information, which shouldn't change under a running guest across
migration between different qemu versions.  At least for Linux guests
we'd probably get away with it, since I think it only reads this info
at boot, and across a migration we'd at worst get non-optimal
behaviour, not actual breakage.

Still, I'd need a stronger case than "probably won't break" before
breaking our rules about guest environment stability within a machine
type.

3)

I'm not sure that this version is totally correct w.r.t. PAPR.  But
then, I'm also not really sure of that for the existing version.
Specifically it's not at all clear from PAPR if the IDs used at each
level of the ibm,associativity need to be:
   a) globally unique
   b) unique only within the associativity level they appear at
or c) unique only within the "node" at the next higher level they
      belong to

4)

I'm not totally clear on the rationale for using the individual gpu's
numa ID at all levels, rather than just one.  I'm guessing this is so
that the gpu memory blocks are distant from each other as well as
distant from main memory.  Is that right?

> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> ---
>  hw/ppc/spapr.c             | 6 +++++-
>  hw/ppc/spapr_pci_nvlink2.c | 8 +++-----
>  2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c18eab0a2305..53567f98f0c6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -892,7 +892,11 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, =
void *fdt)
>      int rtas;
>      GString *hypertas =3D g_string_sized_new(256);
>      GString *qemu_hypertas =3D g_string_sized_new(256);
> -    uint32_t refpoints[] =3D { cpu_to_be32(0x4), cpu_to_be32(0x4) };
> +    uint32_t refpoints[] =3D {
> +        cpu_to_be32(0x4),
> +        cpu_to_be32(0x4),
> +        cpu_to_be32(0x2),
> +    };
>      uint64_t max_device_addr =3D MACHINE(spapr)->device_memory->base +
>          memory_region_size(&MACHINE(spapr)->device_memory->mr);
>      uint32_t lrdr_capacity[] =3D {
> diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
> index 8332d5694e46..f2cb26019e88 100644
> --- a/hw/ppc/spapr_pci_nvlink2.c
> +++ b/hw/ppc/spapr_pci_nvlink2.c
> @@ -37,8 +37,6 @@
>  #define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) << 8)=
 | \
>                                       ((gn) << 4) | (nn))
> =20
> -#define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
> -
>  typedef struct SpaprPhbPciNvGpuSlot {
>          uint64_t tgt;
>          uint64_t gpa;
> @@ -361,9 +359,9 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *s=
phb, void *fdt)
>                                                      "nvlink2-mr[0]", NUL=
L);
>          uint32_t associativity[] =3D {
>              cpu_to_be32(0x4),
> -            SPAPR_GPU_NUMA_ID,
> -            SPAPR_GPU_NUMA_ID,
> -            SPAPR_GPU_NUMA_ID,
> +            cpu_to_be32(nvslot->numa_id),
> +            cpu_to_be32(nvslot->numa_id),
> +            cpu_to_be32(nvslot->numa_id),
>              cpu_to_be32(nvslot->numa_id)
>          };
>          uint64_t size =3D object_property_get_uint(nv_mrobj, "size", NUL=
L);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zn4k3Q+N5puqXur4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl647gYACgkQbDjKyiDZ
s5JVQxAAkWOOYDiK0vnc1Qh+2ZxiS1wshiDBBYVDbzWTc0+4cDQRe7b/NSu3DGkv
nGZJUR/t8PS/v1echmhAoJBFm4i6tuFuBlmBra13KzJetFZKMdPJS97PoCxD2XsQ
aua7mt5nhyYaoqUzN7Ue8XJSg6gwfy8iwPzGaX6QBwTjjNwYZtePpkxo0RLmeHHF
epaVtf1+vErKDLbOuJLPcu2LYOaSqZ3GsacW2NjAwO7KIJ3egfKwzIY44j6OsJEL
Y8am9iaZ27eVp0IDAxFbQnrjx/OkWiHe3sLJWXaK1F4HVgtkbL07QfwxzId4fUp0
z5lJclfeS8lNnDA3X+CqWuGzhY/W8rb2yGoc0q0hAGZmCW0B3okgIZyeyiX1N8x1
zlalfXB/i0gmt64XflPcAhMN7MzJU4aNfCNpvVSWXr50TJPkoHjw4tJhDeM4ZxMa
+Myds+sklOSzguYT3uQ0W1yvAazhAAJrlVCRGZBvJ17jpAB1KnjMoncpAzf+sEwG
uuzuLQSvB5mgfDnhmorg2vi3WbjvM+ztANLNqlDo+bvkXl7489o/b9KFeAFxDnWn
eh6fsoAQ9GHAKtt40m+kPdm9TT3dCaIyW/17Ao58fblpc9CI21EcJs03Zn/z53pY
sgI3Ak8+KCt3RFbOy7RsRmY5WGqdDoHLsoVpQ0VepaBdPRXtN+c=
=SiDq
-----END PGP SIGNATURE-----

--zn4k3Q+N5puqXur4--

