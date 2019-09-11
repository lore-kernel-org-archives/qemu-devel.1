Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0211CC49ED9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 02:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9F4208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 02:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TKpS1qDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9F4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7s2o-0000rh-QH
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 22:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i7s23-00006u-P3
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 22:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i7s21-0001hK-Ja
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 22:06:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46901 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i7s20-0001fo-0L; Tue, 10 Sep 2019 22:06:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46SldL6rZ9z9sCJ; Wed, 11 Sep 2019 12:06:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568167606;
 bh=ueSA1FJshGWi6QkSa1Gwh/r24gY/RjdX6VVHyLgVWN4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TKpS1qDuTG2ZlGYd444Ey40CBTWYCVRHlUUEuLxRRGaMtxstQOGutXo0454o+tTBp
 zyI+Mwd9r2GmlcU+bIht0bF0lt4S2CSyg+kE8rhFNoc6rltzhtkNFAkpYw6hN0kSE+
 HzPrh02p6LjZByLPyok2pZuAUlyzXtNDaCqa0HGc=
Date: Wed, 11 Sep 2019 11:58:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190911015809.GG30740@umbus.fritz.box>
References: <20190910061326.25366-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Content-Disposition: inline
In-Reply-To: <20190910061326.25366-1-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] spapr/irq: Only claim VALID interrupts at
 the KVM level
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
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2019 at 08:13:26AM +0200, C=E9dric Le Goater wrote:
> A typical pseries VM with 16 vCPUs, one disk, one network adapater
> uses less than 100 interrupts but the whole IRQ number space of the
> QEMU machine is allocated at reset time and it is 8K wide. This is
> wasting considerably the global IRQ space of the overall system which
> has 1M interrupts per socket on a POWER9.
>=20
> To optimise the HW resources, only request at the KVM level interrupts
> which have been claimed. This will help up increase the maximum number
> of VMs per system.
>=20
> To keep migration compatibility, we introduce a machine class
> attribute to adapt the reset behavior on older pseries machines.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

The overall idea looks good to me.

I don't really see what the point of the reset-all property is.  How
this is handled shouldn't be guest visible at all AFAICT, so there's
no need to grandfather it for older machine types.

Since ics_irq_free() has uses in the existing code unrelated to this,
it would be nice to pull introducing that out into a separate patch.

