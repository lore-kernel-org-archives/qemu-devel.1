Received: from eggs.gnu.org ([2001:4830:134:3::10]:45938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIqY5-0008Ri-1B
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIqY1-00032d-TK
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:04:01 -0400
Message-ID: <1496901831.2261.4.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 08 Jun 2017 16:03:51 +1000
In-Reply-To: <20170608041739.GY13397@umbus.fritz.box>
References: <20170602031507.29881-1-david@gibson.dropbear.id.au>
	<20170608041739.GY13397@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv5 0/4] Clean up compatibility
 mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, clg@kaod.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, abologna@redhat.com, sbobroff@redhat.com

On Thu, 2017-06-08 at 14:17 +1000, David Gibson wrote:
> On Fri, Jun 02, 2017 at 01:15:03PM +1000, David Gibson wrote:
> > This is a rebased and revised version of my patches revising CPU
> > compatiblity mode handling on ppc, last posted in November.  Since
> > then, many of the patches have already been merged (some for 2.9,
> > some
> > since).  This is what's left.
> > 
> >  * There was conceptual confusion about what a compatibility mode
> >    means, and how it interacts with the machine type.  This cleans
> >    that up, clarifying that a compatibility mode (as an externally
> > set
> >    option) only makes sense on machine types that don't permit the
> >    guest hypervisor privilege (i.e. 'pseries')
> > 
> >  * It was previously the user's (or management layer's)
> > responsibility
> >    to determine compatibility of CPUs on either end for migration.
> >    This uses the compatibility modes to check that properly during
> > an
> >    incoming migration.
> 
> Anyone willing to give some review and/or testing, particularly for
> patch 2/4.
> 

Sorry I had been playing around with this and meant to give it a
Tested-by
