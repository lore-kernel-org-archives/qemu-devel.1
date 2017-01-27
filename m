Received: from eggs.gnu.org ([2001:4830:134:3::10]:54291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cXG2Z-0000vX-4y
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 18:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cXG2W-0002Xw-1U
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 18:34:47 -0500
Received: from mail.kernel.org ([198.145.29.136]:51948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cXG2V-0002Xq-Rp
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 18:34:43 -0500
Date: Fri, 27 Jan 2017 15:34:39 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1485423445-12302-3-git-send-email-paul.durrant@citrix.com>
Message-ID: <alpine.DEB.2.10.1701271533580.2884@sstabellini-ThinkPad-X260>
References: <1485423445-12302-1-git-send-email-paul.durrant@citrix.com>
	<1485423445-12302-3-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v3 2/3] xen-platform: add support for
 unplugging NVMe disks...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 26 Jan 2017, Paul Durrant wrote:
> ...not just IDE and SCSI.
> 
> This patch allows the Xen tool-stack to fully support of NVMe as an
> emulated disk type. See [1] for the relevant tool-stack patch discussion.
> 
> [1] https://lists.xen.org/archives/html/xen-devel/2017-01/msg01225.html
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

I queued the whole series. FYI I am waiting for another patch to fix a
regression before sending a pull request.


> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> 
> v3:
> - Add reference to xen-devel patch discussion in commit message as
>   requested by Stefano.
> ---
>  hw/i386/xen/xen_platform.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
> index f50915f..7d41ebb 100644
> --- a/hw/i386/xen/xen_platform.c
> +++ b/hw/i386/xen/xen_platform.c
> @@ -120,6 +120,7 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, void *o)
>          break;
>  
>      case PCI_CLASS_STORAGE_SCSI:
> +    case PCI_CLASS_STORAGE_EXPRESS:
>          object_unparent(OBJECT(d));
>          break;
>  
> -- 
> 2.1.4
> 
