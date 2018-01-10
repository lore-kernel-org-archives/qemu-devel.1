Received: from eggs.gnu.org ([2001:4830:134:3::10]:44020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eZDYq-0000WJ-CV
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eZDYl-0007Yp-A4
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:24:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:62337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eZDYl-0007Xd-0j
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:24:39 -0500
Message-ID: <5A55EA71.6020309@intel.com>
Date: Wed, 10 Jan 2018 18:26:57 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1515501687-7874-1-git-send-email-wei.w.wang@intel.com>
	<201801092342.FCH56215.LJHOMVFFFOOSQt@I-love.SAKURA.ne.jp>
In-Reply-To: <201801092342.FCH56215.LJHOMVFFFOOSQt@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v21 2/5 RESEND] virtio-balloon:
 VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On 01/09/2018 10:42 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> - enable OOM to free inflated pages maintained in the local temporary
>>    list.
> I do want to see it before applying this patch.


Fine, then what do you think of the method I shared in your post here: 
https://patchwork.kernel.org/patch/10140731/

Michael, could we merge patch 3-5 first?


>
> Please carefully check how the xbitmap implementation works, and you will
> find that you are adding a lot of redundant operations with a bug.

This version mainly added some test cases, and it passes the test run 
without any issue. Appreciate it if your comments could be more 
specific, that would make the discussion more effective, for example, I 
deliberately added "xb_find_set(xb1, 2, ULONG_MAX - 3)" for the overflow 
test, not sure if this is the "bug" you referred to, but I'm glad to 
hear your different thought.

I agree that some tests may be repeated in some degree, since we test 
the implementation from different aspects, for example, 
xbitmap_check_bit_range() may have already performed xb_zero() while we 
specifically have another xbitmap_check_zero_bits() which may test 
something that has already been tested when checking bit range. But I 
think testing twice is better than omission.
Also, I left the "Regualr test1: node=NULL" case though the new 
implementation doesn't explicitly use "node" as before, but that 
node=NULL is still a radix tree implementation internally and that case 
looks special to me, so maybe not bad to cover in the test.

You are also welcome to send a patch to remove the redundant one if you 
think that's an issue. Thanks.

Best,
Wei
