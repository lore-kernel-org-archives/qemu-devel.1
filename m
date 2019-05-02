Received: from eggs.gnu.org ([209.51.188.92]:55854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1hMBhq-0000m6-2C
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1hMBhe-0008Ly-Q5
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:24:58 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hMBhe-0008Lm-LA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:24:46 -0400
Received: by mail-ot1-x341.google.com with SMTP id a10so1992072otl.12
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 06:24:45 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Date: Thu, 2 May 2019 08:24:37 -0500
From: Corey Minyard <minyard@acm.org>
Message-ID: <20190502132437.GI6623@minyard.net>
Reply-To: minyard@acm.org
References: <20190428064731.29913-1-philmd@redhat.com>
	<20190428064731.29913-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190428064731.29913-2-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] hw/acpi: Move the IPMI stub to the
 stubs/ directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Sun, Apr 28, 2019 at 08:47:26AM +0200, Philippe Mathieu-Daudé wrote:
> Move the IPMI stub file to the stubs/ directory to simplify the
> hw/acpi Makefile.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

I'm not sure of the overall view of this, but this is ok from an
IPMI point of view in my view.

Acked-by: Corey Minyard <cminyard@mvista.com>

> ---
>  MAINTAINERS                         | 1 +
>  hw/acpi/Makefile.objs               | 3 +--
>  stubs/Makefile.objs                 | 1 +
>  hw/acpi/ipmi-stub.c => stubs/ipmi.c | 0
>  4 files changed, 3 insertions(+), 2 deletions(-)
>  rename hw/acpi/ipmi-stub.c => stubs/ipmi.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23db6f8408a..e1681eca5cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1309,6 +1309,7 @@ S: Maintained
>  F: include/hw/ipmi/*
>  F: hw/ipmi/*
>  F: hw/smbios/smbios_type_38.c
> +F: stubs/ipmi.c
>  F: tests/ipmi*
>  T: git https://github.com/cminyard/qemu.git master-ipmi-rebase
>  
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index 2d46e3789ae..4e302feb885 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -14,8 +14,7 @@ common-obj-y += aml-build.o
>  common-obj-$(CONFIG_TPM) += tpm.o
>  
>  common-obj-$(CONFIG_IPMI) += ipmi.o
> -common-obj-$(call lnot,$(CONFIG_IPMI)) += ipmi-stub.o
>  else
>  common-obj-y += acpi-stub.o
>  endif
> -common-obj-$(CONFIG_ALL) += acpi-stub.o ipmi-stub.o
> +common-obj-$(CONFIG_ALL) += acpi-stub.o
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 269dfa58326..36bb9ff0b1d 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -9,6 +9,7 @@ stub-obj-y += error-printf.o
>  stub-obj-y += fdset.o
>  stub-obj-y += gdbstub.o
>  stub-obj-y += get-vm-name.o
> +stub-obj-y += ipmi.o
>  stub-obj-y += iothread.o
>  stub-obj-y += iothread-lock.o
>  stub-obj-y += is-daemonized.o
> diff --git a/hw/acpi/ipmi-stub.c b/stubs/ipmi.c
> similarity index 100%
> rename from hw/acpi/ipmi-stub.c
> rename to stubs/ipmi.c
> -- 
> 2.20.1
> 
