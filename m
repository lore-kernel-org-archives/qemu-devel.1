Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE81C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C38420797
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HMZdZsuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C38420797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDyit-0001D7-Fi
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 19:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDyhv-0007yL-6A; Thu, 03 Sep 2020 19:31:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37665 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDyhs-0000h9-LM; Thu, 03 Sep 2020 19:31:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BjHBr2Qvtz9sVR; Fri,  4 Sep 2020 09:31:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599175908;
 bh=ZspMruNggOmm5o9UKba321uzji43kUW+aHYg/Dy2vws=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HMZdZsuAnbMSOgbASeSGUT4b5clt7HEGWT4BV/MsuJ3Z6JVcOboZBG5LLHoueCo93
 BSLKmGHr+FN1bVwIDTr7er3GLOg/oBrbdsWOBbU1YSZyH71oVU/t4a/Vc0pM3V+FiH
 MMXBTGb6xrVhWvSsj0JvBN/nCwcvi50qd26vZPrU=
Date: Fri, 4 Sep 2020 09:27:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v3 6/7] spapr_numa: create a vcpu associativity helper
Message-ID: <20200903232708.GD341806@yekko.fritz.box>
References: <20200903220639.563090-1-danielhb413@gmail.com>
 <20200903220639.563090-7-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Content-Disposition: inline
In-Reply-To: <20200903220639.563090-7-danielhb413@gmail.com>
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


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2020 at 07:06:38PM -0300, Daniel Henrique Barboza wrote:
> The work to be done in h_home_node_associativity() intersects
> with what is already done in spapr_numa_fixup_cpu_dt(). This
> patch creates a new helper, spapr_numa_get_vcpu_assoc(), to
> be used for both spapr_numa_fixup_cpu_dt() and
> h_home_node_associativity().
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr_numa.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index d4dca57321..abc7361921 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -71,14 +71,17 @@ void spapr_numa_write_associativity_dt(SpaprMachineSt=
ate *spapr, void *fdt,
>                        sizeof(spapr->numa_assoc_array[nodeid]))));
>  }
> =20
> -int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
> -                            int offset, PowerPCCPU *cpu)
> +static uint32_t *spapr_numa_get_vcpu_assoc(SpaprMachineState *spapr,
> +                                          PowerPCCPU *cpu,
> +                                          uint *vcpu_assoc_size)
>  {
> -    uint vcpu_assoc_size =3D NUMA_ASSOC_SIZE + 1;
> -    uint32_t vcpu_assoc[vcpu_assoc_size];
> +    uint32_t *vcpu_assoc =3D NULL;
>      int index =3D spapr_get_vcpu_id(cpu);
>      int i;
> =20
> +    *vcpu_assoc_size =3D (NUMA_ASSOC_SIZE + 1) * sizeof(uint32_t);
> +    vcpu_assoc =3D g_malloc(*vcpu_assoc_size);
> +
>      /*
>       * VCPUs have an extra 'cpu_id' value in ibm,associativity
>       * compared to other resources. Increment the size at index
> @@ -91,11 +94,22 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr,=
 void *fdt,
>          vcpu_assoc[i] =3D spapr->numa_assoc_array[cpu->node_id][i];
>      }
> =20
> -    vcpu_assoc[vcpu_assoc_size - 1] =3D cpu_to_be32(index);
> +    vcpu_assoc[MAX_DISTANCE_REF_POINTS + 1] =3D cpu_to_be32(index);
> +
> +    return vcpu_assoc;
> +}
> +
> +int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
> +                            int offset, PowerPCCPU *cpu)
> +{
> +    g_autofree uint32_t *vcpu_assoc =3D NULL;
> +    uint vcpu_assoc_size;
> +
> +    vcpu_assoc =3D spapr_numa_get_vcpu_assoc(spapr, cpu, &vcpu_assoc_siz=
e);
> =20
>      /* Advertise NUMA via ibm,associativity */
>      return fdt_setprop(fdt, offset, "ibm,associativity",
> -                       vcpu_assoc, sizeof(vcpu_assoc));
> +                       vcpu_assoc, vcpu_assoc_size);
>  }
> =20
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9Re8wACgkQbDjKyiDZ
s5LQSA/+KNYuGKDDb3FTeFMWuPe1cEVzQ/5dVHx2ztHGSN9+jVCxiw8TCw4olGtl
/Mqk4MrXAJ1zJv59g/PRa3uPLB3cplP1TA0jZsj4W0ATtE5Q7Wh4Vz2VgRRlzppF
glmJDXKhVmwGQvLZHlKSHeqeSCDUMgbP7GozFo+Iu0KMedZPUDBdDLIrwjTticG6
4n7X5U5o1a+KHG+uQ/wPj+ZImIR6NloRs0gIqr/U+57xfNkLaPyaau2kfqXKtMD9
5jCthIXvlBMntIdA8lgKONU4Hvm1eQf1hLPWYi8TlcEb1fy8s2oQuQA06ZsU3PsI
pJ1Hq7D+aKfxUmXDRvU8N+xjh6CugCEDKXYuiljrVLGFBj9TSXEG+L9l2dyOO87a
MlQXJ85lO1+fKumA4nXg0wWKWVJYhdL59jOiT724F/bdjispVpHCyIBrMpHz7NTk
HT4Jdw6vXjEqv8hxjHmXwkZXbjk6qG9/ZawImXyOW/LvNj2B44QbIsWAzllrH6T+
c8tqsqKg3wsWzUvEjy2Tyjmn9CmtcSlJf+G1DDVI2DZMHrMAV0wGEt5C9XU2iYOa
Idb8LSY0x/Xrv5fQN29fcLxrOv28DZjzHTwuFitpdLFfFTfMeE/Dpyiu1aP2314x
R4IbfbzJ5q6ErOLmfKmkUsAxhZRjInL2bDi+6gswdwbViH+ixA8=
=510u
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--

