Received: from eggs.gnu.org ([2001:4830:134:3::10]:44198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8631c8a8c=anthony.perard@citrix.com>)
	id 1gS3xZ-0001VY-O6
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8631c8a8c=anthony.perard@citrix.com>)
	id 1gS3hV-0001TK-Hk
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:32:38 -0500
Date: Wed, 28 Nov 2018 17:32:01 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181128173201.GD14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-3-paul.durrant@citrix.com>
	<20181128171001.GC14786@perard.uk.xensource.com>
	<79c7ea5f1b8041d7828240ec18f881f4@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <79c7ea5f1b8041d7828240ec18f881f4@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] [PATCH 02/18] xen: introduce new 'XenBus' and
 'XenDevice' object hierarchy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Nov 28, 2018 at 05:17:10PM +0000, Paul Durrant wrote:
> > Will we need a hotplug handler for this bus, like it is done with
> > TYPE_XENSYSBUS?
> 
> I didn't seem to need one even doing 'xl block-attach' after the VM had booted. I'm really not sure what that does.

Indeed, that works fine, and I think I've tested block-detach as well.
Maybe we will need something if we initiate attach of a block device via
QMP instead of xenstore, but we can fix that later.

-- 
Anthony PERARD
