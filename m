Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B02C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 01:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D18B2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 01:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZyieXCoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D18B2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDeXL-0005CL-QS
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 21:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDeUq-0000Bj-NV; Wed, 02 Sep 2020 21:57:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36757 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDeUo-0005dE-HZ; Wed, 02 Sep 2020 21:57:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BhkSd3gTGz9sTq; Thu,  3 Sep 2020 11:56:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599098209;
 bh=mgU/4xDnjO0LsGIQcsn1ZuhyrwRQxHyvp1EwKAFje+g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZyieXCoM9NGzTaS2EMt+9oZ6iKhhau3WBfeBW+ObHS4POVPgIcc5lfx4p4tmzctar
 DAA+9g1G/mBsmSDhKEoT1AbmIZzkdk9zgQoTjkcV85pghrAJckoXJadD6O3P0Ti4GP
 XgDy5Vcxtz8io0/HHTQAXCIQgkqVTYIjNRZA2USE=
Date: Thu, 3 Sep 2020 11:56:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 6/7] spapr_numa: move NVLink2 associativity handling
 to spapr_numa.c
Message-ID: <20200903015632.GL1897@yekko.fritz.box>
References: <20200901125645.118026-1-danielhb413@gmail.com>
 <20200901125645.118026-7-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WkHPBKJ2pKcVUM5H"
Content-Disposition: inline
In-Reply-To: <20200901125645.118026-7-danielhb413@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 20:05:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WkHPBKJ2pKcVUM5H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 09:56:44AM -0300, Daniel Henrique Barboza wrote:
> This patch adds a new spapr_numa_write_assoc_nvlink2() helper
> to handle the ibm,associativity for NVLink2 GPUs.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

It might be nice to "precompute" the assoc arrays for the gpus as you
now do for the regular numa nodes.  That can be a later revision, though.

