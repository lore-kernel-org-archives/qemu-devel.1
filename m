Received: from eggs.gnu.org ([2001:4830:134:3::10]:51480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fAzzC-0008D0-JS
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fAzz9-0004Dn-Gv
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:36:06 -0400
Message-ID: <1524584159.23669.13.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 24 Apr 2018 17:35:59 +0200
In-Reply-To: <20180420102117.GQ2434@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<1524151804.3017.9.camel@redhat.com>
	<20180420023542.GD2434@umbus.fritz.box>
	<1524216670.3017.11.camel@redhat.com>
	<20180420102117.GQ2434@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.13 0/7] spapr: Clean up pagesize
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org

On Fri, 2018-04-20 at 20:21 +1000, David Gibson wrote:
> On Fri, Apr 20, 2018 at 11:31:10AM +0200, Andrea Bolognani wrote:
> > I'll have to look into it to be sure, but I think it should be
> > possible for libvirt to convert a generic
> > 
> >   <memoryBacking>
> >     <hugepages/>
> >   </memoryBacking>
> > 
> > to a more specific
> > 
> >   <memoryBacking>
> >     <hugepages>
> >       <page size="16384" unit="KiB"/>
> >     </hugepages>
> >   </memoryBacking>
> > 
> > by figuring out the page size for the default hugepage mount,
> > which actually sounds like a good idea regardless. Of course users
> > user would still be able to provide the page size themselves in the
> > first place.
> 
> Sounds like a good approach.

Unfortunately it seems like this is not going to be feasible, as
POWER8 is apparently the only platform that enforces a strict
relationship between host page size and guest page size: x86,
aarch64 (and I have to assume POWER9 as well?) can reportedly all
deal gracefully with guests migrating between hosts that have
different hugepage mounts configured.

I need to spend some more time digesting the rest of the
information you provided, but as it stands right now I'm starting
to think this might actually need to be its own, explicit opt-in
knob at the libvirt level too after all :(

-- 
Andrea Bolognani / Red Hat / Virtualization
