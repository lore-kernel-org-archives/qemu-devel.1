Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB81C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B28206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B28206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQDg-0007PC-Iw
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iwQCk-0006BS-Ak
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iwQCf-0007fI-GQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:42:53 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:32649)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1iwQCe-0007R6-Sq
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:42:49 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 90D6974637E;
 Tue, 28 Jan 2020 13:42:37 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 339077456D5; Tue, 28 Jan 2020 13:42:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2FF4374569A;
 Tue, 28 Jan 2020 13:42:37 +0100 (CET)
Date: Tue, 28 Jan 2020 13:42:37 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH rc3 23/30] hw/core/loader: Let load_elf populate the
 processor-specific flags
In-Reply-To: <CAL1e-=hG=NoQWpxQ5xOkyLM7kYpsoZOohTWU1eYr-fLp=Ud_MA@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2001281334310.9839@zero.eik.bme.hu>
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-24-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=hG=NoQWpxQ5xOkyLM7kYpsoZOohTWU1eYr-fLp=Ud_MA@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-477311962-1580215357=:9839"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Jia Liu <proljc@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Thomas Huth <huth@tuxfamily.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>,
 Michael Rolnik <mrolnik@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-477311962-1580215357=:9839
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jan 2020, Aleksandar Markovic wrote:
> On Sunday, January 26, 2020, Aleksandar Markovic <
> aleksandar.markovic@rt-rk.com> wrote:
>
>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> Some platforms (like AVR) need to determine cpu type by reading
>> the ELF flags (field e_flags oin ELF header).
>>
>> This patch enables discovery of the content of that flag while
>> using following functions:
>>
>>   - load_elf()
>>   - load_elf_as()
>>   - load_elf_ram()
>>   - load_elf_ram_sym()
>>
>> The added argument of these functions is of type uint32_t*. It is
>> allowed to pass NULL as that argument, and in such case no lookup
>> to the field e_flags will happen, and of course, no information
>> will be returned to the caller.
>>
>>
> We plan to use this new functionality for MIPS Malta board, for detecti=
on
> of incompatible cpu/kernel combinations, and graceful exit (right now t=
hese
> combinations result in hang or crash). I would say other boards could m=
ake
> use of it too.
>
> For that reason, if there is no objection, I plan to select this patch =
for
> next MIPS queue.

No objection but kind of d=C3=A9j=C3=A0 vu:

https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg03427.html

I still think the interface of load_elf may need to be rethinked but I=20
don't know a good way. This could be fixed in a later patch causing more=20
code churn again though, so if there's a way to fix this it might be a=20
good opportunity now. But I don't want to hold your patch series back so=20
unless someone has a good idea to avoid this situation then we have to=20
live with it.

Regards,
BALATON Zoltan

