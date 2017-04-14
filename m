Received: from eggs.gnu.org ([2001:4830:134:3::10]:54245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cyqwr-0001In-Jp
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 22:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cyqwo-0002C4-F3
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 22:26:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:63276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cyqwo-0002Bg-5l
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 22:26:54 -0400
Message-ID: <58F033D0.7080101@intel.com>
Date: Fri, 14 Apr 2017 10:28:32 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<20170413204411.GJ784@bombadil.infradead.org>
	<20170414044515-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170414044515-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 0/5] Extend virtio-balloon for fast
 (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On 04/14/2017 09:50 AM, Michael S. Tsirkin wrote:
> On Thu, Apr 13, 2017 at 01:44:11PM -0700, Matthew Wilcox wrote:
>> On Thu, Apr 13, 2017 at 05:35:03PM +0800, Wei Wang wrote:
>>> 2) transfer the guest unused pages to the host so that they
>>> can be skipped to migrate in live migration.
>> I don't understand this second bit.  You leave the pages on the free list,
>> and tell the host they're free.  What's preventing somebody else from
>> allocating them and using them for something?  Is the guest semi-frozen
>> at this point with just enough of it running to ask the balloon driver
>> to do things?
> There's missing documentation here.
>
> The way things actually work is host sends to guest
> a request for unused pages and then write-protects all memory.
>
> So guest isn't frozen but any changes will be detected by host.
>

Probably it's better to say " transfer the info about the guest unused pages
to the host so that the host gets a chance to skip the transfer of the 
unused
pages during live migration".

Best,
Wei
