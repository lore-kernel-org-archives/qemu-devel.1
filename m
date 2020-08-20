Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD525C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 04:00:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90BE20724
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 04:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="O36vQUUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90BE20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8bkT-0007cK-VW
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 00:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8biK-00040c-5H; Wed, 19 Aug 2020 23:58:08 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:48685 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8biF-0007LG-SO; Wed, 19 Aug 2020 23:58:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BX9pt1pv8z9sTb; Thu, 20 Aug 2020 13:57:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597895878;
 bh=D+r9kW29ykdbbTiDlnYJurkPalrmPkOLweppE6OV9Po=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O36vQUUmiB2ywdf6+zv2bOkvDcvkKarCIX9ydpqQm4tHsO5tbrh4r0UB5/hEKFmPu
 s8gmReYpeG1GcFMAhlJ+Nz3Wgr0ydzXUIy+vt/yGhrbhcNjVocQ3Hloge8ziR/rZ3g
 J4FXYeFGO6kbmlIVDR0Kn23732zrSMLV2eMSczqw=
Date: Thu, 20 Aug 2020 13:00:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 07/10] spapr: create helper to set ibm,associativity
Message-ID: <20200820030014.GM271315@yekko.fritz.box>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-8-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yklP1rR72f9kjNtc"
Content-Disposition: inline
In-Reply-To: <20200814205424.543857-8-danielhb413@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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


--yklP1rR72f9kjNtc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2020 at 05:54:21PM -0300, Daniel Henrique Barboza wrote:
> We have several places around hw/ppc files where we use the
> same code to set the ibm,associativity array. This patch
> creates a helper called spapr_set_associativity() to do
> that in a single place. It'll also make it saner to change
> the value of ibm,associativity in the next patches.
>=20
> After this patch, only 2 places are left with open code
> ibm,associativity assignment:
>=20
> - spapr_dt_dynamic_reconfiguration_memory()
> - h_home_node_associativity() in spapr_hcall.c
>=20
> The update of associativity values will be made in these places
> manually later on.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

I like this - any chance you could move this to the front of the
series so that we can make this code easier to follow while we're
still discussing the more meaningful changes?

