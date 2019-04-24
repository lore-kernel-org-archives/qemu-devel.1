Received: from eggs.gnu.org ([209.51.188.92]:49601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJLCi-0004RJ-5g
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJL0y-0008Bq-32
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:44:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJL0x-0008Ah-TQ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:44:56 -0400
Date: Wed, 24 Apr 2019 13:44:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190424164447.GB18406@habkost.net>
References: <20190424152401.28304-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424152401.28304-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: clarify VirtioPCIDeviceTypeInfo
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, sebastien.boeuf@intel.com

On Wed, Apr 24, 2019 at 04:24:01PM +0100, Stefan Hajnoczi wrote:
> How to use .base_name, .generic_name, .transitional_name, and
> .non_transitional_name can be confusing.
> 
> Existing devices have .generic_name but its behavior is somewhat magic.
> 
> Devices added to new versions of the VIRTIO specification should forego
> transitional mode completely and always operate in non-transitional mode
> because there are no existing drivers for them that require backwards
> compatibility.
> 
> This patch adds comments that hopefully make it easier for developers to
> decide how to fill out VirtioPCIDeviceTypeInfo.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/virtio/virtio-pci.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 18581854ca..debdee28b3 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -209,7 +209,9 @@ typedef struct VirtioPCIDeviceTypeInfo {
>       * Implements both INTERFACE_PCIE_DEVICE and INTERFACE_CONVENTIONAL_PCI_DEVICE,
>       * but PCI Express is supported only in non-transitional mode.
>       *
> -     * The only type implemented by QEMU 3.1 and older.
> +     * The only type implemented by QEMU 3.1 and older.  This type is less
> +     * explicit than the transitional and non-transitional device types.  Its
> +     * behavior can be affected by machine type compat properties.

I'm not sure what you mean here.  All types can be affected by
machine type compat properties when necessary, don't they?

>       */
>      const char *generic_name;
>      /*
> @@ -222,6 +224,9 @@ typedef struct VirtioPCIDeviceTypeInfo {
>       * The non-transitional device type.  Optional.
>       *
>       * Implements INTERFACE_CONVENTIONAL_PCI_DEVICE only.
> +     *
> +     * New virtio device types should only define this and base_name, thereby
> +     * allowing only non-transitional mode.
>       */
>      const char *non_transitional_name;
>  
> -- 
> 2.20.1
> 

-- 
Eduardo
