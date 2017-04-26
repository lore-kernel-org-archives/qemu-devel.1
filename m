Received: from eggs.gnu.org ([2001:4830:134:3::10]:42503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d3WEx-0008Sr-EZ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 19:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d3WEs-00072f-Hj
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 19:20:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d3WEs-00072G-Bl
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 19:20:50 -0400
Date: Thu, 27 Apr 2017 02:20:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170426192753-mutt-send-email-mst@kernel.org>
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<1492076108-117229-3-git-send-email-wei.w.wang@intel.com>
	<20170413184040-mutt-send-email-mst@kernel.org>
	<58F08A60.2020407@intel.com>
	<20170415000934-mutt-send-email-mst@kernel.org>
	<58F43801.7060004@intel.com>
	<286AC319A985734F985F78AFA26841F7391F6DCD@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F7391F6DCD@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v9 2/5] virtio-balloon:
 VIRTIO_BALLOON_F_BALLOON_CHUNKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com" <david@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>

On Wed, Apr 26, 2017 at 11:03:34AM +0000, Wang, Wei W wrote:
> Hi Michael, could you please give some feedback?

I'm sorry, I'm not sure feedback on what you are requesting.

The interface looks reasonable now, even though there's
a way to make it even simpler if we can limit chunk size
to 2G (in fact 4G - 1). Do you think we can live with this
limitation?

But the code still needs some cleanup.

-- 
MST
