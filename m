Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BCEC04E53
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 01:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4560420862
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 01:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f5f5Bw11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4560420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46913 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR5ZN-0002iA-JN
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 21:52:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hR5WE-0000dY-Qj
	for qemu-devel@nongnu.org; Wed, 15 May 2019 21:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hR5WC-0007tp-AW
	for qemu-devel@nongnu.org; Wed, 15 May 2019 21:49:14 -0400
Received: from ozlabs.org ([203.11.71.1]:55671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hR5WB-0007qQ-Am; Wed, 15 May 2019 21:49:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 454DqQ4fzrz9sMQ; Thu, 16 May 2019 11:49:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557971346;
	bh=lAJAUQPpLOBMKD587hIYaxUphjVwguqLOj8EFuQ5sqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5f5Bw11BvjSbkgJkCIC6NcK97LLZ/zKaBEy4CsUQ5G4Dc3gJjzpMga2wv3qb55gR
	unfyWcO8lnMXz0mi1BCfaQp6gnUvYe3LZjrZBM0cn6+ooutmUnxqkvrUcWy7VE/mKy
	GdSm1UF1W5c0LVV4zY+CwuHTcGLZJVM9UwcjojyE=
Date: Thu, 16 May 2019 11:45:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190516014535.GD3207@umbus.fritz.box>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591661564.20338.10693276428550708820.stgit@aravinda>
	<20190510064620.GL20559@umbus.fritz.box>
	<fa3f0f81-17bc-ce71-7fa0-e0bc706b3c17@linux.vnet.ibm.com>
	<20190510095321.GB5030@umbus.fritz.box>
	<69768ad0-7f08-6233-32df-f6a4a4c25d17@linux.vnet.ibm.com>
	<20190514044711.GI6441@umbus.fritz.box>
	<22c3e719-c14e-c07e-e014-7a55932b011e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
In-Reply-To: <22c3e719-c14e-c07e-e014-7a55932b011e@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 5/6] ppc: spapr: Enable FWNMI
 capability
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
Cc: paulus@ozlabs.org, aik@au1.ibm.com, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2019 at 11:02:07AM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Tuesday 14 May 2019 10:17 AM, David Gibson wrote:
> > On Mon, May 13, 2019 at 04:00:43PM +0530, Aravinda Prasad wrote:
> >>
> >>
> >> On Friday 10 May 2019 03:23 PM, David Gibson wrote:
> >>> On Fri, May 10, 2019 at 12:45:29PM +0530, Aravinda Prasad wrote:
> >>>>
> >>>>
> >>>> On Friday 10 May 2019 12:16 PM, David Gibson wrote:
> >>>>> On Mon, Apr 22, 2019 at 12:33:35PM +0530, Aravinda Prasad wrote:
> >>>>>> Enable the KVM capability KVM_CAP_PPC_FWNMI so that
> >>>>>> the KVM causes guest exit with NMI as exit reason
> >>>>>> when it encounters a machine check exception on the
> >>>>>> address belonging to a guest. Without this capability
> >>>>>> enabled, KVM redirects machine check exceptions to
> >>>>>> guest's 0x200 vector.
> >>>>>>
> >>>>>> This patch also deals with the case when a guest with
> >>>>>> the KVM_CAP_PPC_FWNMI capability enabled is attempted
> >>>>>> to migrate to a host that does not support this
> >>>>>> capability.
> >>>>>>
> >>>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >>>>>> ---
> >>>>>>  hw/ppc/spapr.c         |    1 +
> >>>>>>  hw/ppc/spapr_caps.c    |   26 ++++++++++++++++++++++++++
> >>>>>>  hw/ppc/spapr_rtas.c    |   14 ++++++++++++++
> >>>>>>  include/hw/ppc/spapr.h |    4 +++-
> >>>>>>  target/ppc/kvm.c       |   14 ++++++++++++++
> >>>>>>  target/ppc/kvm_ppc.h   |    6 ++++++
> >>>>>>  6 files changed, 64 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>>>> index ffd1715..44e09bb 100644
> >>>>>> --- a/hw/ppc/spapr.c
> >>>>>> +++ b/hw/ppc/spapr.c
> >>>>>> @@ -4372,6 +4372,7 @@ static void spapr_machine_class_init(ObjectC=
lass *oc, void *data)
> >>>>>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP=
_OFF;
> >>>>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR=
_CAP_ON;
> >>>>>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OF=
F;
> >>>>>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> >>>>>>      spapr_caps_add_properties(smc, &error_abort);
> >>>>>>      smc->irq =3D &spapr_irq_xics;
> >>>>>>      smc->dr_phb_enabled =3D true;
> >>>>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >>>>>> index edc5ed0..5b3af04 100644
> >>>>>> --- a/hw/ppc/spapr_caps.c
> >>>>>> +++ b/hw/ppc/spapr_caps.c
> >>>>>> @@ -473,6 +473,22 @@ static void cap_ccf_assist_apply(SpaprMachine=
State *spapr, uint8_t val,
> >>>>>>      }
> >>>>>>  }
> >>>>>> =20
> >>>>>> +static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t=
 val,
