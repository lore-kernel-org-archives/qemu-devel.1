Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEE1C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82EA121951
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EA121951
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1nh-0001CB-GB
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 11:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36254)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hr1nV-0000VJ-P2
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hr1nU-0004Ua-MJ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:06:17 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:54741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hr1nU-0004Rh-GC
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:06:16 -0400
Received: from player688.ha.ovh.net (unknown [10.109.160.46])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id F2E741A7881
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 17:06:13 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 11153844B4A5;
 Fri, 26 Jul 2019 15:06:10 +0000 (UTC)
Date: Fri, 26 Jul 2019 17:06:09 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Message-ID: <20190726170609.328cdd89@bahia.lan>
In-Reply-To: <523c8643-13ba-7f1f-f2b5-86ce5812e564@kaod.org>
References: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
 <156415228966.1064338.190189424190233355.stgit@bahia.lan>
 <523c8643-13ba-7f1f-f2b5-86ce5812e564@kaod.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 1649724839012112779
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkeeggdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.165.38
Subject: Re: [Qemu-devel] [PATCH 3/3] spapr/irq: Drop spapr_irq_msi_reset()
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

On Fri, 26 Jul 2019 17:01:36 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 26/07/2019 16:44, Greg Kurz wrote:
> > PHBs already take care of clearing the MSIs from the bitmap during reset
> > or unplug. No need to do this globally from the machine code. Rather add
> > an assert to ensure that PHBs have acted as expected.
>=20
> This works because spar_irq_reset() is called after qemu_devices_reset().=
=20
> I guess this is fine.
>=20

Yeah and we have this comment in spapr_machine_reset():

    /*
     * This is fixing some of the default configuration of the XIVE
     * devices. To be called after the reset of the machine devices.
     */
    spapr_irq_reset(spapr, &error_fatal);

I guess this is enough to prevent someone to break things.

> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Thanks,
>=20
> C.
>=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c             |    4 ----
> >  hw/ppc/spapr_irq.c         |    7 ++-----
> >  include/hw/ppc/spapr_irq.h |    1 -
> >  3 files changed, 2 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 5894329f29a9..855e9fbd9805 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1739,10 +1739,6 @@ static void spapr_machine_reset(MachineState *ma=
chine)
> >          ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fa=
tal);
> >      }
> > =20
> > -    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> > -        spapr_irq_msi_reset(spapr);
> > -    }
> > -
> >      /*
> >       * NVLink2-connected GPU RAM needs to be placed on a separate NUMA=
 node.
> >       * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() wh=
ich is
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index d07aed8ca9f9..c72d8433681d 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -57,11 +57,6 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, in=
t irq, uint32_t num)
> >      bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
> >  }
> > =20
> > -void spapr_irq_msi_reset(SpaprMachineState *spapr)
> > -{
> > -    bitmap_clear(spapr->irq_map, 0, spapr->irq_map_nr);
> > -}
> > -
> >  static void spapr_irq_init_kvm(SpaprMachineState *spapr,
> >                                    SpaprIrq *irq, Error **errp)
> >  {
> > @@ -729,6 +724,8 @@ int spapr_irq_post_load(SpaprMachineState *spapr, i=
nt version_id)
> > =20
> >  void spapr_irq_reset(SpaprMachineState *spapr, Error **errp)
> >  {
> > +    assert(bitmap_empty(spapr->irq_map, spapr->irq_map_nr));
> > +
> >      if (spapr->irq->reset) {
> >          spapr->irq->reset(spapr, errp);
> >      }
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index f965a58f8954..44fe4f9e0e2e 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -28,7 +28,6 @@ void spapr_irq_msi_init(SpaprMachineState *spapr, uin=
t32_t nr_msis);
> >  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool a=
lign,
> >                          Error **errp);
> >  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t nu=
m);
> > -void spapr_irq_msi_reset(SpaprMachineState *spapr);
> > =20
> >  typedef struct SpaprIrq {
> >      uint32_t    nr_irqs;
> >=20
>=20


