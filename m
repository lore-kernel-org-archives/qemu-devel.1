Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EB7C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 05:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68EA214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 05:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="paAqc3wI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68EA214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hh5TF-0003tH-QC
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 01:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47764)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hh5SF-0003Fg-6w
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 00:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hh5SA-0007e5-Vv
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 00:59:13 -0400
Received: from ozlabs.org ([203.11.71.1]:35999)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hh5Ru-00077k-RO; Sat, 29 Jun 2019 00:58:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45bLxh1xKDz9s5c; Sat, 29 Jun 2019 14:58:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561784312;
 bh=4l0Fp/EIcDNfaA2+VekUKadMenAca0ad1S2kqEoSg+I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=paAqc3wIXw76tF2Ir3njWf2yBF5tpsXIg8fRsZSmWaH1Ic1+mQGL5ptX3VtB+tN0Q
 zBcL0LQj4Mx/ixvYWhqnER+Nfjsh88TgzCqISt+wAKa3KNiw0hppvC9I6RzXcYXrPI
 txcmxvcIwJK+j25lP+cfpL5EWlmqhTu8wKiAbRVE=
Date: Fri, 28 Jun 2019 19:29:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190628092952.GB29462@umbus.fritz.box>
References: <20190624055812.3906-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20190624055812.3906-1-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 1/2] ppc/spapr: Add
 implementation of hcall H_PURR
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


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2019 at 03:58:11PM +1000, Suraj Jitindar Singh wrote:
> The hcall H_PURR is used by a guest to read the PURR (processor
> utilisation of resources register). A guest expects that this register
> will count at a rate of timebase scaled by the number of guest vcpus
> present in the vcore. That is the per vcpu purr will count at a rate of
> timebase / # vcpus per vcore.
>=20
> Implement a handler for the H_PURR hcall and return the purr value
> divided by smp_threads so that the sum of the purr deltas across the
> vcpus of a vcore equals the timebase delta
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Does this need something new advertised in the hypertas DT entry?

> ---
>  hw/ppc/spapr_hcall.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index aae9fd2b3e..88b3343f04 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1819,6 +1819,27 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, S=
paprMachineState *spapr,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_purr(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong purr;
> +
> +    if (kvm_enabled()) {
> +        cpu_synchronize_state(CPU(cpu));
> +        /*
> +         * Divide by smp_threads so that the sum of the purr deltas acro=
ss the
> +         * vcpus of a vcore equal the timebase delta.
> +         */
> +        purr =3D env->spr[SPR_PURR] / smp_threads;
> +    } else {
> +        purr =3D cpu_ppc_load_purr(env);
> +    }
> +    args[0] =3D purr;
> +
> +    return H_SUCCESS;
> +}
> +
>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_H=
CALL_BASE + 1];
> =20
> @@ -1915,6 +1936,9 @@ static void hypercall_register_types(void)
>      spapr_register_hypercall(H_LOGICAL_DCBF, h_logical_dcbf);
>      spapr_register_hypercall(KVMPPC_H_LOGICAL_MEMOP, h_logical_memop);
> =20
> +    /* hcall-purr */
> +    spapr_register_hypercall(H_PURR, h_purr);
> +
>      /* qemu/KVM-PPC specific hcalls */
>      spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0V3hAACgkQbDjKyiDZ
s5Icuw//YwlGoPuU9cnEkHTk9VaQewSonhPNFBFq7sBEHNHfybAazeQpFiluHbhP
AP2ZpD+ceClO28UQ+jmseOu0Raae65rLSIghM6u0QWYwRl+x9wJzKCpQdl2UPKMt
e5xorC2o6cGxGBjW6yVMPAA/WU4PNtTz65ImffVT9l4QwxPLFpbkJGxB6spEZyFU
2FThuVWgA2PbiSBmlb84OTOwfSUgevGpR7xgPwSO2pFORg+HDg7kmLizZXCEeSKR
ASis/r6O/okgOkWlOZQjSkkz4paP9J92ahwJKfk+3JIDFioh9AhznaB3MFcMr0wb
2fN6Ko3hYPdJWOt6iuNnHZgP+W8DoCXuGzk5Ghssm5AsR8ZfCMv2SZgirweGofHk
HTo/woWGCJ2/ABqn690FVMYtDY/lJC3o/ECgKB1DYyE5k3X4S1e8Qd+l/bIHTJco
c6HuHtDLAMHpJ/T9WU8SwbuYAHS6l1PdQq7e73PvhWrGmsnz+MRpSTXMPevtisWg
Bj8PR13vImWlVGg/1g1mVk3YGidvtvsOVW35eK4Jv7RqQzBBnL+80crNjw8ZfIOr
V7QhOUGtISinOEUo+kp6ExGDNvNLndgGfjNrb7ZgzEl8dWXG9gXXWWNQTC46NQkg
KzzZmyEN9vl/iVrW4XNrWKn2Tvc/nZODiLrRxbSLiSxC2UCp7WI=
=pLYQ
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--

