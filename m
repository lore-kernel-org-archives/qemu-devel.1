Received: from eggs.gnu.org ([2001:4830:134:3::10]:35265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dwmR3-0001pl-Vf
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dwmR1-0002cQ-DU
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:45:50 -0400
Message-ID: <1506419102.2541.11.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 26 Sep 2017 11:45:02 +0200
In-Reply-To: <20170926035423.GH12504@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-2-clg@kaod.org> <20170919022719.GH27153@umbus>
	<d3ee87a7-208e-a172-094b-6aeedf8c5840@kaod.org>
	<20170922110040.GP4998@umbus.fritz.box>
	<fc6b85f6-fa5b-7ed2-2635-72aceda74305@kaod.org>
	<20170926035423.GH12504@umbus>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 01/21] ppc/xive: introduce a
 skeleton for the sPAPR XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On Tue, 2017-09-26 at 13:54 +1000, David Gibson wrote:
> > > 
> > > Which ones?  My impression was that there needed to be at least #cpus
> > > * #priority-levels EQs, but there could be more than that, 
> > 
> > euh no, not in spapr mode at least. There are 8 queues per cpu.
> 
> Ok.

There's a HW feature of XIVE in DD2.x that I will start exploiting soon
that sacrifices a queue btw, keep that in mind.

We should probably only expose 0...6 to guests, not 0...7.

> > > so it was no longer as tightly bound to the number if "interrupt servers"> as xics.
> > 
> > ah. I think I see what you mean, that we could allocate them on the 
> > fly when needed by some hcalls ?
> 
> Not at hcall time, no, but at cpu hot(un)plug time I was wondering if we
> could (de)allocate them then.
> 
> > The other place where I use the nr_targets is to provision the 
> > IRQ numbers for the IPIs but that could probably be done in some 
> > other way, specially it there is a IRQ allocator at the machine
> > level.
> 
> Hm, ok.
> 
