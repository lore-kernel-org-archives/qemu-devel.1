Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C78C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 06:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00063206E7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 06:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dBMNFZQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00063206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE570-00034A-4u
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 02:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE55a-0001mF-Fh; Fri, 04 Sep 2020 02:20:47 -0400
Received: from ozlabs.org ([203.11.71.1]:34085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE55W-00062o-TR; Fri, 04 Sep 2020 02:20:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BjSGX60NNz9sVL; Fri,  4 Sep 2020 16:20:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599200436;
 bh=2fjkLzaaVrzTd6IWUUjGSyxMoluSR0Q9UY7POP7WasI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dBMNFZQSAyB+8QS1DXiGH5zgJUHX9liTab97B7oVWzvbbnzpDaOaiLrVBcivQ/uTX
 acfzzJNwWdtAKjy6eW4pLiztVzezFczJa87EZEyi6dGlCUqq/BSMcsGPQcJAfqwDFa
 MDvQB5hkGRDnwuVN06wrF4l4AmR3rOpM+Ta15cgo=
Date: Fri, 4 Sep 2020 14:09:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v4 1/3] spapr: move h_home_node_associativity to
 spapr_numa.c
Message-ID: <20200904040942.GF341806@yekko.fritz.box>
References: <20200904010439.581957-1-danielhb413@gmail.com>
 <20200904010439.581957-2-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aZoGpuMECXJckB41"
Content-Disposition: inline
In-Reply-To: <20200904010439.581957-2-danielhb413@gmail.com>
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


--aZoGpuMECXJckB41
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2020 at 10:04:37PM -0300, Daniel Henrique Barboza wrote:
> The implementation of this hypercall will be modified to use
> spapr->numa_assoc_arrays input. Moving it to spapr_numa.c makes
> make more sense.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Applied to ppc-for-5.2 (though it missed today's pull request, sorry).

> ---
>  hw/ppc/spapr_hcall.c | 40 ---------------------------------------
>  hw/ppc/spapr_numa.c  | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 40 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index c1d01228c6..c2776b6a7d 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1873,42 +1873,6 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      return ret;
>  }
> =20
> -static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
> -                                              SpaprMachineState *spapr,
> -                                              target_ulong opcode,
> -                                              target_ulong *args)
> -{
> -    target_ulong flags =3D args[0];
> -    target_ulong procno =3D args[1];
> -    PowerPCCPU *tcpu;
> -    int idx;
> -
> -    /* only support procno from H_REGISTER_VPA */
> -    if (flags !=3D 0x1) {
> -        return H_FUNCTION;
> -    }
> -
> -    tcpu =3D spapr_find_cpu(procno);
> -    if (tcpu =3D=3D NULL) {
> -        return H_P2;
> -    }
> -
> -    /* sequence is the same as in the "ibm,associativity" property */
> -
> -    idx =3D 0;
> -#define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
> -                             ((uint64_t)(b) & 0xffffffff))
> -    args[idx++] =3D ASSOCIATIVITY(0, 0);
> -    args[idx++] =3D ASSOCIATIVITY(0, tcpu->node_id);
> -    args[idx++] =3D ASSOCIATIVITY(procno, -1);
> -    for ( ; idx < 6; idx++) {
> -        args[idx] =3D -1;
> -    }
> -#undef ASSOCIATIVITY
> -
> -    return H_SUCCESS;
> -}
> -
>  static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
>                                                SpaprMachineState *spapr,
>                                                target_ulong opcode,
> @@ -2139,10 +2103,6 @@ static void hypercall_register_types(void)
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
> =20
>      spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
> -
> -    /* Virtual Processor Home Node */
> -    spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
> -                             h_home_node_associativity);
>  }
> =20
>  type_init(hypercall_register_types)
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 93a000b729..368c1a494d 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -165,3 +165,48 @@ void spapr_numa_write_rtas_dt(SpaprMachineState *spa=
pr, void *fdt, int rtas)
>      _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
>                       maxdomains, sizeof(maxdomains)));
>  }
> +
> +static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
> +                                              SpaprMachineState *spapr,
> +                                              target_ulong opcode,
> +                                              target_ulong *args)
> +{
> +    target_ulong flags =3D args[0];
> +    target_ulong procno =3D args[1];
> +    PowerPCCPU *tcpu;
> +    int idx;
> +
> +    /* only support procno from H_REGISTER_VPA */
> +    if (flags !=3D 0x1) {
> +        return H_FUNCTION;
> +    }
> +
> +    tcpu =3D spapr_find_cpu(procno);
> +    if (tcpu =3D=3D NULL) {
> +        return H_P2;
> +    }
> +
> +    /* sequence is the same as in the "ibm,associativity" property */
> +
> +    idx =3D 0;
> +#define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
> +                             ((uint64_t)(b) & 0xffffffff))
> +    args[idx++] =3D ASSOCIATIVITY(0, 0);
> +    args[idx++] =3D ASSOCIATIVITY(0, tcpu->node_id);
> +    args[idx++] =3D ASSOCIATIVITY(procno, -1);
> +    for ( ; idx < 6; idx++) {
> +        args[idx] =3D -1;
> +    }
> +#undef ASSOCIATIVITY
> +
> +    return H_SUCCESS;
> +}
> +
> +static void spapr_numa_register_types(void)
> +{
> +    /* Virtual Processor Home Node */
> +    spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
> +                             h_home_node_associativity);
> +}
> +
> +type_init(spapr_numa_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aZoGpuMECXJckB41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9RvgQACgkQbDjKyiDZ
s5Kfvw/+MiRYTndBGvBWbvpWDOdp/7GdCyGfqxXvzidyV3hEN6x+qpguzO0A+RBU
P+UibhOzxAOjKMsu8Xiw0C9rrTgXG/lZzCpOc7Sm5nbRyQ+WJxEnLLJsvmRohZXR
J0PyXCWbbKznXkgjAA3CNgOeuzQLuzUZdTNcwmlCbHJUn35zGGlb8TmFHo21zsiT
DP8waNH9nlsf2/Z1MwFvHB/MGkJGJvmkDXsVGf0oCatjLF9cGFnGnz215ovYL84c
zu1PWenfxG9+5LY6ct2Mlbnx8xtAGYC0KlxS0SdCB5UOX7nlkNfB9JrMPhzNE74w
VOLGxkyGgMYtUWmYVbC+hpNDBMtldyHdPc8nMg50yaVuRclMrWJ3ScMcN+a33wHg
yFJkZ+M3FcnrHSRJ7tlYLQoJYARI2f5or91Q4SLPprjzuY8zPrH8av9+cpu1bJpK
ttMQveK6E/42XzHAG2Nv1p1lL158w7cViL0hTNzU46ac9swx21+yzHWaGKPls37B
WBSlOPRcT1W9RD66roSs5KDGJ2UI27RKrRcxnTP9sYqJ/7HIjHtnqq8rrx/Ub4ox
deNHVdQuGKewKB8HlRqLwuLa+SZVZWdvbDJJKwnZB9EspHXn11DZSfpGjz1ncQ5g
jB1myCUi6AZZtNUruxYGe7hzkhMB2BVWSETyDDqNKdDDLNA5kfk=
=+1wu
-----END PGP SIGNATURE-----

--aZoGpuMECXJckB41--

