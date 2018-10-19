Received: from eggs.gnu.org ([2001:4830:134:3::10]:44092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDU2c-00076G-ST
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDU2Y-0005uA-SR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:38:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDU2Y-0005nw-K4
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:38:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id z204-v6so3541442wmc.5
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 05:38:06 -0700 (PDT)
References: <1539952626-1644-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d5e113f8-a326-932a-e9e9-bd28d4b7bf73@redhat.com>
Date: Fri, 19 Oct 2018 14:38:03 +0200
MIME-Version: 1.0
In-Reply-To: <1539952626-1644-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/core: Move null-machine into the
 common-obj list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 19/10/2018 14:37, Thomas Huth wrote:
> The null-machine code used to be target specific since it used the
> target-specific cpu_init() function in the past. But in the recent
> commit 2278b93941d42c30e2950 ("Use cpu_create(type) instead of
> cpu_init(cpu_model)") this has been change, so that the code now
> uses the common cpu_create() function instead. Thus we can put
> the null-machine into the common-obj list so that it is compiled
> only once for all targets, to save some compilation time.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/core/Makefile.objs  | 3 +--
>  hw/core/null-machine.c | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index b736ce2..a799c83 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -21,5 +21,4 @@ common-obj-$(CONFIG_SOFTMMU) += or-irq.o
>  common-obj-$(CONFIG_SOFTMMU) += split-irq.o
>  common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
>  common-obj-$(CONFIG_SOFTMMU) += generic-loader.o
> -
> -obj-$(CONFIG_SOFTMMU) += null-machine.o
> +common-obj-$(CONFIG_SOFTMMU) += null-machine.o
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index cde4d3e..76d3f8e 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -18,7 +18,7 @@
>  #include "hw/boards.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
> -#include "cpu.h"
> +#include "qom/cpu.h"
>  
>  static void machine_none_init(MachineState *mch)
>  {
> 
