Received: from eggs.gnu.org ([2001:4830:134:3::10]:59747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWyuk-00073b-JD
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 02:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWyuh-0005jO-AS
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 02:26:38 -0500
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:52362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWyuh-0005e5-2Z
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 02:26:35 -0500
Received: from player697.ha.ovh.net (unknown [10.109.160.93])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 289701773F9
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 08:26:33 +0100 (CET)
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-19-clg@kaod.org>
	<39e8edd0-6056-5b51-174b-631dcb267ff5@kaod.org>
	<20181211020620.GG4261@umbus.fritz.box>
	<744ff9f8-6f84-00d4-a2e0-84652658762e@kaod.org>
	<20181212003459.GF2719@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bdfb5ed7-f388-f330-ffe7-6dd39f5a482c@kaod.org>
Date: Wed, 12 Dec 2018 08:26:20 +0100
MIME-Version: 1.0
In-Reply-To: <20181212003459.GF2719@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 18/19] spapr: add a 'pseries-4.0-xive'
 machine type
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

[ ... ]

>>> So, instead I think we want a machine option which can be set to
>>> xics/xive/dual, with xics being the default for earlier machine types
>>> and dual the default for 4.0 onwards.
>>
>> I will revive an old patch doing just that. 
>>
>> The question now is how to link the sPAPRMachineState instance to 
>> the selected sPAPR IRQ backend. 
>>
>> I don't think we can move 'smc->irq' to sPAPRMachineState.
> 
> I think you could..
> 
>> So we will
>> need an helper returning the appropriate backend depending on the machine 
>> option and 'smc->irq' should disappear.
> 
> ..but this approach might be easier.

I proposed the first approach in v8. We can add the missing wrappers 
in a second round and move then under spapr_irq.h. These are :
 
ops :

   spapr->irq->dt_populate   spapr->irq->print_info
   spapr->irq->cpu_intc_create (this name is too long)

constants :

   spapr->irq->ov5
   spapr->irq->nr_msis

C.
