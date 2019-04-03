Received: from eggs.gnu.org ([209.51.188.92]:46739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hBbiq-0007rM-1T
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hBbio-00077q-Un
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:58:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hBbio-000747-Nl
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:58:14 -0400
Date: Wed, 3 Apr 2019 16:58:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190403085802.GA3453@xz-x1>
References: <20190329061422.7926-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190329061422.7926-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] intel_iommu: misc scalable mode
 fixes for 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>

On Fri, Mar 29, 2019 at 02:14:20PM +0800, Peter Xu wrote:
> v2:
> - patch 2: use "1" instead of "sizeof(bool)" for VMSTATE_UNUSED
>   because sizeof(bool) can be >1 depends on definition [Dave]
> 
> The first patch is the important one.  It should fix up a migration
> issue that Dave reported between 3.1<->4.0.  The second patch is born
> only because I noticed it when drafting patch 1 and I think we can
> probably do that too together as a fixup to the scalable patchset for
> 4.0.

Ping - just want to make sure this series won't miss 4.0.  Thanks,

-- 
Peter Xu
