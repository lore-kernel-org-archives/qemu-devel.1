Received: from eggs.gnu.org ([2001:4830:134:3::10]:36878)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <hch@lst.de>)
	id 1djmPv-0001ma-VW
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hch@lst.de>) id 1djmPv-0003ez-Bc
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:06:56 -0400
Date: Mon, 21 Aug 2017 15:06:45 +0200
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20170821130645.GA16745@lst.de>
References: <20170606073806.8180-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606073806.8180-1-quwenruo@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] nvme: Update header to include
	SGL	related macros and members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, keith.busch@intel.com

On Tue, Jun 06, 2017 at 03:38:05PM +0800, Qu Wenruo wrote:
> Update nvme header to catch up with kernel.
> Most of the newly added members are from 1.2 and 1.3 spec, while the
> status code is only kept the same with kernel (around 1.1 spec).
> 
> The major update is to add Scatter Gather List related macros and
> members, for later SGL support implementation.

The keyed sgls are only for nvme over fabrics (aka network) controllers,
and make no sense here.

Looks like this was copy & pasted a little to eager from the kernel
driver :)