> ---
>  hw/ppc/spapr_numa.c         | 23 +++++++++++++++++++++++
>  hw/ppc/spapr_pci_nvlink2.c  | 19 ++-----------------
>  include/hw/ppc/spapr_numa.h |  3 +++
>  3 files changed, 28 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 9eb4bdbe80..785cc24624 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -15,6 +15,8 @@
>  #include "hw/ppc/spapr_numa.h"
>  #include "hw/ppc/fdt.h"
> =20
> +/* Moved from hw/ppc/spapr_pci_nvlink2.c */
> +#define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
> =20
>  void spapr_numa_associativity_init(MachineState *machine)
>  {
> @@ -114,6 +116,27 @@ int spapr_numa_write_assoc_lookup_arrays(SpaprMachin=
eState *spapr, void *fdt,
>      return ret;
>  }
> =20
> +void spapr_numa_write_assoc_nvlink2(void *fdt, int offset, int numa_id,
> +                                    SpaprPhbState *sphb)
> +{
> +    uint32_t associativity[NUMA_ASSOC_SIZE];
> +    int i;
> +
> +    associativity[0] =3D cpu_to_be32(MAX_DISTANCE_REF_POINTS);
> +    for (i =3D 1; i < NUMA_ASSOC_SIZE; i++) {
> +        associativity[i] =3D cpu_to_be32(numa_id);
> +    };
> +
> +    if (sphb->pre_5_1_assoc) {
> +        associativity[1] =3D SPAPR_GPU_NUMA_ID;
> +        associativity[2] =3D SPAPR_GPU_NUMA_ID;
> +        associativity[3] =3D SPAPR_GPU_NUMA_ID;
> +    }
> +
> +    _FDT((fdt_setprop(fdt, offset, "ibm,associativity", associativity,
> +                      sizeof(associativity))));
> +}
> +
>  /*
>   * Helper that writes ibm,associativity-reference-points and
>   * max-associativity-domains in the RTAS pointed by @rtas
> diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
> index 76ae77ebc8..662a0af990 100644
> --- a/hw/ppc/spapr_pci_nvlink2.c
> +++ b/hw/ppc/spapr_pci_nvlink2.c
> @@ -29,6 +29,7 @@
>  #include "qemu/error-report.h"
>  #include "hw/ppc/fdt.h"
>  #include "hw/pci/pci_bridge.h"
> +#include "hw/ppc/spapr_numa.h"
> =20
>  #define PHANDLE_PCIDEV(phb, pdev)    (0x12000000 | \
>                                       (((phb)->index) << 16) | ((pdev)->d=
evfn))
> @@ -37,8 +38,6 @@
>  #define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) << 8)=
 | \
>                                       ((gn) << 4) | (nn))
> =20
> -#define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
> -
>  typedef struct SpaprPhbPciNvGpuSlot {
>          uint64_t tgt;
>          uint64_t gpa;
> @@ -360,13 +359,6 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *=
sphb, void *fdt)
>          Object *nv_mrobj =3D object_property_get_link(OBJECT(nvslot->gpd=
ev),
>                                                      "nvlink2-mr[0]",
>                                                      &error_abort);
> -        uint32_t associativity[] =3D {
> -            cpu_to_be32(0x4),
> -            cpu_to_be32(nvslot->numa_id),
> -            cpu_to_be32(nvslot->numa_id),
> -            cpu_to_be32(nvslot->numa_id),
> -            cpu_to_be32(nvslot->numa_id)
> -        };
>          uint64_t size =3D object_property_get_uint(nv_mrobj, "size", NUL=
L);
>          uint64_t mem_reg[2] =3D { cpu_to_be64(nvslot->gpa), cpu_to_be64(=
size) };
>          char *mem_name =3D g_strdup_printf("memory@%"PRIx64, nvslot->gpa=
);
> @@ -376,14 +368,7 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *=
sphb, void *fdt)
>          _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
>          _FDT((fdt_setprop(fdt, off, "reg", mem_reg, sizeof(mem_reg))));
> =20
> -        if (sphb->pre_5_1_assoc) {
> -            associativity[1] =3D SPAPR_GPU_NUMA_ID;
> -            associativity[2] =3D SPAPR_GPU_NUMA_ID;
> -            associativity[3] =3D SPAPR_GPU_NUMA_ID;
> -        }
> -
> -        _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativity,
> -                          sizeof(associativity))));
> +        spapr_numa_write_assoc_nvlink2(fdt, off, nvslot->numa_id, sphb);
> =20
>          _FDT((fdt_setprop_string(fdt, off, "compatible",
>                                   "ibm,coherent-device-memory")));
> diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
> index f6127501a6..b6e0721b07 100644
> --- a/include/hw/ppc/spapr_numa.h
> +++ b/include/hw/ppc/spapr_numa.h
> @@ -15,6 +15,7 @@
> =20
>  #include "hw/boards.h"
>  #include "hw/ppc/spapr.h"
> +#include "hw/pci-host/spapr.h"
> =20
>  void spapr_numa_associativity_init(MachineState *machine);
>  void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int r=
tas);
> @@ -24,6 +25,8 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, v=
oid *fdt,
>                              int offset, PowerPCCPU *cpu);
>  int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void =
*fdt,
>                                           int offset);
> +void spapr_numa_write_assoc_nvlink2(void *fdt, int offset, int numa_id,
> +                                    SpaprPhbState *sphb);
> =20
> =20
>  #endif /* HW_SPAPR_NUMA_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WkHPBKJ2pKcVUM5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9QTVAACgkQbDjKyiDZ
s5LngA//V8X1QSrbh/r1qv6RRuG7hrDaUZ9FLSY+2qT11ZlepxS0xevfWgUflYFQ
raNIhFAPqNNrNYq498v2B7H/2ulr16DL8XvEcszi7KEoKItUxe3hpeHI6rrD+9sT
v59bGYRJbRPXz5N7lQd71MQCgLMtXYrJ3C4uL3gLtaqhJ79BjaZB923q8neE4oZg
9nygDllBsGtV/tLbbX5uz/dBi532GYb9EOhMaSYbAz666un9KiaQl/gulGqoxeHM
SVF/8mI9ZBEOggCUHmRk1PbDQVWtDCeU8/Q494hS36XJk3WHYv51YZZ5gJHmMoPL
6oKn75XgWy8avnKKgLXHSiuDG9hROThKFkxU+LqMmZ9iK4s9bO8Z8sLPL3BdXeXJ
V4b2hwecSatYAPFsOR0eTfrAFRJS5IaZ9NjTA46X1ctWLsH9cFfchGnKus5ZGFdg
IFxm0uUXVGCMc3RneMmkBb9BnvHRdJIEcK1ocJFRszgQ0eGVvNIXpBBhcPmELVxM
Vrw40eoOxE4KA4UCOMvicBK5ztA257Bicc6drFqK3wMtsg/hVktjwEN1+CA7mJoL
Mjz9OXzJr1II9WFoIoQF5M/HT1ozqOfgMVyf77ZsZ/4gvHZhAv0ylCOWPC0hcaG5
QhKr6+OLuA+ui5JI0IC5CdSyfyM0jE4OfkM7BEO2q7R67P/v7i0=
=16o6
-----END PGP SIGNATURE-----

--WkHPBKJ2pKcVUM5H--

