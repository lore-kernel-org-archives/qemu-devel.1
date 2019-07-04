Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFFAC5B578
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 02:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D7921882
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 02:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SE+tGrHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D7921882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hir9C-0002Qp-4n
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 22:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46231)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hir8P-0001kV-MD
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 22:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hir8N-0004C4-SD
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 22:06:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34107 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hir8L-0004AJ-DS; Wed, 03 Jul 2019 22:06:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45fLtD4gk9z9sBp; Thu,  4 Jul 2019 12:05:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562205956;
 bh=w84ceBxppYPz8x3Ysu8gqyDEAASJqqad5rrtDfXAuZA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SE+tGrHivi2w4OX754g3cVC47eRchU/viRxbd2snXbeslB0pi8eSecQHUz4PvJXpq
 OvAfZiPo6AgK4uHf7CSCIxSvUy22WbVRGLvVrXxhOm7+oYHjdvSoeVCLt7AFgXXRWL
 pxvQUeszBosHdLhTQIO1EmALi44UeBTAZvBBuDF0=
Date: Thu, 4 Jul 2019 11:12:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190704011222.GT9442@umbus.fritz.box>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033129836.26635.3348706829139659071.stgit@aravinda>
 <20190702041129.GJ6779@umbus.fritz.box>
 <89a68bbd-801e-876c-3105-877790a3189b@linux.vnet.ibm.com>
 <20190703032027.GI9442@umbus.fritz.box>
 <c8f78a4c-d4a0-10e9-e0c9-0e37e3415b5c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BfbbJsf3thGkpLcA"