> >>>>>> +                                Error **errp)
> >>>>>> +{
> >>>>>> +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> >>>>>> +
> >>>>>> +    if (!val) {
> >>>>>> +        return; /* Disabled by default */
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    if (kvm_enabled()) {
> >>>>>> +        if (kvmppc_fwnmi_enable(cpu)) {
> >>>>>> +            error_setg(errp, "Requested fwnmi capability not supp=
ort by KVM");
> >>>>>> +        }
> >>>>>> +    }
> >>>>>> +}
> >>>>>> +
> >>>>>>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> >>>>>>      [SPAPR_CAP_HTM] =3D {
> >>>>>>          .name =3D "htm",
> >>>>>> @@ -571,6 +587,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CA=
P_NUM] =3D {
> >>>>>>          .type =3D "bool",
> >>>>>>          .apply =3D cap_ccf_assist_apply,
> >>>>>>      },
> >>>>>> +    [SPAPR_CAP_FWNMI_MCE] =3D {
> >>>>>> +        .name =3D "fwnmi-mce",
> >>>>>> +        .description =3D "Handle fwnmi machine check exceptions",
> >>>>>> +        .index =3D SPAPR_CAP_FWNMI_MCE,
> >>>>>> +        .get =3D spapr_cap_get_bool,
> >>>>>> +        .set =3D spapr_cap_set_bool,
> >>>>>> +        .type =3D "bool",
> >>>>>> +        .apply =3D cap_fwnmi_mce_apply,
> >>>>>> +    },
> >>>>>>  };
> >>>>>> =20
> >>>>>>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState =
*spapr,
> >>>>>> @@ -706,6 +731,7 @@ SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
> >>>>>>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
> >>>>>>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
> >>>>>>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> >>>>>> +SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
> >>>>>> =20
> >>>>>>  void spapr_caps_init(SpaprMachineState *spapr)
> >>>>>>  {
> >>>>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >>>>>> index d3499f9..997cf19 100644
> >>>>>> --- a/hw/ppc/spapr_rtas.c
> >>>>>> +++ b/hw/ppc/spapr_rtas.c
> >>>>>> @@ -49,6 +49,7 @@
> >>>>>>  #include "hw/ppc/fdt.h"
> >>>>>>  #include "target/ppc/mmu-hash64.h"
> >>>>>>  #include "target/ppc/mmu-book3s-v3.h"
> >>>>>> +#include "kvm_ppc.h"
> >>>>>> =20
> >>>>>>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineS=
tate *spapr,
> >>>>>>                                     uint32_t token, uint32_t nargs,
> >>>>>> @@ -354,6 +355,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *=
cpu,
> >>>>>>                                    target_ulong args,
> >>>>>>                                    uint32_t nret, target_ulong ret=
s)
> >>>>>>  {
> >>>>>> +    int ret;
> >>>>>>      uint64_t rtas_addr =3D spapr_get_rtas_addr();
> >>>>>> =20
> >>>>>>      if (!rtas_addr) {
> >>>>>> @@ -361,6 +363,18 @@ static void rtas_ibm_nmi_register(PowerPCCPU =
*cpu,
> >>>>>>          return;
> >>>>>>      }
> >>>>>> =20
> >>>>>> +    ret =3D kvmppc_fwnmi_enable(cpu);
> >>>>>
> >>>>> You shouldn't need this here as well as in cap_fwnmi_mce_apply().
> >>>>>
> >>>>> Instead, you should unconditionally fail the nmi-register if the
> >>>>> capability is not enabled.
> >>>>
> >>>> cap_fwnmi is not enabled by default, because if it is enabled by def=
ault
> >>>> them KVM will start routing machine check exceptions via guest exit
> >>>> instead of routing it to guest's 0x200.
> >>>>
> >>>> During early boot since guest has not yet issued nmi-register, KVM is
> >>>> expected to route exceptions to 0x200. Therefore we enable cap_fwnmi
> >>>> only when a guest issues nmi-register.
> >>>
> >>> Except that's not true - you enable it in cap_fwnmi_mce_apply() which
> >>> will be executed whenever the machine capability is enabled.
> >>
> >> I enable cap_fwnmi in cap_fwnmi_mce_apply() only when the "val" argume=
nt
> >> (which is the effective cap value) is set. In early boot "val" is not
> >> set as cap_fwnmi by default is not set, hence cap_fwnmi is not
> >> enabled.
> >=20
> > Uh.. if that's true, something else is horribly wrong.  SPAPR caps are
> > designed to have a fixed value for the lifetime of the VM.  Otherwise
> > they will fail in their purpose of making sure we have a consistent
> > environment across migrations.  So if the 'val' changes after the
> > first call to apply(), then something is broken.
>=20
> If SPAPR caps are initialized before boot that do not change later, then
> for cap_fwnmi, the default value is off at boot and the cap is enabled
> only when guest issues "ibm,nmi-register" call. Should SPAPR caps be
> updated when "ibm,nmi-register" is called?

So the confusing thing here is that there are spapr machine caps, and
those are separate from the KVM caps for the VM.  Then the KVM caps
also have whether the cap is possible and whether it is current
activated.

The spapr machine caps *must* remain static for the VM's lifetime and
only cover possibilities, not runtime configuration.  KVM caps may be
activated as necessary.

So you can leave activating the KVM cap until nmi-register.  But if
the spapr cap is disabled you must prohibit nmi-register.

The apply() functions are responsible for checking if the spapr caps
are possible on the KVM implementation.  So if cap_fwnmi_mci_apply()
is called with val=3D=3D1 and KVM doesn't support the fwnmi extensions, it
must fail outright.

> >> My understanding is that, cap_fwnmi_mce_apply() is also called during
> >> migration on the target machine.
> >=20
> > Only in the sense that the machine is initialized before processing
> > the incoming migration.  The capability values must be equal on either
> > side of the migration (that's checked elsewhere).  Well, actually,
> > you're allowed to increase the cap value across a migration, just not
> > decrease it.
>=20
> Ah.. ok.. I am still familiarizing myself with the migration code..
>=20
> >=20
> >> If effective cap for cap_fwnmi is
> >> enabled on source machine than I think "val" will be set when
> >> cap_fwnmi_mce_apply() is called on target machine.
> >=20
> > Nope.  The migrated value of the cap will be *validated* against the
> > value set on the destination setup, but it won't *alter* the value on
> > the destination (the result is that you have it enabled on the source,
> > but not the destination, the migration will fail).
>=20
> But if cap_fwnmi is set on the host, which function is responsible to

I'm not sure what you mean by "the host" here.

> enable it on the destination? I think cap_fwnmi_mce_apply() is
> responsible for enabling it on the destination.

Enabling the spapr cap?  It is set based on the command line and
machine type, just like on the source machine.

> If that is the case
> cap_fwnmi_mce_apply() should know if cap_fwnmi is set on the host and
> the only way it can check that is based on the "val" argument passed on
> to it.
>=20
> Or am I missing something here?

Probably, but I'm not sure exactly what.

The val argument to apply() is set to the value of the spapr cap.
This is based on the qemu command line and machine type, and must be
the same on source and destination.  As a general rule, qemu requires
that the same machine options are used on source and destination.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzcwLwACgkQbDjKyiDZ
s5Iqdg//WYOsLd5hEHVva2aE42LVwxHA6UJKrRDIJW9TYSy2J7UPIpjzaZwvPdcO
Rhe8Ang3O9gdvcWafytfTie42z/QEZP9ax68yG2pvuEzhuEa2TTGiCIzM7szyub/
NEEVv99jZu4jjUQMNUE37gaOlFcsJtkbmzzXZHA6J346GQ6fvjdG1hocibXjpzNy
My8XRxCKH8sOFIxYkamNCv+6Ttqq6QM43ZIkVlPxjKFD18BM92da5YHLLC3y8RKN
1Y5tvinR1Cyke87TGP6Xfo0tPLCNj5QiV/PB7zN1iYjNGqh8Jh9xzSjlEVHsRY2G
0YDlqwODRZzoUwh2+K5zlMti1piDJv/CbyIq7Ehvro7SssIR2HYVG5gSksUYZlnt
VtFUI4mZZjwOI7BM6uQhs2lw+obfY9c6/pKPup1zJ8kO3sXJuoWAZj9t9bOqq6Lg
d0637JFDmhGqDGrX6w4iBSun/BkeuPx8BK3wJlT/2q9v2LFnt51bzaLAmUskfuP4
0gQ8kGKjII5x5YuzCG09yQryCDGH9mGldEpZSNdj7QW37uTGouv71TRdF1/cB8Pu
gPQL2+Ib3wKcB1xg+1YqKQwYIqqE0tSsuFnC/QjqGmg4D7BvnK4aAB1SH0eeGRyZ
B6GZRAOqEvj6HtXo6/JXqORjugMAJ3NkHNk3ZZKpJFN37zk0MB8=
=McZm
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--

