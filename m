Received: from eggs.gnu.org ([2001:4830:134:3::10]:60263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeeXC-0006D1-Fv
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeeXB-0006J6-I3
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:13:30 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:36109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eeeXB-0006I0-C2
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:13:29 -0500
Received: by mail-oi0-x22c.google.com with SMTP id w135so4906329oie.3
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 02:13:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180123132051.24448-1-f4bug@amsat.org>
References: <20180123132051.24448-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 10:13:07 +0000
Message-ID: <CAFEAcA97F9nwTajT21hJp5uQbDPsaAKgOBA_+bcOBQOTLc-9Pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sdhci: fix a NULL pointer dereference due
 to uninitialized AddresSpace object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

On 23 January 2018 at 13:20, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> missed in 60765b6ceeb4.
>
>   Thread 1 "qemu-system-aarch64" received signal SIGSEGV, Segmentation fa=
ult.
>   address_space_init (as=3D0x0, root=3D0x55555726e410, name=3Dname@entry=
=3D0x555555e3f0a7 "sdhci-dma") at memory.c:3050
>   3050      as->root =3D root;
>   (gdb) bt
>   #0  address_space_init (as=3D0x0, root=3D0x55555726e410, name=3Dname@en=
try=3D0x555555e3f0a7 "sdhci-dma") at memory.c:3050
>   #1  0x0000555555af62c3 in sdhci_sysbus_realize (dev=3D<optimized out>, =
errp=3D0x7fff7f931150) at hw/sd/sdhci.c:1564
>   #2  0x00005555558b25e5 in zynqmp_sdhci_realize (dev=3D0x555557051520, e=
rrp=3D0x7fff7f931150) at hw/sd/zynqmp-sdhci.c:151
>   #3  0x0000555555a2e7f3 in device_set_realized (obj=3D0x555557051520, va=
lue=3D<optimized out>, errp=3D0x7fff7f931270) at hw/core/qdev.c:966
>   #4  0x0000555555ba3f74 in property_set_bool (obj=3D0x555557051520, v=3D=
<optimized out>, name=3D<optimized out>, opaque=3D0x555556e04a20,
>       errp=3D0x7fff7f931270) at qom/object.c:1906
>   #5  0x0000555555ba51f4 in object_property_set (obj=3Dobj@entry=3D0x5555=
57051520, v=3Dv@entry=3D0x5555576dbd60,
>       name=3Dname@entry=3D0x555555dd6306 "realized", errp=3Derrp@entry=3D=
0x7fff7f931270) at qom/object.c:1102
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>



Applied to target-arm.next, thanks.

-- PMM
