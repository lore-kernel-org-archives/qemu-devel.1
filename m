Received: from eggs.gnu.org ([2001:4830:134:3::10]:38827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eQ9OG-0007ly-R0
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 05:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eQ9OC-0007xr-RL
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 05:08:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:2826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eQ9OC-0007to-Gj
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 05:08:16 -0500
Message-ID: <5A34F103.7070004@intel.com>
Date: Sat, 16 Dec 2017 18:10:11 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513079759-14169-2-git-send-email-wei.w.wang@intel.com>
	<201712151837.MQq7hdgk%fengguang.wu@intel.com>
	<20171215132405.GB10348@bombadil.infradead.org>
In-Reply-To: <20171215132405.GB10348@bombadil.infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v19 1/7] xbitmap: Introduce xbitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Wilcox <willy@infradead.org>, kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

On 12/15/2017 09:24 PM, Matthew Wilcox wrote:
> On Fri, Dec 15, 2017 at 07:05:07PM +0800, kbuild test robot wrote:
>>      21		struct radix_tree_node *node;
>>      22		void **slot;
>                               ^^^
> missing __rcu annotation here.
>
> Wei, could you fold that change into your next round?  Thanks!
>

Sure, I'll do. Thanks for your time on this patch series.

Best,
Wei
