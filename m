Received: from eggs.gnu.org ([209.51.188.92]:47833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gj4Uk-0006Br-R2
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gj4Uj-0004lA-BT
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:49:46 -0500
Date: Mon, 14 Jan 2019 10:49:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114104559-mutt-send-email-mst@kernel.org>
References: <20190114130829.21790-1-philmd@redhat.com>
	<20190114130829.21790-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190114130829.21790-2-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] hw/nvram/fw_cfg: Remove various
 typedefs from "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Ben Warren <ben@skyportsystems.com>, "open list:Virt" <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Mon, Jan 14, 2019 at 02:08:27PM +0100, Philippe Mathieu-Daud=E9 wrote:
> There are only three include files requiring these typedefs, let them
> include "hw/nvram/fw_cfg.h" directly to simplify "qemu/typedefs.h".
>=20
> To clean "qemu/typedefs.h", move the declarations to "hw/nvram/fw_cfg.h=
".
> Reorder two function declarations to avoid forward typedef declarations=
.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  include/hw/acpi/vmgenid.h |  1 +
>  include/hw/arm/virt.h     |  1 +
>  include/hw/mem/nvdimm.h   |  1 +
>  include/hw/nvram/fw_cfg.h | 22 ++++++++++++----------
>  include/qemu/typedefs.h   |  4 ----
>  5 files changed, 15 insertions(+), 14 deletions(-)

I am sorry I don't understand what this patchset is about.
Supposed to be a cleanup but instead it pulls
fw cfg into any user of unrelated headers.

More lines of code slower builds what's to like?

Shared typedefs is what typedefs.h is about.
These are clearly shared so let's keep it simple.


> diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
> index 38586ecbdf..be53de38f1 100644
> --- a/include/hw/acpi/vmgenid.h
> +++ b/include/hw/acpi/vmgenid.h
> @@ -3,6 +3,7 @@
> =20
>  #include "hw/acpi/bios-linker-loader.h"
>  #include "hw/qdev.h"
> +#include "hw/nvram/fw_cfg.h"
>  #include "qemu/uuid.h"
> =20
>  #define VMGENID_DEVICE           "vmgenid"
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 4cc57a7ef6..fef632dcf5 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -35,6 +35,7 @@
>  #include "qemu/notify.h"
>  #include "hw/boards.h"
>  #include "hw/arm/arm.h"
> +#include "hw/nvram/fw_cfg.h"
>  #include "sysemu/kvm.h"
>  #include "hw/intc/arm_gicv3_common.h"
> =20
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index c5c9b3c7f8..51d3a52c4b 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -24,6 +24,7 @@
>  #define QEMU_NVDIMM_H
> =20
>  #include "hw/mem/pc-dimm.h"
> +#include "hw/nvram/fw_cfg.h"
>  #include "hw/acpi/bios-linker-loader.h"
> =20
>  #define NVDIMM_DEBUG 0
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index f5a6895a74..cc744d5268 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -14,15 +14,12 @@
>  #define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG=
_IO)
>  #define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG=
_MEM)
> =20
> -typedef struct fw_cfg_file FWCfgFile;
> -
>  #define FW_CFG_ORDER_OVERRIDE_VGA    70
>  #define FW_CFG_ORDER_OVERRIDE_NIC    80
>  #define FW_CFG_ORDER_OVERRIDE_USER   100
>  #define FW_CFG_ORDER_OVERRIDE_DEVICE 110
> =20
> -void fw_cfg_set_order_override(FWCfgState *fw_cfg, int order);
> -void fw_cfg_reset_order_override(FWCfgState *fw_cfg);
> +typedef struct fw_cfg_file FWCfgFile;
> =20
>  typedef struct FWCfgFiles {
>      uint32_t  count;
> @@ -34,7 +31,9 @@ typedef struct fw_cfg_dma_access FWCfgDmaAccess;
>  typedef void (*FWCfgCallback)(void *opaque);
>  typedef void (*FWCfgWriteCallback)(void *opaque, off_t start, size_t l=
en);
> =20
> -struct FWCfgState {
> +typedef struct FWCfgEntry FWCfgEntry;
> +
> +typedef struct FWCfgState {
>      /*< private >*/
>      SysBusDevice parent_obj;
>      /*< public >*/
> @@ -53,17 +52,17 @@ struct FWCfgState {
>      dma_addr_t dma_addr;
>      AddressSpace *dma_as;
>      MemoryRegion dma_iomem;
> -};
> +} FWCfgState;
> =20
> -struct FWCfgIoState {
> +typedef struct FWCfgIoState {
>      /*< private >*/
>      FWCfgState parent_obj;
>      /*< public >*/
> =20
>      MemoryRegion comb_iomem;
> -};
> +} FWCfgIoState;
> =20
> -struct FWCfgMemState {
> +typedef struct FWCfgMemState {
>      /*< private >*/
>      FWCfgState parent_obj;
>      /*< public >*/
> @@ -71,7 +70,10 @@ struct FWCfgMemState {
>      MemoryRegion ctl_iomem, data_iomem;
>      uint32_t data_width;
>      MemoryRegionOps wide_data_ops;
> -};
> +} FWCfgMemState;
> +
> +void fw_cfg_set_order_override(FWCfgState *fw_cfg, int order);
> +void fw_cfg_reset_order_override(FWCfgState *fw_cfg);
> =20
>  /**
>   * fw_cfg_add_bytes:
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 30ad8b2d8d..293e47ef7c 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -28,10 +28,6 @@ typedef struct DriveInfo DriveInfo;
>  typedef struct Error Error;
>  typedef struct EventNotifier EventNotifier;
>  typedef struct FlatView FlatView;
> -typedef struct FWCfgEntry FWCfgEntry;
> -typedef struct FWCfgIoState FWCfgIoState;
> -typedef struct FWCfgMemState FWCfgMemState;
> -typedef struct FWCfgState FWCfgState;
>  typedef struct HVFX86EmulatorState HVFX86EmulatorState;
>  typedef struct I2CBus I2CBus;
>  typedef struct I2SCodec I2SCodec;
> --=20
> 2.17.2
>=20
