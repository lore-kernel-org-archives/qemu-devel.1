Received: from eggs.gnu.org ([209.51.188.92]:48936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gp7sO-0006EZ-Ko
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gp7sN-0002qx-Re
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:39:12 -0500
References: <20190131073234.18037-1-yang.zhong@intel.com>
	<20190131073234.18037-14-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7d6919f6-5f99-551b-aafa-e1aabf5303a6@redhat.com>
Date: Thu, 31 Jan 2019 09:39:08 +0100
MIME-Version: 1.0
In-Reply-To: <20190131073234.18037-14-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 13/27] hw/s390/Makefile.objs: Create new
 CONFIG_* variables for s390x boards and devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-s390x@nongnu.org

On 2019-01-31 08:32, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Make hw/s390x configurable and add new CONFIG_* to the
> default-configs/s390x*-softmmu.mak. This will be used to
> enable/disable vfio-ccw.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/s390x-softmmu.mak | 1 +
>  hw/s390x/Makefile.objs            | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
> index 5eef375924..8bb7e438c8 100644
> --- a/default-configs/s390x-softmmu.mak
> +++ b/default-configs/s390x-softmmu.mak
> @@ -8,3 +8,4 @@ CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
>  CONFIG_VFIO_CCW=$(CONFIG_LINUX)
>  CONFIG_WDT_DIAG288=y
>  CONFIG_VFIO_AP=$(CONFIG_LINUX)
> +CONFIG_S390_CCW_VIRTIO=y
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index ca68806e44..a18c471913 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -5,7 +5,7 @@ obj-y += sclpquiesce.o
>  obj-y += sclpcpu.o
>  obj-y += ipl.o
>  obj-y += css.o
> -obj-y += s390-virtio-ccw.o
> +obj-$(CONFIG_S390_CCW_VIRTIO) += s390-virtio-ccw.o
>  obj-y += 3270-ccw.o
>  obj-y += virtio-ccw.o
>  obj-$(CONFIG_VIRTIO_SERIAL) += virtio-ccw-serial.o
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
