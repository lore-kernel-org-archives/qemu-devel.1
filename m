Received: from eggs.gnu.org ([2001:4830:134:3::10]:36183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elHn0-0000TK-Lc
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elHmx-000828-Mp
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:21:14 -0500
References: <151844508814.7999.5257918627784684957.stgit@bahia>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9ad4936c-e9b8-c55c-8aad-1f91e459528f@redhat.com>
Date: Mon, 12 Feb 2018 11:21:08 -0600
MIME-Version: 1.0
In-Reply-To: <151844508814.7999.5257918627784684957.stgit@bahia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: trivial fixes in error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On 02/12/2018 08:18 AM, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/virtio/virtio-pci.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c20537f31de7..ae3e8e1ca9b8 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1585,7 +1585,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
>       if (legacy) {
>           if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
>               error_setg(errp, "VIRTIO_F_IOMMU_PLATFORM was supported by"
> -                       "neither legacy nor transitional device.");
> +                       " neither legacy nor transitional device");

Reviewed-by: Eric Blake <eblake@redhat.com>

(fixing both the missing space and the unneeded trailing dot)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
