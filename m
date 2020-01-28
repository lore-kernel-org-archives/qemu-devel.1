Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C092AC33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5366424686
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvBYHx31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5366424686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwNi6-0001kB-Cx
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 05:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwNh0-00018F-P9
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwNgq-0003L0-HK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:01:58 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iwNgn-0003JU-Bn
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:01:46 -0500
Received: by mail-ot1-x342.google.com with SMTP id g15so11452773otp.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 02:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=th4T5sylbMcZJETqJaTeGdK8cK0kPrID0STpO5eEuIs=;
 b=qvBYHx312J3XfheUNbZzbW8UyugqZyqDzhwt/MAFy0dco4uWi7g9EIc0gvW0Yj4io5
 NHXA6S3u00peU+t87cfkAKPq1Df5ZLr7EffmFmuJzM+78R+NZTrVT2ekLX60QxEbdra6
 h1Du5kPVG0DJRj/FlZZGh7O0QzqzQ2D6tzAG8KrTOHHgz+p9LoC27eFUuC4gecnR59Bn
 TbtUOWE5ZnUC2a3AnM+m+aLBt3vPvl2ESuivQFYf17NU6rMZANaY4fnk1PX/lITUWgmO
 +Ve20YBY0uW1+sBkopwvLp+ygAJYfubjFPp0FR/nF/S3LySaOcKobVA5erhKIsMowLsf
 V+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=th4T5sylbMcZJETqJaTeGdK8cK0kPrID0STpO5eEuIs=;
 b=QFGZ2I4zjoeWvsg0pIWuZ/l2TMDkTf8W2iLeajwDr4VouP+J4MSrffFucsH+a+eViQ
 JsfY6Wbwd46hog4VgNhn97vNwmMWIoxvTCUsCKPeGSgK9tmJA5tROG0WRHikvHPRj4il
 M3H5+XYqv6bPBYp64LVK7V8+FPNA34vXUDncuPSR3+eJqCbysHrlrasfggxjVx67ug0K
 54vk/XEulqNu2fdiLKCMOcc93BNiNOWdnskPXdsf+0Nd26f1CucUVm4EbWOes9X8Ciey
 KbpAERDnqUBAFTZaI7thU3UXQJXpCmuZFUz3HtYGQDwZn6sQ/4rkCZVGVXek1+wfC2v/
 pzyw==
X-Gm-Message-State: APjAAAWk3BVelFbYJ2CMVrSO4zfpQS+DCGo0NPAgCTR9iDO8FmJ7mpmx
 aKtju7oZeVquOvirEmppeoPItk3NVPWjQbnGQNQ=
X-Google-Smtp-Source: APXvYqyjMcxmm2sasmnHd0Z0obUkiXo2xVGtmiJERCvGPbJYfKQAxQh/abXCmtTS9oQetRffYs1/IvM6E4G161YEdc0=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr15673784otp.306.1580205704011; 
 Tue, 28 Jan 2020 02:01:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 28 Jan 2020 02:01:43 -0800 (PST)
In-Reply-To: <1580079311-20447-24-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-24-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 28 Jan 2020 11:01:43 +0100
Message-ID: <CAL1e-=hG=NoQWpxQ5xOkyLM7kYpsoZOohTWU1eYr-fLp=Ud_MA@mail.gmail.com>
Subject: Re: [PATCH rc3 23/30] hw/core/loader: Let load_elf populate the
 processor-specific flags
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: multipart/alternative; boundary="000000000000a8e4d1059d304f94"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>,
 Michael Rolnik <mrolnik@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a8e4d1059d304f94
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sunday, January 26, 2020, Aleksandar Markovic <
aleksandar.markovic@rt-rk.com> wrote:

> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Some platforms (like AVR) need to determine cpu type by reading
> the ELF flags (field e_flags oin ELF header).
>
> This patch enables discovery of the content of that flag while
> using following functions:
>
>   - load_elf()
>   - load_elf_as()
>   - load_elf_ram()
>   - load_elf_ram_sym()
>
> The added argument of these functions is of type uint32_t*. It is
> allowed to pass NULL as that argument, and in such case no lookup
> to the field e_flags will happen, and of course, no information
> will be returned to the caller.
>
>
We plan to use this new functionality for MIPS Malta board, for detection
of incompatible cpu/kernel combinations, and graceful exit (right now these
combinations result in hang or crash). I would say other boards could make
use of it too.

For that reason, if there is no objection, I plan to select this patch for
next MIPS queue.

Regards,
Aleksandar




