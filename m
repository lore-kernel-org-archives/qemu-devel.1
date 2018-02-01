Received: from eggs.gnu.org ([2001:4830:134:3::10]:60871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ehIQ7-0000jE-T7
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ehIQ4-0001sO-Np
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:13:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ehIQ4-0001rj-Gd
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:13:04 -0500
Date: Thu, 1 Feb 2018 19:12:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180201190902-mutt-send-email-mst@kernel.org>
References: <20180201040608-mutt-send-email-mst@kernel.org>
	<8dbc7c99-84f6-0023-526b-359fdf2b5162@redhat.com>
	<20180201121009.GR26425@localhost.localdomain>
	<bac4ac10-72ef-679e-69e6-95cdda32d2ab@redhat.com>
	<20180201150254-mutt-send-email-mst@kernel.org>
	<20180201163132.GV26425@localhost.localdomain>
	<20180201184655-mutt-send-email-mst@kernel.org>
	<20180201165739.GY26425@localhost.localdomain>
	<20180201185830-mutt-send-email-mst@kernel.org>
	<20180201170136.GA26425@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201170136.GA26425@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH V8 1/4] mem: add share parameter to
 memory-backend-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, cohuck@redhat.com, f4bug@amsat.org, yuval.shaia@oracle.com, borntraeger@de.ibm.com, pbonzini@redhat.com, imammedo@redhat.com

On Thu, Feb 01, 2018 at 03:01:36PM -0200, Eduardo Habkost wrote:
> On Thu, Feb 01, 2018 at 06:59:07PM +0200, Michael S. Tsirkin wrote:
> > On Thu, Feb 01, 2018 at 02:57:39PM -0200, Eduardo Habkost wrote:
> > > On Thu, Feb 01, 2018 at 06:48:54PM +0200, Michael S. Tsirkin wrote:
> > > > On Thu, Feb 01, 2018 at 02:31:32PM -0200, Eduardo Habkost wrote:
> > > > > On Thu, Feb 01, 2018 at 04:24:30PM +0200, Michael S. Tsirkin wrote:
> > > > > [...]
> > > > > > The full fix would be to allow QEMU to map a list of
> > > > > > pages to a guest supplied IOVA.
> > > > > 
> > > > > Thanks, that's what I expected.
> > > > > 
> > > > > While this is not possible, the only requests I have for this
> > > > > patch is that we clearly document:
> > > > > * What's the only purpose of share=on on a host-memory-backend
> > > > >   object (due to pvrdma limitations).
> > > > > * The potential undesirable side-effects of setting share=on.
> > > > > * On the commit message and other comments, clearly distinguish
> > > > >   HVAs in the QEMU address-space from IOVAs, to avoid confusion.
> > > > 
> > > > Looking forward, when we do support it, how will management find out
> > > > it no longer needs to pass the share parameter?
> > > > 
> > > > Further, if the side effects of the share parameter go away,
> > > > how will it know these no longer hold?
> > > 
> > > A query-host-capabilities or similar QMP command seems necessary
> > > for that.
> > 
> > Is anyone working on that?
> 
> Not yet.
> 
> -- 
> Eduardo

Do these patches need to wait until we do have that command?

I'm thinking it's better to have "share=on required with rdma"
and "hugetlbfs not supported with rdma"
than the reverse, this way new hosts do not need to carry
thus stuff around forever.

Also, how does management know which devices are affected?

-- 
MST
