Received: from eggs.gnu.org ([2001:4830:134:3::10]:42018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1dFsPp-0001Cr-77
	for qemu-devel@nongnu.org; Tue, 30 May 2017 21:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1dFsPo-0001tN-Eg
	for qemu-devel@nongnu.org; Tue, 30 May 2017 21:27:13 -0400
Message-ID: <592E199C.1040602@huawei.com>
Date: Wed, 31 May 2017 09:17:16 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <20170529173751.3443-1-drjones@redhat.com>
	<20170529173751.3443-2-drjones@redhat.com>
In-Reply-To: <20170529173751.3443-2-drjones@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/arm/virt-acpi-build: build SLIT
 when needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org



On 2017/5/30 1:37, Andrew Jones wrote:
> Cc: Shannon Zhao <zhaoshenglong@huawei.com>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Shannon Zhao <shannon.zhao@linaro.org>

> ---
>  hw/arm/virt-acpi-build.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e5852067f5bd..2079828c22a4 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -776,6 +776,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      if (nb_numa_nodes > 0) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_srat(tables_blob, tables->linker, vms);
> +        if (have_numa_distance) {
> +            acpi_add_table(table_offsets, tables_blob);
> +            build_slit(tables_blob, tables->linker);
> +        }
>      }
>  
>      if (its_class_name() && !vmc->no_its) {
> 

-- 
Shannon
