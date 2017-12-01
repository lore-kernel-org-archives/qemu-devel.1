Received: from eggs.gnu.org ([2001:4830:134:3::10]:51888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eKnZj-0003On-3V
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eKnZ0-0003He-UD
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:50:03 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:33626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1eKnZ0-0002vR-II
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:49:18 -0500
Date: Fri, 1 Dec 2017 06:13:07 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20171201141307.GA4722@bombadil.infradead.org>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-6-git-send-email-wei.w.wang@intel.com>
	<201711301934.CDC21800.FSLtJFFOOVQHMO@I-love.SAKURA.ne.jp>
	<5A210C96.8050208@intel.com>
	<201712012202.BDE13557.MJFQLtOOHVOFSF@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201712012202.BDE13557.MJFQLtOOHVOFSF@I-love.SAKURA.ne.jp>
Subject: Re: [Qemu-devel] [PATCH v18 05/10] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

On Fri, Dec 01, 2017 at 10:02:01PM +0900, Tetsuo Handa wrote:
> If start == end is legal,
> 
>    for (; start < end; start = (start | (IDA_BITMAP_BITS - 1)) + 1) {
> 
> makes this loop do nothing because 10 < 10 is false.

... and this is why we add tests to the test-suite!
