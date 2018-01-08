Received: from eggs.gnu.org ([2001:4830:134:3::10]:42800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1eYZcI-00037C-NS
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1eYZcF-0000DC-JA
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:45:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1eYZcF-0000AW-AT
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:45:35 -0500
Message-ID: <1515426330.3287.6.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Mon, 08 Jan 2018 16:45:30 +0100
In-Reply-To: <20180103220651.GE2787@redhat.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<20180103113544.GI2450@redhat.com>
	<CAHNT7Nvo-O2s6xX7kdh-EDd+TSpKHqHAzpGUS7vcUWJBV2Op3w@mail.gmail.com>
	<20180103220651.GE2787@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 00/21] RISC-V QEMU Port Submission v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, Michael Clark <mjc@sifive.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Wed, 2018-01-03 at 22:06 +0000, Richard W.M. Jones wrote:
> On Thu, Jan 04, 2018 at 10:50:06AM +1300, Michael Clark wrote:
> > > (2) I'm worried that this patch starts off using virtio-mmio instead
> > > of virtio-pci.  virtio-pci is better in every respect than
> > > virtio-mmio, and while it may be a good interim solution I think we
> > > need to have a plan to get rid of it eventually, and should make it
> > > clear that virtio-mmio is not a permanent ABI so we don't get into the
> > > same situation that we did with -M virt on ARM.
> > 
> > I've noted in [PATCH v1 00/00] that we have a goal to add GPEX to the
> > SiFive RISC-V virt board. The idea with the initial version of the virt
> > board is to provide enough infrastructure so that distro builders can use
> > RISC-V QEMU. Prior to the work to implement PLIC, device-tree and VirtIO,
> > there was no network and block device support so it was not possible to use
> > QEMU for distro bring up. Now RISC-V QEMU is usable. Data point: the arm
> > 'virt' board still supports VirtIO MMIO. I don't think this should be a
> > blocking issue.
> 
> I don't think it should be blocking either, but I also think (from
> experience with ARM mach_virt) that we should make it clear that we're
> going to have a flag day down the road where we just remove
> virtio-mmio and everyone will be required to recompile their kernel,
> rather than keep supporting virtio-mmio long term.  However that's
> just my opinion, would like to hear what others say.

Having jumped through many of the same hoops with aarch64/virt as
Rich, although on the libvirt side, I agree with both of you that
virtio-pci should not be a requirement for inclusion: virtio-mmio
is perfectly fine as long as it's very explicitly presented as an
interim solution; the improvements virtio-pci brings to the table
should be plenty to convince people to quickly switch to it, too.

-- 
Andrea Bolognani / Red Hat / Virtualization
