Received: from eggs.gnu.org ([2001:4830:134:3::10]:33047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrWi-00078p-Pi
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:26:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrWf-0002MT-KS
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:26:48 -0500
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:40652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrWf-0002Li-Dc
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:26:45 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 119B7175AA8
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:26:44 +0100 (CET)
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-9-clg@kaod.org>
	<20171117045412.GC26448@umbus.fritz.box>
	<54f87bb8-e502-fdc8-1069-2f6081e0d446@kaod.org>
	<20171123111202.GD22454@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d2ddfa50-ef16-8620-e471-bc98901a3f35@kaod.org>
Date: Thu, 23 Nov 2017 14:26:39 +0100
MIME-Version: 1.0
In-Reply-To: <20171123111202.GD22454@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 08/11] spapr: introduce a
 XICSFabric irq_is_lsi() operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/23/2017 12:12 PM, David Gibson wrote:
> On Fri, Nov 17, 2017 at 08:23:00AM +0100, C=E9dric Le Goater wrote:
>> On 11/17/2017 05:54 AM, David Gibson wrote:
>>> On Fri, Nov 10, 2017 at 03:20:14PM +0000, C=E9dric Le Goater wrote:
>>>> It will be used later on to distinguish the allocation of an LSI
>>>> interrupt from an MSI and also to reduce the use of the ICSIRQState
>>>> array of the ICSState object, which is on our way to introduce XIVE.
>>>>
>>>> The 'irq' parameter continues to refer to the global IRQ number spac=
e.
>>>>
>>>> On PowerNV, only the PSI controller interrupts are handled and they
>>>> are all LSIs.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>
>>> !?! AFAICT this is a step backwards.  The users of ics_is_lsi() here
>>> are in the xics code.  So they already have the right information
>>> locally in the ICSState object.  Why on earth would you indirect
>>> through the fabric.
>>
>> because I am trying to get rid of the fact that the current ICS=20
>> allocator handles two things at the same time : IRQ allocation=20
>> and IRQ type. And that's a problem because the ICSState object=20
>> is just used everywhere in the code.
>=20
> That's a good goal, but I don't think this is the right way there.
> One of the reasons that conflation of allocation and typing is bad is
> that the typing is essentially local information to the PIC itself,
> whereas the allocation is a machine concern.

OK.

> By using a XICSFabric hook you're essentially wiring the irq typing
> through the machine, which again seems like a step in the wrong
> direction.

I agree.
=20
>> OK, So that's is not to your liking, I will come up with some=20
>> other solution. Thanks for looking.
>=20
> Sorry if I was a bit harsh; quite a few unrelated things have been
> frustrating me, which has made me grumpy.

No problem. I am also trying to cover too many things at the same=20
time. XIVE is a big piece enough.=20

I think the XIVE patchset is stabilizing. So I will it send today=20
and see how it is perceived. But let's keep in mind that we have=20
some more needs for the PHBs and their IRQs placement.

Thanks,

C.   =20

  =20
