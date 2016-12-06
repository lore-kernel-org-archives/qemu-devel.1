Received: from eggs.gnu.org ([2001:4830:134:3::10]:43320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cELig-0006q1-Al
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cELid-0007xY-NZ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:48:06 -0500
Date: Tue, 6 Dec 2016 17:48:00 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161206194800.GH4027@thinpad.lan.raisama.net>
References: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20161206213023-mutt-send-email-mst@kernel.org>
	<20161206193349.GF4027@thinpad.lan.raisama.net>
	<20161206213545-mutt-send-email-mst@kernel.org>
	<20161206194029.GG4027@thinpad.lan.raisama.net>
	<20161206214217-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161206214217-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] virtio: fix HW_COMPAT_2_6 macro for
 virtio-*-pci drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Dec 06, 2016 at 09:44:11PM +0200, Michael S. Tsirkin wrote:
> On Tue, Dec 06, 2016 at 05:40:29PM -0200, Eduardo Habkost wrote:
> > On Tue, Dec 06, 2016 at 09:36:07PM +0200, Michael S. Tsirkin wrote:
> > > On Tue, Dec 06, 2016 at 05:33:49PM -0200, Eduardo Habkost wrote:
> > > > On Tue, Dec 06, 2016 at 09:31:43PM +0200, Michael S. Tsirkin wrote:
> > > > > On Tue, Dec 06, 2016 at 06:50:47PM +0100, Greg Kurz wrote:
> > > > > > Since commit "9a4c0e220d8a hw/virtio-pci: fix virtio behaviour", passing
> > > > > > -device virtio-blk-pci.disable-modern=off has no effect on 2.6 machine
> > > > > > types because the internal virtio-pci.disable-modern=on compat property
> > > > > > always prevail.
> > > > > > 
> > > > > > This should ideally be fixed in the qdev properties core code, but it is
> > > > > > too late in the QEMU 2.8 schedule. So this patch fixes the issue by setting
> > > > > > the compat properties for every virtio-*-pci subtypes instead of the base
> > > > > > virtio-pci type.
> > > > > > 
> > > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > 
> > > > > What's the rush? Either the issue is or isn't 2.8 material. If it is,
> > > > > let's fix it in qdev core now. If it isn't no need for quick fixes,
> > > > > just wait a bit and merge qdev core fix after 2.8 is out.
> > > > 
> > > > Because it is a regression,
> > > 
> > > Regression in 2.7 though, isn't it?
> > 
> > Yes. Does that mean we don't mind leaving a regression unfixed in
> > 2.8 because it was introduced in 2.7?
> 
> Not necessarily, it's a judgement call.  But there will always be
> another release.  I would say don't rush it.

My judgement is that it won't hurt to include the HW_COMPAT_* fix
for virtio-pci (this patch, after including the missing classes I
pointed out), because it is simple and obvious.

But I agree that this means we don't need the more complex hack I
just sent as RFC.

-- 
Eduardo
