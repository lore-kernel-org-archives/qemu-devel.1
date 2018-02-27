Received: from eggs.gnu.org ([2001:4830:134:3::10]:53651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eqeab-00026Z-Ec
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 07:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eqeaa-0002Jr-KD
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 07:42:37 -0500
References: <1519303376-92875-1-git-send-email-imammedo@redhat.com>
	<1519303376-92875-3-git-send-email-imammedo@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0f55eea6-24ca-b5ea-7e6b-89eb93b70393@redhat.com>
Date: Tue, 27 Feb 2018 13:42:26 +0100
MIME-Version: 1.0
In-Reply-To: <1519303376-92875-3-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/9] pc: replace pm object initialization
 with one-liner in acpi_get_pm_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

Hi,

On 22/02/18 13:42, Igor Mammedov wrote:
> next patch will need it before it gets to piix4/lpc branches
> that initializes 'obj' now.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/i386/acpi-build.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index deb440f..b85fefe 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -128,7 +128,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>  {
>      Object *piix = piix4_pm_find();
>      Object *lpc = ich9_lpc_find();
> -    Object *obj = NULL;
> +    Object *obj = piix ? piix : lpc;
>      QObject *o;
>  
>      pm->force_rev1_fadt = false;
> @@ -138,7 +138,6 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>      if (piix) {
>          /* w2k requires FADT(rev1) or it won't boot, keep PC compatible */
>          pm->force_rev1_fadt = true;
> -        obj = piix;
>          pm->cpu_hp_io_base = PIIX4_CPU_HOTPLUG_IO_BASE;
>          pm->pcihp_io_base =
>              object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> @@ -146,7 +145,6 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>              object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
>      }
>      if (lpc) {
> -        obj = lpc;
>          pm->cpu_hp_io_base = ICH9_CPU_HOTPLUG_IO_BASE;
>      }
>      assert(obj);
> 