> ---
>  hw/ppc/spapr.c         | 32 +++++++++++++++++++++-----------
>  hw/ppc/spapr_nvdimm.c  |  8 +++-----
>  hw/ppc/spapr_pci.c     |  8 +++-----
>  include/hw/ppc/spapr.h |  1 +
>  4 files changed, 28 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bc51d2db90..b80a6f6936 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -201,15 +201,27 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int of=
fset, PowerPCCPU *cpu,
>      return ret;
>  }
> =20
> +void spapr_set_associativity(uint32_t *assoc, int node_id, int cpu_index)
> +{
> +    uint8_t assoc_size =3D 0x4;
> +
> +    if (cpu_index >=3D 0) {
> +        assoc_size =3D 0x5;
> +        assoc[5] =3D cpu_to_be32(cpu_index);
> +    }
> +
> +    assoc[0] =3D cpu_to_be32(assoc_size);
> +    assoc[1] =3D cpu_to_be32(0x0);
> +    assoc[2] =3D cpu_to_be32(0x0);
> +    assoc[3] =3D cpu_to_be32(0x0);
> +    assoc[4] =3D cpu_to_be32(node_id);
> +}
> +
>  static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cp=
u)
>  {
>      int index =3D spapr_get_vcpu_id(cpu);
> -    uint32_t associativity[] =3D {cpu_to_be32(0x5),
> -                                cpu_to_be32(0x0),
> -                                cpu_to_be32(0x0),
> -                                cpu_to_be32(0x0),
> -                                cpu_to_be32(cpu->node_id),
> -                                cpu_to_be32(index)};
> +    uint32_t associativity[6];
> +    spapr_set_associativity(associativity, cpu->node_id, index);
> =20
>      /* Advertise NUMA via ibm,associativity */
>      return fdt_setprop(fdt, offset, "ibm,associativity", associativity,
> @@ -325,15 +337,13 @@ static void add_str(GString *s, const gchar *s1)
>  static int spapr_dt_memory_node(void *fdt, int nodeid, hwaddr start,
>                                  hwaddr size)
>  {
> -    uint32_t associativity[] =3D {
> -        cpu_to_be32(0x4), /* length */
> -        cpu_to_be32(0x0), cpu_to_be32(0x0),
> -        cpu_to_be32(0x0), cpu_to_be32(nodeid)
> -    };
> +    uint32_t associativity[5];
>      char mem_name[32];
>      uint64_t mem_reg_property[2];
>      int off;
> =20
> +    spapr_set_associativity(associativity, nodeid, -1);
> +
>      mem_reg_property[0] =3D cpu_to_be64(start);
>      mem_reg_property[1] =3D cpu_to_be64(size);
> =20
> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> index 81410aa63f..bd109bfc00 100644
> --- a/hw/ppc/spapr_nvdimm.c
> +++ b/hw/ppc/spapr_nvdimm.c
> @@ -115,15 +115,13 @@ int spapr_dt_nvdimm(void *fdt, int parent_offset,
>                                               &error_abort);
>      uint64_t slot =3D object_property_get_uint(OBJECT(nvdimm), PC_DIMM_S=
LOT_PROP,
>                                               &error_abort);
> -    uint32_t associativity[] =3D {
> -        cpu_to_be32(0x4), /* length */
> -        cpu_to_be32(0x0), cpu_to_be32(0x0),
> -        cpu_to_be32(0x0), cpu_to_be32(node)
> -    };
> +    uint32_t associativity[5];
>      uint64_t lsize =3D nvdimm->label_size;
>      uint64_t size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_SI=
ZE_PROP,
>                                              NULL);
> =20
> +    spapr_set_associativity(associativity, node, -1);
> +
>      drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
>      g_assert(drc);
> =20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 09ac58fd7f..c02ace226c 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2321,11 +2321,8 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPh=
bState *phb,
>          cpu_to_be32(1),
>          cpu_to_be32(RTAS_IBM_RESET_PE_DMA_WINDOW)
>      };
> -    uint32_t associativity[] =3D {cpu_to_be32(0x4),
> -                                cpu_to_be32(0x0),
> -                                cpu_to_be32(0x0),
> -                                cpu_to_be32(0x0),
> -                                cpu_to_be32(phb->numa_node)};
> +    uint32_t associativity[5];
> +
>      SpaprTceTable *tcet;
>      SpaprDrc *drc;
>      Error *err =3D NULL;
> @@ -2358,6 +2355,7 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhb=
State *phb,
> =20
>      /* Advertise NUMA via ibm,associativity */
>      if (phb->numa_node !=3D -1) {
> +        spapr_set_associativity(associativity, phb->numa_node, -1);
>          _FDT(fdt_setprop(fdt, bus_off, "ibm,associativity", associativit=
y,
>                           sizeof(associativity)));
>      }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index d9f1afa8b2..cd158bf95a 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -863,6 +863,7 @@ int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachine=
State *spapr,
> =20
>  void spapr_rtc_read(SpaprRtcState *rtc, struct tm *tm, uint32_t *ns);
>  int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
> +void spapr_set_associativity(uint32_t *assoc, int node_id, int cpu_index=
);
> =20
>  #define TYPE_SPAPR_RNG "spapr-rng"
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yklP1rR72f9kjNtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl895z4ACgkQbDjKyiDZ
s5I3oBAAsTDfeFOjflm5NrUa0Bl/6zKpbaH69UAtlstnyz0QTXcblQez89cZO5t2
6HuFKw1B4PBGZOxtQV9mgdGGxypD7cdH4n71a96jrhPgMofCFNmpSmJbTVnBiZlA
V7+xGvRm/dl87RTs17Cnjv2EBSa7mroLiSNtb7YDxNvz+fnWgeDeC/QF5vvOoE9j
GcpvN5LCvcO625MJ7es2RxHNKFMkovJQIma7jf5q7zBOvSf3kCpXIAJSmd6mryYt
a+ChhV0qQUVezb9kWftNXcY2oyjLb9XLgdF21gFcWdHYhvSCUHpBWZwVOl7qqAU2
MNZQUeBBVEt/kZVUx+PXkZs4SdGY7HsOEQZO0LGKdeDfN2tGWtFXSHig5pGX4ld6
uff/cLseubPfwjjxm8AfZm6P5zf30QIaAgL3HGFsdCqwQgjclE2nJ8GHn3mlyuFq
lvNlmNWcbyxAXJ0alTou6VA4H1K3lf3Fz6PixTUpdQcu1blXzq795BhN4ae+9SDK
0Lsa1dE8NMi8j1MxEFT+DJYWa+OkBekvNBV9oQ3Rgl2Ovlf73mFV9vmZhuo7VhYu
KFyDPxfliSnuR2/ITgXN1fUJqgMFwempfk56jKweXqq7Uk0sNOBAwVcKz8WvgfXg
A1nqb7HLJyAo9s0jLEnTSfPwFwcWkbL4F0Mk0fF9aLmdyMQPjFw=
=Dmtc
-----END PGP SIGNATURE-----

--yklP1rR72f9kjNtc--

