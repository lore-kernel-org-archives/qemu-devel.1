Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218F5C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 21:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FD321D43
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 21:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FD321D43
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLC9Q-0000zY-1l
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 17:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kLC7L-0008W4-K4; Wed, 23 Sep 2020 17:15:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:46143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kLC7H-00040y-J4; Wed, 23 Sep 2020 17:15:58 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1BF0174633F;
 Wed, 23 Sep 2020 23:15:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A9F5A74632C; Wed, 23 Sep 2020 23:15:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A80BC746307;
 Wed, 23 Sep 2020 23:15:42 +0200 (CEST)
Date: Wed, 23 Sep 2020 23:15:42 +0200 (CEST)
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] load_elf: Remove unused address variables from callers
In-Reply-To: <alpine.BSF.2.22.395.2007072050210.70758@zero.eik.bme.hu>
Message-ID: <86fbf276-bbd6-1481-4387-34dd1a6c0b2@eik.bme.hu>
References: <20200705174020.BDD0174633F@zero.eik.bme.hu>
 <CAKmqyKPJDiSYvcw5-7_t4uNrXuzeqfX0jnvu-hHc1DxeekB=2w@mail.gmail.com>
 <alpine.BSF.2.22.395.2007072050210.70758@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Marek Vasut <marex@denx.de>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, "open list:New World" <qemu-ppc@nongnu.org>,
 Huacai Chen <chenhc@lemote.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Tue, 7 Jul 2020, BALATON Zoltan wrote:
> On Tue, 7 Jul 2020, Alistair Francis wrote:
>> On Sun, Jul 5, 2020 at 10:41 AM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>> Several callers of load_elf() pass pointers for lowaddr and highaddr
>>> parameters which are then not used for anything. This may stem from a
>>> misunderstanding that load_elf need a value here but in fact it can
>>> take NULL to ignore these values. Remove such unused variables and
>>> pass NULL instead from callers that don't need these.
>>> 
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> 
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> So this got a few review and acked by but since it touches multiple parts who 
> will actually send pull or merge it? I'd like to make sure this won't miss 
> the freeze deadline just because everybody thinks this should go in via some 
> other maintainer. What's the best way for this? Trivial maintainers or Peter 
> should handle such patches?

Ping? Could someone please queue this patch? It still seems to apply 
cleanly.

Regards,
BALATON Zoltan

