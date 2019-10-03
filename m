Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0A2C4CED1
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 13:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CA720873
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 13:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CA720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG1Nr-0001UG-Da
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 09:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iG1Mr-0000cC-Rs
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 09:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iG1Mq-0002oi-E3
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 09:42:05 -0400
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:57702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iG1Mq-0002i4-7I
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 09:42:04 -0400
Received: from player773.ha.ovh.net (unknown [10.109.143.249])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 8F4E811B65E
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 15:42:00 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player773.ha.ovh.net (Postfix) with ESMTPSA id 42516A8A6748;
 Thu,  3 Oct 2019 13:41:56 +0000 (UTC)
Date: Thu, 3 Oct 2019 15:41:55 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/7] spapr, xics: Get number of servers with a
 XICSFabricClass method
Message-ID: <20191003154155.33fedea1@bahia.lan>
In-Reply-To: <d478b754-6614-6ef1-db51-83ae1243cabe@kaod.org>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
 <157010405465.246126.7760334967989385566.stgit@bahia.lan>
 <a00c6fee-42b8-c923-386f-5fa909f6f99b@kaod.org>
 <20191003144952.181da0e2@bahia.lan>
 <7e0d1ddd-61eb-4adf-193a-9bb197b3033c@kaod.org>
 <20191003150231.44bf1046@bahia.lan>
 <d478b754-6614-6ef1-db51-83ae1243cabe@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 18061686306017286539
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.34.1
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

On Thu, 3 Oct 2019 15:19:22 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 03/10/2019 15:02, Greg Kurz wrote:
> > On Thu, 3 Oct 2019 14:58:45 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >=20
> >> On 03/10/2019 14:49, Greg Kurz wrote:
> >>> On Thu, 3 Oct 2019 14:24:06 +0200
> >>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >>>
> >>>> On 03/10/2019 14:00, Greg Kurz wrote:
> >>>>> The number of servers, ie. upper bound of the highest VCPU id, is
> >>>>> currently only needed to generate the "interrupt-controller" node
> >>>>> in the DT. Soon it will be needed to inform the XICS-on-XIVE KVM
> >>>>> device that it can allocates less resources in the XIVE HW.
> >>>>>
> >>>>> Add a method to XICSFabricClass for this purpose.=20
> >>>>
> >>>> This is sPAPR code and PowerNV does not care.
> >>>>
> >>>
> >>> Then PowerNV doesn't need to implement the method.
> >>>
> >>>> why can not we simply call spapr_max_server_number(spapr) ?
> >>>>
> >>>
> >>> Because the backend shouldn't reach out to sPAPR machine
> >>> internals. XICSFabric is the natural interface for ICS/ICP
> >>> if they need something from the machine.
> >>
> >> From what I can see, xics_nr_servers() is only called by :=20
> >>
> >>   spapr_dt_xics(SpaprMachineState *spapr ...)
> >>   xics_kvm_connect(SpaprMachineState *spapr ...)
> >>
> >=20
> > Yes... and ?
>=20
> so it is spapr only and we can use spapr_max_server_number(spapr)
> without the need of a new XICSFabric handler.
>=20

Yet we did care to have an nr_server argument to spapr_dt_xics(), even
though we could have called spapr_max_server_number() since the
beginning. And we also care not to call spapr_max_server_number()
to setup nr_ends in XIVE. Right ?

Ideally spapr_max_server_number() should even be local to spapr.c
IMHO. It happens to be extern because spapr_irq_init() needs it for
sPAPR XIVE, but I think it should rather be passed as an argument.

Anyway, if this patch doesn't reach consensus, I'll switch to using
spapr_max_server_number()... and do the same in sPAPR XIVE for
consistency ;-)

