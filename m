Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2645BC32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3BD2133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3BD2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG2dV-0003gG-Cu
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 11:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iG2ZL-0001Gd-Cj
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iG2ZI-0005XB-SX
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:59:03 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:49620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iG2ZI-0005UG-Ll
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:59:00 -0400
Received: from player779.ha.ovh.net (unknown [10.108.35.131])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 53E6C24A82D
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 16:58:50 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id E61F6A705E31;
 Thu,  3 Oct 2019 14:58:45 +0000 (UTC)
Date: Thu, 3 Oct 2019 16:58:36 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/7] spapr, xics: Get number of servers with a
 XICSFabricClass method
Message-ID: <20191003165836.12cb48af@bahia.lan>
In-Reply-To: <d8da1690-c99c-f9fe-ad62-b588c8408d5f@kaod.org>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
 <157010405465.246126.7760334967989385566.stgit@bahia.lan>
 <a00c6fee-42b8-c923-386f-5fa909f6f99b@kaod.org>
 <20191003144952.181da0e2@bahia.lan>
 <7e0d1ddd-61eb-4adf-193a-9bb197b3033c@kaod.org>
 <20191003150231.44bf1046@bahia.lan>
 <d478b754-6614-6ef1-db51-83ae1243cabe@kaod.org>
 <20191003154155.33fedea1@bahia.lan>
 <d8da1690-c99c-f9fe-ad62-b588c8408d5f@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 912260401866054027
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.51.82
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

On Thu, 3 Oct 2019 15:59:29 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 03/10/2019 15:41, Greg Kurz wrote:
> > On Thu, 3 Oct 2019 15:19:22 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >=20
> >> On 03/10/2019 15:02, Greg Kurz wrote:
> >>> On Thu, 3 Oct 2019 14:58:45 +0200
> >>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >>>
> >>>> On 03/10/2019 14:49, Greg Kurz wrote:
> >>>>> On Thu, 3 Oct 2019 14:24:06 +0200
> >>>>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >>>>>
> >>>>>> On 03/10/2019 14:00, Greg Kurz wrote:
> >>>>>>> The number of servers, ie. upper bound of the highest VCPU id, is
> >>>>>>> currently only needed to generate the "interrupt-controller" node
> >>>>>>> in the DT. Soon it will be needed to inform the XICS-on-XIVE KVM
> >>>>>>> device that it can allocates less resources in the XIVE HW.
> >>>>>>>
> >>>>>>> Add a method to XICSFabricClass for this purpose.=20
> >>>>>>
> >>>>>> This is sPAPR code and PowerNV does not care.
> >>>>>>
> >>>>>
> >>>>> Then PowerNV doesn't need to implement the method.
> >>>>>
> >>>>>> why can not we simply call spapr_max_server_number(spapr) ?
> >>>>>>
> >>>>>
> >>>>> Because the backend shouldn't reach out to sPAPR machine
> >>>>> internals. XICSFabric is the natural interface for ICS/ICP
> >>>>> if they need something from the machine.
> >>>>
> >>>> From what I can see, xics_nr_servers() is only called by :=20
> >>>>
> >>>>   spapr_dt_xics(SpaprMachineState *spapr ...)
> >>>>   xics_kvm_connect(SpaprMachineState *spapr ...)
> >>>>
> >>>
> >>> Yes... and ?
> >>
> >> so it is spapr only and we can use spapr_max_server_number(spapr)
> >> without the need of a new XICSFabric handler.
> >>
> >=20
> > Yet we did care to have an nr_server argument to spapr_dt_xics(), even
> > though we could have called spapr_max_server_number() since the
> > beginning.=20
>=20
> yes it is sometime good practice to pass only what a routine needs=20
> and the whole state.
>=20

Sure.

> > And we also care not to call spapr_max_server_number()
> > to setup nr_ends in XIVE. Right ?
>=20
> yes. That's handled with a property.
> =20

Yes and the same could be done if we had a derived type
for sPAPR XICS.

> > Ideally spapr_max_server_number() should even be local to spapr.c
> > IMHO. It happens to be extern because spapr_irq_init() needs it for
> > sPAPR XIVE, but I think it should rather be passed as an argument.
>=20
> That will be the case again  when David has finished cleaning it up.
>=20

I fully agree. I posted this series based on the current state of
ppc-for-4.2 in order to start the discussion, but I'm looking
forward to base it on the proper backend models that David is
cooking up for us :)

> > Anyway, if this patch doesn't reach consensus, I'll switch to using
> > spapr_max_server_number()... and do the same in sPAPR XIVE for
> > consistency ;-)
>=20
> I don't see the problem sPAPR XIVE. There is a property "nr-server".
>=20

Not before patch 2 in this series :) and it could be dropped and
replaced by a call to spapr_max_server_number() during realize.

> The XICS Fabric was introduced to handle differences between the
> PowerNV machine and spapr machine mostly. We can extend its use
> to abstract the interface between the machine and its device models

Well... this was suggested by David in some other mail...

> but, in that case, if we want consistency, we should then remove=20
> the use of SpaprMachinestate from xics_kvm to begin with and use=20
> only XICSFabric handlers. This is not the case today.
>=20

I must admit I'm not a big fan of seeing SpaprMachinestate being
used in a lot of places like a jack-of-all-trade structure that
allows to access anything you want (even if you should not).

