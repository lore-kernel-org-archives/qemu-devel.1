Received: from eggs.gnu.org ([2001:4830:134:3::10]:60522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ckuHr-0006c4-TU
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ckuHo-0006Z4-MM
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:10:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ckuHo-0006W5-9o
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:10:56 -0500
Date: Mon, 6 Mar 2017 17:10:52 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170306170940-mutt-send-email-mst@kernel.org>
References: <1488011202-32121-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<58BD1982.30509@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58BD1982.30509@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v10 0/8] the reset of msix_init series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Hannes Reinecke <hare@suse.de>, Dmitry Fleytman <dmitry@daynix.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Mar 06, 2017 at 04:10:42PM +0800, Cao jin wrote:
> Michael,
> Is this series ok for 2.9?
> 
> -- 
> Sincerely,
> Cao jin

I'll consider it for 2.10.  Sorry it's taking a long time, the benefit
here is rather small so I don't see a reason to hurry.

> On 02/25/2017 04:26 PM, Cao jin wrote:
> > v10 changelog:
> > 1. drop the unliked patch, introduce a new patch 1 according to mst's comments.
> > 2. base on the new patch, remove the following statements
> > 
> >         /* Any error other than -ENOTSUP(board's MSI support is broken)
> >          * is a programming error */
> >         assert(!ret || ret == -ENOTSUP);
> > 
> >    for the affected device: megasas, hcd-xhci. This is trivial changes,
> >    so I left the R-bs where it was.
> > 
> > Test:
> > 1. Detailed test via command line as v9
> > 2. make check hangs at: GTESTER check-qtest-x86_64. After ctrl-C, it says:
> > 
> >     make: *** [check-qtest-x86_64] Interrupt
> >     qemu-system-x86_64: Failed to read msg header. Read -1 instead of 12. Original request 11.
> >     qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Input/output error (5)
> >     qemu-system-x86_64: Failed to set msg fds.
> >     qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Invalid argument (22)
> > 
> >     qemu-system-x86_64: Failed to set msg fds.
> >     qemu-system-x86_64: vhost VQ 1 ring restore failed: -1: Invalid argument (22)
> > 
> >    Is it a regresstion or I missed something?
> > 
> > CC: Jason Wang <jasowang@redhat.com>
> > CC: Gerd Hoffmann <kraxel@redhat.com>
> > CC: Dmitry Fleytman <dmitry@daynix.com>
> > CC: Michael S. Tsirkin <mst@redhat.com>
> > CC: Hannes Reinecke <hare@suse.de>
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > CC: Alex Williamson <alex.williamson@redhat.com>
> > CC: Markus Armbruster <armbru@redhat.com>
> > CC: Marcel Apfelbaum <marcel@redhat.com>
> > 
> > Cao jin (8):
> >   msix: Rename and create a wrapper
> >   megasas: change behaviour of msix switch
> >   hcd-xhci: change behaviour of msix switch
> >   megasas: undo the overwrites of msi user configuration
> >   vmxnet3: fix reference leak issue
> >   vmxnet3: remove unnecessary internal msix flag
> >   msi_init: convert assert to return -errno
> >   megasas: remove unnecessary megasas_use_msix()
> > 
> >  hw/net/vmxnet3.c      | 40 +++++++++++++++-------------------------
> >  hw/pci/msi.c          |  9 ++++++---
> >  hw/pci/msix.c         | 30 +++++++++++++++++++++---------
> >  hw/scsi/megasas.c     | 48 +++++++++++++++++++++++++-----------------------
> >  hw/usb/hcd-xhci.c     | 29 +++++++++++++++++++++--------
> >  hw/vfio/pci.c         | 12 ++++++------
> >  include/hw/pci/msix.h |  5 +++++
> >  7 files changed, 99 insertions(+), 74 deletions(-)
> > 
> 
> 
> 
