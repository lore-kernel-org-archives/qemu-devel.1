Received: from eggs.gnu.org ([209.51.188.92]:55839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn4dE-0006Yc-L3
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn4dD-0008CC-ME
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:47:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gn4dD-0008AX-FF
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:47:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id f7so11058952wrp.1
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 08:47:02 -0800 (PST)
References: <1548420960-5555-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <47446e41-5758-4ec3-34c3-fded0413e104@redhat.com>
Date: Fri, 25 Jan 2019 17:47:00 +0100
MIME-Version: 1.0
In-Reply-To: <1548420960-5555-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/virtio: Use CONFIG_VIRTIO_PCI switch
 instead of CONFIG_PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-s390x@nongnu.org, Miroslav Rezanina <mrezanin@redhat.com>

On 1/25/19 1:56 PM, Thomas Huth wrote:
> For downstream s390x builds, we'd like to be able to build QEMU with
> CONFIG_VIRTIO_PCI disabled (since virtio-ccw is used here instead),
> but still with CONFIG_PCI enabled. This currently fails since the
> virtio-*-pci.o files are still included in the build, but virtio-pci.o
> is missing. Use the right config switch CONFIG_VIRTIO_PCI to exclude
> the virtio-*-pci.o files from the build.
> 
> Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
> 