>
> Regards,
> Aleksandar
>
>
>
>
>> CC: Richard Henderson <rth@twiddle.net>
>> CC: Peter Maydell <peter.maydell@linaro.org>
>> CC: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>> CC: Michael Walle <michael@walle.cc>
>> CC: Thomas Huth <huth@tuxfamily.org>
>> CC: Laurent Vivier <laurent@vivier.eu>
>> CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> CC: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>> CC: Aurelien Jarno <aurelien@aurel32.net>
>> CC: Jia Liu <proljc@gmail.com>
>> CC: David Gibson <david@gibson.dropbear.id.au>
>> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> CC: BALATON Zoltan <balaton@eik.bme.hu>
>> CC: Christian Borntraeger <borntraeger@de.ibm.com>
>> CC: Thomas Huth <thuth@redhat.com>
>> CC: Artyom Tarasenko <atar4qemu@gmail.com>
>> CC: Fabien Chouteau <chouteau@adacore.com>
>> CC: KONRAD Frederic <frederic.konrad@adacore.com>
>> CC: Max Filippov <jcmvbkbc@gmail.com>
>>
>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> [PMD: Extracted from bigger patch,
>>       Replaced 'uint32_t *pe_flags' by 'int proc_flags']
>> [AM: Replaced 'int proc_flags' with 'uint32_t *pflags',
>>      replaced one instance of 'elf_sword' to 'elf_word',
>>      extended functionality to load_elf()]
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>> ---
>>  hw/alpha/dp264.c               |  4 ++--
>>  hw/arm/armv7m.c                |  2 +-
>>  hw/arm/boot.c                  |  2 +-
>>  hw/core/generic-loader.c       |  2 +-
>>  hw/core/loader.c               | 37 +++++++++++++++++++--------------=
----
>>  hw/cris/boot.c                 |  2 +-
>>  hw/hppa/machine.c              |  4 ++--
>>  hw/i386/multiboot.c            |  2 +-
>>  hw/i386/x86.c                  |  2 +-
>>  hw/lm32/lm32_boards.c          |  4 ++--
>>  hw/lm32/milkymist.c            |  2 +-
>>  hw/m68k/an5206.c               |  2 +-
>>  hw/m68k/mcf5208.c              |  2 +-
>>  hw/m68k/q800.c                 |  2 +-
>>  hw/microblaze/boot.c           |  4 ++--
>>  hw/mips/mips_fulong2e.c        |  2 +-
>>  hw/mips/mips_malta.c           |  3 ++-
>>  hw/mips/mips_mipssim.c         |  2 +-
>>  hw/mips/mips_r4k.c             |  2 +-
>>  hw/moxie/moxiesim.c            |  2 +-
>>  hw/nios2/boot.c                |  4 ++--
>>  hw/openrisc/openrisc_sim.c     |  2 +-
>>  hw/pci-host/prep.c             |  3 ++-
>>  hw/ppc/e500.c                  |  2 +-
>>  hw/ppc/mac_newworld.c          |  4 ++--
>>  hw/ppc/mac_oldworld.c          |  4 ++--
>>  hw/ppc/ppc440_bamboo.c         |  2 +-
>>  hw/ppc/sam460ex.c              |  3 ++-
>>  hw/ppc/spapr.c                 |  6 +++---
>>  hw/ppc/virtex_ml507.c          |  2 +-
>>  hw/riscv/boot.c                |  4 ++--
>>  hw/s390x/ipl.c                 |  7 ++++---
>>  hw/sparc/leon3.c               |  2 +-
>>  hw/sparc/sun4m.c               |  4 ++--
>>  hw/sparc64/sun4u.c             |  5 +++--
>>  hw/tricore/tricore_testboard.c |  2 +-
>>  hw/xtensa/sim.c                |  2 +-
>>  hw/xtensa/xtfpga.c             |  2 +-
>>  include/hw/elf_ops.h           |  6 +++++-
>>  include/hw/loader.h            | 21 ++++++++++++---------
>>  40 files changed, 92 insertions(+), 79 deletions(-)
>>
>> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
>> index f2026fd..a8f9a89 100644
>> --- a/hw/alpha/dp264.c
>> +++ b/hw/alpha/dp264.c
>> @@ -115,7 +115,7 @@ static void clipper_init(MachineState *machine)
>>          exit(1);
>>      }
>>      size =3D load_elf(palcode_filename, NULL, cpu_alpha_superpage_to_=
phys,
>> -                    NULL, &palcode_entry, &palcode_low, &palcode_high=
,
>> +                    NULL, &palcode_entry, &palcode_low, &palcode_high=
,
>> NULL,
>>                      0, EM_ALPHA, 0, 0);
>>      if (size < 0) {
>>          error_report("could not load palcode '%s'", palcode_filename)=
;
>> @@ -134,7 +134,7 @@ static void clipper_init(MachineState *machine)
>>          uint64_t param_offset;
>>
>>          size =3D load_elf(kernel_filename, NULL,
>> cpu_alpha_superpage_to_phys,
>> -                        NULL, &kernel_entry, &kernel_low, &kernel_hig=
h,
>> +                        NULL, &kernel_entry, &kernel_low, &kernel_hig=
h,
>> NULL,
>>                          0, EM_ALPHA, 0, 0);
>>          if (size < 0) {
>>              error_report("could not load kernel '%s'", kernel_filenam=
e);
>> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
>> index 7a3c48f..e4fc9a8 100644
>> --- a/hw/arm/armv7m.c
>> +++ b/hw/arm/armv7m.c
>> @@ -331,7 +331,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char
>> *kernel_filename, int mem_size)
>>
>>      if (kernel_filename) {
>>          image_size =3D load_elf_as(kernel_filename, NULL, NULL, NULL,
>> -                                 &entry, &lowaddr,
>> +                                 &entry, &lowaddr, NULL,
>>                                   NULL, big_endian, EM_ARM, 1, 0, as);
>>          if (image_size < 0) {
>>              image_size =3D load_image_targphys_as(kernel_filename, 0,
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index 8fb4a63..0c213ca 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -903,7 +903,7 @@ static int64_t arm_load_elf(struct arm_boot_info
>> *info, uint64_t *pentry,
>>      }
>>
>>      ret =3D load_elf_as(info->kernel_filename, NULL, NULL, NULL,
>> -                      pentry, lowaddr, highaddr, big_endian, elf_mach=
ine,
>> +                      pentry, lowaddr, highaddr, NULL, big_endian,
>> elf_machine,
>>                        1, data_swab, as);
>>      if (ret <=3D 0) {
>>          /* The header loaded but the image didn't */
>> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
>> index 4b1fc86..1e5ccb7 100644
>> --- a/hw/core/generic-loader.c
>> +++ b/hw/core/generic-loader.c
>> @@ -140,7 +140,7 @@ static void generic_loader_realize(DeviceState *de=
v,
>> Error **errp)
>>
>>          if (!s->force_raw) {
>>              size =3D load_elf_as(s->file, NULL, NULL, NULL, &entry, N=
ULL,
>> NULL,
>> -                               big_endian, 0, 0, 0, as);
>> +                               NULL, big_endian, 0, 0, 0, as);
>>
>>              if (size < 0) {
>>                  size =3D load_uimage_as(s->file, &entry, NULL, NULL, =
NULL,
>> NULL,
>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>> index 5099f27..d1b78f6 100644
>> --- a/hw/core/loader.c
>> +++ b/hw/core/loader.c
>> @@ -406,12 +406,12 @@ int load_elf(const char *filename,
>>               uint64_t (*elf_note_fn)(void *, void *, bool),
>>               uint64_t (*translate_fn)(void *, uint64_t),
>>               void *translate_opaque, uint64_t *pentry, uint64_t *lowa=
ddr,
>> -             uint64_t *highaddr, int big_endian, int elf_machine,
>> -             int clear_lsb, int data_swab)
>> +             uint64_t *highaddr, uint32_t *pflags, int big_endian,
>> +             int elf_machine, int clear_lsb, int data_swab)
>>  {
>>      return load_elf_as(filename, elf_note_fn, translate_fn,
>> translate_opaque,
>> -                       pentry, lowaddr, highaddr, big_endian, elf_mac=
hine,
>> -                       clear_lsb, data_swab, NULL);
>> +                       pentry, lowaddr, highaddr, pflags, big_endian,
>> +                       elf_machine, clear_lsb, data_swab, NULL);
>>  }
>>
>>  /* return < 0 if error, otherwise the number of bytes loaded in memor=
y */
>> @@ -419,12 +419,12 @@ int load_elf_as(const char *filename,
>>                  uint64_t (*elf_note_fn)(void *, void *, bool),
>>                  uint64_t (*translate_fn)(void *, uint64_t),
>>                  void *translate_opaque, uint64_t *pentry, uint64_t
>> *lowaddr,
>> -                uint64_t *highaddr, int big_endian, int elf_machine,
>> -                int clear_lsb, int data_swab, AddressSpace *as)
>> +                uint64_t *highaddr, uint32_t *pflags, int big_endian,
>> +                int elf_machine, int clear_lsb, int data_swab,
>> AddressSpace *as)
>>  {
>>      return load_elf_ram(filename, elf_note_fn, translate_fn,
>> translate_opaque,
>> -                        pentry, lowaddr, highaddr, big_endian,
>> elf_machine,
>> -                        clear_lsb, data_swab, as, true);
>> +                        pentry, lowaddr, highaddr, pflags, big_endian=
,
>> +                        elf_machine, clear_lsb, data_swab, as, true);
>>  }
>>
>>  /* return < 0 if error, otherwise the number of bytes loaded in memor=
y */
>> @@ -432,13 +432,13 @@ int load_elf_ram(const char *filename,
>>                   uint64_t (*elf_note_fn)(void *, void *, bool),
>>                   uint64_t (*translate_fn)(void *, uint64_t),
>>                   void *translate_opaque, uint64_t *pentry, uint64_t
>> *lowaddr,
>> -                 uint64_t *highaddr, int big_endian, int elf_machine,
>> -                 int clear_lsb, int data_swab, AddressSpace *as,
>> -                 bool load_rom)
>> +                 uint64_t *highaddr, uint32_t *pflags, int big_endian=
,
>> +                 int elf_machine, int clear_lsb, int data_swab,
>> +                 AddressSpace *as, bool load_rom)
>>  {
>>      return load_elf_ram_sym(filename, elf_note_fn,
>>                              translate_fn, translate_opaque,
>> -                            pentry, lowaddr, highaddr, big_endian,
>> +                            pentry, lowaddr, highaddr, pflags, big_en=
dian,
>>                              elf_machine, clear_lsb, data_swab, as,
>>                              load_rom, NULL);
>>  }
>> @@ -448,8 +448,9 @@ int load_elf_ram_sym(const char *filename,
>>                       uint64_t (*elf_note_fn)(void *, void *, bool),
>>                       uint64_t (*translate_fn)(void *, uint64_t),
>>                       void *translate_opaque, uint64_t *pentry,
>> -                     uint64_t *lowaddr, uint64_t *highaddr, int
>> big_endian,
>> -                     int elf_machine, int clear_lsb, int data_swab,
>> +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t
>> *pflags,
>> +                     int big_endian, int elf_machine,
>> +                     int clear_lsb, int data_swab,
>>                       AddressSpace *as, bool load_rom, symbol_fn_t sym=
_cb)
>>  {
>>      int fd, data_order, target_data_order, must_swab, ret =3D
>> ELF_LOAD_FAILED;
>> @@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,
>>      if (e_ident[EI_CLASS] =3D=3D ELFCLASS64) {
>>          ret =3D load_elf64(filename, fd, elf_note_fn,
>>                           translate_fn, translate_opaque, must_swab,
>> -                         pentry, lowaddr, highaddr, elf_machine,
>> clear_lsb,
>> -                         data_swab, as, load_rom, sym_cb);
>> +                         pentry, lowaddr, highaddr, pflags, elf_machi=
ne,
>> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>>      } else {
>>          ret =3D load_elf32(filename, fd, elf_note_fn,
>>                           translate_fn, translate_opaque, must_swab,
>> -                         pentry, lowaddr, highaddr, elf_machine,
>> clear_lsb,
>> -                         data_swab, as, load_rom, sym_cb);
>> +                         pentry, lowaddr, highaddr, pflags, elf_machi=
ne,
>> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>>      }
>>
>>   fail:
>> diff --git a/hw/cris/boot.c b/hw/cris/boot.c
>> index 2d2cc0c..b8947bc 100644
>> --- a/hw/cris/boot.c
>> +++ b/hw/cris/boot.c
>> @@ -76,7 +76,7 @@ void cris_load_image(CRISCPU *cpu, struct cris_load_=
info
>> *li)
>>         devboard SDK.  */
>>      image_size =3D load_elf(li->image_filename, NULL,
>>                            translate_kernel_address, NULL,
>> -                          &entry, NULL, &high, 0, EM_CRIS, 0, 0);
>> +                          &entry, NULL, &high, NULL, 0, EM_CRIS, 0, 0=
);
>>      li->entry =3D entry;
>>      if (image_size < 0) {
>>          /* Takes a kimage from the axis devboard SDK.  */
>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>> index 5d0de26..0ab36cf 100644
>> --- a/hw/hppa/machine.c
>> +++ b/hw/hppa/machine.c
>> @@ -140,7 +140,7 @@ static void machine_hppa_init(MachineState *machin=
e)
>>      }
>>
>>      size =3D load_elf(firmware_filename, NULL, NULL, NULL,
>> -                    &firmware_entry, &firmware_low, &firmware_high,
>> +                    &firmware_entry, &firmware_low, &firmware_high, N=
ULL,
>>                      true, EM_PARISC, 0, 0);
>>
>>      /* Unfortunately, load_elf sign-extends reading elf32.  */
>> @@ -169,7 +169,7 @@ static void machine_hppa_init(MachineState *machin=
e)
>>      /* Load kernel */
>>      if (kernel_filename) {
>>          size =3D load_elf(kernel_filename, NULL, &cpu_hppa_to_phys,
>> -                        NULL, &kernel_entry, &kernel_low, &kernel_hig=
h,
>> +                        NULL, &kernel_entry, &kernel_low, &kernel_hig=
h,
>> NULL,
>>                          true, EM_PARISC, 0, 0);
>>
>>          /* Unfortunately, load_elf sign-extends reading elf32.  */
>> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
>> index 9a59f95..9e7d69d 100644
>> --- a/hw/i386/multiboot.c
>> +++ b/hw/i386/multiboot.c
>> @@ -199,7 +199,7 @@ int load_multiboot(FWCfgState *fw_cfg,
>>          }
>>
>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>> &elf_entry,
>> -                               &elf_low, &elf_high, 0, I386_ELF_MACHI=
NE,
>> +                               &elf_low, &elf_high, NULL, 0,
>> I386_ELF_MACHINE,
>>                                 0, 0);
>>          if (kernel_size < 0) {
>>              error_report("Error while loading elf kernel");
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index 9b9a4d5..7f38e6b 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -413,7 +413,7 @@ static bool load_elfboot(const char *kernel_filena=
me,
>>      uint64_t elf_note_type =3D XEN_ELFNOTE_PHYS32_ENTRY;
>>      kernel_size =3D load_elf(kernel_filename, read_pvh_start_addr,
>>                             NULL, &elf_note_type, &elf_entry,
>> -                           &elf_low, &elf_high, 0, I386_ELF_MACHINE,
>> +                           &elf_low, &elf_high, NULL, 0, I386_ELF_MAC=
HINE,
>>                             0, 0);
>>
>>      if (kernel_size < 0) {
>> diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
>> index 5ae308b..d1894ad 100644
>> --- a/hw/lm32/lm32_boards.c
>> +++ b/hw/lm32/lm32_boards.c
>> @@ -138,7 +138,7 @@ static void lm32_evr_init(MachineState *machine)
>>          int kernel_size;
>>
>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>> -                               &entry, NULL, NULL,
>> +                               &entry, NULL, NULL, NULL,
>>                                 1, EM_LATTICEMICO32, 0, 0);
>>          reset_info->bootstrap_pc =3D entry;
>>
>> @@ -232,7 +232,7 @@ static void lm32_uclinux_init(MachineState *machin=
e)
>>          int kernel_size;
>>
>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>> -                               &entry, NULL, NULL,
>> +                               &entry, NULL, NULL, NULL,
>>                                 1, EM_LATTICEMICO32, 0, 0);
>>          reset_info->bootstrap_pc =3D entry;
>>
>> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
>> index 460d322..6d46134 100644
>> --- a/hw/lm32/milkymist.c
>> +++ b/hw/lm32/milkymist.c
>> @@ -177,7 +177,7 @@ milkymist_init(MachineState *machine)
>>
>>          /* Boots a kernel elf binary.  */
>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>> -                               &entry, NULL, NULL,
>> +                               &entry, NULL, NULL, NULL,
>>                                 1, EM_LATTICEMICO32, 0, 0);
>>          reset_info->bootstrap_pc =3D entry;
>>
>> diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
>> index 54ccbe1..bed43a9 100644
>> --- a/hw/m68k/an5206.c
>> +++ b/hw/m68k/an5206.c
>> @@ -65,7 +65,7 @@ static void an5206_init(MachineState *machine)
>>      }
>>
>>      kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL, &elf_=
entry,
>> -                           NULL, NULL, 1, EM_68K, 0, 0);
>> +                           NULL, NULL, NULL, 1, EM_68K, 0, 0);
>>      entry =3D elf_entry;
>>      if (kernel_size < 0) {
>>          kernel_size =3D load_uimage(kernel_filename, &entry, NULL, NU=
LL,
>> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
>> index 158c5e4..a999c21 100644
>> --- a/hw/m68k/mcf5208.c
>> +++ b/hw/m68k/mcf5208.c
>> @@ -329,7 +329,7 @@ static void mcf5208evb_init(MachineState *machine)
>>      }
>>
>>      kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL, &elf_=
entry,
>> -                           NULL, NULL, 1, EM_68K, 0, 0);
>> +                           NULL, NULL, NULL, 1, EM_68K, 0, 0);
>>      entry =3D elf_entry;
>>      if (kernel_size < 0) {
>>          kernel_size =3D load_uimage(kernel_filename, &entry, NULL, NU=
LL,
>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>> index 12491ec..1e32363 100644
>> --- a/hw/m68k/q800.c
>> +++ b/hw/m68k/q800.c
>> @@ -342,7 +342,7 @@ static void q800_init(MachineState *machine)
>>      if (linux_boot) {
>>          uint64_t high;
>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>> -                               &elf_entry, NULL, &high, 1,
>> +                               &elf_entry, NULL, &high, NULL, 1,
>>                                 EM_68K, 0, 0);
>>          if (kernel_size < 0) {
>>              error_report("could not load kernel '%s'", kernel_filenam=
e);
>> diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
>> index d1d7dfb..925e3f7 100644
>> --- a/hw/microblaze/boot.c
>> +++ b/hw/microblaze/boot.c
>> @@ -145,13 +145,13 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu,
>> hwaddr ddr_base,
>>
>>          /* Boots a kernel elf binary.  */
>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>> -                               &entry, &low, &high,
>> +                               &entry, &low, &high, NULL,
>>                                 big_endian, EM_MICROBLAZE, 0, 0);
>>          base32 =3D entry;
>>          if (base32 =3D=3D 0xc0000000) {
>>              kernel_size =3D load_elf(kernel_filename, NULL,
>>                                     translate_kernel_address, NULL,
>> -                                   &entry, NULL, NULL,
>> +                                   &entry, NULL, NULL, NULL,
>>                                     big_endian, EM_MICROBLAZE, 0, 0);
>>          }
>>          /* Always boot into physical ram.  */
>> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
>> index 9eaa6e2..2e043cb 100644
>> --- a/hw/mips/mips_fulong2e.c
>> +++ b/hw/mips/mips_fulong2e.c
>> @@ -119,7 +119,7 @@ static int64_t load_kernel(CPUMIPSState *env)
>>                             cpu_mips_kseg0_to_phys, NULL,
>>                             (uint64_t *)&kernel_entry,
>>                             (uint64_t *)&kernel_low, (uint64_t
>> *)&kernel_high,
>> -                           0, EM_MIPS, 1, 0);
>> +                           NULL, 0, EM_MIPS, 1, 0);
>>      if (kernel_size < 0) {
>>          error_report("could not load kernel '%s': %s",
>>                       loaderparams.kernel_filename,
>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>> index 5aaeaa8..34b76bb 100644
>> --- a/hw/mips/mips_malta.c
>> +++ b/hw/mips/mips_malta.c
>> @@ -1039,7 +1039,8 @@ static int64_t load_kernel(void)
>>      kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
>>                             cpu_mips_kseg0_to_phys, NULL,
>>                             (uint64_t *)&kernel_entry, NULL,
>> -                           (uint64_t *)&kernel_high, big_endian, EM_M=
IPS,
>> 1, 0);
>> +                           (uint64_t *)&kernel_high, NULL, big_endian=
,
>> EM_MIPS,
>> +                           1, 0);
>>      if (kernel_size < 0) {
>>          error_report("could not load kernel '%s': %s",
>>                       loaderparams.kernel_filename,
>> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
>> index 84c03dd..b934ca9 100644
>> --- a/hw/mips/mips_mipssim.c
>> +++ b/hw/mips/mips_mipssim.c
>> @@ -74,7 +74,7 @@ static int64_t load_kernel(void)
>>      kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
>>                             cpu_mips_kseg0_to_phys, NULL,
>>                             (uint64_t *)&entry, NULL,
>> -                           (uint64_t *)&kernel_high, big_endian,
>> +                           (uint64_t *)&kernel_high, NULL, big_endian=
,
>>                             EM_MIPS, 1, 0);
>>      if (kernel_size >=3D 0) {
>>          if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000) {
>> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
>> index fd926a3..b2aec43 100644
>> --- a/hw/mips/mips_r4k.c
>> +++ b/hw/mips/mips_r4k.c
>> @@ -98,7 +98,7 @@ static int64_t load_kernel(void)
>>      kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
>>                             cpu_mips_kseg0_to_phys, NULL,
>>                             (uint64_t *)&entry, NULL,
>> -                           (uint64_t *)&kernel_high, big_endian,
>> +                           (uint64_t *)&kernel_high, NULL, big_endian=
,
>>                             EM_MIPS, 1, 0);
>>      if (kernel_size >=3D 0) {
>>          if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000) {
>> diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
>> index 57af1b4..1d06e39 100644
>> --- a/hw/moxie/moxiesim.c
>> +++ b/hw/moxie/moxiesim.c
>> @@ -58,7 +58,7 @@ static void load_kernel(MoxieCPU *cpu, LoaderParams
>> *loader_params)
>>      ram_addr_t initrd_offset;
>>
>>      kernel_size =3D load_elf(loader_params->kernel_filename,  NULL, N=
ULL,
>> NULL,
>> -                           &entry, &kernel_low, &kernel_high, 1, EM_M=
OXIE,
>> +                           &entry, &kernel_low, &kernel_high, NULL, 1=
,
>> EM_MOXIE,
>>                             0, 0);
>>
>>      if (kernel_size <=3D 0) {
>> diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
>> index d78bc9e..46b8349 100644
>> --- a/hw/nios2/boot.c
>> +++ b/hw/nios2/boot.c
>> @@ -147,7 +147,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_b=
ase,
>>
>>          /* Boots a kernel elf binary. */
>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>> -                               &entry, &low, &high,
>> +                               &entry, &low, &high, NULL,
>>                                 big_endian, EM_ALTERA_NIOS2, 0, 0);
>>          if ((uint32_t)entry =3D=3D 0xc0000000) {
>>              /*
>> @@ -158,7 +158,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_b=
ase,
>>               */
>>              kernel_size =3D load_elf(kernel_filename, NULL,
>>                                     translate_kernel_address, NULL,
>> -                                   &entry, NULL, NULL,
>> +                                   &entry, NULL, NULL, NULL,
>>                                     big_endian, EM_ALTERA_NIOS2, 0, 0)=
;
>>              boot_info.bootstrap_pc =3D ddr_base + 0xc0000000 +
>>                  (entry & 0x07ffffff);
>> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
>> index 79e7049..ad53712 100644
>> --- a/hw/openrisc/openrisc_sim.c
>> +++ b/hw/openrisc/openrisc_sim.c
>> @@ -98,7 +98,7 @@ static void openrisc_load_kernel(ram_addr_t ram_size=
,
>>
>>      if (kernel_filename && !qtest_enabled()) {
>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>> -                               &elf_entry, NULL, NULL, 1, EM_OPENRISC=
,
>> +                               &elf_entry, NULL, NULL, NULL, 1,
>> EM_OPENRISC,
>>                                 1, 0);
>>          entry =3D elf_entry;
>>          if (kernel_size < 0) {
>> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
>> index afa136d..fcf6235 100644
>> --- a/hw/pci-host/prep.c
>> +++ b/hw/pci-host/prep.c
>> @@ -335,7 +335,8 @@ static void raven_realize(PCIDevice *d, Error **er=
rp)
>>          if (filename) {
>>              if (s->elf_machine !=3D EM_NONE) {
>>                  bios_size =3D load_elf(filename, NULL, NULL, NULL, NU=
LL,
>> -                                     NULL, NULL, 1, s->elf_machine, 0=
, 0);
>> +                                     NULL, NULL, NULL, 1, s->elf_mach=
ine,
>> +                                     0, 0);
>>              }
>>              if (bios_size < 0) {
>>                  bios_size =3D get_image_size(filename);
>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>> index 12b6a5b..886442e 100644
>> --- a/hw/ppc/e500.c
>> +++ b/hw/ppc/e500.c
>> @@ -1049,7 +1049,7 @@ void ppce500_init(MachineState *machine)
>>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, payload_name);
>>
>>      payload_size =3D load_elf(filename, NULL, NULL, NULL,
>> -                            &bios_entry, &loadaddr, NULL,
>> +                            &bios_entry, &loadaddr, NULL, NULL,
>>                              1, PPC_ELF_MACHINE, 0, 0);
>>      if (payload_size < 0) {
>>          /*
>> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
>> index 3594517..464d012 100644
>> --- a/hw/ppc/mac_newworld.c
>> +++ b/hw/ppc/mac_newworld.c
>> @@ -168,7 +168,7 @@ static void ppc_core99_init(MachineState *machine)
>>      /* Load OpenBIOS (ELF) */
>>      if (filename) {
>>          bios_size =3D load_elf(filename, NULL, NULL, NULL, NULL,
>> -                             NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
>> +                             NULL, NULL, NULL, 1, PPC_ELF_MACHINE, 0,=
 0);
>>
>>          g_free(filename);
>>      } else {
>> @@ -192,7 +192,7 @@ static void ppc_core99_init(MachineState *machine)
>>
>>          kernel_size =3D load_elf(kernel_filename, NULL,
>>                                 translate_kernel_address, NULL,
>> -                               NULL, &lowaddr, NULL, 1, PPC_ELF_MACHI=
NE,
>> +                               NULL, &lowaddr, NULL, NULL, 1,
>> PPC_ELF_MACHINE,
>>                                 0, 0);
>>          if (kernel_size < 0)
>>              kernel_size =3D load_aout(kernel_filename, kernel_base,
>> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
>> index 0fa680b..7318d7e 100644
>> --- a/hw/ppc/mac_oldworld.c
>> +++ b/hw/ppc/mac_oldworld.c
>> @@ -143,7 +143,7 @@ static void ppc_heathrow_init(MachineState *machin=
e)
>>
>>      /* Load OpenBIOS (ELF) */
>>      if (filename) {
>> -        bios_size =3D load_elf(filename, NULL, 0, NULL, NULL, NULL, N=
ULL,
>> +        bios_size =3D load_elf(filename, NULL, 0, NULL, NULL, NULL, N=
ULL,
>> NULL,
>>                               1, PPC_ELF_MACHINE, 0, 0);
>>          g_free(filename);
>>      } else {
>> @@ -166,7 +166,7 @@ static void ppc_heathrow_init(MachineState *machin=
e)
>>          kernel_base =3D KERNEL_LOAD_ADDR;
>>          kernel_size =3D load_elf(kernel_filename, NULL,
>>                                 translate_kernel_address, NULL,
>> -                               NULL, &lowaddr, NULL, 1, PPC_ELF_MACHI=
NE,
>> +                               NULL, &lowaddr, NULL, NULL, 1,
>> PPC_ELF_MACHINE,
>>                                 0, 0);
>>          if (kernel_size < 0)
>>              kernel_size =3D load_aout(kernel_filename, kernel_base,
>> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
>> index b782641..da777ef 100644
>> --- a/hw/ppc/ppc440_bamboo.c
>> +++ b/hw/ppc/ppc440_bamboo.c
>> @@ -253,7 +253,7 @@ static void bamboo_init(MachineState *machine)
>>                                NULL, NULL);
>>          if (success < 0) {
>>              success =3D load_elf(kernel_filename, NULL, NULL, NULL,
>> &elf_entry,
>> -                               &elf_lowaddr, NULL, 1, PPC_ELF_MACHINE=
,
>> +                               &elf_lowaddr, NULL, NULL, 1,
>> PPC_ELF_MACHINE,
>>                                 0, 0);
>>              entry =3D elf_entry;
>>              loadaddr =3D elf_lowaddr;
>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>> index 437e214..89bc70e 100644
>> --- a/hw/ppc/sam460ex.c
>> +++ b/hw/ppc/sam460ex.c
>> @@ -439,7 +439,8 @@ static void sam460ex_init(MachineState *machine)
>>
>>              success =3D load_elf(machine->kernel_filename, NULL,
>>                                 NULL, NULL, &elf_entry,
>> -                               &elf_lowaddr, NULL, 1, PPC_ELF_MACHINE=
, 0,
>> 0);
>> +                               &elf_lowaddr, NULL, NULL, 1,
>> PPC_ELF_MACHINE, 0,
>> +                               0);
>>              entry =3D elf_entry;
>>              loadaddr =3D elf_lowaddr;
>>          }
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 02cf53f..a0076e5 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2895,13 +2895,13 @@ static void spapr_machine_init(MachineState
>> *machine)
>>
>>          spapr->kernel_size =3D load_elf(kernel_filename, NULL,
>>                                        translate_kernel_address, NULL,
>> -                                      NULL, &lowaddr, NULL, 1,
>> +                                      NULL, &lowaddr, NULL, NULL, 1,
>>                                        PPC_ELF_MACHINE, 0, 0);
>>          if (spapr->kernel_size =3D=3D ELF_LOAD_WRONG_ENDIAN) {
>>              spapr->kernel_size =3D load_elf(kernel_filename, NULL,
>>                                            translate_kernel_address, N=
ULL,
>> NULL,
>> -                                          &lowaddr, NULL, 0,
>> PPC_ELF_MACHINE,
>> -                                          0, 0);
>> +                                          &lowaddr, NULL, NULL, 0,
>> +                                          PPC_ELF_MACHINE, 0, 0);
>>              spapr->kernel_le =3D spapr->kernel_size > 0;
>>          }
>>          if (spapr->kernel_size < 0) {
>> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
>> index 6862552..7526947 100644
>> --- a/hw/ppc/virtex_ml507.c
>> +++ b/hw/ppc/virtex_ml507.c
>> @@ -259,7 +259,7 @@ static void virtex_init(MachineState *machine)
>>
>>          /* Boots a kernel elf binary.  */
>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>> -                               &entry, &low, &high, 1, PPC_ELF_MACHIN=
E,
>> +                               &entry, &low, &high, NULL, 1,
>> PPC_ELF_MACHINE,
>>                                 0, 0);
>>          boot_info.bootstrap_pc =3D entry & 0x00ffffff;
>>
>> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
>> index 027303d..b8e7652 100644
>> --- a/hw/riscv/boot.c
>> +++ b/hw/riscv/boot.c
>> @@ -101,7 +101,7 @@ target_ulong riscv_load_firmware(const char
>> *firmware_filename,
>>      uint64_t firmware_entry, firmware_start, firmware_end;
>>
>>      if (load_elf(firmware_filename, NULL, NULL, NULL, &firmware_entry=
,
>> -                 &firmware_start, &firmware_end, 0, EM_RISCV, 1, 0) >=
 0) {
>> +                 &firmware_start, &firmware_end, NULL, 0, EM_RISCV, 1=
, 0)
>>> 0) {
>>          return firmware_entry;
>>      }
>>
>> @@ -119,7 +119,7 @@ target_ulong riscv_load_kernel(const char
>> *kernel_filename, symbol_fn_t sym_cb)
>>      uint64_t kernel_entry, kernel_high;
>>
>>      if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
>> -                         &kernel_entry, NULL, &kernel_high, 0,
>> +                         &kernel_entry, NULL, &kernel_high, NULL, 0,
>>                           EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
>>          return kernel_entry;
>>      }
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index ca544d6..49506e4 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -139,7 +139,7 @@ static void s390_ipl_realize(DeviceState *dev, Err=
or
>> **errp)
>>
>>          bios_size =3D load_elf(bios_filename, NULL,
>>                               bios_translate_addr, &fwbase,
>> -                             &ipl->bios_start_addr, NULL, NULL, 1,
>> +                             &ipl->bios_start_addr, NULL, NULL, NULL,=
 1,
>>                               EM_S390, 0, 0);
>>          if (bios_size > 0) {
>>              /* Adjust ELF start address to final location */
>> @@ -164,7 +164,7 @@ static void s390_ipl_realize(DeviceState *dev, Err=
or
>> **errp)
>>      if (ipl->kernel) {
>>          kernel_size =3D load_elf(ipl->kernel, NULL, NULL, NULL,
>>                                 &pentry, NULL,
>> -                               NULL, 1, EM_S390, 0, 0);
>> +                               NULL, NULL, 1, EM_S390, 0, 0);
>>          if (kernel_size < 0) {
>>              kernel_size =3D load_image_targphys(ipl->kernel, 0, ram_s=
ize);
>>              if (kernel_size < 0) {
>> @@ -473,7 +473,8 @@ static int load_netboot_image(Error **errp)
>>
>>      img_size =3D load_elf_ram(netboot_filename, NULL, NULL, NULL,
>>                              &ipl->start_addr,
>> -                            NULL, NULL, 1, EM_S390, 0, 0, NULL, false=
);
>> +                            NULL, NULL, NULL, 1, EM_S390, 0, 0, NULL,
>> +                            false);
>>
>>      if (img_size < 0) {
>>          img_size =3D load_image_size(netboot_filename, ram_ptr, ram_s=
ize);
>> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
>> index 8038887..f5a087d 100644
>> --- a/hw/sparc/leon3.c
>> +++ b/hw/sparc/leon3.c
>> @@ -297,7 +297,7 @@ static void leon3_generic_hw_init(MachineState
>> *machine)
>>          uint64_t entry;
>>
>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>> -                               &entry, NULL, NULL,
>> +                               &entry, NULL, NULL, NULL,
>>                                 1 /* big endian */, EM_SPARC, 0, 0);
>>          if (kernel_size < 0) {
>>              kernel_size =3D load_uimage(kernel_filename, NULL, &entry=
,
>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>> index 2aaa5bf..d404353 100644
>> --- a/hw/sparc/sun4m.c
>> +++ b/hw/sparc/sun4m.c
>> @@ -270,7 +270,7 @@ static unsigned long sun4m_load_kernel(const char
>> *kernel_filename,
>>  #endif
>>          kernel_size =3D load_elf(kernel_filename, NULL,
>>                                 translate_kernel_address, NULL,
>> -                               NULL, NULL, NULL, 1, EM_SPARC, 0, 0);
>> +                               NULL, NULL, NULL, NULL, 1, EM_SPARC, 0=
, 0);
>>          if (kernel_size < 0)
>>              kernel_size =3D load_aout(kernel_filename, KERNEL_LOAD_AD=
DR,
>>                                      RAM_size - KERNEL_LOAD_ADDR,
>> bswap_needed,
>> @@ -721,7 +721,7 @@ static void prom_init(hwaddr addr, const char
>> *bios_name)
>>      if (filename) {
>>          ret =3D load_elf(filename, NULL,
>>                         translate_prom_address, &addr, NULL,
>> -                       NULL, NULL, 1, EM_SPARC, 0, 0);
>> +                       NULL, NULL, NULL, 1, EM_SPARC, 0, 0);
>>          if (ret < 0 || ret > PROM_SIZE_MAX) {
>>              ret =3D load_image_targphys(filename, addr, PROM_SIZE_MAX=
);
>>          }
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index 9550827..c746040 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -175,7 +175,8 @@ static uint64_t sun4u_load_kernel(const char
>> *kernel_filename,
>>          bswap_needed =3D 0;
>>  #endif
>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>> kernel_entry,
>> -                               kernel_addr, &kernel_top, 1, EM_SPARCV=
9,
>> 0, 0);
>> +                               kernel_addr, &kernel_top, NULL, 1,
>> EM_SPARCV9, 0,
>> +                               0);
>>          if (kernel_size < 0) {
>>              *kernel_addr =3D KERNEL_LOAD_ADDR;
>>              *kernel_entry =3D KERNEL_LOAD_ADDR;
>> @@ -439,7 +440,7 @@ static void prom_init(hwaddr addr, const char
>> *bios_name)
>>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>>      if (filename) {
>>          ret =3D load_elf(filename, NULL, translate_prom_address, &add=
r,
>> -                       NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);
>> +                       NULL, NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);
>>          if (ret < 0 || ret > PROM_SIZE_MAX) {
>>              ret =3D load_image_targphys(filename, addr, PROM_SIZE_MAX=
);
>>          }
>> diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_
>> testboard.c
>> index aef3289..20c9ccb 100644
>> --- a/hw/tricore/tricore_testboard.c
>> +++ b/hw/tricore/tricore_testboard.c
>> @@ -42,7 +42,7 @@ static void tricore_load_kernel(CPUTriCoreState *env=
)
>>
>>      kernel_size =3D load_elf(tricoretb_binfo.kernel_filename, NULL,
>>                             NULL, NULL, &entry, NULL,
>> -                           NULL, 0,
>> +                           NULL, NULL, 0,
>>                             EM_TRICORE, 1, 0);
>>      if (kernel_size <=3D 0) {
>>          error_report("no kernel file '%s'",
>> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
>> index a22743a..aeb46d8 100644
>> --- a/hw/xtensa/sim.c
>> +++ b/hw/xtensa/sim.c
>> @@ -108,7 +108,7 @@ void xtensa_sim_load_kernel(XtensaCPU *cpu,
>> MachineState *machine)
>>          uint64_t elf_entry;
>>          uint64_t elf_lowaddr;
>>          int success =3D load_elf(kernel_filename, NULL,
>> translate_phys_addr, cpu,
>> -                               &elf_entry, &elf_lowaddr, NULL, big_en=
dian,
>> +                               &elf_entry, &elf_lowaddr, NULL, NULL,
>> big_endian,
>>                                 EM_XTENSA, 0, 0);
>>
>>          if (success > 0) {
>> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
>> index 8220c7a..8e2dd13 100644
>> --- a/hw/xtensa/xtfpga.c
>> +++ b/hw/xtensa/xtfpga.c
>> @@ -415,7 +415,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *boa=
rd,
>> MachineState *machine)
>>          uint64_t elf_entry;
>>          uint64_t elf_lowaddr;
>>          int success =3D load_elf(kernel_filename, NULL,
>> translate_phys_addr, cpu,
>> -                &elf_entry, &elf_lowaddr, NULL, be, EM_XTENSA, 0, 0);
>> +                &elf_entry, &elf_lowaddr, NULL, NULL, be, EM_XTENSA, =
0,
>> 0);
>>          if (success > 0) {
>>              entry_point =3D elf_entry;
>>          } else {
>> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
>> index e07d276..a1411bf 100644
>> --- a/include/hw/elf_ops.h
>> +++ b/include/hw/elf_ops.h
>> @@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, in=
t fd,
>>                                void *translate_opaque,
>>                                int must_swab, uint64_t *pentry,
>>                                uint64_t *lowaddr, uint64_t *highaddr,
>> -                              int elf_machine, int clear_lsb, int
>> data_swab,
>> +                              uint32_t *pflags, int elf_machine,
>> +                              int clear_lsb, int data_swab,
>>                                AddressSpace *as, bool load_rom,
>>                                symbol_fn_t sym_cb)
>>  {
>> @@ -389,6 +390,9 @@ static int glue(load_elf, SZ)(const char *name, in=
t fd,
>>              }
>>      }
>>
>> +    if (pflags) {
>> +        *pflags =3D (elf_word)ehdr.e_flags;
>> +    }
>>      if (pentry)
>>          *pentry =3D (uint64_t)(elf_sword)ehdr.e_entry;
>>
>> diff --git a/include/hw/loader.h b/include/hw/loader.h
>> index 48a96cd..a9eeea3 100644
>> --- a/include/hw/loader.h
>> +++ b/include/hw/loader.h
>> @@ -101,6 +101,7 @@ const char *load_elf_strerror(int error);
>>   * @pentry: Populated with program entry point. Ignored if NULL.
>>   * @lowaddr: Populated with lowest loaded address. Ignored if NULL.
>>   * @highaddr: Populated with highest loaded address. Ignored if NULL.
>> + * @pflags: Populated with ELF processor-specific flags. Ignore if NU=
LL.
>>   * @bigendian: Expected ELF endianness. 0 for LE otherwise BE
>>   * @elf_machine: Expected ELF machine type
>>   * @clear_lsb: Set to mask off LSB of addresses (Some architectures u=
se
>> @@ -131,8 +132,9 @@ int load_elf_ram_sym(const char *filename,
>>                       uint64_t (*elf_note_fn)(void *, void *, bool),
>>                       uint64_t (*translate_fn)(void *, uint64_t),
>>                       void *translate_opaque, uint64_t *pentry,
>> -                     uint64_t *lowaddr, uint64_t *highaddr, int
>> big_endian,
>> -                     int elf_machine, int clear_lsb, int data_swab,
>> +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t
>> *pflags,
>> +                     int big_endian, int elf_machine,
>> +                     int clear_lsb, int data_swab,
>>                       AddressSpace *as, bool load_rom, symbol_fn_t sym=
_cb);
>>
>>  /** load_elf_ram:
>> @@ -143,9 +145,9 @@ int load_elf_ram(const char *filename,
>>                   uint64_t (*elf_note_fn)(void *, void *, bool),
>>                   uint64_t (*translate_fn)(void *, uint64_t),
>>                   void *translate_opaque, uint64_t *pentry, uint64_t
>> *lowaddr,
>> -                 uint64_t *highaddr, int big_endian, int elf_machine,
>> -                 int clear_lsb, int data_swab, AddressSpace *as,
>> -                 bool load_rom);
>> +                 uint64_t *highaddr, uint32_t *pflags, int big_endian=
,
>> +                 int elf_machine, int clear_lsb, int data_swab,
>> +                 AddressSpace *as, bool load_rom);
>>
>>  /** load_elf_as:
>>   * Same as load_elf_ram(), but always loads the elf as ROM
>> @@ -154,8 +156,9 @@ int load_elf_as(const char *filename,
>>                  uint64_t (*elf_note_fn)(void *, void *, bool),
>>                  uint64_t (*translate_fn)(void *, uint64_t),
>>                  void *translate_opaque, uint64_t *pentry, uint64_t
>> *lowaddr,
>> -                uint64_t *highaddr, int big_endian, int elf_machine,
>> -                int clear_lsb, int data_swab, AddressSpace *as);
>> +                uint64_t *highaddr, uint32_t *pflags, int big_endian,
>> +                int elf_machine, int clear_lsb, int data_swab,
>> +                AddressSpace *as);
>>
>>  /** load_elf:
>>   * Same as load_elf_as(), but doesn't allow the caller to specify an
>> @@ -165,8 +168,8 @@ int load_elf(const char *filename,
>>               uint64_t (*elf_note_fn)(void *, void *, bool),
>>               uint64_t (*translate_fn)(void *, uint64_t),
>>               void *translate_opaque, uint64_t *pentry, uint64_t *lowa=
ddr,
>> -             uint64_t *highaddr, int big_endian, int elf_machine,
>> -             int clear_lsb, int data_swab);
>> +             uint64_t *highaddr, uint32_t *pflags, int big_endian,
>> +             int elf_machine, int clear_lsb, int data_swab);
>>
>>  /** load_elf_hdr:
>>   * @filename: Path of ELF file
>> --
>> 2.7.4
>>
>>
>>
>
--3866299591-477311962-1580215357=:9839--

