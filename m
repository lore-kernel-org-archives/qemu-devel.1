Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D272C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 06:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F865206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 06:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="W9AsIHmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F865206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVqcb-0002cE-3T
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 02:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jVqb4-0000gf-MG; Tue, 05 May 2020 01:58:26 -0400
Received: from ozlabs.org ([203.11.71.1]:36827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jVqb2-0001gw-4Y; Tue, 05 May 2020 01:58:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49GTY71BB7z9sSs; Tue,  5 May 2020 15:58:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588658299;
 bh=WQc/B/IOCA/MIhanqT2LfkPRDPTRJsQbQjmGugfqXvU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W9AsIHmumofmXCKNomroi3/asKDHk6Bi00/2XEhms+71A3GMUMQGJqK2AmJo/+o+a
 r/d+6A6olSN9Rf3Iu36WW6AbkUEwObOBKXMvVwpxOKtZ4QSv+Xq7TqGJBL3ptdMgj6
 T+nfPutYkKQ+4THyuXo+Q2kQaAhqSRJ+s6Byk0Ss=
Date: Tue, 5 May 2020 15:50:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu] spapr: Add PVR setting capability
Message-ID: <20200505055007.GD218517@umbus.fritz.box>
References: <20200417041105.63563-1-aik@ozlabs.ru>
 <20200504133027.4f5a18f8@bahia.lan>
 <15bdf96d-c617-665e-09cd-f4f0e0f107e4@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <15bdf96d-c617-665e-09cd-f4f0e0f107e4@ozlabs.ru>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 01:03:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 10:56:17AM +1000, Alexey Kardashevskiy wrote:
