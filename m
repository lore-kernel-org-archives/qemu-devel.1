Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E68C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB7D2084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKszL8lN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB7D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXHX-0007YH-UA
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdXGw-0006xe-Hv
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:57:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdXGt-0003Nu-Pn
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:57:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id n5so2785738wmd.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2pd6DbzTsFcN4VgAv7+uDIg0TpQmDa6kxg2Yz1BZ3WM=;
 b=hKszL8lNYdYUOxxOGvZ2PQhvqHF1BnYGEZqEgfNIgyWSpnIt8i1hB0dqfbNgHzgUS0
 LrjsckKVg77XeyDVi3uZJ8x5ZT3xloe+HtvCXgSnynq/yk/DkAQgoYU6TNG5yGG1DFHI
 Qb2KkZ76XOrw6xfZRHAN73eKM5IO5iUN69wYbs9vQn+BMjqJ+oOmkLOtcY58MEtNYWJb
 QBlbehOfjitEw0DSWtG9sNEW9n3GS40ld2fXGvXbxxHv7eNWC7I+m+rkQAIK8Ba9i84F
 tO7pYlh4M7GeDULs3UoOVp671cBV6ELHZuWW/TofojWw2vSW9RMrpq7kOMy1VA7GoiEW
 3jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2pd6DbzTsFcN4VgAv7+uDIg0TpQmDa6kxg2Yz1BZ3WM=;
 b=Bk09LTGk1VrswkmdXgBHxb03usQQIMTgAFB1U/YLhBZrU6p14177siWBpj8W1rrnBQ
 yxfO5GdageMmrCPd0OPPmfQAaZDN3Q/wSl3N8ZiJKoqBsl3HTl85C1yiPyvfnjbK6bP9
 JgMTxeumMa3vuzFS+zPiUjZ239t01zE3T9iCgXooXwl3d8WTiWf0vWFNbHpHIgsLB2jM
 kZedDYHWP3cyBtH/+fm2na4d9dR9e7CHHhQoyH5NIDem17FtttQ11rHCmUdJcqAzyuSF
 rKm2Bux8OHShUAz1/XF2yxf2p0SANsQPRDP9EcRSjHz6TskussHBwxfS6IIyGqSJG4aQ
 c6Fw==
X-Gm-Message-State: AOAM532xPgIS/CthHKw8RM+R9p5r3EOxonX/95OART/uHlE2cbqXLIVK
 IjH3r+vZpdTsNsCIAx9UBQ2TTVJ1AG9JXnmA+hI=
X-Google-Smtp-Source: ABdhPJwEphzWH/FXtXUcweIsDHtP1U5AKods2VSCSPsrzHivAgktzJVQyfa+3EpUX5Hhe2gTBpg1O6J9BnMiX2D+Dzo=
X-Received: by 2002:a1c:18e:: with SMTP id 136mr793458wmb.159.1590490642149;
 Tue, 26 May 2020 03:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200526104726.11273-1-f4bug@amsat.org>
 <20200526104726.11273-11-f4bug@amsat.org>