Content-Disposition: inline
In-Reply-To: <c8f78a4c-d4a0-10e9-e0c9-0e37e3415b5c@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v10 6/6] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BfbbJsf3thGkpLcA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2019 at 02:30:31PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Wednesday 03 July 2019 08:50 AM, David Gibson wrote:
> > On Tue, Jul 02, 2019 at 04:10:08PM +0530, Aravinda Prasad wrote:
> >>
> >>
> >> On Tuesday 02 July 2019 09:41 AM, David Gibson wrote:
> >>> On Wed, Jun 12, 2019 at 02:51:38PM +0530, Aravinda Prasad wrote:
> >>>> This patch adds support in QEMU to handle "ibm,nmi-register"
> >>>> and "ibm,nmi-interlock" RTAS calls and sets the default
> >>>> value of SPAPR_CAP_FWNMI_MCE to SPAPR_CAP_ON for machine
> >>>> type 4.0.
> >>>>
> >>>> The machine check notification address is saved when the
> >>>> OS issues "ibm,nmi-register" RTAS call.
> >>>>
> >>>> This patch also handles the case when multiple processors
> >>>> experience machine check at or about the same time by
> >>>> handling "ibm,nmi-interlock" call. In such cases, as per
> >>>> PAPR, subsequent processors serialize waiting for the first
> >>>> processor to issue the "ibm,nmi-interlock" call. The second
> >>>> processor that also received a machine check error waits
> >>>> till the first processor is done reading the error log.
> >>>> The first processor issues "ibm,nmi-interlock" call
> >>>> when the error log is consumed.
> >>>>
> >>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >>>> ---
> >>>>  hw/ppc/spapr.c         |    6 ++++-
> >>>>  hw/ppc/spapr_rtas.c    |   63 +++++++++++++++++++++++++++++++++++++=
+++++++++++
> >>>>  include/hw/ppc/spapr.h |    5 +++-
> >>>>  3 files changed, 72 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>> index 3d6d139..213d493 100644
> >>>> --- a/hw/ppc/spapr.c
> >>>> +++ b/hw/ppc/spapr.c
> >>>> @@ -2946,6 +2946,9 @@ static void spapr_machine_init(MachineState *m=
achine)
> >>>>          /* Create the error string for live migration blocker */
> >>>>          error_setg(&spapr->fwnmi_migration_blocker,
> >>>>                  "Live migration not supported during machine check =
handling");
> >>>> +
> >>>> +        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS cal=
ls */
> >>>> +        spapr_fwnmi_register();
> >>>>      }
> >>>> =20
> >>>>      spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
> >>>> @@ -4408,7 +4411,7 @@ static void spapr_machine_class_init(ObjectCla=
ss *oc, void *data)
> >>>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_O=
FF;
> >>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_C=
AP_ON;
> >>>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> >>>> -    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> >>>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_ON;
> >>>
> >>> Turning this on by default really isn't ok if it stops you running TCG
> >>> guests at all.
> >>
> >> If so this can be "off" by default until TCG is supported.
> >>
> >>>
> >>>>      spapr_caps_add_properties(smc, &error_abort);
> >>>>      smc->irq =3D &spapr_irq_dual;
> >>>>      smc->dr_phb_enabled =3D true;
> >>>> @@ -4512,6 +4515,7 @@ static void spapr_machine_3_1_class_options(Ma=
chineClass *mc)
> >>>>      smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
> >>>>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
> >>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_C=
AP_OFF;
> >>>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> >>>
> >>> We're now well past 4.0, and in fact we're about to go into soft
> >>> freeze for 4.1, so we're going to miss that too.  So 4.1 and earlier
> >>> will need to retain the old default.
> >>
> >> ok.
> >>
> >>>
> >>>>  }
> >>>> =20
> >>>>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> >>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >>>> index a015a80..e010cb2 100644
> >>>> --- a/hw/ppc/spapr_rtas.c
> >>>> +++ b/hw/ppc/spapr_rtas.c
> >>>> @@ -49,6 +49,7 @@
> >>>>  #include "hw/ppc/fdt.h"
> >>>>  #include "target/ppc/mmu-hash64.h"
> >>>>  #include "target/ppc/mmu-book3s-v3.h"
> >>>> +#include "migration/blocker.h"
> >>>> =20
> >>>>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineSta=
te *spapr,
> >>>>                                     uint32_t token, uint32_t nargs,
> >>>> @@ -352,6 +353,60 @@ static void rtas_get_power_level(PowerPCCPU *cp=
u, SpaprMachineState *spapr,
> >>>>      rtas_st(rets, 1, 100);
> >>>>  }
> >>>> =20
> >>>> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> >>>> +                                  SpaprMachineState *spapr,
> >>>> +                                  uint32_t token, uint32_t nargs,
> >>>> +                                  target_ulong args,
> >>>> +                                  uint32_t nret, target_ulong rets)
> >>>> +{
> >>>> +    int ret;
> >>>> +    hwaddr rtas_addr =3D spapr_get_rtas_addr();
> >>>> +
> >>>> +    if (!rtas_addr) {
> >>>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> >>>> +        return;
> >>>> +    }
> >>>> +
> >>>> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_=
OFF) {
> >>>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> >>>> +        return;
> >>>> +    }
> >>>> +
> >>>> +    ret =3D kvmppc_fwnmi_enable(cpu);
> >>>> +    if (ret =3D=3D 1) {
> >>>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> >>>
> >>> I don't understand this case separate from the others.  We've already
> >>> set the cap, so fwnmi support should be checked and available.
> >>
> >> But we have not enabled fwnmi in KVM. kvmppc_fwnmi_enable() returns 1 =
if
> >> cap_ppc_fwnmi is not available in KVM.
> >=20
> > But you've checked for the presence of the extension, yes?  So a
> > failure to enable the cap would be unexpected.  In which case how does
> > this case differ from..=20
>=20
> No, this is the function where I check for the presence of the
> extension. In kvm_arch_init() we just set cap_ppc_fwnmi to 1 if KVM
> support is available, but don't take any action if unavailable.

Yeah, that's not ok.  You should be checking for the presence of the
extension in the .apply() function.  If you start up with the spapr
cap selected then failing at nmi-register time means something has
gone badly wrong.

This is necessary for migration: if you start on a system with nmi
support and the guest registers for it, you can't then migrate safely
to a system that doesn't have nmi support.  The way to handle that
case is to have qemu fail to even start up on a destination without
the support.

> So this case is when we are running an old version of KVM with no
> cap_ppc_fwnmi support.
>=20
> >=20
> >>
> >>>
> >>>> +        return;
> >>>> +    } else if (ret < 0) {
> >>>> +        error_report("Couldn't enable KVM FWNMI capability");
> >>>> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> >>>> +        return;
> >=20
> > ..this case.
>=20
> And this is when we have the KVM support but due to some problem with
> either KVM or QEMU we are unable to enable cap_ppc_fwnmi.
>=20
> >=20
> >>>> +    }
> >>>> +
> >>>> +    spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
> >>>> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> >>>> +}
> >>>> +
> >>>> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
> >>>> +                                   SpaprMachineState *spapr,
> >>>> +                                   uint32_t token, uint32_t nargs,
> >>>> +                                   target_ulong args,
> >>>> +                                   uint32_t nret, target_ulong rets)
> >>>> +{
> >>>> +    if (spapr->guest_machine_check_addr =3D=3D -1) {
> >>>> +        /* NMI register not called */
> >>>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> >>>> +    } else {
> >>>> +        /*
> >>>> +         * vCPU issuing "ibm,nmi-interlock" is done with NMI handli=
ng,
> >>>> +         * hence unset mc_status.
> >>>> +         */
> >>>> +        spapr->mc_status =3D -1;
> >>>> +        qemu_cond_signal(&spapr->mc_delivery_cond);
> >>>> +        migrate_del_blocker(spapr->fwnmi_migration_blocker);
> >>>
> >>> Hrm.  We add the blocker at the mce request point.  First, that's in
> >>> another patch, which isn't great.  Second, does that mean we could add
> >>> multiple times if we get an MCE on multiple CPUs?  Will that work and
> >>> correctly match adds and removes properly?
> >>
> >> If it is fine to move the migration patch as the last patch in the
> >> sequence, then we will have add and del blocker in the same patch.
> >>
> >> And yes we could add multiple times if we get MCE on multiple CPUs and
> >> as all those cpus call interlock there should be matching number of
> >> delete blockers.
> >=20
> > Ok, and I think adding the same pointer to the list multiple times
> > will work ok.
>=20
> I think so
>=20
> >=20
> > Btw, add_blocker() can fail - have you handled failure conditions?
>=20
> yes, I am handling it.
>=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BfbbJsf3thGkpLcA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0dUnYACgkQbDjKyiDZ
s5ISAQ//ZJQY0uWPprEiHpbP4TDM1PhRWwWb59WEHAQrXhdjT2vTGp0/SYlBpnDH
6He/M7INLnRjBHE+vbz86jSoW5RgxnhzvHFbL2Y9jbYF7XgJAl0J7K5IJ1rB7JoF
7GESCInfECHK51oyIT/1geK9Joa6+fEXrF0dYZC3uFV0SaooWNMUC3vLprvTdnzA
nu8CgVgabEUBHc2xDqFxsvQkWxTWI/yB7ck7m/88y/LFFxWeBK9JHMxr4PIqBAMD
AE309FQXqnkELvVHb3E7WjbN3YwtCFnxC6Xb6eZEGCEKtez056wgLfKF5xkOKxHr
komCj37nS/LWreqkv2QQiMaQJBcijIcxnNnmAHnEtMKq2OQD+6Z9LvfdCziWBgae
94jqz7NiMwfnaPf+SlvmZ227Nx3b5upGCYqAVBfAy4B3P9MEQtwo2HcfvoGKGy2y
+6y6nWOrVT42TPGp19QhHtM5ZsK+a3o1/bT0XqDfN0bZcDYwO37LZHNFGfdfrDP8
nhT8E2T+BNxVEzhqcbe933ZHDuXCzI49DiUjPY2YdFju6Q3puxykS4Vvry9VvQad
0Y0rjOtA2wBLB8XeCDIhLISYSRfDW0vzFuMy1SjFmc4feDaqhXojxYqNS1/9MJmN
caGegtyWavtv6HXLZq/xTjxqWbgllNbpEyz9qNphJVisq0j3cYQ=
=RXQi
-----END PGP SIGNATURE-----

--BfbbJsf3thGkpLcA--

