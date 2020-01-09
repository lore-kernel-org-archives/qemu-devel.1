Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD406C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 01:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776BC206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 01:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mTb60/+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776BC206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipN2L-0007CC-LK
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 20:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ipMzE-0004bH-9f
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 20:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ipMzA-0000mz-2I
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 20:51:48 -0500
Received: from ozlabs.org ([203.11.71.1]:58327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ipMz8-0000b2-T1; Wed, 08 Jan 2020 20:51:43 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47tTcV3HKfz9sRl; Thu,  9 Jan 2020 12:51:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578534698;
 bh=AcerTNXaFSKPN5OSm2F72MecNYL1/X0SKLJ4tLwLGZs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mTb60/+JOCWbPC3dvI5pukMIlMAWKCF9wBqxhq+PYKib7/eoR9BzHqdNSRVUkawxp
 79gx/SKcuaLDbt82muhGOBO0sDNea6i6soevGWnuPUwVNu89Ugw1PuudgqoJQUXLUM
 swde3dkgjq0zZtTguegOUYRF8B0zYlH7uJ25JXcA=
Date: Thu, 9 Jan 2020 12:37:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ganesh <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v18 5/7] ppc: spapr: Handle "ibm,nmi-register" and
 "ibm,nmi-interlock" RTAS calls
Message-ID: <20200109013700.GI8586@umbus.fritz.box>
References: <20200102075111.25308-1-ganeshgr@linux.ibm.com>
 <20200102075111.25308-6-ganeshgr@linux.ibm.com>
 <20200103021959.GR2098@umbus>
 <279e921a-7540-d543-ba16-7fca55aff056@linux.ibm.com>
 <20200108010450.GH2137@umbus.fritz.box>
 <c6c3f717-2122-e2fe-f1b7-d7c7e4db79dc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <c6c3f717-2122-e2fe-f1b7-d7c7e4db79dc@linux.ibm.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2020 at 12:19:12AM +0530, Ganesh wrote:
