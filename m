Received: from eggs.gnu.org ([2001:4830:134:3::10]:51016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cJg4i-00010m-Ld
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cJg4e-0004Wt-O0
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:32:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cJg4e-0004W7-G1
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:32:48 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0DD1804F5
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 12:32:47 +0000 (UTC)
References: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
	<1480980749-182204-9-git-send-email-imammedo@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <d435dc62-2b9a-e650-eac6-f68b123adfe6@redhat.com>
Date: Wed, 21 Dec 2016 14:32:42 +0200
MIME-Version: 1.0
In-Reply-To: <1480980749-182204-9-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 08/10] memhp: move memory hotplug
 only defines to memory_hotplug.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 12/06/2016 01:32 AM, Igor Mammedov wrote:
> Move defines used locally only by memory_hotplug.c into it
> from header files.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/acpi/memory_hotplug.h |  3 ---
>  include/hw/acpi/pc-hotplug.h     | 22 ----------------------
>  hw/acpi/memory_hotplug.c         | 24 ++++++++++++++++++++++++
>  3 files changed, 24 insertions(+), 25 deletions(-)
>
> diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
> index 37e2706..91d4045 100644
> --- a/include/hw/acpi/memory_hotplug.h
> +++ b/include/hw/acpi/memory_hotplug.h
> @@ -47,9 +47,6 @@ extern const VMStateDescription vmstate_memory_hotplug;
>
>  void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
>
> -#define MEMORY_HOTPLUG_DEVICE        "MHPD"
> -#define MEMORY_SLOT_SCAN_METHOD      "MSCN"
> -
>  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>                                uint16_t io_base, uint16_t io_len,
>                                const char *res_root,
> diff --git a/include/hw/acpi/pc-hotplug.h b/include/hw/acpi/pc-hotplug.h
> index 6a8d268..a4f513d 100644
> --- a/include/hw/acpi/pc-hotplug.h
> +++ b/include/hw/acpi/pc-hotplug.h
> @@ -32,26 +32,4 @@
>  #define ACPI_MEMORY_HOTPLUG_IO_LEN 24
>  #define ACPI_MEMORY_HOTPLUG_BASE 0x0a00
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
> -
>  #endif
> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index 49e856f..da29332 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -7,6 +7,30 @@
>  #include "trace.h"
>  #include "qapi-event.h"
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
> +
>  static ACPIOSTInfo *acpi_memory_device_status(int slot, MemStatus *mdev)
>  {
>      ACPIOSTInfo *info = g_new0(ACPIOSTInfo, 1);
>

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
