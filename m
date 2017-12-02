Received: from eggs.gnu.org ([2001:4830:134:3::10]:36443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL8is-0001ET-KF
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL8in-0001i5-Mr
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:24:54 -0500
Message-ID: <1512224666.2224.52.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 02 Dec 2017 08:24:26 -0600
In-Reply-To: <20171128064034.GQ11775@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-12-clg@kaod.org>
	<20171128064034.GQ11775@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/25] spapr: describe the XIVE interrupt
 source flags
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

On Tue, 2017-11-28 at 17:40 +1100, David Gibson wrote:
> > @@ -368,6 +368,10 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
> >      /* Allocate the IVT (Interrupt Virtualization Table) */
> >      xive->ivt = g_malloc0(xive->nr_irqs * sizeof(XiveIVE));
> >  
> > +    /* All sources are emulated under the XIVE object and share the
> > +     * same characteristic */
> > +    xive->flags = XIVE_SRC_TRIGGER;
> 
> You never actually use this field.  And since it always has the same
> value, is there a point to storing it?

Some HW sources don't have it, so with pass-through maybe...

Cheers,
Ben