> C.=20
>=20
> >> C.=20
> >>
> >>>>
> >>>>> Implement it
> >>>>> for sPAPR and use it to generate the "interrupt-controller" node.
> >>>>>
> >>>>> Signed-off-by: Greg Kurz <groug@kaod.org>
> >>>>> ---
> >>>>>  hw/intc/xics.c        |    7 +++++++
> >>>>>  hw/intc/xics_spapr.c  |    3 ++-
> >>>>>  hw/ppc/spapr.c        |    8 ++++++++
> >>>>>  include/hw/ppc/xics.h |    2 ++
> >>>>>  4 files changed, 19 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> >>>>> index dfe7dbd254ab..f82072935266 100644
> >>>>> --- a/hw/intc/xics.c
> >>>>> +++ b/hw/intc/xics.c
> >>>>> @@ -716,6 +716,13 @@ ICPState *xics_icp_get(XICSFabric *xi, int ser=
ver)
> >>>>>      return xic->icp_get(xi, server);
> >>>>>  }
> >>>>> =20
> >>>>> +uint32_t xics_nr_servers(XICSFabric *xi)
> >>>>> +{
> >>>>> +    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
> >>>>> +
> >>>>> +    return xic->nr_servers(xi);
> >>>>> +}
> >>>>> +
> >>>>>  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
> >>>>>  {
> >>>>>      assert(!(ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK));
> >>>>> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> >>>>> index 6e5eb24b3cca..aa568ed0dc0d 100644
> >>>>> --- a/hw/intc/xics_spapr.c
> >>>>> +++ b/hw/intc/xics_spapr.c
> >>>>> @@ -311,8 +311,9 @@ static void ics_spapr_realize(DeviceState *dev,=
 Error **errp)
> >>>>>  void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, =
void *fdt,
> >>>>>                     uint32_t phandle)
> >>>>>  {
> >>>>> +    ICSState *ics =3D spapr->ics;
> >>>>>      uint32_t interrupt_server_ranges_prop[] =3D {
> >>>>> -        0, cpu_to_be32(nr_servers),
> >>>>> +        0, cpu_to_be32(xics_nr_servers(ics->xics)),
> >>>>>      };
> >>>>>      int node;
> >>>>> =20
> >>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>>> index 514a17ae74d6..b8b9796c88e4 100644
> >>>>> --- a/hw/ppc/spapr.c
> >>>>> +++ b/hw/ppc/spapr.c
> >>>>> @@ -4266,6 +4266,13 @@ static ICPState *spapr_icp_get(XICSFabric *x=
i, int vcpu_id)
> >>>>>      return cpu ? spapr_cpu_state(cpu)->icp : NULL;
> >>>>>  }
> >>>>> =20
> >>>>> +static uint32_t spapr_nr_servers(XICSFabric *xi)
> >>>>> +{
> >>>>> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(xi);
> >>>>> +
> >>>>> +    return spapr_max_server_number(spapr);
> >>>>> +}
> >>>>> +
> >>>>>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
> >>>>>                                   Monitor *mon)
> >>>>>  {
> >>>>> @@ -4423,6 +4430,7 @@ static void spapr_machine_class_init(ObjectCl=
ass *oc, void *data)
> >>>>>      xic->ics_get =3D spapr_ics_get;
> >>>>>      xic->ics_resend =3D spapr_ics_resend;
> >>>>>      xic->icp_get =3D spapr_icp_get;
> >>>>> +    xic->nr_servers =3D spapr_nr_servers;
> >>>>>      ispc->print_info =3D spapr_pic_print_info;
> >>>>>      /* Force NUMA node memory size to be a multiple of
> >>>>>       * SPAPR_MEMORY_BLOCK_SIZE (256M) since that's the granularity
> >>>>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> >>>>> index 1e6a9300eb2b..e6bb1239e8f8 100644
> >>>>> --- a/include/hw/ppc/xics.h
> >>>>> +++ b/include/hw/ppc/xics.h
> >>>>> @@ -151,9 +151,11 @@ typedef struct XICSFabricClass {
> >>>>>      ICSState *(*ics_get)(XICSFabric *xi, int irq);
> >>>>>      void (*ics_resend)(XICSFabric *xi);
> >>>>>      ICPState *(*icp_get)(XICSFabric *xi, int server);
> >>>>> +    uint32_t (*nr_servers)(XICSFabric *xi);
> >>>>>  } XICSFabricClass;
> >>>>> =20
> >>>>>  ICPState *xics_icp_get(XICSFabric *xi, int server);
> >>>>> +uint32_t xics_nr_servers(XICSFabric *xi);
> >>>>> =20
> >>>>>  /* Internal XICS interfaces */
> >>>>>  void icp_set_cppr(ICPState *icp, uint8_t cppr);
> >>>>>
> >>>>
> >>>
> >>
> >=20
>=20


