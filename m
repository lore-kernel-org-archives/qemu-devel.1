Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB57C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 06:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2AF320748
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 06:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="d3JavGW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AF320748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE577-0003Ez-27
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 02:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE55c-0001mU-6P; Fri, 04 Sep 2020 02:20:49 -0400
Received: from ozlabs.org ([203.11.71.1]:49951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE55W-00062p-RY; Fri, 04 Sep 2020 02:20:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BjSGY2FrWz9sVB; Fri,  4 Sep 2020 16:20:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599200437;
 bh=9GqHTDLobR0jWc7MzR/l0USSH3hKb109jmAMesbL5LY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d3JavGW2xaQ1TBRwwML1MHGTF2cscRtKN4qyTxlp1YEcADF7PUT4XEB7gvIQXa4Y8
 3wlrf5H456U2H2NFWkFZGFGiefFePmNMZzKPFVecXADPpKY8/mzMBzIcvxYj+I3zdS
 Qf54DKBoKH95dfOssIeFQYvsTusj5fHxBENDT8AY=
Date: Fri, 4 Sep 2020 14:10:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v4 2/3] spapr_numa: create a vcpu associativity helper
Message-ID: <20200904041033.GG341806@yekko.fritz.box>
References: <20200904010439.581957-1-danielhb413@gmail.com>
 <20200904010439.581957-3-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6BvahUXLYAruDZOj"
Content-Disposition: inline
In-Reply-To: <20200904010439.581957-3-danielhb413@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 02:20:37
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


--6BvahUXLYAruDZOj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2020 at 10:04:38PM -0300, Daniel Henrique Barboza wrote:
> The work to be done in h_home_node_associativity() intersects
> with what is already done in spapr_numa_fixup_cpu_dt(). This
> patch creates a new helper, spapr_numa_get_vcpu_assoc(), to
> be used for both spapr_numa_fixup_cpu_dt() and
> h_home_node_associativity().
>=20
> While we're at it, use memcpy() instead of loop assignment
> to created the returned array.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr_numa.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 368c1a494d..980a6488bf 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -71,13 +71,15 @@ void spapr_numa_write_associativity_dt(SpaprMachineSt=
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
> -    int i;
> +
> +    *vcpu_assoc_size =3D (NUMA_ASSOC_SIZE + 1) * sizeof(uint32_t);
> +    vcpu_assoc =3D g_malloc(*vcpu_assoc_size);
> =20
>      /*
>       * VCPUs have an extra 'cpu_id' value in ibm,associativity
> @@ -86,16 +88,24 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr,=
 void *fdt,
>       * cpu_id last.
>       */
>      vcpu_assoc[0] =3D cpu_to_be32(MAX_DISTANCE_REF_POINTS + 1);
> +    memcpy(vcpu_assoc + 1, spapr->numa_assoc_array[cpu->node_id],
> +           MAX_DISTANCE_REF_POINTS);

That needs to be MAX_DISTANCE_REF_POINTS * sizeof(uint32_t), doesn't it?

> +    vcpu_assoc[MAX_DISTANCE_REF_POINTS + 1] =3D cpu_to_be32(index);
> =20
> -    for (i =3D 1; i <=3D MAX_DISTANCE_REF_POINTS; i++) {
> -        vcpu_assoc[i] =3D spapr->numa_assoc_array[cpu->node_id][i];
> -    }
> +    return vcpu_assoc;
> +}
> +
> +int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
> +                            int offset, PowerPCCPU *cpu)
> +{
> +    g_autofree uint32_t *vcpu_assoc =3D NULL;
> +    uint vcpu_assoc_size;
> =20
> -    vcpu_assoc[vcpu_assoc_size - 1] =3D cpu_to_be32(index);
> +    vcpu_assoc =3D spapr_numa_get_vcpu_assoc(spapr, cpu, &vcpu_assoc_siz=
e);
> =20
>      /* Advertise NUMA via ibm,associativity */
>      return fdt_setprop(fdt, offset, "ibm,associativity",
> -                       vcpu_assoc, sizeof(vcpu_assoc));
> +                       vcpu_assoc, vcpu_assoc_size);>  }
> =20
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6BvahUXLYAruDZOj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9RvjkACgkQbDjKyiDZ
s5KZvQ/+PjB2SEUexsoNVf9PoB+U6kun3qxlWoj9WjJzQOfrJOvfAN6o5+D2NnNS
rrbiGsCGShqleuSMexgx6dvQJUy1exddl69Y6N/+Y0ACcjiQSCUFVOp2dbiVe3mo
FRN7kQADh/vvoqeqs9+5ywfMZsyiWUxDgiyB4qUsiKSJo6yld7mgrlJXyCzjqtbO
L3jnFUg+gK7p4Fw8lPjAJ19OxFOXmSMH1EiVsE3bEfjQr445M2arm6ZbvZ30Nn/0
gH2ToJRpYBDppjCANG+YlJU8pGVZo6W0Gxm1nuuWY3p7g6IQ5XSDkRdb5nChCENv
lK+uoSdEvAVgpIigQSLAlsazNgle3dCBrhswGRm8XKEPLPbm771eex/QY8vV0DTZ
cwjZXOX0sqmNoFvTCY6ACyAeIb4fE7ilIHCX38ZFSd6EchuKKWFaNZ9OcSEmsYQj
BilfXM78JNoKkskj7jzPdpH9T5SK9MDNLQliWn8/iYUx/2/v/VQ+suLcdx9HLEZ4
3fsGIBYjgYBwBYbfngqi+HkWwIcas+BU8QlL6GV8STnmNkonMVSgkJUSs2l8h6pF
U/v/nd4ayodKnN+EF+rszhvJgVgX5sr4DnJ0qNO4P6FPbpTFxyQz03rqy6l4XB3a
SPZkYoWDtDAROLeSB79+mD0ylMpSCw52weFCyjzcloq4VFpGFNc=
=r4Xt
-----END PGP SIGNATURE-----

--6BvahUXLYAruDZOj--

