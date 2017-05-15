Received: from eggs.gnu.org ([2001:4830:134:3::10]:54612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAGiY-0000pF-7Z
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAGiX-0006YD-8Z
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:11:22 -0400
Date: Mon, 15 May 2017 22:11:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170515141112.GA17921@lemon.lan>
References: <20170515105032.GD23262@lemon.lan>
	<26b2441d-e80c-eeef-fba1-67b2529e9287@kamp.de>
	<20170515115318.GA7305@lemon.lan>
	<243331f2-3822-3c0e-b4a5-9f3de2302fe4@kamp.de>
	<20170515122802.GB7305@lemon.lan>
	<b850c6d3-c104-b171-0e7d-40ebf6780d6e@kamp.de>
	<20170515125202.GC7305@lemon.lan>
	<0e904501-91c6-7186-f5e6-8c2b60bda8cf@kamp.de>
	<20170515133515.GD7305@lemon.lan>
	<498e1918-4e53-02b9-1528-5220d3b9cca8@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <498e1918-4e53-02b9-1528-5220d3b9cca8@kamp.de>
Subject: Re: [Qemu-devel] [RFC PATCH] qemu-io: add drain/undrain cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com

On Mon, 05/15 16:02, Peter Lieven wrote:
> > > do you have a pointer to the image locking mechanism?
> > It hit qemu.git master just a moment ago. See raw_check_perm.
> 
> which master are you looking at?
> 
> $ git fetch upstream
> $ git log upstream/master --oneline
> 3a87606 Merge tag 'tracing-pull-request' into staging
> b54933e Merge tag 'block-pull-request' into staging
> 3753e25 Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging
> 5651743 trace: add sanity check
> 321d1db aio: add missing aio_notify() to aio_enable_external()
> ee29d6a block: Simplify BDRV_BLOCK_RAW recursion
> 33c53c5 coroutine: remove GThread implementation
> ecc1f5a maintainers: Add myself as linux-user reviewer
> d541e20 Merge remote-tracking branch 'mreitz/tags/pull-block-2017-05-11' into queue-block
> 8dd30c8 MAINTAINERS: Add qemu-progress to the block layer
> d2cb36a qcow2: Discard/zero clusters by byte count
> f10ee13 qcow2: Assert that cluster operations are aligned
> fbaa6bb qcow2: Optimize write zero of unaligned tail cluster
> e249d51 iotests: Add test 179 to cover write zeroes with unmap
> d9ca221 iotests: Improve _filter_qemu_img_map
> 06cc5e2 qcow2: Optimize zero_single_l2() to minimize L2 churn
> fdfab37 qcow2: Make distinction between zero cluster types obvious
> 3ef9521 qcow2: Name typedef for cluster type
> 4341df8 qcow2: Correctly report status of preallocated zero clusters
> 4c41cb4 block: Update comments on BDRV_BLOCK_* meanings

It's 244a5668 "file-posix: Add image locking to perm operations".

Fam
