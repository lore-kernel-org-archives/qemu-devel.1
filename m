Received: from eggs.gnu.org ([2001:4830:134:3::10]:56553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eLJTq-0007sW-LK
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 20:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eLJTl-0000ca-Qx
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 20:54:06 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:13212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eLJTl-0000av-Ae
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 20:54:01 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <201711301934.CDC21800.FSLtJFFOOVQHMO@I-love.SAKURA.ne.jp>
	<5A210C96.8050208@intel.com>
	<201712012202.BDE13557.MJFQLtOOHVOFSF@I-love.SAKURA.ne.jp>
	<286AC319A985734F985F78AFA26841F739376DA1@shsmsx102.ccr.corp.intel.com>
	<20171201172519.GA27192@bombadil.infradead.org>
In-Reply-To: <20171201172519.GA27192@bombadil.infradead.org>
Message-Id: <201712031050.IAC64520.QVLFFOOJOSFtHM@I-love.SAKURA.ne.jp>
Date: Sun, 3 Dec 2017 10:50:42 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v18 05/10] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: willy@infradead.org, wei.w.wang@intel.com
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

Matthew Wilcox wrote:
> On Fri, Dec 01, 2017 at 03:09:08PM +0000, Wang, Wei W wrote:
> > On Friday, December 1, 2017 9:02 PM, Tetsuo Handa wrote:
> > > If start == end is legal,
> > > 
> > >    for (; start < end; start = (start | (IDA_BITMAP_BITS - 1)) + 1) {
> > > 
> > > makes this loop do nothing because 10 < 10 is false.
> > 
> > How about "start <= end "?
> 
> Don't ask Tetsuo for his opinion, write some userspace code that uses it.
> 

Please be sure to prepare for "end == -1UL" case, for "start < end" will become
true when "start = (start | (IDA_BITMAP_BITS - 1)) + 1" made "start == 0" due to
overflow.
