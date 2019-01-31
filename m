Received: from eggs.gnu.org ([209.51.188.92]:57212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpEuz-0000Hs-8D
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpEuq-0002PB-PN
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:10:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gpEuo-0002Ib-M9
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:10:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DE8E7AE99
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 16:10:06 +0000 (UTC)
References: <1548946740-28714-1-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b63a1205-e71b-d90a-f7c5-78dac7bd32b1@redhat.com>
Date: Thu, 31 Jan 2019 17:10:03 +0100
MIME-Version: 1.0
In-Reply-To: <1548946740-28714-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio: PCI proxy devices should depend on
 CONFIG_VIRTIO_PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 2019-01-31 15:59, Paolo Bonzini wrote:
> ... otherwise, they break the build in the rare case where
> CONFIG_VIRTIO_PCI is disabled (which will not be so rare
> once kconfig goes in).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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

Miroslav hit this already, too:

https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06552.html

 Thomas