>=20
>=20
> On 04/05/2020 21:30, Greg Kurz wrote:
> > On Fri, 17 Apr 2020 14:11:05 +1000
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >=20
> >> At the moment the VCPU init sequence includes setting PVR which in cas=
e of
> >> KVM-HV only checks if it matches the hardware PVR mask as PVR cannot be
> >> virtualized by the hardware. In order to cope with various CPU revisio=
ns
> >> only top 16bit of PVR are checked which works for minor revision updat=
es.
> >>
> >> However in every CPU generation starting POWER7 (at least) there were =
CPUs
> >> supporting the (almost) same POWER ISA level but having different top
> >> 16bits of PVR - POWER7+, POWER8E, POWER8NVL; this time we got POWER9+
> >> with a new PVR family. We would normally add the PVR mask for the new =
one
> >> too, the problem with it is that although the physical machines exist,
> >> P9+ is not going to be released as a product, and this situation is li=
kely
> >> to repeat in the future.
> >>
> >> Instead of adding every new CPU family in QEMU, this adds a new sPAPR
> >> machine capability to force PVR setting/checking. It is "on" by default
> >> to preserve the existing behavior. When "off", it is the user's
> >> responsibility to specify the correct CPU.
> >>
> >=20
> > I don't quite understand the motivation for this... what does this
> > buy us ?
>=20
> I answered that part in another mail in this thread, shortly this is to
> make QEMU work with HV KVM on unknown-to-QEMU CPU family (0x004f0000).
>=20
>=20
> >=20
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>  include/hw/ppc/spapr.h |  5 ++++-
> >>  hw/ppc/spapr.c         |  1 +
> >>  hw/ppc/spapr_caps.c    | 18 ++++++++++++++++++
> >>  target/ppc/kvm.c       | 16 ++++++++++++++--
> >>  4 files changed, 37 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index e579eaf28c05..5ccac4d56871 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -81,8 +81,10 @@ typedef enum {
> >>  #define SPAPR_CAP_CCF_ASSIST            0x09
> >>  /* Implements PAPR FWNMI option */
> >>  #define SPAPR_CAP_FWNMI                 0x0A
> >> +/* Implements PAPR PVR option */
> >> +#define SPAPR_CAP_PVR                   0x0B
> >>  /* Num Caps */
> >> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI + 1)
> >> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_PVR + 1)
> >> =20
> >>  /*
> >>   * Capability Values
> >> @@ -912,6 +914,7 @@ extern const VMStateDescription vmstate_spapr_cap_=
nested_kvm_hv;
> >>  extern const VMStateDescription vmstate_spapr_cap_large_decr;
> >>  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
> >>  extern const VMStateDescription vmstate_spapr_cap_fwnmi;
> >> +extern const VMStateDescription vmstate_spapr_cap_pvr;
> >> =20
> >>  static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
> >>  {
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 841b5ec59b12..ecc74c182b9f 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -4535,6 +4535,7 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
> >>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP=
_ON;
> >>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_ON;
> >>      smc->default_caps.caps[SPAPR_CAP_FWNMI] =3D SPAPR_CAP_ON;
> >> +    smc->default_caps.caps[SPAPR_CAP_PVR] =3D SPAPR_CAP_ON;
> >>      spapr_caps_add_properties(smc, &error_abort);
> >>      smc->irq =3D &spapr_irq_dual;
> >>      smc->dr_phb_enabled =3D true;
> >> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >> index eb54f9422722..398b72b77f9f 100644
> >> --- a/hw/ppc/spapr_caps.c
> >> +++ b/hw/ppc/spapr_caps.c
> >> @@ -525,6 +525,14 @@ static void cap_fwnmi_apply(SpaprMachineState *sp=
apr, uint8_t val,
> >>      }
> >>  }
> >> =20
> >> +static void cap_pvr_apply(SpaprMachineState *spapr, uint8_t val, Erro=
r **errp)
> >> +{
> >> +    if (val) {
> >> +        return;
> >> +    }
> >> +    warn_report("If you're uing kvm-hv.ko, only \"-cpu host\" is supp=
orted");
> >> +}
> >> +
> >>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> >>      [SPAPR_CAP_HTM] =3D {
> >>          .name =3D "htm",
> >> @@ -633,6 +641,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NU=
M] =3D {
> >>          .type =3D "bool",
> >>          .apply =3D cap_fwnmi_apply,
> >>      },
> >> +    [SPAPR_CAP_PVR] =3D {
> >> +        .name =3D "pvr",
> >> +        .description =3D "Enforce PVR in KVM",
> >> +        .index =3D SPAPR_CAP_PVR,
> >> +        .get =3D spapr_cap_get_bool,
> >> +        .set =3D spapr_cap_set_bool,
> >> +        .type =3D "bool",
> >> +        .apply =3D cap_pvr_apply,
> >> +    },
> >>  };
> >> =20
> >>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spa=
pr,
> >> @@ -773,6 +790,7 @@ SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTE=
D_KVM_HV);
> >>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
> >>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> >>  SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
> >> +SPAPR_CAP_MIG_STATE(pvr, SPAPR_CAP_PVR);
> >> =20
> >>  void spapr_caps_init(SpaprMachineState *spapr)
> >>  {
> >> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> >> index 03d0667e8f94..a4adc29b6522 100644
> >> --- a/target/ppc/kvm.c
> >> +++ b/target/ppc/kvm.c
> >> @@ -466,15 +466,27 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >>      CPUPPCState *cenv =3D &cpu->env;
> >>      int ret;
> >> +    SpaprMachineState *spapr;
> >> =20
> >=20
> > We generally try to avoid adding such explicit dependencies to the
> > machine code within the target directory... A virtual hypervisor
> > hook could possibly do the trick but this would require to set
> > PowerPCCPU::vhyp before kvm_arch_init_vcpu() gets called, eg.
> > when the vCPU is created in spapr_create_vcpu() rather than
> > when it gets realized.
>=20
> The only thing kvm_arch_sync_sregs() does is setting PVR, and it does
> not do even that for Book3E so there is dependency already, mine at
> least explicit :)
>=20
> I am really not sure what setting PVR buys us, KVM PR will take
> anything,

PR will take anything, but it changes the behaviour.  Basically PR
will try to match its behaviour to the PVR you specify.  It can't
entirely succeeed in all cases, of course, but that's PR for you.

=46rom an API point of view, the idea is that setting the PVR here
specifies the model you want the vcpu to appear to be.  But, KVM is
free to say "can't do that".

> KVM HV will only take the same family PVR and reject others
> while it could still run more configurations, let's say -cpu POWER8 on
> actual POWER9 machine. Dunno. The capability seems a harmless way of
> relaxing this restriction. Thanks,
>=20
>=20
>=20
>=20
> >=20
> >>      /* Synchronize sregs with kvm */
> >>      ret =3D kvm_arch_sync_sregs(cpu);
> >>      if (ret) {
> >>          if (ret =3D=3D -EINVAL) {
> >>              error_report("Register sync failed... If you're using kvm=
-hv.ko,"
> >> -                         " only \"-cpu host\" is possible");
> >> +                         " only \"-cpu host\" is supported");
> >> +        }
> >> +        /*
> >> +         * The user chose not to set PVR which makes sense if we are =
running
> >> +         * on a CPU with known ISA level but unknown PVR.
> >> +         */
> >> +        spapr =3D (SpaprMachineState *)
> >> +            object_dynamic_cast(OBJECT(qdev_get_machine()), TYPE_SPAP=
R_MACHINE);
> >> +
> >> +        if (spapr && spapr->eff.caps[SPAPR_CAP_PVR] =3D=3D SPAPR_CAP_=
OFF) {
> >> +            ret =3D 0;
> >> +        } else {
> >> +            return ret;
> >>          }
> >> -        return ret;
> >>      }
> >> =20
> >>      switch (cenv->mmu_model) {
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6w/owACgkQbDjKyiDZ
s5JI7xAAyUaN0UcQWIOXEu6b44FOSIz6XK9uftqLiTLq5oHtdylT9wXYStENX0o1
5eod8cF5ePgLZJqZ/n5lcIOVRQqgyG7uJsVsSwXncBlfWqO4JEDg22TFz90aqsqz
ebDDWaRId+xZlpgiKSneLDTzTsG6OYLtXEw6MUtpHRcGb/N9VRhTitz4udqpraRp
fpycsUm30IXme4hB6/1Ouj2KSL06Uf8fF1USBvoPZnD4eZ4Xx97OozT/w312MFkQ
mfkjuKOlfEDDDM/KN6Wlh0hDptiL29QbQXeSiS6qVx44c7ytzICcKovpb8Ke8GdW
vDPhI33or0uC1xgQ4a8CSHacIIHSIOkieOIQOGmX4evNrh4GmnVX3n0mgwOSjL/B
cyqbquaKMHAyY4lNQrt0HRGU4+IuNmCSjkuUxHm8L7SeJvtcfo/lH5RDEJSVR8Eo
A+B0wsKIwCvMWmy6+8PXNdd/vD1n6SaQK2Q6DvkcfPEmnA89bGaZ+E6a2YHO88Ok
3uDoQ+iF0HuRcxqAak7nSd+W0pTn1W6tqSq1xuEBbjxiVLOGp02p0u2n64hGw0OJ
XRA0ds1LbHhQrq2/sHTgLwrYOnLtK9lIXfF1UEsZXjduPwYObwvXtsg5ohmPI3A8
2Z4ghADQ7V9RoiWJM8eWAvqU4XgNxe/i0Oo/9iRw2bloh4A7XAo=
=xEYq
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--

