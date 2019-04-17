Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0343C10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 03:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9386721773
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 03:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IaB/HB+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9386721773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46013 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGav8-00089o-Rl
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 23:07:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGasx-0006Z7-J0
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 23:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGasu-0001sl-UN
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 23:05:19 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:39589)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hGast-0001oQ-QU; Tue, 16 Apr 2019 23:05:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44kRtZ1LhQz9sBF; Wed, 17 Apr 2019 13:05:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1555470310;
	bh=DNCiQWB0MlnMiHGDuzU7H3/c35jhwbCMTqc1dBBEww0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IaB/HB+VCRfDXOXKtGEgJTKw5TnYiTf8VS+hESub/EyuFUi77FLXOph0e5EYgnpfI
	NbC7hgquhfons262UHGUnPvQwmDmyv3io6xZiV2kFYGPpVT/Cn+K/Z5bfMGzixW0r2
	ZsrjpwH0OIaYzKwwI//Ys2olJ9dmwuza4f5PIC+E=
Date: Wed, 17 Apr 2019 10:47:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190417004721.GG32705@umbus.fritz.box>
References: <20190412093603.18232-1-npiggin@gmail.com>
	<20190415041359.GE32705@umbus.fritz.box>
	<1555302690.7m52mtdllv.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Content-Disposition: inline
In-Reply-To: <1555302690.7m52mtdllv.astroid@bobo.none>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2] spapr: add splpar hcalls H_JOIN, H_PROD,
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417004722.FsZPesF6phI98EGv5c2ePY3u8WGHn0pL6YMtLxrzFEc@z>


