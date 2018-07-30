Received: from eggs.gnu.org ([2001:4830:134:3::10]:39565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fk9WJ-0004Xj-FH
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fk9WG-0001B3-Uy
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:51:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fk9WG-0001Aj-Px
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:51:32 -0400
Date: Mon, 30 Jul 2018 17:51:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180730174601-mutt-send-email-mst@kernel.org>
References: <20180717222721.14019.27548.stgit@gimli.home>
	<20180730163123-mutt-send-email-mst@kernel.org>
	<20180730083939.23f3b9cc@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730083939.23f3b9cc@t450s.home>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Balloon inhibit enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

On Mon, Jul 30, 2018 at 08:39:39AM -0600, Alex Williamson wrote:
> This is more
> compatible with the IOMMU mappings,

Precisely. These are at page granularity.

> but I don't think it can be done
> atomically with respect to inflight DMA of a physical device where we
> cannot halt the device without interfering with its state.

Guests never add pages to the balloon if they are under DMA,
so that's fine - there's never an in-flight DMA, if
there is guest is buggy and it's ok to crash it.

-- 
MST
