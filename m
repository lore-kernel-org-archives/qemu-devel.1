Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A895AC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D14218A3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D14218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjOCs-0007EQ-D7
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 09:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hjOBs-0006dR-8j
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hjOBq-0005nX-5y
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:23:52 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:42111)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hjOBm-0005DO-C2
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:23:47 -0400
Received: from player760.ha.ovh.net (unknown [10.108.42.192])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id A972123BBAF
 for <qemu-devel@nongnu.org>; Fri,  5 Jul 2019 15:23:41 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player760.ha.ovh.net (Postfix) with ESMTPSA id 43AE87A32412;
 Fri,  5 Jul 2019 13:23:34 +0000 (UTC)
Date: Fri, 5 Jul 2019 15:23:32 +0200
From: Greg Kurz <groug@kaod.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190705152332.40126a76@bahia.lan>
In-Reply-To: <c0ab62c0-b170-2c11-221f-b46b1ba4339f@linux.vnet.ibm.com>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033126489.26635.3005245220857933178.stgit@aravinda>
 <20190702035105.GG6779@umbus.fritz.box>
 <fa2b5983-7cad-9679-489f-c273bd8216fb@linux.vnet.ibm.com>
 <20190703030334.GF9442@umbus.fritz.box>
 <a43707b0-8059-b2bd-a461-9f6de3285d8f@linux.vnet.ibm.com>
 <20190704010714.GS9442@umbus.fritz.box>
 <d5c75742-4f45-2f26-3837-098e8710ccd9@linux.vnet.ibm.com>
 <20190705010755.GA3266@umbus.fritz.box>
 <c0ab62c0-b170-2c11-221f-b46b1ba4339f@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5718727102572960148
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrfeeggdeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.182.191
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v10 2/6] ppc: spapr: Introduce
 FWNMI capability
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jul 2019 16:49:17 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> 
> 
> On Friday 05 July 2019 06:37 AM, David Gibson wrote:
> > On Thu, Jul 04, 2019 at 10:33:11AM +0530, Aravinda Prasad wrote:
> >>
> >>
> >> On Thursday 04 July 2019 06:37 AM, David Gibson wrote:
> >>> On Wed, Jul 03, 2019 at 02:58:24PM +0530, Aravinda Prasad wrote:
> >>>>
> >>>>
> >>>> On Wednesday 03 July 2019 08:33 AM, David Gibson wrote:
> >>>>> On Tue, Jul 02, 2019 at 11:54:26AM +0530, Aravinda Prasad wrote:
> >>>>>>
> >>>>>>
> >>>>>> On Tuesday 02 July 2019 09:21 AM, David Gibson wrote:
> >>>>>>> On Wed, Jun 12, 2019 at 02:51:04PM +0530, Aravinda Prasad wrote:
> >>>>>>>> Introduce the KVM capability KVM_CAP_PPC_FWNMI so that
> >>>>>>>> the KVM causes guest exit with NMI as exit reason
> >>>>>>>> when it encounters a machine check exception on the
> >>>>>>>> address belonging to a guest. Without this capability
> >>>>>>>> enabled, KVM redirects machine check exceptions to
> >>>>>>>> guest's 0x200 vector.
> >>>>>>>>
> >>>>>>>> This patch also introduces fwnmi-mce capability to
> >>>>>>>> deal with the case when a guest with the
> >>>>>>>> KVM_CAP_PPC_FWNMI capability enabled is attempted
> >>>>>>>> to migrate to a host that does not support this
> >>>>>>>> capability.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >>>>>>>> ---
> >>>>>>>>  hw/ppc/spapr.c         |    1 +
> >>>>>>>>  hw/ppc/spapr_caps.c    |   26 ++++++++++++++++++++++++++
> >>>>>>>>  include/hw/ppc/spapr.h |    4 +++-
> >>>>>>>>  target/ppc/kvm.c       |   19 +++++++++++++++++++
> >>>>>>>>  target/ppc/kvm_ppc.h   |   12 ++++++++++++
> >>>>>>>>  5 files changed, 61 insertions(+), 1 deletion(-)
> >>>>>>>>
> >>>>>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>>>>>> index 6dd8aaa..2ef86aa 100644
> >>>>>>>> --- a/hw/ppc/spapr.c
> >>>>>>>> +++ b/hw/ppc/spapr.c
> >>>>>>>> @@ -4360,6 +4360,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
> >>>>>>>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
> >>>>>>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
> >>>>>>>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
> >>>>>>>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
> >>>>>>>>      spapr_caps_add_properties(smc, &error_abort);
> >>>>>>>>      smc->irq = &spapr_irq_dual;
> >>>>>>>>      smc->dr_phb_enabled = true;
> >>>>>>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >>>>>>>> index 31b4661..2e92eb6 100644
> >>>>>>>> --- a/hw/ppc/spapr_caps.c
> >>>>>>>> +++ b/hw/ppc/spapr_caps.c
> >>>>>>>> @@ -479,6 +479,22 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
> >>>>>>>>      }
> >>>>>>>>  }
> >>>>>>>>  
> >>>>>>>> +static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
> >>>>>>>> +                                Error **errp)
> >>>>>>>> +{
> >>>>>>>> +    if (!val) {
> >>>>>>>> +        return; /* Disabled by default */
> >>>>>>>> +    }
> >>>>>>>> +
> >>>>>>>> +    if (tcg_enabled()) {
> >>>>>>>> +        error_setg(errp,
> >>>>>>>> +"No Firmware Assisted Non-Maskable Interrupts support in TCG, try cap-fwnmi-mce=off");
> >>>>>>>
> >>>>>>> Not allowing this for TCG creates an awkward incompatibility between
> >>>>>>> KVM and TCG guests.  I can't actually see any reason to ban it for TCG
> >>>>>>> - with the current code TCG won't ever generate NMIs, but I don't see
> >>>>>>> that anything will actually break.
> >>>>>>>
> >>>>>>> In fact, we do have an nmi monitor command, currently wired to the
> >>>>>>> spapr_nmi() function which resets each cpu, but it probably makes
> >>>>>>> sense to wire it up to the fwnmi stuff when present.
> >>>>>>
> >>>>>> Yes, but that nmi support is not enough to inject a synchronous error
> >>>>>> into the guest kernel. For example, we should provide the faulty address
> >>>>>> along with other information such as the type of error (slb multi-hit,
> >>>>>> memory error, TLB multi-hit) and when the error occurred (load/store)
> >>>>>> and whether the error was completely recovered or not. Without such
> >>>>>> information we cannot build the error log and pass it on to the guest
> >>>>>> kernel. Right now nmi monitor command takes cpu number as the only argument.
> >>>>>
> >>>>> Obviously we can't inject an arbitrary MCE event with that monitor
> >>>>> command.  But isn't there some sort of catch-all / unknown type of MCE
> >>>>> event which we could inject?
> >>>>
> >>>> We have "unknown" type of error, but we should also pass an address in
> >>>> the MCE event log. Strictly speaking this address should be a valid
> >>>> address in the current CPU context as MCEs are synchronous errors
> >>>> triggered when we touch a bad address.
> >>>
> >>> Well, some of them are.  At least historically both synchronous and
> >>> asnchronous MCEs were possible.  Are there really no versions where
> >>> you can report an MCE with unknown address?
> >>
> >> I am not aware of any such versions. Will cross check.
> >>
> >>>
> >>>> We can pass a default address with every nmi, but I am not sure whether
> >>>> that will be practically helpful.
> >>>>
> >>>>> It seems very confusing to me to have 2 totally separate "nmi"
> >>>>> mechanisms.
> >>>>>
> >>>>>> So I think TCG support should be a separate patch by itself.
> >>>>>
> >>>>> Even if we don't wire up the monitor command, I still don't see
> >>>>> anything that this patch breaks - we can support the nmi-register and
> >>>>> nmi-interlock calls without ever actually creating MCE events.
> >>>>
> >>>> If we support nmi-register and nmi-interlock calls without the monitor
> >>>> command wire-up then we will be falsely claiming the nmi support to the
> >>>> guest while it is not actually supported.
> >>>
> >>> How so?  AFAICT, from the point of view of the guest this is not
> >>> observably different from supporting the NMI mechanism but NMIs never
> >>> occurring.
> >>
> >> A guest inserting a duplicate SLB will expect the machine check
> >> exception delivered to the handler registered via nmi,register.
> >> But we actually don't do that in TCG.
> > 
> > Ah, true, I was thinking of external hardware fault triggered MCEs
> > rather than software error ones like duplicate SLB.
> > 
> > That said, I strongly suspect TCG is buggy enough at present that
> > exact behaviour in rare error conditions like duplicate SLB is not
> > really a big problem in the scheme of things.
> > 
> > I really don't think we can enable this by default until we allow it
> > for TCG - we don't want starting a TCG guest to involve manually
> > switching other options.
> > 
> > We could consider allowing it for TCG but just printing a warning that
> > the behaviour may not be correct in some conditions - we do something
> > similar for some of the Spectre workarounds already.
> 
> I think we better not enable this by default until we enhance TCG to
> support fwnmi.
> 

If we ever enhance TCG... until this get done, I concur with David's
idea of just printing a warning. System emulation+TCG is more a CI
or developer thing: we just want FWNMI not to break anything, even
if it doesn't work. KVM is the real life scenario we want to support.
If the feature is valuable, and I think it is, it should be the
default otherwise fewer people will have a chance to take benefit
from it.

> > 
> 


