Received: from eggs.gnu.org ([2001:4830:134:3::10]:41924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fL89A-0002Lu-VK
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fL899-0005f1-Qx
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:20:16 -0400
Date: Tue, 22 May 2018 17:19:50 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180522171112-mutt-send-email-mst@kernel.org>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180518170956.GI8615@redhat.com>
	<20180522073555.peibbwoqvbor7nrs@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522073555.peibbwoqvbor7nrs@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, kwolf@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On Tue, May 22, 2018 at 09:35:55AM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > You must /sometimes/ supply the correct machine type.
> > 
> > It is quite dependent on the guest OS you have installed, and even
> > just how the guest OS is configured.  In general Linux is very
> > flexible and can adapt to a wide range of hardware, automatically
> > detecting things as needed. It is possible for a sysadmin to build
> > a Linux image in a way that would only work with I440FX, but I
> > don't think it would be common to see that.
> 
> I think it would be pretty hard to actually build such an image.
> 
> The more critical thing for linux guests is the storage driver which
> must be included into the initrd so the image can mount the root
> filesystem.  And the firmware, bios vs. uefi is more critical than
> pc vs. q35.

I think we can start by finding a location to embed a string in a qcow
image, add ability for qemu-img to set and get this string.  We can
discuss how it's formatted separately.

> > That said I'm not really convinced that using the qcow2 headers is
> > a good plan. We have many disk image formats in common use, qcow2
> > is just one. Even if the user provides the image in qcow2 format,
> > that doesn't mean that mgmt apps actually store the qcow2 file.
> 
> > I tend to think we'd be better looking at what we can do in the context
> > of an existing standard like OVF rather than inventing something that
> > only works with qcow2. I think it would need to be more expressive than
> > just a single list of key,value pairs for each item.
> 
> Embed OVF metadata in the qcow2 image?
> 
> cheers,
>   Gerd

What would be helpful is if we could tell the user who wonders
how to run an image "hey you probably want flags X,Y and Z".
I can see how we could have an option to either stick
a bit of XML there, or just some QEMU flags.

-- 
MST
