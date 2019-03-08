Received: from eggs.gnu.org ([209.51.188.92]:49427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h2I40-0006wa-Dm
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h2I3z-0000Gt-0V
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:09:36 -0500
References: <20190308114218.26692-1-shameerali.kolothum.thodi@huawei.com>
	<20190308114218.26692-2-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7490ad1c-d4a6-ad5b-ebbf-c27a674d9629@redhat.com>
Date: Fri, 8 Mar 2019 17:09:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190308114218.26692-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/11] hw/acpi: Move constant
 definitions to header files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com
Cc: linuxarm@huawei.com, xuwei5@hisilicon.com

Hi,

On 3/8/19 12:42 PM, Shameer Kolothum wrote:
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> 
> By moving the definition of memory hotplug related constants used
> by ACPI for both CPU and memory, this commits allows those to be
> used from  other parts of the code.

Maybe elaborate on where you intend to use them.

> 
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/acpi/memory_hotplug.c         | 26 --------------------------
>  include/hw/acpi/memory_hotplug.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index 921cad2..a6beb10 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -8,32 +8,6 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-misc.h"
>  
> -#define MEMORY_SLOTS_NUMBER          "MDNR"
> -#define MEMORY_HOTPLUG_IO_REGION     "HPMR"
> -#define MEMORY_SLOT_ADDR_LOW         "MRBL"
> -#define MEMORY_SLOT_ADDR_HIGH        "MRBH"
> -#define MEMORY_SLOT_SIZE_LOW         "MRLL"
> -#define MEMORY_SLOT_SIZE_HIGH        "MRLH"
> -#define MEMORY_SLOT_PROXIMITY        "MPX"
> -#define MEMORY_SLOT_ENABLED          "MES"
> -#define MEMORY_SLOT_INSERT_EVENT     "MINS"
> -#define MEMORY_SLOT_REMOVE_EVENT     "MRMV"
> -#define MEMORY_SLOT_EJECT            "MEJ"
> -#define MEMORY_SLOT_SLECTOR          "MSEL"
> -#define MEMORY_SLOT_OST_EVENT        "MOEV"
> -#define MEMORY_SLOT_OST_STATUS       "MOSC"
> -#define MEMORY_SLOT_LOCK             "MLCK"
> -#define MEMORY_SLOT_STATUS_METHOD    "MRST"
> -#define MEMORY_SLOT_CRS_METHOD       "MCRS"
> -#define MEMORY_SLOT_OST_METHOD       "MOST"
> -#define MEMORY_SLOT_PROXIMITY_METHOD "MPXM"
> -#define MEMORY_SLOT_EJECT_METHOD     "MEJ0"
> -#define MEMORY_SLOT_NOTIFY_METHOD    "MTFY"
> -#define MEMORY_SLOT_SCAN_METHOD      "MSCN"
> -#define MEMORY_HOTPLUG_DEVICE        "MHPD"
> -#define MEMORY_HOTPLUG_IO_LEN         24
> -#define MEMORY_DEVICES_CONTAINER     "\\_SB.MHPC"

Do we really need to expose all of them. I just can see
MEMORY_SLOT_SCAN_METHOD used in hw/acpi/ged.c? Maybe I missed some though?

Also at the beginning I tried to find some specification details for
those stuff but I failed. It would be helpful for a non specialist
reader to add a comment that helps to understand what is part of a
specification (link?) and what is arbitrarily defined.

Thanks

Eric
> -
>  static uint16_t memhp_io_base;
>  
>  static ACPIOSTInfo *acpi_memory_device_status(int slot, MemStatus *mdev)
> diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
> index 77c6576..fbfcbe6 100644
> --- a/include/hw/acpi/memory_hotplug.h
> +++ b/include/hw/acpi/memory_hotplug.h
> @@ -5,6 +5,32 @@
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/aml-build.h"
>  
> +#define MEMORY_SLOTS_NUMBER          "MDNR"
> +#define MEMORY_HOTPLUG_IO_REGION     "HPMR"
> +#define MEMORY_SLOT_ADDR_LOW         "MRBL"
> +#define MEMORY_SLOT_ADDR_HIGH        "MRBH"
> +#define MEMORY_SLOT_SIZE_LOW         "MRLL"
> +#define MEMORY_SLOT_SIZE_HIGH        "MRLH"
> +#define MEMORY_SLOT_PROXIMITY        "MPX"
> +#define MEMORY_SLOT_ENABLED          "MES"
> +#define MEMORY_SLOT_INSERT_EVENT     "MINS"
> +#define MEMORY_SLOT_REMOVE_EVENT     "MRMV"
> +#define MEMORY_SLOT_EJECT            "MEJ"
> +#define MEMORY_SLOT_SLECTOR          "MSEL"
> +#define MEMORY_SLOT_OST_EVENT        "MOEV"
> +#define MEMORY_SLOT_OST_STATUS       "MOSC"
> +#define MEMORY_SLOT_LOCK             "MLCK"
> +#define MEMORY_SLOT_STATUS_METHOD    "MRST"
> +#define MEMORY_SLOT_CRS_METHOD       "MCRS"
> +#define MEMORY_SLOT_OST_METHOD       "MOST"
> +#define MEMORY_SLOT_PROXIMITY_METHOD "MPXM"
> +#define MEMORY_SLOT_EJECT_METHOD     "MEJ0"
> +#define MEMORY_SLOT_NOTIFY_METHOD    "MTFY"
> +#define MEMORY_SLOT_SCAN_METHOD      "MSCN"
> +#define MEMORY_HOTPLUG_DEVICE        "MHPD"
> +#define MEMORY_HOTPLUG_IO_LEN         24
> +#define MEMORY_DEVICES_CONTAINER     "\\_SB.MHPC"
> +
>  /**
>   * MemStatus:
>   * @is_removing: the memory device in slot has been requested to be ejected.
> 
