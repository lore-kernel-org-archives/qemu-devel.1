Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077D3C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2188207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lK0TAnS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2188207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY24d-0000qY-TT
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 02:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jY23b-0007uV-Bu; Mon, 11 May 2020 02:36:55 -0400
Received: from ozlabs.org ([203.11.71.1]:37441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jY23Y-000742-VA; Mon, 11 May 2020 02:36:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49LB6l0xkgz9sTH; Mon, 11 May 2020 16:36:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589179007;
 bh=fpH8RoaCbdgmGjevZaV5wDdi3Q9Hoi0Q1eGkanzgnyo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lK0TAnS6c+FlkjGAm/SUJtCwQKvVMjWkE6tIWV/yKS1CYip4oqnU80muSUmEMxThr
 yIuBM5pgY7b+qW4jnCwoaQ+I4OFmIdncOA5Y/cAkmIJE48f9JdqAIM72nk+Dw6Wmv/
 b0Hyc29VDY2q6FNfPQZcozDTQEVMmWyqQXAN5OYY=
Date: Mon, 11 May 2020 16:27:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu] spapr: Add PVR setting capability
Message-ID: <20200511062701.GQ2183@umbus.fritz.box>
References: <20200417041105.63563-1-aik@ozlabs.ru>
 <20200504133027.4f5a18f8@bahia.lan>
 <15bdf96d-c617-665e-09cd-f4f0e0f107e4@ozlabs.ru>
 <20200505055007.GD218517@umbus.fritz.box>
 <7f7467ea-7919-f642-5bbe-083c34a018f5@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uRjmd8ppyyws0Tml"
Content-Disposition: inline
In-Reply-To: <7f7467ea-7919-f642-5bbe-083c34a018f5@ozlabs.ru>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:36:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uRjmd8ppyyws0Tml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 04:18:40PM +1000, Alexey Kardashevskiy wrote:
>=20
>=20
> On 05/05/2020 15:50, David Gibson wrote:
> > On Tue, May 05, 2020 at 10:56:17AM +1000, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 04/05/2020 21:30, Greg Kurz wrote:
> >>> On Fri, 17 Apr 2020 14:11:05 +1000
> >>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>
> >>>> At the moment the VCPU init sequence includes setting PVR which in c=
ase of
> >>>> KVM-HV only checks if it matches the hardware PVR mask as PVR cannot=
 be
