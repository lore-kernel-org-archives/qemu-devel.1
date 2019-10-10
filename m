Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A873C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 06:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF572067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 06:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF572067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIS0F-0003nV-CJ
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 02:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iIRxp-0001mW-Jg
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 02:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iIRxm-0007Ie-QY
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 02:30:17 -0400
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:41725)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iIRxm-0007Hm-Fd
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 02:30:14 -0400
Received: from player159.ha.ovh.net (unknown [10.109.160.244])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 23A7813695A
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 08:30:11 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id A5749AB17C54;
 Thu, 10 Oct 2019 06:29:59 +0000 (UTC)
Date: Thu, 10 Oct 2019 08:29:58 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 17/19] spapr: Remove last pieces of SpaprIrq
Message-ID: <20191010082958.12e17561@bahia.lan>
In-Reply-To: <20191010020209.GC28552@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-18-david@gibson.dropbear.id.au>
 <20191009190215.7e05c017@bahia.lan>
 <20191010020209.GC28552@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=9h=VUhGDF_G11agvjHDGbf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 14984320388865366502
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedriedvgdduuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.173.157
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/=9h=VUhGDF_G11agvjHDGbf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Oct 2019 13:02:09 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Oct 09, 2019 at 07:02:15PM +0200, Greg Kurz wrote:
> > On Wed,  9 Oct 2019 17:08:16 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > The only thing remaining in this structure are the flags to allow eit=
her
> > > XICS or XIVE to be present.  These actually make more sense as spapr
> > > capabilities - that way they can take advantage of the existing
> > > infrastructure to sanity check capability states across migration and=
 so
> > > forth.
> > >=20
> >=20
> > The user can now choose the interrupt controller mode either through
> > ic-mode or through cap-xics/cap-xive. I guess it doesn't break anything
> > to expose another API to do the same thing but it raises some questions.
> >=20
> > We should at least document somewhere that ic-mode is an alias to these
> > caps, and maybe state which is the preferred method (I personally vote
> > for the caps).
> >=20
> > Also, we must keep ic-mode for the moment to stay compatible with the
> > existing pseries-4.0 and pseries-4.1 machine types, but will we
> > keep ic-mode forever ? If no, maybe start by not allowing it for
> > pseries-4.2 ?
>=20
> I'm actually inclined to keep it for now, maybe even leave it as the
> suggested way to configure this.  The caps are nice from an internal
> organization point of view, but ic-mode is arguably a more user
> friendly way of configuring it.  The conversion of one to the other is
> straightforward, isolated ans small, so I'm not especially bothered by
> keeping it around.
>=20

Fair enough.

Reviewed-by: Greg Kurz <groug@kaod.org>

