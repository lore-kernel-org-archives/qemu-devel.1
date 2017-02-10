Received: from eggs.gnu.org ([2001:4830:134:3::10]:42211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cc1Kt-0002TK-M4
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cc1Kt-0002a5-1r
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:53:23 -0500
Message-ID: <589D2A30.5030804@huawei.com>
Date: Fri, 10 Feb 2017 10:49:20 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1486644810-33181-1-git-send-email-agraf@suse.de>
	<1486644810-33181-3-git-send-email-agraf@suse.de>
In-Reply-To: <1486644810-33181-3-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] hw/arm/virt: Declare virtio-mmio as
 dma cache coherent in ACPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>, mst@redhat.com



On 2017/2/9 20:53, Alexander Graf wrote:
> Virtio-mmio devices can directly access guest memory and do so in cache
> coherent fashion. Tell the guest about that fact when it's using ACPI.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  hw/arm/virt-acpi-build.c | 1 +
>  1 file changed, 1 insertion(+)
> 
Reviewed-by: Shannon Zhao <shannon.zhao@linaro.org>

> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 07a10ac..8955a9d 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -135,6 +135,7 @@ static void acpi_dsdt_add_virtio(Aml *scope,
>          Aml *dev = aml_device("VR%02u", i);
>          aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
>          aml_append(dev, aml_name_decl("_UID", aml_int(i)));
> +        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
>  
>          Aml *crs = aml_resource_template();
>          aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
> 

-- 
Shannon
