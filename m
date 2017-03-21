Received: from eggs.gnu.org ([2001:4830:134:3::10]:60067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cqMzX-0005x9-V4
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cqMzW-0002V4-T4
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:50:40 -0400
Date: Tue, 21 Mar 2017 13:50:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170321165035.GI2811@thinpad.lan.raisama.net>
References: <20170320141244.20737-1-lvivier@redhat.com>
	<20170320191114.GE2811@thinpad.lan.raisama.net>
	<20170321010321.GA13932@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170321010321.GA13932@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH v2] numa,
 spapr: align default numa node memory size to 256MB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>

On Tue, Mar 21, 2017 at 12:03:21PM +1100, David Gibson wrote:
> On Mon, Mar 20, 2017 at 04:11:14PM -0300, Eduardo Habkost wrote:
> > On Mon, Mar 20, 2017 at 03:12:44PM +0100, Laurent Vivier wrote:
> > > Since commit 224245b ("spapr: Add LMB DR connectors"), NUMA node
> > > memory size must be aligned to 256MB (SPAPR_MEMORY_BLOCK_SIZE).
> > > 
> > > But when "-numa" option is provided without "mem" parameter,
> > > the memory is equally divided between nodes, but 8MB aligned.
> > > This can be not valid for pseries.
> > > 
> > > In that case we can have:
> > > $ ./ppc64-softmmu/qemu-system-ppc64 -m 4G -numa node -numa node -numa node
> > > qemu-system-ppc64: Node 0 memory size 0x55000000 is not aligned to 256 MiB
> > > 
> > > With this patch, we have:
> > > (qemu) info numa
> > > 3 nodes
> > > node 0 cpus: 0
> > > node 0 size: 1280 MB
> > > node 1 cpus:
> > > node 1 size: 1280 MB
> > > node 2 cpus:
> > > node 2 size: 1536 MB
> > > 
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> In agree with Eduardo's suggested comment changes.  Apart from that,
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Eduardo, do you want to take the final spin through your tree, or
> should I take it through mine?

As the bug affects only spapr, please feel free to merge it.

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
