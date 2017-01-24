Received: from eggs.gnu.org ([2001:4830:134:3::10]:56853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cWApp-0000ZG-Pt
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 18:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cWApm-0001Fq-O0
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 18:49:09 -0500
Received: from mail.kernel.org ([198.145.29.136]:44774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cWApm-0001FW-Ii
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 18:49:06 -0500
Date: Tue, 24 Jan 2017 15:48:49 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1485266747-4694-3-git-send-email-paul.durrant@citrix.com>
Message-ID: <alpine.DEB.2.10.1701241520050.10192@sstabellini-ThinkPad-X260>
References: <1485266747-4694-1-git-send-email-paul.durrant@citrix.com>
	<1485266747-4694-3-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 2/3] xen-platform: add support for
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
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, olaf@aepfle.de

On Tue, 24 Jan 2017, Paul Durrant wrote:
> ...not just IDE and SCSI.
> 
> This patch allows the Xen tool-stack to fully support of NVMe as an
> emulated disk type.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Please update docs/misc/hvm-emulated-unplug.markdown in the Xen
repository first. It might be also worth clarifying that `1` actually
means all disks, not just IDE disks. Then, please add a reference to
that commit in the description of this patch.


> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
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
