Received: from eggs.gnu.org ([2001:4830:134:3::10]:35119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQWvY-0004M7-4H
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQWvX-0001bV-3i
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:48:32 -0400
Date: Wed, 6 Jun 2018 12:48:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180606114817.GC3064@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm> <20180606114228.GH1455@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180606114228.GH1455@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

On Wed, Jun 06, 2018 at 12:42:28PM +0100, Richard W.M. Jones wrote:
> On Wed, Jun 06, 2018 at 12:14:07PM +0100, Dr. David Alan Gilbert wrote:
> > The problem with having a separate file is that you either have to copy
> > it around with the image or have an archive.  If you have an archive
> > you have to have an unpacking step which then copies, potentially a lot
> > of data taking some reasonable amount of time.  Storing a simple bit
> > of data with the image avoids that.
> 
> This isn't really true.  For OVA (ie. tar) we don't unpack them.
> Adding file.offset and file.size in qemu's raw driver was crucial to
> that optimization.

Though that assumes you're only using the qcow2 file in read-only mode.
As soon as you need write access you need to unpack from the OVA so that
the qcow2 file can grow its length when new sectors are allocated.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
