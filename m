Received: from eggs.gnu.org ([2001:4830:134:3::10]:39077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d3cwI-0004cr-IN
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d3cwF-0007zA-FP
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:30:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:23048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d3cwF-0007vL-6Q
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:30:03 -0400
Message-ID: <59019055.3040708@intel.com>
Date: Thu, 27 Apr 2017 14:31:49 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<1492076108-117229-3-git-send-email-wei.w.wang@intel.com>
	<20170413184040-mutt-send-email-mst@kernel.org>
	<58F08A60.2020407@intel.com>
	<20170415000934-mutt-send-email-mst@kernel.org>
	<58F43801.7060004@intel.com>
	<286AC319A985734F985F78AFA26841F7391F6DCD@shsmsx102.ccr.corp.intel.com>
	<20170426192753-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170426192753-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com" <david@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>

On 04/27/2017 07:20 AM, Michael S. Tsirkin wrote:
> On Wed, Apr 26, 2017 at 11:03:34AM +0000, Wang, Wei W wrote:
>> Hi Michael, could you please give some feedback?
> I'm sorry, I'm not sure feedback on what you are requesting.
Oh, just some trivial things (e.g. use a field in the
header, hdr->chunks to indicate the number of chunks
in the payload) that wasn't confirmed.

I will prepare the new version with fixing the agreed issues,
and we can continue to discuss those parts if you still find
them improper.


>
> The interface looks reasonable now, even though there's
> a way to make it even simpler if we can limit chunk size
> to 2G (in fact 4G - 1). Do you think we can live with this
> limitation?
Yes, I think we can. So, is it good to change to use the
previous 64-bit chunk format (52-bit base + 12-bit size)?


>
> But the code still needs some cleanup.
>

OK. We'll also still to discuss your comments in the patch 05.

Best,
Wei
