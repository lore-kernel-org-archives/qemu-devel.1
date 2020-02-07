Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4453C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA2021741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA2021741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07mP-00059W-L9
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j07l4-0003Px-9y
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j07l2-0003Hj-7h
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:49:38 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:41467)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j07kx-0002pD-E6; Fri, 07 Feb 2020 12:49:31 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MOzKm-1jA7bx1o6e-00PLWJ; Fri, 07 Feb 2020 18:48:33 +0100
Subject: Re: [PATCH v4 2/3] hw: Make MachineClass::is_default a boolean type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200207161948.15972-1-philmd@redhat.com>
 <20200207161948.15972-3-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f17e7728-342a-1d52-b2f8-238b31013709@vivier.eu>
Date: Fri, 7 Feb 2020 18:48:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200207161948.15972-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eBBO4MQNvkrGp7J3o2rbNdqkkxrxHxNDSaXL7+8cioiqzb6VUzC
 ZGYUuVs0QavZ2wTGQ+pCxuZrPrA+Z93WNglBAehVj6Jk5hm1fg6JL5PVgw3AdnxXTRmgdUq
 BDBVdHerY17NFhmpMgB8Sq6CmIYbk6WiZdphafBzDBDrrLLEwWgz5Hd2rASPDcodhRkk4mT
 xc3l4DlSJ3lHTI3xdoNRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6YDcUkHd6Sw=:eqBUHkjiW1ltVkAFGYzfQz
 r6l3wF6GKVsxhCJw5xxTdttRF6pll/sSUUtd4ucHxyaBJl7Z/MMmi5kCaMNQA2j0hlSYMsxbr
 1nWnPP8dfHmarl8T4A2IPbKIoTNkEi987kqOga8Bj04VYE6dRL3wufThJJYDBGnR5S6ThTlaA
 Y4qZ8gWrkzQKyS+R8y2f8GsiuUPcHhoJpv/ii0XrlkSJwpl5eFd6TyXungo6J6RsNz4qaUEYY
 QdXQfzwrskS8mrDIknig7zZ/pONzyW5E8Tp4taQLUHLTaIkjPEmMOoFJCC1u+imMfdNtBGig8
 liyncI171s9lVG0kie6ODV1YVqQi8nNXntqpc+qaMe8fas047r/bqfpV++q8CKnztOaxMVG/9
 FnZk1Y6BrzW/t8li+LzzXZNe1ntDWW38wMhuUGPC5wos98kO1G3alsyWbSELOrh5T+5w3pUVo
 o92WshaibLVyUMVzZoVXtAR9J9RG1T/EecMOmPa3yb+3Fu7MWdzeExVxoaLrO/AlGdpvha/9F
 P1anj5A7tyJaGYzzQLRM1ogKdDq4fLXGMDRrD3/EYI2EVkjW7wWCaKLzMfTzWXe4Xa0zDMmBV
 l6tjhKK812eO+t+q2d9GEwAyz4nd59Svnkjux8BiOAzBqNnLD/Z4R95CJhS3h4BQM5zqPaVIP
 4Nw00b/xLTZF5yOreImvfdq1KK5RrXClnQA0XUeNLEHl4iw/udVFcV21GWlVTltA0dNd5gwNR
 hIGMPzqRwwqdywSyGISGwimb/Uw+mEsCeqEZtAFbIKknnYszDtvbistC8BnLnQSCZPpZTa1OI
 TlzzwoV78TPfno5NJ+X6Zmb5837y/qSjjw1M90098t1Zc+Xt4eO1engB3P9rYoT/NZHcv98
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 07/02/2020 à 17:19, Philippe Mathieu-Daudé a écrit :
> There's no good reason for it to be type int, change it to bool.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v4:
> - fixed incorrect changes to max_cpus (Laurent)
> - describe field
> ---
>  include/hw/boards.h                      |  4 +++-
>  hw/alpha/dp264.c                         |  2 +-
>  hw/cris/axis_dev88.c                     |  2 +-
>  hw/hppa/machine.c                        |  2 +-
>  hw/i386/pc_piix.c                        | 10 +++++-----
>  hw/lm32/lm32_boards.c                    |  2 +-
>  hw/m68k/mcf5208.c                        |  2 +-
>  hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
>  hw/mips/mips_malta.c                     |  2 +-
>  hw/moxie/moxiesim.c                      |  2 +-
>  hw/nios2/10m50_devboard.c                |  2 +-
>  hw/openrisc/openrisc_sim.c               |  2 +-
>  hw/ppc/mac_oldworld.c                    |  2 +-
>  hw/ppc/spapr.c                           |  2 +-
>  hw/riscv/spike.c                         |  2 +-
>  hw/s390x/s390-virtio-ccw.c               |  2 +-
>  hw/sh4/shix.c                            |  2 +-
>  hw/sparc/sun4m.c                         |  2 +-
>  hw/sparc64/sun4u.c                       |  2 +-
>  hw/unicore32/puv3.c                      |  2 +-
>  20 files changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index fb1b43d5b9..c3523a70e8 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -107,6 +107,8 @@ typedef struct {
>   * @max_cpus: maximum number of CPUs supported. Default: 1
>   * @min_cpus: minimum number of CPUs supported. Default: 1
>   * @default_cpus: number of CPUs instantiated if none are specified. Default: 1
> + * @is_default:
> + *    If true QEMU will use this machine by default if no '-M' option is given.
>   * @get_hotplug_handler: this function is called during bus-less
>   *    device hotplug. If defined it returns pointer to an instance
>   *    of HotplugHandler object, which handles hotplug operation
> @@ -200,7 +202,7 @@ struct MachineClass {
>          no_sdcard:1,
>          pci_allow_0_address:1,
>          legacy_fw_cfg_order:1;
> -    int is_default;
> +    bool is_default;
>      const char *default_machine_opts;
>      const char *default_boot_order;
>      const char *default_display;
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index a8f9a89cc4..083a198a64 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -181,7 +181,7 @@ static void clipper_machine_init(MachineClass *mc)
>      mc->init = clipper_init;
>      mc->block_default_type = IF_IDE;
>      mc->max_cpus = 4;
> -    mc->is_default = 1;
> +    mc->is_default = true;
>      mc->default_cpu_type = ALPHA_CPU_TYPE_NAME("ev67");
>  }
>  
> diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
> index be7760476a..de7b49188b 100644
> --- a/hw/cris/axis_dev88.c
> +++ b/hw/cris/axis_dev88.c
> @@ -349,7 +349,7 @@ static void axisdev88_machine_init(MachineClass *mc)
>  {
>      mc->desc = "AXIS devboard 88";
>      mc->init = axisdev88_init;
> -    mc->is_default = 1;
> +    mc->is_default = true;
>      mc->default_cpu_type = CRIS_CPU_TYPE_NAME("crisv32");
>  }
>  
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index d8755ec422..83ae87f565 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -295,7 +295,7 @@ static void machine_hppa_machine_init(MachineClass *mc)
>      mc->block_default_type = IF_SCSI;
>      mc->max_cpus = HPPA_MAX_CPUS;
>      mc->default_cpus = 1;
> -    mc->is_default = 1;
> +    mc->is_default = true;
>      mc->default_ram_size = 512 * MiB;
>      mc->default_boot_order = "cd";
>  }
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index fa12203079..9088db8fb6 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -423,7 +423,7 @@ static void pc_i440fx_5_0_machine_options(MachineClass *m)
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_i440fx_machine_options(m);
>      m->alias = "pc";
> -    m->is_default = 1;
> +    m->is_default = true;
>      pcmc->default_cpu_version = 1;
>  }
>  
> @@ -434,7 +434,7 @@ static void pc_i440fx_4_2_machine_options(MachineClass *m)
>  {
>      pc_i440fx_5_0_machine_options(m);
>      m->alias = NULL;
> -    m->is_default = 0;
> +    m->is_default = false;
>      compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>      compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
>  }
> @@ -446,7 +446,7 @@ static void pc_i440fx_4_1_machine_options(MachineClass *m)
>  {
>      pc_i440fx_4_2_machine_options(m);
>      m->alias = NULL;
> -    m->is_default = 0;
> +    m->is_default = false;
>      compat_props_add(m->compat_props, hw_compat_4_1, hw_compat_4_1_len);
>      compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
>  }
> @@ -459,7 +459,7 @@ static void pc_i440fx_4_0_machine_options(MachineClass *m)
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_i440fx_4_1_machine_options(m);
>      m->alias = NULL;
> -    m->is_default = 0;
> +    m->is_default = false;
>      pcmc->default_cpu_version = CPU_VERSION_LEGACY;
>      compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
>      compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
> @@ -473,7 +473,7 @@ static void pc_i440fx_3_1_machine_options(MachineClass *m)
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>  
>      pc_i440fx_4_0_machine_options(m);
> -    m->is_default = 0;
> +    m->is_default = false;
>      pcmc->do_not_add_smb_acpi = true;
>      m->smbus_no_migration_support = true;
>      m->alias = NULL;
> diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
> index 156b050abc..352f69532e 100644
> --- a/hw/lm32/lm32_boards.c
> +++ b/hw/lm32/lm32_boards.c
> @@ -286,7 +286,7 @@ static void lm32_evr_class_init(ObjectClass *oc, void *data)
>  
>      mc->desc = "LatticeMico32 EVR32 eval system";
>      mc->init = lm32_evr_init;
> -    mc->is_default = 1;
> +    mc->is_default = true;
>      mc->default_cpu_type = LM32_CPU_TYPE_NAME("lm32-full");
>  }
>  
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index a999c21982..5f8f6e4475 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -352,7 +352,7 @@ static void mcf5208evb_machine_init(MachineClass *mc)
>  {
>      mc->desc = "MCF5208EVB";
>      mc->init = mcf5208evb_init;
> -    mc->is_default = 1;
> +    mc->is_default = true;
>      mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5208");
>  }
>  
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> index 849bafc186..0bb6cdea8d 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -132,7 +132,7 @@ static void petalogix_s3adsp1800_machine_init(MachineClass *mc)
>  {
>      mc->desc = "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
>      mc->init = petalogix_s3adsp1800_init;
> -    mc->is_default = 1;
> +    mc->is_default = true;
>  }
>  
>  DEFINE_MACHINE("petalogix-s3adsp1800", petalogix_s3adsp1800_machine_init)
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 34b76bb6a1..499eac8d33 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1442,7 +1442,7 @@ static void mips_malta_machine_init(MachineClass *mc)
>      mc->init = mips_malta_init;
>      mc->block_default_type = IF_IDE;
>      mc->max_cpus = 16;
> -    mc->is_default = 1;
> +    mc->is_default = true;
>  #ifdef TARGET_MIPS64
>      mc->default_cpu_type = MIPS_CPU_TYPE_NAME("20Kc");
>  #else
> diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
> index 1d06e39fcb..51a98287b5 100644
> --- a/hw/moxie/moxiesim.c
> +++ b/hw/moxie/moxiesim.c
> @@ -150,7 +150,7 @@ static void moxiesim_machine_init(MachineClass *mc)
>  {
>      mc->desc = "Moxie simulator platform";
>      mc->init = moxiesim_init;
> -    mc->is_default = 1;
> +    mc->is_default = true;
>      mc->default_cpu_type = MOXIE_CPU_TYPE_NAME("MoxieLite");
>  }
>  
> diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
> index ad8b2fc670..33dc2bf511 100644
> --- a/hw/nios2/10m50_devboard.c
> +++ b/hw/nios2/10m50_devboard.c
> @@ -120,7 +120,7 @@ static void nios2_10m50_ghrd_machine_init(struct MachineClass *mc)
>  {
>      mc->desc = "Altera 10M50 GHRD Nios II design";
>      mc->init = nios2_10m50_ghrd_init;
> -    mc->is_default = 1;
> +    mc->is_default = true;
>  }
>  
>  DEFINE_MACHINE("10m50-ghrd", nios2_10m50_ghrd_machine_init);
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index ad5371250f..d08ce61811 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -176,7 +176,7 @@ static void openrisc_sim_machine_init(MachineClass *mc)
>      mc->desc = "or1k simulation";
>      mc->init = openrisc_sim_init;
>      mc->max_cpus = 2;
> -    mc->is_default = 1;
> +    mc->is_default = true;
>      mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
>  }
>  
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 7318d7e9b4..1630663bc2 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -438,7 +438,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
>      mc->block_default_type = IF_IDE;
>      mc->max_cpus = MAX_CPUS;
>  #ifndef TARGET_PPC64
> -    mc->is_default = 1;
> +    mc->is_default = true;
>  #endif
>      /* TOFIX "cad" when Mac floppy is implemented */
>      mc->default_boot_order = "cd";
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c9b2e0a5e0..e3e3208cd8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4493,7 +4493,7 @@ static const TypeInfo spapr_machine_info = {
>          spapr_machine_##suffix##_class_options(mc);                  \
>          if (latest) {                                                \
>              mc->alias = "pseries";                                   \
> -            mc->is_default = 1;                                      \
> +            mc->is_default = true;                                   \
>          }                                                            \
>      }                                                                \
>      static const TypeInfo spapr_machine_##suffix##_info = {          \
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 8823681783..6f03857660 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -448,7 +448,7 @@ static void spike_machine_init(MachineClass *mc)
>      mc->desc = "RISC-V Spike Board";
>      mc->init = spike_board_init;
>      mc->max_cpus = 1;
> -    mc->is_default = 1;
> +    mc->is_default = true;
>      mc->default_cpu_type = SPIKE_V1_10_0_CPU;
>  }
>  
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index e759eb5f83..c4b291e434 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -631,7 +631,7 @@ bool css_migration_enabled(void)
>          mc->desc = "VirtIO-ccw based S390 machine v" verstr;                  \
>          if (latest) {                                                         \
>              mc->alias = "s390-ccw-virtio";                                    \
> -            mc->is_default = 1;                                               \
> +            mc->is_default = true;                                            \
>          }                                                                     \
>      }                                                                         \
>      static void ccw_machine_##suffix##_instance_init(Object *obj)             \
> diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
> index 2fc2915428..68b14ee5e7 100644
> --- a/hw/sh4/shix.c
> +++ b/hw/sh4/shix.c
> @@ -82,7 +82,7 @@ static void shix_machine_init(MachineClass *mc)
>  {
>      mc->desc = "shix card";
>      mc->init = shix_init;
> -    mc->is_default = 1;
> +    mc->is_default = true;
>      mc->default_cpu_type = TYPE_SH7750R_CPU;
>  }
>  
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 25e96db5ca..d6c9772f95 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -1411,7 +1411,7 @@ static void ss5_class_init(ObjectClass *oc, void *data)
>      mc->desc = "Sun4m platform, SPARCstation 5";
>      mc->init = ss5_init;
>      mc->block_default_type = IF_SCSI;
> -    mc->is_default = 1;
> +    mc->is_default = true;
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
>      mc->default_display = "tcx";
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index b7ac42f7a5..d33e84f831 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -816,7 +816,7 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
>      mc->init = sun4u_init;
>      mc->block_default_type = IF_IDE;
>      mc->max_cpus = 1; /* XXX for now */
> -    mc->is_default = 1;
> +    mc->is_default = true;
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-UltraSparc-IIi");
>      mc->ignore_boot_device_suffixes = true;
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index 7e933de228..7f9c0238fe 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -140,7 +140,7 @@ static void puv3_machine_init(MachineClass *mc)
>  {
>      mc->desc = "PKUnity Version-3 based on UniCore32";
>      mc->init = puv3_init;
> -    mc->is_default = 1;
> +    mc->is_default = true;
>      mc->default_cpu_type = UNICORE32_CPU_TYPE_NAME("UniCore-II");
>  }
>  
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

