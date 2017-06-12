Received: from eggs.gnu.org ([2001:4830:134:3::10]:42056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1dKPqk-0007Vy-W0
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1dKPqg-00024b-5u
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:57:47 -0400
Date: Mon, 12 Jun 2017 10:05:31 -0400
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20170612140530.GA23969@localhost.localdomain>
References: <b3375e1d-a304-237c-124c-21b7f482b6ab@cn.fujitsu.com>
	<20170602135151.GB4948@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170602135151.GB4948@noname.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] NVME: is there any plan to support
 SGL data transfer?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qu Wenruo <quwenruo@cn.fujitsu.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, Jun 02, 2017 at 03:51:51PM +0200, Kevin Wolf wrote:
> Am 02.06.2017 um 03:47 hat Qu Wenruo geschrieben:
> > When going through NVMe specification and hw/block/nvme.c,
> > I found that it seems that NVMe qemu implementation only support PRP
> > for sq entry.
> > And NvmeRwCmd doesn't even use union to define DPTR, but just prp1 and prp2.
> > 
> > Although I am just a newbie, but I'm quite interested in NVMe and
> > want to try to implement SGL support for qemu NVMe.
> > 
> > Is there anyone already doing such work? Or is there any plan on
> > implement such feature?
> 
> Keith, you can probably answer this?

Hi,

I personally have no plans to implement it, but would be happy to see it
added if someone wants to send the patch for review.

Thanks,
Keith
