Received: from eggs.gnu.org ([2001:4830:134:3::10]:47703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ewhAY-0005Fq-MR
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 00:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ewhAT-0000pd-NM
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 00:40:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54316 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ewhAT-0000pQ-IN
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 00:40:37 -0400
Date: Fri, 16 Mar 2018 12:40:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180316044017.GC2477@xz-mi>
References: <20180315212634.15150.88094.stgit@gimli.home>
	<20180315213157.15150.86812.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315213157.15150.86812.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] vfio/pci: Add ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, eric.auger@redhat.com, aik@ozlabs.ru

On Thu, Mar 15, 2018 at 03:31:58PM -0600, Alex Williamson wrote:
> The ioeventfd here is actually irqfd handling of an ioeventfd such as
> supported in KVM.  A user is able to pre-program a device write to
> occur when the eventfd triggers.  This is yet another instance of
> eventfd-irqfd triggering between KVM and vfio.  The impetus for this
> is high frequency writes to pages which are virtualized in QEMU.
> Enabling this near-direct write path for selected registers within
> the virtualized page can improve performance and reduce overhead.
> Specifically this is initially targeted at NVIDIA graphics cards where
> the driver issues a write to an MMIO register within a virtualized
> region in order to allow the MSI interrupt to re-trigger.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
