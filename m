Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48CFCA9EB0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 22:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DAD2067D
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 22:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DAD2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iROPW-0000TV-PV
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 17:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iROOa-0008OU-To
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 17:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iROOZ-0005ff-Fm
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 17:30:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33436)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iROOZ-0005fD-7W
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 17:30:51 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B91ECC057E9A
 for <qemu-devel@nongnu.org>; Sun,  3 Nov 2019 22:30:49 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id b4so9265543wrn.8
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2019 14:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KQQyKeOCsUoauqsrdi5L6gCkHdjOkpi83Z9x3M99sr8=;
 b=kt6gXpR5erHnUZWKxdPCQmkq/+w6ayb/PhWeJMRzqKbzAinhVr0gP6mnqCAi9nE1HS
 OOv7Djr59edf1CXAGId4zAOwSmdWzPxKOYM8CGjJ2ssq/SrybNAt+IVuNlriG55zmQOw
 tsAsy1OKD6z0LPqcKx5XPgcBkPdHxSkLVtpfyTMPlq1B1jv69Pw+z0UesoIEJp1JJXMV
 ldSbcXSuay6botfZa/47hOv7/hYOpkHtQEUxYxYEGxRct8OjkoUT8XRWC8dEg1VMtsgJ
 pvQg8wOs2hB9gaq7lI4WuTWQ0eQOsyWEqcNnMH5whsx0d5F+HPos84HlfhCkl0JI6eKf
 E0Cw==
X-Gm-Message-State: APjAAAWhfcfvEMlRUXGrf4+QkZXAkdVLo5SL9Tcy2OgDNJjqYy9bQyW0
 VrwTU7NphhmufbvtbNj20LVSinqB4dyoHs2iHQq+556IulmbYYpjOpZ9zno3oWMRRCaKgz3zRov
 RrMDuFQnv6r1F1PI=
X-Received: by 2002:a5d:458d:: with SMTP id p13mr5187749wrq.181.1572820248420; 
 Sun, 03 Nov 2019 14:30:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7lEpu3xnnV0lgjgjyUJy+bHbV7e65VgPjIvIUK31XAWmVN+nb29OYbEPDdKTAzPvbYmXVrA==
X-Received: by 2002:a5d:458d:: with SMTP id p13mr5187737wrq.181.1572820248189; 
 Sun, 03 Nov 2019 14:30:48 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id z8sm10349828wrp.49.2019.11.03.14.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Nov 2019 14:30:47 -0800 (PST)
Subject: Re: [PATCH v2] q800: fix I/O memory map
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191102214209.26058-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6a200cd8-bb8f-d2b1-dc1f-247fb0870396@redhat.com>
Date: Sun, 3 Nov 2019 23:30:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191102214209.26058-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/19 10:42 PM, Laurent Vivier wrote:
> Linux kernel 5.4 will introduce a new memory map for SWIM device.
> (aee6bff1c325 ("m68k: mac: Revisit floppy disc controller base addresse=
s"))
>=20
> Until this release all MMIO are mapped between 0x50f00000 and 0x50f4000=
0,
> but it appears that for real hardware 0x50f00000 is not the base addres=
s:
> the MMIO region spans 0x50000000 through 0x60000000, and 0x50040000 thr=
ough
> 0x54000000 is repeated images of 0x50000000 to 0x50040000.
>=20
> Fixed: 04e7ca8d0f ("hw/m68k: define Macintosh Quadra 800")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>=20
> Notes:
>      v2: add some constant definitions
>          allocate a bloc of memory to stores all I/O MemoryRegion
>=20
>   hw/m68k/q800.c | 40 ++++++++++++++++++++++++++++++++--------
>   1 file changed, 32 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 2b4842f8c6..822bd13d36 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -60,14 +60,19 @@
>   #define MACH_MAC        3
>   #define Q800_MAC_CPU_ID 2
>  =20
> -#define VIA_BASE              0x50f00000
> -#define SONIC_PROM_BASE       0x50f08000
> -#define SONIC_BASE            0x50f0a000
> -#define SCC_BASE              0x50f0c020
> -#define ESP_BASE              0x50f10000
> -#define ESP_PDMA              0x50f10100
> -#define ASC_BASE              0x50F14000
> -#define SWIM_BASE             0x50F1E000
> +#define IO_BASE               0x50000000
> +#define IO_SLICE              0x00040000
> +#define IO_SIZE               0x04000000
> +
> +#define VIA_BASE              (IO_BASE + 0x00000)

Good idea.

> +#define SONIC_PROM_BASE       (IO_BASE + 0x08000)
> +#define SONIC_BASE            (IO_BASE + 0x0a000)
> +#define SCC_BASE              (IO_BASE + 0x0c020)
> +#define ESP_BASE              (IO_BASE + 0x10000)
> +#define ESP_PDMA              (IO_BASE + 0x10100)
> +#define ASC_BASE              (IO_BASE + 0x14000)
> +#define SWIM_BASE             (IO_BASE + 0x1E000)
> +
>   #define NUBUS_SUPER_SLOT_BASE 0x60000000
>   #define NUBUS_SLOT_BASE       0xf0000000
>  =20
> @@ -135,6 +140,9 @@ static void q800_init(MachineState *machine)
>       int32_t initrd_size;
>       MemoryRegion *rom;
>       MemoryRegion *ram;
> +    MemoryRegion *io;
> +    const int io_slice_nb =3D (IO_SIZE / IO_SLICE) - 1;
> +    int i;
>       ram_addr_t ram_size =3D machine->ram_size;
>       const char *kernel_filename =3D machine->kernel_filename;
>       const char *initrd_filename =3D machine->initrd_filename;
> @@ -163,10 +171,26 @@ static void q800_init(MachineState *machine)
>       cpu =3D M68K_CPU(cpu_create(machine->cpu_type));
>       qemu_register_reset(main_cpu_reset, cpu);
>  =20
> +    /* RAM */
>       ram =3D g_malloc(sizeof(*ram));
>       memory_region_init_ram(ram, NULL, "m68k_mac.ram", ram_size, &erro=
r_abort);
>       memory_region_add_subregion(get_system_memory(), 0, ram);
>  =20
> +    /*
> +     * Memory from IO_BASE to IO_BASE + IO_SLICE is repeated
> +     * from IO_BASE + IO_SLICE to IO_BASE + IO_SIZE
> +     */
> +    io =3D g_new(MemoryRegion, io_slice_nb);
> +    for (i =3D 0; i < io_slice_nb; i++) {
> +        char *name =3D g_strdup_printf("mac_m68k.io[%d]", i + 1);
> +
> +        memory_region_init_alias(io + i, NULL, name, get_system_memory=
(),

We usually use &io[i], anyway:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +                                 IO_BASE, IO_SLICE);
> +        memory_region_add_subregion(get_system_memory(),
> +                                    IO_BASE + (i + 1) * IO_SLICE, io +=
 i);
> +        g_free(name);
> +    }
> +
>       /* IRQ Glue */
>  =20
>       irq =3D g_new0(GLUEState, 1);
>=20

