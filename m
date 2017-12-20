Received: from eggs.gnu.org ([2001:4830:134:3::10]:59104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRi6W-0003V0-JQ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:24:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRi6T-0003KE-Gz
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:24:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRi6T-0003Jx-Ag
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:24:25 -0500
Date: Wed, 20 Dec 2017 19:24:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171220192116-mutt-send-email-mst@kernel.org>
References: <20171213082644.83113-1-ben@skyportsystems.com>
	<20171213100712.GA16782@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171213100712.GA16782@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Add subsystem-vendor-id
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: ben@skyportsystems.com, qemu-devel@nongnu.org, yan@daynix.com, eswierk@skyportsystems.com, lprosek@redhat.com

On Wed, Dec 13, 2017 at 10:07:12AM +0000, Stefan Hajnoczi wrote:
> On Wed, Dec 13, 2017 at 12:26:44AM -0800, Ben Warren via Qemu-devel wrote:
> > From: Ben Warren <ben@skyportsystems.com>
> > 
> > Now that virtio-win guest drivers provided by non-Redhat vendors need to
> > use a different Subsystem Vendor ID value, a way is needed to set this
> > parameter on the host.  This works with all of the PCI-based devices,
> > such as NetKVM, viostor, vioscsi, vioserial and balloon.
> > 
> > Signed-off-by: Ben Warren <ben@skyportsystems.com>
> > ---
> >  hw/virtio/virtio-pci.c | 5 +++++
> >  hw/virtio/virtio-pci.h | 1 +
> >  2 files changed, 6 insertions(+)
> 
> Is it possible to put this property in hw/pci/pci.c:pci_props[] so that
> users can override the Subsystem Vendor ID for any PCI adapter, not just
> virtio-pci?

The difficulty is that some devices override the ID you would set,
and there's no way for management to find out.
So I think virtio is preferable for now.
