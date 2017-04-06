Received: from eggs.gnu.org ([2001:4830:134:3::10]:35662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1cw938-0002I4-Gj
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1cw932-0005nh-8Y
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:10:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sahid.ferdjaoui@redhat.com>)
	id 1cw932-0005m2-0a
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:10:08 -0400
Date: Thu, 6 Apr 2017 17:10:04 +0200
From: Sahid Orentino Ferdjaoui <sferdjao@redhat.com>
Message-ID: <20170406151004.GA1618@redhat>
References: <1491434491-1765-1-git-send-email-anthony.xu@intel.com>
	<1491434491-1765-2-git-send-email-anthony.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491434491-1765-2-git-send-email-anthony.xu@intel.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] move xen-common.c to hw/xen/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Xu <anthony.xu@intel.com>
Cc: qemu-devel@nongnu.org, anthony.perard@citrix.com, pbonzini@redhat.com, sstabellini@kernel.org

On Wed, Apr 05, 2017 at 04:21:29PM -0700, Anthony Xu wrote:
> move xen-common.c to hw/xen/
> 
> Signed-off -by: Anthony Xu <anthony.xu@intel.com>

nit: s/Signed-off -by/Signed-off-by, not sure if it's really important
or not.

Reviewed-By: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>

> 
> ---
>  Makefile.target                         | 2 --
>  hw/xen/Makefile.objs                    | 2 +-
>  xen-common.c => hw/xen/xen-common.c     | 0
>  stubs/Makefile.objs                     | 1 +
>  xen-common-stub.c => stubs/xen-common.c | 0
>  5 files changed, 2 insertions(+), 3 deletions(-)
>  rename xen-common.c => hw/xen/xen-common.c (100%)
>  rename xen-common-stub.c => stubs/xen-common.c (100%)
>
> diff --git a/Makefile.target b/Makefile.target
> index 7df2b8c..48c027f 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -150,9 +150,7 @@ obj-y += migration/ram.o migration/savevm.o
>  LIBS := $(libs_softmmu) $(LIBS)
>  
>  # xen support
> -obj-$(CONFIG_XEN) += xen-common.o
>  obj-$(CONFIG_XEN_I386) += xen-hvm.o xen-mapcache.o
> -obj-$(call lnot,$(CONFIG_XEN)) += xen-common-stub.o
>  obj-$(call lnot,$(CONFIG_XEN_I386)) += xen-hvm-stub.o
>  
>  # Hardware support
> diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
> index 4be3ec9..64a70bc 100644
> --- a/hw/xen/Makefile.objs
> +++ b/hw/xen/Makefile.objs
> @@ -1,5 +1,5 @@
>  # xen backend driver support
> -common-obj-$(CONFIG_XEN) += xen_backend.o xen_devconfig.o xen_pvdev.o
> +common-obj-$(CONFIG_XEN) += xen_backend.o xen_devconfig.o xen_pvdev.o xen-common.o

Refers to the moved file /xen-common.c to /hw/xen/xen-common.c

>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
> diff --git a/xen-common.c b/hw/xen/xen-common.c
> similarity index 100%
> rename from xen-common.c
> rename to hw/xen/xen-common.c
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 224f04b..6c80613 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -37,3 +37,4 @@ stub-obj-y += target-monitor-defs.o
>  stub-obj-y += target-get-monitor-def.o
>  stub-obj-y += pc_madt_cpu_entry.o
>  stub-obj-y += vmgenid.o
> +stub-obj-y += xen-common.o

Refers to the moved file /xen-common-stub.c to /hw/xen/stubs/xen-common.c

> diff --git a/xen-common-stub.c b/stubs/xen-common.c
> similarity index 100%
> rename from xen-common-stub.c
> rename to stubs/xen-common.c
> -- 
> 1.8.3.1
> 
