Received: from eggs.gnu.org ([2001:4830:134:3::10]:39343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cwjNb-0007Jb-0a
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 01:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cwjNX-00055M-W8
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 01:57:47 -0400
Received: from mail-sn1nam01on0106.outbound.protection.outlook.com
	([104.47.32.106]:18592
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1cwjNX-00054m-L3
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 01:57:43 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Sat, 8 Apr 2017 05:57:32 +0000
Message-ID: <DM2PR21MB00601A5A86C3F935CCCBAC0D9E0F0@DM2PR21MB0060.namprd21.prod.outlook.com>
References: <20170408054318.19830-1-omar.rizwan@gmail.com>
In-Reply-To: <20170408054318.19830-1-omar.rizwan@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] raspi: Add Raspberry Pi 1 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Omar Rizwan <omar.rizwan@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

Hi Omar,

> From: Omar Rizwan [mailto:omar.rizwan@gmail.com]
> Sent: Friday, 7 April 2017 22:43

Did you do any testing of this? One of the reasons I never got around to up=
streaming this was that I couldn't get Raspbian working reliably (there was=
 some problem with stalled DMA reads from the MMC controller), and I didn't=
 have the cycles to debug it further. Also, IIRC Raspbian on pi1 depended o=
n the system timer devices, so it might not make sense to have this board-l=
evel support without adding that first.

> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -34,6 +34,7 @@ static void bcm2835_peripherals_init(Object *obj)
>      /* Internal memory region for peripheral bus addresses (not exported=
) */
>      memory_region_init(&s->gpu_bus_mr, obj, "bcm2835-gpu", (uint64_t)1 <=
<
> 32);
>      object_property_add_child(obj, "gpu-bus", OBJECT(&s->gpu_bus_mr),
> NULL);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->gpu_bus_mr);
>=20
>      /* Internal memory region for request/response communication with
>       * mailbox-addressable peripherals (not exported)

This line looks like it might have snuck in by accident?

Andrew
