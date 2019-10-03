Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2978FC32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6F620700
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6F620700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG0c9-0007sS-QD
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iG0b0-0007K6-1u
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iG0ay-00035D-Nw
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:52:37 -0400
Received: from 1.mo7.mail-out.ovh.net ([178.33.45.51]:46024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iG0ay-00034d-HI
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:52:36 -0400
Received: from player168.ha.ovh.net (unknown [10.109.160.23])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 89CA3135D4D
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 14:52:34 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id 4AEDDA6F5BB5;
 Thu,  3 Oct 2019 12:52:29 +0000 (UTC)
Date: Thu, 3 Oct 2019 14:52:28 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 3/7] spapr, xics, xive: Drop nr_servers argument in
 DT-related functions
Message-ID: <20191003145228.51fced80@bahia.lan>
In-Reply-To: <4a35c881-e499-0539-790c-25b6f5f0068e@kaod.org>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
 <157010407899.246126.7691819104525548257.stgit@bahia.lan>
 <4a35c881-e499-0539-790c-25b6f5f0068e@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 17226831526589077899
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgdehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.45.51
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 3 Oct 2019 14:25:58 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 03/10/2019 14:01, Greg Kurz wrote:
> > Both XICS and XIVE backends can access nr_servers by other means. No
> > need to pass it around anymore.
>=20
> OK. You are doing the clean up in this patch.
>=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> even if spapr_irq removal is programmed,=20
>=20

I have another version of this patchset based on David's full cleanup
series :)

> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> > ---
> >  hw/intc/spapr_xive.c        |    3 +--
> >  hw/intc/xics_spapr.c        |    3 +--
> >  hw/ppc/spapr.c              |    3 +--
> >  hw/ppc/spapr_irq.c          |    5 ++---
> >  include/hw/ppc/spapr_irq.h  |    3 +--
> >  include/hw/ppc/spapr_xive.h |    3 +--
> >  include/hw/ppc/xics_spapr.h |    3 +--
> >  7 files changed, 8 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index 62888ddc68db..56d851169cf6 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -1552,8 +1552,7 @@ void spapr_xive_hcall_init(SpaprMachineState *spa=
pr)
> >      spapr_register_hypercall(H_INT_RESET, h_int_reset);
> >  }
> > =20
> > -void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> > -                   uint32_t phandle)
> > +void spapr_dt_xive(SpaprMachineState *spapr, void *fdt, uint32_t phand=
le)
> >  {
> >      SpaprXive *xive =3D spapr->xive;
> >      int node;
> > diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> > index aa568ed0dc0d..015753c19c5d 100644
> > --- a/hw/intc/xics_spapr.c
> > +++ b/hw/intc/xics_spapr.c
> > @@ -308,8 +308,7 @@ static void ics_spapr_realize(DeviceState *dev, Err=
or **errp)
> >      spapr_register_hypercall(H_IPOLL, h_ipoll);
> >  }
> > =20
> > -void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> > -                   uint32_t phandle)
> > +void spapr_dt_xics(SpaprMachineState *spapr, void *fdt, uint32_t phand=
le)
> >  {
> >      ICSState *ics =3D spapr->ics;
> >      uint32_t interrupt_server_ranges_prop[] =3D {
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index b8b9796c88e4..8f59f08c102e 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1255,8 +1255,7 @@ static void *spapr_build_fdt(SpaprMachineState *s=
papr)
> >      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> > =20
> >      /* /interrupt controller */
> > -    spapr->irq->dt_populate(spapr, spapr_max_server_number(spapr), fdt,
> > -                          PHANDLE_INTC);
> > +    spapr->irq->dt_populate(spapr, fdt, PHANDLE_INTC);
> > =20
> >      ret =3D spapr_populate_memory(spapr, fdt);
> >      if (ret < 0) {
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index 025fd00143a2..02e1b5503b65 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -368,11 +368,10 @@ static void spapr_irq_print_info_dual(SpaprMachin=
eState *spapr, Monitor *mon)
> >      spapr_irq_current(spapr)->print_info(spapr, mon);
> >  }
> > =20
> > -static void spapr_irq_dt_populate_dual(SpaprMachineState *spapr,
> > -                                       uint32_t nr_servers, void *fdt,
> > +static void spapr_irq_dt_populate_dual(SpaprMachineState *spapr, void =
*fdt,
> >                                         uint32_t phandle)
> >  {
> > -    spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, phan=
dle);
> > +    spapr_irq_current(spapr)->dt_populate(spapr, fdt, phandle);
> >  }
> > =20
> >  static void spapr_irq_cpu_intc_create_dual(SpaprMachineState *spapr,
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index 69a37f608e01..1736e503a8e9 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -45,8 +45,7 @@ typedef struct SpaprIrq {
> >      int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **=
errp);
> >      void (*free)(SpaprMachineState *spapr, int irq);
> >      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
> > -    void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
> > -                        void *fdt, uint32_t phandle);
> > +    void (*dt_populate)(SpaprMachineState *spapr, void *fdt, uint32_t =
phandle);
> >      void (*cpu_intc_create)(SpaprMachineState *spapr, PowerPCCPU *cpu,
> >                              Error **errp);
> >      int (*post_load)(SpaprMachineState *spapr, int version_id);
> > diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> > index 4a4a6fc6be7f..fae075d51815 100644
> > --- a/include/hw/ppc/spapr_xive.h
> > +++ b/include/hw/ppc/spapr_xive.h
> > @@ -61,8 +61,7 @@ void spapr_xive_pic_print_info(SpaprXive *xive, Monit=
or *mon);
> >  int spapr_xive_post_load(SpaprXive *xive, int version_id);
> > =20
> >  void spapr_xive_hcall_init(SpaprMachineState *spapr);
> > -void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> > -                   uint32_t phandle);
> > +void spapr_dt_xive(SpaprMachineState *spapr, void *fdt, uint32_t phand=
le);
> >  void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
> >  void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
> >  void spapr_xive_map_mmio(SpaprXive *xive);
> > diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> > index 0b35e85c266a..ecb67c6c340a 100644
> > --- a/include/hw/ppc/xics_spapr.h
> > +++ b/include/hw/ppc/xics_spapr.h
> > @@ -32,8 +32,7 @@
> >  #define TYPE_ICS_SPAPR "ics-spapr"
> >  #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
> > =20
> > -void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> > -                   uint32_t phandle);
> > +void spapr_dt_xics(SpaprMachineState *spapr, void *fdt, uint32_t phand=
le);
> >  int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
> >  void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
> >  bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
> >=20
>=20


