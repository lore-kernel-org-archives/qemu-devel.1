Received: from eggs.gnu.org ([2001:4830:134:3::10]:34292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAdrR-00042y-Fn
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAdrM-0005Jb-IN
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:58:37 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:30308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAdrM-0005Iw-86
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:58:32 -0400
Date: Mon, 23 Apr 2018 16:58:17 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180423155816.GF1980@perard>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-6-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1524156319-11465-6-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 05/16] xen: defer call to xen_restrict
 until just before os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Apr 19, 2018 at 05:45:08PM +0100, Ian Jackson wrote:
> diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
> index 0067bcc..7787ea2 100644
> --- a/stubs/xen-hvm.c
> +++ b/stubs/xen-hvm.c
> @@ -13,6 +13,7 @@
>  #include "hw/xen/xen.h"
>  #include "exec/memory.h"
>  #include "qapi/qapi-commands-misc.h"
> +#include "sysemu/sysemu.h"

I think this include is not needed anymore, and can go away from the
patch series.

>  
>  int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
>  {

-- 
Anthony PERARD
