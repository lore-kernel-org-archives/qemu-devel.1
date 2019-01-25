Received: from eggs.gnu.org ([209.51.188.92]:35899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn37B-0003Ng-3a
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn32F-0002fb-NA
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:04:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gn32D-0002Y8-PV
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:04:47 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-4-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7c25e629-2f48-7386-f50b-3bd9777aa111@redhat.com>
Date: Fri, 25 Jan 2019 16:04:15 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-4-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/52] vfio: move conditional up to
 hw/Makefile.objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, Alex Williamson <alex.williamson@redhat.com>

On 2019-01-25 11:06, Paolo Bonzini wrote:
> Instead of wrapping the entire Makefile.objs with an ifeq/endif, just
> include the directory only for Linux.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/Makefile.objs      | 2 +-
>  hw/vfio/Makefile.objs | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index 39d882a..22dd211 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -30,7 +30,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += ssi/
>  devices-dirs-$(CONFIG_SOFTMMU) += timer/
>  devices-dirs-$(CONFIG_TPM) += tpm/
>  devices-dirs-$(CONFIG_SOFTMMU) += usb/
> -devices-dirs-$(CONFIG_SOFTMMU) += vfio/
> +devices-dirs-$(CONFIG_LINUX) += vfio/
>  devices-dirs-$(CONFIG_SOFTMMU) += virtio/
>  devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
>  devices-dirs-$(CONFIG_SOFTMMU) += xen/
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> index 8b3f664..9180589 100644
> --- a/hw/vfio/Makefile.objs
> +++ b/hw/vfio/Makefile.objs
> @@ -1,4 +1,3 @@
> -ifeq ($(CONFIG_LINUX), y)
>  obj-$(CONFIG_SOFTMMU) += common.o
>  obj-$(CONFIG_PCI) += pci.o pci-quirks.o display.o
>  obj-$(CONFIG_VFIO_CCW) += ccw.o
> @@ -7,4 +6,3 @@ obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
>  obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
>  obj-$(CONFIG_SOFTMMU) += spapr.o
>  obj-$(CONFIG_VFIO_AP) += ap.o
> -endif
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
