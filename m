Received: from eggs.gnu.org ([2001:4830:134:3::10]:47912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgunthorpe@obsidianresearch.com>) id 1cwEQE-0001vx-KN
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 16:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgunthorpe@obsidianresearch.com>) id 1cwEQ9-000806-QN
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 16:54:26 -0400
Received: from quartz.orcorp.ca ([184.70.90.242]:47873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jgunthorpe@obsidianresearch.com>)
	id 1cwEQ9-0007zK-H3
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 16:54:21 -0400
Date: Thu, 6 Apr 2017 14:54:16 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Message-ID: <20170406205416.GB27155@obsidianresearch.com>
References: <1490872341-9959-1-git-send-email-marcel@redhat.com>
	<20170330141314.GM20443@mtr-leonro.local>
	<5e952524-7c2d-b4da-4bd7-6437830a40d8@redhat.com>
	<f7f3fc0e-0a75-2fdc-b3c2-6c3d34ff2978@redhat.com>
	<20170403062314.GO20443@mtr-leonro.local>
	<aa400244-426a-ea62-0ccf-ac5adb76fdd1@redhat.com>
	<20170404173349.GY20443@mtr-leonro.local>
	<20170406194552.GB2170@yuval-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406194552.GB2170@yuval-lap>
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pvrdma: Proposal of a new pvrdma
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Leon Romanovsky <leon@kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Doug Ledford <dledford@redhat.com>, qemu-devel@nongnu.org, linux-rdma@vger.kernel.org

On Thu, Apr 06, 2017 at 10:45:54PM +0300, Yuval Shaia wrote:

> > Just add my 2 cents. You didn't answer on my question about other possible
> > implementations. It can be SoftRoCE loopback optimizations, special ULP,
> > RDMA transport, virtual driver with multiple VFs and single PF.
> 
> Please see my response to Jason's comments - eventually, when a support for
> VM to external host communication will be added - kdbr will become ULP as
> well.

So, is KDBR only to be used on the HV side? Ie it never shows up in the VM?

That is even weirder, we certainly do not want to see a kernel RDMA
ULP for any of this - the entire point of RDMA is to let user space
implement their protocols without needing a unique kernel component!!

Jason
