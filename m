Received: from eggs.gnu.org ([2001:4830:134:3::10]:44425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fBNG5-0005cU-5f
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 12:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fBNG2-0001I0-31
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 12:27:05 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57737)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fBNG1-0001HG-Qw
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 12:27:02 -0400
Date: Wed, 25 Apr 2018 12:26:58 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180425162658.GA9204@flamenco>
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425045129.17449-4-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/10] intel-iommu: add iommu lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, "Michael S . Tsirkin" <mst@redhat.com>

On Wed, Apr 25, 2018 at 12:51:22 +0800, Peter Xu wrote:
> Add a per-iommu big lock to protect IOMMU status.  Currently the only
> thing to be protected is the IOTLB cache, since that can be accessed
> even without BQL, e.g., in IO dataplane.

Is the added lock going to protect anything else beyond a g_hash_table?
If not, did you consider using qht instead of the lock + hash table?
It would give you lockless lookups as well as scalable updates.

[Sorry if my question isn't relevant, I am not familiar with
this code and just briefly skimmed over this series.]

Thanks,

		Emilio
