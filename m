Received: from eggs.gnu.org ([2001:4830:134:3::10]:40268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3891006ae=anthony.perard@citrix.com>)
	id 1dgEJ9-0000ya-Rw
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3891006ae=anthony.perard@citrix.com>)
	id 1dgEJ5-0006DJ-IX
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:05:14 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:19813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3891006ae=anthony.perard@citrix.com>)
	id 1dgEJ5-0006Cr-CE
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:05:11 -0400
Date: Fri, 11 Aug 2017 19:04:38 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170811180438.GI1519@perard.uk.xensource.com>
References: <1502311882-11038-1-git-send-email-tianyu.lan@intel.com>
	<1502311882-11038-3-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1502311882-11038-3-git-send-email-tianyu.lan@intel.com>
Subject: Re: [Qemu-devel] [PATCH V2 2/3] xen-pt: bind/unbind interrupt
 remapping format MSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Chao Gao <chao.gao@intel.com>, sstabellini@kernel.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, marcel@redhat.com, kevin.tian@intel.com

On Wed, Aug 09, 2017 at 04:51:21PM -0400, Lan Tianyu wrote:
> From: Chao Gao <chao.gao@intel.com>
> 
> If a vIOMMU is exposed to guest, guest will configure the msi to remapping
> format. The original code isn't suitable to the new format. A new pair
> bind/unbind interfaces are added for this usage. This patch recognizes
> this case and uses new interfaces to bind/unbind msi.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

That patch series can be applied once the Xen side patches are merged.

Thanks,

-- 
Anthony PERARD