> CC: Richard Henderson <rth@twiddle.net>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> CC: Michael Walle <michael@walle.cc>
> CC: Thomas Huth <huth@tuxfamily.org>
> CC: Laurent Vivier <laurent@vivier.eu>
> CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> CC: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> CC: Aurelien Jarno <aurelien@aurel32.net>
> CC: Jia Liu <proljc@gmail.com>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: BALATON Zoltan <balaton@eik.bme.hu>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> CC: Thomas Huth <thuth@redhat.com>
> CC: Artyom Tarasenko <atar4qemu@gmail.com>
> CC: Fabien Chouteau <chouteau@adacore.com>
> CC: KONRAD Frederic <frederic.konrad@adacore.com>
> CC: Max Filippov <jcmvbkbc@gmail.com>
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> [PMD: Extracted from bigger patch,
>       Replaced 'uint32_t *pe_flags' by 'int proc_flags']
> [AM: Replaced 'int proc_flags' with 'uint32_t *pflags',
>      replaced one instance of 'elf_sword' to 'elf_word',
>      extended functionality to load_elf()]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> ---
>  hw/alpha/dp264.c               |  4 ++--
>  hw/arm/armv7m.c                |  2 +-
>  hw/arm/boot.c                  |  2 +-
>  hw/core/generic-loader.c       |  2 +-
>  hw/core/loader.c               | 37 +++++++++++++++++++-----------------=
-
>  hw/cris/boot.c                 |  2 +-
>  hw/hppa/machine.c              |  4 ++--
>  hw/i386/multiboot.c            |  2 +-
>  hw/i386/x86.c                  |  2 +-
>  hw/lm32/lm32_boards.c          |  4 ++--
>  hw/lm32/milkymist.c            |  2 +-
>  hw/m68k/an5206.c               |  2 +-
>  hw/m68k/mcf5208.c              |  2 +-
>  hw/m68k/q800.c                 |  2 +-
>  hw/microblaze/boot.c           |  4 ++--
>  hw/mips/mips_fulong2e.c        |  2 +-
>  hw/mips/mips_malta.c           |  3 ++-
>  hw/mips/mips_mipssim.c         |  2 +-
>  hw/mips/mips_r4k.c             |  2 +-
>  hw/moxie/moxiesim.c            |  2 +-
>  hw/nios2/boot.c                |  4 ++--
>  hw/openrisc/openrisc_sim.c     |  2 +-
>  hw/pci-host/prep.c             |  3 ++-
>  hw/ppc/e500.c                  |  2 +-
>  hw/ppc/mac_newworld.c          |  4 ++--
>  hw/ppc/mac_oldworld.c          |  4 ++--
>  hw/ppc/ppc440_bamboo.c         |  2 +-
>  hw/ppc/sam460ex.c              |  3 ++-
>  hw/ppc/spapr.c                 |  6 +++---
>  hw/ppc/virtex_ml507.c          |  2 +-
>  hw/riscv/boot.c                |  4 ++--
>  hw/s390x/ipl.c                 |  7 ++++---
>  hw/sparc/leon3.c               |  2 +-
>  hw/sparc/sun4m.c               |  4 ++--
>  hw/sparc64/sun4u.c             |  5 +++--
>  hw/tricore/tricore_testboard.c |  2 +-
>  hw/xtensa/sim.c                |  2 +-
>  hw/xtensa/xtfpga.c             |  2 +-
>  include/hw/elf_ops.h           |  6 +++++-
>  include/hw/loader.h            | 21 ++++++++++++---------
>  40 files changed, 92 insertions(+), 79 deletions(-)
>
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index f2026fd..a8f9a89 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -115,7 +115,7 @@ static void clipper_init(MachineState *machine)
>          exit(1);
>      }
>      size =3D load_elf(palcode_filename, NULL, cpu_alpha_superpage_to_phy=
s,
> -                    NULL, &palcode_entry, &palcode_low, &palcode_high,
> +                    NULL, &palcode_entry, &palcode_low, &palcode_high,
> NULL,
>                      0, EM_ALPHA, 0, 0);
>      if (size < 0) {
>          error_report("could not load palcode '%s'", palcode_filename);
> @@ -134,7 +134,7 @@ static void clipper_init(MachineState *machine)
>          uint64_t param_offset;
>
>          size =3D load_elf(kernel_filename, NULL,
> cpu_alpha_superpage_to_phys,
> -                        NULL, &kernel_entry, &kernel_low, &kernel_high,
> +                        NULL, &kernel_entry, &kernel_low, &kernel_high,
> NULL,
>                          0, EM_ALPHA, 0, 0);
>          if (size < 0) {
>              error_report("could not load kernel '%s'", kernel_filename);
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 7a3c48f..e4fc9a8 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -331,7 +331,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char
> *kernel_filename, int mem_size)
>
>      if (kernel_filename) {
>          image_size =3D load_elf_as(kernel_filename, NULL, NULL, NULL,
> -                                 &entry, &lowaddr,
> +                                 &entry, &lowaddr, NULL,
>                                   NULL, big_endian, EM_ARM, 1, 0, as);
>          if (image_size < 0) {
>              image_size =3D load_image_targphys_as(kernel_filename, 0,
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 8fb4a63..0c213ca 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -903,7 +903,7 @@ static int64_t arm_load_elf(struct arm_boot_info
> *info, uint64_t *pentry,
>      }
>
>      ret =3D load_elf_as(info->kernel_filename, NULL, NULL, NULL,
> -                      pentry, lowaddr, highaddr, big_endian, elf_machine=
,
> +                      pentry, lowaddr, highaddr, NULL, big_endian,
> elf_machine,
>                        1, data_swab, as);
>      if (ret <=3D 0) {
>          /* The header loaded but the image didn't */
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index 4b1fc86..1e5ccb7 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -140,7 +140,7 @@ static void generic_loader_realize(DeviceState *dev,
> Error **errp)
>
>          if (!s->force_raw) {
>              size =3D load_elf_as(s->file, NULL, NULL, NULL, &entry, NULL=
,
> NULL,
> -                               big_endian, 0, 0, 0, as);
> +                               NULL, big_endian, 0, 0, 0, as);
>
>              if (size < 0) {
>                  size =3D load_uimage_as(s->file, &entry, NULL, NULL, NUL=
L,
> NULL,
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 5099f27..d1b78f6 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -406,12 +406,12 @@ int load_elf(const char *filename,
>               uint64_t (*elf_note_fn)(void *, void *, bool),
>               uint64_t (*translate_fn)(void *, uint64_t),
>               void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr=
,
> -             uint64_t *highaddr, int big_endian, int elf_machine,
> -             int clear_lsb, int data_swab)
> +             uint64_t *highaddr, uint32_t *pflags, int big_endian,
> +             int elf_machine, int clear_lsb, int data_swab)
>  {
>      return load_elf_as(filename, elf_note_fn, translate_fn,
> translate_opaque,
> -                       pentry, lowaddr, highaddr, big_endian, elf_machin=
e,
> -                       clear_lsb, data_swab, NULL);
> +                       pentry, lowaddr, highaddr, pflags, big_endian,
> +                       elf_machine, clear_lsb, data_swab, NULL);
>  }
>
>  /* return < 0 if error, otherwise the number of bytes loaded in memory *=
/
> @@ -419,12 +419,12 @@ int load_elf_as(const char *filename,
>                  uint64_t (*elf_note_fn)(void *, void *, bool),
>                  uint64_t (*translate_fn)(void *, uint64_t),
>                  void *translate_opaque, uint64_t *pentry, uint64_t
> *lowaddr,
> -                uint64_t *highaddr, int big_endian, int elf_machine,
> -                int clear_lsb, int data_swab, AddressSpace *as)
> +                uint64_t *highaddr, uint32_t *pflags, int big_endian,
> +                int elf_machine, int clear_lsb, int data_swab,
> AddressSpace *as)
>  {
>      return load_elf_ram(filename, elf_note_fn, translate_fn,
> translate_opaque,
> -                        pentry, lowaddr, highaddr, big_endian,
> elf_machine,
> -                        clear_lsb, data_swab, as, true);
> +                        pentry, lowaddr, highaddr, pflags, big_endian,
> +                        elf_machine, clear_lsb, data_swab, as, true);
>  }
>
>  /* return < 0 if error, otherwise the number of bytes loaded in memory *=
/
> @@ -432,13 +432,13 @@ int load_elf_ram(const char *filename,
>                   uint64_t (*elf_note_fn)(void *, void *, bool),
>                   uint64_t (*translate_fn)(void *, uint64_t),
>                   void *translate_opaque, uint64_t *pentry, uint64_t
> *lowaddr,
> -                 uint64_t *highaddr, int big_endian, int elf_machine,
> -                 int clear_lsb, int data_swab, AddressSpace *as,
> -                 bool load_rom)
> +                 uint64_t *highaddr, uint32_t *pflags, int big_endian,
> +                 int elf_machine, int clear_lsb, int data_swab,
> +                 AddressSpace *as, bool load_rom)
>  {
>      return load_elf_ram_sym(filename, elf_note_fn,
>                              translate_fn, translate_opaque,
> -                            pentry, lowaddr, highaddr, big_endian,
> +                            pentry, lowaddr, highaddr, pflags, big_endia=
n,
>                              elf_machine, clear_lsb, data_swab, as,
>                              load_rom, NULL);
>  }
> @@ -448,8 +448,9 @@ int load_elf_ram_sym(const char *filename,
>                       uint64_t (*elf_note_fn)(void *, void *, bool),
>                       uint64_t (*translate_fn)(void *, uint64_t),
>                       void *translate_opaque, uint64_t *pentry,
> -                     uint64_t *lowaddr, uint64_t *highaddr, int
> big_endian,
> -                     int elf_machine, int clear_lsb, int data_swab,
> +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t
> *pflags,
> +                     int big_endian, int elf_machine,
> +                     int clear_lsb, int data_swab,
>                       AddressSpace *as, bool load_rom, symbol_fn_t sym_cb=
)
>  {
>      int fd, data_order, target_data_order, must_swab, ret =3D
> ELF_LOAD_FAILED;
> @@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,
>      if (e_ident[EI_CLASS] =3D=3D ELFCLASS64) {
>          ret =3D load_elf64(filename, fd, elf_note_fn,
>                           translate_fn, translate_opaque, must_swab,
> -                         pentry, lowaddr, highaddr, elf_machine,
> clear_lsb,
> -                         data_swab, as, load_rom, sym_cb);
> +                         pentry, lowaddr, highaddr, pflags, elf_machine,
> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>      } else {
>          ret =3D load_elf32(filename, fd, elf_note_fn,
>                           translate_fn, translate_opaque, must_swab,
> -                         pentry, lowaddr, highaddr, elf_machine,
> clear_lsb,
> -                         data_swab, as, load_rom, sym_cb);
> +                         pentry, lowaddr, highaddr, pflags, elf_machine,
> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>      }
>
>   fail:
> diff --git a/hw/cris/boot.c b/hw/cris/boot.c
> index 2d2cc0c..b8947bc 100644
> --- a/hw/cris/boot.c
> +++ b/hw/cris/boot.c
> @@ -76,7 +76,7 @@ void cris_load_image(CRISCPU *cpu, struct cris_load_inf=
o
> *li)
>         devboard SDK.  */
>      image_size =3D load_elf(li->image_filename, NULL,
>                            translate_kernel_address, NULL,
> -                          &entry, NULL, &high, 0, EM_CRIS, 0, 0);
> +                          &entry, NULL, &high, NULL, 0, EM_CRIS, 0, 0);
>      li->entry =3D entry;
>      if (image_size < 0) {
>          /* Takes a kimage from the axis devboard SDK.  */
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 5d0de26..0ab36cf 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -140,7 +140,7 @@ static void machine_hppa_init(MachineState *machine)
>      }
>
>      size =3D load_elf(firmware_filename, NULL, NULL, NULL,
> -                    &firmware_entry, &firmware_low, &firmware_high,
> +                    &firmware_entry, &firmware_low, &firmware_high, NULL=
,
>                      true, EM_PARISC, 0, 0);
>
>      /* Unfortunately, load_elf sign-extends reading elf32.  */
> @@ -169,7 +169,7 @@ static void machine_hppa_init(MachineState *machine)
>      /* Load kernel */
>      if (kernel_filename) {
>          size =3D load_elf(kernel_filename, NULL, &cpu_hppa_to_phys,
> -                        NULL, &kernel_entry, &kernel_low, &kernel_high,
> +                        NULL, &kernel_entry, &kernel_low, &kernel_high,
> NULL,
>                          true, EM_PARISC, 0, 0);
>
>          /* Unfortunately, load_elf sign-extends reading elf32.  */
> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> index 9a59f95..9e7d69d 100644
> --- a/hw/i386/multiboot.c
> +++ b/hw/i386/multiboot.c
> @@ -199,7 +199,7 @@ int load_multiboot(FWCfgState *fw_cfg,
>          }
>
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> &elf_entry,
> -                               &elf_low, &elf_high, 0, I386_ELF_MACHINE,
> +                               &elf_low, &elf_high, NULL, 0,
> I386_ELF_MACHINE,
>                                 0, 0);
>          if (kernel_size < 0) {
>              error_report("Error while loading elf kernel");
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 9b9a4d5..7f38e6b 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -413,7 +413,7 @@ static bool load_elfboot(const char *kernel_filename,
>      uint64_t elf_note_type =3D XEN_ELFNOTE_PHYS32_ENTRY;
>      kernel_size =3D load_elf(kernel_filename, read_pvh_start_addr,
>                             NULL, &elf_note_type, &elf_entry,
> -                           &elf_low, &elf_high, 0, I386_ELF_MACHINE,
> +                           &elf_low, &elf_high, NULL, 0, I386_ELF_MACHIN=
E,
>                             0, 0);
>
>      if (kernel_size < 0) {
> diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
> index 5ae308b..d1894ad 100644
> --- a/hw/lm32/lm32_boards.c
> +++ b/hw/lm32/lm32_boards.c
> @@ -138,7 +138,7 @@ static void lm32_evr_init(MachineState *machine)
>          int kernel_size;
>
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> -                               &entry, NULL, NULL,
> +                               &entry, NULL, NULL, NULL,
>                                 1, EM_LATTICEMICO32, 0, 0);
>          reset_info->bootstrap_pc =3D entry;
>
> @@ -232,7 +232,7 @@ static void lm32_uclinux_init(MachineState *machine)
>          int kernel_size;
>
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> -                               &entry, NULL, NULL,
> +                               &entry, NULL, NULL, NULL,
>                                 1, EM_LATTICEMICO32, 0, 0);
>          reset_info->bootstrap_pc =3D entry;
>
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index 460d322..6d46134 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -177,7 +177,7 @@ milkymist_init(MachineState *machine)
>
>          /* Boots a kernel elf binary.  */
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> -                               &entry, NULL, NULL,
> +                               &entry, NULL, NULL, NULL,
>                                 1, EM_LATTICEMICO32, 0, 0);
>          reset_info->bootstrap_pc =3D entry;
>
> diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
> index 54ccbe1..bed43a9 100644
> --- a/hw/m68k/an5206.c
> +++ b/hw/m68k/an5206.c
> @@ -65,7 +65,7 @@ static void an5206_init(MachineState *machine)
>      }
>
>      kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL, &elf_ent=
ry,
> -                           NULL, NULL, 1, EM_68K, 0, 0);
> +                           NULL, NULL, NULL, 1, EM_68K, 0, 0);
>      entry =3D elf_entry;
>      if (kernel_size < 0) {
>          kernel_size =3D load_uimage(kernel_filename, &entry, NULL, NULL,
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index 158c5e4..a999c21 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -329,7 +329,7 @@ static void mcf5208evb_init(MachineState *machine)
>      }
>
>      kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL, &elf_ent=
ry,
> -                           NULL, NULL, 1, EM_68K, 0, 0);
> +                           NULL, NULL, NULL, 1, EM_68K, 0, 0);
>      entry =3D elf_entry;
>      if (kernel_size < 0) {
>          kernel_size =3D load_uimage(kernel_filename, &entry, NULL, NULL,
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 12491ec..1e32363 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -342,7 +342,7 @@ static void q800_init(MachineState *machine)
>      if (linux_boot) {
>          uint64_t high;
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> -                               &elf_entry, NULL, &high, 1,
> +                               &elf_entry, NULL, &high, NULL, 1,
>                                 EM_68K, 0, 0);
>          if (kernel_size < 0) {
>              error_report("could not load kernel '%s'", kernel_filename);
> diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
> index d1d7dfb..925e3f7 100644
> --- a/hw/microblaze/boot.c
> +++ b/hw/microblaze/boot.c
> @@ -145,13 +145,13 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu,
> hwaddr ddr_base,
>
>          /* Boots a kernel elf binary.  */
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> -                               &entry, &low, &high,
> +                               &entry, &low, &high, NULL,
>                                 big_endian, EM_MICROBLAZE, 0, 0);
>          base32 =3D entry;
>          if (base32 =3D=3D 0xc0000000) {
>              kernel_size =3D load_elf(kernel_filename, NULL,
>                                     translate_kernel_address, NULL,
> -                                   &entry, NULL, NULL,
> +                                   &entry, NULL, NULL, NULL,
>                                     big_endian, EM_MICROBLAZE, 0, 0);
>          }
>          /* Always boot into physical ram.  */
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 9eaa6e2..2e043cb 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -119,7 +119,7 @@ static int64_t load_kernel(CPUMIPSState *env)
>                             cpu_mips_kseg0_to_phys, NULL,
>                             (uint64_t *)&kernel_entry,
>                             (uint64_t *)&kernel_low, (uint64_t
> *)&kernel_high,
> -                           0, EM_MIPS, 1, 0);
> +                           NULL, 0, EM_MIPS, 1, 0);
>      if (kernel_size < 0) {
>          error_report("could not load kernel '%s': %s",
>                       loaderparams.kernel_filename,
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 5aaeaa8..34b76bb 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1039,7 +1039,8 @@ static int64_t load_kernel(void)
>      kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
>                             cpu_mips_kseg0_to_phys, NULL,
>                             (uint64_t *)&kernel_entry, NULL,
> -                           (uint64_t *)&kernel_high, big_endian, EM_MIPS=
,
> 1, 0);
> +                           (uint64_t *)&kernel_high, NULL, big_endian,
> EM_MIPS,
> +                           1, 0);
>      if (kernel_size < 0) {
>          error_report("could not load kernel '%s': %s",
>                       loaderparams.kernel_filename,
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 84c03dd..b934ca9 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -74,7 +74,7 @@ static int64_t load_kernel(void)
>      kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
>                             cpu_mips_kseg0_to_phys, NULL,
>                             (uint64_t *)&entry, NULL,
> -                           (uint64_t *)&kernel_high, big_endian,
> +                           (uint64_t *)&kernel_high, NULL, big_endian,
>                             EM_MIPS, 1, 0);
>      if (kernel_size >=3D 0) {
>          if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000) {
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index fd926a3..b2aec43 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -98,7 +98,7 @@ static int64_t load_kernel(void)
>      kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
>                             cpu_mips_kseg0_to_phys, NULL,
>                             (uint64_t *)&entry, NULL,
> -                           (uint64_t *)&kernel_high, big_endian,
> +                           (uint64_t *)&kernel_high, NULL, big_endian,
>                             EM_MIPS, 1, 0);
>      if (kernel_size >=3D 0) {
>          if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000) {
> diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
> index 57af1b4..1d06e39 100644
> --- a/hw/moxie/moxiesim.c
> +++ b/hw/moxie/moxiesim.c
> @@ -58,7 +58,7 @@ static void load_kernel(MoxieCPU *cpu, LoaderParams
> *loader_params)
>      ram_addr_t initrd_offset;
>
>      kernel_size =3D load_elf(loader_params->kernel_filename,  NULL, NULL=
,
> NULL,
> -                           &entry, &kernel_low, &kernel_high, 1, EM_MOXI=
E,
> +                           &entry, &kernel_low, &kernel_high, NULL, 1,
> EM_MOXIE,
>                             0, 0);
>
>      if (kernel_size <=3D 0) {
> diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
> index d78bc9e..46b8349 100644
> --- a/hw/nios2/boot.c
> +++ b/hw/nios2/boot.c
> @@ -147,7 +147,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base=
,
>
>          /* Boots a kernel elf binary. */
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> -                               &entry, &low, &high,
> +                               &entry, &low, &high, NULL,
>                                 big_endian, EM_ALTERA_NIOS2, 0, 0);
>          if ((uint32_t)entry =3D=3D 0xc0000000) {
>              /*
> @@ -158,7 +158,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base=
,
>               */
>              kernel_size =3D load_elf(kernel_filename, NULL,
>                                     translate_kernel_address, NULL,
> -                                   &entry, NULL, NULL,
> +                                   &entry, NULL, NULL, NULL,
>                                     big_endian, EM_ALTERA_NIOS2, 0, 0);
>              boot_info.bootstrap_pc =3D ddr_base + 0xc0000000 +
>                  (entry & 0x07ffffff);
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index 79e7049..ad53712 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -98,7 +98,7 @@ static void openrisc_load_kernel(ram_addr_t ram_size,
>
>      if (kernel_filename && !qtest_enabled()) {
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> -                               &elf_entry, NULL, NULL, 1, EM_OPENRISC,
> +                               &elf_entry, NULL, NULL, NULL, 1,
> EM_OPENRISC,
>                                 1, 0);
>          entry =3D elf_entry;
>          if (kernel_size < 0) {
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index afa136d..fcf6235 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -335,7 +335,8 @@ static void raven_realize(PCIDevice *d, Error **errp)
>          if (filename) {
>              if (s->elf_machine !=3D EM_NONE) {
>                  bios_size =3D load_elf(filename, NULL, NULL, NULL, NULL,
> -                                     NULL, NULL, 1, s->elf_machine, 0, 0=
);
> +                                     NULL, NULL, NULL, 1, s->elf_machine=
,
> +                                     0, 0);
>              }
>              if (bios_size < 0) {
>                  bios_size =3D get_image_size(filename);
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 12b6a5b..886442e 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -1049,7 +1049,7 @@ void ppce500_init(MachineState *machine)
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, payload_name);
>
>      payload_size =3D load_elf(filename, NULL, NULL, NULL,
> -                            &bios_entry, &loadaddr, NULL,
> +                            &bios_entry, &loadaddr, NULL, NULL,
>                              1, PPC_ELF_MACHINE, 0, 0);
>      if (payload_size < 0) {
>          /*
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 3594517..464d012 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -168,7 +168,7 @@ static void ppc_core99_init(MachineState *machine)
>      /* Load OpenBIOS (ELF) */
>      if (filename) {
>          bios_size =3D load_elf(filename, NULL, NULL, NULL, NULL,
> -                             NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
> +                             NULL, NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0)=
;
>
>          g_free(filename);
>      } else {
> @@ -192,7 +192,7 @@ static void ppc_core99_init(MachineState *machine)
>
>          kernel_size =3D load_elf(kernel_filename, NULL,
>                                 translate_kernel_address, NULL,
> -                               NULL, &lowaddr, NULL, 1, PPC_ELF_MACHINE,
> +                               NULL, &lowaddr, NULL, NULL, 1,
> PPC_ELF_MACHINE,
>                                 0, 0);
>          if (kernel_size < 0)
>              kernel_size =3D load_aout(kernel_filename, kernel_base,
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 0fa680b..7318d7e 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -143,7 +143,7 @@ static void ppc_heathrow_init(MachineState *machine)
>
>      /* Load OpenBIOS (ELF) */
>      if (filename) {
> -        bios_size =3D load_elf(filename, NULL, 0, NULL, NULL, NULL, NULL=
,
> +        bios_size =3D load_elf(filename, NULL, 0, NULL, NULL, NULL, NULL=
,
> NULL,
>                               1, PPC_ELF_MACHINE, 0, 0);
>          g_free(filename);
>      } else {
> @@ -166,7 +166,7 @@ static void ppc_heathrow_init(MachineState *machine)
>          kernel_base =3D KERNEL_LOAD_ADDR;
>          kernel_size =3D load_elf(kernel_filename, NULL,
>                                 translate_kernel_address, NULL,
> -                               NULL, &lowaddr, NULL, 1, PPC_ELF_MACHINE,
> +                               NULL, &lowaddr, NULL, NULL, 1,
> PPC_ELF_MACHINE,
>                                 0, 0);
>          if (kernel_size < 0)
>              kernel_size =3D load_aout(kernel_filename, kernel_base,
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index b782641..da777ef 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -253,7 +253,7 @@ static void bamboo_init(MachineState *machine)
>                                NULL, NULL);
>          if (success < 0) {
>              success =3D load_elf(kernel_filename, NULL, NULL, NULL,
> &elf_entry,
> -                               &elf_lowaddr, NULL, 1, PPC_ELF_MACHINE,
> +                               &elf_lowaddr, NULL, NULL, 1,
> PPC_ELF_MACHINE,
>                                 0, 0);
>              entry =3D elf_entry;
>              loadaddr =3D elf_lowaddr;
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 437e214..89bc70e 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -439,7 +439,8 @@ static void sam460ex_init(MachineState *machine)
>
>              success =3D load_elf(machine->kernel_filename, NULL,
>                                 NULL, NULL, &elf_entry,
> -                               &elf_lowaddr, NULL, 1, PPC_ELF_MACHINE, 0=
,
> 0);
> +                               &elf_lowaddr, NULL, NULL, 1,
> PPC_ELF_MACHINE, 0,
> +                               0);
>              entry =3D elf_entry;
>              loadaddr =3D elf_lowaddr;
>          }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 02cf53f..a0076e5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2895,13 +2895,13 @@ static void spapr_machine_init(MachineState
> *machine)
>
>          spapr->kernel_size =3D load_elf(kernel_filename, NULL,
>                                        translate_kernel_address, NULL,
> -                                      NULL, &lowaddr, NULL, 1,
> +                                      NULL, &lowaddr, NULL, NULL, 1,
>                                        PPC_ELF_MACHINE, 0, 0);
>          if (spapr->kernel_size =3D=3D ELF_LOAD_WRONG_ENDIAN) {
>              spapr->kernel_size =3D load_elf(kernel_filename, NULL,
>                                            translate_kernel_address, NULL=
,
> NULL,
> -                                          &lowaddr, NULL, 0,
> PPC_ELF_MACHINE,
> -                                          0, 0);
> +                                          &lowaddr, NULL, NULL, 0,
> +                                          PPC_ELF_MACHINE, 0, 0);
>              spapr->kernel_le =3D spapr->kernel_size > 0;
>          }
>          if (spapr->kernel_size < 0) {
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 6862552..7526947 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -259,7 +259,7 @@ static void virtex_init(MachineState *machine)
>
>          /* Boots a kernel elf binary.  */
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> -                               &entry, &low, &high, 1, PPC_ELF_MACHINE,
> +                               &entry, &low, &high, NULL, 1,
> PPC_ELF_MACHINE,
>                                 0, 0);
>          boot_info.bootstrap_pc =3D entry & 0x00ffffff;
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 027303d..b8e7652 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -101,7 +101,7 @@ target_ulong riscv_load_firmware(const char
> *firmware_filename,
>      uint64_t firmware_entry, firmware_start, firmware_end;
>
>      if (load_elf(firmware_filename, NULL, NULL, NULL, &firmware_entry,
> -                 &firmware_start, &firmware_end, 0, EM_RISCV, 1, 0) > 0)=
 {
> +                 &firmware_start, &firmware_end, NULL, 0, EM_RISCV, 1, 0=
)
> > 0) {
>          return firmware_entry;
>      }
>
> @@ -119,7 +119,7 @@ target_ulong riscv_load_kernel(const char
> *kernel_filename, symbol_fn_t sym_cb)
>      uint64_t kernel_entry, kernel_high;
>
>      if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
> -                         &kernel_entry, NULL, &kernel_high, 0,
> +                         &kernel_entry, NULL, &kernel_high, NULL, 0,
>                           EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
>          return kernel_entry;
>      }
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index ca544d6..49506e4 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -139,7 +139,7 @@ static void s390_ipl_realize(DeviceState *dev, Error
> **errp)
>
>          bios_size =3D load_elf(bios_filename, NULL,
>                               bios_translate_addr, &fwbase,
> -                             &ipl->bios_start_addr, NULL, NULL, 1,
> +                             &ipl->bios_start_addr, NULL, NULL, NULL, 1,
>                               EM_S390, 0, 0);
>          if (bios_size > 0) {
>              /* Adjust ELF start address to final location */
> @@ -164,7 +164,7 @@ static void s390_ipl_realize(DeviceState *dev, Error
> **errp)
>      if (ipl->kernel) {
>          kernel_size =3D load_elf(ipl->kernel, NULL, NULL, NULL,
>                                 &pentry, NULL,
> -                               NULL, 1, EM_S390, 0, 0);
> +                               NULL, NULL, 1, EM_S390, 0, 0);
>          if (kernel_size < 0) {
>              kernel_size =3D load_image_targphys(ipl->kernel, 0, ram_size=
);
>              if (kernel_size < 0) {
> @@ -473,7 +473,8 @@ static int load_netboot_image(Error **errp)
>
>      img_size =3D load_elf_ram(netboot_filename, NULL, NULL, NULL,
>                              &ipl->start_addr,
> -                            NULL, NULL, 1, EM_S390, 0, 0, NULL, false);
> +                            NULL, NULL, NULL, 1, EM_S390, 0, 0, NULL,
> +                            false);
>
>      if (img_size < 0) {
>          img_size =3D load_image_size(netboot_filename, ram_ptr, ram_size=
);
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 8038887..f5a087d 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -297,7 +297,7 @@ static void leon3_generic_hw_init(MachineState
> *machine)
>          uint64_t entry;
>
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> -                               &entry, NULL, NULL,
> +                               &entry, NULL, NULL, NULL,
>                                 1 /* big endian */, EM_SPARC, 0, 0);
>          if (kernel_size < 0) {
>              kernel_size =3D load_uimage(kernel_filename, NULL, &entry,
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 2aaa5bf..d404353 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -270,7 +270,7 @@ static unsigned long sun4m_load_kernel(const char
> *kernel_filename,
>  #endif
>          kernel_size =3D load_elf(kernel_filename, NULL,
>                                 translate_kernel_address, NULL,
> -                               NULL, NULL, NULL, 1, EM_SPARC, 0, 0);
> +                               NULL, NULL, NULL, NULL, 1, EM_SPARC, 0, 0=
);
>          if (kernel_size < 0)
>              kernel_size =3D load_aout(kernel_filename, KERNEL_LOAD_ADDR,
>                                      RAM_size - KERNEL_LOAD_ADDR,
> bswap_needed,
> @@ -721,7 +721,7 @@ static void prom_init(hwaddr addr, const char
> *bios_name)
>      if (filename) {
>          ret =3D load_elf(filename, NULL,
>                         translate_prom_address, &addr, NULL,
> -                       NULL, NULL, 1, EM_SPARC, 0, 0);
> +                       NULL, NULL, NULL, 1, EM_SPARC, 0, 0);
>          if (ret < 0 || ret > PROM_SIZE_MAX) {
>              ret =3D load_image_targphys(filename, addr, PROM_SIZE_MAX);
>          }
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 9550827..c746040 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -175,7 +175,8 @@ static uint64_t sun4u_load_kernel(const char
> *kernel_filename,
>          bswap_needed =3D 0;
>  #endif
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> kernel_entry,
> -                               kernel_addr, &kernel_top, 1, EM_SPARCV9,
> 0, 0);
> +                               kernel_addr, &kernel_top, NULL, 1,
> EM_SPARCV9, 0,
> +                               0);
>          if (kernel_size < 0) {
>              *kernel_addr =3D KERNEL_LOAD_ADDR;
>              *kernel_entry =3D KERNEL_LOAD_ADDR;
> @@ -439,7 +440,7 @@ static void prom_init(hwaddr addr, const char
> *bios_name)
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>      if (filename) {
>          ret =3D load_elf(filename, NULL, translate_prom_address, &addr,
> -                       NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);
> +                       NULL, NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);
>          if (ret < 0 || ret > PROM_SIZE_MAX) {
>              ret =3D load_image_targphys(filename, addr, PROM_SIZE_MAX);
>          }
> diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_
> testboard.c
> index aef3289..20c9ccb 100644
> --- a/hw/tricore/tricore_testboard.c
> +++ b/hw/tricore/tricore_testboard.c
> @@ -42,7 +42,7 @@ static void tricore_load_kernel(CPUTriCoreState *env)
>
>      kernel_size =3D load_elf(tricoretb_binfo.kernel_filename, NULL,
>                             NULL, NULL, &entry, NULL,
> -                           NULL, 0,
> +                           NULL, NULL, 0,
>                             EM_TRICORE, 1, 0);
>      if (kernel_size <=3D 0) {
>          error_report("no kernel file '%s'",
> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
> index a22743a..aeb46d8 100644
> --- a/hw/xtensa/sim.c
> +++ b/hw/xtensa/sim.c
> @@ -108,7 +108,7 @@ void xtensa_sim_load_kernel(XtensaCPU *cpu,
> MachineState *machine)
>          uint64_t elf_entry;
>          uint64_t elf_lowaddr;
>          int success =3D load_elf(kernel_filename, NULL,
> translate_phys_addr, cpu,
> -                               &elf_entry, &elf_lowaddr, NULL, big_endia=
n,
> +                               &elf_entry, &elf_lowaddr, NULL, NULL,
> big_endian,
>                                 EM_XTENSA, 0, 0);
>
>          if (success > 0) {
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index 8220c7a..8e2dd13 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -415,7 +415,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board,
> MachineState *machine)
>          uint64_t elf_entry;
>          uint64_t elf_lowaddr;
>          int success =3D load_elf(kernel_filename, NULL,
> translate_phys_addr, cpu,
> -                &elf_entry, &elf_lowaddr, NULL, be, EM_XTENSA, 0, 0);
> +                &elf_entry, &elf_lowaddr, NULL, NULL, be, EM_XTENSA, 0,
> 0);
>          if (success > 0) {
>              entry_point =3D elf_entry;
>          } else {
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index e07d276..a1411bf 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, int f=
d,
>                                void *translate_opaque,
>                                int must_swab, uint64_t *pentry,
>                                uint64_t *lowaddr, uint64_t *highaddr,
> -                              int elf_machine, int clear_lsb, int
> data_swab,
> +                              uint32_t *pflags, int elf_machine,
> +                              int clear_lsb, int data_swab,
>                                AddressSpace *as, bool load_rom,
>                                symbol_fn_t sym_cb)
>  {
> @@ -389,6 +390,9 @@ static int glue(load_elf, SZ)(const char *name, int f=
d,
>              }
>      }
>
> +    if (pflags) {
> +        *pflags =3D (elf_word)ehdr.e_flags;
> +    }
>      if (pentry)
>          *pentry =3D (uint64_t)(elf_sword)ehdr.e_entry;
>
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 48a96cd..a9eeea3 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -101,6 +101,7 @@ const char *load_elf_strerror(int error);
>   * @pentry: Populated with program entry point. Ignored if NULL.
>   * @lowaddr: Populated with lowest loaded address. Ignored if NULL.
>   * @highaddr: Populated with highest loaded address. Ignored if NULL.
> + * @pflags: Populated with ELF processor-specific flags. Ignore if NULL.
>   * @bigendian: Expected ELF endianness. 0 for LE otherwise BE
>   * @elf_machine: Expected ELF machine type
>   * @clear_lsb: Set to mask off LSB of addresses (Some architectures use
> @@ -131,8 +132,9 @@ int load_elf_ram_sym(const char *filename,
>                       uint64_t (*elf_note_fn)(void *, void *, bool),
>                       uint64_t (*translate_fn)(void *, uint64_t),
>                       void *translate_opaque, uint64_t *pentry,
> -                     uint64_t *lowaddr, uint64_t *highaddr, int
> big_endian,
> -                     int elf_machine, int clear_lsb, int data_swab,
> +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t
> *pflags,
> +                     int big_endian, int elf_machine,
> +                     int clear_lsb, int data_swab,
>                       AddressSpace *as, bool load_rom, symbol_fn_t sym_cb=
);
>
>  /** load_elf_ram:
> @@ -143,9 +145,9 @@ int load_elf_ram(const char *filename,
>                   uint64_t (*elf_note_fn)(void *, void *, bool),
>                   uint64_t (*translate_fn)(void *, uint64_t),
>                   void *translate_opaque, uint64_t *pentry, uint64_t
> *lowaddr,
> -                 uint64_t *highaddr, int big_endian, int elf_machine,
> -                 int clear_lsb, int data_swab, AddressSpace *as,
> -                 bool load_rom);
> +                 uint64_t *highaddr, uint32_t *pflags, int big_endian,
> +                 int elf_machine, int clear_lsb, int data_swab,
> +                 AddressSpace *as, bool load_rom);
>
>  /** load_elf_as:
>   * Same as load_elf_ram(), but always loads the elf as ROM
> @@ -154,8 +156,9 @@ int load_elf_as(const char *filename,
>                  uint64_t (*elf_note_fn)(void *, void *, bool),
>                  uint64_t (*translate_fn)(void *, uint64_t),
>                  void *translate_opaque, uint64_t *pentry, uint64_t
> *lowaddr,
> -                uint64_t *highaddr, int big_endian, int elf_machine,
> -                int clear_lsb, int data_swab, AddressSpace *as);
> +                uint64_t *highaddr, uint32_t *pflags, int big_endian,
> +                int elf_machine, int clear_lsb, int data_swab,
> +                AddressSpace *as);
>
>  /** load_elf:
>   * Same as load_elf_as(), but doesn't allow the caller to specify an
> @@ -165,8 +168,8 @@ int load_elf(const char *filename,
>               uint64_t (*elf_note_fn)(void *, void *, bool),
>               uint64_t (*translate_fn)(void *, uint64_t),
>               void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr=
,
> -             uint64_t *highaddr, int big_endian, int elf_machine,
> -             int clear_lsb, int data_swab);
> +             uint64_t *highaddr, uint32_t *pflags, int big_endian,
> +             int elf_machine, int clear_lsb, int data_swab);
>
>  /** load_elf_hdr:
>   * @filename: Path of ELF file
> --
> 2.7.4
>
>
>

--000000000000a8e4d1059d304f94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGJyPjxicj5PbiBTdW5kYXksIEphbnVhcnkgMjYsIDIwMjAsIEFsZWtzYW5kYXIgTWFya292aWMg
Jmx0OzxhIGhyZWY9Im1haWx0bzphbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbSI+YWxla3Nh
bmRhci5tYXJrb3ZpY0BydC1yay5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgJmx0OzxhIGhyZWY9Im1haWx0bzpmNGJ1Z0BhbXNhdC5vcmciPmY0YnVnQGFtc2F0Lm9yZzwv
YT4mZ3Q7PGJyPg0KPGJyPg0KU29tZSBwbGF0Zm9ybXMgKGxpa2UgQVZSKSBuZWVkIHRvIGRldGVy
bWluZSBjcHUgdHlwZSBieSByZWFkaW5nPGJyPg0KdGhlIEVMRiBmbGFncyAoZmllbGQgZV9mbGFn
cyBvaW4gRUxGIGhlYWRlcikuPGJyPg0KPGJyPg0KVGhpcyBwYXRjaCBlbmFibGVzIGRpc2NvdmVy
eSBvZiB0aGUgY29udGVudCBvZiB0aGF0IGZsYWcgd2hpbGU8YnI+DQp1c2luZyBmb2xsb3dpbmcg
ZnVuY3Rpb25zOjxicj4NCjxicj4NCsKgIC0gbG9hZF9lbGYoKTxicj4NCsKgIC0gbG9hZF9lbGZf
YXMoKTxicj4NCsKgIC0gbG9hZF9lbGZfcmFtKCk8YnI+DQrCoCAtIGxvYWRfZWxmX3JhbV9zeW0o
KTxicj4NCjxicj4NClRoZSBhZGRlZCBhcmd1bWVudCBvZiB0aGVzZSBmdW5jdGlvbnMgaXMgb2Yg
dHlwZSB1aW50MzJfdCouIEl0IGlzPGJyPg0KYWxsb3dlZCB0byBwYXNzIE5VTEwgYXMgdGhhdCBh
cmd1bWVudCwgYW5kIGluIHN1Y2ggY2FzZSBubyBsb29rdXA8YnI+DQp0byB0aGUgZmllbGQgZV9m
bGFncyB3aWxsIGhhcHBlbiwgYW5kIG9mIGNvdXJzZSwgbm8gaW5mb3JtYXRpb248YnI+DQp3aWxs
IGJlIHJldHVybmVkIHRvIHRoZSBjYWxsZXIuPGJyPg0KPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxi
cj48L2Rpdj48ZGl2PldlIHBsYW4gdG8gdXNlIHRoaXMgbmV3IGZ1bmN0aW9uYWxpdHkgZm9yIE1J
UFMgTWFsdGEgYm9hcmQsIGZvciBkZXRlY3Rpb24gb2YgaW5jb21wYXRpYmxlIGNwdS9rZXJuZWwg
Y29tYmluYXRpb25zLCBhbmQgZ3JhY2VmdWwgZXhpdCAocmlnaHQgbm93IHRoZXNlIGNvbWJpbmF0
aW9ucyByZXN1bHQgaW4gaGFuZyBvciBjcmFzaCkuIEkgd291bGQgc2F5IG90aGVyIGJvYXJkcyBj
b3VsZCBtYWtlIHVzZSBvZiBpdCB0b28uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Gb3IgdGhh
dCByZWFzb24sIGlmIHRoZXJlIGlzIG5vIG9iamVjdGlvbiwgSSBwbGFuIHRvIHNlbGVjdCB0aGlz
IHBhdGNoIGZvciBuZXh0IE1JUFMgcXVldWUuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdh
cmRzLDwvZGl2PjxkaXY+QWxla3NhbmRhcjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij4NCkNDOiBSaWNoYXJkIEhlbmRlcnNvbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOnJ0aEB0d2lk
ZGxlLm5ldCI+cnRoQHR3aWRkbGUubmV0PC9hPiZndDs8YnI+DQpDQzogUGV0ZXIgTWF5ZGVsbCAm
bHQ7PGEgaHJlZj0ibWFpbHRvOnBldGVyLm1heWRlbGxAbGluYXJvLm9yZyI+cGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnPC9hPiZndDs8YnI+DQpDQzogRWRnYXIgRS4gSWdsZXNpYXMgJmx0OzxhIGhy
ZWY9Im1haWx0bzplZGdhci5pZ2xlc2lhc0BnbWFpbC5jb20iPmVkZ2FyLmlnbGVzaWFzQGdtYWls
LmNvbTwvYT4mZ3Q7PGJyPg0KQ0M6IE1pY2hhZWwgV2FsbGUgJmx0O21pY2hhZWxAd2FsbGUuY2Mm
Z3Q7PGJyPg0KQ0M6IFRob21hcyBIdXRoICZsdDs8YSBocmVmPSJtYWlsdG86aHV0aEB0dXhmYW1p
bHkub3JnIj5odXRoQHR1eGZhbWlseS5vcmc8L2E+Jmd0Ozxicj4NCkNDOiBMYXVyZW50IFZpdmll
ciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmxhdXJlbnRAdml2aWVyLmV1Ij5sYXVyZW50QHZpdmllci5l
dTwvYT4mZ3Q7PGJyPg0KQ0M6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpICZsdDs8YSBocmVmPSJt
YWlsdG86ZjRidWdAYW1zYXQub3JnIj5mNGJ1Z0BhbXNhdC5vcmc8L2E+Jmd0Ozxicj4NCkNDOiBB
bGVrc2FuZGFyIFJpa2FsbyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsZWtzYW5kYXIucmlrYWxvQHJ0
LXJrLmNvbSI+YWxla3NhbmRhci5yaWthbG9AcnQtcmsuY29tPC9hPiZndDs8YnI+DQpDQzogQXVy
ZWxpZW4gSmFybm8gJmx0OzxhIGhyZWY9Im1haWx0bzphdXJlbGllbkBhdXJlbDMyLm5ldCI+YXVy
ZWxpZW5AYXVyZWwzMi5uZXQ8L2E+Jmd0Ozxicj4NCkNDOiBKaWEgTGl1ICZsdDs8YSBocmVmPSJt
YWlsdG86cHJvbGpjQGdtYWlsLmNvbSI+cHJvbGpjQGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPg0KQ0M6
IERhdmlkIEdpYnNvbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRhdmlkQGdpYnNvbi5kcm9wYmVhci5p
ZC5hdSI+ZGF2aWRAZ2lic29uLmRyb3BiZWFyLmlkLmF1PC9hPiZndDs8YnI+DQpDQzogTWFyayBD
YXZlLUF5bGFuZCAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNv
LnVrIj5tYXJrLmNhdmUtYXlsYW5kQGlsYW5kZS5jby51azwvYT4mZ3Q7PGJyPg0KQ0M6IEJBTEFU
T04gWm9sdGFuICZsdDs8YSBocmVmPSJtYWlsdG86YmFsYXRvbkBlaWsuYm1lLmh1Ij5iYWxhdG9u
QGVpay5ibWUuaHU8L2E+Jmd0Ozxicj4NCkNDOiBDaHJpc3RpYW4gQm9ybnRyYWVnZXIgJmx0Ozxh
IGhyZWY9Im1haWx0bzpib3JudHJhZWdlckBkZS5pYm0uY29tIj5ib3JudHJhZWdlckBkZS5pYm0u
Y29tPC9hPiZndDs8YnI+DQpDQzogVGhvbWFzIEh1dGggJmx0OzxhIGhyZWY9Im1haWx0bzp0aHV0
aEByZWRoYXQuY29tIj50aHV0aEByZWRoYXQuY29tPC9hPiZndDs8YnI+DQpDQzogQXJ0eW9tIFRh
cmFzZW5rbyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmF0YXI0cWVtdUBnbWFpbC5jb20iPmF0YXI0cWVt
dUBnbWFpbC5jb208L2E+Jmd0Ozxicj4NCkNDOiBGYWJpZW4gQ2hvdXRlYXUgJmx0OzxhIGhyZWY9
Im1haWx0bzpjaG91dGVhdUBhZGFjb3JlLmNvbSI+Y2hvdXRlYXVAYWRhY29yZS5jb208L2E+Jmd0
Ozxicj4NCkNDOiBLT05SQUQgRnJlZGVyaWMgJmx0OzxhIGhyZWY9Im1haWx0bzpmcmVkZXJpYy5r
b25yYWRAYWRhY29yZS5jb20iPmZyZWRlcmljLmtvbnJhZEBhZGFjb3JlLmNvbTwvYT4mZ3Q7PGJy
Pg0KQ0M6IE1heCBGaWxpcHBvdiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmpjbXZia2JjQGdtYWlsLmNv
bSI+amNtdmJrYmNAZ21haWwuY29tPC9hPiZndDs8YnI+DQo8YnI+DQpTaWduZWQtb2ZmLWJ5OiBN
aWNoYWVsIFJvbG5payAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1yb2xuaWtAZ21haWwuY29tIj5tcm9s
bmlrQGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kYXIgTWFya292
aWMgJmx0OzxhIGhyZWY9Im1haWx0bzphbWFya292aWNAd2F2ZWNvbXAuY29tIj5hbWFya292aWNA
d2F2ZWNvbXAuY29tPC9hPiZndDs8YnI+DQpbUE1EOiBFeHRyYWN0ZWQgZnJvbSBiaWdnZXIgcGF0
Y2gsPGJyPg0KwqAgwqAgwqAgUmVwbGFjZWQgJiMzOTt1aW50MzJfdCAqcGVfZmxhZ3MmIzM5OyBi
eSAmIzM5O2ludCBwcm9jX2ZsYWdzJiMzOTtdPGJyPg0KW0FNOiBSZXBsYWNlZCAmIzM5O2ludCBw
cm9jX2ZsYWdzJiMzOTsgd2l0aCAmIzM5O3VpbnQzMl90ICpwZmxhZ3MmIzM5Oyw8YnI+DQrCoCDC
oCDCoHJlcGxhY2VkIG9uZSBpbnN0YW5jZSBvZiAmIzM5O2VsZl9zd29yZCYjMzk7IHRvICYjMzk7
ZWxmX3dvcmQmIzM5Oyw8YnI+DQrCoCDCoCDCoGV4dGVuZGVkIGZ1bmN0aW9uYWxpdHkgdG8gbG9h
ZF9lbGYoKV08YnI+DQpTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSAmbHQ7
PGEgaHJlZj0ibWFpbHRvOmY0YnVnQGFtc2F0Lm9yZyI+ZjRidWdAYW1zYXQub3JnPC9hPiZndDs8
YnI+DQpTaWduZWQtb2ZmLWJ5OiBBbGVrc2FuZGFyIE1hcmtvdmljICZsdDs8YSBocmVmPSJtYWls
dG86YWxla3NhbmRhci5tLm1haWxAZ21haWwuY29tIj5hbGVrc2FuZGFyLm0ubWFpbEBnbWFpbC5j
b208L2E+Jmd0Ozxicj4NCi0tLTxicj4NCsKgaHcvYWxwaGEvZHAyNjQuY8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgfMKgIDQgKystLTxicj4NCsKgaHcvYXJtL2FybXY3bS5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfMKgIDIgKy08YnI+DQrCoGh3L2FybS9ib290LmPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB8wqAgMiArLTxicj4NCsKgaHcvY29yZS9nZW5lcmljLWxvYWRlci5jwqAgwqAgwqAg
wqB8wqAgMiArLTxicj4NCsKgaHcvY29yZS9sb2FkZXIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fCAzNyArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS08d2JyPi0tLS0tLS08YnI+DQrCoGh3
L2NyaXMvYm9vdC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4NCsKgaHcv
aHBwYS9tYWNoaW5lLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgNCArKy0tPGJyPg0KwqBody9p
Mzg2L211bHRpYm9vdC5jwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDIgKy08YnI+DQrCoGh3L2kzODYv
eDg2LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCsKgaHcvbG0zMi9s
bTMyX2JvYXJkcy5jwqAgwqAgwqAgwqAgwqAgfMKgIDQgKystLTxicj4NCsKgaHcvbG0zMi9taWxr
eW1pc3QuY8KgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0KwqBody9tNjhrL2FuNTIwNi5j
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4NCsKgaHcvbTY4ay9tY2Y1MjA4LmPC
oCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCsKgaHcvbTY4ay9xODAwLmPCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0KwqBody9taWNyb2JsYXplL2Jvb3QuY8Kg
IMKgIMKgIMKgIMKgIMKgfMKgIDQgKystLTxicj4NCsKgaHcvbWlwcy9taXBzX2Z1bG9uZzJlLmPC
oCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCsKgaHcvbWlwcy9taXBzX21hbHRhLmPCoCDCoCDCoCDC
oCDCoCDCoHzCoCAzICsrLTxicj4NCsKgaHcvbWlwcy9taXBzX21pcHNzaW0uY8KgIMKgIMKgIMKg
IMKgfMKgIDIgKy08YnI+DQrCoGh3L21pcHMvbWlwc19yNGsuY8KgIMKgIMKgIMKgIMKgIMKgIMKg
fMKgIDIgKy08YnI+DQrCoGh3L21veGllL21veGllc2ltLmPCoCDCoCDCoCDCoCDCoCDCoCB8wqAg
MiArLTxicj4NCsKgaHcvbmlvczIvYm9vdC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDQg
KystLTxicj4NCsKgaHcvb3BlbnJpc2Mvb3BlbnJpc2Nfc2ltLmPCoCDCoCDCoHzCoCAyICstPGJy
Pg0KwqBody9wY2ktaG9zdC9wcmVwLmPCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAzICsrLTxicj4N
CsKgaHcvcHBjL2U1MDAuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0K
wqBody9wcGMvbWFjX25ld3dvcmxkLmPCoCDCoCDCoCDCoCDCoCB8wqAgNCArKy0tPGJyPg0KwqBo
dy9wcGMvbWFjX29sZHdvcmxkLmPCoCDCoCDCoCDCoCDCoCB8wqAgNCArKy0tPGJyPg0KwqBody9w
cGMvcHBjNDQwX2JhbWJvby5jwqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4NCsKgaHcvcHBjL3Nh
bTQ2MGV4LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMyArKy08YnI+DQrCoGh3L3BwYy9zcGFw
ci5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgNiArKystLS08YnI+DQrCoGh3L3BwYy92
aXJ0ZXhfbWw1MDcuY8KgIMKgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0KwqBody9yaXNjdi9ib290
LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgNCArKy0tPGJyPg0KwqBody9zMzkweC9pcGwu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDcgKysrKy0tLTxicj4NCsKgaHcvc3BhcmMv
bGVvbjMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQrCoGh3L3NwYXJjL3N1
bjRtLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCA0ICsrLS08YnI+DQrCoGh3L3NwYXJjNjQv
c3VuNHUuY8KgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDUgKysrLS08YnI+DQrCoGh3L3RyaWNvcmUv
dHJpY29yZV90ZXN0Ym9hcmQuYyB8wqAgMiArLTxicj4NCsKgaHcveHRlbnNhL3NpbS5jwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfMKgIDIgKy08YnI+DQrCoGh3L3h0ZW5zYS94dGZwZ2EuY8KgIMKg
IMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQrCoGluY2x1ZGUvaHcvZWxmX29wcy5owqAgwqAg
wqAgwqAgwqAgwqB8wqAgNiArKysrKy08YnI+DQrCoGluY2x1ZGUvaHcvbG9hZGVyLmjCoCDCoCDC
oCDCoCDCoCDCoCB8IDIxICsrKysrKysrKysrKy0tLS0tLS0tLTxicj4NCsKgNDAgZmlsZXMgY2hh
bmdlZCwgOTIgaW5zZXJ0aW9ucygrKSwgNzkgZGVsZXRpb25zKC0pPGJyPg0KPGJyPg0KZGlmZiAt
LWdpdCBhL2h3L2FscGhhL2RwMjY0LmMgYi9ody9hbHBoYS9kcDI2NC5jPGJyPg0KaW5kZXggZjIw
MjZmZC4uYThmOWE4OSAxMDA2NDQ8YnI+DQotLS0gYS9ody9hbHBoYS9kcDI2NC5jPGJyPg0KKysr
IGIvaHcvYWxwaGEvZHAyNjQuYzxicj4NCkBAIC0xMTUsNyArMTE1LDcgQEAgc3RhdGljIHZvaWQg
Y2xpcHBlcl9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSk8YnI+DQrCoCDCoCDCoCDCoCDCoGV4
aXQoMSk7PGJyPg0KwqAgwqAgwqB9PGJyPg0KwqAgwqAgwqBzaXplID0gbG9hZF9lbGYocGFsY29k
ZV9maWxlbmFtZSwgTlVMTCwgY3B1X2FscGhhX3N1cGVycGFnZV90b19waHlzLDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCAmYW1wO3BhbGNvZGVfZW50cnksICZhbXA7
cGFsY29kZV9sb3csICZhbXA7cGFsY29kZV9oaWdoLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBOVUxMLCAmYW1wO3BhbGNvZGVfZW50cnksICZhbXA7cGFsY29kZV9sb3csICZh
bXA7cGFsY29kZV9oaWdoLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgMCwgRU1fQUxQSEEsIDAsIDApOzxicj4NCsKgIMKgIMKgaWYgKHNpemUgJmx0OyAwKSB7PGJy
Pg0KwqAgwqAgwqAgwqAgwqBlcnJvcl9yZXBvcnQoJnF1b3Q7Y291bGQgbm90IGxvYWQgcGFsY29k
ZSAmIzM5OyVzJiMzOTsmcXVvdDssIHBhbGNvZGVfZmlsZW5hbWUpOzxicj4NCkBAIC0xMzQsNyAr
MTM0LDcgQEAgc3RhdGljIHZvaWQgY2xpcHBlcl9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSk8
YnI+DQrCoCDCoCDCoCDCoCDCoHVpbnQ2NF90IHBhcmFtX29mZnNldDs8YnI+DQo8YnI+DQrCoCDC
oCDCoCDCoCDCoHNpemUgPSBsb2FkX2VsZihrZXJuZWxfZmlsZW5hbWUsIE5VTEwsIGNwdV9hbHBo
YV9zdXBlcnBhZ2VfdG9fcGh5cyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgTlVMTCwgJmFtcDtrZXJuZWxfZW50cnksICZhbXA7a2VybmVsX2xvdywgJmFtcDtrZXJu
ZWxfaGlnaCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTlVMTCwg
JmFtcDtrZXJuZWxfZW50cnksICZhbXA7a2VybmVsX2xvdywgJmFtcDtrZXJuZWxfaGlnaCwgTlVM
TCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDAsIEVNX0FMUEhB
LCAwLCAwKTs8YnI+DQrCoCDCoCDCoCDCoCDCoGlmIChzaXplICZsdDsgMCkgezxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgZXJyb3JfcmVwb3J0KCZxdW90O2NvdWxkIG5vdCBsb2FkIGtlcm5lbCAm
IzM5OyVzJiMzOTsmcXVvdDssIGtlcm5lbF9maWxlbmFtZSk7PGJyPg0KZGlmZiAtLWdpdCBhL2h3
L2FybS9hcm12N20uYyBiL2h3L2FybS9hcm12N20uYzxicj4NCmluZGV4IDdhM2M0OGYuLmU0ZmM5
YTggMTAwNjQ0PGJyPg0KLS0tIGEvaHcvYXJtL2FybXY3bS5jPGJyPg0KKysrIGIvaHcvYXJtL2Fy
bXY3bS5jPGJyPg0KQEAgLTMzMSw3ICszMzEsNyBAQCB2b2lkIGFybXY3bV9sb2FkX2tlcm5lbChB
Uk1DUFUgKmNwdSwgY29uc3QgY2hhciAqa2VybmVsX2ZpbGVuYW1lLCBpbnQgbWVtX3NpemUpPGJy
Pg0KPGJyPg0KwqAgwqAgwqBpZiAoa2VybmVsX2ZpbGVuYW1lKSB7PGJyPg0KwqAgwqAgwqAgwqAg
wqBpbWFnZV9zaXplID0gbG9hZF9lbGZfYXMoa2VybmVsX2ZpbGVuYW1lLCBOVUxMLCBOVUxMLCBO
VUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCZhbXA7ZW50cnksICZhbXA7bG93YWRkciw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO2VudHJ5LCAmYW1wO2xvd2FkZHIsIE5V
TEwsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgTlVMTCwgYmlnX2VuZGlhbiwgRU1fQVJNLCAxLCAwLCBhcyk7PGJyPg0KwqAgwqAgwqAgwqAg
wqBpZiAoaW1hZ2Vfc2l6ZSAmbHQ7IDApIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoGltYWdl
X3NpemUgPSBsb2FkX2ltYWdlX3RhcmdwaHlzX2FzKGtlcm5lbF88d2JyPmZpbGVuYW1lLCAwLDxi
cj4NCmRpZmYgLS1naXQgYS9ody9hcm0vYm9vdC5jIGIvaHcvYXJtL2Jvb3QuYzxicj4NCmluZGV4
IDhmYjRhNjMuLjBjMjEzY2EgMTAwNjQ0PGJyPg0KLS0tIGEvaHcvYXJtL2Jvb3QuYzxicj4NCisr
KyBiL2h3L2FybS9ib290LmM8YnI+DQpAQCAtOTAzLDcgKzkwMyw3IEBAIHN0YXRpYyBpbnQ2NF90
IGFybV9sb2FkX2VsZihzdHJ1Y3QgYXJtX2Jvb3RfaW5mbyAqaW5mbywgdWludDY0X3QgKnBlbnRy
eSw8YnI+DQrCoCDCoCDCoH08YnI+DQo8YnI+DQrCoCDCoCDCoHJldCA9IGxvYWRfZWxmX2FzKGlu
Zm8tJmd0O2tlcm5lbF88d2JyPmZpbGVuYW1lLCBOVUxMLCBOVUxMLCBOVUxMLDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwZW50cnksIGxvd2FkZHIsIGhpZ2hhZGRyLCBi
aWdfZW5kaWFuLCBlbGZfbWFjaGluZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgcGVudHJ5LCBsb3dhZGRyLCBoaWdoYWRkciwgTlVMTCwgYmlnX2VuZGlhbiwgZWxmX21h
Y2hpbmUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAxLCBkYXRhX3N3
YWIsIGFzKTs8YnI+DQrCoCDCoCDCoGlmIChyZXQgJmx0Oz0gMCkgezxicj4NCsKgIMKgIMKgIMKg
IMKgLyogVGhlIGhlYWRlciBsb2FkZWQgYnV0IHRoZSBpbWFnZSBkaWRuJiMzOTt0ICovPGJyPg0K
ZGlmZiAtLWdpdCBhL2h3L2NvcmUvZ2VuZXJpYy1sb2FkZXIuYyBiL2h3L2NvcmUvZ2VuZXJpYy1s
b2FkZXIuYzxicj4NCmluZGV4IDRiMWZjODYuLjFlNWNjYjcgMTAwNjQ0PGJyPg0KLS0tIGEvaHcv
Y29yZS9nZW5lcmljLWxvYWRlci5jPGJyPg0KKysrIGIvaHcvY29yZS9nZW5lcmljLWxvYWRlci5j
PGJyPg0KQEAgLTE0MCw3ICsxNDAsNyBAQCBzdGF0aWMgdm9pZCBnZW5lcmljX2xvYWRlcl9yZWFs
aXplKDx3YnI+RGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKTxicj4NCjxicj4NCsKgIMKg
IMKgIMKgIMKgaWYgKCFzLSZndDtmb3JjZV9yYXcpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oHNpemUgPSBsb2FkX2VsZl9hcyhzLSZndDtmaWxlLCBOVUxMLCBOVUxMLCBOVUxMLCAmYW1wO2Vu
dHJ5LCBOVUxMLCBOVUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGJpZ19lbmRpYW4sIDAsIDAsIDAsIGFzKTs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOVUxMLCBiaWdfZW5kaWFuLCAwLCAw
LCAwLCBhcyk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc2l6ZSAmbHQ7IDAp
IHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNpemUgPSBsb2FkX3VpbWFnZV9hcyhz
LSZndDtmaWxlLCAmYW1wO2VudHJ5LCBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMLDxicj4NCmRpZmYg
LS1naXQgYS9ody9jb3JlL2xvYWRlci5jIGIvaHcvY29yZS9sb2FkZXIuYzxicj4NCmluZGV4IDUw
OTlmMjcuLmQxYjc4ZjYgMTAwNjQ0PGJyPg0KLS0tIGEvaHcvY29yZS9sb2FkZXIuYzxicj4NCisr
KyBiL2h3L2NvcmUvbG9hZGVyLmM8YnI+DQpAQCAtNDA2LDEyICs0MDYsMTIgQEAgaW50IGxvYWRf
ZWxmKGNvbnN0IGNoYXIgKmZpbGVuYW1lLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIHVpbnQ2
NF90ICgqZWxmX25vdGVfZm4pKHZvaWQgKiwgdm9pZCAqLCBib29sKSw8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCB1aW50NjRfdCAoKnRyYW5zbGF0ZV9mbikodm9pZCAqLCB1aW50NjRfdCksPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgdm9pZCAqdHJhbnNsYXRlX29wYXF1ZSwgdWludDY0X3Qg
KnBlbnRyeSwgdWludDY0X3QgKmxvd2FkZHIsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgdWlu
dDY0X3QgKmhpZ2hhZGRyLCBpbnQgYmlnX2VuZGlhbiwgaW50IGVsZl9tYWNoaW5lLDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoGludCBjbGVhcl9sc2IsIGludCBkYXRhX3N3YWIpPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgdWludDY0X3QgKmhpZ2hhZGRyLCB1aW50MzJfdCAqcGZsYWdzLCBp
bnQgYmlnX2VuZGlhbiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQgZWxmX21hY2hpbmUs
IGludCBjbGVhcl9sc2IsIGludCBkYXRhX3N3YWIpPGJyPg0KwqB7PGJyPg0KwqAgwqAgwqByZXR1
cm4gbG9hZF9lbGZfYXMoZmlsZW5hbWUsIGVsZl9ub3RlX2ZuLCB0cmFuc2xhdGVfZm4sIHRyYW5z
bGF0ZV9vcGFxdWUsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGVu
dHJ5LCBsb3dhZGRyLCBoaWdoYWRkciwgYmlnX2VuZGlhbiwgZWxmX21hY2hpbmUsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2xlYXJfbHNiLCBkYXRhX3N3YWIsIE5V
TEwpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBlbnRyeSwgbG93
YWRkciwgaGlnaGFkZHIsIHBmbGFncywgYmlnX2VuZGlhbiw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBlbGZfbWFjaGluZSwgY2xlYXJfbHNiLCBkYXRhX3N3YWIsIE5V
TEwpOzxicj4NCsKgfTxicj4NCjxicj4NCsKgLyogcmV0dXJuICZsdDsgMCBpZiBlcnJvciwgb3Ro
ZXJ3aXNlIHRoZSBudW1iZXIgb2YgYnl0ZXMgbG9hZGVkIGluIG1lbW9yeSAqLzxicj4NCkBAIC00
MTksMTIgKzQxOSwxMiBAQCBpbnQgbG9hZF9lbGZfYXMoY29uc3QgY2hhciAqZmlsZW5hbWUsPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50NjRfdCAoKmVsZl9ub3RlX2ZuKSh2b2lk
ICosIHZvaWQgKiwgYm9vbCksPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50NjRf
dCAoKnRyYW5zbGF0ZV9mbikodm9pZCAqLCB1aW50NjRfdCksPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB2b2lkICp0cmFuc2xhdGVfb3BhcXVlLCB1aW50NjRfdCAqcGVudHJ5LCB1aW50
NjRfdCAqbG93YWRkciw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdWludDY0X3QgKmhp
Z2hhZGRyLCBpbnQgYmlnX2VuZGlhbiwgaW50IGVsZl9tYWNoaW5lLDxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBpbnQgY2xlYXJfbHNiLCBpbnQgZGF0YV9zd2FiLCBBZGRyZXNzU3BhY2Ug
KmFzKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1aW50NjRfdCAqaGlnaGFkZHIsIHVp
bnQzMl90ICpwZmxhZ3MsIGludCBiaWdfZW5kaWFuLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpbnQgZWxmX21hY2hpbmUsIGludCBjbGVhcl9sc2IsIGludCBkYXRhX3N3YWIsIEFkZHJl
c3NTcGFjZSAqYXMpPGJyPg0KwqB7PGJyPg0KwqAgwqAgwqByZXR1cm4gbG9hZF9lbGZfcmFtKGZp
bGVuYW1lLCBlbGZfbm90ZV9mbiwgdHJhbnNsYXRlX2ZuLCB0cmFuc2xhdGVfb3BhcXVlLDxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwZW50cnksIGxvd2FkZHIsIGhp
Z2hhZGRyLCBiaWdfZW5kaWFuLCBlbGZfbWFjaGluZSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgY2xlYXJfbHNiLCBkYXRhX3N3YWIsIGFzLCB0cnVlKTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcGVudHJ5LCBsb3dhZGRyLCBoaWdo
YWRkciwgcGZsYWdzLCBiaWdfZW5kaWFuLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBlbGZfbWFjaGluZSwgY2xlYXJfbHNiLCBkYXRhX3N3YWIsIGFzLCB0cnVlKTs8
YnI+DQrCoH08YnI+DQo8YnI+DQrCoC8qIHJldHVybiAmbHQ7IDAgaWYgZXJyb3IsIG90aGVyd2lz
ZSB0aGUgbnVtYmVyIG9mIGJ5dGVzIGxvYWRlZCBpbiBtZW1vcnkgKi88YnI+DQpAQCAtNDMyLDEz
ICs0MzIsMTMgQEAgaW50IGxvYWRfZWxmX3JhbShjb25zdCBjaGFyICpmaWxlbmFtZSw8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1aW50NjRfdCAoKmVsZl9ub3RlX2ZuKSh2b2lkICos
IHZvaWQgKiwgYm9vbCksPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdWludDY0X3Qg
KCp0cmFuc2xhdGVfZm4pKHZvaWQgKiwgdWludDY0X3QpLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHZvaWQgKnRyYW5zbGF0ZV9vcGFxdWUsIHVpbnQ2NF90ICpwZW50cnksIHVpbnQ2
NF90ICpsb3dhZGRyLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQ2NF90ICpo
aWdoYWRkciwgaW50IGJpZ19lbmRpYW4sIGludCBlbGZfbWFjaGluZSw8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBpbnQgY2xlYXJfbHNiLCBpbnQgZGF0YV9zd2FiLCBBZGRyZXNzU3Bh
Y2UgKmFzLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJvb2wgbG9hZF9yb20pPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdWludDY0X3QgKmhpZ2hhZGRyLCB1aW50MzJf
dCAqcGZsYWdzLCBpbnQgYmlnX2VuZGlhbiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpbnQgZWxmX21hY2hpbmUsIGludCBjbGVhcl9sc2IsIGludCBkYXRhX3N3YWIsPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQWRkcmVzc1NwYWNlICphcywgYm9vbCBsb2FkX3JvbSk8
YnI+DQrCoHs8YnI+DQrCoCDCoCDCoHJldHVybiBsb2FkX2VsZl9yYW1fc3ltKGZpbGVuYW1lLCBl
bGZfbm90ZV9mbiw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHRyYW5zbGF0ZV9mbiwgdHJhbnNsYXRlX29wYXF1ZSw8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcGVudHJ5LCBsb3dhZGRyLCBoaWdoYWRkciwgYmln
X2VuZGlhbiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cGVudHJ5LCBsb3dhZGRyLCBoaWdoYWRkciwgcGZsYWdzLCBiaWdfZW5kaWFuLDxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZWxmX21hY2hpbmUsIGNsZWFy
X2xzYiwgZGF0YV9zd2FiLCBhcyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGxvYWRfcm9tLCBOVUxMKTs8YnI+DQrCoH08YnI+DQpAQCAtNDQ4LDggKzQ0
OCw5IEBAIGludCBsb2FkX2VsZl9yYW1fc3ltKGNvbnN0IGNoYXIgKmZpbGVuYW1lLDxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVpbnQ2NF90ICgqZWxmX25vdGVfZm4pKHZv
aWQgKiwgdm9pZCAqLCBib29sKSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB1aW50NjRfdCAoKnRyYW5zbGF0ZV9mbikodm9pZCAqLCB1aW50NjRfdCksPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdm9pZCAqdHJhbnNsYXRlX29wYXF1ZSwgdWludDY0
X3QgKnBlbnRyeSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50NjRf
dCAqbG93YWRkciwgdWludDY0X3QgKmhpZ2hhZGRyLCBpbnQgYmlnX2VuZGlhbiw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQgZWxmX21hY2hpbmUsIGludCBjbGVhcl9s
c2IsIGludCBkYXRhX3N3YWIsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
dWludDY0X3QgKmxvd2FkZHIsIHVpbnQ2NF90ICpoaWdoYWRkciwgdWludDMyX3QgKnBmbGFncyw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQgYmlnX2VuZGlhbiwgaW50
IGVsZl9tYWNoaW5lLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludCBj
bGVhcl9sc2IsIGludCBkYXRhX3N3YWIsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgQWRkcmVzc1NwYWNlICphcywgYm9vbCBsb2FkX3JvbSwgc3ltYm9sX2ZuX3Qgc3ltX2Ni
KTxicj4NCsKgezxicj4NCsKgIMKgIMKgaW50IGZkLCBkYXRhX29yZGVyLCB0YXJnZXRfZGF0YV9v
cmRlciwgbXVzdF9zd2FiLCByZXQgPSBFTEZfTE9BRF9GQUlMRUQ7PGJyPg0KQEAgLTQ5MCwxMyAr
NDkxLDEzIEBAIGludCBsb2FkX2VsZl9yYW1fc3ltKGNvbnN0IGNoYXIgKmZpbGVuYW1lLDxicj4N
CsKgIMKgIMKgaWYgKGVfaWRlbnRbRUlfQ0xBU1NdID09IEVMRkNMQVNTNjQpIHs8YnI+DQrCoCDC
oCDCoCDCoCDCoHJldCA9IGxvYWRfZWxmNjQoZmlsZW5hbWUsIGZkLCBlbGZfbm90ZV9mbiw8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0cmFuc2xhdGVfZm4sIHRy
YW5zbGF0ZV9vcGFxdWUsIG11c3Rfc3dhYiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBwZW50cnksIGxvd2FkZHIsIGhpZ2hhZGRyLCBlbGZfbWFjaGluZSwgY2xl
YXJfbHNiLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRhdGFf
c3dhYiwgYXMsIGxvYWRfcm9tLCBzeW1fY2IpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHBlbnRyeSwgbG93YWRkciwgaGlnaGFkZHIsIHBmbGFncywgZWxmX21h
Y2hpbmUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2xlYXJf
bHNiLCBkYXRhX3N3YWIsIGFzLCBsb2FkX3JvbSwgc3ltX2NiKTs8YnI+DQrCoCDCoCDCoH0gZWxz
ZSB7PGJyPg0KwqAgwqAgwqAgwqAgwqByZXQgPSBsb2FkX2VsZjMyKGZpbGVuYW1lLCBmZCwgZWxm
X25vdGVfZm4sPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdHJh
bnNsYXRlX2ZuLCB0cmFuc2xhdGVfb3BhcXVlLCBtdXN0X3N3YWIsPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGVudHJ5LCBsb3dhZGRyLCBoaWdoYWRkciwgZWxm
X21hY2hpbmUsIGNsZWFyX2xzYiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBkYXRhX3N3YWIsIGFzLCBsb2FkX3JvbSwgc3ltX2NiKTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwZW50cnksIGxvd2FkZHIsIGhpZ2hhZGRyLCBw
ZmxhZ3MsIGVsZl9tYWNoaW5lLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGNsZWFyX2xzYiwgZGF0YV9zd2FiLCBhcywgbG9hZF9yb20sIHN5bV9jYik7PGJyPg0K
wqAgwqAgwqB9PGJyPg0KPGJyPg0KwqAgZmFpbDo8YnI+DQpkaWZmIC0tZ2l0IGEvaHcvY3Jpcy9i
b290LmMgYi9ody9jcmlzL2Jvb3QuYzxicj4NCmluZGV4IDJkMmNjMGMuLmI4OTQ3YmMgMTAwNjQ0
PGJyPg0KLS0tIGEvaHcvY3Jpcy9ib290LmM8YnI+DQorKysgYi9ody9jcmlzL2Jvb3QuYzxicj4N
CkBAIC03Niw3ICs3Niw3IEBAIHZvaWQgY3Jpc19sb2FkX2ltYWdlKENSSVNDUFUgKmNwdSwgc3Ry
dWN0IGNyaXNfbG9hZF9pbmZvICpsaSk8YnI+DQrCoCDCoCDCoCDCoCBkZXZib2FyZCBTREsuwqAg
Ki88YnI+DQrCoCDCoCDCoGltYWdlX3NpemUgPSBsb2FkX2VsZihsaS0mZ3Q7aW1hZ2VfZmlsZW5h
bWUsIE5VTEwsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0
cmFuc2xhdGVfa2VybmVsX2FkZHJlc3MsIE5VTEwsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICZhbXA7ZW50cnksIE5VTEwsICZhbXA7aGlnaCwgMCwgRU1fQ1JJ
UywgMCwgMCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZh
bXA7ZW50cnksIE5VTEwsICZhbXA7aGlnaCwgTlVMTCwgMCwgRU1fQ1JJUywgMCwgMCk7PGJyPg0K
wqAgwqAgwqBsaS0mZ3Q7ZW50cnkgPSBlbnRyeTs8YnI+DQrCoCDCoCDCoGlmIChpbWFnZV9zaXpl
ICZsdDsgMCkgezxicj4NCsKgIMKgIMKgIMKgIMKgLyogVGFrZXMgYSBraW1hZ2UgZnJvbSB0aGUg
YXhpcyBkZXZib2FyZCBTREsuwqAgKi88YnI+DQpkaWZmIC0tZ2l0IGEvaHcvaHBwYS9tYWNoaW5l
LmMgYi9ody9ocHBhL21hY2hpbmUuYzxicj4NCmluZGV4IDVkMGRlMjYuLjBhYjM2Y2YgMTAwNjQ0
PGJyPg0KLS0tIGEvaHcvaHBwYS9tYWNoaW5lLmM8YnI+DQorKysgYi9ody9ocHBhL21hY2hpbmUu
Yzxicj4NCkBAIC0xNDAsNyArMTQwLDcgQEAgc3RhdGljIHZvaWQgbWFjaGluZV9ocHBhX2luaXQo
TWFjaGluZVN0YXRlICptYWNoaW5lKTxicj4NCsKgIMKgIMKgfTxicj4NCjxicj4NCsKgIMKgIMKg
c2l6ZSA9IGxvYWRfZWxmKGZpcm13YXJlX2ZpbGVuYW1lLCBOVUxMLCBOVUxMLCBOVUxMLDxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmYW1wO2Zpcm13YXJlX2VudHJ5LCAmYW1w
O2Zpcm13YXJlX2xvdywgJmFtcDtmaXJtd2FyZV9oaWdoLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAmYW1wO2Zpcm13YXJlX2VudHJ5LCAmYW1wO2Zpcm13YXJlX2xvdywgJmFt
cDtmaXJtd2FyZV9oaWdoLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgdHJ1ZSwgRU1fUEFSSVNDLCAwLCAwKTs8YnI+DQo8YnI+DQrCoCDCoCDCoC8qIFVuZm9ydHVu
YXRlbHksIGxvYWRfZWxmIHNpZ24tZXh0ZW5kcyByZWFkaW5nIGVsZjMyLsKgICovPGJyPg0KQEAg
LTE2OSw3ICsxNjksNyBAQCBzdGF0aWMgdm9pZCBtYWNoaW5lX2hwcGFfaW5pdChNYWNoaW5lU3Rh
dGUgKm1hY2hpbmUpPGJyPg0KwqAgwqAgwqAvKiBMb2FkIGtlcm5lbCAqLzxicj4NCsKgIMKgIMKg
aWYgKGtlcm5lbF9maWxlbmFtZSkgezxicj4NCsKgIMKgIMKgIMKgIMKgc2l6ZSA9IGxvYWRfZWxm
KGtlcm5lbF9maWxlbmFtZSwgTlVMTCwgJmFtcDtjcHVfaHBwYV90b19waHlzLDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCAmYW1wO2tlcm5lbF9lbnRyeSwg
JmFtcDtrZXJuZWxfbG93LCAmYW1wO2tlcm5lbF9oaWdoLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCAmYW1wO2tlcm5lbF9lbnRyeSwgJmFtcDtrZXJuZWxf
bG93LCAmYW1wO2tlcm5lbF9oaWdoLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgdHJ1ZSwgRU1fUEFSSVNDLCAwLCAwKTs8YnI+DQo8YnI+DQrCoCDCoCDC
oCDCoCDCoC8qIFVuZm9ydHVuYXRlbHksIGxvYWRfZWxmIHNpZ24tZXh0ZW5kcyByZWFkaW5nIGVs
ZjMyLsKgICovPGJyPg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvbXVsdGlib290LmMgYi9ody9pMzg2
L211bHRpYm9vdC5jPGJyPg0KaW5kZXggOWE1OWY5NS4uOWU3ZDY5ZCAxMDA2NDQ8YnI+DQotLS0g
YS9ody9pMzg2L211bHRpYm9vdC5jPGJyPg0KKysrIGIvaHcvaTM4Ni9tdWx0aWJvb3QuYzxicj4N
CkBAIC0xOTksNyArMTk5LDcgQEAgaW50IGxvYWRfbXVsdGlib290KEZXQ2ZnU3RhdGUgKmZ3X2Nm
Zyw8YnI+DQrCoCDCoCDCoCDCoCDCoH08YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoGtlcm5lbF9z
aXplID0gbG9hZF9lbGYoa2VybmVsX2ZpbGVuYW1lLCBOVUxMLCBOVUxMLCBOVUxMLCAmYW1wO2Vs
Zl9lbnRyeSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAmYW1wO2VsZl9sb3csICZhbXA7ZWxmX2hpZ2gsIDAsIEkzODZfRUxGX01BQ0hJTkUsPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtl
bGZfbG93LCAmYW1wO2VsZl9oaWdoLCBOVUxMLCAwLCBJMzg2X0VMRl9NQUNISU5FLDxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDAsIDApOzxicj4N
CsKgIMKgIMKgIMKgIMKgaWYgKGtlcm5lbF9zaXplICZsdDsgMCkgezxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgZXJyb3JfcmVwb3J0KCZxdW90O0Vycm9yIHdoaWxlIGxvYWRpbmcgZWxmIGtlcm5l
bCZxdW90Oyk7PGJyPg0KZGlmZiAtLWdpdCBhL2h3L2kzODYveDg2LmMgYi9ody9pMzg2L3g4Ni5j
PGJyPg0KaW5kZXggOWI5YTRkNS4uN2YzOGU2YiAxMDA2NDQ8YnI+DQotLS0gYS9ody9pMzg2L3g4
Ni5jPGJyPg0KKysrIGIvaHcvaTM4Ni94ODYuYzxicj4NCkBAIC00MTMsNyArNDEzLDcgQEAgc3Rh
dGljIGJvb2wgbG9hZF9lbGZib290KGNvbnN0IGNoYXIgKmtlcm5lbF9maWxlbmFtZSw8YnI+DQrC
oCDCoCDCoHVpbnQ2NF90IGVsZl9ub3RlX3R5cGUgPSBYRU5fRUxGTk9URV9QSFlTMzJfRU5UUlk7
PGJyPg0KwqAgwqAgwqBrZXJuZWxfc2l6ZSA9IGxvYWRfZWxmKGtlcm5lbF9maWxlbmFtZSwgcmVh
ZF9wdmhfc3RhcnRfYWRkciw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBOVUxMLCAmYW1wO2VsZl9ub3RlX3R5cGUsICZhbXA7ZWxmX2VudHJ5LDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7ZWxmX2xvdywgJmFt
cDtlbGZfaGlnaCwgMCwgSTM4Nl9FTEZfTUFDSElORSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO2VsZl9sb3csICZhbXA7ZWxmX2hpZ2gsIE5VTEws
IDAsIEkzODZfRUxGX01BQ0hJTkUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgMCwgMCk7PGJyPg0KPGJyPg0KwqAgwqAgwqBpZiAoa2VybmVsX3NpemUgJmx0
OyAwKSB7PGJyPg0KZGlmZiAtLWdpdCBhL2h3L2xtMzIvbG0zMl9ib2FyZHMuYyBiL2h3L2xtMzIv
bG0zMl9ib2FyZHMuYzxicj4NCmluZGV4IDVhZTMwOGIuLmQxODk0YWQgMTAwNjQ0PGJyPg0KLS0t
IGEvaHcvbG0zMi9sbTMyX2JvYXJkcy5jPGJyPg0KKysrIGIvaHcvbG0zMi9sbTMyX2JvYXJkcy5j
PGJyPg0KQEAgLTEzOCw3ICsxMzgsNyBAQCBzdGF0aWMgdm9pZCBsbTMyX2V2cl9pbml0KE1hY2hp
bmVTdGF0ZSAqbWFjaGluZSk8YnI+DQrCoCDCoCDCoCDCoCDCoGludCBrZXJuZWxfc2l6ZTs8YnI+
DQo8YnI+DQrCoCDCoCDCoCDCoCDCoGtlcm5lbF9zaXplID0gbG9hZF9lbGYoa2VybmVsX2ZpbGVu
YW1lLCBOVUxMLCBOVUxMLCBOVUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7ZW50cnksIE5VTEwsIE5VTEwsPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtlbnRyeSwgTlVMTCwg
TlVMTCwgTlVMTCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAxLCBFTV9MQVRUSUNFTUlDTzMyLCAwLCAwKTs8YnI+DQrCoCDCoCDCoCDCoCDCoHJl
c2V0X2luZm8tJmd0O2Jvb3RzdHJhcF9wYyA9IGVudHJ5Ozxicj4NCjxicj4NCkBAIC0yMzIsNyAr
MjMyLDcgQEAgc3RhdGljIHZvaWQgbG0zMl91Y2xpbnV4X2luaXQoTWFjaGluZVN0YXRlICptYWNo
aW5lKTxicj4NCsKgIMKgIMKgIMKgIMKgaW50IGtlcm5lbF9zaXplOzxicj4NCjxicj4NCsKgIMKg
IMKgIMKgIMKga2VybmVsX3NpemUgPSBsb2FkX2VsZihrZXJuZWxfZmlsZW5hbWUsIE5VTEwsIE5V
TEwsIE5VTEwsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgJmFtcDtlbnRyeSwgTlVMTCwgTlVMTCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO2VudHJ5LCBOVUxMLCBOVUxMLCBOVUxMLDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDEsIEVN
X0xBVFRJQ0VNSUNPMzIsIDAsIDApOzxicj4NCsKgIMKgIMKgIMKgIMKgcmVzZXRfaW5mby0mZ3Q7
Ym9vdHN0cmFwX3BjID0gZW50cnk7PGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2h3L2xtMzIvbWls
a3ltaXN0LmMgYi9ody9sbTMyL21pbGt5bWlzdC5jPGJyPg0KaW5kZXggNDYwZDMyMi4uNmQ0NjEz
NCAxMDA2NDQ8YnI+DQotLS0gYS9ody9sbTMyL21pbGt5bWlzdC5jPGJyPg0KKysrIGIvaHcvbG0z
Mi9taWxreW1pc3QuYzxicj4NCkBAIC0xNzcsNyArMTc3LDcgQEAgbWlsa3ltaXN0X2luaXQoTWFj
aGluZVN0YXRlICptYWNoaW5lKTxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgLyogQm9vdHMgYSBr
ZXJuZWwgZWxmIGJpbmFyeS7CoCAqLzxicj4NCsKgIMKgIMKgIMKgIMKga2VybmVsX3NpemUgPSBs
b2FkX2VsZihrZXJuZWxfZmlsZW5hbWUsIE5VTEwsIE5VTEwsIE5VTEwsPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtlbnRyeSwgTlVMTCwg
TlVMTCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAmYW1wO2VudHJ5LCBOVUxMLCBOVUxMLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDEsIEVNX0xBVFRJQ0VNSUNPMzIsIDAsIDApOzxi
cj4NCsKgIMKgIMKgIMKgIMKgcmVzZXRfaW5mby0mZ3Q7Ym9vdHN0cmFwX3BjID0gZW50cnk7PGJy
Pg0KPGJyPg0KZGlmZiAtLWdpdCBhL2h3L202OGsvYW41MjA2LmMgYi9ody9tNjhrL2FuNTIwNi5j
PGJyPg0KaW5kZXggNTRjY2JlMS4uYmVkNDNhOSAxMDA2NDQ8YnI+DQotLS0gYS9ody9tNjhrL2Fu
NTIwNi5jPGJyPg0KKysrIGIvaHcvbTY4ay9hbjUyMDYuYzxicj4NCkBAIC02NSw3ICs2NSw3IEBA
IHN0YXRpYyB2b2lkIGFuNTIwNl9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSk8YnI+DQrCoCDC
oCDCoH08YnI+DQo8YnI+DQrCoCDCoCDCoGtlcm5lbF9zaXplID0gbG9hZF9lbGYoa2VybmVsX2Zp
bGVuYW1lLCBOVUxMLCBOVUxMLCBOVUxMLCAmYW1wO2VsZl9lbnRyeSw8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOVUxMLCBOVUxMLCAxLCBFTV82OEssIDAs
IDApOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEws
IE5VTEwsIE5VTEwsIDEsIEVNXzY4SywgMCwgMCk7PGJyPg0KwqAgwqAgwqBlbnRyeSA9IGVsZl9l
bnRyeTs8YnI+DQrCoCDCoCDCoGlmIChrZXJuZWxfc2l6ZSAmbHQ7IDApIHs8YnI+DQrCoCDCoCDC
oCDCoCDCoGtlcm5lbF9zaXplID0gbG9hZF91aW1hZ2Uoa2VybmVsX2ZpbGVuYW1lLCAmYW1wO2Vu
dHJ5LCBOVUxMLCBOVUxMLDxicj4NCmRpZmYgLS1naXQgYS9ody9tNjhrL21jZjUyMDguYyBiL2h3
L202OGsvbWNmNTIwOC5jPGJyPg0KaW5kZXggMTU4YzVlNC4uYTk5OWMyMSAxMDA2NDQ8YnI+DQot
LS0gYS9ody9tNjhrL21jZjUyMDguYzxicj4NCisrKyBiL2h3L202OGsvbWNmNTIwOC5jPGJyPg0K
QEAgLTMyOSw3ICszMjksNyBAQCBzdGF0aWMgdm9pZCBtY2Y1MjA4ZXZiX2luaXQoTWFjaGluZVN0
YXRlICptYWNoaW5lKTxicj4NCsKgIMKgIMKgfTxicj4NCjxicj4NCsKgIMKgIMKga2VybmVsX3Np
emUgPSBsb2FkX2VsZihrZXJuZWxfZmlsZW5hbWUsIE5VTEwsIE5VTEwsIE5VTEwsICZhbXA7ZWxm
X2VudHJ5LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5V
TEwsIE5VTEwsIDEsIEVNXzY4SywgMCwgMCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgTlVMTCwgTlVMTCwgTlVMTCwgMSwgRU1fNjhLLCAwLCAwKTs8YnI+
DQrCoCDCoCDCoGVudHJ5ID0gZWxmX2VudHJ5Ozxicj4NCsKgIMKgIMKgaWYgKGtlcm5lbF9zaXpl
ICZsdDsgMCkgezxicj4NCsKgIMKgIMKgIMKgIMKga2VybmVsX3NpemUgPSBsb2FkX3VpbWFnZShr
ZXJuZWxfZmlsZW5hbWUsICZhbXA7ZW50cnksIE5VTEwsIE5VTEwsPGJyPg0KZGlmZiAtLWdpdCBh
L2h3L202OGsvcTgwMC5jIGIvaHcvbTY4ay9xODAwLmM8YnI+DQppbmRleCAxMjQ5MWVjLi4xZTMy
MzYzIDEwMDY0NDxicj4NCi0tLSBhL2h3L202OGsvcTgwMC5jPGJyPg0KKysrIGIvaHcvbTY4ay9x
ODAwLmM8YnI+DQpAQCAtMzQyLDcgKzM0Miw3IEBAIHN0YXRpYyB2b2lkIHE4MDBfaW5pdChNYWNo
aW5lU3RhdGUgKm1hY2hpbmUpPGJyPg0KwqAgwqAgwqBpZiAobGludXhfYm9vdCkgezxicj4NCsKg
IMKgIMKgIMKgIMKgdWludDY0X3QgaGlnaDs8YnI+DQrCoCDCoCDCoCDCoCDCoGtlcm5lbF9zaXpl
ID0gbG9hZF9lbGYoa2VybmVsX2ZpbGVuYW1lLCBOVUxMLCBOVUxMLCBOVUxMLDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7ZWxmX2VudHJ5
LCBOVUxMLCAmYW1wO2hpZ2gsIDEsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtlbGZfZW50cnksIE5VTEwsICZhbXA7aGlnaCwgTlVMTCwg
MSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBF
TV82OEssIDAsIDApOzxicj4NCsKgIMKgIMKgIMKgIMKgaWYgKGtlcm5lbF9zaXplICZsdDsgMCkg
ezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgZXJyb3JfcmVwb3J0KCZxdW90O2NvdWxkIG5vdCBs
b2FkIGtlcm5lbCAmIzM5OyVzJiMzOTsmcXVvdDssIGtlcm5lbF9maWxlbmFtZSk7PGJyPg0KZGlm
ZiAtLWdpdCBhL2h3L21pY3JvYmxhemUvYm9vdC5jIGIvaHcvbWljcm9ibGF6ZS9ib290LmM8YnI+
DQppbmRleCBkMWQ3ZGZiLi45MjVlM2Y3IDEwMDY0NDxicj4NCi0tLSBhL2h3L21pY3JvYmxhemUv
Ym9vdC5jPGJyPg0KKysrIGIvaHcvbWljcm9ibGF6ZS9ib290LmM8YnI+DQpAQCAtMTQ1LDEzICsx
NDUsMTMgQEAgdm9pZCBtaWNyb2JsYXplX2xvYWRfa2VybmVsKDx3YnI+TWljcm9CbGF6ZUNQVSAq
Y3B1LCBod2FkZHIgZGRyX2Jhc2UsPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAvKiBCb290cyBh
IGtlcm5lbCBlbGYgYmluYXJ5LsKgICovPGJyPg0KwqAgwqAgwqAgwqAgwqBrZXJuZWxfc2l6ZSA9
IGxvYWRfZWxmKGtlcm5lbF9maWxlbmFtZSwgTlVMTCwgTlVMTCwgTlVMTCw8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO2VudHJ5LCAmYW1w
O2xvdywgJmFtcDtoaWdoLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCZhbXA7ZW50cnksICZhbXA7bG93LCAmYW1wO2hpZ2gsIE5VTEwsPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYmlnX2VuZGlh
biwgRU1fTUlDUk9CTEFaRSwgMCwgMCk7PGJyPg0KwqAgwqAgwqAgwqAgwqBiYXNlMzIgPSBlbnRy
eTs8YnI+DQrCoCDCoCDCoCDCoCDCoGlmIChiYXNlMzIgPT0gMHhjMDAwMDAwMCkgezxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKga2VybmVsX3NpemUgPSBsb2FkX2VsZihrZXJuZWxfZmlsZW5hbWUs
IE5VTEwsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgdHJhbnNsYXRlX2tlcm5lbF9hZGRyZXNzLCBOVUxMLDxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7ZW50cnksIE5V
TEwsIE5VTEwsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgJmFtcDtlbnRyeSwgTlVMTCwgTlVMTCwgTlVMTCw8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBiaWdfZW5kaWFuLCBF
TV9NSUNST0JMQVpFLCAwLCAwKTs8YnI+DQrCoCDCoCDCoCDCoCDCoH08YnI+DQrCoCDCoCDCoCDC
oCDCoC8qIEFsd2F5cyBib290IGludG8gcGh5c2ljYWwgcmFtLsKgICovPGJyPg0KZGlmZiAtLWdp
dCBhL2h3L21pcHMvbWlwc19mdWxvbmcyZS5jIGIvaHcvbWlwcy9taXBzX2Z1bG9uZzJlLmM8YnI+
DQppbmRleCA5ZWFhNmUyLi4yZTA0M2NiIDEwMDY0NDxicj4NCi0tLSBhL2h3L21pcHMvbWlwc19m
dWxvbmcyZS5jPGJyPg0KKysrIGIvaHcvbWlwcy9taXBzX2Z1bG9uZzJlLmM8YnI+DQpAQCAtMTE5
LDcgKzExOSw3IEBAIHN0YXRpYyBpbnQ2NF90IGxvYWRfa2VybmVsKENQVU1JUFNTdGF0ZSAqZW52
KTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNwdV9taXBz
X2tzZWcwX3RvX3BoeXMsIE5VTEwsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgKHVpbnQ2NF90ICopJmFtcDtrZXJuZWxfZW50cnksPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKHVpbnQ2NF90ICopJmFtcDtrZXJuZWxf
bG93LCAodWludDY0X3QgKikmYW1wO2tlcm5lbF9oaWdoLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDAsIEVNX01JUFMsIDEsIDApOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsIDAsIEVNX01JUFMsIDEsIDAp
Ozxicj4NCsKgIMKgIMKgaWYgKGtlcm5lbF9zaXplICZsdDsgMCkgezxicj4NCsKgIMKgIMKgIMKg
IMKgZXJyb3JfcmVwb3J0KCZxdW90O2NvdWxkIG5vdCBsb2FkIGtlcm5lbCAmIzM5OyVzJiMzOTs6
ICVzJnF1b3Q7LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxvYWRlcnBh
cmFtcy5rZXJuZWxfZmlsZW5hbWUsPGJyPg0KZGlmZiAtLWdpdCBhL2h3L21pcHMvbWlwc19tYWx0
YS5jIGIvaHcvbWlwcy9taXBzX21hbHRhLmM8YnI+DQppbmRleCA1YWFlYWE4Li4zNGI3NmJiIDEw
MDY0NDxicj4NCi0tLSBhL2h3L21pcHMvbWlwc19tYWx0YS5jPGJyPg0KKysrIGIvaHcvbWlwcy9t
aXBzX21hbHRhLmM8YnI+DQpAQCAtMTAzOSw3ICsxMDM5LDggQEAgc3RhdGljIGludDY0X3QgbG9h
ZF9rZXJuZWwodm9pZCk8YnI+DQrCoCDCoCDCoGtlcm5lbF9zaXplID0gbG9hZF9lbGYobG9hZGVy
cGFyYW1zLmtlcm5lbF88d2JyPmZpbGVuYW1lLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNwdV9taXBzX2tzZWcwX3RvX3BoeXMsIE5VTEwsPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKHVpbnQ2NF90ICop
JmFtcDtrZXJuZWxfZW50cnksIE5VTEwsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgKHVpbnQ2NF90ICopJmFtcDtrZXJuZWxfaGlnaCwgYmlnX2VuZGlhbiwg
RU1fTUlQUywgMSwgMCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgKHVpbnQ2NF90ICopJmFtcDtrZXJuZWxfaGlnaCwgTlVMTCwgYmlnX2VuZGlhbiwgRU1f
TUlQUyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAxLCAw
KTs8YnI+DQrCoCDCoCDCoGlmIChrZXJuZWxfc2l6ZSAmbHQ7IDApIHs8YnI+DQrCoCDCoCDCoCDC
oCDCoGVycm9yX3JlcG9ydCgmcXVvdDtjb3VsZCBub3QgbG9hZCBrZXJuZWwgJiMzOTslcyYjMzk7
OiAlcyZxdW90Oyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsb2FkZXJw
YXJhbXMua2VybmVsX2ZpbGVuYW1lLDxicj4NCmRpZmYgLS1naXQgYS9ody9taXBzL21pcHNfbWlw
c3NpbS5jIGIvaHcvbWlwcy9taXBzX21pcHNzaW0uYzxicj4NCmluZGV4IDg0YzAzZGQuLmI5MzRj
YTkgMTAwNjQ0PGJyPg0KLS0tIGEvaHcvbWlwcy9taXBzX21pcHNzaW0uYzxicj4NCisrKyBiL2h3
L21pcHMvbWlwc19taXBzc2ltLmM8YnI+DQpAQCAtNzQsNyArNzQsNyBAQCBzdGF0aWMgaW50NjRf
dCBsb2FkX2tlcm5lbCh2b2lkKTxicj4NCsKgIMKgIMKga2VybmVsX3NpemUgPSBsb2FkX2VsZihs
b2FkZXJwYXJhbXMua2VybmVsXzx3YnI+ZmlsZW5hbWUsIE5VTEwsPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY3B1X21pcHNfa3NlZzBfdG9fcGh5cywgTlVM
TCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAodWludDY0
X3QgKikmYW1wO2VudHJ5LCBOVUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCh1aW50NjRfdCAqKSZhbXA7a2VybmVsX2hpZ2gsIGJpZ19lbmRpYW4sPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHVpbnQ2NF90ICop
JmFtcDtrZXJuZWxfaGlnaCwgTlVMTCwgYmlnX2VuZGlhbiw8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBFTV9NSVBTLCAxLCAwKTs8YnI+DQrCoCDCoCDCoGlm
IChrZXJuZWxfc2l6ZSAmZ3Q7PSAwKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqBpZiAoKGVudHJ5ICZh
bXA7IH4weDdmZmZmZmZmVUxMKSA9PSAweDgwMDAwMDAwKSB7PGJyPg0KZGlmZiAtLWdpdCBhL2h3
L21pcHMvbWlwc19yNGsuYyBiL2h3L21pcHMvbWlwc19yNGsuYzxicj4NCmluZGV4IGZkOTI2YTMu
LmIyYWVjNDMgMTAwNjQ0PGJyPg0KLS0tIGEvaHcvbWlwcy9taXBzX3I0ay5jPGJyPg0KKysrIGIv
aHcvbWlwcy9taXBzX3I0ay5jPGJyPg0KQEAgLTk4LDcgKzk4LDcgQEAgc3RhdGljIGludDY0X3Qg
bG9hZF9rZXJuZWwodm9pZCk8YnI+DQrCoCDCoCDCoGtlcm5lbF9zaXplID0gbG9hZF9lbGYobG9h
ZGVycGFyYW1zLmtlcm5lbF88d2JyPmZpbGVuYW1lLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNwdV9taXBzX2tzZWcwX3RvX3BoeXMsIE5VTEws
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKHVpbnQ2NF90
ICopJmFtcDtlbnRyeSwgTlVMTCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAodWludDY0X3QgKikmYW1wO2tlcm5lbF9oaWdoLCBiaWdfZW5kaWFuLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCh1aW50NjRfdCAqKSZh
bXA7a2VybmVsX2hpZ2gsIE5VTEwsIGJpZ19lbmRpYW4sPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgRU1fTUlQUywgMSwgMCk7PGJyPg0KwqAgwqAgwqBpZiAo
a2VybmVsX3NpemUgJmd0Oz0gMCkgezxicj4NCsKgIMKgIMKgIMKgIMKgaWYgKChlbnRyeSAmYW1w
OyB+MHg3ZmZmZmZmZlVMTCkgPT0gMHg4MDAwMDAwMCkgezxicj4NCmRpZmYgLS1naXQgYS9ody9t
b3hpZS9tb3hpZXNpbS5jIGIvaHcvbW94aWUvbW94aWVzaW0uYzxicj4NCmluZGV4IDU3YWYxYjQu
LjFkMDZlMzkgMTAwNjQ0PGJyPg0KLS0tIGEvaHcvbW94aWUvbW94aWVzaW0uYzxicj4NCisrKyBi
L2h3L21veGllL21veGllc2ltLmM8YnI+DQpAQCAtNTgsNyArNTgsNyBAQCBzdGF0aWMgdm9pZCBs
b2FkX2tlcm5lbChNb3hpZUNQVSAqY3B1LCBMb2FkZXJQYXJhbXMgKmxvYWRlcl9wYXJhbXMpPGJy
Pg0KwqAgwqAgwqByYW1fYWRkcl90IGluaXRyZF9vZmZzZXQ7PGJyPg0KPGJyPg0KwqAgwqAgwqBr
ZXJuZWxfc2l6ZSA9IGxvYWRfZWxmKGxvYWRlcl9wYXJhbXMtJmd0Ozx3YnI+a2VybmVsX2ZpbGVu
YW1lLMKgIE5VTEwsIE5VTEwsIE5VTEwsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgJmFtcDtlbnRyeSwgJmFtcDtrZXJuZWxfbG93LCAmYW1wO2tlcm5lbF9o
aWdoLCAxLCBFTV9NT1hJRSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAmYW1wO2VudHJ5LCAmYW1wO2tlcm5lbF9sb3csICZhbXA7a2VybmVsX2hpZ2gsIE5V
TEwsIDEsIEVNX01PWElFLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIDAsIDApOzxicj4NCjxicj4NCsKgIMKgIMKgaWYgKGtlcm5lbF9zaXplICZsdDs9IDAp
IHs8YnI+DQpkaWZmIC0tZ2l0IGEvaHcvbmlvczIvYm9vdC5jIGIvaHcvbmlvczIvYm9vdC5jPGJy
Pg0KaW5kZXggZDc4YmM5ZS4uNDZiODM0OSAxMDA2NDQ8YnI+DQotLS0gYS9ody9uaW9zMi9ib290
LmM8YnI+DQorKysgYi9ody9uaW9zMi9ib290LmM8YnI+DQpAQCAtMTQ3LDcgKzE0Nyw3IEBAIHZv
aWQgbmlvczJfbG9hZF9rZXJuZWwoTmlvczJDUFUgKmNwdSwgaHdhZGRyIGRkcl9iYXNlLDxicj4N
Cjxicj4NCsKgIMKgIMKgIMKgIMKgLyogQm9vdHMgYSBrZXJuZWwgZWxmIGJpbmFyeS4gKi88YnI+
DQrCoCDCoCDCoCDCoCDCoGtlcm5lbF9zaXplID0gbG9hZF9lbGYoa2VybmVsX2ZpbGVuYW1lLCBO
VUxMLCBOVUxMLCBOVUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCZhbXA7ZW50cnksICZhbXA7bG93LCAmYW1wO2hpZ2gsPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtlbnRyeSwgJmFt
cDtsb3csICZhbXA7aGlnaCwgTlVMTCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBiaWdfZW5kaWFuLCBFTV9BTFRFUkFfTklPUzIsIDAsIDApOzxi
cj4NCsKgIMKgIMKgIMKgIMKgaWYgKCh1aW50MzJfdCllbnRyeSA9PSAweGMwMDAwMDAwKSB7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAvKjxicj4NCkBAIC0xNTgsNyArMTU4LDcgQEAgdm9pZCBu
aW9zMl9sb2FkX2tlcm5lbChOaW9zMkNQVSAqY3B1LCBod2FkZHIgZGRyX2Jhc2UsPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgKi88YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoGtlcm5lbF9zaXpl
ID0gbG9hZF9lbGYoa2VybmVsX2ZpbGVuYW1lLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRyYW5zbGF0ZV9rZXJuZWxfYWRk
cmVzcywgTlVMTCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAmYW1wO2VudHJ5LCBOVUxMLCBOVUxMLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7ZW50cnksIE5VTEws
IE5VTEwsIE5VTEwsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgYmlnX2VuZGlhbiwgRU1fQUxURVJBX05JT1MyLCAwLCAwKTs8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoGJvb3RfaW5mby5ib290c3RyYXBfcGMgPSBkZHJfYmFzZSArIDB4
YzAwMDAwMDAgKzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKGVudHJ5ICZhbXA7IDB4
MDdmZmZmZmYpOzxicj4NCmRpZmYgLS1naXQgYS9ody9vcGVucmlzYy9vcGVucmlzY19zaW0uYyBi
L2h3L29wZW5yaXNjL29wZW5yaXNjX3NpbS5jPGJyPg0KaW5kZXggNzllNzA0OS4uYWQ1MzcxMiAx
MDA2NDQ8YnI+DQotLS0gYS9ody9vcGVucmlzYy9vcGVucmlzY19zaW0uYzxicj4NCisrKyBiL2h3
L29wZW5yaXNjL29wZW5yaXNjX3NpbS5jPGJyPg0KQEAgLTk4LDcgKzk4LDcgQEAgc3RhdGljIHZv
aWQgb3BlbnJpc2NfbG9hZF9rZXJuZWwocmFtX2FkZHJfPHdicj50IHJhbV9zaXplLDxicj4NCjxi
cj4NCsKgIMKgIMKgaWYgKGtlcm5lbF9maWxlbmFtZSAmYW1wOyZhbXA7ICFxdGVzdF9lbmFibGVk
KCkpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoGtlcm5lbF9zaXplID0gbG9hZF9lbGYoa2VybmVsX2Zp
bGVuYW1lLCBOVUxMLCBOVUxMLCBOVUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7ZWxmX2VudHJ5LCBOVUxMLCBOVUxMLCAxLCBFTV9P
UEVOUklTQyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAmYW1wO2VsZl9lbnRyeSwgTlVMTCwgTlVMTCwgTlVMTCwgMSwgRU1fT1BFTlJJU0MsPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMSwgMCk7
PGJyPg0KwqAgwqAgwqAgwqAgwqBlbnRyeSA9IGVsZl9lbnRyeTs8YnI+DQrCoCDCoCDCoCDCoCDC
oGlmIChrZXJuZWxfc2l6ZSAmbHQ7IDApIHs8YnI+DQpkaWZmIC0tZ2l0IGEvaHcvcGNpLWhvc3Qv
cHJlcC5jIGIvaHcvcGNpLWhvc3QvcHJlcC5jPGJyPg0KaW5kZXggYWZhMTM2ZC4uZmNmNjIzNSAx
MDA2NDQ8YnI+DQotLS0gYS9ody9wY2ktaG9zdC9wcmVwLmM8YnI+DQorKysgYi9ody9wY2ktaG9z
dC9wcmVwLmM8YnI+DQpAQCAtMzM1LDcgKzMzNSw4IEBAIHN0YXRpYyB2b2lkIHJhdmVuX3JlYWxp
emUoUENJRGV2aWNlICpkLCBFcnJvciAqKmVycnApPGJyPg0KwqAgwqAgwqAgwqAgwqBpZiAoZmls
ZW5hbWUpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChzLSZndDtlbGZfbWFjaGluZSAh
PSBFTV9OT05FKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBiaW9zX3NpemUgPSBs
b2FkX2VsZihmaWxlbmFtZSwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCw8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOVUxMLCBOVUxM
LCAxLCBzLSZndDtlbGZfbWFjaGluZSwgMCwgMCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTlVMTCwgTlVMTCwgTlVMTCwgMSwg
cy0mZ3Q7ZWxmX21hY2hpbmUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMCwgMCk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqB9
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoYmlvc19zaXplICZsdDsgMCkgezxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYmlvc19zaXplID0gZ2V0X2ltYWdlX3NpemUoZmlsZW5h
bWUpOzxicj4NCmRpZmYgLS1naXQgYS9ody9wcGMvZTUwMC5jIGIvaHcvcHBjL2U1MDAuYzxicj4N
CmluZGV4IDEyYjZhNWIuLjg4NjQ0MmUgMTAwNjQ0PGJyPg0KLS0tIGEvaHcvcHBjL2U1MDAuYzxi
cj4NCisrKyBiL2h3L3BwYy9lNTAwLmM8YnI+DQpAQCAtMTA0OSw3ICsxMDQ5LDcgQEAgdm9pZCBw
cGNlNTAwX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKTxicj4NCsKgIMKgIMKgZmlsZW5hbWUg
PSBxZW11X2ZpbmRfZmlsZShRRU1VX0ZJTEVfVFlQRV88d2JyPkJJT1MsIHBheWxvYWRfbmFtZSk7
PGJyPg0KPGJyPg0KwqAgwqAgwqBwYXlsb2FkX3NpemUgPSBsb2FkX2VsZihmaWxlbmFtZSwgTlVM
TCwgTlVMTCwgTlVMTCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJmFtcDtiaW9zX2VudHJ5LCAmYW1wO2xvYWRhZGRyLCBOVUxMLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmYW1wO2Jpb3NfZW50cnksICZhbXA7
bG9hZGFkZHIsIE5VTEwsIE5VTEwsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAxLCBQUENfRUxGX01BQ0hJTkUsIDAsIDApOzxicj4NCsKgIMKgIMKgaWYg
KHBheWxvYWRfc2l6ZSAmbHQ7IDApIHs8YnI+DQrCoCDCoCDCoCDCoCDCoC8qPGJyPg0KZGlmZiAt
LWdpdCBhL2h3L3BwYy9tYWNfbmV3d29ybGQuYyBiL2h3L3BwYy9tYWNfbmV3d29ybGQuYzxicj4N
CmluZGV4IDM1OTQ1MTcuLjQ2NGQwMTIgMTAwNjQ0PGJyPg0KLS0tIGEvaHcvcHBjL21hY19uZXd3
b3JsZC5jPGJyPg0KKysrIGIvaHcvcHBjL21hY19uZXd3b3JsZC5jPGJyPg0KQEAgLTE2OCw3ICsx
NjgsNyBAQCBzdGF0aWMgdm9pZCBwcGNfY29yZTk5X2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5l
KTxicj4NCsKgIMKgIMKgLyogTG9hZCBPcGVuQklPUyAoRUxGKSAqLzxicj4NCsKgIMKgIMKgaWYg
KGZpbGVuYW1lKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqBiaW9zX3NpemUgPSBsb2FkX2VsZihmaWxl
bmFtZSwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOVUxMLCBOVUxMLCAxLCBQUENfRUxGX01BQ0hJTkUsIDAs
IDApOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5V
TEwsIE5VTEwsIE5VTEwsIDEsIFBQQ19FTEZfTUFDSElORSwgMCwgMCk7PGJyPg0KPGJyPg0KwqAg
wqAgwqAgwqAgwqBnX2ZyZWUoZmlsZW5hbWUpOzxicj4NCsKgIMKgIMKgfSBlbHNlIHs8YnI+DQpA
QCAtMTkyLDcgKzE5Miw3IEBAIHN0YXRpYyB2b2lkIHBwY19jb3JlOTlfaW5pdChNYWNoaW5lU3Rh
dGUgKm1hY2hpbmUpPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqBrZXJuZWxfc2l6ZSA9IGxvYWRf
ZWxmKGtlcm5lbF9maWxlbmFtZSwgTlVMTCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0cmFuc2xhdGVfa2VybmVsX2FkZHJlc3MsIE5VTEwsPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTlVMTCwg
JmFtcDtsb3dhZGRyLCBOVUxMLCAxLCBQUENfRUxGX01BQ0hJTkUsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTlVMTCwgJmFtcDtsb3dhZGRyLCBO
VUxMLCBOVUxMLCAxLCBQUENfRUxGX01BQ0hJTkUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMCwgMCk7PGJyPg0KwqAgwqAgwqAgwqAgwqBpZiAo
a2VybmVsX3NpemUgJmx0OyAwKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKga2VybmVsX3NpemUg
PSBsb2FkX2FvdXQoa2VybmVsX2ZpbGVuYW1lLCBrZXJuZWxfYmFzZSw8YnI+DQpkaWZmIC0tZ2l0
IGEvaHcvcHBjL21hY19vbGR3b3JsZC5jIGIvaHcvcHBjL21hY19vbGR3b3JsZC5jPGJyPg0KaW5k
ZXggMGZhNjgwYi4uNzMxOGQ3ZSAxMDA2NDQ8YnI+DQotLS0gYS9ody9wcGMvbWFjX29sZHdvcmxk
LmM8YnI+DQorKysgYi9ody9wcGMvbWFjX29sZHdvcmxkLmM8YnI+DQpAQCAtMTQzLDcgKzE0Myw3
IEBAIHN0YXRpYyB2b2lkIHBwY19oZWF0aHJvd19pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSk8
YnI+DQo8YnI+DQrCoCDCoCDCoC8qIExvYWQgT3BlbkJJT1MgKEVMRikgKi88YnI+DQrCoCDCoCDC
oGlmIChmaWxlbmFtZSkgezxicj4NCi3CoCDCoCDCoCDCoCBiaW9zX3NpemUgPSBsb2FkX2VsZihm
aWxlbmFtZSwgTlVMTCwgMCwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCw8YnI+DQorwqAgwqAgwqAg
wqAgYmlvc19zaXplID0gbG9hZF9lbGYoZmlsZW5hbWUsIE5VTEwsIDAsIE5VTEwsIE5VTEwsIE5V
TEwsIE5VTEwsIE5VTEwsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgMSwgUFBDX0VMRl9NQUNISU5FLCAwLCAwKTs8YnI+DQrCoCDCoCDCoCDCoCDCoGdf
ZnJlZShmaWxlbmFtZSk7PGJyPg0KwqAgwqAgwqB9IGVsc2Ugezxicj4NCkBAIC0xNjYsNyArMTY2
LDcgQEAgc3RhdGljIHZvaWQgcHBjX2hlYXRocm93X2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5l
KTxicj4NCsKgIMKgIMKgIMKgIMKga2VybmVsX2Jhc2UgPSBLRVJORUxfTE9BRF9BRERSOzxicj4N
CsKgIMKgIMKgIMKgIMKga2VybmVsX3NpemUgPSBsb2FkX2VsZihrZXJuZWxfZmlsZW5hbWUsIE5V
TEwsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
dHJhbnNsYXRlX2tlcm5lbF9hZGRyZXNzLCBOVUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsICZhbXA7bG93YWRkciwgTlVMTCwgMSwg
UFBDX0VMRl9NQUNISU5FLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoE5VTEwsICZhbXA7bG93YWRkciwgTlVMTCwgTlVMTCwgMSwgUFBDX0VMRl9N
QUNISU5FLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIDAsIDApOzxicj4NCsKgIMKgIMKgIMKgIMKgaWYgKGtlcm5lbF9zaXplICZsdDsgMCk8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoGtlcm5lbF9zaXplID0gbG9hZF9hb3V0KGtlcm5lbF9maWxl
bmFtZSwga2VybmVsX2Jhc2UsPGJyPg0KZGlmZiAtLWdpdCBhL2h3L3BwYy9wcGM0NDBfYmFtYm9v
LmMgYi9ody9wcGMvcHBjNDQwX2JhbWJvby5jPGJyPg0KaW5kZXggYjc4MjY0MS4uZGE3NzdlZiAx
MDA2NDQ8YnI+DQotLS0gYS9ody9wcGMvcHBjNDQwX2JhbWJvby5jPGJyPg0KKysrIGIvaHcvcHBj
L3BwYzQ0MF9iYW1ib28uYzxicj4NCkBAIC0yNTMsNyArMjUzLDcgQEAgc3RhdGljIHZvaWQgYmFt
Ym9vX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTlVMTCwgTlVMTCk7PGJyPg0KwqAgwqAgwqAgwqAg
wqBpZiAoc3VjY2VzcyAmbHQ7IDApIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoHN1Y2Nlc3Mg
PSBsb2FkX2VsZihrZXJuZWxfZmlsZW5hbWUsIE5VTEwsIE5VTEwsIE5VTEwsICZhbXA7ZWxmX2Vu
dHJ5LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCZhbXA7ZWxmX2xvd2FkZHIsIE5VTEwsIDEsIFBQQ19FTEZfTUFDSElORSw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO2VsZl9sb3dhZGRy
LCBOVUxMLCBOVUxMLCAxLCBQUENfRUxGX01BQ0hJTkUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMCwgMCk7PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqBlbnRyeSA9IGVsZl9lbnRyeTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoGxvYWRhZGRy
ID0gZWxmX2xvd2FkZHI7PGJyPg0KZGlmZiAtLWdpdCBhL2h3L3BwYy9zYW00NjBleC5jIGIvaHcv
cHBjL3NhbTQ2MGV4LmM8YnI+DQppbmRleCA0MzdlMjE0Li44OWJjNzBlIDEwMDY0NDxicj4NCi0t
LSBhL2h3L3BwYy9zYW00NjBleC5jPGJyPg0KKysrIGIvaHcvcHBjL3NhbTQ2MGV4LmM8YnI+DQpA
QCAtNDM5LDcgKzQzOSw4IEBAIHN0YXRpYyB2b2lkIHNhbTQ2MGV4X2luaXQoTWFjaGluZVN0YXRl
ICptYWNoaW5lKTxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgc3VjY2VzcyA9IGxvYWRf
ZWxmKG1hY2hpbmUtJmd0O2tlcm5lbF88d2JyPmZpbGVuYW1lLCBOVUxMLDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5VTEwsIE5VTEwsICZhbXA7
ZWxmX2VudHJ5LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCZhbXA7ZWxmX2xvd2FkZHIsIE5VTEwsIDEsIFBQQ19FTEZfTUFDSElORSwgMCwgMCk7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFt
cDtlbGZfbG93YWRkciwgTlVMTCwgTlVMTCwgMSwgUFBDX0VMRl9NQUNISU5FLCAwLDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDApOzxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgZW50cnkgPSBlbGZfZW50cnk7PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqBsb2FkYWRkciA9IGVsZl9sb3dhZGRyOzxicj4NCsKgIMKgIMKgIMKgIMKgfTxicj4NCmRp
ZmYgLS1naXQgYS9ody9wcGMvc3BhcHIuYyBiL2h3L3BwYy9zcGFwci5jPGJyPg0KaW5kZXggMDJj
ZjUzZi4uYTAwNzZlNSAxMDA2NDQ8YnI+DQotLS0gYS9ody9wcGMvc3BhcHIuYzxicj4NCisrKyBi
L2h3L3BwYy9zcGFwci5jPGJyPg0KQEAgLTI4OTUsMTMgKzI4OTUsMTMgQEAgc3RhdGljIHZvaWQg
c3BhcHJfbWFjaGluZV9pbml0KDx3YnI+TWFjaGluZVN0YXRlICptYWNoaW5lKTxicj4NCjxicj4N
CsKgIMKgIMKgIMKgIMKgc3BhcHItJmd0O2tlcm5lbF9zaXplID0gbG9hZF9lbGYoa2VybmVsX2Zp
bGVuYW1lLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgdHJhbnNsYXRlX2tlcm5lbF9hZGRyZXNzLCBOVUxMLDxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBOVUxMLCAmYW1wO2xvd2FkZHIsIE5VTEwsIDEsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5VTEwsICZhbXA7bG93YWRkciwg
TlVMTCwgTlVMTCwgMSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFBQQ19FTEZfTUFDSElORSwgMCwgMCk7PGJyPg0KwqAgwqAg
wqAgwqAgwqBpZiAoc3BhcHItJmd0O2tlcm5lbF9zaXplID09IEVMRl9MT0FEX1dST05HX0VORElB
Tikgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgc3BhcHItJmd0O2tlcm5lbF9zaXplID0gbG9h
ZF9lbGYoa2VybmVsX2ZpbGVuYW1lLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdHJhbnNsYXRlX2tlcm5l
bF9hZGRyZXNzLCBOVUxMLCBOVUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmYW1wO2xvd2FkZHIsIE5VTEwsIDAs
IFBQQ19FTEZfTUFDSElORSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMCwgMCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZhbXA7bG93
YWRkciwgTlVMTCwgTlVMTCwgMCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUFBDX0VMRl9NQUNISU5FLCAwLCAwKTs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoHNwYXByLSZndDtrZXJuZWxfbGUgPSBzcGFwci0mZ3Q7
a2VybmVsX3NpemUgJmd0OyAwOzxicj4NCsKgIMKgIMKgIMKgIMKgfTxicj4NCsKgIMKgIMKgIMKg
IMKgaWYgKHNwYXByLSZndDtrZXJuZWxfc2l6ZSAmbHQ7IDApIHs8YnI+DQpkaWZmIC0tZ2l0IGEv
aHcvcHBjL3ZpcnRleF9tbDUwNy5jIGIvaHcvcHBjL3ZpcnRleF9tbDUwNy5jPGJyPg0KaW5kZXgg
Njg2MjU1Mi4uNzUyNjk0NyAxMDA2NDQ8YnI+DQotLS0gYS9ody9wcGMvdmlydGV4X21sNTA3LmM8
YnI+DQorKysgYi9ody9wcGMvdmlydGV4X21sNTA3LmM8YnI+DQpAQCAtMjU5LDcgKzI1OSw3IEBA
IHN0YXRpYyB2b2lkIHZpcnRleF9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSk8YnI+DQo8YnI+
DQrCoCDCoCDCoCDCoCDCoC8qIEJvb3RzIGEga2VybmVsIGVsZiBiaW5hcnkuwqAgKi88YnI+DQrC
oCDCoCDCoCDCoCDCoGtlcm5lbF9zaXplID0gbG9hZF9lbGYoa2VybmVsX2ZpbGVuYW1lLCBOVUxM
LCBOVUxMLCBOVUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCZhbXA7ZW50cnksICZhbXA7bG93LCAmYW1wO2hpZ2gsIDEsIFBQQ19FTEZfTUFD
SElORSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAmYW1wO2VudHJ5LCAmYW1wO2xvdywgJmFtcDtoaWdoLCBOVUxMLCAxLCBQUENfRUxGX01BQ0hJ
TkUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
MCwgMCk7PGJyPg0KwqAgwqAgwqAgwqAgwqBib290X2luZm8uYm9vdHN0cmFwX3BjID0gZW50cnkg
JmFtcDsgMHgwMGZmZmZmZjs8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvYm9vdC5j
IGIvaHcvcmlzY3YvYm9vdC5jPGJyPg0KaW5kZXggMDI3MzAzZC4uYjhlNzY1MiAxMDA2NDQ8YnI+
DQotLS0gYS9ody9yaXNjdi9ib290LmM8YnI+DQorKysgYi9ody9yaXNjdi9ib290LmM8YnI+DQpA
QCAtMTAxLDcgKzEwMSw3IEBAIHRhcmdldF91bG9uZyByaXNjdl9sb2FkX2Zpcm13YXJlKGNvbnN0
IGNoYXIgKmZpcm13YXJlX2ZpbGVuYW1lLDxicj4NCsKgIMKgIMKgdWludDY0X3QgZmlybXdhcmVf
ZW50cnksIGZpcm13YXJlX3N0YXJ0LCBmaXJtd2FyZV9lbmQ7PGJyPg0KPGJyPg0KwqAgwqAgwqBp
ZiAobG9hZF9lbGYoZmlybXdhcmVfZmlsZW5hbWUsIE5VTEwsIE5VTEwsIE5VTEwsICZhbXA7Zmly
bXdhcmVfZW50cnksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtmaXJtd2Fy
ZV9zdGFydCwgJmFtcDtmaXJtd2FyZV9lbmQsIDAsIEVNX1JJU0NWLCAxLCAwKSAmZ3Q7IDApIHs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO2Zpcm13YXJlX3N0YXJ0LCAmYW1w
O2Zpcm13YXJlX2VuZCwgTlVMTCwgMCwgRU1fUklTQ1YsIDEsIDApICZndDsgMCkgezxicj4NCsKg
IMKgIMKgIMKgIMKgcmV0dXJuIGZpcm13YXJlX2VudHJ5Ozxicj4NCsKgIMKgIMKgfTxicj4NCjxi
cj4NCkBAIC0xMTksNyArMTE5LDcgQEAgdGFyZ2V0X3Vsb25nIHJpc2N2X2xvYWRfa2VybmVsKGNv
bnN0IGNoYXIgKmtlcm5lbF9maWxlbmFtZSwgc3ltYm9sX2ZuX3Qgc3ltX2NiKTxicj4NCsKgIMKg
IMKgdWludDY0X3Qga2VybmVsX2VudHJ5LCBrZXJuZWxfaGlnaDs8YnI+DQo8YnI+DQrCoCDCoCDC
oGlmIChsb2FkX2VsZl9yYW1fc3ltKGtlcm5lbF88d2JyPmZpbGVuYW1lLCBOVUxMLCBOVUxMLCBO
VUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7a2Vy
bmVsX2VudHJ5LCBOVUxMLCAmYW1wO2tlcm5lbF9oaWdoLCAwLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7a2VybmVsX2VudHJ5LCBOVUxMLCAmYW1wO2tl
cm5lbF9oaWdoLCBOVUxMLCAwLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIEVNX1JJU0NWLCAxLCAwLCBOVUxMLCB0cnVlLCBzeW1fY2IpICZndDsgMCkgezxicj4N
CsKgIMKgIMKgIMKgIMKgcmV0dXJuIGtlcm5lbF9lbnRyeTs8YnI+DQrCoCDCoCDCoH08YnI+DQpk
aWZmIC0tZ2l0IGEvaHcvczM5MHgvaXBsLmMgYi9ody9zMzkweC9pcGwuYzxicj4NCmluZGV4IGNh
NTQ0ZDYuLjQ5NTA2ZTQgMTAwNjQ0PGJyPg0KLS0tIGEvaHcvczM5MHgvaXBsLmM8YnI+DQorKysg
Yi9ody9zMzkweC9pcGwuYzxicj4NCkBAIC0xMzksNyArMTM5LDcgQEAgc3RhdGljIHZvaWQgczM5
MF9pcGxfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApPGJyPg0KPGJyPg0K
wqAgwqAgwqAgwqAgwqBiaW9zX3NpemUgPSBsb2FkX2VsZihiaW9zX2ZpbGVuYW1lLCBOVUxMLDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJpb3NfdHJh
bnNsYXRlX2FkZHIsICZhbXA7ZndiYXNlLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7aXBsLSZndDtiaW9zX3N0YXJ0X2FkZHIsIE5VTEwsIE5V
TEwsIDEsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
JmFtcDtpcGwtJmd0O2Jpb3Nfc3RhcnRfYWRkciwgTlVMTCwgTlVMTCwgTlVMTCwgMSw8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBFTV9TMzkwLCAwLCAw
KTs8YnI+DQrCoCDCoCDCoCDCoCDCoGlmIChiaW9zX3NpemUgJmd0OyAwKSB7PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAvKiBBZGp1c3QgRUxGIHN0YXJ0IGFkZHJlc3MgdG8gZmluYWwgbG9jYXRp
b24gKi88YnI+DQpAQCAtMTY0LDcgKzE2NCw3IEBAIHN0YXRpYyB2b2lkIHMzOTBfaXBsX3JlYWxp
emUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKTxicj4NCsKgIMKgIMKgaWYgKGlwbC0m
Z3Q7a2VybmVsKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqBrZXJuZWxfc2l6ZSA9IGxvYWRfZWxmKGlw
bC0mZ3Q7a2VybmVsLCBOVUxMLCBOVUxMLCBOVUxMLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZhbXA7cGVudHJ5LCBOVUxMLDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsIDEsIEVNX1Mz
OTAsIDAsIDApOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoE5VTEwsIE5VTEwsIDEsIEVNX1MzOTAsIDAsIDApOzxicj4NCsKgIMKgIMKgIMKgIMKg
aWYgKGtlcm5lbF9zaXplICZsdDsgMCkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKga2VybmVs
X3NpemUgPSBsb2FkX2ltYWdlX3RhcmdwaHlzKGlwbC0mZ3Q7PHdicj5rZXJuZWwsIDAsIHJhbV9z
aXplKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChrZXJuZWxfc2l6ZSAmbHQ7IDApIHs8
YnI+DQpAQCAtNDczLDcgKzQ3Myw4IEBAIHN0YXRpYyBpbnQgbG9hZF9uZXRib290X2ltYWdlKEVy
cm9yICoqZXJycCk8YnI+DQo8YnI+DQrCoCDCoCDCoGltZ19zaXplID0gbG9hZF9lbGZfcmFtKG5l
dGJvb3RfZmlsZW5hbWUsIE5VTEwsIE5VTEwsIE5VTEwsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO2lwbC0mZ3Q7c3RhcnRfYWRkciw8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTlVMTCwgTlVMTCwgMSwg
RU1fUzM5MCwgMCwgMCwgTlVMTCwgZmFsc2UpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCBOVUxMLCBOVUxMLCAxLCBFTV9TMzkwLCAwLCAwLCBO
VUxMLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmYWxz
ZSk7PGJyPg0KPGJyPg0KwqAgwqAgwqBpZiAoaW1nX3NpemUgJmx0OyAwKSB7PGJyPg0KwqAgwqAg
wqAgwqAgwqBpbWdfc2l6ZSA9IGxvYWRfaW1hZ2Vfc2l6ZShuZXRib290Xzx3YnI+ZmlsZW5hbWUs
IHJhbV9wdHIsIHJhbV9zaXplKTs8YnI+DQpkaWZmIC0tZ2l0IGEvaHcvc3BhcmMvbGVvbjMuYyBi
L2h3L3NwYXJjL2xlb24zLmM8YnI+DQppbmRleCA4MDM4ODg3Li5mNWEwODdkIDEwMDY0NDxicj4N
Ci0tLSBhL2h3L3NwYXJjL2xlb24zLmM8YnI+DQorKysgYi9ody9zcGFyYy9sZW9uMy5jPGJyPg0K
QEAgLTI5Nyw3ICsyOTcsNyBAQCBzdGF0aWMgdm9pZCBsZW9uM19nZW5lcmljX2h3X2luaXQoPHdi
cj5NYWNoaW5lU3RhdGUgKm1hY2hpbmUpPGJyPg0KwqAgwqAgwqAgwqAgwqB1aW50NjRfdCBlbnRy
eTs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoGtlcm5lbF9zaXplID0gbG9hZF9lbGYoa2VybmVs
X2ZpbGVuYW1lLCBOVUxMLCBOVUxMLCBOVUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7ZW50cnksIE5VTEwsIE5VTEwsPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtlbnRyeSwg
TlVMTCwgTlVMTCwgTlVMTCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAxIC8qIGJpZyBlbmRpYW4gKi8sIEVNX1NQQVJDLCAwLCAwKTs8YnI+DQrC
oCDCoCDCoCDCoCDCoGlmIChrZXJuZWxfc2l6ZSAmbHQ7IDApIHs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoGtlcm5lbF9zaXplID0gbG9hZF91aW1hZ2Uoa2VybmVsX2ZpbGVuYW1lLCBOVUxMLCAm
YW1wO2VudHJ5LDxicj4NCmRpZmYgLS1naXQgYS9ody9zcGFyYy9zdW40bS5jIGIvaHcvc3BhcmMv
c3VuNG0uYzxicj4NCmluZGV4IDJhYWE1YmYuLmQ0MDQzNTMgMTAwNjQ0PGJyPg0KLS0tIGEvaHcv
c3BhcmMvc3VuNG0uYzxicj4NCisrKyBiL2h3L3NwYXJjL3N1bjRtLmM8YnI+DQpAQCAtMjcwLDcg
KzI3MCw3IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIHN1bjRtX2xvYWRfa2VybmVsKGNvbnN0IGNo
YXIgKmtlcm5lbF9maWxlbmFtZSw8YnI+DQrCoCNlbmRpZjxicj4NCsKgIMKgIMKgIMKgIMKga2Vy
bmVsX3NpemUgPSBsb2FkX2VsZihrZXJuZWxfZmlsZW5hbWUsIE5VTEwsPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdHJhbnNsYXRlX2tlcm5lbF9h
ZGRyZXNzLCBOVUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoE5VTEwsIE5VTEwsIE5VTEwsIDEsIEVNX1NQQVJDLCAwLCAwKTs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOVUxMLCBOVUxMLCBO
VUxMLCBOVUxMLCAxLCBFTV9TUEFSQywgMCwgMCk7PGJyPg0KwqAgwqAgwqAgwqAgwqBpZiAoa2Vy
bmVsX3NpemUgJmx0OyAwKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKga2VybmVsX3NpemUgPSBs
b2FkX2FvdXQoa2VybmVsX2ZpbGVuYW1lLCBLRVJORUxfTE9BRF9BRERSLDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUkFNX3NpemUg
LSBLRVJORUxfTE9BRF9BRERSLCBic3dhcF9uZWVkZWQsPGJyPg0KQEAgLTcyMSw3ICs3MjEsNyBA
QCBzdGF0aWMgdm9pZCBwcm9tX2luaXQoaHdhZGRyIGFkZHIsIGNvbnN0IGNoYXIgKmJpb3NfbmFt
ZSk8YnI+DQrCoCDCoCDCoGlmIChmaWxlbmFtZSkgezxicj4NCsKgIMKgIMKgIMKgIMKgcmV0ID0g
bG9hZF9lbGYoZmlsZW5hbWUsIE5VTEwsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgdHJhbnNsYXRlX3Byb21fYWRkcmVzcywgJmFtcDthZGRyLCBOVUxMLDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsIE5VTEwsIDEsIEVNX1NQQVJD
LCAwLCAwKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOVUxMLCBO
VUxMLCBOVUxMLCAxLCBFTV9TUEFSQywgMCwgMCk7PGJyPg0KwqAgwqAgwqAgwqAgwqBpZiAocmV0
ICZsdDsgMCB8fCByZXQgJmd0OyBQUk9NX1NJWkVfTUFYKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqByZXQgPSBsb2FkX2ltYWdlX3RhcmdwaHlzKGZpbGVuYW1lLCBhZGRyLCBQUk9NX1NJWkVf
TUFYKTs8YnI+DQrCoCDCoCDCoCDCoCDCoH08YnI+DQpkaWZmIC0tZ2l0IGEvaHcvc3BhcmM2NC9z
dW40dS5jIGIvaHcvc3BhcmM2NC9zdW40dS5jPGJyPg0KaW5kZXggOTU1MDgyNy4uYzc0NjA0MCAx
MDA2NDQ8YnI+DQotLS0gYS9ody9zcGFyYzY0L3N1bjR1LmM8YnI+DQorKysgYi9ody9zcGFyYzY0
L3N1bjR1LmM8YnI+DQpAQCAtMTc1LDcgKzE3NSw4IEBAIHN0YXRpYyB1aW50NjRfdCBzdW40dV9s
b2FkX2tlcm5lbChjb25zdCBjaGFyICprZXJuZWxfZmlsZW5hbWUsPGJyPg0KwqAgwqAgwqAgwqAg
wqBic3dhcF9uZWVkZWQgPSAwOzxicj4NCsKgI2VuZGlmPGJyPg0KwqAgwqAgwqAgwqAgwqBrZXJu
ZWxfc2l6ZSA9IGxvYWRfZWxmKGtlcm5lbF9maWxlbmFtZSwgTlVMTCwgTlVMTCwgTlVMTCwga2Vy
bmVsX2VudHJ5LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGtlcm5lbF9hZGRyLCAmYW1wO2tlcm5lbF90b3AsIDEsIEVNX1NQQVJDVjksIDAsIDAp
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGtl
cm5lbF9hZGRyLCAmYW1wO2tlcm5lbF90b3AsIE5VTEwsIDEsIEVNX1NQQVJDVjksIDAsPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMCk7PGJyPg0K
wqAgwqAgwqAgwqAgwqBpZiAoa2VybmVsX3NpemUgJmx0OyAwKSB7PGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAqa2VybmVsX2FkZHIgPSBLRVJORUxfTE9BRF9BRERSOzxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgKmtlcm5lbF9lbnRyeSA9IEtFUk5FTF9MT0FEX0FERFI7PGJyPg0KQEAgLTQzOSw3
ICs0NDAsNyBAQCBzdGF0aWMgdm9pZCBwcm9tX2luaXQoaHdhZGRyIGFkZHIsIGNvbnN0IGNoYXIg
KmJpb3NfbmFtZSk8YnI+DQrCoCDCoCDCoGZpbGVuYW1lID0gcWVtdV9maW5kX2ZpbGUoUUVNVV9G
SUxFX1RZUEVfPHdicj5CSU9TLCBiaW9zX25hbWUpOzxicj4NCsKgIMKgIMKgaWYgKGZpbGVuYW1l
KSB7PGJyPg0KwqAgwqAgwqAgwqAgwqByZXQgPSBsb2FkX2VsZihmaWxlbmFtZSwgTlVMTCwgdHJh
bnNsYXRlX3Byb21fYWRkcmVzcywgJmFtcDthZGRyLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoE5VTEwsIE5VTEwsIE5VTEwsIDEsIEVNX1NQQVJDVjksIDAsIDApOzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsIE5VTEwsIE5VTEws
IE5VTEwsIDEsIEVNX1NQQVJDVjksIDAsIDApOzxicj4NCsKgIMKgIMKgIMKgIMKgaWYgKHJldCAm
bHQ7IDAgfHwgcmV0ICZndDsgUFJPTV9TSVpFX01BWCkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgcmV0ID0gbG9hZF9pbWFnZV90YXJncGh5cyhmaWxlbmFtZSwgYWRkciwgUFJPTV9TSVpFX01B
WCk7PGJyPg0KwqAgwqAgwqAgwqAgwqB9PGJyPg0KZGlmZiAtLWdpdCBhL2h3L3RyaWNvcmUvdHJp
Y29yZV88d2JyPnRlc3Rib2FyZC5jIGIvaHcvdHJpY29yZS90cmljb3JlXzx3YnI+dGVzdGJvYXJk
LmM8YnI+DQppbmRleCBhZWYzMjg5Li4yMGM5Y2NiIDEwMDY0NDxicj4NCi0tLSBhL2h3L3RyaWNv
cmUvdHJpY29yZV88d2JyPnRlc3Rib2FyZC5jPGJyPg0KKysrIGIvaHcvdHJpY29yZS90cmljb3Jl
Xzx3YnI+dGVzdGJvYXJkLmM8YnI+DQpAQCAtNDIsNyArNDIsNyBAQCBzdGF0aWMgdm9pZCB0cmlj
b3JlX2xvYWRfa2VybmVsKDx3YnI+Q1BVVHJpQ29yZVN0YXRlICplbnYpPGJyPg0KPGJyPg0KwqAg
wqAgwqBrZXJuZWxfc2l6ZSA9IGxvYWRfZWxmKHRyaWNvcmV0Yl9iaW5mby48d2JyPmtlcm5lbF9m
aWxlbmFtZSwgTlVMTCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBOVUxMLCBOVUxMLCAmYW1wO2VudHJ5LCBOVUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsIDAsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTlVMTCwgTlVMTCwgMCw8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBFTV9UUklDT1JFLCAxLCAwKTs8YnI+DQrCoCDC
oCDCoGlmIChrZXJuZWxfc2l6ZSAmbHQ7PSAwKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqBlcnJvcl9y
ZXBvcnQoJnF1b3Q7bm8ga2VybmVsIGZpbGUgJiMzOTslcyYjMzk7JnF1b3Q7LDxicj4NCmRpZmYg
LS1naXQgYS9ody94dGVuc2Evc2ltLmMgYi9ody94dGVuc2Evc2ltLmM8YnI+DQppbmRleCBhMjI3
NDNhLi5hZWI0NmQ4IDEwMDY0NDxicj4NCi0tLSBhL2h3L3h0ZW5zYS9zaW0uYzxicj4NCisrKyBi
L2h3L3h0ZW5zYS9zaW0uYzxicj4NCkBAIC0xMDgsNyArMTA4LDcgQEAgdm9pZCB4dGVuc2Ffc2lt
X2xvYWRfa2VybmVsKDx3YnI+WHRlbnNhQ1BVICpjcHUsIE1hY2hpbmVTdGF0ZSAqbWFjaGluZSk8
YnI+DQrCoCDCoCDCoCDCoCDCoHVpbnQ2NF90IGVsZl9lbnRyeTs8YnI+DQrCoCDCoCDCoCDCoCDC
oHVpbnQ2NF90IGVsZl9sb3dhZGRyOzxicj4NCsKgIMKgIMKgIMKgIMKgaW50IHN1Y2Nlc3MgPSBs
b2FkX2VsZihrZXJuZWxfZmlsZW5hbWUsIE5VTEwsIHRyYW5zbGF0ZV9waHlzX2FkZHIsIGNwdSw8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1w
O2VsZl9lbnRyeSwgJmFtcDtlbGZfbG93YWRkciwgTlVMTCwgYmlnX2VuZGlhbiw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO2VsZl9lbnRy
eSwgJmFtcDtlbGZfbG93YWRkciwgTlVMTCwgTlVMTCwgYmlnX2VuZGlhbiw8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBFTV9YVEVOU0EsIDAsIDAp
Ozxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgaWYgKHN1Y2Nlc3MgJmd0OyAwKSB7PGJyPg0KZGlm
ZiAtLWdpdCBhL2h3L3h0ZW5zYS94dGZwZ2EuYyBiL2h3L3h0ZW5zYS94dGZwZ2EuYzxicj4NCmlu
ZGV4IDgyMjBjN2EuLjhlMmRkMTMgMTAwNjQ0PGJyPg0KLS0tIGEvaHcveHRlbnNhL3h0ZnBnYS5j
PGJyPg0KKysrIGIvaHcveHRlbnNhL3h0ZnBnYS5jPGJyPg0KQEAgLTQxNSw3ICs0MTUsNyBAQCBz
dGF0aWMgdm9pZCB4dGZwZ2FfaW5pdChjb25zdCBYdGZwZ2FCb2FyZERlc2MgKmJvYXJkLCBNYWNo
aW5lU3RhdGUgKm1hY2hpbmUpPGJyPg0KwqAgwqAgwqAgwqAgwqB1aW50NjRfdCBlbGZfZW50cnk7
PGJyPg0KwqAgwqAgwqAgwqAgwqB1aW50NjRfdCBlbGZfbG93YWRkcjs8YnI+DQrCoCDCoCDCoCDC
oCDCoGludCBzdWNjZXNzID0gbG9hZF9lbGYoa2VybmVsX2ZpbGVuYW1lLCBOVUxMLCB0cmFuc2xh
dGVfcGh5c19hZGRyLCBjcHUsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZhbXA7ZWxm
X2VudHJ5LCAmYW1wO2VsZl9sb3dhZGRyLCBOVUxMLCBiZSwgRU1fWFRFTlNBLCAwLCAwKTs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmFtcDtlbGZfZW50cnksICZhbXA7ZWxmX2xvd2Fk
ZHIsIE5VTEwsIE5VTEwsIGJlLCBFTV9YVEVOU0EsIDAsIDApOzxicj4NCsKgIMKgIMKgIMKgIMKg
aWYgKHN1Y2Nlc3MgJmd0OyAwKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqBlbnRyeV9wb2lu
dCA9IGVsZl9lbnRyeTs8YnI+DQrCoCDCoCDCoCDCoCDCoH0gZWxzZSB7PGJyPg0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvaHcvZWxmX29wcy5oIGIvaW5jbHVkZS9ody9lbGZfb3BzLmg8YnI+DQppbmRl
eCBlMDdkMjc2Li5hMTQxMWJmIDEwMDY0NDxicj4NCi0tLSBhL2luY2x1ZGUvaHcvZWxmX29wcy5o
PGJyPg0KKysrIGIvaW5jbHVkZS9ody9lbGZfb3BzLmg8YnI+DQpAQCAtMzE2LDcgKzMxNiw4IEBA
IHN0YXRpYyBpbnQgZ2x1ZShsb2FkX2VsZiwgU1opKGNvbnN0IGNoYXIgKm5hbWUsIGludCBmZCw8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHZvaWQg
KnRyYW5zbGF0ZV9vcGFxdWUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpbnQgbXVzdF9zd2FiLCB1aW50NjRfdCAqcGVudHJ5LDxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdWludDY0X3QgKmxvd2Fk
ZHIsIHVpbnQ2NF90ICpoaWdoYWRkciw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgaW50IGVsZl9tYWNoaW5lLCBpbnQgY2xlYXJfbHNiLCBpbnQgZGF0
YV9zd2FiLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB1aW50MzJfdCAqcGZsYWdzLCBpbnQgZWxmX21hY2hpbmUsPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGludCBjbGVhcl9sc2IsIGludCBkYXRhX3N3
YWIsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBB
ZGRyZXNzU3BhY2UgKmFzLCBib29sIGxvYWRfcm9tLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3ltYm9sX2ZuX3Qgc3ltX2NiKTxicj4NCsKgezxi
cj4NCkBAIC0zODksNiArMzkwLDkgQEAgc3RhdGljIGludCBnbHVlKGxvYWRfZWxmLCBTWikoY29u
c3QgY2hhciAqbmFtZSwgaW50IGZkLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCsKg
IMKgIMKgfTxicj4NCjxicj4NCivCoCDCoCBpZiAocGZsYWdzKSB7PGJyPg0KK8KgIMKgIMKgIMKg
ICpwZmxhZ3MgPSAoZWxmX3dvcmQpZWhkci5lX2ZsYWdzOzxicj4NCivCoCDCoCB9PGJyPg0KwqAg
wqAgwqBpZiAocGVudHJ5KTxicj4NCsKgIMKgIMKgIMKgIMKgKnBlbnRyeSA9ICh1aW50NjRfdCko
ZWxmX3N3b3JkKWVoZHIuZV88d2JyPmVudHJ5Ozxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2h3L2xvYWRlci5oIGIvaW5jbHVkZS9ody9sb2FkZXIuaDxicj4NCmluZGV4IDQ4YTk2Y2Qu
LmE5ZWVlYTMgMTAwNjQ0PGJyPg0KLS0tIGEvaW5jbHVkZS9ody9sb2FkZXIuaDxicj4NCisrKyBi
L2luY2x1ZGUvaHcvbG9hZGVyLmg8YnI+DQpAQCAtMTAxLDYgKzEwMSw3IEBAIGNvbnN0IGNoYXIg
KmxvYWRfZWxmX3N0cmVycm9yKGludCBlcnJvcik7PGJyPg0KwqAgKiBAcGVudHJ5OiBQb3B1bGF0
ZWQgd2l0aCBwcm9ncmFtIGVudHJ5IHBvaW50LiBJZ25vcmVkIGlmIE5VTEwuPGJyPg0KwqAgKiBA
bG93YWRkcjogUG9wdWxhdGVkIHdpdGggbG93ZXN0IGxvYWRlZCBhZGRyZXNzLiBJZ25vcmVkIGlm
IE5VTEwuPGJyPg0KwqAgKiBAaGlnaGFkZHI6IFBvcHVsYXRlZCB3aXRoIGhpZ2hlc3QgbG9hZGVk
IGFkZHJlc3MuIElnbm9yZWQgaWYgTlVMTC48YnI+DQorICogQHBmbGFnczogUG9wdWxhdGVkIHdp
dGggRUxGIHByb2Nlc3Nvci1zcGVjaWZpYyBmbGFncy4gSWdub3JlIGlmIE5VTEwuPGJyPg0KwqAg
KiBAYmlnZW5kaWFuOiBFeHBlY3RlZCBFTEYgZW5kaWFubmVzcy4gMCBmb3IgTEUgb3RoZXJ3aXNl
IEJFPGJyPg0KwqAgKiBAZWxmX21hY2hpbmU6IEV4cGVjdGVkIEVMRiBtYWNoaW5lIHR5cGU8YnI+
DQrCoCAqIEBjbGVhcl9sc2I6IFNldCB0byBtYXNrIG9mZiBMU0Igb2YgYWRkcmVzc2VzIChTb21l
IGFyY2hpdGVjdHVyZXMgdXNlPGJyPg0KQEAgLTEzMSw4ICsxMzIsOSBAQCBpbnQgbG9hZF9lbGZf
cmFtX3N5bShjb25zdCBjaGFyICpmaWxlbmFtZSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB1aW50NjRfdCAoKmVsZl9ub3RlX2ZuKSh2b2lkICosIHZvaWQgKiwgYm9vbCks
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdWludDY0X3QgKCp0cmFuc2xh
dGVfZm4pKHZvaWQgKiwgdWludDY0X3QpLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHZvaWQgKnRyYW5zbGF0ZV9vcGFxdWUsIHVpbnQ2NF90ICpwZW50cnksPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdWludDY0X3QgKmxvd2FkZHIsIHVpbnQ2NF90
ICpoaWdoYWRkciwgaW50IGJpZ19lbmRpYW4sPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaW50IGVsZl9tYWNoaW5lLCBpbnQgY2xlYXJfbHNiLCBpbnQgZGF0YV9zd2FiLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQ2NF90ICpsb3dhZGRyLCB1
aW50NjRfdCAqaGlnaGFkZHIsIHVpbnQzMl90ICpwZmxhZ3MsPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaW50IGJpZ19lbmRpYW4sIGludCBlbGZfbWFjaGluZSw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQgY2xlYXJfbHNiLCBpbnQgZGF0YV9z
d2FiLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEFkZHJlc3NTcGFjZSAq
YXMsIGJvb2wgbG9hZF9yb20sIHN5bWJvbF9mbl90IHN5bV9jYik7PGJyPg0KPGJyPg0KwqAvKiog
bG9hZF9lbGZfcmFtOjxicj4NCkBAIC0xNDMsOSArMTQ1LDkgQEAgaW50IGxvYWRfZWxmX3JhbShj
b25zdCBjaGFyICpmaWxlbmFtZSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1aW50
NjRfdCAoKmVsZl9ub3RlX2ZuKSh2b2lkICosIHZvaWQgKiwgYm9vbCksPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgdWludDY0X3QgKCp0cmFuc2xhdGVfZm4pKHZvaWQgKiwgdWludDY0
X3QpLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHZvaWQgKnRyYW5zbGF0ZV9vcGFx
dWUsIHVpbnQ2NF90ICpwZW50cnksIHVpbnQ2NF90ICpsb3dhZGRyLDxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHVpbnQ2NF90ICpoaWdoYWRkciwgaW50IGJpZ19lbmRpYW4sIGludCBl
bGZfbWFjaGluZSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQgY2xlYXJfbHNi
LCBpbnQgZGF0YV9zd2FiLCBBZGRyZXNzU3BhY2UgKmFzLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGJvb2wgbG9hZF9yb20pOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHVpbnQ2NF90ICpoaWdoYWRkciwgdWludDMyX3QgKnBmbGFncywgaW50IGJpZ19lbmRpYW4sPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW50IGVsZl9tYWNoaW5lLCBpbnQgY2xlYXJf
bHNiLCBpbnQgZGF0YV9zd2FiLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEFkZHJl
c3NTcGFjZSAqYXMsIGJvb2wgbG9hZF9yb20pOzxicj4NCjxicj4NCsKgLyoqIGxvYWRfZWxmX2Fz
Ojxicj4NCsKgICogU2FtZSBhcyBsb2FkX2VsZl9yYW0oKSwgYnV0IGFsd2F5cyBsb2FkcyB0aGUg
ZWxmIGFzIFJPTTxicj4NCkBAIC0xNTQsOCArMTU2LDkgQEAgaW50IGxvYWRfZWxmX2FzKGNvbnN0
IGNoYXIgKmZpbGVuYW1lLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdWludDY0X3Qg
KCplbGZfbm90ZV9mbikodm9pZCAqLCB2b2lkICosIGJvb2wpLDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgdWludDY0X3QgKCp0cmFuc2xhdGVfZm4pKHZvaWQgKiwgdWludDY0X3QpLDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdm9pZCAqdHJhbnNsYXRlX29wYXF1ZSwgdWlu
dDY0X3QgKnBlbnRyeSwgdWludDY0X3QgKmxvd2FkZHIsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHVpbnQ2NF90ICpoaWdoYWRkciwgaW50IGJpZ19lbmRpYW4sIGludCBlbGZfbWFjaGlu
ZSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaW50IGNsZWFyX2xzYiwgaW50IGRhdGFf
c3dhYiwgQWRkcmVzc1NwYWNlICphcyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVp
bnQ2NF90ICpoaWdoYWRkciwgdWludDMyX3QgKnBmbGFncywgaW50IGJpZ19lbmRpYW4sPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGludCBlbGZfbWFjaGluZSwgaW50IGNsZWFyX2xzYiwg
aW50IGRhdGFfc3dhYiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQWRkcmVzc1NwYWNl
ICphcyk7PGJyPg0KPGJyPg0KwqAvKiogbG9hZF9lbGY6PGJyPg0KwqAgKiBTYW1lIGFzIGxvYWRf
ZWxmX2FzKCksIGJ1dCBkb2VzbiYjMzk7dCBhbGxvdyB0aGUgY2FsbGVyIHRvIHNwZWNpZnkgYW48
YnI+DQpAQCAtMTY1LDggKzE2OCw4IEBAIGludCBsb2FkX2VsZihjb25zdCBjaGFyICpmaWxlbmFt
ZSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCB1aW50NjRfdCAoKmVsZl9ub3RlX2ZuKSh2b2lk
ICosIHZvaWQgKiwgYm9vbCksPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgdWludDY0X3QgKCp0
cmFuc2xhdGVfZm4pKHZvaWQgKiwgdWludDY0X3QpLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IHZvaWQgKnRyYW5zbGF0ZV9vcGFxdWUsIHVpbnQ2NF90ICpwZW50cnksIHVpbnQ2NF90ICpsb3dh
ZGRyLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQ2NF90ICpoaWdoYWRkciwgaW50IGJp
Z19lbmRpYW4sIGludCBlbGZfbWFjaGluZSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQg
Y2xlYXJfbHNiLCBpbnQgZGF0YV9zd2FiKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50
NjRfdCAqaGlnaGFkZHIsIHVpbnQzMl90ICpwZmxhZ3MsIGludCBiaWdfZW5kaWFuLDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoGludCBlbGZfbWFjaGluZSwgaW50IGNsZWFyX2xzYiwgaW50IGRh
dGFfc3dhYik7PGJyPg0KPGJyPg0KwqAvKiogbG9hZF9lbGZfaGRyOjxicj4NCsKgICogQGZpbGVu
YW1lOiBQYXRoIG9mIEVMRiBmaWxlPGJyPg0KLS0gPGJyPg0KMi43LjQ8YnI+DQo8YnI+DQo8YnI+
DQo8L2Jsb2NrcXVvdGU+DQo=
--000000000000a8e4d1059d304f94--

