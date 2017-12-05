Received: from eggs.gnu.org ([2001:4830:134:3::10]:40288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eMEYe-0006XJ-OG
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eMEYa-0003g6-QK
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:50:52 -0500
Message-ID: <1512485426.2224.95.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 05 Dec 2017 08:50:26 -0600
In-Reply-To: <20171205070004.GL3057@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-20-clg@kaod.org>
	<20171201040115.GC30161@umbus.fritz.box>
	<02120b7e-cd8b-af61-7d35-8289253828f6@kaod.org>
	<20171205070004.GL3057@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/25] spapr: add hcalls support for the
 XIVE interrupt mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 2017-12-05 at 18:00 +1100, David Gibson wrote:
> > The CPU revision. But we won't introduce XIVE exploitation mode on 
> > anything else than DD2.0 which has full XIVE support. Even STORE_EOI 
> > that we should be adding.
> 
> Hrm.  Host CPU?  That's a problem - if guest visible properties like
> this vary with the host CPU, migration breaks.

I don't think this is going to be a problem in practice. The
availability of trigger comes from OPAL but in practice, all virtual
interrupts are going to support it always, only some of the HW
originated ones (PCIe MSIs for example and LSIs) won't. And we don't
migrate with PCIe devices passed through.

So the guest need the info, but we should be ok with migration from P9
DD2.0 onwards. Nobody sane cares about P9 DD1.0.

Any future chip will have to ensure that we don't lose that property in
HW least we lost migration, but that would break AIX too so I'm
reasonably confident the HW guys will get that right ;-)

> > 
> > > If it varies with host capabilities, that's going to be real pain for
> > > migration.
> > 
> > Yes. I am not aware of any future extension but I agree this is
> > something we need to keep an eye on.
> 
> I'm not talking about future extension, I'm meaning right now.

No, no issue right now.

Cheers,
Ben.
