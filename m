Received: from eggs.gnu.org ([2001:4830:134:3::10]:51339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fhvwJ-00072s-DA
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fhvwG-0001tG-Aa
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:57:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51830 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fhvwG-0001rP-4l
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:57:12 -0400
Date: Tue, 24 Jul 2018 14:57:08 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180724145603-mutt-send-email-mst@kernel.org>
References: <CAHyh4xjUmwHr7b=92y7YUwKGSW0o+FUMwJLSehdzuFc3R6eLTg@mail.gmail.com>
	<20180724055501.GA2479@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724055501.GA2479@xz-mi>
Subject: Re: [Qemu-devel] Virtual IOMMU + Virtio-net devices in a Windows VM
 doesn't work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Jintack Lim <jintack@cs.columbia.edu>, QEMU Devel Mailing List <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, yvugenfi@redhat.com

On Tue, Jul 24, 2018 at 01:55:01PM +0800, Peter Xu wrote:
> On Mon, Jul 23, 2018 at 04:13:18PM -0400, Jintack Lim wrote:
> > Hi,
> > 
> > I'm running a Windows VM on top of KVM on x86, and one of virtio-net
> > device in the Windows VM doesn't seem to work. I provided virtual
> > IOMMU and two virtio-net devices to the VM: one bypassing the virtual
> > IOMMU and the other one behind the virtual IOMMU[1]. It turned out
> > that the virtio-net device behind virtual IOMMU didn't work while the
> > one bypassing the virtual IOMMU worked well. In a linux VM with the
> > same configuration, both of virtio-net device worked well.
> > 
> > I found that there is a subtle difference between virtio-net devices
> > bypassing and behind virtual IOMMU in a Linux VM. The lscpu command in
> > the Linux VM shows different device names for them; the first line is
> > for the bypassing one, and the second line is for the one behind the
> > virtual IOMMU
> > 
> > 00:03.0 Ethernet controller: Red Hat, Inc Virtio network device
> > 01:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
> > 
> > I wonder if this difference somehow caused the problem in the Windows
> > VM. I've installed the latest virtio drivers (0.1.149) from the fedora
> > project [2]
> > 
> > Any thoughts?
> > 
> > I'm using v4.15 Linux kernel as a host, and QEMU 2.11.0.
> 
> Have you tried the latest QEMU?
> 
> Also CC Jason and Michael.

I'm not sure windows virtio drivers support the virtual iommu option.
CC Yan to make sure.

> > 
> > Thanks,
> > Jintack
> > 
> > [1] https://wiki.qemu.org/Features/VT-d
> > [2] https://docs.fedoraproject.org/quick-docs/en-US/creating-windows-virtual-machines-using-virtio-drivers.html
> > 
> > 
> 
> Regards,
> 
> -- 
> Peter Xu
