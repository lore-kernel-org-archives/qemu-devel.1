Received: from eggs.gnu.org ([2001:4830:134:3::10]:50733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhqHx-0001to-6I
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 01:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhqHt-0000Ox-VM
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 01:55:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fhqHt-0000Mj-R9
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 01:55:09 -0400
Date: Tue, 24 Jul 2018 13:55:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180724055501.GA2479@xz-mi>
References: <CAHyh4xjUmwHr7b=92y7YUwKGSW0o+FUMwJLSehdzuFc3R6eLTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHyh4xjUmwHr7b=92y7YUwKGSW0o+FUMwJLSehdzuFc3R6eLTg@mail.gmail.com>
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
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, Jul 23, 2018 at 04:13:18PM -0400, Jintack Lim wrote:
> Hi,
> 
> I'm running a Windows VM on top of KVM on x86, and one of virtio-net
> device in the Windows VM doesn't seem to work. I provided virtual
> IOMMU and two virtio-net devices to the VM: one bypassing the virtual
> IOMMU and the other one behind the virtual IOMMU[1]. It turned out
> that the virtio-net device behind virtual IOMMU didn't work while the
> one bypassing the virtual IOMMU worked well. In a linux VM with the
> same configuration, both of virtio-net device worked well.
> 
> I found that there is a subtle difference between virtio-net devices
> bypassing and behind virtual IOMMU in a Linux VM. The lscpu command in
> the Linux VM shows different device names for them; the first line is
> for the bypassing one, and the second line is for the one behind the
> virtual IOMMU
> 
> 00:03.0 Ethernet controller: Red Hat, Inc Virtio network device
> 01:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
> 
> I wonder if this difference somehow caused the problem in the Windows
> VM. I've installed the latest virtio drivers (0.1.149) from the fedora
> project [2]
> 
> Any thoughts?
> 
> I'm using v4.15 Linux kernel as a host, and QEMU 2.11.0.

Have you tried the latest QEMU?

Also CC Jason and Michael.

> 
> Thanks,
> Jintack
> 
> [1] https://wiki.qemu.org/Features/VT-d
> [2] https://docs.fedoraproject.org/quick-docs/en-US/creating-windows-virtual-machines-using-virtio-drivers.html
> 
> 

Regards,

-- 
Peter Xu
