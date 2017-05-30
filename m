Received: from eggs.gnu.org ([2001:4830:134:3::10]:59618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFb6d-0000HF-3V
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFb6c-0004xZ-Cy
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:58:15 -0400
Date: Tue, 30 May 2017 08:58:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170530085802.578dc4b3@nial.brq.redhat.com>
In-Reply-To: <20170529173751.3443-2-drjones@redhat.com>
References: <20170529173751.3443-1-drjones@redhat.com>
	<20170529173751.3443-2-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, zhaoshenglong@huawei.com

On Mon, 29 May 2017 19:37:50 +0200
Andrew Jones <drjones@redhat.com> wrote:

> Cc: Shannon Zhao <zhaoshenglong@huawei.com>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

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
