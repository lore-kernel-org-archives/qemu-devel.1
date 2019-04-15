Received: from eggs.gnu.org ([209.51.188.92]:52978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG2TB-0006S7-1o
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG2TA-0005Is-4u
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:20:25 -0400
Date: Mon, 15 Apr 2019 16:20:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190415162005.1ff9ca3b@Igors-MacBook-Pro.local>
In-Reply-To: <20190415070307.13668-1-richardw.yang@linux.intel.com>
References: <20190415070307.13668-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Extract build_mcfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com, shannon.zhaosl@gmail.com, peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, yang.zhong@intel.com

On Mon, 15 Apr 2019 15:03:03 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> This patch set tries to generalize MCFG table build process.

1.
series should reference not merged  dependency if any exists.
in this case "[PATCH for-4.1] q35: acpi: do not create dummy MCFG table"
or as alternative include and repost that patch as part of the series.

if you'd do the later then add your SoB last when you are reposting it.

2. series is not finished without converting build_mcfg() to
   build_append_int_noprefix() API


> Wei Yang (4):
>   hw/arm/virt-acpi-build: remove unnecessary variable mcfg_start
>   i386, acpi: remove mcfg_ prefix in AcpiMcfgInfo members
>   hw/arm/virt-acpi-build: pass AcpiMcfgInfo to build_mcfg()
>   hw/acpi: Extract build_mcfg to pci.c
> 
>  default-configs/arm-softmmu.mak  |  1 +
>  default-configs/i386-softmmu.mak |  1 +
>  hw/acpi/Kconfig                  |  4 +++
>  hw/acpi/Makefile.objs            |  1 +
>  hw/acpi/pci.c                    | 46 ++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c         | 31 ++++++---------------
>  hw/i386/acpi-build.c             | 30 ++++-----------------
>  include/hw/acpi/aml-build.h      |  5 ++++
>  include/hw/acpi/pci.h            |  5 ++++
>  9 files changed, 76 insertions(+), 48 deletions(-)
>  create mode 100644 hw/acpi/pci.c
>  create mode 100644 include/hw/acpi/pci.h
> 
