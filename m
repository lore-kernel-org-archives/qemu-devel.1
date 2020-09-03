Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD5DC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECDE52078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PSuEcnlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDE52078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDyit-0001DS-3V
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 19:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDyhw-0007ye-8U; Thu, 03 Sep 2020 19:31:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39397 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDyhs-0000h7-KB; Thu, 03 Sep 2020 19:31:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BjHBr10f8z9sV8; Fri,  4 Sep 2020 09:31:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599175908;
 bh=joGhEyngvJ8ff5J8G31ISc0o+K9rPfhaDjOH5lEwyFQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PSuEcnlq78floG2YEw9fS3VIgM8RuJCNKsfQlkkEl18UWXweqNHodlhoM5q8DqqDH
 CmkaHJP0dJhYhsSt79eCoflJF7Jx9c3qrp8+jLUdKIQMXzWy0SuFXpgpfWoO4b2r8L
 rzkcHj4PZXi2Jr3ickNa1GBMXzi6jynmUmWp4I+E=
Date: Fri, 4 Sep 2020 09:23:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v3 2/7] spapr, spapr_numa: handle vcpu ibm,associativity
Message-ID: <20200903232346.GB341806@yekko.fritz.box>
References: <20200903220639.563090-1-danielhb413@gmail.com>
 <20200903220639.563090-3-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <20200903220639.563090-3-danielhb413@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 19:31:48
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


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2020 at 07:06:34PM -0300, Daniel Henrique Barboza wrote:
> Vcpus have an additional paramenter to be appended, vcpu_id. This
> also changes the size of the of property itself, which is being
> represented in index 0 of numa_assoc_array[cpu->node_id],
> and defaults to MAX_DISTANCE_REF_POINTS for all cases but
> vcpus.
>=20
> All this logic makes more sense in spapr_numa.c, where we handle
> everything NUMA and associativity. A new helper spapr_numa_fixup_cpu_dt()
> was added, and spapr.c uses it the same way as it was using the former
> spapr_fixup_cpu_numa_dt().
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr.c              | 17 +----------------
>  hw/ppc/spapr_numa.c         | 27 +++++++++++++++++++++++++++
>  include/hw/ppc/spapr_numa.h |  2 ++
>  3 files changed, 30 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1ad6f59863..badfa86319 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -202,21 +202,6 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int off=
set, PowerPCCPU *cpu,
>      return ret;
>  }
> =20
> -static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cp=
u)
> -{
> -    int index =3D spapr_get_vcpu_id(cpu);
> -    uint32_t associativity[] =3D {cpu_to_be32(0x5),
> -                                cpu_to_be32(0x0),
> -                                cpu_to_be32(0x0),
> -                                cpu_to_be32(0x0),
> -                                cpu_to_be32(cpu->node_id),
> -                                cpu_to_be32(index)};
> -
> -    /* Advertise NUMA via ibm,associativity */
> -    return fdt_setprop(fdt, offset, "ibm,associativity", associativity,
> -                          sizeof(associativity));
> -}
> -
>  static void spapr_dt_pa_features(SpaprMachineState *spapr,
>                                   PowerPCCPU *cpu,
>                                   void *fdt, int offset)
> @@ -785,7 +770,7 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int=
 offset,
>                        pft_size_prop, sizeof(pft_size_prop))));
> =20
>      if (ms->numa_state->num_nodes > 1) {
> -        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu));
> +        _FDT(spapr_numa_fixup_cpu_dt(spapr, fdt, offset, cpu));
>      }
> =20
>      _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index f6b6fe648f..1a1ec8bcff 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -45,6 +45,33 @@ void spapr_numa_write_associativity_dt(SpaprMachineSta=
te *spapr, void *fdt,
>                        sizeof(spapr->numa_assoc_array[nodeid]))));
>  }
> =20
> +int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
> +                            int offset, PowerPCCPU *cpu)
> +{
> +    uint vcpu_assoc_size =3D NUMA_ASSOC_SIZE + 1;
> +    uint32_t vcpu_assoc[vcpu_assoc_size];
> +    int index =3D spapr_get_vcpu_id(cpu);
> +    int i;
> +
> +    /*
> +     * VCPUs have an extra 'cpu_id' value in ibm,associativity
> +     * compared to other resources. Increment the size at index
> +     * 0, copy all associativity domains already set, then put
> +     * cpu_id last.
> +     */
> +    vcpu_assoc[0] =3D cpu_to_be32(MAX_DISTANCE_REF_POINTS + 1);
> +
> +    for (i =3D 1; i <=3D MAX_DISTANCE_REF_POINTS; i++) {
> +        vcpu_assoc[i] =3D spapr->numa_assoc_array[cpu->node_id][i];
> +    }

You could use a single memcpy() here as well.

> +
> +    vcpu_assoc[vcpu_assoc_size - 1] =3D cpu_to_be32(index);
> +
> +    /* Advertise NUMA via ibm,associativity */
> +    return fdt_setprop(fdt, offset, "ibm,associativity",
> +                       vcpu_assoc, sizeof(vcpu_assoc));
> +}
> +
>  /*
>   * Helper that writes ibm,associativity-reference-points and
>   * max-associativity-domains in the RTAS pointed by @rtas
> diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
> index a2a4df55f7..43c6a16fe3 100644
> --- a/include/hw/ppc/spapr_numa.h
> +++ b/include/hw/ppc/spapr_numa.h
> @@ -27,5 +27,7 @@ void spapr_numa_associativity_init(SpaprMachineState *s=
papr,
>  void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int r=
tas);
>  void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *f=
dt,
>                                         int offset, int nodeid);
> +int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
> +                            int offset, PowerPCCPU *cpu);
> =20
>  #endif /* HW_SPAPR_NUMA_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9RewIACgkQbDjKyiDZ
s5JZ9A/8CSIfCwfwPffrjHG951S2DVRW3/6rtd9UmV3SEdN/J64IyT65m14inwle
t4Q+RdvDRrCMUPA0uC+cc0VUyHyqdynWQZuprB7l+WLhpiHljoxV8qHCqI5Ivv92
UfXDQgq8wnCeeCP48kkyTKtxqk3jm6U+VLGkP8g3m4zVV+S85vuAt9pd7WQuLuCH
iu5QTToJCRU7Qp6qaBDkJ5EImv0NEwikfjJesdS9BAjAjfLlbmR720MnWcsQhRAa
YfHdYGyUc1wveEF4QzS9io1EIlAuoSKx5rpxi+lDiHtI6yjeRw8J/LegIG/fYPfL
vjxaTuv8mMTCXmAFIEb+hsxDJlUHmEKuCmcSSY59f9fsI3yVJa1jCIBCzgDwSLwA
Xr/hm+8REI+K94Maw+GoeLgFMK5R1LLDJ8zCyMtJXsHFVIu8jQpqW7iM5LEVzuKI
tTK3bNveyhfSkbDWl8vpeneu4XSPH+bCmv8E1hsxZ/9QK9KjgBzA+VBK0bMzqi3R
3RDekSC+U4e4xHzTC5sLOZAei493StmfbL+mZFl5LtDu+vetcibmEuFy5eJG1I8b
wO0w9Z1+3RkEPghus0pS+M/tJNL6sSjU6XR0H4KiQSymxblkg0LzECCe0X+Kp+OB
UDL7BgOT7KNejaWcGI7jx7lctOtgdvkfilxlW1reNPxRwceP62M=
=hvDW
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--

