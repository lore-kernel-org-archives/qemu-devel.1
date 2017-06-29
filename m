Received: from eggs.gnu.org ([2001:4830:134:3::10]:40259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQirP-0002lV-Rz
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQirM-0007iY-41
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:28:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dQirL-0007hz-SD
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:28:28 -0400
Date: Fri, 30 Jun 2017 02:28:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170630022802-mutt-send-email-mst@kernel.org>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
	<1498773362-18675-5-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498773362-18675-5-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [PATCH RFC 4/6] hw/acpi: prepare pci hotplug IO
 for ich9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On Fri, Jun 30, 2017 at 12:56:00AM +0300, Aleksandr Bezzubikov wrote:
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>

Add more explanation in commit log please.

> ---
>  hw/i386/acpi-build.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index c99dbcc..e434efe 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -135,12 +135,6 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>      if (piix) {
>          obj = piix;
>          pm->cpu_hp_io_base = PIIX4_CPU_HOTPLUG_IO_BASE;
> -        pcihp_io_base =
> -            object_property_get_int(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> -        pcihp_io_len =
> -            object_property_get_int(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
> -        pm->pcihp_io_base = (pcihp_io_base == -1) ? 0 : pcihp_io_base;
> -        pm->pcihp_io_len = (pcihp_io_len == -1) ? 0 : pcihp_io_len;
>      }
>      if (lpc) {
>          obj = lpc;
> @@ -148,6 +142,13 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>      }
>      assert(obj);
>  
> +    pcihp_io_base =
> +        object_property_get_int(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> +    pcihp_io_len =
> +        object_property_get_int(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
> +    pm->pcihp_io_base = (pcihp_io_base == -1) ? 0 : pcihp_io_base;
> +    pm->pcihp_io_len = (pcihp_io_len == -1) ? 0 : pcihp_io_len;
> +
>      /* Fill in optional s3/s4 related properties */
>      o = object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NULL);
>      if (o) {
> -- 
> 2.7.4