> >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  hw/ppc/spapr.c             | 40 ++++++++++--------
> > >  hw/ppc/spapr_caps.c        | 64 +++++++++++++++++++++++++++++
> > >  hw/ppc/spapr_hcall.c       |  7 ++--
> > >  hw/ppc/spapr_irq.c         | 84 ++----------------------------------=
--
> > >  include/hw/ppc/spapr.h     | 10 +++--
> > >  include/hw/ppc/spapr_irq.h | 10 -----
> > >  6 files changed, 103 insertions(+), 112 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index e1ff03152e..bf9fdb1693 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1072,12 +1072,13 @@ static void spapr_dt_ov5_platform_support(Spa=
prMachineState *spapr, void *fdt,
> > >          26, 0x40, /* Radix options: GTSE =3D=3D yes. */
> > >      };
> > > =20
> > > -    if (spapr->irq->xics && spapr->irq->xive) {
> > > +    if (spapr_get_cap(spapr, SPAPR_CAP_XICS)
> > > +        && spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
> > >          val[1] =3D SPAPR_OV5_XIVE_BOTH;
> > > -    } else if (spapr->irq->xive) {
> > > +    } else if (spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
> > >          val[1] =3D SPAPR_OV5_XIVE_EXPLOIT;
> > >      } else {
> > > -        assert(spapr->irq->xics);
> > > +        assert(spapr_get_cap(spapr, SPAPR_CAP_XICS));
> > >          val[1] =3D SPAPR_OV5_XIVE_LEGACY;
> > >      }
> > > =20
> > > @@ -2075,6 +2076,8 @@ static const VMStateDescription vmstate_spapr =
=3D {
> > >          &vmstate_spapr_dtb,
> > >          &vmstate_spapr_cap_large_decr,
> > >          &vmstate_spapr_cap_ccf_assist,
> > > +        &vmstate_spapr_cap_xics,
> > > +        &vmstate_spapr_cap_xive,
> > >          NULL
> > >      }
> > >  };
> > > @@ -2775,7 +2778,7 @@ static void spapr_machine_init(MachineState *ma=
chine)
> > >      spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
> > > =20
> > >      /* advertise XIVE on POWER9 machines */
> > > -    if (spapr->irq->xive) {
> > > +    if (spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
> > >          spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
> > >      }
> > > =20
> > > @@ -3242,14 +3245,18 @@ static void spapr_set_vsmt(Object *obj, Visit=
or *v, const char *name,
> > >  static char *spapr_get_ic_mode(Object *obj, Error **errp)
> > >  {
> > >      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> > > =20
> > > -    if (spapr->irq =3D=3D &spapr_irq_xics_legacy) {
> > > +    if (smc->legacy_irq_allocation) {
> > >          return g_strdup("legacy");
> > > -    } else if (spapr->irq =3D=3D &spapr_irq_xics) {
> > > +    } else if (spapr_get_cap(spapr, SPAPR_CAP_XICS)
> > > +               && !spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
> > >          return g_strdup("xics");
> > > -    } else if (spapr->irq =3D=3D &spapr_irq_xive) {
> > > +    } else if (!spapr_get_cap(spapr, SPAPR_CAP_XICS)
> > > +               && spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
> > >          return g_strdup("xive");
> > > -    } else if (spapr->irq =3D=3D &spapr_irq_dual) {
> > > +    } else if (spapr_get_cap(spapr, SPAPR_CAP_XICS)
> > > +               && spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
> > >          return g_strdup("dual");
> > >      }
> > >      g_assert_not_reached();
> > > @@ -3266,11 +3273,14 @@ static void spapr_set_ic_mode(Object *obj, co=
nst char *value, Error **errp)
> > > =20
> > >      /* The legacy IRQ backend can not be set */
> > >      if (strcmp(value, "xics") =3D=3D 0) {
> > > -        spapr->irq =3D &spapr_irq_xics;
> > > +        object_property_set_bool(obj, true, "cap-xics", errp);
> > > +        object_property_set_bool(obj, false, "cap-xive", errp);
> > >      } else if (strcmp(value, "xive") =3D=3D 0) {
> > > -        spapr->irq =3D &spapr_irq_xive;
> > > +        object_property_set_bool(obj, false, "cap-xics", errp);
> > > +        object_property_set_bool(obj, true, "cap-xive", errp);
> > >      } else if (strcmp(value, "dual") =3D=3D 0) {
> > > -        spapr->irq =3D &spapr_irq_dual;
> > > +        object_property_set_bool(obj, true, "cap-xics", errp);
> > > +        object_property_set_bool(obj, true, "cap-xive", errp);
> > >      } else {
> > >          error_setg(errp, "Bad value for \"ic-mode\" property");
> > >      }
> > > @@ -3309,7 +3319,6 @@ static void spapr_set_host_serial(Object *obj, =
const char *value, Error **errp)
> > >  static void spapr_instance_init(Object *obj)
> > >  {
> > >      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > -    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> > > =20
> > >      spapr->htab_fd =3D -1;
> > >      spapr->use_hotplug_event_source =3D true;
> > > @@ -3345,7 +3354,6 @@ static void spapr_instance_init(Object *obj)
> > >                               spapr_get_msix_emulation, NULL, NULL);
> > > =20
> > >      /* The machine class defines the default interrupt controller mo=
de */
> > > -    spapr->irq =3D smc->irq;
> > >      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
> > >                              spapr_set_ic_mode, NULL);
> > >      object_property_set_description(obj, "ic-mode",
> > > @@ -4439,8 +4447,9 @@ static void spapr_machine_class_init(ObjectClas=
s *oc, void *data)
> > >      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OF=
F;
> > >      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CA=
P_ON;
> > >      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> > > +    smc->default_caps.caps[SPAPR_CAP_XICS] =3D SPAPR_CAP_ON;
> > > +    smc->default_caps.caps[SPAPR_CAP_XIVE] =3D SPAPR_CAP_ON;
> > >      spapr_caps_add_properties(smc, &error_abort);
> > > -    smc->irq =3D &spapr_irq_dual;
> > >      smc->dr_phb_enabled =3D true;
> > >      smc->linux_pci_probe =3D true;
> > >      smc->nr_xirqs =3D SPAPR_NR_XIRQS;
> > > @@ -4539,7 +4548,7 @@ static void spapr_machine_4_0_class_options(Mac=
hineClass *mc)
> > >      spapr_machine_4_1_class_options(mc);
> > >      compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_=
len);
> > >      smc->phb_placement =3D phb_placement_4_0;
> > > -    smc->irq =3D &spapr_irq_xics;
> > > +    smc->default_caps.caps[SPAPR_CAP_XIVE] =3D SPAPR_CAP_OFF;
> > >      smc->pre_4_1_migration =3D true;
> > >  }
> > > =20
> > > @@ -4580,7 +4589,6 @@ static void spapr_machine_3_0_class_options(Mac=
hineClass *mc)
> > > =20
> > >      smc->legacy_irq_allocation =3D true;
> > >      smc->nr_xirqs =3D 0x400;
> > > -    smc->irq =3D &spapr_irq_xics_legacy;
> > >  }
> > > =20
> > >  DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
> > > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > > index 481dfd2a27..e06fd386f6 100644
> > > --- a/hw/ppc/spapr_caps.c
> > > +++ b/hw/ppc/spapr_caps.c
> > > @@ -496,6 +496,42 @@ static void cap_ccf_assist_apply(SpaprMachineSta=
te *spapr, uint8_t val,
> > >      }
> > >  }
> > > =20
> > > +static void cap_xics_apply(SpaprMachineState *spapr, uint8_t val, Er=
ror **errp)
> > > +{
> > > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> > > +
> > > +    if (!val) {
> > > +        if (!spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
> > > +            error_setg(errp,
> > > +"No interrupt controllers enabled, try cap-xics=3Don or cap-xive=3Do=
n");
> > > +            return;
> > > +        }
> > > +
> > > +        if (smc->legacy_irq_allocation) {
> > > +            error_setg(errp, "This machine version requires XICS sup=
port");
> > > +            return;
> > > +        }
> > > +    }
> > > +}
> > > +
> > > +static void cap_xive_apply(SpaprMachineState *spapr, uint8_t val, Er=
ror **errp)
> > > +{
> > > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> > > +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> > > +
> > > +    if (val) {
> > > +        if (smc->legacy_irq_allocation) {
> > > +            error_setg(errp, "This machine version cannot support XI=
VE");
> > > +            return;
> > > +        }
> > > +        if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> > > +                              spapr->max_compat_pvr)) {
> > > +            error_setg(errp, "XIVE requires POWER9 CPU");
> > > +            return;
> > > +        }
> > > +    }
> > > +}
> > > +
> > >  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> > >      [SPAPR_CAP_HTM] =3D {
> > >          .name =3D "htm",
> > > @@ -595,6 +631,24 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_N=
UM] =3D {
> > >          .type =3D "bool",
> > >          .apply =3D cap_ccf_assist_apply,
> > >      },
> > > +    [SPAPR_CAP_XICS] =3D {
> > > +        .name =3D "xics",
> > > +        .description =3D "Allow XICS interrupt controller",
> > > +        .index =3D SPAPR_CAP_XICS,
> > > +        .get =3D spapr_cap_get_bool,
> > > +        .set =3D spapr_cap_set_bool,
> > > +        .type =3D "bool",
> > > +        .apply =3D cap_xics_apply,
> > > +    },
> > > +    [SPAPR_CAP_XIVE] =3D {
> > > +        .name =3D "xive",
> > > +        .description =3D "Allow XIVE interrupt controller",
> > > +        .index =3D SPAPR_CAP_XIVE,
> > > +        .get =3D spapr_cap_get_bool,
> > > +        .set =3D spapr_cap_set_bool,
> > > +        .type =3D "bool",
> > > +        .apply =3D cap_xive_apply,
> > > +    },
> > >  };
> > > =20
> > >  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *sp=
apr,
> > > @@ -641,6 +695,14 @@ static SpaprCapabilities default_caps_with_cpu(S=
paprMachineState *spapr,
> > >          caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D mps;
> > >      }
> > > =20
> > > +    /*
> > > +     * POWER8 machines don't have XIVE
> > > +     */
> > > +    if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_3_00,
> > > +                               0, spapr->max_compat_pvr)) {
> > > +        caps.caps[SPAPR_CAP_XIVE] =3D SPAPR_CAP_OFF;
> > > +    }
> > > +
> > >      return caps;
> > >  }
> > > =20
> > > @@ -734,6 +796,8 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HP=
T_MAXPAGESIZE);
> > >  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
> > >  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
> > >  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> > > +SPAPR_CAP_MIG_STATE(xics, SPAPR_CAP_XICS);
> > > +SPAPR_CAP_MIG_STATE(xive, SPAPR_CAP_XIVE);
> > > =20
> > >  void spapr_caps_init(SpaprMachineState *spapr)
> > >  {
> > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > index 140f05c1c6..cb4c6edf63 100644
> > > --- a/hw/ppc/spapr_hcall.c
> > > +++ b/hw/ppc/spapr_hcall.c
> > > @@ -1784,13 +1784,13 @@ static target_ulong h_client_architecture_sup=
port(PowerPCCPU *cpu,
> > >       * terminate the boot.
> > >       */
> > >      if (guest_xive) {
> > > -        if (!spapr->irq->xive) {
> > > +        if (!spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
> > >              error_report(
> > >  "Guest requested unavailable interrupt mode (XIVE), try the ic-mode=
=3Dxive or ic-mode=3Ddual machine property");
> > >              exit(EXIT_FAILURE);
> > >          }
> > >      } else {
> > > -        if (!spapr->irq->xics) {
> > > +        if (!spapr_get_cap(spapr, SPAPR_CAP_XICS)) {
> > >              error_report(
> > >  "Guest requested unavailable interrupt mode (XICS), either don't set=
 the ic-mode machine property or try ic-mode=3Dxics or ic-mode=3Ddual");
> > >              exit(EXIT_FAILURE);
> > > @@ -1804,7 +1804,8 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
> > >       */
> > >      if (!spapr->cas_reboot) {
> > >          spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_=
EXPLOIT)
> > > -            && spapr->irq->xics && spapr->irq->xive;
> > > +            && spapr_get_cap(spapr, SPAPR_CAP_XICS)
> > > +            && spapr_get_cap(spapr, SPAPR_CAP_XIVE);
> > >      }
> > > =20
> > >      spapr_ovec_cleanup(ov5_updates);
> > > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > > index 2768f9a765..473fc8780a 100644
> > > --- a/hw/ppc/spapr_irq.c
> > > +++ b/hw/ppc/spapr_irq.c
> > > @@ -101,90 +101,19 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterrupt=
Controller *, Error **),
> > >      return 0;
> > >  }
> > > =20
> > > -/*
> > > - * XICS IRQ backend.
> > > - */
> > > -
> > > -SpaprIrq spapr_irq_xics =3D {
> > > -    .xics        =3D true,
> > > -    .xive        =3D false,
> > > -};
> > > -
> > > -/*
> > > - * XIVE IRQ backend.
> > > - */
> > > -
> > > -SpaprIrq spapr_irq_xive =3D {
> > > -    .xics        =3D false,
> > > -    .xive        =3D true,
> > > -};
> > > -
> > > -/*
> > > - * Dual XIVE and XICS IRQ backend.
> > > - *
> > > - * Both interrupt mode, XIVE and XICS, objects are created but the
> > > - * machine starts in legacy interrupt mode (XICS). It can be changed
> > > - * by the CAS negotiation process and, in that case, the new mode is
> > > - * activated after an extra machine reset.
> > > - */
> > > -
> > > -/*
> > > - * Define values in sync with the XIVE and XICS backend
> > > - */
> > > -SpaprIrq spapr_irq_dual =3D {
> > > -    .xics        =3D true,
> > > -    .xive        =3D true,
> > > -};
> > > -
> > > -
> > >  static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
> > >  {
> > >      MachineState *machine =3D MACHINE(spapr);
> > > =20
> > > -    /*
> > > -     * Sanity checks on non-P9 machines. On these, XIVE is not
> > > -     * advertised, see spapr_dt_ov5_platform_support()
> > > -     */
> > > -    if (!ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICA=
L_3_00,
> > > -                               0, spapr->max_compat_pvr)) {
> > > -        /*
> > > -         * If the 'dual' interrupt mode is selected, force XICS as C=
AS
> > > -         * negotiation is useless.
> > > -         */
> > > -        if (spapr->irq =3D=3D &spapr_irq_dual) {
> > > -            spapr->irq =3D &spapr_irq_xics;
> > > -            return 0;
> > > -        }
> > > -
> > > -        /*
> > > -         * Non-P9 machines using only XIVE is a bogus setup. We have=
 two
> > > -         * scenarios to take into account because of the compat mode:
> > > -         *
> > > -         * 1. POWER7/8 machines should fail to init later on when cr=
eating
> > > -         *    the XIVE interrupt presenters because a POWER9 excepti=
on
> > > -         *    model is required.
> > > -
> > > -         * 2. POWER9 machines using the POWER8 compat mode won't fai=
l and
> > > -         *    will let the OS boot with a partial XIVE setup : DT
> > > -         *    properties but no hcalls.
> > > -         *
> > > -         * To cover both and not confuse the OS, add an early failur=
e in
> > > -         * QEMU.
> > > -         */
> > > -        if (spapr->irq =3D=3D &spapr_irq_xive) {
> > > -            error_setg(errp, "XIVE-only machines require a POWER9 CP=
U");
> > > -            return -1;
> > > -        }
> > > -    }
> > > -
> > >      /*
> > >       * On a POWER9 host, some older KVM XICS devices cannot be destr=
oyed and
> > >       * re-created. Detect that early to avoid QEMU to exit later whe=
n the
> > >       * guest reboots.
> > >       */
> > >      if (kvm_enabled() &&
> > > -        spapr->irq =3D=3D &spapr_irq_dual &&
> > >          machine_kernel_irqchip_required(machine) &&
> > > +        spapr_get_cap(spapr, SPAPR_CAP_XICS) &&
> > > +        spapr_get_cap(spapr, SPAPR_CAP_XIVE) &&
> > >          xics_kvm_has_broken_disconnect(spapr)) {
> > >          error_setg(errp, "KVM is too old to support ic-mode=3Ddual,k=
ernel-irqchip=3Don");
> > >          return -1;
> > > @@ -280,7 +209,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
> > >      /* Initialize the MSI IRQ allocator. */
> > >      spapr_irq_msi_init(spapr);
> > > =20
> > > -    if (spapr->irq->xics) {
> > > +    if (spapr_get_cap(spapr, SPAPR_CAP_XICS)) {
> > >          Error *local_err =3D NULL;
> > >          Object *obj;
> > > =20
> > > @@ -313,7 +242,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
> > >          spapr->ics =3D ICS_SPAPR(obj);
> > >      }
> > > =20
> > > -    if (spapr->irq->xive) {
> > > +    if (spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
> > >          uint32_t nr_servers =3D spapr_max_server_number(spapr);
> > >          DeviceState *dev;
> > >          int i;
> > > @@ -558,11 +487,6 @@ int spapr_irq_find(SpaprMachineState *spapr, int=
 num, bool align, Error **errp)
> > >      return first + ics->offset;
> > >  }
> > > =20
> > > -SpaprIrq spapr_irq_xics_legacy =3D {
> > > -    .xics        =3D true,
> > > -    .xive        =3D false,
> > > -};
> > > -
> > >  static void spapr_irq_register_types(void)
> > >  {
> > >      type_register_static(&spapr_intc_info);
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index 623e8e3f93..d3b4dd7de3 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -79,8 +79,12 @@ typedef enum {
> > >  #define SPAPR_CAP_LARGE_DECREMENTER     0x08
> > >  /* Count Cache Flush Assist HW Instruction */
> > >  #define SPAPR_CAP_CCF_ASSIST            0x09
> > > +/* XICS interrupt controller */
> > > +#define SPAPR_CAP_XICS                  0x0a
> > > +/* XIVE interrupt controller */
> > > +#define SPAPR_CAP_XIVE                  0x0b
> > >  /* Num Caps */
> > > -#define SPAPR_CAP_NUM                   (SPAPR_CAP_CCF_ASSIST + 1)
> > > +#define SPAPR_CAP_NUM                   (SPAPR_CAP_XIVE + 1)
> > > =20
> > >  /*
> > >   * Capability Values
> > > @@ -131,7 +135,6 @@ struct SpaprMachineClass {
> > >                            hwaddr *nv2atsd, Error **errp);
> > >      SpaprResizeHpt resize_hpt_default;
> > >      SpaprCapabilities default_caps;
> > > -    SpaprIrq *irq;
> > >  };
> > > =20
> > >  /**
> > > @@ -195,7 +198,6 @@ struct SpaprMachineState {
> > > =20
> > >      int32_t irq_map_nr;
> > >      unsigned long *irq_map;
> > > -    SpaprIrq *irq;
> > >      qemu_irq *qirqs;
> > >      SpaprInterruptController *active_intc;
> > >      ICSState *ics;
> > > @@ -870,6 +872,8 @@ extern const VMStateDescription vmstate_spapr_cap=
_hpt_maxpagesize;
> > >  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
> > >  extern const VMStateDescription vmstate_spapr_cap_large_decr;
> > >  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
> > > +extern const VMStateDescription vmstate_spapr_cap_xics;
> > > +extern const VMStateDescription vmstate_spapr_cap_xive;
> > > =20
> > >  static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int ca=
p)
> > >  {
> > > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > > index 5e150a6679..71aee13743 100644
> > > --- a/include/hw/ppc/spapr_irq.h
> > > +++ b/include/hw/ppc/spapr_irq.h
> > > @@ -77,16 +77,6 @@ int spapr_irq_msi_alloc(SpaprMachineState *spapr, =
uint32_t num, bool align,
> > >                          Error **errp);
> > >  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t =
num);
> > > =20
> > > -typedef struct SpaprIrq {
> > > -    bool        xics;
> > > -    bool        xive;
> > > -} SpaprIrq;
> > > -
> > > -extern SpaprIrq spapr_irq_xics;
> > > -extern SpaprIrq spapr_irq_xics_legacy;
> > > -extern SpaprIrq spapr_irq_xive;
> > > -extern SpaprIrq spapr_irq_dual;
> > > -
> > >  void spapr_irq_init(SpaprMachineState *spapr, Error **errp);
> > >  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Err=
or **errp);
> > >  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num);
> >=20
>=20


--Sig_/=9h=VUhGDF_G11agvjHDGbf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2ez+YACgkQcdTV5YIv
c9aGXxAAvZgXz7fxnCo1lscYNeHgNCXowGHX9WH+BIR8DPmaLqAvkMIzeAZjTvQ/
N8EUlOGq6orMQqoBZQ2C7/JGxPs+8s1/G92J+XWIKrOXAZ9fgSZiStYLcM0TM3Bl
i2NeVLGMLki4Sjc0kD966l+tyCGWPFxWvc4CbKSrDmJlHJMP/EXBIoqbGACfdZ9U
R3m1UrFcb4n37v4MgQ239uP50CoGoCUIKnXVn/t+Vde1CICc3/7lWQTMzmQHbRp/
E6whCnQhn4mz+oGwrIC8NCApdvEggaSjNQHxNfp7VFhwsVqEqLmJRw2sm1TFMT8j
6DhnH9+7Jhksi8mhNYdwiiRmBBwNCw4BMO/iILGqVez5H/pEFPHrf10mexMmgcip
fJeqkVXgb2wmekMKCaeLuXUAfK84D+fiRfG9BfYLrDNmCFRrpTxBn4lIYWHJPBOI
YZmykZOlMSQGFk4+UvT0s/Ij30kkDi4dJTAnj3uRDHd68tvY9b9N30fXikh08OOo
Lb0ngmlc97xo6FQEhyxzppRl9hKt0L7QlTFj8uamcEikvp6omrzKGK1oZ8RHEZDI
HufRctZPMT4s63r84BHln7XA8VjF3ae2OxtT5pZbstCr5RYBsYS0zVpspAD+ZzsP
fhOCMuhuP4Uu5TaUUnxEszQzZfkmERne/7TzXNpYw/gv8MSRBuI=
=+AUA
-----END PGP SIGNATURE-----

--Sig_/=9h=VUhGDF_G11agvjHDGbf--