>=20
>=20
> On 1/8/20 6:34 AM, David Gibson wrote:
> > On Tue, Jan 07, 2020 at 11:57:08AM +0530, Ganesh wrote:
> > > On 1/3/20 7:49 AM, David Gibson wrote:
> > > > On Thu, Jan 02, 2020 at 01:21:09PM +0530, Ganesh Goudar wrote:
> > > > > From: Aravinda Prasad <arawinda.p@gmail.com>
> > > > >=20
> > > > > This patch adds support in QEMU to handle "ibm,nmi-register"
> > > > > and "ibm,nmi-interlock" RTAS calls.
> > > > >=20
> > > > > The machine check notification address is saved when the
> > > > > OS issues "ibm,nmi-register" RTAS call.
> > > > >=20
> > > > > This patch also handles the case when multiple processors
> > > > > experience machine check at or about the same time by
> > > > > handling "ibm,nmi-interlock" call. In such cases, as per
> > > > > PAPR, subsequent processors serialize waiting for the first
> > > > > processor to issue the "ibm,nmi-interlock" call. The second
> > > > > processor that also received a machine check error waits
> > > > > till the first processor is done reading the error log.
> > > > > The first processor issues "ibm,nmi-interlock" call
> > > > > when the error log is consumed.
> > > > >=20
> > > > > [Move fwnmi registration to .apply hook]
> > > > > Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> > > > > Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
> > > > > ---
> > > > >    hw/ppc/spapr_caps.c    |  6 +++++
> > > > >    hw/ppc/spapr_rtas.c    | 58 ++++++++++++++++++++++++++++++++++=
++++++++
> > > > >    include/hw/ppc/spapr.h |  7 ++++-
> > > > >    3 files changed, 70 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > > > > index 3001098601..e922419cfb 100644
> > > > > --- a/hw/ppc/spapr_caps.c
> > > > > +++ b/hw/ppc/spapr_caps.c
> > > > > @@ -502,6 +502,12 @@ static void cap_fwnmi_mce_apply(SpaprMachine=
State *spapr, uint8_t val,
> > > > >        if (!val) {
> > > > >            return; /* Disabled by default */
> > > > >        }
> > > > > +
> > > > > +    if (!spapr->fwnmi_calls_registered && !kvmppc_set_fwnmi()) {
> > > > So, we definitely need the kvmppc_set_fwnmi() call here.  But in the
> > > > case where we *do* have KVM, but the call fails, we should fail the
> > > > .apply hook, rather than ignoring it silently.
> > > >=20
> > > > As we've discussed although TCG behaviour with fwnmi isn't 100%
> > > > correct, it's close enough to pass for most purposes - so it's
> > > > reasonable to continue if the cap is selected.  But if the cap is
> > > > selected and we're running with KVM we *must* enable the capability=
 in
> > > > KVM or we're not providing the environment the user requested.
> > > >=20
> > > > > +        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS =
calls */
> > > > > +        spapr_fwnmi_register();
> > > > We discussed registering the hypercalls here, but I thought after t=
hat
> > > > I suggested just always registering them, and having them bail out
> > > > when called if the cap is not set.  I see that you've implemented t=
hat
> > > > bailout for register, though not for interlock.  I think that's
> > > > simpler than registering them here.
> > > something like this?, with bailout in interlock as well.
> > >=20
> > > {
> > >  =A0=A0=A0 if (!val) {
> > >  =A0=A0=A0=A0=A0=A0=A0 return; /* Disabled by default */
> > >  =A0=A0=A0 }
> > >=20
> > >  =A0=A0=A0 if (kvm_enabled()) {
> > >  =A0=A0=A0=A0=A0=A0=A0 if (kvmppc_set_fwnmi() < 0) {
> > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_report("Could not enable fwn=
mi capability");
> > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 exit(1)
> > >  =A0=A0=A0 }
> > >=20
> > >  =A0=A0=A0 if (!spapr->fwnmi_calls_registered) {
> > >  =A0=A0=A0=A0=A0=A0=A0 /* Register ibm,nmi-register and ibm,nmi-inter=
lock RTAS calls */
> > >  =A0=A0=A0=A0=A0=A0=A0 spapr_fwnmi_register();
> > >  =A0=A0=A0=A0=A0=A0=A0 spapr->fwnmi_calls_registered =3D true;
> > >  =A0=A0=A0 }
> > > }
> > Uh.. no.. not really.  I was suggesting registering the calls
> > unconditionally, but in each of the call implementations you have
> Yes I got your point, here I am just trying to avoid registering the
> calls more than once, otherwise we may hit an assert.

Oh, right.  My point is that an advantage of registering them
unconditionally is you can do it early with the rest of the statically
registered calls, and so the problem of multiple registering them no
longer arises.

> >=20
> >=20
> >      if(!fwnmi_enabed)
> >           return H_FUNCTION;
> >=20
> > or maybe H_NOT_AVAILABLE.
> Sure, ill add this check in interlock call also.
> >=20
> > > > > +        spapr->fwnmi_calls_registered =3D true;
> > > > > +    }
> > > > >    }
> > > > >    SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> > > > > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > > > > index 2c066a372d..54b142f35b 100644
> > > > > --- a/hw/ppc/spapr_rtas.c
> > > > > +++ b/hw/ppc/spapr_rtas.c
> > > > > @@ -400,6 +400,56 @@ static void rtas_get_power_level(PowerPCCPU =
*cpu, SpaprMachineState *spapr,
> > > > >        rtas_st(rets, 1, 100);
> > > > >    }
> > > > > +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> > > > > +                                  SpaprMachineState *spapr,
> > > > > +                                  uint32_t token, uint32_t nargs,
> > > > > +                                  target_ulong args,
> > > > > +                                  uint32_t nret, target_ulong re=
ts)
> > > > > +{
> > > > > +    hwaddr rtas_addr;
> > > > > +
> > > > > +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_C=
AP_OFF) {
> > > > > +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    rtas_addr =3D spapr_get_rtas_addr();
> > > > > +    if (!rtas_addr) {
> > > > > +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
> > > > > +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> > > > > +}
> > > > > +
> > > > > +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
> > > > > +                                   SpaprMachineState *spapr,
> > > > > +                                   uint32_t token, uint32_t narg=
s,
> > > > > +                                   target_ulong args,
> > > > > +                                   uint32_t nret, target_ulong r=
ets)
> > > > > +{
> > > > > +    if (spapr->guest_machine_check_addr =3D=3D -1) {
> > > > > +        /* NMI register not called */
> > > > > +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    if (spapr->mc_status !=3D cpu->vcpu_id) {
> > > > > +        /* The vCPU that hit the NMI should invoke "ibm,nmi-inte=
rlock" */
> > > > > +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    /*
> > > > > +     * vCPU issuing "ibm,nmi-interlock" is done with NMI handlin=
g,
> > > > > +     * hence unset mc_status.
> > > > > +     */
> > > > > +    spapr->mc_status =3D -1;
> > > > > +    qemu_cond_signal(&spapr->mc_delivery_cond);
> > > > > +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> > > > > +}
> > > > > +
> > > > >    static struct rtas_call {
> > > > >        const char *name;
> > > > >        spapr_rtas_fn fn;
> > > > > @@ -503,6 +553,14 @@ hwaddr spapr_get_rtas_addr(void)
> > > > >        return (hwaddr)fdt32_to_cpu(*rtas_data);
> > > > >    }
> > > > > +void spapr_fwnmi_register(void)
> > > > > +{
> > > > > +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register=
",
> > > > > +                        rtas_ibm_nmi_register);
> > > > > +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlo=
ck",
> > > > > +                        rtas_ibm_nmi_interlock);
> > > > > +}
> > > > > +
> > > > >    static void core_rtas_register_types(void)
> > > > >    {
> > > > >        spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-chara=
cter",
> > > > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > > > index 652a5514e8..a90e677cc3 100644
> > > > > --- a/include/hw/ppc/spapr.h
> > > > > +++ b/include/hw/ppc/spapr.h
> > > > > @@ -218,6 +218,8 @@ struct SpaprMachineState {
> > > > >        unsigned gpu_numa_id;
> > > > >        SpaprTpmProxy *tpm_proxy;
> > > > > +
> > > > > +    bool fwnmi_calls_registered;
> > > > >    };
> > > > >    #define H_SUCCESS         0
> > > > > @@ -656,8 +658,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu=
, target_ulong opcode,
> > > > >    #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BA=
SE + 0x28)
> > > > >    #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BA=
SE + 0x29)
> > > > >    #define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BA=
SE + 0x2A)
> > > > > +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE=
 + 0x2B)
