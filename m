Received: from eggs.gnu.org ([2001:4830:134:3::10]:50148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fPeS2-0004Ae-RK
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fPeRz-0006Ch-P3
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:38:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39620 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fPeRz-0006Cd-Ks
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:38:23 -0400
Date: Mon, 4 Jun 2018 04:38:22 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180604042928-mutt-send-email-mst@kernel.org>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net

On Sun, Jun 03, 2018 at 12:27:49PM +0300, Marcel Apfelbaum wrote:
> Moving to QEMU 3.0 seems like a good opportunity for such a change.
> 
> I440FX is really old and does not support modern features like IOMMU.
> Q35's SATA emulation is faster than pc's IDE, native PCI express hotplug
> is cleaner than ACPI based one and so on...
> 
> Also the libvirt guys added very good support for the Q35 machine (thanks!).
> 
> Management software should always specify the machine type and for the
> current setups, adding '-machine pc' to the command line is not such a
> big deal.
> 
> In time the pc machine will fade out and we will probably stop adding
> new versions at some point.
> 
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

For command line users, I think changing the default isn't nice.

Yes it's easy to add -machine pc but there's no documentation
that tells you to do so. Add to that shortcuts like -cdrom
stop working, hotplug needs extra bridges to work, and one
can see that while management tool users benefit from q35,
command line users will suffer.

Can't we add a tag for management without changing the command line
default? How about "management-default"? "recommended"? "latest"?

-- 
MST
