Received: from eggs.gnu.org ([2001:4830:134:3::10]:50997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fEQI9-0007g2-HK
	for qemu-devel@nongnu.org; Thu, 03 May 2018 22:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fEQI7-0005j4-2Y
	for qemu-devel@nongnu.org; Thu, 03 May 2018 22:17:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fEQI6-0005ih-TR
	for qemu-devel@nongnu.org; Thu, 03 May 2018 22:17:46 -0400
Date: Fri, 4 May 2018 10:17:34 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180504021734.GJ29580@xz-mi>
References: <20180503213458.2749.28566.stgit@gimli.home>
	<20180503214513.2749.30627.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180503214513.2749.30627.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH v3 6/6] vfio/quirks: Enable ioeventfd
 quirks to be handled by vfio directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, eric.auger@redhat.com

On Thu, May 03, 2018 at 03:45:13PM -0600, Alex Williamson wrote:
> With vfio ioeventfd support, we can program vfio-pci to perform a
> specified BAR write when an eventfd is triggered.  This allows the
> KVM ioeventfd to be wired directly to vfio-pci, entirely avoiding
> userspace handling for these events.  On the same micro-benchmark
> where the ioeventfd got us to almost 90% of performance versus
> disabling the GeForce quirks, this gets us to within 95%.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
