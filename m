Received: from eggs.gnu.org ([2001:4830:134:3::10]:59092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1fhkgh-0000Ik-Tp
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 19:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1fhkgd-0001oK-0M
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 19:56:23 -0400
Message-ID: <3692f644f72a1af49b7d5988d6b8482ea2f1e271.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 24 Jul 2018 09:55:53 +1000
In-Reply-To: <20180723041614.GD6830@umbus.fritz.box>
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
	<bc6c5befa0a24b35f439419d6dea493dc19035b9.camel@kernel.crashing.org>
	<20180723041614.GD6830@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, 2018-07-23 at 14:16 +1000, David Gibson wrote:
> > 
> > Now, this is an ICS subclass, so why shouldn't it directly poke at the
> > target ICP ?
> 
> That's ok in theory, but causing it to expose the icp interface to a
> new module isn't great.
> 
> > It's an alternate to the normal ICS since it behaves a bit
> > differently (PQ bits & all).
> 
> AFAICT the PQ bits are effectively another filtering layer on top of
> the same ICS logic as elsewhere.  I think it's better if we can share
> that shared logic, rather than replicating it.

I don't know, is there much shared logic ? And the shared bits are the
subclassing, that's handled that way...

This is really a different piece of HW, a separate ICS implementation,
that has its own quirks, is configured via different registers, does
EOI differently etc...

Even the resend stuff is done differently, the resend bitmap is
actually SW visible via an IODA table.

I mean, we could (maybe we do these days not sure) have an ICS
superclass wrapper on the actual icp_irq() but that's really all there
is to it I think.

Cheers,
Ben.