--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 03:06:43PM +1000, Nicholas Piggin wrote:
> David Gibson's on April 15, 2019 2:13 pm:
> > On Fri, Apr 12, 2019 at 07:36:03PM +1000, Nicholas Piggin wrote:
> >> These implementations have a few deficiencies that are noted, but are
> >> good enough for Linux to use.
> >>=20
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >>=20
> >> Cleaned up checkpatch warnings, sorry I didn't realise that exists.
> >>=20
> >>  hw/ppc/spapr_hcall.c | 88 ++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 88 insertions(+)
> >>=20
> >> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >> index 8a736797b9..e985bb694d 100644
> >> --- a/hw/ppc/spapr_hcall.c
> >> +++ b/hw/ppc/spapr_hcall.c
> >> @@ -1065,6 +1065,90 @@ static target_ulong h_cede(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
> >>      return H_SUCCESS;
> >>  }
> >> =20
> >> +static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
> >> +                           target_ulong opcode, target_ulong *args)
> >> +{
> >> +    CPUPPCState *env =3D &cpu->env;
> >> +    CPUState *cs =3D CPU(cpu);
> >> +
> >> +    if (env->msr & (1ULL << MSR_EE)) {
> >> +        return H_BAD_MODE;
> >> +    }
> >> +
> >> +    /*
> >> +     * This should check for single-threaded mode. In practice, Linux
> >> +     * does not try to H_JOIN all CPUs.
> >> +     */
> >> +
> >> +    cs->halted =3D 1;
> >> +    cs->exception_index =3D EXCP_HALTED;
> >> +    cs->exit_request =3D 1;
> >> +
> >> +    return H_SUCCESS;
> >> +}
> >> +
> >> +static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
> >> +                           target_ulong opcode, target_ulong *args)
> >> +{
> >> +    target_long target =3D args[0];
> >> +    CPUState *cs =3D CPU(cpu);
> >> +
> >> +    /*
> >> +     * This does not do a targeted yield or confer, but check the par=
ameter
> >> +     * anyway. -1 means confer to all/any other CPUs.
> >> +     */
> >> +    if (target !=3D -1 && !CPU(spapr_find_cpu(target))) {
> >> +        return H_PARAMETER;
> >> +    }
> >> +
> >> +    /*
> >> +     * H_CONFER with target =3D=3D this is not exactly the same as H_=
JOIN
> >> +     * according to PAPR (e.g., MSR[EE] check and single threaded che=
ck
> >> +     * is not done in this case), but unlikely to matter.
> >> +     */
> >> +    if (cpu =3D=3D spapr_find_cpu(target)) {
> >> +        return h_join(cpu, spapr, opcode, args);
> >> +    }
> >> +
> >> +    /*
> >> +     * This does not implement the dispatch sequence check that PAPR =
calls for,
> >> +     * but PAPR also specifies a stronger implementation where the ta=
rget must
> >> +     * be run (or EE, or H_PROD) before H_CONFER returns. Without suc=
h a hard
> >> +     * scheduling requirement implemented, there is no correctness re=
ason to
> >> +     * implement the dispatch sequence check.
> >> +     */
> >> +    cs->exception_index =3D EXCP_YIELD;
> >> +    cpu_loop_exit(cs);
> >> +
> >> +    return H_SUCCESS;
> >> +}
> >> +
> >> +/*
> >> + * H_PROD and H_CONFER are specified to only modify GPR r3, which is =
not
> >> + * achievable running under KVM,
> >=20
> > Uh.. why not?
>=20
> sc 1 handler kills ctr and cr0, but I misread the spec, they are not
> specified to modify _only_ GPR r3, but rather the only GPR modified
> is r3. cr0 and ctr still in the kill set.

Ah, ok.

>=20
> >> although KVM already implements H_CONFER
> >> + * this way.
> >=20
> > And this seems to contradict the above.
>=20
> I just meat it already is implemented with those clobbers, but as
> above that's not a problem. I'll take the comment out.
>=20
> >> + */
> >> +static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
> >> +                           target_ulong opcode, target_ulong *args)
> >> +{
> >> +    target_long target =3D args[0];
> >> +    CPUState *cs;
> >> +
> >> +    /*
> >> +     * Should set the prod flag in the VPA.
> >=20
> > So.. why doesn't it?
>=20
> It needs to be cleared at all vCPU dispatch points to SPEC, not just
> when calling H_CEDE as Ben's patch had. I think complexity would be
> significant for questionable benefit. Like the dispatch sequence, it
> seems like the test is trying to cover some race condition for the
> client but does not really do it well (and for Linux not necessary).
>=20
> prod bit is cleared after vCPU returns from preemption, so it can=20
> clear at any time and you can't rely on it, unless you look at=20
> dispatch sequence numbers to decipher if it was reset or not.
>=20
> KVM does implement something like the prodded flag as Ben's patch did
> but that's not to spec AFAIKS.

Hm, ok.  Maybe include this rationale in the comment here.

>=20
> >=20
> >> +     */
> >> +
> >> +    cs =3D CPU(spapr_find_cpu(target));
> >> +    if (!cs) {
> >> +        return H_PARAMETER;
> >> +    }
> >> +
> >> +    cs->halted =3D 0;
> >> +    qemu_cpu_kick(cs);
> >> +
> >> +    return H_SUCCESS;
> >> +}
> >> +
> >>  static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
> >>                             target_ulong opcode, target_ulong *args)
> >>  {
> >> @@ -1860,6 +1944,10 @@ static void hypercall_register_types(void)
> >>      /* hcall-splpar */
> >>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
> >>      spapr_register_hypercall(H_CEDE, h_cede);
> >> +    spapr_register_hypercall(H_CONFER, h_confer);
> >> +    spapr_register_hypercall(H_JOIN, h_join);
> >=20
> > I don't see any sign that H_JOIN is implemented in KVM, although
> > H_CONFER and H_PROD certainly are.
>=20
> H_JOIN is not.

Right, so we shouldn't be trying to enable it.  What will happen if we
use a KVM H_CONFGER and H_PROD along with a userspace H_JOIN?

> >> +    spapr_register_hypercall(H_PROD, h_prod);
> >> +
> >>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
> >> =20
> >>      /* processor register resource access h-calls */
> >=20
> > Don't we also need to add something to hypertas-calls to advertise the
> > availability of these calls to the guest?
>=20
> hcall-splpar is for H_CONFER and H_PROD, H_JOIN also wants
> hcall-join actually, good point. I could split the patch up and add
> H_CONFER and H_PROD first.

Ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly2d5cACgkQbDjKyiDZ
s5IwuRAAh7gKW9v2DX30j7yZ8F+gewNt6OiRHrWW15Gr29LKpNlM5NYwO8aDrs3a
593x0fnQpSaTAthsDuA1f5fHmd1vS9j5HfD8mXmDj3xpeySv/gbBDlT5NcD4YCg6
/Kzn8Wz0yR/Y9Ww8pYoqX+4/nj4iDBA9bWGYcgYmStL9PXVm4qkti42hRaXz+KIy
SDFq0U8cz8McZFiZmARKJPFnWWx+Z0dr3aNEeqT2liaf3A8hbcBnwaw07eoYF6ZQ
J9XEIQZzn/OGXm/VsysEj5FxZIb6Aemp+eW5hOdDrChVRP8Jipbtg4VmEplGw45j
/uHOaJmnEqwVdPGwgpW17E6lUWtRTmI/IKWALivdZcl9oVTEV7EhFk5HW+1oxo+r
02INSdII4oW8pYd5dl0AqC60GSDx9InUGoPj2qSyAqupTd3SAyRQZIhGRcuCO/jQ
rn9FFenv1/gMnxZL80MA00eXyBhmHc9Pi9JMckZnY10HiEaub4j5rv7xnqTCvO/m
S/w3woaRPLK8iy41hJO8Je9tJkp3tH6Mayb9XxXl3tdxJ2xQ9TbFFrVjpCfRoBTS
nJZ6AIvcG2uMOgwiJyq8CdvZGrxVDb+TgX7x4ra+qMDyPDTtG0PWmDI0VB5PGGqi
w+HMnyGyN42RRiW4jMTGfBM4qEDTO0k84CY+1LCLHvFKqr8FFUw=
=chMX
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--

