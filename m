Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2847FC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 06:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFFD1218BA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 06:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFD1218BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXJpx-0001G8-UU
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 01:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXJot-0000ka-1B
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 01:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXJor-0001wD-Cy
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 01:50:30 -0500
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:38826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXJor-0001tJ-67
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 01:50:29 -0500
Received: from player694.ha.ovh.net (unknown [10.108.35.158])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id A68C6148C1A
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 07:50:26 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id 183E3C3CE109;
 Wed, 20 Nov 2019 06:50:18 +0000 (UTC)
Subject: Re: [RFC 5/5] spapr: Work around spurious warnings from vfio INTx
 initialization
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191017054218.8876-1-david@gibson.dropbear.id.au>
 <20191017054218.8876-6-david@gibson.dropbear.id.au>
 <3cded480-ce51-eef7-dc75-686022a18726@kaod.org>
 <2319e683-983c-2c40-3234-c4c43555c657@kaod.org>
 <20191120041739.GE5582@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <652c50bf-a6ce-4dff-77a1-413c615ed519@kaod.org>
Date: Wed, 20 Nov 2019 07:50:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120041739.GE5582@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 16299090005006781248
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegledguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeehnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.52.162
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
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qemu-ppc@nongnu.org,
 groug@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/2019 05:17, David Gibson wrote:
> On Thu, Oct 17, 2019 at 03:42:06PM +0200, C=E9dric Le Goater wrote:
>> On 17/10/2019 10:43, C=E9dric Le Goater wrote:
>>> On 17/10/2019 07:42, David Gibson wrote:
>>>> Traditional PCI INTx for vfio devices can only perform well if using
>>>> an in-kernel irqchip.  Therefore, vfio_intx_update() issues a warnin=
g
>>>> if an in kernel irqchip is not available.
>>>>
>>>> We usually do have an in-kernel irqchip available for pseries machin=
es
>>>> on POWER hosts.  However, because the platform allows feature
>>>> negotiation of what interrupt controller model to use, we don't
>>>> currently initialize it until machine reset.  vfio_intx_update() is
>>>> called (first) from vfio_realize() before that, so it can issue a
>>>> spurious warning, even if we will have an in kernel irqchip by the
>>>> time we need it.
>>>>
>>>> To workaround this, make a call to spapr_irq_update_active_intc() fr=
om
>>>> spapr_irq_init() which is called at machine realize time, before the
>>>> vfio realize.  This call will be pretty much obsoleted by the later
>>>> call at reset time, but it serves to suppress the spurious warning
>>>> from VFIO.
>>>>
>>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>>> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>
>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>> ---
>>>>  hw/ppc/spapr_irq.c | 11 ++++++++++-
>>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>>>> index 45544b8976..bb91c61fa0 100644
>>>> --- a/hw/ppc/spapr_irq.c
>>>> +++ b/hw/ppc/spapr_irq.c
>>>> @@ -345,6 +345,14 @@ void spapr_irq_init(SpaprMachineState *spapr, E=
rror **errp)
>>>> =20
>>>>      spapr->qirqs =3D qemu_allocate_irqs(spapr_set_irq, spapr,
>>>>                                        smc->nr_xirqs + SPAPR_XIRQ_BA=
SE);
>>>> +
>>>> +    /*
>>>> +     * Mostly we don't actually need this until reset, except that =
not
>>>> +     * having this set up can cause VFIO devices to issue a
>>>> +     * false-positive warning during realize(), because they don't =
yet
>>>> +     * have an in-kernel irq chip.
>>>> +     */
>>>> +    spapr_irq_update_active_intc(spapr);
>>>
>>> This will call the de/activate hooks of the irq chip very early=20
>>> before reset and CAS, and won't call them at reset if the intc
>>> pointers are the same (xive only for instance). It breaks very=20
>>> obviously the emulated XIVE device which won't reset the OS CAM=20
>>> line with the CPU id values and CPU notification will be broken.
>>>
>>> We have to find something else.
>>
>> Here is a possible fix for the (re)setting of the OS CAM line.=20
>>
>> Removing spapr_xive_set_tctx_os_cam() is a good thing but this solutio=
n
>> shows some issues in our modeling of hot-plugged CPUS with a reset()=20
>> being called at realize().
>=20
> Ok, I've applied the patch below now.=20

Yes. this was replaced by :

  http://patchwork.ozlabs.org/cover/1181522/

> Does that mean that my 5/5 patch should be good now?

We should.

C.

