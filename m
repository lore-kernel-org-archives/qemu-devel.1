Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AD6C10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 03:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923D621773
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 03:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Klj1SJd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923D621773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46011 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGaup-0007vX-QF
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 23:07:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGasx-0006Z3-I2
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 23:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGasu-0001sG-44
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 23:05:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46463 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hGasr-0001oW-Vy; Tue, 16 Apr 2019 23:05:15 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44kRtZ3GYfz9sBb; Wed, 17 Apr 2019 13:05:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1555470310;
	bh=zerSvUSWI5OoH+Et740il/vdEdrlhJofSOO7TKszlnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Klj1SJd9h8c0TI5MgpXZHKBQbo5R3yX5ES10ku1DvHQTJ8D2+4fZmWd3MYeahAI6x
	HVRQP3DW/0qQvF+8KLfcqFEYkJ583eA+wRQIyma8tFfG+l46yVyLuTG69gj63ZVlJ6
	+923SWVSac7p5GsyLfRtJUPgc+yDD7oJbLRX0zww=
Date: Wed, 17 Apr 2019 11:59:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190417015934.GH32705@umbus.fritz.box>
References: <20190416045552.24573-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline
In-Reply-To: <20190416045552.24573-1-npiggin@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v3] spapr: add splpar hcalls H_PROD,
 H_CONFER
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417015934.DBzd7BFNu37tq2gr-6dZyZUAOYen_BvllBNMl15gmvg@z>


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 02:55:52PM +1000, Nicholas Piggin wrote:
> These implementations have a few deficiencies that are noted, but are
> good enough for Linux to use.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>=20
> v3: Removed wrong comment about GPR3, drop H_JOIN for now (at least until
> it is tested some more in Linux/KVM), and expand the comment about not
> prod bit.
>=20
>  hw/ppc/spapr_hcall.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 8a736797b9..8892ad008b 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1065,6 +1065,74 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    target_long target =3D args[0];
> +    CPUState *cs =3D CPU(cpu);
> +
> +    /*
> +     * This does not do a targeted yield or confer, but check the parame=
ter
> +     * anyway. -1 means confer to all/any other CPUs.
> +     */
> +    if (target !=3D -1 && !CPU(spapr_find_cpu(target))) {
> +        return H_PARAMETER;
> +    }
> +
> +    /*
> +     * PAPR calls for waiting until proded in this case (or presumably
> +     * an external interrupt if MSR[EE]=3D1, without dispatch sequence c=
ount
> +     * check.

Is this comment complete?  It's missing a closing parenthesis at the
very least.

> +     */
> +    if (cpu =3D=3D spapr_find_cpu(target)) {
> +        cs->halted =3D 1;
> +        cs->exception_index =3D EXCP_HALTED;
> +        cs->exit_request =3D 1;
> +
> +        return H_SUCCESS;
> +    }
> +
> +    /*
> +     * This does not implement the dispatch sequence check that PAPR cal=
ls for,
> +     * but PAPR also specifies a stronger implementation where the targe=
t must
> +     * be run (or EE, or H_PROD) before H_CONFER returns. Without such a=
 hard
> +     * scheduling requirement implemented, there is no correctness reaso=
n to
> +     * implement the dispatch sequence check.
> +     */
> +    cs->exception_index =3D EXCP_YIELD;
> +    cpu_loop_exit(cs);
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    target_long target =3D args[0];
> +    CPUState *cs;
> +
> +    /*
> +     * PAPR specifies there should be a prod flag should be associated w=
ith
> +     * a vCPU, which gets set here, tested by H_CEDE, and cleared any ti=
me
> +     * the vCPU is dispatched, including via preemption.
> +     *
> +     * We don't implement this because it is not used by Linux. The bit =
would
> +     * be difficult or impossible to use properly because preemption can=
 not
> +     * be prevented so dispatch sequence count would have to somehow be =
used
> +     * to detect it.

Hm.  AFAIK the dispatch sequence count only exists with KVM, so I
don't see how testing it would fit with a userspace implementation of PROD.

> +     */
> +
> +    cs =3D CPU(spapr_find_cpu(target));
> +    if (!cs) {
> +        return H_PARAMETER;
> +    }
> +
> +    cs->halted =3D 0;
> +    qemu_cpu_kick(cs);
> +
> +    return H_SUCCESS;
> +}
> +
>  static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                             target_ulong opcode, target_ulong *args)
>  {
> @@ -1860,6 +1928,9 @@ static void hypercall_register_types(void)
>      /* hcall-splpar */
>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>      spapr_register_hypercall(H_CEDE, h_cede);
> +    spapr_register_hypercall(H_CONFER, h_confer);
> +    spapr_register_hypercall(H_PROD, h_prod);
> +
>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);

You're no longer enabling the KVM CONFER and PROD hypercalls.  Are
they enabled by default, or is that an intentional change?

>      /* processor register resource access h-calls */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly2iIQACgkQbDjKyiDZ
s5Kuuw//eznmY7qwsa31ezrdfG1UNnQRBFzbjxmbYq55WFfJnT+yTsG2BE7eVfN/
A1fmLyXjuxT8k8tdVMsP2tT1N+3o2okAhMLLLp1WeUgW2KF++EyDzaM2BK/YEUtr
YD1cm3gN5Jrfg7xZ3gQOL37UGz9S6NNyXThOr3HCzTYqaO9BXOVn69wQyEpOGw7i
+4SpemMN9hrKA/6JmfoLnjl6tmmodF9PfdXpgY7W4WPTtjL5g/UsEbA1KyDxn5u8
pmvgdfsrX2SaGCCtlLMUW8Db2ZyeK6ErYndu6UrutCON+SDAbFeR4NBxxwylyVO6
fZVjL6Eapj3ASlDsRQnMSf91wFFzT5AG6n/CIbjxDMSYSF4uKmbzhNWoSVrorShx
9MOeKS7PeKPU1hIzcEHwt2DB6tLpwahMTl0mM17ZcRqSddASItzrhe+CpqKgvkYX
HKgl9v/67sgELYlGwFzNCtkypXsWyT3X+Td7LR9JwoBo0Pqs6QodzPLtmpeK5Kb3
OuikwXVFLQvMtup/lBwkzvMmrCllRTx8VAH+C9+ObV9IaPjl9IaglJddfXquboIh
G48lK1mYzVS1s7XyXWImbH4ytN1PZCTff/PXtHlyDfseFL7QeQXIcIfVBy1LSf6c
TKip0M/MEkyjkXHk6L70a6QH4Ie6DNFo8m7fQ72Agq3kJ36gcSU=
=deig
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--

