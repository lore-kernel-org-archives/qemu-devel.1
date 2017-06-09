Received: from eggs.gnu.org ([2001:4830:134:3::10]:58278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dJJqX-0002fS-4j
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dJJqU-0001Zk-09
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:21:01 -0400
Date: Fri, 9 Jun 2017 10:20:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170609132053.GM5016@thinpad.lan.raisama.net>
References: <1496927934-21815-1-git-send-email-thuth@redhat.com>
	<871squblsp.fsf@secure.mitica>
	<20170609020338.GC26521@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170609020338.GC26521@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH] hw/cpu: core.c can be compiled as common
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Andrew Jones <drjones@redhat.com>

On Fri, Jun 09, 2017 at 12:03:38PM +1000, David Gibson wrote:
> On Thu, Jun 08, 2017 at 04:23:34PM +0200, Juan Quintela wrote:
> > Thomas Huth <thuth@redhat.com> wrote:
> > > There does not seem to be any target specific code in core.c, so we can
> > > put it into "common-obj" instead of "obj" to compile it only once for
> > > all targets.
> > >
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > 
> > It compiles.
> > I can't see anything that is target dependent on core.c.
> > 
> > So
> > 
> > Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> I've merged this into my ppc-for-2.10 tree, on the basis that ppc is
> the only user of core.c so far.  Any objections?

No problem to me.  If you want, you can add my:

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
