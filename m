Received: from eggs.gnu.org ([2001:4830:134:3::10]:55171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ddYYF-0001ka-HN
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ddYYC-00076P-4o
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:05:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ddYYB-000769-Sq
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:05:44 -0400
Date: Fri, 4 Aug 2017 11:05:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170804110539.3885a22d@nial.brq.redhat.com>
In-Reply-To: <20170804064540.10523-1-dhiru.kholia@gmail.com>
References: <20170804064540.10523-1-dhiru.kholia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc/acpi: Fix booting of macOS with Clover
 EFI bootloader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dhiru Kholia <dhiru.kholia@gmail.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>, BALATON Zoltan <balaton@eik.bme.hu>

On Fri,  4 Aug 2017 12:15:40 +0530
Dhiru Kholia <dhiru.kholia@gmail.com> wrote:

> This was tested with macOS 10.12.5 and Clover r4114.
> 
> Without this patch, the macOS boot process gets stuck at the Apple logo
> without showing any progress bar.
> 
> I have documented the process of running macOS on QEMU/KVM at,
> 
> https://github.com/kholia/OSX-KVM/
> 
> Instead of using this patch, adding an additional command-line knob
> which exposes this setting (force_rev1_fadt) to the user might be a more
> general solution.
it's been reported that OVMF had issues that were fixed,
you probably want to read this thread:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg468456.html

CCing interested parties

> ---
>  hw/i386/acpi-build.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b9c245c..0f8df19 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -145,6 +145,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>              object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
>      }
>      if (lpc) {
> +        pm->force_rev1_fadt = true;
>          obj = lpc;
>          pm->cpu_hp_io_base = ICH9_CPU_HOTPLUG_IO_BASE;
>      }
