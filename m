Received: from eggs.gnu.org ([209.51.188.92]:37915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKQgU-0001bV-51
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKQgT-0002rj-6V
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:00:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKQgT-0002pu-05
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:00:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so8935471wra.12
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 10:00:16 -0700 (PDT)
References: <20190427165504.29846-1-philmd@redhat.com>
	<20190427165504.29846-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c6a685b1-b8a6-9479-45ef-26243bebe77b@redhat.com>
Date: Sat, 27 Apr 2019 19:00:12 +0200
MIME-Version: 1.0
In-Reply-To: <20190427165504.29846-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/acpi: Always build the acpi/core.o
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Samuel Ortiz <sameo@linux.intel.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>

On 4/27/19 6:55 PM, Philippe Mathieu-Daudé wrote:
> The 'core' ACPI functions are not X86-specific.
> Let this file be built unconditionally, this will allow
> us to use ACPI on non-X86 architectures.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/acpi/Makefile.objs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index c86edfbed90..09c810ac556 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -1,4 +1,5 @@
> -common-obj-$(CONFIG_ACPI_X86) += core.o piix4.o pcihp.o
> +common-obj-$(CONFIG_ACPI) += core.o

Sorry, sent from wrong branch :S

Please consider reviewing with this snippet applied on top:

-- >8 --
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-$(CONFIG_ACPI) += core.o
+common-obj-y += core.o
---

I'll respin after getting some review comments.

> +common-obj-$(CONFIG_ACPI_X86) += piix4.o pcihp.o
>  common-obj-$(CONFIG_ACPI_X86_ICH) += ich9.o tco.o
>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu_hotplug.o
>  common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
> 
