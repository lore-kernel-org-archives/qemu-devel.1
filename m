Received: from eggs.gnu.org ([2001:4830:134:3::10]:38637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cHZ3G-00008Z-Gi
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cHZ3F-0002Zx-JF
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:38:38 -0500
Date: Thu, 15 Dec 2016 18:38:30 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20161215183759-mutt-send-email-mst@kernel.org>
References: <20161213214522.25548-1-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161213214522.25548-1-drjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/11] Remove VirtGuestInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, zhaoshenglong@huawei.com, imammedo@redhat.com, ehabkost@redhat.com

On Tue, Dec 13, 2016 at 10:45:11PM +0100, Andrew Jones wrote:
> This series is based on Peter's qemu-arm gicv3-virt branch. It's
> main goal (patches 04-10), which was suggested by Eduardo, is to
> remove an unnecessary structure, VirtGuestInfo, which is a
> maintenance burden, as it requires duplicating Virt machine state.
> Additionally patches 01-03 do some mach-virt cleanups and patch 11
> adds the ACPI equivalent to one of the DT patches in Peter's
> gicv3-virt branch.
> 
> The last patch isn't really tested as the guest kernel versions I
> used seem to ignore the GTDT irqflags and either just choose edge,
> 4.5-based kernel, or level, 4.9-based kernel.
> 
> Patches available here
> https://github.com/rhdrjones/qemu/commits/virt/remove-guest-info

I like this in general.
Acked-by: Michael S. Tsirkin <mst@redhat.com>

Pls merge through the ARM tree.

> 
> Andrew Jones (11):
>   hw/arm/virt: parameter passing cleanups
>   hw/arm/virt: use VirtMachineState.gic_version
>   hw/arm/virt: use VirtMachineState.smp_cpus
>   hw/arm/virt: eliminate struct VirtGuestInfoState
>   hw/arm/virt: remove include/hw/arm/virt-acpi-build.h
>   hw/arm/virt: move VirtMachineState/Class to virt.h
>   hw/arm/virt: pass VirtMachineState instead of VirtGuestInfo
>   hw/arm/virt-acpi-build: remove redundant members from VirtGuestInfo
>   hw/arm/virt-acpi-build: don't save VirtGuestInfo on AcpiBuildState
>   hw/arm/virt: remove VirtGuestInfo
>   hw/arm/virt-acpi-build: Don't incorrectly claim architectural timer to
>     be edge-triggered
> 
>  MAINTAINERS                      |   2 -
>  hw/arm/virt-acpi-build.c         | 103 +++++++++++++-------------
>  hw/arm/virt.c                    | 152 ++++++++++++++-------------------------
>  include/hw/arm/virt-acpi-build.h |  47 ------------
>  include/hw/arm/virt.h            |  45 +++++++++++-
>  5 files changed, 151 insertions(+), 198 deletions(-)
>  delete mode 100644 include/hw/arm/virt-acpi-build.h
> 
> -- 
> 2.9.3
