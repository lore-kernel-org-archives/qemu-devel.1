Received: from eggs.gnu.org ([2001:4830:134:3::10]:39101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gHNpa-00062b-DP
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gHNpZ-0004oi-9o
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:48:50 -0400
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
	<20181029134000.11157-10-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <bc310af5-2423-f6c7-d478-c386efb95004@reactos.org>
Date: Tue, 30 Oct 2018 07:48:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181029134000.11157-10-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 09/11] hw/m68k: add a dummy SWIM floppy
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, afaerber@suse.de, aurelien@aurel32.net, laurent@vivier.eu

Le 29/10/2018 à 14:39, Mark Cave-Ayland a écrit :
> From: Laurent Vivier <laurent@vivier.eu>
> 
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/block/Makefile.objs  |   1 +
>   hw/block/swim.c         | 415 ++++++++++++++++++++++++++++++++++++++++++++++++
>   include/hw/block/swim.h |  76 +++++++++
>   3 files changed, 492 insertions(+)
>   create mode 100644 hw/block/swim.c
>   create mode 100644 include/hw/block/swim.h

[...]

> diff --git a/include/hw/block/swim.h b/include/hw/block/swim.h
> new file mode 100644
> index 0000000000..d6fbdc11ac
> --- /dev/null
> +++ b/include/hw/block/swim.h
> @@ -0,0 +1,76 @@
> +/*
> + * QEMU Macintosh floppy disk controller emulator (SWIM)
> + *
> + * Copyright (c) 2014-2018 Laurent Vivier <laurent@vivier.eu>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef SWIM_H
> +#define SWIM_H
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +
> +#define MAX_FD                  2

Maybe rename MAX_FD to SWIM_MAX_FD, to prevent conflicts with MAX_FD in other files?
Excepted that:
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
