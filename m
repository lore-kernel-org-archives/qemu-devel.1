Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7190EC388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 07:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416E021783
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 07:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416E021783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFCns-0003BT-D1
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 03:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFCn5-0002e4-0L
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 03:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFCn3-0007QR-Ca
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 03:41:46 -0400
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:39598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFCn3-0007Nx-5A
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 03:41:45 -0400
Received: from player786.ha.ovh.net (unknown [10.108.54.209])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id ADDB111B293
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 09:41:42 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id F0E01A7E8298;
 Tue,  1 Oct 2019 07:41:30 +0000 (UTC)
Subject: Re: [PATCH v2 21/33] spapr, xics, xive: Move cpu_intc_create from
 SpaprIrq to SpaprInterruptController
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-22-david@gibson.dropbear.id.au>
 <20190927121649.5b9f3db7@bahia.lan> <20190930014904.GB11105@umbus.fritz.box>
 <adb67721-5c4e-50ac-f459-a48570a45d6e@kaod.org>
 <20190930061445.GG11105@umbus.fritz.box>
 <75672a0f-6bae-406c-0f0c-d23cc58c9c9f@kaod.org>
 <20191001023102.GN11105@umbus.fritz.box>
 <9c6c7e17-0578-2313-4324-a5ca75149762@kaod.org>
 <20191001064726.GP11105@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5d1910be-7bb7-19d9-73c3-269f2d0c2ee7@kaod.org>
Date: Tue, 1 Oct 2019 09:41:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001064726.GP11105@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 231372434575952665
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeefgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.49
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
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/2019 08:47, David Gibson wrote:
> On Tue, Oct 01, 2019 at 07:43:51AM +0200, C=E9dric Le Goater wrote:
>> On 01/10/2019 04:31, David Gibson wrote:
>>> On Mon, Sep 30, 2019 at 12:13:14PM +0200, C=E9dric Le Goater wrote:
>>>> On 30/09/2019 08:14, David Gibson wrote:
>>>>> On Mon, Sep 30, 2019 at 07:28:45AM +0200, C=E9dric Le Goater wrote:
>>>>>> On 30/09/2019 03:49, David Gibson wrote:
>>>>>>> On Fri, Sep 27, 2019 at 12:16:49PM +0200, Greg Kurz wrote:
>>>>>>>> On Fri, 27 Sep 2019 15:50:16 +1000
>>>>>>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>>>>>>
>>>>>>>>> This method essentially represents code which belongs to the in=
terrupt
>>>>>>>>> controller, but needs to be called on all possible intcs, rathe=
r than
>>>>>>>>> just the currently active one.  The "dual" version therefore ca=
lls
>>>>>>>>> into the xics and xive versions confusingly.
>>>>>>>>>
>>>>>>>>> Handle this more directly, by making it instead a method on the=
 intc
>>>>>>>>> backend, and always calling it on every backend that exists.
>>>>>>>>>
>>>>>>>>> While we're there, streamline the error reporting a bit.
>>>>>>>>>
>>>>>>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>>>>> [snip]
>>>>>>>>> @@ -525,6 +469,30 @@ static void spapr_irq_check(SpaprMachineSt=
ate *spapr, Error **errp)
>>>>>>>>>  /*
>>>>>>>>>   * sPAPR IRQ frontend routines for devices
>>>>>>>>>   */
>>>>>>>>> +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
>>>>>>>>> +                              PowerPCCPU *cpu, Error **errp)
>>>>>>>>> +{
>>>>>>>>> +    if (spapr->xive) {
>>>>>>>>> +        SpaprInterruptController *intc =3D SPAPR_INTC(spapr->x=
ive);
>>>>>>>>> +        SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET=
_CLASS(intc);
>>>>>>>>> +
>>>>>>>>> +        if (sicc->cpu_intc_create(intc, cpu, errp) < 0) {
>>>>>>>>> +            return -1;
>>>>>>>>> +        }
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    if (spapr->ics) {
>>>>>>>>> +        SpaprInterruptController *intc =3D SPAPR_INTC(spapr->i=
cs);
>>>>>>>>> +        SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET=
_CLASS(intc);
>>>>>>>>> +
>>>>>>>>> +        if (sicc->cpu_intc_create(intc, cpu, errp) < 0) {
>>>>>>>>> +            return -1;
>>>>>>>>> +        }
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>
>>>>>>>> Instead of these hooks, what about open-coding spapr_xive_cpu_in=
tc_create()
>>>>>>>> and xics_spapr_cpu_intc_create() directly here, like you already=
 did for the
>>>>>>>> ICS and the XIVE objects in spapr_irq_init() ?
>>>>>>>
>>>>>>> I'd prefer not to.  The idea is I want to treat this as basically=
:
>>>>>>>
>>>>>>> 	foreach_possible_intc(intc)
>>>>>>> 		intc::cpu_intc_create(...)
>>>>>>>
>>>>>>> If I find time I might indeed replace the explicit ics and xive
>>>>>>> pointers with just an array of SpaprInterruptController *.
>>>>>>
>>>>>> Or you could use object_child_foreach() and check for the type. If=
 we had
>>>>>> a helper object_child_foreach_type(), we could use it elsewhere.
>>>>>
>>>>> I thought about that, but I don't think it quite works.  The
>>>>> complication is that the xics device is made explicitly a child of =
the
>>>>> machine, but the xive device has mmio, so it's a SusBusDevice sitti=
ng
>>>>> on the root bus instead.
>>>>
>>>> PnvXscom works fine with Devices and SysBusDevices.
>>>
>>> Uh... what's an example of it working with a SysBusDevice?  All the
>>> implementors of PNV_XSCOM_INTERFACE I could find were instantiated
>>> with object_initialize_child() making them explicitly children of the
>>> chip.  The SPAPR_XIVE is instantiated with qdev_create(NULL,
>>> TYPE_SPAPR_XIVE), making it a child of the root bus, not the machine,
>>> I believe.
>>
>> I see. We should reparent the interrupt controller then.
>=20
> Well, maybe.  It's not obvious to me that that's the right approach
> just because of this.
>=20
>=20
>> Could we rework=20
>> the code to instantiate and realize the XICS and XIVE model objects ?=20
>> We have the handlers spapr_instance_init() and spapr_machine_init().=20
>=20
> I'm not really sure what you're suggesting here.

Define the device model objects under the machine and not pointers :

	struct SpaprMachineState {
		...
		ICSState ics;
		SpaprXive  xive;
		...
	};

in spapr_instance_init() :

	object_initialize_child(obj, "ics",  &spapr->ics, sizeof(spapr->ics),
                            TYPE_ICS, &error_abort, NULL);
	object_property_add_const_link(OBJECT(&spapr->ics), "xics", obj,
                                   &error_abort);

	object_initialize_child(obj, "xive",  &spapr->xive, sizeof(spapr->xive),
                            TYPE_SPAPR_XIVE, &error_abort, NULL);


in spapr_machine_init(), call the realize handler depending on the chosen=
=20
'ic-mode'.=20


C.


>> That always has been a problem IMO.
>>
>>
>> C.=20
>> =20
>>
>>
>=20


