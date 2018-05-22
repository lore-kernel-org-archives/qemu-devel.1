Received: from eggs.gnu.org ([2001:4830:134:3::10]:52227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fL8oH-0005Zr-GE
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fL8oB-0000R3-GZ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:02:45 -0400
Date: Tue, 22 May 2018 17:02:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180522150221.GF6233@localhost.localdomain>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180518170956.GI8615@redhat.com>
	<20180522073555.peibbwoqvbor7nrs@sirius.home.kraxel.org>
	<20180522171112-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522171112-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

Am 22.05.2018 um 16:19 hat Michael S. Tsirkin geschrieben:
> On Tue, May 22, 2018 at 09:35:55AM +0200, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > > You must /sometimes/ supply the correct machine type.
> > > 
> > > It is quite dependent on the guest OS you have installed, and even
> > > just how the guest OS is configured.  In general Linux is very
> > > flexible and can adapt to a wide range of hardware, automatically
> > > detecting things as needed. It is possible for a sysadmin to build
> > > a Linux image in a way that would only work with I440FX, but I
> > > don't think it would be common to see that.
> > 
> > I think it would be pretty hard to actually build such an image.
> > 
> > The more critical thing for linux guests is the storage driver which
> > must be included into the initrd so the image can mount the root
> > filesystem.  And the firmware, bios vs. uefi is more critical than
> > pc vs. q35.
> 
> I think we can start by finding a location to embed a string in a qcow
> image, add ability for qemu-img to set and get this string.  We can
> discuss how it's formatted separately.

If we want it, we'll find a place to store it.

But the first thing we need is a spec for what's actually in it. Just
storing a machine type hint would be a one-off hack that wouldn't last
very long before we want to add the next thing.

Essentially, what we need is a description of the virtual machine that
we suggest to use with this image. We can try to reuse something
existing there, like libvirt XML or OVF, or invent something new (a JSON
array describing runtime options?). One difference to existing formats
is probably that we want only frontends and no backends in the
description.

Kevin
