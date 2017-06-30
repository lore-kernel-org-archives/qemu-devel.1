Received: from eggs.gnu.org ([2001:4830:134:3::10]:54605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=347e3a6fc=anthony.perard@citrix.com>)
	id 1dQyEL-0007WC-Ot
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 11:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=347e3a6fc=anthony.perard@citrix.com>)
	id 1dQyEI-0003qT-NF
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 11:53:13 -0400
Received: from smtp.citrix.com ([66.165.176.89]:36228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=347e3a6fc=anthony.perard@citrix.com>)
	id 1dQyEI-0003pW-F7
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 11:53:10 -0400
Date: Fri, 30 Jun 2017 16:52:25 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170630155225.GG1598@perard.uk.xensource.com>
References: <1498715394-16402-1-git-send-email-tianyu.lan@intel.com>
	<1498715394-16402-4-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1498715394-16402-4-git-send-email-tianyu.lan@intel.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] msi: Handle remappable format
 interrupt request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xensource.com, Chao Gao <chao.gao@intel.com>, mst@redhat.com, marcel@redhat.com, sstabellini@kernel.org, kevin.tian@intel.com

On Thu, Jun 29, 2017 at 01:49:54AM -0400, Lan Tianyu wrote:
> From: Chao Gao <chao.gao@intel.com>
> 
> According to VT-d spec Interrupt Remapping and Interrupt Posting ->
> Interrupt Remapping -> Interrupt Request Formats On Intel 64
> Platforms, fields of MSI data register have changed. This patch
> avoids wrongly regarding a remappable format interrupt request as
> an interrupt binded with an event channel.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

The patch needs to be rebased on top of QEMU upstream.

Beside that:
Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
