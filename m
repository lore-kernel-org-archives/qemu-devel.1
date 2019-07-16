Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5A0C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB676206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KEiI4GaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB676206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnJDa-0001qm-My
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45100)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnJD1-00006e-CK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnJD0-0007T8-24
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:53:15 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:57863)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnJCz-0007SG-4U; Tue, 16 Jul 2019 04:53:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45nvLY0tWvz9sNT; Tue, 16 Jul 2019 18:53:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563267189;
 bh=0t32TsDHikmCUWkN9jUBAlXKYvSxuA6pkyI1EoMTHjU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KEiI4GaLrw+UPx0IPjuDO2DZo+QBm+iU/e2QKSbyVGaVpv5xaABMR9Ggkg/GHH/Ed
 DCOb5LnZmHMBheS8+Lq8z+Jix2vwNmqlLe9sF7o121tPsUzlTL0mXx2ZDa1pVlxXhA
 rRBj7lxoCNrvv7/JM+/yKcuy3GLUeR7MBlGxjA2Q=
Date: Tue, 16 Jul 2019 18:22:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190716082250.GD7525@umbus.fritz.box>
References: <20190716024726.17864-1-npiggin@gmail.com>
 <20190716024726.17864-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <20190716024726.17864-3-npiggin@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v4 2/5] spapr: Implement H_PROD
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 12:47:23PM +1000, Nicholas Piggin wrote:
> H_PROD is added, and H_CEDE is modified to test the prod bit
> according to PAPR.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

LGTM apart from the style issues the bot noted.

> ---
>  hw/ppc/spapr_hcall.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index e615881ac4..8b208ab259 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1050,14 +1050,41 @@ static target_ulong h_cede(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
>  {
>      CPUPPCState *env =3D &cpu->env;
>      CPUState *cs =3D CPU(cpu);
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> =20
>      env->msr |=3D (1ULL << MSR_EE);
>      hreg_compute_hflags(env);
> +
> +    if (spapr_cpu->prod) {
> +        spapr_cpu->prod =3D false;
> +        return H_SUCCESS;
> +    }
> +
>      if (!cpu_has_work(cs)) {
>          cs->halted =3D 1;
>          cs->exception_index =3D EXCP_HLT;
>          cs->exit_request =3D 1;
>      }
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    target_long target =3D args[0];
> +    CPUState *cs;
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +
> +    cs =3D CPU(spapr_find_cpu(target));
> +    if (!cs) {
> +        return H_PARAMETER;
> +    }
> +
> +    spapr_cpu->prod =3D true;
> +    cs->halted =3D 0;
> +    qemu_cpu_kick(cs);
> +
>      return H_SUCCESS;
>  }
> =20
> @@ -1882,6 +1909,8 @@ static void hypercall_register_types(void)
>      /* hcall-splpar */
>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>      spapr_register_hypercall(H_CEDE, h_cede);
> +    spapr_register_hypercall(H_PROD, h_prod);
> +
>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
> =20
>      /* processor register resource access h-calls */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0tiVgACgkQbDjKyiDZ
s5JYZg/+P+ULLdROR4k1PeZo1sofzMBxwh9wNDvgfcX+4Ukop1gMDu35RBoc/3op
+pgwTKi+cxA7fKa/Hp4zh2f2tgtgGw9fPw217C1a7gE/WZyTIkUXcxCh5yJUnAPy
p6O0cHXt/U/m1M/f2Jn/uAA9NkxT3K+n0sadP3wEtXumOgPnbSMabIqMBNUajBSr
FNL02nL4NyQOCSdVyyJnuTRSyNI+8sB7r4qXv2v5/0RqdizBHQEfMOmLGrp/e1YK
AoukO6t/DYWmq7yR0yoTY8ezMUjox4Lzv0x1RSPGxjKhEDbqbqYqPUe5Py494kBT
N04pN/Uf3dGgV+ghSsNxYOgEMIcAdU/9ZbRzQ3Bkj3UjeWyJlxnQfZuTeIVyPyw+
D25NrHPkOFBM2MS67Fbvz7PgeNxmA2GblbHG6fjhMr/FjWTtoUgK+63N20wOtY4H
9wQCxWDNEagWtP17mEI9uHWkwOKQwFbZX47+z5rKj4jT8uSdQDpgTz7ECU8MA4D6
Hx42U1FFKivMLNWDbIu/pBloktqNqHTd3EEDmD4tF8JR58QSnZBX90wVuLg7CC5D
wFkAZ9+UZHXZ8O5nYnJPEpY7JKjs2VJHu9+HMjLtNYnU+RFtVR3IwievdIWcmBOt
O0Zm0Q/I6JDglRKb4J797OGw9i/ngDYGzGZ3Py8JADSi8X6j3qc=
=1nwN
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--