>>> ---
>>>  hw/alpha/dp264.c       |  8 ++++----
>>>  hw/arm/armv7m.c        |  4 +---
>>>  hw/cris/boot.c         |  4 ++--
>>>  hw/microblaze/boot.c   |  4 ++--
>>>  hw/mips/fuloong2e.c    |  8 ++++----
>>>  hw/moxie/moxiesim.c    |  4 ++--
>>>  hw/nios2/boot.c        |  4 ++--
>>>  hw/ppc/mac_newworld.c  |  6 ++----
>>>  hw/ppc/mac_oldworld.c  |  6 ++----
>>>  hw/ppc/ppc440_bamboo.c |  9 +++------
>>>  hw/ppc/sam460ex.c      | 12 +++++-------
>>>  hw/ppc/spapr.c         | 11 ++++-------
>>>  hw/ppc/virtex_ml507.c  |  4 ++--
>>>  hw/riscv/boot.c        |  8 ++++----
>>>  hw/xtensa/sim.c        |  3 +--
>>>  hw/xtensa/xtfpga.c     |  3 +--
>>>  16 files changed, 41 insertions(+), 57 deletions(-)
>>> 
>>> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
>>> index f7751b18f6..4d24518d1d 100644
>>> --- a/hw/alpha/dp264.c
>>> +++ b/hw/alpha/dp264.c
>>> @@ -62,8 +62,8 @@ static void clipper_init(MachineState *machine)
>>>      qemu_irq rtc_irq;
>>>      long size, i;
>>>      char *palcode_filename;
>>> -    uint64_t palcode_entry, palcode_low, palcode_high;
>>> -    uint64_t kernel_entry, kernel_low, kernel_high;
>>> +    uint64_t palcode_entry;
>>> +    uint64_t kernel_entry, kernel_low;
>>>      unsigned int smp_cpus = machine->smp.cpus;
>>>
>>>      /* Create up to 4 cpus.  */
>>> @@ -113,7 +113,7 @@ static void clipper_init(MachineState *machine)
>>>          exit(1);
>>>      }
>>>      size = load_elf(palcode_filename, NULL, cpu_alpha_superpage_to_phys,
>>> -                    NULL, &palcode_entry, &palcode_low, &palcode_high, 
>>> NULL,
>>> +                    NULL, &palcode_entry, NULL, NULL, NULL,
>>>                      0, EM_ALPHA, 0, 0);
>>>      if (size < 0) {
>>>          error_report("could not load palcode '%s'", palcode_filename);
>>> @@ -132,7 +132,7 @@ static void clipper_init(MachineState *machine)
>>>          uint64_t param_offset;
>>>
>>>          size = load_elf(kernel_filename, NULL, 
>>> cpu_alpha_superpage_to_phys,
>>> -                        NULL, &kernel_entry, &kernel_low, &kernel_high, 
>>> NULL,
>>> +                        NULL, &kernel_entry, &kernel_low, NULL, NULL,
>>>                          0, EM_ALPHA, 0, 0);
>>>          if (size < 0) {
>>>              error_report("could not load kernel '%s'", kernel_filename);
>>> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
>>> index 3308211e9c..92f859d760 100644
>>> --- a/hw/arm/armv7m.c
>>> +++ b/hw/arm/armv7m.c
>>> @@ -309,7 +309,6 @@ void armv7m_load_kernel(ARMCPU *cpu, const char 
>>> *kernel_filename, int mem_size)
>>>  {
>>>      int image_size;
>>>      uint64_t entry;
>>> -    uint64_t lowaddr;
>>>      int big_endian;
>>>      AddressSpace *as;
>>>      int asidx;
>>> @@ -330,12 +329,11 @@ void armv7m_load_kernel(ARMCPU *cpu, const char 
>>> *kernel_filename, int mem_size)
>>>
>>>      if (kernel_filename) {
>>>          image_size = load_elf_as(kernel_filename, NULL, NULL, NULL,
>>> -                                 &entry, &lowaddr, NULL,
>>> +                                 &entry, NULL, NULL,
>>>                                   NULL, big_endian, EM_ARM, 1, 0, as);
>>>          if (image_size < 0) {
>>>              image_size = load_image_targphys_as(kernel_filename, 0,
>>>                                                  mem_size, as);
>>> -            lowaddr = 0;
>>>          }
>>>          if (image_size < 0) {
>>>              error_report("Could not load kernel '%s'", kernel_filename);
>>> diff --git a/hw/cris/boot.c b/hw/cris/boot.c
>>> index b8947bc660..aa8d2756d6 100644
>>> --- a/hw/cris/boot.c
>>> +++ b/hw/cris/boot.c
>>> @@ -67,7 +67,7 @@ static uint64_t translate_kernel_address(void *opaque, 
>>> uint64_t addr)
>>>  void cris_load_image(CRISCPU *cpu, struct cris_load_info *li)
>>>  {
>>>      CPUCRISState *env = &cpu->env;
>>> -    uint64_t entry, high;
>>> +    uint64_t entry;
>>>      int kcmdline_len;
>>>      int image_size;
>>> 
>>> @@ -76,7 +76,7 @@ void cris_load_image(CRISCPU *cpu, struct cris_load_info 
>>> *li)
>>>         devboard SDK.  */
>>>      image_size = load_elf(li->image_filename, NULL,
>>>                            translate_kernel_address, NULL,
>>> -                          &entry, NULL, &high, NULL, 0, EM_CRIS, 0, 0);
>>> +                          &entry, NULL, NULL, NULL, 0, EM_CRIS, 0, 0);
>>>      li->entry = entry;
>>>      if (image_size < 0) {
>>>          /* Takes a kimage from the axis devboard SDK.  */
>>> diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
>>> index 925e3f7c9d..8ad3c27f2c 100644
>>> --- a/hw/microblaze/boot.c
>>> +++ b/hw/microblaze/boot.c
>>> @@ -135,7 +135,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr 
>>> ddr_base,
>>>
>>>      if (kernel_filename) {
>>>          int kernel_size;
>>> -        uint64_t entry, low, high;
>>> +        uint64_t entry, high;
>>>          uint32_t base32;
>>>          int big_endian = 0;
>>> 
>>> @@ -145,7 +145,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr 
>>> ddr_base,
>>>
>>>          /* Boots a kernel elf binary.  */
>>>          kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
>>> -                               &entry, &low, &high, NULL,
>>> +                               &entry, NULL, &high, NULL,
>>>                                 big_endian, EM_MICROBLAZE, 0, 0);
>>>          base32 = entry;
>>>          if (base32 == 0xc0000000) {
>>> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
>>> index 8ca31e5162..507e549fca 100644
>>> --- a/hw/mips/fuloong2e.c
>>> +++ b/hw/mips/fuloong2e.c
>>> @@ -107,7 +107,7 @@ static void GCC_FMT_ATTR(3, 4) prom_set(uint32_t 
>>> *prom_buf, int index,
>>>
>>>  static int64_t load_kernel(CPUMIPSState *env)
>>>  {
>>> -    int64_t kernel_entry, kernel_low, kernel_high, initrd_size;
>>> +    int64_t kernel_entry, kernel_high, initrd_size;
>>>      int index = 0;
>>>      long kernel_size;
>>>      ram_addr_t initrd_offset;
>>> @@ -116,9 +116,9 @@ static int64_t load_kernel(CPUMIPSState *env)
>>>
>>>      kernel_size = load_elf(loaderparams.kernel_filename, NULL,
>>>                             cpu_mips_kseg0_to_phys, NULL,
>>> -                           (uint64_t *)&kernel_entry,
>>> -                           (uint64_t *)&kernel_low, (uint64_t 
>>> *)&kernel_high,
>>> -                           NULL, 0, EM_MIPS, 1, 0);
>>> +                           (uint64_t *)&kernel_entry, NULL,
>>> +                           (uint64_t *)&kernel_high, NULL,
>>> +                           0, EM_MIPS, 1, 0);
>>>      if (kernel_size < 0) {
>>>          error_report("could not load kernel '%s': %s",
>>>                       loaderparams.kernel_filename,
>>> diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
>>> index 51a98287b5..a765e9f6be 100644
>>> --- a/hw/moxie/moxiesim.c
>>> +++ b/hw/moxie/moxiesim.c
>>> @@ -52,13 +52,13 @@ typedef struct {
>>>
>>>  static void load_kernel(MoxieCPU *cpu, LoaderParams *loader_params)
>>>  {
>>> -    uint64_t entry, kernel_low, kernel_high;
>>> +    uint64_t entry, kernel_high;
>>>      int64_t initrd_size;
>>>      long kernel_size;
>>>      ram_addr_t initrd_offset;
>>>
>>>      kernel_size = load_elf(loader_params->kernel_filename,  NULL, NULL, 
>>> NULL,
>>> -                           &entry, &kernel_low, &kernel_high, NULL, 1, 
>>> EM_MOXIE,
>>> +                           &entry, NULL, &kernel_high, NULL, 1, EM_MOXIE,
>>>                             0, 0);
>>>
>>>      if (kernel_size <= 0) {
>>> diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
>>> index 88224aa84c..1df3b66c29 100644
>>> --- a/hw/nios2/boot.c
>>> +++ b/hw/nios2/boot.c
>>> @@ -139,7 +139,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
>>>
>>>      if (kernel_filename) {
>>>          int kernel_size, fdt_size;
>>> -        uint64_t entry, low, high;
>>> +        uint64_t entry, high;
>>>          int big_endian = 0;
>>>
>>>  #ifdef TARGET_WORDS_BIGENDIAN
>>> @@ -148,7 +148,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
>>>
>>>          /* Boots a kernel elf binary. */
>>>          kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
>>> -                               &entry, &low, &high, NULL,
>>> +                               &entry, NULL, &high, NULL,
>>>                                 big_endian, EM_ALTERA_NIOS2, 0, 0);
>>>          if ((uint32_t)entry == 0xc0000000) {
>>>              /*
>>> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
>>> index 828c5992ae..a3f25ab479 100644
>>> --- a/hw/ppc/mac_newworld.c
>>> +++ b/hw/ppc/mac_newworld.c
>>> @@ -177,7 +177,6 @@ static void ppc_core99_init(MachineState *machine)
>>>      }
>>>
>>>      if (linux_boot) {
>>> -        uint64_t lowaddr = 0;
>>>          int bswap_needed;
>>>
>>>  #ifdef BSWAP_NEEDED
>>> @@ -188,9 +187,8 @@ static void ppc_core99_init(MachineState *machine)
>>>          kernel_base = KERNEL_LOAD_ADDR;
>>>
>>>          kernel_size = load_elf(kernel_filename, NULL,
>>> -                               translate_kernel_address, NULL,
>>> -                               NULL, &lowaddr, NULL, NULL, 1, 
>>> PPC_ELF_MACHINE,
>>> -                               0, 0);
>>> +                               translate_kernel_address, NULL, NULL, 
>>> NULL,
>>> +                               NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
>>>          if (kernel_size < 0)
>>>              kernel_size = load_aout(kernel_filename, kernel_base,
>>>                                      ram_size - kernel_base, bswap_needed,
>>> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
>>> index f8c204ead7..4bcce22a96 100644
>>> --- a/hw/ppc/mac_oldworld.c
>>> +++ b/hw/ppc/mac_oldworld.c
>>> @@ -150,7 +150,6 @@ static void ppc_heathrow_init(MachineState *machine)
>>>      }
>>>
>>>      if (linux_boot) {
>>> -        uint64_t lowaddr = 0;
>>>          int bswap_needed;
>>>
>>>  #ifdef BSWAP_NEEDED
>>> @@ -160,9 +159,8 @@ static void ppc_heathrow_init(MachineState *machine)
>>>  #endif
>>>          kernel_base = KERNEL_LOAD_ADDR;
>>>          kernel_size = load_elf(kernel_filename, NULL,
>>> -                               translate_kernel_address, NULL,
>>> -                               NULL, &lowaddr, NULL, NULL, 1, 
>>> PPC_ELF_MACHINE,
>>> -                               0, 0);
>>> +                               translate_kernel_address, NULL, NULL, 
>>> NULL,
>>> +                               NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
>>>          if (kernel_size < 0)
>>>              kernel_size = load_aout(kernel_filename, kernel_base,
>>>                                      ram_size - kernel_base, bswap_needed,
>>> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
>>> index 4c5e9e4373..74028dc986 100644
>>> --- a/hw/ppc/ppc440_bamboo.c
>>> +++ b/hw/ppc/ppc440_bamboo.c
>>> @@ -172,9 +172,6 @@ static void bamboo_init(MachineState *machine)
>>>      PCIBus *pcibus;
>>>      PowerPCCPU *cpu;
>>>      CPUPPCState *env;
>>> -    uint64_t elf_entry;
>>> -    uint64_t elf_lowaddr;
>>> -    hwaddr loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
>>>      target_long initrd_size = 0;
>>>      DeviceState *dev;
>>>      int success;
>>> @@ -246,14 +243,14 @@ static void bamboo_init(MachineState *machine)
>>>
>>>      /* Load kernel. */
>>>      if (kernel_filename) {
>>> +        hwaddr loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
>>>          success = load_uimage(kernel_filename, &entry, &loadaddr, NULL,
>>>                                NULL, NULL);
>>>          if (success < 0) {
>>> +            uint64_t elf_entry;
>>>              success = load_elf(kernel_filename, NULL, NULL, NULL, 
>>> &elf_entry,
>>> -                               &elf_lowaddr, NULL, NULL, 1, 
>>> PPC_ELF_MACHINE,
>>> -                               0, 0);
>>> +                               NULL, NULL, NULL, 1, PPC_ELF_MACHINE, 0, 
>>> 0);
>>>              entry = elf_entry;
>>> -            loadaddr = elf_lowaddr;
>>>          }
>>>          /* XXX try again as binary */
>>>          if (success < 0) {
>>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>>> index 1a106a68de..71f74e983c 100644
>>> --- a/hw/ppc/sam460ex.c
>>> +++ b/hw/ppc/sam460ex.c
>>> @@ -286,7 +286,6 @@ static void sam460ex_init(MachineState *machine)
>>>      CPUPPCState *env;
>>>      I2CBus *i2c;
>>>      hwaddr entry = UBOOT_ENTRY;
>>> -    hwaddr loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
>>>      target_long initrd_size = 0;
>>>      DeviceState *dev;
>>>      SysBusDevice *sbdev;
>>> @@ -426,17 +425,16 @@ static void sam460ex_init(MachineState *machine)
>>>
>>>      /* Load kernel. */
>>>      if (machine->kernel_filename) {
>>> +        hwaddr loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
>>>          success = load_uimage(machine->kernel_filename, &entry, 
>>> &loadaddr,
>>>                                NULL, NULL, NULL);
>>>          if (success < 0) {
>>> -            uint64_t elf_entry, elf_lowaddr;
>>> +            uint64_t elf_entry;
>>> 
>>> -            success = load_elf(machine->kernel_filename, NULL,
>>> -                               NULL, NULL, &elf_entry,
>>> -                               &elf_lowaddr, NULL, NULL, 1, 
>>> PPC_ELF_MACHINE, 0,
>>> -                               0);
>>> +            success = load_elf(machine->kernel_filename, NULL, NULL, 
>>> NULL,
>>> +                               &elf_entry, NULL, NULL, NULL,
>>> +                               1, PPC_ELF_MACHINE, 0, 0);
>>>              entry = elf_entry;
>>> -            loadaddr = elf_lowaddr;
>>>          }
>>>          /* XXX try again as binary */
>>>          if (success < 0) {
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index f6f034d039..f4e8e2e139 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -2972,18 +2972,15 @@ static void spapr_machine_init(MachineState 
>>> *machine)
>>>      }
>>>
>>>      if (kernel_filename) {
>>> -        uint64_t lowaddr = 0;
>>> -
>>>          spapr->kernel_size = load_elf(kernel_filename, NULL,
>>>                                        translate_kernel_address, spapr,
>>> -                                      NULL, &lowaddr, NULL, NULL, 1,
>>> +                                      NULL, NULL, NULL, NULL, 1,
>>>                                        PPC_ELF_MACHINE, 0, 0);
>>>          if (spapr->kernel_size == ELF_LOAD_WRONG_ENDIAN) {
>>>              spapr->kernel_size = load_elf(kernel_filename, NULL,
>>> -                                          translate_kernel_address, 
>>> spapr, NULL,
>>> -                                          &lowaddr, NULL, NULL, 0,
>>> -                                          PPC_ELF_MACHINE,
>>> -                                          0, 0);
>>> +                                          translate_kernel_address, 
>>> spapr,
>>> +                                          NULL, NULL, NULL, NULL, 0,
>>> +                                          PPC_ELF_MACHINE, 0, 0);
>>>              spapr->kernel_le = spapr->kernel_size > 0;
>>>          }
>>>          if (spapr->kernel_size < 0) {
>>> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
>>> index 78c4901be1..c790c1113f 100644
>>> --- a/hw/ppc/virtex_ml507.c
>>> +++ b/hw/ppc/virtex_ml507.c
>>> @@ -250,12 +250,12 @@ static void virtex_init(MachineState *machine)
>>>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
>>>
>>>      if (kernel_filename) {
>>> -        uint64_t entry, low, high;
>>> +        uint64_t entry, high;
>>>          hwaddr boot_offset;
>>>
>>>          /* Boots a kernel elf binary.  */
>>>          kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
>>> -                               &entry, &low, &high, NULL, 1, 
>>> PPC_ELF_MACHINE,
>>> +                               &entry, NULL, &high, NULL, 1, 
>>> PPC_ELF_MACHINE,
>>>                                 0, 0);
>>>          boot_info.bootstrap_pc = entry & 0x00ffffff;
>>> 
>>> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
>>> index adb421b91b..ab8da252ee 100644
>>> --- a/hw/riscv/boot.c
>>> +++ b/hw/riscv/boot.c
>>> @@ -85,10 +85,10 @@ target_ulong riscv_load_firmware(const char 
>>> *firmware_filename,
>>>                                   hwaddr firmware_load_addr,
>>>                                   symbol_fn_t sym_cb)
>>>  {
>>> -    uint64_t firmware_entry, firmware_start, firmware_end;
>>> +    uint64_t firmware_entry;
>>>
>>>      if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
>>> -                         &firmware_entry, &firmware_start, &firmware_end, 
>>> NULL,
>>> +                         &firmware_entry, NULL, NULL, NULL,
>>>                           0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
>>>          return firmware_entry;
>>>      }
>>> @@ -104,10 +104,10 @@ target_ulong riscv_load_firmware(const char 
>>> *firmware_filename,
>>>
>>>  target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t 
>>> sym_cb)
>>>  {
>>> -    uint64_t kernel_entry, kernel_high;
>>> +    uint64_t kernel_entry;
>>>
>>>      if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
>>> -                         &kernel_entry, NULL, &kernel_high, NULL, 0,
>>> +                         &kernel_entry, NULL, NULL, NULL, 0,
>>>                           EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
>>>          return kernel_entry;
>>>      }
>>> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
>>> index aeb46d86f5..cbac50db2d 100644
>>> --- a/hw/xtensa/sim.c
>>> +++ b/hw/xtensa/sim.c
>>> @@ -106,9 +106,8 @@ void xtensa_sim_load_kernel(XtensaCPU *cpu, 
>>> MachineState *machine)
>>>
>>>      if (kernel_filename) {
>>>          uint64_t elf_entry;
>>> -        uint64_t elf_lowaddr;
>>>          int success = load_elf(kernel_filename, NULL, 
>>> translate_phys_addr, cpu,
>>> -                               &elf_entry, &elf_lowaddr, NULL, NULL, 
>>> big_endian,
>>> +                               &elf_entry, NULL, NULL, NULL, big_endian,
>>>                                 EM_XTENSA, 0, 0);
>>>
>>>          if (success > 0) {
>>> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
>>> index 10de15855a..b1470b88e6 100644
>>> --- a/hw/xtensa/xtfpga.c
>>> +++ b/hw/xtensa/xtfpga.c
>>> @@ -413,9 +413,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, 
>>> MachineState *machine)
>>>          env->regs[2] = tagptr;
>>>
>>>          uint64_t elf_entry;
>>> -        uint64_t elf_lowaddr;
>>>          int success = load_elf(kernel_filename, NULL, 
>>> translate_phys_addr, cpu,
>>> -                &elf_entry, &elf_lowaddr, NULL, NULL, be, EM_XTENSA, 0, 
>>> 0);
>>> +                &elf_entry, NULL, NULL, NULL, be, EM_XTENSA, 0, 0);
>>>          if (success > 0) {
>>>              entry_point = elf_entry;
>>>          } else {
>>> --
>>> 2.21.3
>>> 
>>> 
>> 
>> 
>
>

