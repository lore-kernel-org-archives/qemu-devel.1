Received: from eggs.gnu.org ([209.51.188.92]:44058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBGIz-0003bH-Rt
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBG4S-0004dX-Cx
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:51:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hBG4S-0004dB-3g
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:51:08 -0400
Date: Tue, 2 Apr 2019 11:50:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190402115057.7412fa40@redhat.com>
In-Reply-To: <20190401181150.GA31786@erokenlabserver>
References: <20190401181150.GA31786@erokenlabserver>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] Categorize devices: DIMM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ernest Esene <eroken1@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, 1 Apr 2019 19:11:50 +0100
Ernest Esene <eroken1@gmail.com> wrote:

> Set category and describe DIMM devices
> 
> Signed-off-by: Ernest Esene <eroken1@gmail.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> v3:
>   * add MEMORY device category
>   * set category to MEMORY
> v2:
>   * split into separate patches
> ---
>  hw/mem/nvdimm.c        | 1 +
>  hw/mem/pc-dimm.c       | 1 +
>  include/hw/qdev-core.h | 1 +
>  qdev-monitor.c         | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index bf2adf5e16..a334dbe1f5 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -200,6 +200,7 @@ static void nvdimm_class_init(ObjectClass *oc, void *data)
>      ddc->realize = nvdimm_realize;
>      mdc->get_memory_region = nvdimm_md_get_memory_region;
>      dc->props = nvdimm_properties;
> +    dc->desc = "NVDIMM memory module";
>  
>      nvc->read_label_data = nvdimm_read_label_data;
>      nvc->write_label_data = nvdimm_write_label_data;
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 152400b1fc..3ace8077b5 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -259,6 +259,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
>      dc->unrealize = pc_dimm_unrealize;
>      dc->props = pc_dimm_properties;
>      dc->desc = "DIMM memory module";
> +    set_bit(DEVICE_CATEGORY_MEMORY, dc->categories);
>  
>      ddc->get_vmstate_memory_region = pc_dimm_get_memory_region;
>  
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 33ed3b8dde..a7d9ea1fbe 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -26,6 +26,7 @@ typedef enum DeviceCategory {
>      DEVICE_CATEGORY_SOUND,
>      DEVICE_CATEGORY_MISC,
>      DEVICE_CATEGORY_CPU,
> +    DEVICE_CATEGORY_MEMORY,
>      DEVICE_CATEGORY_MAX
>  } DeviceCategory;
>  
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index d4320986a2..5318df205b 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -143,6 +143,7 @@ static void qdev_print_devinfos(bool show_no_user)
>          [DEVICE_CATEGORY_SOUND]   = "Sound",
>          [DEVICE_CATEGORY_MISC]    = "Misc",
>          [DEVICE_CATEGORY_CPU]     = "CPU",
> +        [DEVICE_CATEGORY_MEMORY]  = "Memory",
>          [DEVICE_CATEGORY_MAX]     = "Uncategorized",
>      };
>      GSList *list, *elt;
