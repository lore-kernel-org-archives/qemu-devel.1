Received: from eggs.gnu.org ([2001:4830:134:3::10]:49373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fINi6-0002Y6-9A
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fINi1-0008Uu-AI
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:20:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50152
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fINi1-0008UD-3m
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:20:53 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4F0IsBd019644
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 20:20:52 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hyh2ag0ag-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 20:20:51 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Mon, 14 May 2018 18:20:51 -0600
Date: Mon, 14 May 2018 21:20:43 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20180514100023.12542-1-david@redhat.com>
	<20180514100023.12542-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514100023.12542-3-david@redhat.com>
Message-Id: <20180515002043.GC12837@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 02/18] memory-device:
 introduce separate config option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Mon, May 14, 2018 at 12:00:07PM +0200, David Hildenbrand wrote:
> Some architectures might support memory devices, while they don't
> support DIMM/NVDIMM. So let's
> - Rename CONFIG_MEM_HOTPLUG to CONFIG_MEM_DEVICE
> - Intriduce CONFIG_DIMM and use it similarly to CONFIG NVDIMM

Since you're resending it:

s/Intriduce/Introduce

> 
> CONFIG_DIMM and CONFIG_NVDIMM require CONFIG_MEM_DEVICE.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  default-configs/i386-softmmu.mak   | 3 ++-
>  default-configs/ppc64-softmmu.mak  | 3 ++-
>  default-configs/x86_64-softmmu.mak | 3 ++-
>  hw/Makefile.objs                   | 2 +-
>  hw/mem/Makefile.objs               | 4 ++--
>  qapi/misc.json                     | 2 +-
>  6 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index 8c7d4a0fa0..4c1637338b 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -50,7 +50,8 @@ CONFIG_PCI_Q35=y
>  CONFIG_APIC=y
>  CONFIG_IOAPIC=y
>  CONFIG_PVPANIC=y
> -CONFIG_MEM_HOTPLUG=y
> +CONFIG_MEM_DEVICE=y
> +CONFIG_DIMM=y
>  CONFIG_NVDIMM=y
>  CONFIG_ACPI_NVDIMM=y
>  CONFIG_PCIE_PORT=y
> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
> index b94af6c7c6..f550573782 100644
> --- a/default-configs/ppc64-softmmu.mak
> +++ b/default-configs/ppc64-softmmu.mak
> @@ -16,4 +16,5 @@ CONFIG_VIRTIO_VGA=y
>  CONFIG_XICS=$(CONFIG_PSERIES)
>  CONFIG_XICS_SPAPR=$(CONFIG_PSERIES)
>  CONFIG_XICS_KVM=$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
> -CONFIG_MEM_HOTPLUG=y
> +CONFIG_MEM_DEVICE=y
> +CONFIG_DIMM=y
> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
> index 0390b4303c..7785351414 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -50,7 +50,8 @@ CONFIG_PCI_Q35=y
>  CONFIG_APIC=y
>  CONFIG_IOAPIC=y
>  CONFIG_PVPANIC=y
> -CONFIG_MEM_HOTPLUG=y
> +CONFIG_MEM_DEVICE=y
> +CONFIG_DIMM=y
>  CONFIG_NVDIMM=y
>  CONFIG_ACPI_NVDIMM=y
>  CONFIG_PCIE_PORT=y
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index 6a0ffe0afd..127a60eca4 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -33,7 +33,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += vfio/
>  devices-dirs-$(CONFIG_SOFTMMU) += virtio/
>  devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
>  devices-dirs-$(CONFIG_SOFTMMU) += xen/
> -devices-dirs-$(CONFIG_MEM_HOTPLUG) += mem/
> +devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
>  devices-dirs-$(CONFIG_SOFTMMU) += smbios/
>  devices-dirs-y += core/
>  common-obj-y += $(devices-dirs-y)
> diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
> index 10be4df2a2..3e2f7c5ca2 100644
> --- a/hw/mem/Makefile.objs
> +++ b/hw/mem/Makefile.objs
> @@ -1,3 +1,3 @@
> -common-obj-$(CONFIG_MEM_HOTPLUG) += pc-dimm.o
> -common-obj-$(CONFIG_MEM_HOTPLUG) += memory-device.o
> +common-obj-$(CONFIG_DIMM) += pc-dimm.o
> +common-obj-$(CONFIG_MEM_DEVICE) += memory-device.o
>  common-obj-$(CONFIG_NVDIMM) += nvdimm.o
> diff --git a/qapi/misc.json b/qapi/misc.json
> index f5988cc0b5..65eae0c8a0 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2060,7 +2060,7 @@
>  #
>  # @plugged-memory: size of memory that can be hot-unplugged. This field
>  #                  is omitted if target doesn't support memory hotplug
> -#                  (i.e. CONFIG_MEM_HOTPLUG not defined on build time).
> +#                  (i.e. CONFIG_MEM_DEVICE not defined on build time).
>  #
>  # Since: 2.11.0
>  ##
> -- 
> 2.14.3
> 
> 

-- 
Murilo
