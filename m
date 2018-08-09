Received: from eggs.gnu.org ([2001:4830:134:3::10]:56530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fnh7P-0004fq-Hb
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 05:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fnh7M-0000Za-10
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 05:20:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fnh7L-0000Wu-IB
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 05:20:27 -0400
Date: Thu, 9 Aug 2018 12:20:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180809121649-mutt-send-email-mst@kernel.org>
References: <20180807193125.30378-1-alex.williamson@redhat.com>
	<20180807224033-mutt-send-email-mst@kernel.org>
	<20180807135303.3938b3a2@t450s.home>
	<20180808004929-mutt-send-email-mst@kernel.org>
	<20180808034543.GC24415@xz-mi> <20180808162304.42d3fecc@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808162304.42d3fecc@t450s.home>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Balloon inhibit enhancements,
 vfio restriction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, david@redhat.com

On Wed, Aug 08, 2018 at 04:23:04PM -0600, Alex Williamson wrote:
> So again, I think this comes down to new iommu driver support and new
> iommu apis and new vfio apis to enable some sort of atomic update
> interface,

Oh absolutely. My point is some guest OS can start using atomic updates
at any time since it's something IOMMU hardware supports.  Adherence to
a hardware spec would be preferable to adherence to an internal Linux
API.  I appreciate it's not an easy task involving host Linux and QEMU
changes.

-- 
MST
