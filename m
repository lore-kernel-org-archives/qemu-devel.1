Received: from eggs.gnu.org ([2001:4830:134:3::10]:44951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1elP7o-0004pk-Nq
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 20:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1elP7k-0001tv-I8
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 20:11:12 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:41524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1elP7k-0001st-AS
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 20:11:08 -0500
Received: by mail-io0-x243.google.com with SMTP id f4so19483824ioh.8
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 17:11:07 -0800 (PST)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<1516187433.31850.189.camel@kernel.crashing.org>
	<2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
	<1516224472.31850.193.camel@kernel.crashing.org>
	<20180211080831.GC11634@umbus.fritz.box>
	<1518389717.2312.245.camel@kernel.crashing.org>
	<c0a92679-c237-1bd4-d9d5-91be16d043b4@ozlabs.ru>
	<1518438032.11875.26.camel@redhat.com>
	<1518446406.2959.22.camel@kernel.crashing.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <3436171e-8370-fa9c-e823-c273fa819677@ozlabs.ru>
Date: Tue, 13 Feb 2018 12:11:00 +1100
MIME-Version: 1.0
In-Reply-To: <1518446406.2959.22.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 02/19] spapr: introduce a
 skeleton for the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 13/02/18 01:40, Benjamin Herrenschmidt wrote:
> On Mon, 2018-02-12 at 13:20 +0100, Andrea Bolognani wrote:
>> On Mon, 2018-02-12 at 13:02 +1100, Alexey Kardashevskiy wrote:
>>> On 12/02/18 09:55, Benjamin Herrenschmidt wrote:
>>>> Well, we have a problem then. It looks like Qemu broken migration is
>>>> fundamentally incompatible with PAPR and CAS design...
>>>>
>>>> I know we don't migrate the configuration, that's not exactly what I
>>>> had in mind tho... Can we have some piece of *data* from the machine be
>>>> migrated first, and use it on the target to reconfigure the interrupt
>>>> controller before the stream arrives ?
>>>
>>> These days this is done via libvirt - it reads properties it needs via QMP,
>>> then sends an XML with everything (the interrupt controller type may be one
>>> of such properties), and starts the destination QEMU with the explicit
>>> interrupt controller (like -machine pseries,intrc=xive).
>>
>> Clarification: libvirt will use the user-defined XML configuration
>> to generate the QEMU command line both for the source and the target
>> of the migration, but it will not automagically figure out properties
>> through QMP. So if you want the controller to explicitly show up on
>> the QEMU command line, libvirt should be taught about it.
> 
> Which can't work because the guest pretty much decides what it will be
> early on during the boot process.


At the time of migration the guest has told QEMU what intrc it wants (via
cas?) and libvirt can ask QEMU via QMP about that when migrating.


> So we're back to square 1 having to instanciate both objects in qemu
> with some kind of "activation" flag.
> 
> Cheers,
> Ben.
> 


-- 
Alexey
