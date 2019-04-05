Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B72DC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 04:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3965E2184B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 04:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3965E2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36038 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCGq0-00043i-Lj
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 00:52:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hCGpG-0003YV-GZ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 00:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hCGpF-0003wj-0d
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 00:51:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hCGpE-0003qR-Lm
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 00:51:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6EC61F74BC;
	Fri,  5 Apr 2019 04:51:34 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-62.ams2.redhat.com [10.36.116.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E61F19C58;
	Fri,  5 Apr 2019 04:51:25 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190404221238.12468-1-philmd@redhat.com>
	<20190404221238.12468-5-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <bb4e3258-9036-e487-81b4-8bc5eff24158@redhat.com>
Date: Fri, 5 Apr 2019 06:51:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404221238.12468-5-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 05 Apr 2019 04:51:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1 4/4] hw/mips/r4k: Refactor the
 Super I/O chipset
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405045125.6NR7_lAQKW1uSoP5ylRLqlwZ8WaL2TCPuvey3xSZpME@z>

On 05/04/2019 00.12, Philippe Mathieu-Daud=C3=A9 wrote:
> ISA Super I/O are already modeled by the ISASuperIODevice abstract
> device.
> Since this board uses a generic ISA Super I/O chipset, refactor it
> as the TYPE_R4K_SUPERIO device, child of ISASuperIODevice.

Good idea!

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/mips/mips_r4k.c | 61 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 93dbf76bb49..b51a9523b43 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -18,6 +18,7 @@
>  #include "hw/i386/pc.h"
>  #include "hw/char/serial.h"
>  #include "hw/isa/isa.h"
> +#include "hw/isa/superio.h"
>  #include "net/net.h"
>  #include "hw/net/ne2000-isa.h"
>  #include "sysemu/sysemu.h"
> @@ -29,7 +30,6 @@
>  #include "hw/loader.h"
>  #include "elf.h"
>  #include "hw/timer/mc146818rtc.h"
> -#include "hw/input/i8042.h"
>  #include "hw/timer/i8254.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/qtest.h"
> @@ -37,10 +37,6 @@
> =20
>  #define MAX_IDE_BUS 2
> =20
> -static const int ide_iobase[2] =3D { 0x1f0, 0x170 };
> -static const int ide_iobase2[2] =3D { 0x3f6, 0x376 };
> -static const int ide_irq[2] =3D { 14, 15 };
> -
>  static ISADevice *pit; /* PIT i8254 */
> =20
>  /* i8254 PIT is attached to the IRQ0 at PIC i8259 */
> @@ -73,6 +69,49 @@ static const MemoryRegionOps mips_qemu_ops =3D {
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>  };
> =20
> +#define TYPE_R4K_SUPERIO "r4k-superio"
> +
> +static uint16_t get_ide_iobase(ISASuperIODevice *sio, uint8_t index)
> +{
> +    static const uint16_t ide_iobase[] =3D { 0x1f0, 0x3f6, 0x170, 0x37=
6 };
> +
> +    return ide_iobase[index];
> +}
> +
> +static unsigned int get_ide_irq(ISASuperIODevice *sio, uint8_t index)
> +{
> +    return index < MAX_IDE_DEVS ? 14 : 15;
> +}
> +
> +static void r4k_superio_class_init(ObjectClass *klass, void *data)
> +{
> +    ISASuperIOClass *sc =3D ISA_SUPERIO_CLASS(klass);
> +
> +    sc->serial.count =3D MAX_ISA_SERIAL_PORTS;
> +    sc->parallel.count =3D 0;
> +    sc->floppy.count =3D 0;
> +    sc->ide =3D (ISASuperIOFuncs){
> +        .count =3D MAX_IDE_BUS * MAX_IDE_DEVS,
> +        .get_iobase =3D get_ide_iobase,
> +        .get_irq    =3D get_ide_irq,
> +    };
> +}
> +
> +static const TypeInfo r4k_superio_type_info =3D {
> +    .name          =3D TYPE_R4K_SUPERIO,
> +    .parent        =3D TYPE_ISA_SUPERIO,
> +    .instance_size =3D sizeof(ISASuperIODevice),
> +    .class_size    =3D sizeof(ISASuperIOClass),
> +    .class_init    =3D r4k_superio_class_init,
> +};
> +
> +static void r4k_superio_register_types(void)
> +{
> +    type_register_static(&r4k_superio_type_info);
> +}
> +
> +type_init(r4k_superio_register_types)
> +
>  typedef struct ResetData {
>      MIPSCPU *cpu;
>      uint64_t vector;
> @@ -179,10 +218,8 @@ void mips_r4k_init(MachineState *machine)
>      MIPSCPU *cpu;
>      CPUMIPSState *env;
>      ResetData *reset_info;
> -    int i;
>      qemu_irq *i8259;
>      ISABus *isa_bus;
> -    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>      DriveInfo *dinfo;
>      int be;
> =20
> @@ -274,20 +311,12 @@ void mips_r4k_init(MachineState *machine)
> =20
>      pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
> =20
> -    serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
> -
>      isa_vga_init(isa_bus);
> =20
>      if (nd_table[0].used)
>          isa_ne2000_init(isa_bus, 0x300, 9, &nd_table[0]);
> =20
> -    ide_drive_get(hd, ARRAY_SIZE(hd));
> -    for(i =3D 0; i < MAX_IDE_BUS; i++)
> -        isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i], ide_irq[i=
],
> -                     hd[MAX_IDE_DEVS * i],
> -                     hd[MAX_IDE_DEVS * i + 1]);
> -
> -    isa_create_simple(isa_bus, TYPE_I8042);
> +    isa_create_simple(isa_bus, TYPE_R4K_SUPERIO);

What about the ide_drive_get() and the ide_create_drive() that is done
by isa_ide_init() internally? As far as I can see, the superio code does
not do this job for you? So don't you have to do that manually here
after creating the R4K_SUPERIO device?

 Thomas

