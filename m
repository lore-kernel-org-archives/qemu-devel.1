Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1ADC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00E1206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BKoAtel7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00E1206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnJE5-0004Q5-Qz
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45098)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnJD1-00006c-Bx
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnJD0-0007TK-2s
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:53:15 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43137 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnJCz-0007SE-8i; Tue, 16 Jul 2019 04:53:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45nvLY320Nz9sNj; Tue, 16 Jul 2019 18:53:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563267189;
 bh=kdDz65odmbBZPSq/8iNy90UTGXtaOsFmTSKHPRqjT2Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BKoAtel7Fnf4TglEeIMHTFgnrmG+4YHQ452cq2l4tnJT2JBDHHuytOPa3S0NdfI2F
 6/TuelaweoyQyFjGPDDdzDkM7iPjVx6KSQgwkfy5Whq0rwzh3O6qqNUygDsDXTlWEv
 aSwm0q61i74hl/gfKvVTIhwvmSx5lmwopYuNeNoA=
Date: Tue, 16 Jul 2019 18:25:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190716082549.GE7525@umbus.fritz.box>
References: <20190716024726.17864-1-npiggin@gmail.com>
 <20190716024726.17864-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <20190716024726.17864-4-npiggin@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v4 3/5] spapr: Implement H_CONFER
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


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 12:47:24PM +1000, Nicholas Piggin wrote:
> This does not do directed yielding and is not quite as strict as PAPR
> specifies in terms of precise dispatch behaviour. This generally will
> mean suboptimal performance, rather than guest misbehaviour. Linux
> does not rely on exact dispatch behaviour.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/spapr_hcall.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 8b208ab259..28d58113be 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1069,6 +1069,53 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    target_long target =3D args[0];
> +    uint32_t dispatch =3D args[1];
> +    PowerPCCPU *target_cpu =3D spapr_find_cpu(target);
> +    CPUState *target_cs =3D CPU(target_cpu);
> +    CPUState *cs =3D CPU(cpu);
> +    SpaprCpuState *spapr_cpu;
> +
> +    /*
> +     * This does not do a targeted yield or confer, but check the parame=
ter
> +     * anyway. -1 means confer to all/any other CPUs.
> +     */
> +    if (target !=3D -1 && !target_cs) {
> +        return H_PARAMETER;
> +    }

Should we return an error if a targeted yield is attempted, rather
than pretend we've done it?

> +
> +    spapr_cpu =3D spapr_cpu_state(target_cpu);
> +
> +    /*
> +     * PAPR specifies waiting until proded in this case, without dispatch

s/proded/prodded/

> +     * counter check.
> +     */
> +    if (cpu =3D=3D target_cpu) {
> +        if (spapr_cpu->prod) {
> +            spapr_cpu->prod =3D false;
> +            return H_SUCCESS;
> +        }
> +
> +        cs->halted =3D 1;
> +        cs->exception_index =3D EXCP_HALTED;
> +        cs->exit_request =3D 1;

Now that we're using this sequence in a bunch of places, I wonder if
we want a little helper function.

> +
> +        return H_SUCCESS;
> +    }
> +
> +    if (spapr_cpu->dispatch_counter !=3D dispatch || (dispatch & 1) =3D=
=3D 0) {
> +        return H_SUCCESS;
> +    }
> +
> +    cs->exception_index =3D EXCP_YIELD;
> +    cpu_loop_exit(cs);
> +
> +    return H_SUCCESS;
> +}
> +
>  static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                             target_ulong opcode, target_ulong *args)
>  {
> @@ -1909,6 +1956,7 @@ static void hypercall_register_types(void)
>      /* hcall-splpar */
>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>      spapr_register_hypercall(H_CEDE, h_cede);
> +    spapr_register_hypercall(H_CONFER, h_confer);
>      spapr_register_hypercall(H_PROD, h_prod);
> =20
>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0tig0ACgkQbDjKyiDZ
s5Kimg//W/sc1aAYObKViC473brR1CqnP6pUlsrNB3DQCQw82ru1/j/dIdSdXEp6
d29pMsd6laNBlvM4TrtnEbc5gxo5IYV8wC+YB9j9dT5N1bhuMFiWStI3kAPlQYan
mmPD6BRya7aRQOj36Oq3tO/MOXtWN6UQ+P+ksZrYJyOn3ui+tLONfyLrMSrS3pmU
1XpzUQ18yUZyUVLqEbnbcxXo9u2ymHSuvDltENkPcseAO7ZqTdYWDy96gTXmxM35
PZtziyhRND04kyZPOz8aGjcZyK37obPid8wat5ClQp3IgDi0mYUxgGvq7PjDWlDl
v0/FhI/qF12F11NWXDvXwt2oNckAYkVzzxI09nIbdx/6ddfkBtTF/GKZhCDG+Iez
14A0bi/bG9ofNk3AvnBjd+JgsJei16o/pVzYHrg7+z1LtRk1TUu4IKh0U5CHvRPt
RUmukTEERQyEsfGuqcdA82SwpBSo/OZV3Kc1Uy/VX1PCAT1CiIkyEkwsXh1QbcdW
bIObe5ux6/qWXvfR2LtY7QRkVMsH06Q0AxVtqeulAgcGMqC3MvepWsGCZnrIYTYL
qiynHtfSx03U/8RTnOG3Wm5zTYHSlg6M38gUTopPyo/rR5HfOju6y0ZCAflzDgMA
bw4plE5yRMLN/Nd2dGPHF/O4atcEIco5HU/m632QEC0msyiCZ9Y=
=pfmU
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--

