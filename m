Received: from eggs.gnu.org ([2001:4830:134:3::10]:36476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.guo.simon@gmail.com>) id 1esnt6-0002Qe-26
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:02:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.guo.simon@gmail.com>) id 1esnt3-0004Mn-0M
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:02:36 -0500
Date: Mon, 5 Mar 2018 19:02:18 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
Message-ID: <20180305110056.GA2466@simonLocalRHEL7.x64>
References: <1519782697-13100-1-git-send-email-wei.guo.simon@gmail.com>
	<20180305062233.GL2650@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305062233.GL2650@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH] PowerPC: Add TM bits into msr_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

Hi David,
On Mon, Mar 05, 2018 at 05:22:33PM +1100, David Gibson wrote:
> On Wed, Feb 28, 2018 at 09:51:37AM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > During migration, cpu_post_load() will use msr_mask to determine which
> > PPC MSR bits will be sync to the target side. Hardware Transaction
> > Memory(HTM) has been supported since Power8. This patch adds TM/TS bits
> > into msr_mask for Power8, so that transactional application can be
> > migrated across qemu.
> > 
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> 
> Sorry I've taken a while to respond to this.
> 
> This addresses a real bug, but doesn't get the details quite right.
> 
> First, the MSR_TM bit is *already* included in the msr_mask for POWER8
> (it's a little above the context for this patch), though TS0 and TS1
> were not.
> 
> Second, all MSR bits are sent to the far side, it's just that without
> them in the MSR mask they'll be dropped instead of re-inserted into
> KVM.  That's the only reason the msr_mask is relevant to KVM (and TCG
> doesn't support HTM anyway).  The commit message needs to make that clearer.
> 

Thanks for the comments. I have sent v2 to correct the above.

Regards,
- Simon