> >>>> virtualized by the hardware. In order to cope with various CPU revis=
ions
> >>>> only top 16bit of PVR are checked which works for minor revision upd=
ates.
> >>>>
> >>>> However in every CPU generation starting POWER7 (at least) there wer=
e CPUs
> >>>> supporting the (almost) same POWER ISA level but having different top
> >>>> 16bits of PVR - POWER7+, POWER8E, POWER8NVL; this time we got POWER9+
> >>>> with a new PVR family. We would normally add the PVR mask for the ne=
w one
> >>>> too, the problem with it is that although the physical machines exis=
t,
> >>>> P9+ is not going to be released as a product, and this situation is =
likely
> >>>> to repeat in the future.
> >>>>
> >>>> Instead of adding every new CPU family in QEMU, this adds a new sPAPR
> >>>> machine capability to force PVR setting/checking. It is "on" by defa=
ult
> >>>> to preserve the existing behavior. When "off", it is the user's
> >>>> responsibility to specify the correct CPU.
> >>>>
> >>>
> >>> I don't quite understand the motivation for this... what does this
> >>> buy us ?
> >>
> >> I answered that part in another mail in this thread, shortly this is to
> >> make QEMU work with HV KVM on unknown-to-QEMU CPU family (0x004f0000).
> >>
> >>
> >>>
> >>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>> ---
> >>>>  include/hw/ppc/spapr.h |  5 ++++-
> >>>>  hw/ppc/spapr.c         |  1 +
> >>>>  hw/ppc/spapr_caps.c    | 18 ++++++++++++++++++
> >>>>  target/ppc/kvm.c       | 16 ++++++++++++++--
> >>>>  4 files changed, 37 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >>>> index e579eaf28c05..5ccac4d56871 100644
> >>>> --- a/include/hw/ppc/spapr.h
> >>>> +++ b/include/hw/ppc/spapr.h
> >>>> @@ -81,8 +81,10 @@ typedef enum {
> >>>>  #define SPAPR_CAP_CCF_ASSIST            0x09
> >>>>  /* Implements PAPR FWNMI option */
> >>>>  #define SPAPR_CAP_FWNMI                 0x0A
> >>>> +/* Implements PAPR PVR option */
> >>>> +#define SPAPR_CAP_PVR                   0x0B
> >>>>  /* Num Caps */
> >>>> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI + 1)
> >>>> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_PVR + 1)
> >>>> =20
> >>>>  /*
> >>>>   * Capability Values
> >>>> @@ -912,6 +914,7 @@ extern const VMStateDescription vmstate_spapr_ca=
p_nested_kvm_hv;
> >>>>  extern const VMStateDescription vmstate_spapr_cap_large_decr;
> >>>>  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
> >>>>  extern const VMStateDescription vmstate_spapr_cap_fwnmi;
> >>>> +extern const VMStateDescription vmstate_spapr_cap_pvr;
> >>>> =20
> >>>>  static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int c=
ap)
> >>>>  {
> >>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>> index 841b5ec59b12..ecc74c182b9f 100644
> >>>> --- a/hw/ppc/spapr.c
> >>>> +++ b/hw/ppc/spapr.c
> >>>> @@ -4535,6 +4535,7 @@ static void spapr_machine_class_init(ObjectCla=
ss *oc, void *data)
> >>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_C=
AP_ON;
> >>>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_ON;
> >>>>      smc->default_caps.caps[SPAPR_CAP_FWNMI] =3D SPAPR_CAP_ON;
> >>>> +    smc->default_caps.caps[SPAPR_CAP_PVR] =3D SPAPR_CAP_ON;
> >>>>      spapr_caps_add_properties(smc, &error_abort);
> >>>>      smc->irq =3D &spapr_irq_dual;
> >>>>      smc->dr_phb_enabled =3D true;
> >>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >>>> index eb54f9422722..398b72b77f9f 100644
> >>>> --- a/hw/ppc/spapr_caps.c
> >>>> +++ b/hw/ppc/spapr_caps.c
> >>>> @@ -525,6 +525,14 @@ static void cap_fwnmi_apply(SpaprMachineState *=
spapr, uint8_t val,
> >>>>      }
> >>>>  }
> >>>> =20
> >>>> +static void cap_pvr_apply(SpaprMachineState *spapr, uint8_t val, Er=
ror **errp)
> >>>> +{
> >>>> +    if (val) {
> >>>> +        return;
> >>>> +    }
> >>>> +    warn_report("If you're uing kvm-hv.ko, only \"-cpu host\" is su=
pported");
> >>>> +}
> >>>> +
> >>>>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> >>>>      [SPAPR_CAP_HTM] =3D {
> >>>>          .name =3D "htm",
> >>>> @@ -633,6 +641,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_=
NUM] =3D {
> >>>>          .type =3D "bool",
> >>>>          .apply =3D cap_fwnmi_apply,
> >>>>      },
> >>>> +    [SPAPR_CAP_PVR] =3D {
> >>>> +        .name =3D "pvr",
> >>>> +        .description =3D "Enforce PVR in KVM",
> >>>> +        .index =3D SPAPR_CAP_PVR,
> >>>> +        .get =3D spapr_cap_get_bool,
> >>>> +        .set =3D spapr_cap_set_bool,
> >>>> +        .type =3D "bool",
> >>>> +        .apply =3D cap_pvr_apply,
> >>>> +    },
> >>>>  };
> >>>> =20
> >>>>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *s=
papr,
> >>>> @@ -773,6 +790,7 @@ SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NES=
TED_KVM_HV);
> >>>>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
> >>>>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> >>>>  SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
> >>>> +SPAPR_CAP_MIG_STATE(pvr, SPAPR_CAP_PVR);
> >>>> =20
> >>>>  void spapr_caps_init(SpaprMachineState *spapr)
> >>>>  {
> >>>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> >>>> index 03d0667e8f94..a4adc29b6522 100644
> >>>> --- a/target/ppc/kvm.c
> >>>> +++ b/target/ppc/kvm.c
> >>>> @@ -466,15 +466,27 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >>>>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >>>>      CPUPPCState *cenv =3D &cpu->env;
> >>>>      int ret;
> >>>> +    SpaprMachineState *spapr;
> >>>> =20
> >>>
> >>> We generally try to avoid adding such explicit dependencies to the
> >>> machine code within the target directory... A virtual hypervisor
> >>> hook could possibly do the trick but this would require to set
> >>> PowerPCCPU::vhyp before kvm_arch_init_vcpu() gets called, eg.
> >>> when the vCPU is created in spapr_create_vcpu() rather than
> >>> when it gets realized.
> >>
> >> The only thing kvm_arch_sync_sregs() does is setting PVR, and it does
> >> not do even that for Book3E so there is dependency already, mine at
> >> least explicit :)
> >>
> >> I am really not sure what setting PVR buys us, KVM PR will take
> >> anything,
> >=20
> > PR will take anything, but it changes the behaviour.  Basically PR
> > will try to match its behaviour to the PVR you specify.  It can't
> > entirely succeeed in all cases, of course, but that's PR for you.
> >
> > From an API point of view, the idea is that setting the PVR here
> > specifies the model you want the vcpu to appear to be.  But, KVM is
> > free to say "can't do that".
>=20
>=20
> Except pseries does not care what the CPU appears to be and uses
> KVM_REG_PPC_ARCH_COMPAT instead.

I'm not really sure what you mean by that.  The exact cpu model can be
relevant for pseries in certain edge cases, although in most cases
it's the compat mode that will matter in practice.

> So, is this a no? Thanks,

Yes, although not really for the reasons above.  As you say this is
just for the handful of people who have never-released machines, which
makes this some ugly and confusing cruft for nearly everyone.  So, I'm
more inclined to say that if you happen to have one of those machines,
you get to apply the workaround patch yourself.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uRjmd8ppyyws0Tml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl648DUACgkQbDjKyiDZ
s5Kf5A//daTfKGY00o1U7bsgt1jIkjeOvcQ0TCRPd+d99ZIUab+kNuBhz7CYqWLH
301qDH+SV5iNXSCaCDnO7WErQSBcJFB2f+xW8kEpeGrJ38GPeVoKmoy+rKi87fkM
cd/XecWdePakJSiwV3bNulKIB3ISndZk1I5kGeQDglvlGFbjHwhbw9pSDonO0wWF
PvCCAA6t+CFbB1EFgSQU9aTLeaXg4y1wsI0NihtaDQYOfLnBc/dDdRWQdJylatBH
ulhQPeiqzzz36RmnWOoeYWsjm/Qr8ajJd5DtNVJTDw48CNeMggHSN2GQq7noshLl
LXmyxaQ1isMDG/PbzxZdNhlKxVRJclRduDo/GGlNtBJf72TwsmV8SnAFRQmsjxib
aqyWPQhS229k3TEQ5Ls2MY/1sTqUu2KZGK8ORmWyLQbz7rlTW16JrWweC/0IEz7M
tTyWEyMlG2+gTCHyx9sMSleFFhc0rArL8sNPPUrcH4eiUzp3jVT6M77OP6S9oYhn
sltpdmTHnK6VCgMx1nIcd8iKEayLWr3KXQXZbQiiJuqjZ5JxlDZrqJafNdq1XLxV
Fwqu5TxkH/iyLbZhtGUEyQdwQggzQ1AZqNbfDmBjYgchqo6Mu08ccEs2b4NsHdZf
1jSOpgQKyv1P8xlSeS5kJkXPZxCsYzp6e5UWCtCEHDQzLIY65fA=
=ACLh
-----END PGP SIGNATURE-----

--uRjmd8ppyyws0Tml--

