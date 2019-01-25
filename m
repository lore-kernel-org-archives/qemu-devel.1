Received: from eggs.gnu.org ([209.51.188.92]:50973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gn1wT-00084p-Ah
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gn1wR-0005rv-9F
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:54:44 -0500
Date: Fri, 25 Jan 2019 14:54:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190125145414.2a92177b.cohuck@redhat.com>
In-Reply-To: <1548420960-5555-1-git-send-email-thuth@redhat.com>
References: <1548420960-5555-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] hw/virtio: Use
 CONFIG_VIRTIO_PCI switch instead of CONFIG_PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-s390x@nongnu.org, Miroslav Rezanina <mrezanin@redhat.com>

On Fri, 25 Jan 2019 13:56:00 +0100
Thomas Huth <thuth@redhat.com> wrote:

> For downstream s390x builds, we'd like to be able to build QEMU with
> CONFIG_VIRTIO_PCI disabled (since virtio-ccw is used here instead),
> but still with CONFIG_PCI enabled. This currently fails since the
> virtio-*-pci.o files are still included in the build, but virtio-pci.o
> is missing. Use the right config switch CONFIG_VIRTIO_PCI to exclude
> the virtio-*-pci.o files from the build.
> 
> Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/virtio/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index ea7913d..d335dd0 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -11,7 +11,7 @@ obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-p
>  
>  obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
> -ifeq ($(CONFIG_PCI),y)
> +ifeq ($(CONFIG_VIRTIO_PCI),y)
>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
>  obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk-pci.o
>  obj-$(CONFIG_VHOST_USER_SCSI) += vhost-user-scsi-pci.o

CONFIG_VIRTIO_PCI looks like the right knob.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
