Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5843CA9ECB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 00:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9812086D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 00:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9812086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQKNi-0001gl-S8
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 20:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iQKMh-0001AY-6A
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 20:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iQKMZ-0002US-SA
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 20:00:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iQKMZ-0002PJ-5G
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 20:00:23 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1D14385A07
 for <qemu-devel@nongnu.org>; Fri,  1 Nov 2019 00:00:21 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id m17so4462223wrb.20
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 17:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yTQrLhRRDKlEcNLTfUQI0lgXMQ6dDnDgFG10jSP8D2E=;
 b=q1V7D4wNbJIc9mstrrPApZOmLv9unlYGgej/RLcMMN/r4C+n0o9Lx6un5dqB1SN28J
 ZhxnkKu0FOa/QKq4xhiJiKYcL2KYRn5h/VQdu6CYMIWZCp+3gYDLk+fuJG0NIYUwn/CK
 9lkvufo7gikiJ25xYGTVJWeTk6z0Cg4iyFiNCJApJSwveb0T+97I1yTFjX1PauF+gMFu
 WqiDg6IKHVvLsvamtBy8sNtoJx4zo1Vavdsmy2hKzUTXqeCqyS3dMKEfSOD7YqRYfqJQ
 zd0gmelhvfeCpbOtm0JbFMjwSIiyQ03n11ZUHdj7pdHAwb6C5dAo7kdEAchRaDWPyWrH
 wbkg==
X-Gm-Message-State: APjAAAWI83Cr1M54A3scyHP7mjazcGS0UCGBJuYbGLxwMr0Oymbhm+ZS
 0JdHRw7w+uhEupRjlGsiLDmX9mIy/2T7bMQ7A9LOeb+2XLOTK7QOmRFMd14wQyE6Rgt0g2mzZma
 7ffkMfn4ogRpMso8=
X-Received: by 2002:a1c:544b:: with SMTP id p11mr7829996wmi.46.1572566419843; 
 Thu, 31 Oct 2019 17:00:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwCicbxlS/iKaciaCn09ABRL8p68A80MV5Qv1ETrkSyiUItREWxS5jJGDnU6Sql36SAl19nWA==
X-Received: by 2002:a1c:544b:: with SMTP id p11mr7829986wmi.46.1572566419628; 
 Thu, 31 Oct 2019 17:00:19 -0700 (PDT)
Received: from [192.168.20.58] (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id b4sm5221869wrh.87.2019.10.31.17.00.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2019 17:00:19 -0700 (PDT)
Subject: Re: [RFC] q800: fix I/O memory map
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191031100341.3827-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bf1a2cbf-f462-e6df-c7c1-1e2ad26003ad@redhat.com>
Date: Fri, 1 Nov 2019 01:00:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191031100341.3827-1-laurent@vivier.eu>
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

On 10/31/19 11:03 AM, Laurent Vivier wrote:
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
>   hw/m68k/q800.c | 33 +++++++++++++++++++++++++--------
>   1 file changed, 25 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 2b4842f8c6..8122e7c612 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -60,14 +60,14 @@
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
> +#define VIA_BASE              0x50000000
> +#define SONIC_PROM_BASE       0x50008000
> +#define SONIC_BASE            0x5000a000
> +#define SCC_BASE              0x5000c020
> +#define ESP_BASE              0x50010000
> +#define ESP_PDMA              0x50010100
> +#define ASC_BASE              0x50014000
> +#define SWIM_BASE             0x5001E000
>   #define NUBUS_SUPER_SLOT_BASE 0x60000000
>   #define NUBUS_SLOT_BASE       0xf0000000
>  =20
> @@ -135,6 +135,7 @@ static void q800_init(MachineState *machine)
>       int32_t initrd_size;
>       MemoryRegion *rom;
>       MemoryRegion *ram;
> +    int i;
>       ram_addr_t ram_size =3D machine->ram_size;
>       const char *kernel_filename =3D machine->kernel_filename;
>       const char *initrd_filename =3D machine->initrd_filename;
> @@ -163,10 +164,26 @@ static void q800_init(MachineState *machine)
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
> +     * Memory from VIA_BASE to VIA_BASE + 0x40000 is repeated
> +     * from VIA_BASE + 0x40000 to VIA_BASE + 0x4000000
> +     */

Maybe:

        const size_t via_aliases_count =3D (0x4000000 / 0x40000) - 1;
        MemoryRegion *via_alias =3D g_new(MemoryRegion, via_aliases_count=
);
        for (size_t i =3D 0; i < via_aliases_count; i++) {

            ...

            memory_region_add_subregion(get_system_memory(),
                                        VIA_BASE + (i + 1) * 0x40000,
                                        via_alias[i]);
            ...
        }

> +    for (i =3D 1; i < 256; i++) {
> +        MemoryRegion *io =3D g_malloc(sizeof(*io));
> +        char *name =3D g_strdup_printf("mac_m68k.io[%d]", i);
> +
> +        memory_region_init_alias(io, NULL, name, get_system_memory(),
> +                                 VIA_BASE, 0x40000);
> +        memory_region_add_subregion(get_system_memory(),
> +                                    VIA_BASE + i * 0x40000, io);
> +        g_free(name);
> +    }

I'm trying to get ride of this pattern, so I plan to refactor this later=20
(and will use 256*KiB). Anyway not this patch problem.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +
>       /* IRQ Glue */
>  =20
>       irq =3D g_new0(GLUEState, 1);
>=20

