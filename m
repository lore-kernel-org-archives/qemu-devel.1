Received: from eggs.gnu.org ([2001:4830:134:3::10]:49713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPRwt-00036d-Jh
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPRwq-0001cJ-Fp
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:12:55 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPRwq-0001c2-Br
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:12:52 -0400
Received: by mail-qk0-x243.google.com with SMTP id 91so8097968qkq.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 04:12:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1498454578-18709-1-git-send-email-thuth@redhat.com>
	<1498454578-18709-7-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <13d24c5a-b039-12a8-bfed-7b11866526a9@amsat.org>
Date: Mon, 26 Jun 2017 08:12:48 -0300
MIME-Version: 1.0
In-Reply-To: <1498454578-18709-7-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 6/7] Makefile: Move bootdevice.o to
 common-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 06/26/2017 02:22 AM, Thomas Huth wrote:
> There does not seem to be any target specific code in this file, so
> we can put it into "common-obj" instead of "obj" to compile it only
> once for all targets.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   Makefile.objs   | 2 +-
>   Makefile.target | 2 +-
>   bootdevice.c    | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index b2e6322..756644c 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -40,7 +40,7 @@ io-obj-y = io/
>   
>   ifeq ($(CONFIG_SOFTMMU),y)
>   common-obj-y = blockdev.o blockdev-nbd.o block/
> -common-obj-y += iothread.o
> +common-obj-y += bootdevice.o iothread.o
>   common-obj-y += net/
>   common-obj-y += qdev-monitor.o device-hotplug.o
>   common-obj-$(CONFIG_WIN32) += os-win32.o
> diff --git a/Makefile.target b/Makefile.target
> index 0066579..ffa7a8f 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -137,7 +137,7 @@ endif #CONFIG_BSD_USER
>   # System emulator target
>   ifdef CONFIG_SOFTMMU
>   obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
> -obj-y += qtest.o bootdevice.o
> +obj-y += qtest.o
>   obj-y += hw/
>   obj-y += memory.o
>   obj-y += memory_mapping.o
> diff --git a/bootdevice.c b/bootdevice.c
> index 33e3029..1141009 100644
> --- a/bootdevice.c
> +++ b/bootdevice.c
> @@ -27,7 +27,7 @@
>   #include "sysemu/sysemu.h"
>   #include "qapi/visitor.h"
>   #include "qemu/error-report.h"
> -#include "hw/hw.h"
> +#include "sysemu/reset.h"
>   #include "hw/qdev-core.h"
>   
>   typedef struct FWBootEntry FWBootEntry;
> 
