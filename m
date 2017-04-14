Received: from eggs.gnu.org ([2001:4830:134:3::10]:60793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cyx1t-0007se-Fk
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cyx1o-0008GV-Lh
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:56:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:44590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cyx1o-0008FN-Cp
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:56:28 -0400
Message-ID: <58F08F1F.8020904@intel.com>
Date: Fri, 14 Apr 2017 16:58:07 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<1492076108-117229-4-git-send-email-wei.w.wang@intel.com>
	<20170413130217.2316b0394192d8677f5ddbdf@linux-foundation.org>
	<58F03443.9040202@intel.com>
	<20170414025824.GK784@bombadil.infradead.org>
In-Reply-To: <20170414025824.GK784@bombadil.infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 3/5] mm: function to offer a page block
 on the free list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On 04/14/2017 10:58 AM, Matthew Wilcox wrote:
> On Fri, Apr 14, 2017 at 10:30:27AM +0800, Wei Wang wrote:
>> OK. What do you think if we add this:
>>
>> #if defined(CONFIG_VIRTIO_BALLOON) || defined(CONFIG_VIRTIO_BALLOON_MODULE)
> That's spelled "IS_ENABLED(CONFIG_VIRTIO_BALLOON)", FYI.

Right, thanks.

Best,
Wei
