Received: from eggs.gnu.org ([2001:4830:134:3::10]:39712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1ePpyg-0001z7-IW
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:24:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1ePpyc-0006Wc-L7
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:24:38 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:37846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1ePpyc-0006M0-C8
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:24:34 -0500
Date: Fri, 15 Dec 2017 05:24:05 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20171215132405.GB10348@bombadil.infradead.org>
References: <1513079759-14169-2-git-send-email-wei.w.wang@intel.com>
	<201712151837.MQq7hdgk%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201712151837.MQq7hdgk%fengguang.wu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v19 1/7] xbitmap: Introduce xbitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kbuild test robot <lkp@intel.com>
Cc: Wei Wang <wei.w.wang@intel.com>, kbuild-all@01.org, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

On Fri, Dec 15, 2017 at 07:05:07PM +0800, kbuild test robot wrote:
>     21		struct radix_tree_node *node;
>     22		void **slot;
                             ^^^
missing __rcu annotation here.

Wei, could you fold that change into your next round?  Thanks!