> > > > > +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE=
 + 0x2C)
> > > > > -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE=
 + 0x2B)
> > > > > +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE=
 + 0x2D)
> > > > >    /* RTAS ibm,get-system-parameter token values */
> > > > >    #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
> > > > > @@ -908,4 +912,5 @@ void spapr_check_pagesize(SpaprMachineState *=
spapr, hwaddr pagesize,
> > > > >    void spapr_set_all_lpcrs(target_ulong value, target_ulong mask=
);
> > > > >    hwaddr spapr_get_rtas_addr(void);
> > > > > +void spapr_fwnmi_register(void);
> > > > >    #endif /* HW_SPAPR_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4Wg7wACgkQbDjKyiDZ
s5KZdxAAwuFEN7iPXIZQ7ViE6NagM+yUbECFxaBDQj6bCoU6QvLOBaWByAou3Gx9
+xkAeqKFoOZx0NsCWLb2E+ey0/m78wlzcIq7HFkBtDiTiYHPI+xKdYFJVXyd3ofZ
d2jOIibWcvEgHocqG/rt5vIfZxPrhGhY9n2yBi+7cmM7/++nJst3ujr243ER38PD
UWtpVMr33HFoJbefKns/vvjludC+QSWTYvdkAqYpbqqxxvcBD6B0tJijE0GccDIN
vpePRQKjFACrrNq9fyyNB53IOwRVGwbtDBvA14JOrFPVooBy6vsrN7MG5OcYCkJ3
+KFFSgYIRdBApruhv+834yklSKLo9qlkf9wVjP2ZcbU1b9st6o6qdly4Y3G+1p3+
B48LZtKxNrBIr90qiTgwdVUp9oVb/PLfXp6Ixrs961nUYWbpj4UqhO+yE59wNkGG
aAFh7HEgHnCaUGMj7E2ikl1ivhkCNue5fv6eicBaJcIncHHQz2YagYn5X1rkvVJ7
gPdlJHjd+AY2/GF6LABB9mFes8c/YZZvQ0wO+6Hu50FMjnoXTzN3HIx16wLoPFtQ
oVq+OOJ8JGitORuc8cd7WZjEQcdZXW6E3P81mVFWa8f9AVfDk8RXi6DMctIkf66+
8fkOc00+0lAgMJdACh41PkBqu/bq4XYxTrX3nZ68bUAUdSq1xEA=
=XDiO
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--

