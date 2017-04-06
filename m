Received: from eggs.gnu.org ([2001:4830:134:3::10]:58362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1cwDMD-0006JL-CJ
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 15:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1cwDM9-000074-DR
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 15:46:13 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:23551)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1cwDM9-00006e-4r
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 15:46:09 -0400
Date: Thu, 6 Apr 2017 22:45:54 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20170406194552.GB2170@yuval-lap>
References: <1490872341-9959-1-git-send-email-marcel@redhat.com>
	<20170330141314.GM20443@mtr-leonro.local>
	<5e952524-7c2d-b4da-4bd7-6437830a40d8@redhat.com>
	<f7f3fc0e-0a75-2fdc-b3c2-6c3d34ff2978@redhat.com>
	<20170403062314.GO20443@mtr-leonro.local>
	<aa400244-426a-ea62-0ccf-ac5adb76fdd1@redhat.com>
	<20170404173349.GY20443@mtr-leonro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170404173349.GY20443@mtr-leonro.local>
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
To: Leon Romanovsky <leon@kernel.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Doug Ledford <dledford@redhat.com>, qemu-devel@nongnu.org, linux-rdma@vger.kernel.org

On Tue, Apr 04, 2017 at 08:33:49PM +0300, Leon Romanovsky wrote:
> 
> I'm not going to repeat Jason's answer, I'm completely agree with him.
> 
> Just add my 2 cents. You didn't answer on my question about other possible
> implementations. It can be SoftRoCE loopback optimizations, special ULP,
> RDMA transport, virtual driver with multiple VFs and single PF.

Please see my response to Jason's comments - eventually, when a support for
VM to external host communication will be added - kdbr will become ULP as
well.

Marcel & Yuval

> 
> >
