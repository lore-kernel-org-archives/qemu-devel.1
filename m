Received: from eggs.gnu.org ([2001:4830:134:3::10]:52260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dXk6i-0002T9-V1
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dXk6f-0004Nl-Mw
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:13:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:38962 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhocko@kernel.org>) id 1dXk6f-0004MA-Fs
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:13:17 -0400
Date: Wed, 19 Jul 2017 10:13:12 +0200
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20170719081311.GC26779@dhcp22.suse.cz>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-7-git-send-email-wei.w.wang@intel.com>
	<20170714123023.GA2624@dhcp22.suse.cz>
	<20170714181523-mutt-send-email-mst@kernel.org>
	<20170717152448.GN12888@dhcp22.suse.cz>
	<596D6E7E.4070700@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <596D6E7E.4070700@intel.com>
Subject: Re: [Qemu-devel] [PATCH v12 6/8] mm: support reporting free page
 blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Tue 18-07-17 10:12:14, Wei Wang wrote:
[...]
> Probably I should have included the introduction of the usages in
> the log. Hope it is not too later to explain here:

Yes this should have been described in the cover.
 
> Live migration needs to transfer the VM's memory from the source
> machine to the destination round by round. For the 1st round, all the VM's
> memory is transferred. From the 2nd round, only the pieces of memory
> that were written by the guest (after the 1st round) are transferred. One
> method that is popularly used by the hypervisor to track which part of
> memory is written is to write-protect all the guest memory.
> 
> This patch enables the optimization of the 1st round memory transfer -
> the hypervisor can skip the transfer of guest unused pages in the 1st round.

All you should need is the check for the page reference count, no?  I
assume you do some sort of pfn walk and so you should be able to get an
access to the struct page.
-- 
Michal Hocko
SUSE Labs
