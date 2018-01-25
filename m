Received: from eggs.gnu.org ([2001:4830:134:3::10]:52807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eehKD-0007ju-Hp
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eehKA-0005d9-Jc
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:12:17 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-7-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9190614d-6e13-1bca-3551-a76c9800d0b9@redhat.com>
Date: Thu, 25 Jan 2018 14:12:05 +0100
MIME-Version: 1.0
In-Reply-To: <1516732013-18272-7-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 06/10] s390-ccw: set up interactive boot
 menu parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

On 23.01.2018 19:26, Collin L. Walling wrote:
> Reads boot menu flag and timeout values from the iplb and
> sets the respective fields for the menu.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile |  2 +-
>  pc-bios/s390-ccw/iplb.h   |  3 +++
>  pc-bios/s390-ccw/main.c   | 21 +++++++++++++++++++++
>  pc-bios/s390-ccw/menu.c   | 26 ++++++++++++++++++++++++++
>  pc-bios/s390-ccw/menu.h   | 23 +++++++++++++++++++++++
>  5 files changed, 74 insertions(+), 1 deletion(-)
>  create mode 100644 pc-bios/s390-ccw/menu.c
>  create mode 100644 pc-bios/s390-ccw/menu.h
[...]
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> new file mode 100644
> index 0000000..e15a7f2
> --- /dev/null
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -0,0 +1,26 @@
> +/*
> + * QEMU S390 Interactive Boot Menu
> + *
> + * Copyright 2017 IBM Corp.

Happy new year?

> + * Author: Collin L. Walling <walling@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#include "menu.h"
> +
> +static uint8_t flags;
> +static uint64_t timeout;
> +
> +void menu_set_parms(uint8_t boot_menu_flag, uint16_t boot_menu_timeout)
> +{
> +    flags = boot_menu_flag;
> +    timeout = boot_menu_timeout;
> +}
> +
> +int menu_check_flags(uint8_t check_flags)
> +{
> +    return flags & check_flags;
> +}
> diff --git a/pc-bios/s390-ccw/menu.h b/pc-bios/s390-ccw/menu.h
> new file mode 100644
> index 0000000..04b1db1
> --- /dev/null
> +++ b/pc-bios/s390-ccw/menu.h
> @@ -0,0 +1,23 @@
> +/*
> + * QEMU S390 Interactive Boot Menu
> + *
> + * Copyright 2017 IBM Corp.

You might want to bump that to 2018, too.

> + * Author: Collin L. Walling <walling@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef MENU_H
> +#define MENU_H
> +
> +#include "libc.h"
> +
> +#define BOOT_MENU_FLAG_BOOT_OPTS 0x80
> +#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
> +
> +void menu_set_parms(uint8_t boot_menu_flags, uint16_t boot_menu_timeout);
> +bool menu_check_flags(uint8_t check_flags);
> +
> +#endif /* MENU_H */
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
