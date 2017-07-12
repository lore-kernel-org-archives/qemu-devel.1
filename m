Received: from eggs.gnu.org ([2001:4830:134:3::10]:46895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVHIP-0002o9-Pc
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVHIK-0004fL-Sr
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:03:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:36969)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dVHIK-0004eZ-Jr
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:03:08 -0400
Message-ID: <59661EA2.2040708@intel.com>
Date: Wed, 12 Jul 2017 21:05:38 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-4-git-send-email-wei.w.wang@intel.com>
	<20170613200049-mutt-send-email-mst@kernel.org>
	<594240E9.2070705@intel.com>
	<20170628150450.GA1402@bombadil.infradead.org>
In-Reply-To: <20170628150450.GA1402@bombadil.infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v11 3/6] virtio-balloon:
 VIRTIO_BALLOON_F_PAGE_CHUNKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

Hi Matthew,

On 06/28/2017 11:04 PM, Matthew Wilcox wrote:
> On Thu, Jun 15, 2017 at 04:10:17PM +0800, Wei Wang wrote:
>>> So you still have a home-grown bitmap. I'd like to know why
>>> isn't xbitmap suggested for this purpose by Matthew Wilcox
>>> appropriate. Please add a comment explaining the requirements
>>> from the data structure.
>> I didn't find his xbitmap being upstreamed, did you?
> It doesn't have any users in the tree yet.  Can't add code with new users.
> You should be the first!

Glad to be the first person eating your tomato. Taste good :-)
Please have a check how it's cooked in the latest v12 patches. Thanks.

Best,
Wei