In-Reply-To: <20200526104726.11273-11-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 26 May 2020 12:57:08 +0200
Message-ID: <CAHiYmc7wBy6PiM=9Ex_fdtwLfceDCHqR1nF=dtS6Onj_8B=2mg@mail.gmail.com>
Subject: Re: [PATCH 10/14] hw/mips/fuloong2e: Fix typo in Fuloong machine name
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <chenhc@lemote.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:47 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> We always miswrote the Fuloong machine... Fix its name.
> Add an machine alias to the previous name for backward
> compatibility.
>
> Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Message-id: <20200510210128.18343-5-f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---


Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>  docs/system/deprecated.rst               |  5 +++
>  docs/system/target-mips.rst              |  2 +-
>  default-configs/mips64el-softmmu.mak     |  2 +-
>  hw/isa/vt82c686.c                        |  2 +-
>  hw/mips/{mips_fulong2e.c =3D> fuloong2e.c} | 41 ++++++++++++------------
>  hw/pci-host/bonito.c                     |  8 ++---
>  tests/qtest/endianness-test.c            |  2 +-
>  MAINTAINERS                              |  4 +--
>  hw/mips/Kconfig                          |  2 +-
>  hw/mips/Makefile.objs                    |  2 +-
>  10 files changed, 38 insertions(+), 32 deletions(-)
>  rename hw/mips/{mips_fulong2e.c =3D> fuloong2e.c} (91%)
>
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 3142fac386..f0061f94aa 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -368,6 +368,11 @@ mips ``r4k`` platform (since 5.0)
>  This machine type is very old and unmaintained. Users should use the ``m=
alta``
>  machine type instead.
>
> +mips ``fulong2e`` machine (since 5.1)
> +'''''''''''''''''''''''''''''''''''''
> +
> +This machine has been renamed ``fuloong2e``.
> +
>  ``pc-1.0``, ``pc-1.1``, ``pc-1.2`` and ``pc-1.3`` (since 5.0)
>  '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>
> diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
> index 2736fd0509..cd2a931edf 100644
> --- a/docs/system/target-mips.rst
> +++ b/docs/system/target-mips.rst
> @@ -74,7 +74,7 @@ The MIPS Magnum R4000 emulation supports:
>
>  -  G364 framebuffer
>
> -The Fulong 2E emulation supports:
> +The Fuloong 2E emulation supports:
>
>  -  Loongson 2E CPU
>
> diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips6=
4el-softmmu.mak
> index 8b0c9b1e15..9f8a3ef156 100644
> --- a/default-configs/mips64el-softmmu.mak
> +++ b/default-configs/mips64el-softmmu.mak
> @@ -2,7 +2,7 @@
>
>  include mips-softmmu-common.mak
>  CONFIG_IDE_VIA=3Dy
> -CONFIG_FULONG=3Dy
> +CONFIG_FULOONG=3Dy
>  CONFIG_ATI_VGA=3Dy
>  CONFIG_RTL8139_PCI=3Dy
>  CONFIG_JAZZ=3Dy
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index d9b51fce8d..fac4e56b7d 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -503,7 +503,7 @@ static void via_class_init(ObjectClass *klass, void *=
data)
>      dc->vmsd =3D &vmstate_via;
>      /*
>       * Reason: part of VIA VT82C686 southbridge, needs to be wired up,
> -     * e.g. by mips_fulong2e_init()
> +     * e.g. by mips_fuloong2e_init()
>       */
>      dc->user_creatable =3D false;
>  }
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/fuloong2e.c
> similarity index 91%
> rename from hw/mips/mips_fulong2e.c
> rename to hw/mips/fuloong2e.c
> index 6996f5e3d1..f583c44b79 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/fuloong2e.c
> @@ -1,5 +1,5 @@
>  /*
> - * QEMU fulong 2e mini pc support
> + * QEMU fuloong 2e mini pc support
>   *
>   * Copyright (c) 2008 yajin (yajin@vm-kernel.org)
>   * Copyright (c) 2009 chenming (chenming@rdc.faw.com.cn)
> @@ -11,8 +11,8 @@
>   */
>
>  /*
> - * Fulong 2e mini pc is based on ICT/ST Loongson 2e CPU (MIPS III like, =
800MHz)
> - * http://www.linux-mips.org/wiki/Fulong
> + * Fuloong 2e mini pc is based on ICT/ST Loongson 2e CPU (MIPS III like,=
 800MHz)
> + * https://www.linux-mips.org/wiki/Fuloong_2E
>   *
>   * Loongson 2e user manual:
>   * http://www.loongsondeveloper.com/doc/Loongson2EUserGuide.pdf
> @@ -45,13 +45,13 @@
>  #include "sysemu/reset.h"
>  #include "qemu/error-report.h"
>
> -#define DEBUG_FULONG2E_INIT
> +#define DEBUG_FULOONG2E_INIT
>
>  #define ENVP_ADDR               0x80002000l
>  #define ENVP_NB_ENTRIES         16
>  #define ENVP_ENTRY_SIZE         256
>
> -/* fulong 2e has a 512k flash: Winbond W39L040AP70Z */
> +/* Fuloong 2e has a 512k flash: Winbond W39L040AP70Z */
>  #define BIOS_SIZE               (512 * KiB)
>  #define MAX_IDE_BUS             2
>
> @@ -68,12 +68,12 @@
>   * 2, use "Bonito2edev" to replace "dir_corresponding_to_your_target_har=
dware"
>   * in the "Compile Guide".
>   */
> -#define FULONG_BIOSNAME "pmon_fulong2e.bin"
> +#define FULOONG_BIOSNAME "pmon_2e.bin"
>
> -/* PCI SLOT in fulong 2e */
> -#define FULONG2E_VIA_SLOT        5
> -#define FULONG2E_ATI_SLOT        6
> -#define FULONG2E_RTL8139_SLOT    7
> +/* PCI SLOT in Fuloong 2e */
> +#define FULOONG2E_VIA_SLOT        5
> +#define FULOONG2E_ATI_SLOT        6
> +#define FULOONG2E_RTL8139_SLOT    7
>
>  static struct _loaderparams {
>      int ram_size;
> @@ -278,7 +278,7 @@ static void network_init(PCIBus *pci_bus)
>          const char *default_devaddr =3D NULL;
>
>          if (i =3D=3D 0 && (!nd->model || strcmp(nd->model, "rtl8139") =
=3D=3D 0)) {
> -            /* The fulong board has a RTL8139 card using PCI SLOT 7 */
> +            /* The Fuloong board has a RTL8139 card using PCI SLOT 7 */
>              default_devaddr =3D "07";
>          }
>
> @@ -286,7 +286,7 @@ static void network_init(PCIBus *pci_bus)
>      }
>  }
>
> -static void mips_fulong2e_init(MachineState *machine)
> +static void mips_fuloong2e_init(MachineState *machine)
>  {
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *kernel_cmdline =3D machine->kernel_cmdline;
> @@ -318,7 +318,7 @@ static void mips_fulong2e_init(MachineState *machine)
>      memory_region_add_subregion(address_space_mem, 0, machine->ram);
>
>      /* Boot ROM */
> -    memory_region_init_rom(bios, NULL, "fulong2e.bios", BIOS_SIZE,
> +    memory_region_init_rom(bios, NULL, "fuloong2e.bios", BIOS_SIZE,
>                             &error_fatal);
>      memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
>
> @@ -336,7 +336,7 @@ static void mips_fulong2e_init(MachineState *machine)
>          write_bootloader(env, memory_region_get_ram_ptr(bios), kernel_en=
try);
>      } else {
>          if (bios_name =3D=3D NULL) {
> -                bios_name =3D FULONG_BIOSNAME;
> +                bios_name =3D FULOONG_BIOSNAME;
>          }
>          filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>          if (filename) {
> @@ -362,7 +362,7 @@ static void mips_fulong2e_init(MachineState *machine)
>      pci_bus =3D bonito_init((qemu_irq *)&(env->irq[2]));
>
>      /* South bridge -> IP5 */
> -    vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
> +    vt82c686b_southbridge_init(pci_bus, FULOONG2E_VIA_SLOT, env->irq[5],
>                                 &smbus, &isa_bus);
>
>      /* GPU */
> @@ -383,14 +383,15 @@ static void mips_fulong2e_init(MachineState *machin=
e)
>      network_init(pci_bus);
>  }
>
> -static void mips_fulong2e_machine_init(MachineClass *mc)
> +static void mips_fuloong2e_machine_init(MachineClass *mc)
>  {
> -    mc->desc =3D "Fulong 2e mini pc";
> -    mc->init =3D mips_fulong2e_init;
> +    mc->desc =3D "Fuloong 2e mini pc";
> +    mc->alias =3D "fulong2e";             /* Incorrect name used up to Q=
EMU 4.2 */
> +    mc->init =3D mips_fuloong2e_init;
>      mc->block_default_type =3D IF_IDE;
>      mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-2E");
>      mc->default_ram_size =3D 256 * MiB;
> -    mc->default_ram_id =3D "fulong2e.ram";
> +    mc->default_ram_id =3D "fuloong2e.ram";
>  }
>
> -DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
> +DEFINE_MACHINE("fuloong2e", mips_fuloong2e_machine_init)
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index d0201ce59e..f9697dcc43 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -11,7 +11,7 @@
>   */
>
>  /*
> - * fulong 2e mini pc has a bonito north bridge.
> + * fuloong 2e mini pc has a bonito north bridge.
>   */
>
>  /*
> @@ -573,11 +573,11 @@ static int pci_bonito_map_irq(PCIDevice *pci_dev, i=
nt irq_num)
>      slot =3D (pci_dev->devfn >> 3);
>
>      switch (slot) {
> -    case 5:   /* FULONG2E_VIA_SLOT, SouthBridge, IDE, USB, ACPI, AC97, M=
C97 */
> +    case 5:   /* FULOONG2E_VIA_SLOT, SouthBridge, IDE, USB, ACPI, AC97, =
MC97 */
>          return irq_num % 4 + BONITO_IRQ_BASE;
> -    case 6:   /* FULONG2E_ATI_SLOT, VGA */
> +    case 6:   /* FULOONG2E_ATI_SLOT, VGA */
>          return 4 + BONITO_IRQ_BASE;
> -    case 7:   /* FULONG2E_RTL_SLOT, RTL8139 */
> +    case 7:   /* FULOONG2E_RTL_SLOT, RTL8139 */
>          return 5 + BONITO_IRQ_BASE;
>      case 8 ... 12: /* PCI slot 1 to 4 */
>          return (slot - 8 + irq_num) + 6 + BONITO_IRQ_BASE;
> diff --git a/tests/qtest/endianness-test.c b/tests/qtest/endianness-test.=
c
> index 2798802c63..cc088ac01a 100644
> --- a/tests/qtest/endianness-test.c
> +++ b/tests/qtest/endianness-test.c
> @@ -33,7 +33,7 @@ static const TestCase test_cases[] =3D {
>      { "mips64", "pica61", 0x90000000, .bswap =3D true },
>      { "mips64", "mips", 0x14000000, .bswap =3D true },
>      { "mips64", "malta", 0x10000000, .bswap =3D true },
> -    { "mips64el", "fulong2e", 0x1fd00000 },
> +    { "mips64el", "fuloong2e", 0x1fd00000 },
>      { "ppc", "g3beige", 0xfe000000, .bswap =3D true, .superio =3D "i8237=
8" },
>      { "ppc", "40p", 0x80000000, .bswap =3D true },
>      { "ppc", "bamboo", 0xe8000000, .bswap =3D true, .superio =3D "i82378=
" },
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f597aae12..8136a0e56c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1081,13 +1081,13 @@ R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com=
>
>  S: Obsolete
>  F: hw/mips/mips_r4k.c
>
> -Fulong 2E
> +Fuloong 2E
>  M: Huacai Chen <chenhc@lemote.com>
>  M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  S: Odd Fixes
> -F: hw/mips/mips_fulong2e.c
> +F: hw/mips/fuloong2e.c
>  F: hw/isa/vt82c686.c
>  F: hw/pci-host/bonito.c
>  F: include/hw/isa/vt82c686.h
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index 2240504dff..67d39c56a4 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -41,7 +41,7 @@ config JAZZ
>      select DS1225Y
>      select JAZZ_LED
>
> -config FULONG
> +config FULOONG
>      bool
>      select PCI_BONITO
>
> diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
> index 525809af07..8ab41edc3f 100644
> --- a/hw/mips/Makefile.objs
> +++ b/hw/mips/Makefile.objs
> @@ -3,6 +3,6 @@ obj-$(CONFIG_R4K) +=3D mips_r4k.o
>  obj-$(CONFIG_MALTA) +=3D gt64xxx_pci.o mips_malta.o
>  obj-$(CONFIG_MIPSSIM) +=3D mips_mipssim.o
>  obj-$(CONFIG_JAZZ) +=3D mips_jazz.o
> -obj-$(CONFIG_FULONG) +=3D mips_fulong2e.o
> +obj-$(CONFIG_FULOONG) +=3D fuloong2e.o
>  obj-$(CONFIG_MIPS_CPS) +=3D cps.o
>  obj-$(CONFIG_MIPS_BOSTON) +=3D boston.o
> --
> 2.21.3
>

