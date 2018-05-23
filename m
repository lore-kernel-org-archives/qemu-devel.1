Received: from eggs.gnu.org ([2001:4830:134:3::10]:59764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fLQlJ-0002we-Ul
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fLQlD-0004wP-5I
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:12:53 -0400
Received: from 10.mo7.mail-out.ovh.net ([178.33.250.56]:57030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fLQlC-0004vb-RG
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:12:47 -0400
Received: from player714.ha.ovh.net (unknown [10.109.105.5])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id AE5EBAB38A
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 12:12:44 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-4-clg@kaod.org>
	<20180423064644.GG19804@umbus.fritz.box>
	<8d1cb270-d62f-f08f-9167-3f130906f910@kaod.org>
	<20180424064629.GP19804@umbus.fritz.box>
	<3b57fde8-ee11-81a0-271b-9e514ed63856@kaod.org>
	<20180426035452.GE8800@umbus.fritz.box>
	<b11688ae-a08f-320f-2bb5-46262ccb6376@kaod.org>
	<20180427063211.GO8800@umbus.fritz.box>
	<562fdbd3-cf09-0123-a481-b97e72802f5d@kaod.org>
	<20180503051333.GP13229@umbus.fritz.box>
Message-ID: <467317cf-d76a-acd9-7e8d-c393542d1a96@kaod.org>
Date: Wed, 23 May 2018 12:12:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180503051333.GP13229@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/35] ppc/xive: introduce the
 XiveFabric interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 05/03/2018 07:13 AM, David Gibson wrote:
> On Wed, May 02, 2018 at 05:28:23PM +0200, C=E9dric Le Goater wrote:
>> On 04/27/2018 08:32 AM, David Gibson wrote:
>>> On Thu, Apr 26, 2018 at 12:30:42PM +0200, C=E9dric Le Goater wrote:
>>>> On 04/26/2018 05:54 AM, David Gibson wrote:
>>>>> On Tue, Apr 24, 2018 at 11:33:11AM +0200, C=E9dric Le Goater wrote:
>>>>>> On 04/24/2018 08:46 AM, David Gibson wrote:
>>>>>>> On Mon, Apr 23, 2018 at 09:58:43AM +0200, C=E9dric Le Goater wrot=
e:
>>>>>>>> On 04/23/2018 08:46 AM, David Gibson wrote:
>>>>>>>>> On Thu, Apr 19, 2018 at 02:42:59PM +0200, C=E9dric Le Goater wr=
ote:
>>>>>>>>>> The XiveFabric offers a simple interface, between the XiveSour=
ve
>>>>>>>>>> object and the device model owning the interrupt sources, to f=
orward
>>>>>>>>>> an event notification to the XIVE interrupt controller of the =
machine
>>>>>>>>>> and if the owner is the controller, to call directly the routi=
ng
>>>>>>>>>> sub-engine.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>>>>>>>> ---
>>>>>>>>>>  hw/intc/xive.c        | 37 ++++++++++++++++++++++++++++++++++=
++-
>>>>>>>>>>  include/hw/ppc/xive.h | 25 +++++++++++++++++++++++++
>>>>>>>>>>  2 files changed, 61 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>>>>>>>>>> index 060976077dd7..b4c3d06c1219 100644
>>>>>>>>>> --- a/hw/intc/xive.c
>>>>>>>>>> +++ b/hw/intc/xive.c
>>>>>>>>>> @@ -17,6 +17,21 @@
>>>>>>>>>>  #include "hw/ppc/xive.h"
>>>>>>>>>> =20
>>>>>>>>>>  /*
>>>>>>>>>> + * XIVE Fabric
>>>>>>>>>> + */
>>>>>>>>>> +
>>>>>>>>>> +static void xive_fabric_route(XiveFabric *xf, int lisn)
>>>>>>>>>> +{
>>>>>>>>>> +
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static const TypeInfo xive_fabric_info =3D {
>>>>>>>>>> +    .name =3D TYPE_XIVE_FABRIC,
>>>>>>>>>> +    .parent =3D TYPE_INTERFACE,
>>>>>>>>>> +    .class_size =3D sizeof(XiveFabricClass),
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +/*
>>>>>>>>>>   * XIVE Interrupt Source
>>>>>>>>>>   */
>>>>>>>>>> =20
>>>>>>>>>> @@ -97,11 +112,19 @@ static bool xive_source_pq_trigger(XiveSo=
urce *xsrc, uint32_t srcno)
>>>>>>>>>> =20
>>>>>>>>>>  /*
>>>>>>>>>>   * Forward the source event notification to the associated Xi=
veFabric,
>>>>>>>>>> - * the device owning the sources.
>>>>>>>>>> + * the device owning the sources, or perform the routing if t=
he device
>>>>>>>>>> + * is the interrupt controller.
>>>>>>>>>>   */
>>>>>>>>>>  static void xive_source_notify(XiveSource *xsrc, int srcno)
>>>>>>>>>>  {
>>>>>>>>>> =20
>>>>>>>>>> +    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xsrc->xive=
);
>>>>>>>>>> +
>>>>>>>>>> +    if (xfc->notify) {
>>>>>>>>>> +        xfc->notify(xsrc->xive, srcno + xsrc->offset);
>>>>>>>>>> +    } else {
>>>>>>>>>> +        xive_fabric_route(xsrc->xive, srcno + xsrc->offset);
>>>>>>>>>> +    }
>>>>>>>>>
>>>>>>>>> Why 2 cases?  Can't the XiveFabric object just make its notify =
equal
>>>>>>>>> to xive_fabric_route if that's what it wants?
>>>>>>>> Under sPAPR, all the sources, IPIs and virtual device interrupts=
,=20
>>>>>>>> generate events which are directly routed by xive_fabric_route()=
.=20
>>>>>>>> There is no need of an extra hop. Indeed.=20
>>>>>>>
>>>>>>> Ok.
>>>>>>>
>>>>>>>> Under PowerNV, some sources forward the notification to the rout=
ing=20
>>>>>>>> engine using a specific MMIO load on a notify address which is s=
tored=20
>>>>>>>> in one of the controller registers. So we need a hop to reach th=
e=20
>>>>>>>> device model, owning the sources, and do that load :
>>>>>>>
>>>>>>> Hm.  So you're saying that in pnv some sources send their notific=
ation
>>>>>>> to some other unit,=20
>>>>>>
>>>>>> Not to any unit/device, to the device owning the sources.
>>>>>>
>>>>>> For the XiveSource object under PSI, the XIVEFabric interface is t=
he=20
>>>>>> PSI device object it self, which knows how to forward the notifica=
tion=20
>>>>>> on the XIVE Power "bus". To be more precise, the PSI HB device has=
=20
>>>>>> 14 interrupt sources, which notifications are forwarded using a MM=
IO=20
>>>>>> load to some address. The load address is configured (by skiboot) =
in=20
>>>>>> one of the PSI device registers, and points to a MMIO region of th=
e=20
>>>>>> main XIVE interrupt controller.=20
>>>>>>
>>>>>> The PHB4 sources should be the same.
>>>>>>
>>>>>> For the XiveSource object (all interrupts) under sPAPRXive, the=20
>>>>>> XIVEFabric is the main interrupt controller sPAPRXive.
>>>>>>
>>>>>> For the XiveSource object (IPIs) under PnvXive, the XIVEFabric is=20
>>>>>> also the main interrupt controller PnvXive.
>>>>>
>>>>> Hrm.  Apparently I'm missing something, I'm really not getting what
>>>>> you're trying to explain here.
>>>>
>>>> I see that. Let's try again.
>>>>
>>>>>>> that would then (after possible masking) forward on to the overal=
l> xive fabric ?=20
>>>>>>
>>>>>> yes. May be XIVEFabric is a confusing name. What about XIVEForward=
er ?=20
>>>>>
>>>>> Maybe..?
>>>>>
>>>>>>> That seems like a property of the source object,=20
>>>>>>
>>>>>> The source object is generic. It's a bunch of PQ bits that can be=20
>>>>>> controlled by MMIOs. Nothing more.
>>>>>
>>>>> Hmm.  Isn't the source object also responsible for forwarding the
>>>>> interrupt to something up the chain (whatever that is)?
>>>>
>>>> Yes but it can not forward directly. The XiveSource is generic and=20
>>>> can only call a handler :
>>>>
>>>> 	xfc->notify(xsrc->xive, srcno + xsrc->offset);
>>>
>>> But.. your patch doesn't do that always, it's conditional which I
>>> still don't understand.
>>
>> Because at the end of the notify/forward chain, you route.
>=20
> Hrm.  I'm really not understanding this notify/forward thing as
> distinct from routing.  I mean, from the description here it sounds
> kind of like cascaded interrupt controllers, which qemu already has
> mechanisms to handle, but I didn't think (most) POWER9 devices worked
> like that.

they don't.=20

The concept I have in mind for the XIVEFabric QOM interface is=20
something close to the XIVE logic unit in HW which links the=20
device interrupt sources and the XIVE interrupt controller of the=20
chip to the PowerBUS. The interrupt controller also has a special=20
CQ (common queue) unit acting as a proxy for the PowerBus for the=20
virtualization/router and the presenter units. =20

It's a convenient model for QEMU because the XiveSource model only=20
has to call an interface handler when a notification event is let=20
through. It's like doing a MMIO to send on the PowerBUS the ISN of=20
the source that just triggered. =20

>>>> The device model owner, the parent of the XiveSource object, would=20
>>>> do the real forward.
>>>
>>> Why? =20
>>
>> because, in my idea of the XiveSource concept, it does not have=20
>> the logic to do so: the register for the MMIO address to use,=20
>> another one for the IVT offset, etc
>>
>>> I mean the XiveSource basically represents the xive irq related
>>> logic of the PHB or whatever, why would it not represent *all* of
>>> that, rather than just the ESB bits, meaning the owner has to have
>>> some more xive logic for the forwarding.
>>
>> ok. This is where we diverge in the concept.=20
>>
>> The PQ bits, the ESB MMIO region handlers can be easily shared=20
>> between the different device models. They are the common part
>> of devices with XIVE interrupt sources.
>=20
> Sure, but QOM subclasses are a thing, which sounds like a better way
> of doing this than having to have extra XIVE logic in all the parent
> devices.

I agree It can be done with subclasses also but QOM interfaces are=20
quickly defined and stateless.=20

On sPAPR, the extra XIVE logic would only be the sPAPRXive model=20
acting as the machine interrupt controller model. It owns all the=20
guest interrupt sources.

In PowerNV, we would have the PnvXive interrupt controller model
for the chip, which also owns the IPI sources, and the PSIHB model=20
and the PHB4 model.=20

This is very much like XICS. Each relevant device has one or more=20
ICSstate objects. ICSstate has a pointer to the XICSfabric.


>>> Note that I don't think the fact that some sources notify via mmio an=
d
>>> some are internal really matters.  It's not like we're modelling the
>>> power bus down to the wire-transaction level.
>>
>> yes but the configuration of the devices are different. pnv devices=20
>> will have registers accessible through MMIO or XSCOM and configured
>> by the firmware. spapr is all set up by QEMU.
>=20
> Ah.. ok.  Actually modelling the mmio forwards probably makes sense
> then.  I still think it makes more sense in a pnv XiveSource subclass
> rather than putting it in the containing device.

Hmm, we will then need to define classes for the sPAPRXiveSource,=20
PnvXiveSource, PSIXiveSource, which works fine for sure. But with=20
a QOM interface, we could use directly the XiveSource class.=20

I will take a look.=20

>>>> It's very similar to what we have today with XICS :
>>>>
>>>> 	- The sPAPR model has an ICSState =20
>>>> 	- The PnvPSI model has an ICSState=20
>>>> 	- The PnvPHB3 model has two ICSStates
>>>>
>>>> and the 'xics' pointer in ICSState points to the 'interrupt unit' of=
=20
>>>> the machine to do resends and to grab ICPs. So it used for routing=20
>>>> essentially.
>>>
>>> Hmm.  I think you and I are looking at XICSFabric kind of
>>> differently.  As I see it, it's not really an active component at
>>> all.  Rather it's basically a global "map" of the xics components so
>>> that they can find each other.
>>
>> ok. I am not that far either.=20
>> =20
>>>> in Xive=20
>>>>
>>>> 	- sPAPRXive model has a XiveSource
>>>> 	- PnvXive model has a XiveSource
>>>> 	- PnvPSI model has a XiveSource
>>>> 	- PnvPHB4 model should have also.
>>>>
>>>> and the 'xive' pointer in XiveSource points to the parent object,
>>>
>>> Uh.. yeah.. the xics pointer in ICS units doesn't point to the parent
>>> object, except maybe by accident.  It's absolutely intended to be
>>> global, and so points to the machine.
>>
>> yes. I agree.=20
>>
>> XIVE has more layers and visible components due to the internal=20
>> tables used for routing.
>=20
> Right.
>=20
>>>> which will handle the event notification forwarding or routing.
>>>
>>> Ok, how about this for a partial model.  We have:
>>>
>>> XiveSource objects:
>>> 	* Owns an ESB table
>>> 	* Knows the mapping of its local irq offsets to global irq
>>> 	  numbers
>>
>> That is the 'offset' attribute I suppose. This is set at runtime=20
>> for the powernv devices.
>=20
> Ok, so that offset is effectively a register (which will have to be
> migrated), rather than a device property.

powernv migration is a not on my radar yet :)

>> For pseries, we should need it for=20
>> passthrough. I think. I haven't looked at that part yet.
>=20
> Uh.. I really hope not.  AIUI the offsets are decided by the platform
> rather than the guest in this case, yes? =20

A mapping is done in the guest. I still need to check how the ESB=20
pages are populated in the guest ESB MMIO region. We should be fine=20
I think.

> In which case if we can't
> count on a fixed offset even in passthrough mode, then migration is
> basically impossible.
>>>> 	* Provides the mmio interface for ESB manipulation
>>> 	* When neccessary, notifies a new interrupt to a XiveRouter
>>
>> ok. I think that what we have today fits the idea then.=20
>=20
> Yes, I think so to - just clarifying in the context of the rest of
> this proposal.

yes. I think we should be adding a XiveRouter class like you propose=20
below.
=20
>>> XiveRouter objects:
>>> 	* Responsible for a fixed range of global irq numbers
>>> 	* Owns an IVT (but what that means can vary, see below)
>>
>> the size of the IVT table is determined at runtime for powernv.
>=20
> That's fine - both the size and base of the IVT will be registers of
> the powernv variant of the device.
>=20
>>> 	* When notified of an irq, routes it to the appropriate EQ
>>> 	  (haven't thought about this part yet)
>>
>> we will need a class handler to get EQs
>=20
> Sure.
>=20
>>> 	* Abstract class - needs subclasses to define how to get IVEs
>>
>> OK. We will need a few other ops. The router needs to :
>>
>> 	- get IVEs
>> 	- get EQ descriptors
>> 	- update OS EQs (write event data in OS RAM)
>=20
> IIUC the actual EQ (as opposed to its descriptor) will be in guest RAM
> for both powernv and spapr,

yes.=20

> so this can be common (utiliizing a
> subclass hook to locate the EQ base address).

yes.
=20
>> 	- update EQ descriptors (to set EQ descriptor index & toggle)
>> 	- get an NVT/VP (to notify CPUs)
>=20
> Getting NVT/VP sounds more like it would belong in the XiveFabric than
> the router, but I haven't looked at this in detail yet.

The VP table is owned by the presenter unit. It is notified by the router
unit when an event is let through. The presenter then looks for the VP to
notify among the VPs dispatched on the HW threads. If none is found,=20
the event is escalated.=20

The router units owns the IVE and the EQ tables, but still can do some
remote access to the VPDT, to update the backlog and IBP I think.=20
I don't think we need to introduce a presenter model, accessors for=20
the VPs should enough.=20

>> For powernv, we should also consider updating the NVT/VP. It can be=20
>> done later.=20
>>
>>> XiveFabric interface:
>>> 	* Lets XIVE components locate each other
>>
>> hmm, it should be a chain :=20
>>
>> 	source -> router -> presenter -> cpu
>>
>> So the components should not have to locate each other. The presenter
>> does not know about the source for instance. Only the sources need
>> to forward events to the main controller logic doing the routing.
>=20
> source -> router
>=20
> From the above sounds like we can maybe make this just a router
> property in the source, rather than a lookup through a fabric.

If we use a direct link from the source to the router, how do we handle=20
the powernv case which does event notification with a MMIO load ?=20
I think a call through an interface is better (the XiveFabric)

> router -> presenter
>=20
> Here we might still need a "fabric".  By defintion the router can
> direct to a bunch of different presenters, so it needs some kind of
> map to find them, no?

yes. The vp_block identifies the chip. There are different possible=20
scenarios for the block configuration on a system but OPAL uses a=20
simple one : one chip <-> one block. We can use that to start with=20
on PowerNV.

And on pseries, just use block 0 for all, we don't really care.
The concept of block does not reach the spapr specs.=20

As for the presenter it self, it loops on the CPUs to check the CAM=20
line register of the thread interrupt management context to see if=20
one matches vp_block+vp_index. This is one routine. I don't think=20
we need a model for that.

> presenter -> cpu
>=20
> This one's trivial; just the cpu->intc pointer or similar.

yes. We store under the cpu the thread interrupt management context,
which is a set of registers that the OS accesses through the TIMA,
one per machine.

>>> 	* get_router() method: maps a global irq number to XiveRouter
>>> 	  object
>>
>> Ah. you are thinking about the multichip case under powernv. I need
>> to look at that more closely. But XIVE has a concept of block which=20
>> is used by skiboot to map a chip to a block and the XIVE tables have=20
>> a block field.
>=20
> Hmm.. I think we need to understand this to make a real model.  I'd
> thought the block number would just be the chip number somewhere in
> the high bits of the global irq, but sounds like there might be yet
> another indirection here.

We have a one-to-one mapping today. I doubt it will change. We can
start with that.

>>> 	* Always global (implemented on the machine)
>>
>> OK. this is more or less the object modeling the main interrupt=20
>> controller ? What I called sPAPRXive in the current patchset.
>=20
> No.  This is *always* global - assuming we need it at all - even on
> multichip powernv.
>
>>> On pseries we have:
>>>
>>> 	? XiveSource objects.  We probably only need one, but 1 for
>>> 	LSI and one for MSI might be convenient. =20
>>
>> It's not too ugly for the moment. If we create a source object=20
>> for LSIs only that might be more complex for passthrough devices=20
>> and their associated ESB MMIO region.
>>
>> side note :
>>
>> LSIs work under TCG, and used to work under KVM until we removed
>> the StoreEOI support. Since the EOI is now different, we need=20
>> to find a way to handle EOI for guest virtual LSIs which are=20
>> not LSIs for the host.
>=20
> I can't quite picture that case - can you give a concrete example?

A guest won't be able to use a rtl8139 nic under KVM.

As it is the guest that does the EOI, it should use the appropriate=20
sequence depending on the interrupt type, LSI vs. MSI. The store EOI
was used for both types until we removed the support bc of ordering=20
issues. So now, the guest uses a specific EOI sequence for LSI but=20
the hypervisor implements virtual LSIs on top of IPIs interrupts which
are MSIs ... we are doomed. We need to fix the guest or to find a=20
way to reroute such interrupts to QEMU. =20


>=20
>> We can still change the Linux spapr=20
>> backend or have QEMU handle the EOI for virtual LSIs. This is=20
>> on my TODO list.
>>
>>>       More wouldn't break the model
>>
>> It should not. Initially the pachset had two source objects :=20
>> one for IPIs and one for the virtual devices interrupts.=20
>>
>>> 	1 sPAPRXiveRouter.  This is a subclass of XiveRouter that
>>> 	holds the IVT internall (and migrates it).
>>
>> OK.
>>
>>> 	the XiveFabric implementation always returns the single global
>>> 	router for get_router()
>>
>> we can do that.=20
>=20
> Again, if it's true that each source object always forwards to just
> one router, then we don't need a get_router(), we can just use a link
> property.

that is the goal of the architecture, yes. powernv sources use MMIOs=20
to forward events to the router and source event notifications are=20
usually forwarded to the local chip.=20

There are some case in which the IVE lookups are be remote. We can
use the block to scan the system chips for that. we don't have to
implement all the protocol.

>=20
>> Do we gather all XIVE components objects under an object 'sPAPRXive'=20
>> modeling that way the main interrupt controller of the machine ?=20
>=20
> No, I don't think so.
Hmm,=20

sPAPRXive would inherit from the XiveRouter and define the IVT
and the EQDT. It is also practical to set up the TIMA memory region
which is unique per machine. KVM support will need custom version=20
of this model. =20

>> It should not have any state but it will hold the TIMA region=20
>> most certainly, and the addresses where to map the ESB and=20
>> TIMA regions.
>=20
> Uh.. I'd expect the TIMAs to be held by the NVT objects, which we
> haven't covered yet.

There is a set of registers per CPU (thread interrupt management context)=
,
but there is one TIMA (thread interrupt management areao) memory region=20
for the whole machine.
=20
We should change the NVT name, it is confusing. NVT is an old name for th=
e=20
backing store struct in RAM, which was replaced by VP.=20

XiveTCTX (Xive Thread Context) is better IMO and its reflects the names=20
of the IC registers.
=20
>> KVM support will bring extra needs.
>> =20
>>> On powernv we have:
>>> 	N XiveSource objects.  Some in PHBs, some extra ones on each
>>> 	chip
>>
>> yes and PSI to start with. =20
>>
>>> 	(#chips) PowerXiveRouter objects.  This subclass of XiveRouter
>>> 	stores the register giving the IVT base address and migrates
>>> 	that, but the IVT contents are in RAM
>>>
>>> 	the XiveFabric get_router() implementation returns the right
>>> 	chip's router based on the irq number
>>>
>>> Obviously the router->EQ sides still needs a bunch of thought.
>>
>> These are all routing tables :=20
>>
>> 	- IVT
>> 	- EQDT
>> 	- VPDT =20
>=20
> Thinking about what you've said, I'm thinking maybe what we need on
> the source side is two versions which don't exactly correspond to
> spapr vs powernv:
>=20
> InBandXiveSource: this one's notify behaviour is to issue an mmio read
> to a configured address.  It's expected that mmio address belongs to a
> XiveRouter, but the source itself doesn't know anything routers.
>=20
> OutOfBandXiveSource: this one's notify behaviour is to explicitly poke
> a XiveRouter.  A link to the router and offset (which range of router
> irqs are used by this source) would be object properties.
>=20
> powernv would use the first for "external" irq sources and the second
> for internal ones.  spapr would use the second for everything.
>=20

OK.=20

I think I will stick to my idea for the next version because there are=20
quite a lot of changes in the models already : a new spapr irq backend,
a XiveRouter, a EQD table for sPAPR, a complete TIMA support for all=20
privileges, a renamed XiveTCTX, a simple Presenter scanning CAM lines,=20
support for EQ ESBs (that no system uses), a pseries-2.13-xive machine,
etc.

I will share the powernv and PSIHB models to validate the common
XIVE model. We can change to the above if it is really not satisfying.

Thanks,

C.
