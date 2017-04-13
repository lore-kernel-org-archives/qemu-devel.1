Received: from eggs.gnu.org ([2001:4830:134:3::10]:59378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cycZy-0005mC-8c
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 07:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cycZv-0000h9-4M
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 07:06:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:22970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cycZu-0000gA-Qs
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 07:06:19 -0400
Message-ID: <58EF5C0D.60603@intel.com>
Date: Thu, 13 Apr 2017 19:07:57 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1489648127-37282-1-git-send-email-wei.w.wang@intel.com>	<1489648127-37282-4-git-send-email-wei.w.wang@intel.com>
	<20170316142842.69770813b98df70277431b1e@linux-foundation.org>
In-Reply-To: <20170316142842.69770813b98df70277431b1e@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH kernel v8 3/4] mm: add inerface to offer
 info about unused pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On 03/17/2017 05:28 AM, Andrew Morton wrote:
> On Thu, 16 Mar 2017 15:08:46 +0800 Wei Wang <wei.w.wang@intel.com> wrote:
>
>> From: Liang Li <liang.z.li@intel.com>
>>
>> This patch adds a function to provides a snapshot of the present system
>> unused pages. An important usage of this function is to provide the
>> unsused pages to the Live migration thread, which skips the transfer of
>> thoses unused pages. Newly used pages can be re-tracked by the dirty
>> page logging mechanisms.
> I don't think this will be useful for anything other than
> virtio-balloon.  I guess it would be better to keep this code in the
> virtio-balloon driver if possible, even though that's rather a layering
> violation :( What would have to be done to make that possible?  Perhaps
> we can put some *small* helpers into page_alloc.c to prevent things
> from becoming too ugly.
>
>
Thanks for the suggestion. Small helpers do look more elegant. The nice 
thing is that I also didn't see any performance loss.
To make that possible, we need to enable for_each_polulated_zone() to be 
callable by a kernel module. Please have a check the v9 patches that I 
just posted out.

Best,
Wei
