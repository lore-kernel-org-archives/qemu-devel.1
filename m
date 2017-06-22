Received: from eggs.gnu.org ([2001:4830:134:3::10]:34959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dO5sw-0004hz-Il
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dO5sv-0002Ux-Jg
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:27:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dO5sv-0002Uk-DL
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:27:13 -0400
Date: Thu, 22 Jun 2017 11:27:09 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170622112709.51bd4885@w520.home>
In-Reply-To: <CAB995Mv3naMDu1e2zvzDn77GGNqwPXWUoJOrO0ZMs8B5YooRAQ@mail.gmail.com>
References: <CAB995MvCYo=tWGg-tC5R-GmRqtdiaLaU_rHTprpRJ_hMJK6Rtw@mail.gmail.com>
	<20170622105935.2dbd574d@w520.home>
	<CAB995Mv3naMDu1e2zvzDn77GGNqwPXWUoJOrO0ZMs8B5YooRAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Query on VFIO in Virtual machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nitin Saxena <nitin.lnx@gmail.com>
Cc: linux-kernel@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

On Thu, 22 Jun 2017 22:42:19 +0530
Nitin Saxena <nitin.lnx@gmail.com> wrote:

> Thanks Alex.
> 
> >> Without an iommu in the VM, you'd be limited to no-iommu support for VM userspace,  
> So are you trying to say VFIO NO-IOMMU should work inside VM. Does
> that mean VFIO NO-IOMMU in VM and VFIO IOMMU in host for same device
> is a legitimate configuration? I did tried this configuration and the
> application (in VM) seems to get container_fd, group_fd, device_fd
> successfully but after VFIO_DEVICE_RESET ioctl the PCI link breaks
> from VM as well as from host. This could be specific to PCI endpoint
> device which I can dig.
> 
> I will be happy if VFIO NO-IOMMU in VM and IOMMU in host for same
> device is legitimate configuration.

Using no-iommu in the guest should work in that configuration, however
there's no isolation from the user to the rest of VM memory, so the VM
kernel will be tainted.  Host memory does have iommu isolation.  Device
reset from VM userspace sounds like another bug to investigate.  Thanks,

Alex
