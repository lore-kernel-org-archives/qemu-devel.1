Received: from eggs.gnu.org ([2001:4830:134:3::10]:57701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebVtL-0002JH-ET
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:23:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebVtG-0008B6-3R
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:23:23 -0500
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-5-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6e4c6445-0b78-1709-b724-e35daeefb1c1@redhat.com>
Date: Tue, 16 Jan 2018 19:23:06 +0100
MIME-Version: 1.0
In-Reply-To: <1516034665-27606-5-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/8] s390-ccw: interactive boot menu for
 eckd dasd (menu setup)
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

On 15.01.2018 17:44, Collin L. Walling wrote:
> Reads boot menu flag and timeout values from the iplb and
> sets the respective fields for the menu.
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
[...]
> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
> index fe909d2..da29e6e 100644
> --- a/pc-bios/s390-ccw/iplb.h
> +++ b/pc-bios/s390-ccw/iplb.h
> @@ -81,6 +81,9 @@ extern IplParameterBlock iplb __attribute__((__aligne=
d__(PAGE_SIZE)));
>  #define S390_IPL_TYPE_CCW 0x02
>  #define S390_IPL_TYPE_QEMU_SCSI 0xff
> =20
> +#define LOADPARM_PROMPT "PROMPT  "
> +#define LOADPARM_EMPTY  "........"

I've got a question: Is there a (public) specification document
available somewhere for the loadparm field?

[...]
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
> + * Author: Collin L. Walling <walling@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
> + * your option) any later version. See the COPYING file in the top-lev=
el
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
> +void menu_set_parms(uint8_t boot_menu_flags, uint16_t boot_menu_timeou=
t);
> +bool menu_check_flags(uint8_t check_flags);
> +
> +#endif /* MENU_H */
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