> ---
>  include/hw/ppc/spapr.h      |  1 +
>  include/hw/ppc/spapr_xive.h |  1 +
>  include/hw/ppc/xics.h       |  6 ++++++
>  hw/intc/spapr_xive.c        |  1 +
>  hw/intc/spapr_xive_kvm.c    | 34 +++++++++++++++++++++++++++++++---
>  hw/intc/xics.c              |  1 +
>  hw/intc/xics_kvm.c          | 14 ++++++++++++++
>  hw/ppc/spapr.c              |  1 +
>  hw/ppc/spapr_irq.c          | 13 +++++++------
>  9 files changed, 63 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 03111fd55bc8..6c622954a60c 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -131,6 +131,7 @@ struct SpaprMachineClass {
>      SpaprResizeHpt resize_hpt_default;
>      SpaprCapabilities default_caps;
>      SpaprIrq *irq;
> +    bool irq_reset_all;
>  };
> =20
>  /**
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index bfd40f01d882..b33913eb0f28 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -45,6 +45,7 @@ typedef struct SpaprXive {
>      void          *tm_mmap;
>      MemoryRegion  tm_mmio_kvm;
>      VMChangeStateEntry *change;
> +    bool          reset_all;
>  } SpaprXive;
> =20
>  /*
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index f2a8d6a4b4f9..856815362406 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -117,6 +117,7 @@ struct ICSState {
>      DeviceState parent_obj;
>      /*< public >*/
>      uint32_t nr_irqs;
> +    bool reset_all;
>      uint32_t offset;
>      ICSIRQState *irqs;
>      XICSFabric *xics;
> @@ -179,6 +180,11 @@ void ics_simple_write_xive(ICSState *ics, int nr, in=
t server,
>                             uint8_t priority, uint8_t saved_priority);
>  void ics_simple_set_irq(void *opaque, int srcno, int val);
> =20
> +static inline bool ics_irq_free(ICSState *ics, uint32_t srcno)
> +{
> +    return !(ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK);
> +}
> +
>  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
>  void icp_pic_print_info(ICPState *icp, Monitor *mon);
>  void ics_pic_print_info(ICSState *ics, Monitor *mon);
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index c1c97192a7d2..b717d9e09314 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -492,6 +492,7 @@ static Property spapr_xive_properties[] =3D {
>      DEFINE_PROP_UINT32("nr-ends", SpaprXive, nr_ends, 0),
>      DEFINE_PROP_UINT64("vc-base", SpaprXive, vc_base, SPAPR_XIVE_VC_BASE=
),
>      DEFINE_PROP_UINT64("tm-base", SpaprXive, tm_base, SPAPR_XIVE_TM_BASE=
),
> +    DEFINE_PROP_BOOL("reset-all", ICSState, reset_all, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 17af4d19f54e..225abce36270 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -253,13 +253,23 @@ void kvmppc_xive_source_reset_one(XiveSource *xsrc,=
 int srcno, Error **errp)
>                        true, errp);
>  }
> =20
> +static bool xive_source_skip_reset(SpaprXive *xive, int srcno)
> +{
> +    return !xive->reset_all && !xive_eas_is_valid(&xive->eat[srcno]);
> +}
> +
>  static void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
>  {
> +    SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
>      int i;
> =20
>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
>          Error *local_err =3D NULL;
> =20
> +        if (xive_source_skip_reset(xive, i)) {
> +            continue;
> +        }
> +
>          kvmppc_xive_source_reset_one(xsrc, i, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
> @@ -328,11 +338,18 @@ uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int s=
rcno, uint32_t offset,
> =20
>  static void kvmppc_xive_source_get_state(XiveSource *xsrc)
>  {
> +    SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
>      int i;
> =20
>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
> +        uint8_t pq;
> +
> +        if (xive_source_skip_reset(xive, i)) {
> +            continue;
> +        }
> +
>          /* Perform a load without side effect to retrieve the PQ bits */
> -        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> +        pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> =20
>          /* and save PQ locally */
>          xive_source_esb_set(xsrc, i, pq);
> @@ -521,9 +538,14 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
>       */
>      if (running) {
>          for (i =3D 0; i < xsrc->nr_irqs; i++) {
> -            uint8_t pq =3D xive_source_esb_get(xsrc, i);
> +            uint8_t pq;
>              uint8_t old_pq;
> =20
> +            if (xive_source_skip_reset(xive, i)) {
> +                continue;
> +            }
> +
> +            pq =3D xive_source_esb_get(xsrc, i);
>              old_pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq <=
< 8));
> =20
>              /*
> @@ -545,7 +567,13 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
>       * migration is in progress.
>       */
>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
> -        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> +        uint8_t pq;
> +
> +        if (xive_source_skip_reset(xive, i)) {
> +            continue;
> +        }
> +
> +        pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> =20
>          /*
>           * PQ is set to PENDING to possibly catch a triggered
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index b2fca2975cc4..ae3f83cf0aad 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -746,6 +746,7 @@ static const VMStateDescription vmstate_ics_base =3D {
> =20
>  static Property ics_base_properties[] =3D {
>      DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
> +    DEFINE_PROP_BOOL("reset-all", ICSState, reset_all, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index a4d2e876cc5f..aa017b99801c 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -177,6 +177,12 @@ void icp_kvm_realize(DeviceState *dev, Error **errp)
>  /*
>   * ICS-KVM
>   */
> +
> +static bool ics_irq_skip_reset(ICSState *ics, int srcno)
> +{
> +    return !ics->reset_all && ics_irq_free(ics, srcno);
> +}
> +
>  void ics_get_kvm_state(ICSState *ics)
>  {
>      uint64_t state;
> @@ -190,6 +196,10 @@ void ics_get_kvm_state(ICSState *ics)
>      for (i =3D 0; i < ics->nr_irqs; i++) {
>          ICSIRQState *irq =3D &ics->irqs[i];
> =20
> +        if (ics_irq_skip_reset(ics, i)) {
> +            continue;
> +        }
> +
>          kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
>                            i + ics->offset, &state, false, &error_fatal);
> =20
> @@ -301,6 +311,10 @@ int ics_set_kvm_state(ICSState *ics, Error **errp)
>          Error *local_err =3D NULL;
>          int ret;
> =20
> +        if (ics_irq_skip_reset(ics, i)) {
> +            continue;
> +        }
> +
>          ret =3D ics_set_kvm_state_one(ics, i, &local_err);
>          if (ret < 0) {
>              error_propagate(errp, local_err);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7124053b43b7..af89f3b6c698 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4594,6 +4594,7 @@ static void spapr_machine_4_1_class_options(Machine=
Class *mc)
>      smc->linux_pci_probe =3D false;
>      compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> +    smc->irq_reset_all =3D true;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(4_1, "4.1", false);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 06fe2432bae5..8c3682613404 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -97,11 +97,13 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_irqs,
>  {
>      Object *obj;
>      Error *local_err =3D NULL;
> +    bool reset_all =3D SPAPR_MACHINE_GET_CLASS(spapr)->irq_reset_all;
> =20
>      obj =3D object_new(TYPE_ICS_SIMPLE);
>      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
>      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
>                                     &error_fatal);
> +    object_property_set_bool(obj, reset_all, "reset-all",  &error_fatal);
>      object_property_set_int(obj, nr_irqs, "nr-irqs",  &error_fatal);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
> @@ -114,9 +116,6 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_irqs,
>      xics_spapr_init(spapr);
>  }
> =20
> -#define ICS_IRQ_FREE(ics, srcno)   \
> -    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
> -
>  static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool =
lsi,
>                                  Error **errp)
>  {
> @@ -129,7 +128,7 @@ static int spapr_irq_claim_xics(SpaprMachineState *sp=
apr, int irq, bool lsi,
>          return -1;
>      }
> =20
> -    if (!ICS_IRQ_FREE(ics, irq - ics->offset)) {
> +    if (!ics_irq_free(ics, irq - ics->offset)) {
>          error_setg(errp, "IRQ %d is not free", irq);
>          return -1;
>      }
> @@ -147,7 +146,7 @@ static void spapr_irq_free_xics(SpaprMachineState *sp=
apr, int irq, int num)
>      if (ics_valid_irq(ics, irq)) {
>          trace_spapr_irq_free(0, irq, num);
>          for (i =3D srcno; i < srcno + num; ++i) {
> -            if (ICS_IRQ_FREE(ics, i)) {
> +            if (ics_irq_free(ics, i)) {
>                  trace_spapr_irq_free_warn(0, i);
>              }
>              memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
> @@ -270,9 +269,11 @@ static void spapr_irq_init_xive(SpaprMachineState *s=
papr, int nr_irqs,
>  {
>      uint32_t nr_servers =3D spapr_max_server_number(spapr);
>      DeviceState *dev;
> +    bool reset_all =3D SPAPR_MACHINE_GET_CLASS(spapr)->irq_reset_all;
>      int i;
> =20
>      dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
> +    object_property_set_bool(OBJECT(dev), reset_all, "reset-all", &error=
_fatal);
>      qdev_prop_set_uint32(dev, "nr-irqs", nr_irqs);
>      /*
>       * 8 XIVE END structures per CPU. One for each available priority
> @@ -767,7 +768,7 @@ static int ics_find_free_block(ICSState *ics, int num=
, int alignnum)
>              return -1;
>          }
>          for (i =3D first; i < first + num; ++i) {
> -            if (!ICS_IRQ_FREE(ics, i)) {
> +            if (!ics_irq_free(ics, i)) {
>                  break;
>              }
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl14VK8ACgkQbDjKyiDZ
s5IRlA/+N3SUH2dBNFjsbwE9T7kqCNpJkpTsx2dOTY8H0vPOP7K8gp5vvuwDfP9w
r0DjDeljTWOGkNaoOLjSjSLaW3SkzaEboEppZaL22TD07k6EjmwaCh2FrphBnoRI
JFpLOrLT+gXt6NF+BDY/AjN3iM/nMnICZOjVgQ5wNHbE8Sl12T5L5vuHd2OUtcrR
MuuO3dvJrfH7i8ydl8PkkkTnv6mLzvlO0TN7o429oT+BxqebHXejWukQ+rH4G+yd
X3AMs8lIdtA+vL22P4pjqOfqJiRCs3JyayK7COPLFH1cGhhYSnjWGdMDZB7d/aON
29ZC9iuX56qGG58tizR67pkk8YQrbfR5pDhJ0A7RhullMa0jxn1DdKh/SL2KTDyX
7tCoR8MqTkL6D3FSNRW54lDd/RygflUd1IVRVVGkyMQOlDkZob3SYzZRPX9M695b
LfqP38myYYOgJy9koca++cAl0LNpyC5LiYB+YEDOHzVcpyecantATsszikbA21ce
zjv53Ncq+jgxpod+N6io/75WCI+yPdu7geDzZjmYIGTk5rFOGlQKSyoPNwRegz9p
s8VafFHZJHL12IWG+D38qM31DgBpZJDZKlfZC6HA5YX6gsyeMJ8rpnL52rl66/49
jHPDzuq/4AVIQwR9MOsEcmLB8s+e709dQd0v0tm9TwFrPk6WXEU=
=9UuZ
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--

