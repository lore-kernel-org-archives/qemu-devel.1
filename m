Received: from eggs.gnu.org ([2001:4830:134:3::10]:54652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9dw9-0001N4-3k
	for qemu-devel@nongnu.org; Sat, 13 May 2017 16:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9dw4-0004er-8f
	for qemu-devel@nongnu.org; Sat, 13 May 2017 16:46:49 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9dw4-0004eh-31
	for qemu-devel@nongnu.org; Sat, 13 May 2017 16:46:44 -0400
Received: by mail-qk0-x241.google.com with SMTP id k74so12261761qke.2
	for <qemu-devel@nongnu.org>; Sat, 13 May 2017 13:46:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170425220451.6028-1-quintela@redhat.com>
	<20170425220451.6028-20-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <34384986-c266-3e12-f046-af893ff94331@amsat.org>
Date: Sat, 13 May 2017 17:46:39 -0300
MIME-Version: 1.0
In-Reply-To: <20170425220451.6028-20-quintela@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 19/41] migration: Remove unneeded includes
 of migration/vmstate.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 04/25/2017 07:04 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/core/qdev.c                   | 1 -
>  include/hw/acpi/memory_hotplug.h | 1 -
>  include/hw/acpi/pcihp.h          | 1 -
>  include/hw/pci/shpc.h            | 1 -
>  include/net/net.h                | 1 -
>  target/alpha/cpu.c               | 1 -
>  target/hppa/cpu.c                | 1 -
>  target/s390x/cpu.c               | 1 -
>  target/tilegx/cpu.c              | 1 -
>  9 files changed, 9 deletions(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 17ff638..23ccf9f 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -37,7 +37,6 @@
>  #include "hw/boards.h"
>  #include "hw/sysbus.h"
>  #include "qapi-event.h"
> -#include "migration/vmstate.h"
>
>  bool qdev_hotplug = false;
>  static bool qdev_hot_added = false;
> diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
> index db8ebc9..77c6576 100644
> --- a/include/hw/acpi/memory_hotplug.h
> +++ b/include/hw/acpi/memory_hotplug.h
> @@ -3,7 +3,6 @@
>
>  #include "hw/qdev-core.h"
>  #include "hw/acpi/acpi.h"
> -#include "migration/vmstate.h"
>  #include "hw/acpi/aml-build.h"
>
>  /**
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index 04528b7..8a65f99 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -28,7 +28,6 @@
>  #define HW_ACPI_PCIHP_H
>
>  #include "hw/acpi/acpi.h"
> -#include "migration/vmstate.h"
>  #include "hw/hotplug.h"
>
>  #define ACPI_PCIHP_IO_BASE_PROP "acpi-pcihp-io-base"
> diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
> index b208554..71e836b 100644
> --- a/include/hw/pci/shpc.h
> +++ b/include/hw/pci/shpc.h
> @@ -3,7 +3,6 @@
>
>  #include "qemu-common.h"
>  #include "exec/memory.h"
> -#include "migration/vmstate.h"
>  #include "hw/hotplug.h"
>  #include "hw/pci/pci.h"
>
> diff --git a/include/net/net.h b/include/net/net.h
> index 99b28d5..ba663bd 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -6,7 +6,6 @@
>  #include "qapi/qmp/qdict.h"
>  #include "qemu/option.h"
>  #include "net/queue.h"
> -#include "migration/vmstate.h"
>  #include "qapi-types.h"
>
>  #define MAC_FMT "%02X:%02X:%02X:%02X:%02X:%02X"
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index b4f9798..8186c9d 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -23,7 +23,6 @@
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "qemu-common.h"
> -#include "migration/vmstate.h"
>  #include "exec/exec-all.h"
>
>
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 1d791d0..30299e9 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -22,7 +22,6 @@
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "qemu-common.h"
> -#include "migration/vmstate.h"
>  #include "exec/exec-all.h"
>
>
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 066dcd1..cfd3b70 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -32,7 +32,6 @@
>  #include "qemu/error-report.h"
>  #include "trace.h"
>  #include "qapi/visitor.h"
> -#include "migration/vmstate.h"
>  #include "exec/exec-all.h"
>  #ifndef CONFIG_USER_ONLY
>  #include "hw/hw.h"
> diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
> index d90e38e..4532639 100644
> --- a/target/tilegx/cpu.c
> +++ b/target/tilegx/cpu.c
> @@ -23,7 +23,6 @@
>  #include "cpu.h"
>  #include "qemu-common.h"
>  #include "hw/qdev-properties.h"
> -#include "migration/vmstate.h"
>  #include "linux-user/syscall_defs.h"
>  #include "exec/exec-all.h"
>
>