> Because this is a spapr model only. Why bother ? This would add=20
> just extra and useless ops.=20
>=20
> You should wait for David to finish the cleanup. I think that=20
> at end we will only do pass a nr_servers to a couple of routine.
> kvmppc_xive_connect() might need an extra argument.
>=20

This is how I was doing when I started to work on this :)

>=20
> C.
>=20
>=20
> >=20
> >> C.=20
> >>
> >>>> C.=20
> >>>>
> >>>>>>
> >>>>>>> Implement it
> >>>>>>> for sPAPR and use it to generate the "interrupt-controller" node.
> >>>>>>>
> >>>>>>> Signed-off-by: Greg Kurz <groug@kaod.org>
> >>>>>>> ---
> >>>>>>>  hw/intc/xics.c        |    7 +++++++
> >>>>>>>  hw/intc/xics_spapr.c  |    3 ++-
> >>>>>>>  hw/ppc/spapr.c        |    8 ++++++++
> >>>>>>>  include/hw/ppc/xics.h |    2 ++
> >>>>>>>  4 files changed, 19 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> >>>>>>> index dfe7dbd254ab..f82072935266 100644
> >>>>>>> --- a/hw/intc/xics.c
> >>>>>>> +++ b/hw/intc/xics.c
> >>>>>>> @@ -716,6 +716,13 @@ ICPState *xics_icp_get(XICSFabric *xi, int s=
erver)
> >>>>>>>      return xic->icp_get(xi, server);
> >>>>>>>  }
> >>>>>>> =20
> >>>>>>> +uint32_t xics_nr_servers(XICSFabric *xi)
> >>>>>>> +{
> >>>>>>> +    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
> >>>>>>> +
> >>>>>>> +    return xic->nr_servers(xi);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
> >>>>>>>  {
> >>>>>>>      assert(!(ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK));
> >>>>>>> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> >>>>>>> index 6e5eb24b3cca..aa568ed0dc0d 100644
> >>>>>>> --- a/hw/intc/xics_spapr.c
> >>>>>>> +++ b/hw/intc/xics_spapr.c
> >>>>>>> @@ -311,8 +311,9 @@ static void ics_spapr_realize(DeviceState *de=
v, Error **errp)
> >>>>>>>  void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers=
, void *fdt,
> >>>>>>>                     uint32_t phandle)
> >>>>>>>  {
> >>>>>>> +    ICSState *ics =3D spapr->ics;
> >>>>>>>      uint32_t interrupt_server_ranges_prop[] =3D {
> >>>>>>> -        0, cpu_to_be32(nr_servers),
> >>>>>>> +        0, cpu_to_be32(xics_nr_servers(ics->xics)),
> >>>>>>>      };
> >>>>>>>      int node;
> >>>>>>> =20
> >>>>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>>>>> index 514a17ae74d6..b8b9796c88e4 100644
> >>>>>>> --- a/hw/ppc/spapr.c
> >>>>>>> +++ b/hw/ppc/spapr.c
> >>>>>>> @@ -4266,6 +4266,13 @@ static ICPState *spapr_icp_get(XICSFabric =
*xi, int vcpu_id)
> >>>>>>>      return cpu ? spapr_cpu_state(cpu)->icp : NULL;
> >>>>>>>  }
> >>>>>>> =20
> >>>>>>> +static uint32_t spapr_nr_servers(XICSFabric *xi)
> >>>>>>> +{
> >>>>>>> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(xi);
> >>>>>>> +
> >>>>>>> +    return spapr_max_server_number(spapr);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
> >>>>>>>                                   Monitor *mon)
> >>>>>>>  {
> >>>>>>> @@ -4423,6 +4430,7 @@ static void spapr_machine_class_init(Object=
Class *oc, void *data)
> >>>>>>>      xic->ics_get =3D spapr_ics_get;
> >>>>>>>      xic->ics_resend =3D spapr_ics_resend;
> >>>>>>>      xic->icp_get =3D spapr_icp_get;
> >>>>>>> +    xic->nr_servers =3D spapr_nr_servers;
> >>>>>>>      ispc->print_info =3D spapr_pic_print_info;
> >>>>>>>      /* Force NUMA node memory size to be a multiple of
> >>>>>>>       * SPAPR_MEMORY_BLOCK_SIZE (256M) since that's the granulari=
ty
> >>>>>>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> >>>>>>> index 1e6a9300eb2b..e6bb1239e8f8 100644
> >>>>>>> --- a/include/hw/ppc/xics.h
> >>>>>>> +++ b/include/hw/ppc/xics.h
> >>>>>>> @@ -151,9 +151,11 @@ typedef struct XICSFabricClass {
> >>>>>>>      ICSState *(*ics_get)(XICSFabric *xi, int irq);
> >>>>>>>      void (*ics_resend)(XICSFabric *xi);
> >>>>>>>      ICPState *(*icp_get)(XICSFabric *xi, int server);
> >>>>>>> +    uint32_t (*nr_servers)(XICSFabric *xi);
> >>>>>>>  } XICSFabricClass;
> >>>>>>> =20
> >>>>>>>  ICPState *xics_icp_get(XICSFabric *xi, int server);
> >>>>>>> +uint32_t xics_nr_servers(XICSFabric *xi);
> >>>>>>> =20
> >>>>>>>  /* Internal XICS interfaces */
> >>>>>>>  void icp_set_cppr(ICPState *icp, uint8_t cppr);
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>>
> >>
> >=20
>=20


