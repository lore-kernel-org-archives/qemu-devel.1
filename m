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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B41C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 23:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95942214D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 23:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd7ylhfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95942214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwZxG-0001k5-KJ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 18:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwZwM-0000zf-Vt
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwZwF-0001p5-8b
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:06:38 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iwZwE-0001oU-Ry
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:06:31 -0500
Received: by mail-ot1-x342.google.com with SMTP id d3so13471351otp.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 15:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zCL22YU7pFaBiDnjXHN08GRLnVf2Bi19CoDrxy9L/k8=;
 b=Vd7ylhfFKbh4x4a1hBwcDwxx8xyWDPFnycpmlpnkNaJ+hi6KVMNKwS1yYTv88q6fUJ
 m3vEIBxprNrtrWt12SjWjQIdFUWfTeXYH+aJNynDJ0yRVSxdmVMppCV/urVBGSiSGtki
 3DO2mt8i/E0mT2fWIKX5STRej1Hm+Eb4QdERNyswCEgaf2gdOClD24i6n1MzyaX29+uQ
 eqPvSR+ZL+3ZVkHji6rLXD2totcZFdjboRNpHt03L1nEogR1FBHtKR7gKT509spflwjx
 pnNTrL5CYRdfHoST1wYqhDFtsGU1mf1yv/cW6KQ7Zu+NTTWBxebHza+coyuo3xpiMeGx
 LW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zCL22YU7pFaBiDnjXHN08GRLnVf2Bi19CoDrxy9L/k8=;
 b=figDNZL04a1FVmR0DQErBqi1p7uzO4fc+DDqphCqONLtlYzlcrpziOpiMX6hQeTZqz
 OaEr3xFgAolpy17gwPoW54WKaz81c8q0RrRGDyjBtuuGAFLrXjBxy6IVxPJ1Pyihaj0U
 ktaAoUyHvMyCJMz8e+NyPItMNw8WT9mRTD0E5U2wjo2AjlGitMWtBkTPPG6mE82cvxYL
 M9kFpzOiCSxH7feW32MzIk7WkpW8x3MERJPm4oxjPdkqil9XVHpkcmJDW46EK26fSXoQ
 T8Wu7HPynJniHljvb4Ce3VGc3jOljiu5zmsDxqRVZ1rT6DQ5fpsQiihv9y4iXxh8fsSP
 GxKw==
X-Gm-Message-State: APjAAAW43KgJv1DRlvBI39GmDdw+SVNsy0AR9ymXaQLFWt7UISNUk57v
 3KmTz9nW7vKo28M51E7fBF6zHfSA92l+xzYv1+A=
X-Google-Smtp-Source: APXvYqw/HfSlrVt3KvOVg1+9/diqC1HOLDlRjIRsPvXQ/n1zIuNyvFs3MblJ4be8tDNNEKx4HowIo8tGZSDAo8w1sf0=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr17596718otk.64.1580252789085; 
 Tue, 28 Jan 2020 15:06:29 -0800 (PST)
MIME-Version: 1.0
References: <1580242161-20333-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580242161-20333-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1580242161-20333-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 29 Jan 2020 00:06:12 +0100
Message-ID: <CAL1e-=g2FTxL60JD1YWFLSQ_fMBHXBis1ynpbjF-jBmek_FzQg@mail.gmail.com>
Subject: Re: [PULL 4/6] hw/core/loader: Let load_elf() populate the
 processor-specific flags
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: multipart/alternative; boundary="000000000000261a16059d3b4631"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jia Liu <proljc@gmail.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 Michael Rolnik <mrolnik@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Michael Walle <michael@walle.cc>, amarkovic@wavecomp.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000261a16059d3b4631
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

21:10 Uto, 28.01.2020. Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

Unfortunately, some spelling errors of mine slipped through the cracks:

> While loading the executable, some platforms (like AVR) need to
> determine CPU type that executable is built for by reading the
> field 'e_flags' of the ELF header of tha executable.
>

s/tha/the

> This patch enables such discovery of that field while using any
> of the following functions:
>
>   - load_elf()
>   - load_elf_as()
>   - load_elf_ram()
>   - load_elf_ram_sym()
>
> The argument added to these functions is called 'pflags' and is of
> type 'uint32_t*' (that matches the the pointer to the 'elf_word' -

s/the the/the

May I ask you, Peter, to fix them while applying?

Regards,
Aleksandar

> the type of the field 'e_flags' in both 32-bit and 64-bit variants
> of ELF header). Callers are allowed to pass NULL as that argument,
> and in such case no lookup to the field 'e_flags' will happen, and
> no information will be returned, of course.
>
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
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Message-Id: <
1580079311-20447-24-git-send-email-aleksandar.markovic@rt-rk.com>
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
NULL,
>                      0, EM_ALPHA, 0, 0);
>      if (size < 0) {
>          error_report("could not load palcode '%s'", palcode_filename);
> @@ -134,7 +134,7 @@ static void clipper_init(MachineState *machine)
>          uint64_t param_offset;
>
>          size =3D load_elf(kernel_filename, NULL,
cpu_alpha_superpage_to_phys,
> -                        NULL, &kernel_entry, &kernel_low, &kernel_high,
> +                        NULL, &kernel_entry, &kernel_low, &kernel_high,
NULL,
>                          0, EM_ALPHA, 0, 0);
>          if (size < 0) {
>              error_report("could not load kernel '%s'", kernel_filename);
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 5d4a581..7531b97 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -331,7 +331,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char
*kernel_filename, int mem_size)
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
*info, uint64_t *pentry,
>      }
>
>      ret =3D load_elf_as(info->kernel_filename, NULL, NULL, NULL,
> -                      pentry, lowaddr, highaddr, big_endian, elf_machine=
,
> +                      pentry, lowaddr, highaddr, NULL, big_endian,
elf_machine,
>                        1, data_swab, as);
>      if (ret <=3D 0) {
>          /* The header loaded but the image didn't */
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index e7eb57e..b9aaa52 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -140,7 +140,7 @@ static void generic_loader_realize(DeviceState *dev,
Error **errp)
>
>          if (!s->force_raw) {
>              size =3D load_elf_as(s->file, NULL, NULL, NULL, &entry, NULL=
,
NULL,
> -                               big_endian, 0, 0, 0, as);
> +                               NULL, big_endian, 0, 0, 0, as);
>
>              if (size < 0) {
>                  size =3D load_uimage_as(s->file, &entry, NULL, NULL, NUL=
L,
NULL,
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
translate_opaque,
> -                       pentry, lowaddr, highaddr, big_endian,
elf_machine,
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
*lowaddr,
> -                uint64_t *highaddr, int big_endian, int elf_machine,
> -                int clear_lsb, int data_swab, AddressSpace *as)
> +                uint64_t *highaddr, uint32_t *pflags, int big_endian,
> +                int elf_machine, int clear_lsb, int data_swab,
AddressSpace *as)
>  {
>      return load_elf_ram(filename, elf_note_fn, translate_fn,
translate_opaque,
> -                        pentry, lowaddr, highaddr, big_endian,
elf_machine,
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
*lowaddr,
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
> +                            pentry, lowaddr, highaddr, pflags,
big_endian,
>                              elf_machine, clear_lsb, data_swab, as,
>                              load_rom, NULL);
>  }
> @@ -448,8 +448,9 @@ int load_elf_ram_sym(const char *filename,
>                       uint64_t (*elf_note_fn)(void *, void *, bool),
>                       uint64_t (*translate_fn)(void *, uint64_t),
>                       void *translate_opaque, uint64_t *pentry,
> -                     uint64_t *lowaddr, uint64_t *highaddr, int
big_endian,
> -                     int elf_machine, int clear_lsb, int data_swab,
> +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t
*pflags,
> +                     int big_endian, int elf_machine,
> +                     int clear_lsb, int data_swab,
>                       AddressSpace *as, bool load_rom, symbol_fn_t sym_cb=
)
>  {
>      int fd, data_order, target_data_order, must_swab, ret =3D
ELF_LOAD_FAILED;
> @@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,
>      if (e_ident[EI_CLASS] =3D=3D ELFCLASS64) {
>          ret =3D load_elf64(filename, fd, elf_note_fn,
>                           translate_fn, translate_opaque, must_swab,
> -                         pentry, lowaddr, highaddr, elf_machine,
clear_lsb,
> -                         data_swab, as, load_rom, sym_cb);
> +                         pentry, lowaddr, highaddr, pflags, elf_machine,
> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>      } else {
>          ret =3D load_elf32(filename, fd, elf_note_fn,
>                           translate_fn, translate_opaque, must_swab,
> -                         pentry, lowaddr, highaddr, elf_machine,
clear_lsb,
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
> @@ -76,7 +76,7 @@ void cris_load_image(CRISCPU *cpu, struct
cris_load_info *li)
>         devboard SDK.  */
>      image_size =3D load_elf(li->image_filename, NULL,
>                            translate_kernel_address, NULL,
> -                          &entry, NULL, &high, 0, EM_CRIS, 0, 0);
> +                          &entry, NULL, &high, NULL, 0, EM_CRIS, 0, 0);
>      li->entry =3D entry;
>      if (image_size < 0) {
>          /* Takes a kimage from the axis devboard SDK.  */
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 2d62a24..d8755ec 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -155,7 +155,7 @@ static void machine_hppa_init(MachineState *machine)
>      }
>
>      size =3D load_elf(firmware_filename, NULL, NULL, NULL,
> -                    &firmware_entry, &firmware_low, &firmware_high,
> +                    &firmware_entry, &firmware_low, &firmware_high, NULL=
,
>                      true, EM_PARISC, 0, 0);
>
>      /* Unfortunately, load_elf sign-extends reading elf32.  */
> @@ -184,7 +184,7 @@ static void machine_hppa_init(MachineState *machine)
>      /* Load kernel */
>      if (kernel_filename) {
>          size =3D load_elf(kernel_filename, NULL, &cpu_hppa_to_phys,
> -                        NULL, &kernel_entry, &kernel_low, &kernel_high,
> +                        NULL, &kernel_entry, &kernel_low, &kernel_high,
NULL,
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
&elf_entry,
> -                               &elf_low, &elf_high, 0, I386_ELF_MACHINE,
> +                               &elf_low, &elf_high, NULL, 0,
I386_ELF_MACHINE,
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
> +                           &elf_low, &elf_high, NULL, 0,
I386_ELF_MACHINE,
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
hwaddr ddr_base,
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
*)&kernel_high,
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
> -                           (uint64_t *)&kernel_high, big_endian,
EM_MIPS, 1, 0);
> +                           (uint64_t *)&kernel_high, NULL, big_endian,
EM_MIPS,
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
*loader_params)
>      ram_addr_t initrd_offset;
>
>      kernel_size =3D load_elf(loader_params->kernel_filename,  NULL, NULL=
,
NULL,
> -                           &entry, &kernel_low, &kernel_high, 1,
EM_MOXIE,
> +                           &entry, &kernel_low, &kernel_high, NULL, 1,
EM_MOXIE,
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
EM_OPENRISC,
>                                 1, 0);
>          entry =3D elf_entry;
>          if (kernel_size < 0) {
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index f2f8821..1aff72b 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -335,7 +335,8 @@ static void raven_realize(PCIDevice *d, Error **errp)
>          if (filename) {
>              if (s->elf_machine !=3D EM_NONE) {
>                  bios_size =3D load_elf(filename, NULL, NULL, NULL, NULL,
> -                                     NULL, NULL, 1, s->elf_machine, 0,
0);
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
PPC_ELF_MACHINE,
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
NULL,
>                               1, PPC_ELF_MACHINE, 0, 0);
>          g_free(filename);
>      } else {
> @@ -166,7 +166,7 @@ static void ppc_heathrow_init(MachineState *machine)
>          kernel_base =3D KERNEL_LOAD_ADDR;
>          kernel_size =3D load_elf(kernel_filename, NULL,
>                                 translate_kernel_address, NULL,
> -                               NULL, &lowaddr, NULL, 1, PPC_ELF_MACHINE,
> +                               NULL, &lowaddr, NULL, NULL, 1,
PPC_ELF_MACHINE,
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
&elf_entry,
> -                               &elf_lowaddr, NULL, 1, PPC_ELF_MACHINE,
> +                               &elf_lowaddr, NULL, NULL, 1,
PPC_ELF_MACHINE,
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
> -                               &elf_lowaddr, NULL, 1, PPC_ELF_MACHINE,
0, 0);
> +                               &elf_lowaddr, NULL, NULL, 1,
PPC_ELF_MACHINE, 0,
> +                               0);
>              entry =3D elf_entry;
>              loadaddr =3D elf_lowaddr;
>          }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 02cf53f..a0076e5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2895,13 +2895,13 @@ static void spapr_machine_init(MachineState
*machine)
>
>          spapr->kernel_size =3D load_elf(kernel_filename, NULL,
>                                        translate_kernel_address, NULL,
> -                                      NULL, &lowaddr, NULL, 1,
> +                                      NULL, &lowaddr, NULL, NULL, 1,
>                                        PPC_ELF_MACHINE, 0, 0);
>          if (spapr->kernel_size =3D=3D ELF_LOAD_WRONG_ENDIAN) {
>              spapr->kernel_size =3D load_elf(kernel_filename, NULL,
>                                            translate_kernel_address,
NULL, NULL,
> -                                          &lowaddr, NULL, 0,
PPC_ELF_MACHINE,
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
PPC_ELF_MACHINE,
>                                 0, 0);
>          boot_info.bootstrap_pc =3D entry & 0x00ffffff;
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 027303d..b8e7652 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -101,7 +101,7 @@ target_ulong riscv_load_firmware(const char
*firmware_filename,
>      uint64_t firmware_entry, firmware_start, firmware_end;
>
>      if (load_elf(firmware_filename, NULL, NULL, NULL, &firmware_entry,
> -                 &firmware_start, &firmware_end, 0, EM_RISCV, 1, 0) > 0)
{
> +                 &firmware_start, &firmware_end, NULL, 0, EM_RISCV, 1,
0) > 0) {
>          return firmware_entry;
>      }
>
> @@ -119,7 +119,7 @@ target_ulong riscv_load_kernel(const char
*kernel_filename, symbol_fn_t sym_cb)
>      uint64_t kernel_entry, kernel_high;
>
>      if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
> -                         &kernel_entry, NULL, &kernel_high, 0,
> +                         &kernel_entry, NULL, &kernel_high, NULL, 0,
>                           EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
>          return kernel_entry;
>      }
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index b3ae901..ca8e7db 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -139,7 +139,7 @@ static void s390_ipl_realize(DeviceState *dev, Error
**errp)
>
>          bios_size =3D load_elf(bios_filename, NULL,
>                               bios_translate_addr, &fwbase,
> -                             &ipl->bios_start_addr, NULL, NULL, 1,
> +                             &ipl->bios_start_addr, NULL, NULL, NULL, 1,
>                               EM_S390, 0, 0);
>          if (bios_size > 0) {
>              /* Adjust ELF start address to final location */
> @@ -164,7 +164,7 @@ static void s390_ipl_realize(DeviceState *dev, Error
**errp)
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
*machine)
>          uint64_t entry;
>
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> -                               &entry, NULL, NULL,
> +                               &entry, NULL, NULL, NULL,
>                                 1 /* big endian */, EM_SPARC, 0, 0);
>          if (kernel_size < 0) {
>              kernel_size =3D load_uimage(kernel_filename, NULL, &entry,
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index df33b32..25e96db 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -270,7 +270,7 @@ static unsigned long sun4m_load_kernel(const char
*kernel_filename,
>  #endif
>          kernel_size =3D load_elf(kernel_filename, NULL,
>                                 translate_kernel_address, NULL,
> -                               NULL, NULL, NULL, 1, EM_SPARC, 0, 0);
> +                               NULL, NULL, NULL, NULL, 1, EM_SPARC, 0,
0);
>          if (kernel_size < 0)
>              kernel_size =3D load_aout(kernel_filename, KERNEL_LOAD_ADDR,
>                                      RAM_size - KERNEL_LOAD_ADDR,
bswap_needed,
> @@ -721,7 +721,7 @@ static void prom_init(hwaddr addr, const char
*bios_name)
>      if (filename) {
>          ret =3D load_elf(filename, NULL,
>                         translate_prom_address, &addr, NULL,
> -                       NULL, NULL, 1, EM_SPARC, 0, 0);
> +                       NULL, NULL, NULL, 1, EM_SPARC, 0, 0);
>          if (ret < 0 || ret > PROM_SIZE_MAX) {
>              ret =3D load_image_targphys(filename, addr, PROM_SIZE_MAX);
>          }
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 5d710d6..b7ac42f 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -175,7 +175,8 @@ static uint64_t sun4u_load_kernel(const char
*kernel_filename,
>          bswap_needed =3D 0;
>  #endif
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
kernel_entry,
> -                               kernel_addr, &kernel_top, 1, EM_SPARCV9,
0, 0);
> +                               kernel_addr, &kernel_top, NULL, 1,
EM_SPARCV9, 0,
> +                               0);
>          if (kernel_size < 0) {
>              *kernel_addr =3D KERNEL_LOAD_ADDR;
>              *kernel_entry =3D KERNEL_LOAD_ADDR;
> @@ -439,7 +440,7 @@ static void prom_init(hwaddr addr, const char
*bios_name)
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>      if (filename) {
>          ret =3D load_elf(filename, NULL, translate_prom_address, &addr,
> -                       NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);
> +                       NULL, NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);
>          if (ret < 0 || ret > PROM_SIZE_MAX) {
>              ret =3D load_image_targphys(filename, addr, PROM_SIZE_MAX);
>          }
> diff --git a/hw/tricore/tricore_testboard.c
b/hw/tricore/tricore_testboard.c
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
MachineState *machine)
>          uint64_t elf_entry;
>          uint64_t elf_lowaddr;
>          int success =3D load_elf(kernel_filename, NULL,
translate_phys_addr, cpu,
> -                               &elf_entry, &elf_lowaddr, NULL,
big_endian,
> +                               &elf_entry, &elf_lowaddr, NULL, NULL,
big_endian,
>                                 EM_XTENSA, 0, 0);
>
>          if (success > 0) {
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index 8220c7a..8e2dd13 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -415,7 +415,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board,
MachineState *machine)
>          uint64_t elf_entry;
>          uint64_t elf_lowaddr;
>          int success =3D load_elf(kernel_filename, NULL,
translate_phys_addr, cpu,
> -                &elf_entry, &elf_lowaddr, NULL, be, EM_XTENSA, 0, 0);
> +                &elf_entry, &elf_lowaddr, NULL, NULL, be, EM_XTENSA, 0,
0);
>          if (success > 0) {
>              entry_point =3D elf_entry;
>          } else {
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index e07d276..a1411bf 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, int
fd,
>                                void *translate_opaque,
>                                int must_swab, uint64_t *pentry,
>                                uint64_t *lowaddr, uint64_t *highaddr,
> -                              int elf_machine, int clear_lsb, int
data_swab,
> +                              uint32_t *pflags, int elf_machine,
> +                              int clear_lsb, int data_swab,
>                                AddressSpace *as, bool load_rom,
>                                symbol_fn_t sym_cb)
>  {
> @@ -389,6 +390,9 @@ static int glue(load_elf, SZ)(const char *name, int
fd,
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
big_endian,
> -                     int elf_machine, int clear_lsb, int data_swab,
> +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t
*pflags,
> +                     int big_endian, int elf_machine,
> +                     int clear_lsb, int data_swab,
>                       AddressSpace *as, bool load_rom, symbol_fn_t
sym_cb);
>
>  /** load_elf_ram:
> @@ -143,9 +145,9 @@ int load_elf_ram(const char *filename,
>                   uint64_t (*elf_note_fn)(void *, void *, bool),
>                   uint64_t (*translate_fn)(void *, uint64_t),
>                   void *translate_opaque, uint64_t *pentry, uint64_t
*lowaddr,
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
*lowaddr,
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

--000000000000261a16059d3b4631
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">21:10 Uto, 28.01.2020. Aleksandar Markovic &lt;<a href=3D"ma=
ilto:aleksandar.markovic@rt-rk.com">aleksandar.markovic@rt-rk.com</a>&gt; =
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.or=
g">f4bug@amsat.org</a>&gt;<br>
&gt;</p>
<p dir=3D"ltr">Unfortunately, some spelling errors of mine slipped through =
the cracks:<br></p>
<p dir=3D"ltr">&gt; While loading the executable, some platforms (like AVR)=
 need to<br>
&gt; determine CPU type that executable is built for by reading the<br>
&gt; field &#39;e_flags&#39; of the ELF header of tha executable.<br>
&gt;</p>
<p dir=3D"ltr">s/tha/the</p>
<p dir=3D"ltr">&gt; This patch enables such discovery of that field while u=
sing any<br>
&gt; of the following functions:<br>
&gt;<br>
&gt; =C2=A0 - load_elf()<br>
&gt; =C2=A0 - load_elf_as()<br>
&gt; =C2=A0 - load_elf_ram()<br>
&gt; =C2=A0 - load_elf_ram_sym()<br>
&gt;<br>
&gt; The argument added to these functions is called &#39;pflags&#39; and i=
s of<br>
&gt; type &#39;uint32_t*&#39; (that matches the the pointer to the &#39;elf=
_word&#39; -</p>
<p dir=3D"ltr">s/the the/the</p>
<p dir=3D"ltr">May I ask you, Peter, to fix them while applying?</p>
<p dir=3D"ltr">Regards,<br>
Aleksandar</p>
<p dir=3D"ltr">&gt; the type of the field &#39;e_flags&#39; in both 32-bit =
and 64-bit variants<br>
&gt; of ELF header). Callers are allowed to pass NULL as that argument,<br>
&gt; and in such case no lookup to the field &#39;e_flags&#39; will happen,=
 and<br>
&gt; no information will be returned, of course.<br>
&gt;<br>
&gt; CC: Richard Henderson &lt;<a href=3D"mailto:rth@twiddle.net">rth@twidd=
le.net</a>&gt;<br>
&gt; CC: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">pete=
r.maydell@linaro.org</a>&gt;<br>
&gt; CC: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com">=
edgar.iglesias@gmail.com</a>&gt;<br>
&gt; CC: Michael Walle &lt;michael@walle.cc&gt;<br>
&gt; CC: Thomas Huth &lt;<a href=3D"mailto:huth@tuxfamily.org">huth@tuxfami=
ly.org</a>&gt;<br>
&gt; CC: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu">laurent@vi=
vier.eu</a>&gt;<br>
&gt; CC: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org"=
>f4bug@amsat.org</a>&gt;<br>
&gt; CC: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-rk.co=
m">aleksandar.rikalo@rt-rk.com</a>&gt;<br>
&gt; CC: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net">aurelie=
n@aurel32.net</a>&gt;<br>
&gt; CC: Jia Liu &lt;<a href=3D"mailto:proljc@gmail.com">proljc@gmail.com</=
a>&gt;<br>
&gt; CC: David Gibson &lt;<a href=3D"mailto:david@gibson.dropbear.id.au">da=
vid@gibson.dropbear.id.au</a>&gt;<br>
&gt; CC: Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.=
uk">mark.cave-ayland@ilande.co.uk</a>&gt;<br>
&gt; CC: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@e=
ik.bme.hu</a>&gt;<br>
&gt; CC: Christian Borntraeger &lt;<a href=3D"mailto:borntraeger@de.ibm.com=
">borntraeger@de.ibm.com</a>&gt;<br>
&gt; CC: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.c=
om</a>&gt;<br>
&gt; CC: Artyom Tarasenko &lt;<a href=3D"mailto:atar4qemu@gmail.com">atar4q=
emu@gmail.com</a>&gt;<br>
&gt; CC: Fabien Chouteau &lt;<a href=3D"mailto:chouteau@adacore.com">choute=
au@adacore.com</a>&gt;<br>
&gt; CC: KONRAD Frederic &lt;<a href=3D"mailto:frederic.konrad@adacore.com"=
>frederic.konrad@adacore.com</a>&gt;<br>
&gt; CC: Max Filippov &lt;<a href=3D"mailto:jcmvbkbc@gmail.com">jcmvbkbc@gm=
ail.com</a>&gt;<br>
&gt;<br>
&gt; Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavec=
omp.com">amarkovic@wavecomp.com</a>&gt;<br>
&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com"=
>mrolnik@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org">f4bug@amsat.org</a>&gt;<br>
&gt; Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.=
mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt;<br>
&gt; Message-Id: &lt;<a href=3D"mailto:1580079311-20447-24-git-send-email-a=
leksandar.markovic@rt-rk.com">1580079311-20447-24-git-send-email-aleksandar=
.markovic@rt-rk.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0hw/alpha/dp264.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 4 ++--<br>
&gt; =C2=A0hw/arm/armv7m.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-<br>
&gt; =C2=A0hw/arm/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt; =C2=A0hw/core/generic-loader.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
&gt; =C2=A0hw/core/loader.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 37 +++++++++++++++++++------------------<br>
&gt; =C2=A0hw/cris/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt; =C2=A0hw/hppa/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 4 ++--<br>
&gt; =C2=A0hw/i386/multiboot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 +-<br>
&gt; =C2=A0hw/i386/x86.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt; =C2=A0hw/lm32/lm32_boards.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
4 ++--<br>
&gt; =C2=A0hw/lm32/milkymist.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 +-<br>
&gt; =C2=A0hw/m68k/an5206.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 2 +-<br>
&gt; =C2=A0hw/m68k/mcf5208.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 2 +-<br>
&gt; =C2=A0hw/m68k/q800.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt; =C2=A0hw/microblaze/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 4 ++--<br>
&gt; =C2=A0hw/mips/mips_fulong2e.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<=
br>
&gt; =C2=A0hw/mips/mips_malta.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 3 ++-<br>
&gt; =C2=A0hw/mips/mips_mipssim.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
2 +-<br>
&gt; =C2=A0hw/mips/mips_r4k.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 +-<br>
&gt; =C2=A0hw/moxie/moxiesim.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 +-<br>
&gt; =C2=A0hw/nios2/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 4 ++--<br>
&gt; =C2=A0hw/openrisc/openrisc_sim.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt; =C2=A0hw/pci-host/prep.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 3 ++-<br>
&gt; =C2=A0hw/ppc/e500.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt; =C2=A0hw/ppc/mac_newworld.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
4 ++--<br>
&gt; =C2=A0hw/ppc/mac_oldworld.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
4 ++--<br>
&gt; =C2=A0hw/ppc/ppc440_bamboo.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
2 +-<br>
&gt; =C2=A0hw/ppc/sam460ex.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 3 ++-<br>
&gt; =C2=A0hw/ppc/spapr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 6 +++---<br>
&gt; =C2=A0hw/ppc/virtex_ml507.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
2 +-<br>
&gt; =C2=A0hw/riscv/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 4 ++--<br>
&gt; =C2=A0hw/s390x/ipl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 7 ++++---<br>
&gt; =C2=A0hw/sparc/leon3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 2 +-<br>
&gt; =C2=A0hw/sparc/sun4m.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 4 ++--<br>
&gt; =C2=A0hw/sparc64/sun4u.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 5 +++--<br>
&gt; =C2=A0hw/tricore/tricore_testboard.c |=C2=A0 2 +-<br>
&gt; =C2=A0hw/xtensa/sim.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-<br>
&gt; =C2=A0hw/xtensa/xtfpga.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 +-<br>
&gt; =C2=A0include/hw/elf_ops.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 6 +++++-<br>
&gt; =C2=A0include/hw/loader.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2=
1 ++++++++++++---------<br>
&gt; =C2=A040 files changed, 92 insertions(+), 79 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c<br>
&gt; index f2026fd..a8f9a89 100644<br>
&gt; --- a/hw/alpha/dp264.c<br>
&gt; +++ b/hw/alpha/dp264.c<br>
&gt; @@ -115,7 +115,7 @@ static void clipper_init(MachineState *machine)<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0 =C2=A0 =C2=A0size =3D load_elf(palcode_filename, NULL, cpu_alph=
a_superpage_to_phys,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 NULL, &amp;palcode_entry, &amp;palcode_low, &amp;palcode_high,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 NULL, &amp;palcode_entry, &amp;palcode_low, &amp;palcode_high, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00, EM_ALPHA, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;could not load pa=
lcode &#39;%s&#39;&quot;, palcode_filename);<br>
&gt; @@ -134,7 +134,7 @@ static void clipper_init(MachineState *machine)<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t param_offset;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D load_elf(kernel_filename, N=
ULL, cpu_alpha_superpage_to_phys,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 NULL, &amp;kernel_entry, &amp;kernel_low, &amp;kernel_high,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 NULL, &amp;kernel_entry, &amp;kernel_low, &amp;kernel_high, =
NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00, EM_ALPHA, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;cou=
ld not load kernel &#39;%s&#39;&quot;, kernel_filename);<br>
&gt; diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c<br>
&gt; index 5d4a581..7531b97 100644<br>
&gt; --- a/hw/arm/armv7m.c<br>
&gt; +++ b/hw/arm/armv7m.c<br>
&gt; @@ -331,7 +331,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *k=
ernel_filename, int mem_size)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (kernel_filename) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_size =3D load_elf_as(kernel_fi=
lename, NULL, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;lowaddr,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;lowaddr, =
NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, big_endian, EM_ARM, =
1, 0, as);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (image_size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_size =3D load_im=
age_targphys_as(kernel_filename, 0,<br>
&gt; diff --git a/hw/arm/boot.c b/hw/arm/boot.c<br>
&gt; index 8fb4a63..0c213ca 100644<br>
&gt; --- a/hw/arm/boot.c<br>
&gt; +++ b/hw/arm/boot.c<br>
&gt; @@ -903,7 +903,7 @@ static int64_t arm_load_elf(struct arm_boot_info *=
info, uint64_t *pentry,<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0ret =3D load_elf_as(info-&gt;kernel_filename, NULL=
, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pentry, lowaddr, highaddr, big_endian, elf_machine,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pentry, lowaddr, highaddr, NULL, big_endian, elf_machine,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A01, data_swab, as);<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (ret &lt;=3D 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The header loaded but the image d=
idn&#39;t */<br>
&gt; diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c<br>
&gt; index e7eb57e..b9aaa52 100644<br>
&gt; --- a/hw/core/generic-loader.c<br>
&gt; +++ b/hw/core/generic-loader.c<br>
&gt; @@ -140,7 +140,7 @@ static void generic_loader_realize(DeviceState *de=
v, Error **errp)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;force_raw) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D load_elf_as(s=
-&gt;file, NULL, NULL, NULL, &amp;entry, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0big_endian, 0, 0, 0, as);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, big_endian, 0, 0, 0, as);<b=
r>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D=
 load_uimage_as(s-&gt;file, &amp;entry, NULL, NULL, NULL, NULL,<br>
&gt; diff --git a/hw/core/loader.c b/hw/core/loader.c<br>
&gt; index 5099f27..d1b78f6 100644<br>
&gt; --- a/hw/core/loader.c<br>
&gt; +++ b/hw/core/loader.c<br>
&gt; @@ -406,12 +406,12 @@ int load_elf(const char *filename,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t (*elf_note_f=
n)(void *, void *, bool),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t (*translate_=
fn)(void *, uint64_t),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *translate_opaqu=
e, uint64_t *pentry, uint64_t *lowaddr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *highaddr, i=
nt big_endian, int elf_machine,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int clear_lsb, int da=
ta_swab)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *highaddr, u=
int32_t *pflags, int big_endian,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int elf_machine, int =
clear_lsb, int data_swab)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0return load_elf_as(filename, elf_note_fn, translat=
e_fn, translate_opaque,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pentry, lowaddr, highaddr, big_endian, elf_machine,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0clear_lsb, data_swab, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pentry, lowaddr, highaddr, pflags, big_endian,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0elf_machine, clear_lsb, data_swab, NULL);<br>
&gt; =C2=A0}<br>
&gt;<br>
&gt; =C2=A0/* return &lt; 0 if error, otherwise the number of bytes loaded =
in memory */<br>
&gt; @@ -419,12 +419,12 @@ int load_elf_as(const char *filename,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=
 (*elf_note_fn)(void *, void *, bool),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=
 (*translate_fn)(void *, uint64_t),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *tr=
anslate_opaque, uint64_t *pentry, uint64_t *lowaddr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *hig=
haddr, int big_endian, int elf_machine,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int clear_lsb=
, int data_swab, AddressSpace *as)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *hig=
haddr, uint32_t *pflags, int big_endian,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int elf_machi=
ne, int clear_lsb, int data_swab, AddressSpace *as)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0return load_elf_ram(filename, elf_note_fn, transla=
te_fn, translate_opaque,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 pentry, lowaddr, highaddr, big_endian, elf_machine,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 clear_lsb, data_swab, as, true);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 pentry, lowaddr, highaddr, pflags, big_endian,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 elf_machine, clear_lsb, data_swab, as, true);<br>
&gt; =C2=A0}<br>
&gt;<br>
&gt; =C2=A0/* return &lt; 0 if error, otherwise the number of bytes loaded =
in memory */<br>
&gt; @@ -432,13 +432,13 @@ int load_elf_ram(const char *filename,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_=
t (*elf_note_fn)(void *, void *, bool),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_=
t (*translate_fn)(void *, uint64_t),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *t=
ranslate_opaque, uint64_t *pentry, uint64_t *lowaddr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_=
t *highaddr, int big_endian, int elf_machine,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int cle=
ar_lsb, int data_swab, AddressSpace *as,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool lo=
ad_rom)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_=
t *highaddr, uint32_t *pflags, int big_endian,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int elf=
_machine, int clear_lsb, int data_swab,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Address=
Space *as, bool load_rom)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0return load_elf_ram_sym(filename, elf_note_fn,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0translate_fn, translate_opaque,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pentry, lowaddr, highaddr, big_endian,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pentry, lowaddr, highaddr, pflags, big_endian,=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elf_machine, clear_lsb, data_swab, as,<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0load_rom, NULL);<br>
&gt; =C2=A0}<br>
&gt; @@ -448,8 +448,9 @@ int load_elf_ram_sym(const char *filename,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint64_t (*elf_note_fn)(void *, void *, bool),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint64_t (*translate_fn)(void *, uint64_t),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 void *translate_opaque, uint64_t *pentry,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0uint64_t *lowaddr, uint64_t *highaddr, int big_endian,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int elf_machine, int clear_lsb, int data_swab,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0uint64_t *lowaddr, uint64_t *highaddr, uint32_t *pflags,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int big_endian, int elf_machine,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int clear_lsb, int data_swab,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 AddressSpace *as, bool load_rom, symbol_fn_t sym_cb)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0int fd, data_order, target_data_order, must_swab, =
ret =3D ELF_LOAD_FAILED;<br>
&gt; @@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (e_ident[EI_CLASS] =3D=3D ELFCLASS64) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D load_elf64(filename, fd, elf=
_note_fn,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 translate_fn, translate_opaque, must_swab,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, elf_machine, clear_lsb,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0data_swab, as, load_rom, sym_cb);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, pflags, elf_machine,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0clear_lsb, data_swab, as, load_rom, sym_cb);<br>
&gt; =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D load_elf32(filename, fd, elf=
_note_fn,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 translate_fn, translate_opaque, must_swab,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, elf_machine, clear_lsb,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0data_swab, as, load_rom, sym_cb);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, pflags, elf_machine,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0clear_lsb, data_swab, as, load_rom, sym_cb);<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; =C2=A0 fail:<br>
&gt; diff --git a/hw/cris/boot.c b/hw/cris/boot.c<br>
&gt; index 2d2cc0c..b8947bc 100644<br>
&gt; --- a/hw/cris/boot.c<br>
&gt; +++ b/hw/cris/boot.c<br>
&gt; @@ -76,7 +76,7 @@ void cris_load_image(CRISCPU *cpu, struct cris_load_=
info *li)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 devboard SDK.=C2=A0 */<br>
&gt; =C2=A0 =C2=A0 =C2=A0image_size =3D load_elf(li-&gt;image_filename, NUL=
L,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0translate_kernel_address, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &amp;entry, NULL, &amp;high, 0, EM_CRIS, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &amp;entry, NULL, &amp;high, NULL, 0, EM_CRIS, 0, 0);=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0li-&gt;entry =3D entry;<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (image_size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Takes a kimage from the axis devb=
oard SDK.=C2=A0 */<br>
&gt; diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c<br>
&gt; index 2d62a24..d8755ec 100644<br>
&gt; --- a/hw/hppa/machine.c<br>
&gt; +++ b/hw/hppa/machine.c<br>
&gt; @@ -155,7 +155,7 @@ static void machine_hppa_init(MachineState *machin=
e)<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0size =3D load_elf(firmware_filename, NULL, NULL, N=
ULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &amp;firmware_entry, &amp;firmware_low, &amp;firmware_high,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &amp;firmware_entry, &amp;firmware_low, &amp;firmware_high, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0true, EM_PARISC, 0, 0);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0/* Unfortunately, load_elf sign-extends reading el=
f32.=C2=A0 */<br>
&gt; @@ -184,7 +184,7 @@ static void machine_hppa_init(MachineState *machin=
e)<br>
&gt; =C2=A0 =C2=A0 =C2=A0/* Load kernel */<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (kernel_filename) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D load_elf(kernel_filename, N=
ULL, &amp;cpu_hppa_to_phys,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 NULL, &amp;kernel_entry, &amp;kernel_low, &amp;kernel_high,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 NULL, &amp;kernel_entry, &amp;kernel_low, &amp;kernel_high, =
NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0true, EM_PARISC, 0, 0);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Unfortunately, load_elf sign-exte=
nds reading elf32.=C2=A0 */<br>
&gt; diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c<br>
&gt; index 9a59f95..9e7d69d 100644<br>
&gt; --- a/hw/i386/multiboot.c<br>
&gt; +++ b/hw/i386/multiboot.c<br>
&gt; @@ -199,7 +199,7 @@ int load_multiboot(FWCfgState *fw_cfg,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_file=
name, NULL, NULL, NULL, &amp;elf_entry,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_low, &amp;elf_high, 0, I=
386_ELF_MACHINE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_low, &amp;elf_high, NULL=
, 0, I386_ELF_MACHINE,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;Err=
or while loading elf kernel&quot;);<br>
&gt; diff --git a/hw/i386/x86.c b/hw/i386/x86.c<br>
&gt; index 9b9a4d5..7f38e6b 100644<br>
&gt; --- a/hw/i386/x86.c<br>
&gt; +++ b/hw/i386/x86.c<br>
&gt; @@ -413,7 +413,7 @@ static bool load_elfboot(const char *kernel_filena=
me,<br>
&gt; =C2=A0 =C2=A0 =C2=A0uint64_t elf_note_type =3D XEN_ELFNOTE_PHYS32_ENTR=
Y;<br>
&gt; =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename, read_pvh=
_start_addr,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, &amp;elf_note_type, &amp;elf_entry,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_low, &amp;elf_high, 0, I386_ELF_MACHIN=
E,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_low, &amp;elf_high, NULL, 0, I386_ELF_=
MACHINE,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
&gt; diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c<br>
&gt; index 5ae308b..d1894ad 100644<br>
&gt; --- a/hw/lm32/lm32_boards.c<br>
&gt; +++ b/hw/lm32/lm32_boards.c<br>
&gt; @@ -138,7 +138,7 @@ static void lm32_evr_init(MachineState *machine)<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int kernel_size;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_file=
name, NULL, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1, EM_LATTICEMICO32, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reset_info-&gt;bootstrap_pc =3D entr=
y;<br>
&gt;<br>
&gt; @@ -232,7 +232,7 @@ static void lm32_uclinux_init(MachineState *machin=
e)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int kernel_size;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_file=
name, NULL, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1, EM_LATTICEMICO32, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reset_info-&gt;bootstrap_pc =3D entr=
y;<br>
&gt;<br>
&gt; diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c<br>
&gt; index 460d322..6d46134 100644<br>
&gt; --- a/hw/lm32/milkymist.c<br>
&gt; +++ b/hw/lm32/milkymist.c<br>
&gt; @@ -177,7 +177,7 @@ milkymist_init(MachineState *machine)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Boots a kernel elf binary.=C2=A0 =
*/<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_file=
name, NULL, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1, EM_LATTICEMICO32, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reset_info-&gt;bootstrap_pc =3D entr=
y;<br>
&gt;<br>
&gt; diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c<br>
&gt; index 54ccbe1..bed43a9 100644<br>
&gt; --- a/hw/m68k/an5206.c<br>
&gt; +++ b/hw/m68k/an5206.c<br>
&gt; @@ -65,7 +65,7 @@ static void an5206_init(MachineState *machine)<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename, NULL, NU=
LL, NULL, &amp;elf_entry,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, 1, EM_68K, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, 1, EM_68K, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0entry =3D elf_entry;<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_uimage(kernel_f=
ilename, &amp;entry, NULL, NULL,<br>
&gt; diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c<br>
&gt; index 158c5e4..a999c21 100644<br>
&gt; --- a/hw/m68k/mcf5208.c<br>
&gt; +++ b/hw/m68k/mcf5208.c<br>
&gt; @@ -329,7 +329,7 @@ static void mcf5208evb_init(MachineState *machine)=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename, NULL, NU=
LL, NULL, &amp;elf_entry,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, 1, EM_68K, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, 1, EM_68K, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0entry =3D elf_entry;<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_uimage(kernel_f=
ilename, &amp;entry, NULL, NULL,<br>
&gt; diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c<br>
&gt; index 12491ec..1e32363 100644<br>
&gt; --- a/hw/m68k/q800.c<br>
&gt; +++ b/hw/m68k/q800.c<br>
&gt; @@ -342,7 +342,7 @@ static void q800_init(MachineState *machine)<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (linux_boot) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t high;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_file=
name, NULL, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_entry, NULL, &amp;high, =
1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_entry, NULL, &amp;high, =
NULL, 1,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EM_68K, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;cou=
ld not load kernel &#39;%s&#39;&quot;, kernel_filename);<br>
&gt; diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c<br>
&gt; index d1d7dfb..925e3f7 100644<br>
&gt; --- a/hw/microblaze/boot.c<br>
&gt; +++ b/hw/microblaze/boot.c<br>
&gt; @@ -145,13 +145,13 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, =
hwaddr ddr_base,<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Boots a kernel elf binary.=C2=A0 =
*/<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_file=
name, NULL, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;low, &amp;high,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;low, &amp;high, =
NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 big_endian, EM_MICROBLAZE, 0, 0);=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0base32 =3D entry;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (base32 =3D=3D 0xc0000000) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_e=
lf(kernel_filename, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 translate_kernel_ad=
dress, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, N=
ULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, N=
ULL, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 big_endian, EM_MICR=
OBLAZE, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Always boot into physical ram.=C2=
=A0 */<br>
&gt; diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c<br>
&gt; index 9eaa6e2..2e043cb 100644<br>
&gt; --- a/hw/mips/mips_fulong2e.c<br>
&gt; +++ b/hw/mips/mips_fulong2e.c<br>
&gt; @@ -119,7 +119,7 @@ static int64_t load_kernel(CPUMIPSState *env)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mips_kseg0_to_phys, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t *)&amp;kernel_entry,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t *)&amp;kernel_low, (uint64_t *)&amp;k=
ernel_high,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00, EM_MIPS, 1, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, 0, EM_MIPS, 1, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;could not load ke=
rnel &#39;%s&#39;: %s&quot;,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 loaderparams.kernel_filename,<br>
&gt; diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c<br>
&gt; index 5aaeaa8..34b76bb 100644<br>
&gt; --- a/hw/mips/mips_malta.c<br>
&gt; +++ b/hw/mips/mips_malta.c<br>
&gt; @@ -1039,7 +1039,8 @@ static int64_t load_kernel(void)<br>
&gt; =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(loaderparams.kernel_filen=
ame, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mips_kseg0_to_phys, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t *)&amp;kernel_entry, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t *)&amp;kernel_high, big_endian, EM_MI=
PS, 1, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t *)&amp;kernel_high, NULL, big_endian,=
 EM_MIPS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A01, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;could not load ke=
rnel &#39;%s&#39;: %s&quot;,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 loaderparams.kernel_filename,<br>
&gt; diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c<br>
&gt; index 84c03dd..b934ca9 100644<br>
&gt; --- a/hw/mips/mips_mipssim.c<br>
&gt; +++ b/hw/mips/mips_mipssim.c<br>
&gt; @@ -74,7 +74,7 @@ static int64_t load_kernel(void)<br>
&gt; =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(loaderparams.kernel_filen=
ame, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mips_kseg0_to_phys, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t *)&amp;entry, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t *)&amp;kernel_high, big_endian,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t *)&amp;kernel_high, NULL, big_endian,=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 EM_MIPS, 1, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (kernel_size &gt;=3D 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((entry &amp; ~0x7fffffffULL) =3D=
=3D 0x80000000) {<br>
&gt; diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c<br>
&gt; index fd926a3..b2aec43 100644<br>
&gt; --- a/hw/mips/mips_r4k.c<br>
&gt; +++ b/hw/mips/mips_r4k.c<br>
&gt; @@ -98,7 +98,7 @@ static int64_t load_kernel(void)<br>
&gt; =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(loaderparams.kernel_filen=
ame, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mips_kseg0_to_phys, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t *)&amp;entry, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t *)&amp;kernel_high, big_endian,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t *)&amp;kernel_high, NULL, big_endian,=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 EM_MIPS, 1, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (kernel_size &gt;=3D 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((entry &amp; ~0x7fffffffULL) =3D=
=3D 0x80000000) {<br>
&gt; diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c<br>
&gt; index 57af1b4..1d06e39 100644<br>
&gt; --- a/hw/moxie/moxiesim.c<br>
&gt; +++ b/hw/moxie/moxiesim.c<br>
&gt; @@ -58,7 +58,7 @@ static void load_kernel(MoxieCPU *cpu, LoaderParams =
*loader_params)<br>
&gt; =C2=A0 =C2=A0 =C2=A0ram_addr_t initrd_offset;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(loader_params-&gt;kernel_=
filename,=C2=A0 NULL, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;kernel_low, &amp;kernel_high, =
1, EM_MOXIE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;kernel_low, &amp;kernel_high, =
NULL, 1, EM_MOXIE,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt;=3D 0) {<br>
&gt; diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c<br>
&gt; index d78bc9e..46b8349 100644<br>
&gt; --- a/hw/nios2/boot.c<br>
&gt; +++ b/hw/nios2/boot.c<br>
&gt; @@ -147,7 +147,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_b=
ase,<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Boots a kernel elf binary. */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_file=
name, NULL, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;low, &amp;high,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;low, &amp;high, =
NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 big_endian, EM_ALTERA_NIOS2, 0, 0=
);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((uint32_t)entry =3D=3D 0xc000000=
0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; @@ -158,7 +158,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_b=
ase,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_e=
lf(kernel_filename, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 translate_kernel_ad=
dress, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, N=
ULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, N=
ULL, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 big_endian, EM_ALTE=
RA_NIOS2, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0boot_info.bootstrap_pc=
 =3D ddr_base + 0xc0000000 +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(entry &=
amp; 0x07ffffff);<br>
&gt; diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c<b=
r>
&gt; index 79e7049..ad53712 100644<br>
&gt; --- a/hw/openrisc/openrisc_sim.c<br>
&gt; +++ b/hw/openrisc/openrisc_sim.c<br>
&gt; @@ -98,7 +98,7 @@ static void openrisc_load_kernel(ram_addr_t ram_size=
,<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (kernel_filename &amp;&amp; !qtest_enabled()) {=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_file=
name, NULL, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_entry, NULL, NULL, 1, EM=
_OPENRISC,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_entry, NULL, NULL, NULL,=
 1, EM_OPENRISC,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry =3D elf_entry;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
&gt; diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c<br>
&gt; index f2f8821..1aff72b 100644<br>
&gt; --- a/hw/pci-host/prep.c<br>
&gt; +++ b/hw/pci-host/prep.c<br>
&gt; @@ -335,7 +335,8 @@ static void raven_realize(PCIDevice *d, Error **er=
rp)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (filename) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;elf_machine =
!=3D EM_NONE) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios_siz=
e =3D load_elf(filename, NULL, NULL, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, =
1, s-&gt;elf_machine, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, =
NULL, 1, s-&gt;elf_machine,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bios_size &lt; 0) =
{<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios_siz=
e =3D get_image_size(filename);<br>
&gt; diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c<br>
&gt; index 12b6a5b..886442e 100644<br>
&gt; --- a/hw/ppc/e500.c<br>
&gt; +++ b/hw/ppc/e500.c<br>
&gt; @@ -1049,7 +1049,7 @@ void ppce500_init(MachineState *machine)<br>
&gt; =C2=A0 =C2=A0 =C2=A0filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, p=
ayload_name);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0payload_size =3D load_elf(filename, NULL, NULL, NU=
LL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;bios_entry, &amp;loadaddr, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;bios_entry, &amp;loadaddr, NULL, NULL,<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01, PPC_ELF_MACHINE, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (payload_size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c<br>
&gt; index 3594517..464d012 100644<br>
&gt; --- a/hw/ppc/mac_newworld.c<br>
&gt; +++ b/hw/ppc/mac_newworld.c<br>
&gt; @@ -168,7 +168,7 @@ static void ppc_core99_init(MachineState *machine)=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0/* Load OpenBIOS (ELF) */<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (filename) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios_size =3D load_elf(filename, NUL=
L, NULL, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, 1, PPC_ELF_MACHINE, 0,=
 0);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(filename);<br>
&gt; =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; @@ -192,7 +192,7 @@ static void ppc_core99_init(MachineState *machine)=
<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_file=
name, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 translate_kernel_address, NULL,<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, &amp;lowaddr, NULL, 1, PPC_=
ELF_MACHINE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, &amp;lowaddr, NULL, NULL, 1=
, PPC_ELF_MACHINE,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_a=
out(kernel_filename, kernel_base,<br>
&gt; diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c<br>
&gt; index 0fa680b..7318d7e 100644<br>
&gt; --- a/hw/ppc/mac_oldworld.c<br>
&gt; +++ b/hw/ppc/mac_oldworld.c<br>
&gt; @@ -143,7 +143,7 @@ static void ppc_heathrow_init(MachineState *machin=
e)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0/* Load OpenBIOS (ELF) */<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (filename) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 bios_size =3D load_elf(filename, NULL, 0,=
 NULL, NULL, NULL, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bios_size =3D load_elf(filename, NULL, 0,=
 NULL, NULL, NULL, NULL, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1, PPC_ELF_MACHINE, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(filename);<br>
&gt; =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; @@ -166,7 +166,7 @@ static void ppc_heathrow_init(MachineState *machin=
e)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_base =3D KERNEL_LOAD_ADDR;<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_file=
name, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 translate_kernel_address, NULL,<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, &amp;lowaddr, NULL, 1, PPC_=
ELF_MACHINE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, &amp;lowaddr, NULL, NULL, 1=
, PPC_ELF_MACHINE,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_a=
out(kernel_filename, kernel_base,<br>
&gt; diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c<br>
&gt; index b782641..da777ef 100644<br>
&gt; --- a/hw/ppc/ppc440_bamboo.c<br>
&gt; +++ b/hw/ppc/ppc440_bamboo.c<br>
&gt; @@ -253,7 +253,7 @@ static void bamboo_init(MachineState *machine)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (success &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0success =3D load_elf(k=
ernel_filename, NULL, NULL, NULL, &amp;elf_entry,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_lowaddr, NULL, 1, PPC_EL=
F_MACHINE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_lowaddr, NULL, NULL, 1, =
PPC_ELF_MACHINE,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry =3D elf_entry;<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loadaddr =3D elf_lowad=
dr;<br>
&gt; diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c<br>
&gt; index 437e214..89bc70e 100644<br>
&gt; --- a/hw/ppc/sam460ex.c<br>
&gt; +++ b/hw/ppc/sam460ex.c<br>
&gt; @@ -439,7 +439,8 @@ static void sam460ex_init(MachineState *machine)<b=
r>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0success =3D load_elf(m=
achine-&gt;kernel_filename, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, &amp;elf_entry,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_lowaddr, NULL, 1, PPC_EL=
F_MACHINE, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_lowaddr, NULL, NULL, 1, =
PPC_ELF_MACHINE, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry =3D elf_entry;<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loadaddr =3D elf_lowad=
dr;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c<br>
&gt; index 02cf53f..a0076e5 100644<br>
&gt; --- a/hw/ppc/spapr.c<br>
&gt; +++ b/hw/ppc/spapr.c<br>
&gt; @@ -2895,13 +2895,13 @@ static void spapr_machine_init(MachineState *m=
achine)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spapr-&gt;kernel_size =3D load_elf(k=
ernel_filename, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0transl=
ate_kernel_address, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, &amp;=
lowaddr, NULL, 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, &amp;=
lowaddr, NULL, NULL, 1,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PPC_EL=
F_MACHINE, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spapr-&gt;kernel_size =3D=3D ELF=
_LOAD_WRONG_ENDIAN) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spapr-&gt;kernel_size =
=3D load_elf(kernel_filename, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0translate_kernel_address, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;lowaddr, NULL, 0, PPC_ELF_MACHINE,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;lowaddr, NULL, NULL, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 PPC_ELF_MACHINE, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spapr-&gt;kernel_le =
=3D spapr-&gt;kernel_size &gt; 0;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spapr-&gt;kernel_size &lt; 0) {<=
br>
&gt; diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c<br>
&gt; index 6862552..7526947 100644<br>
&gt; --- a/hw/ppc/virtex_ml507.c<br>
&gt; +++ b/hw/ppc/virtex_ml507.c<br>
&gt; @@ -259,7 +259,7 @@ static void virtex_init(MachineState *machine)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Boots a kernel elf binary.=C2=A0 =
*/<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_file=
name, NULL, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;low, &amp;high, =
1, PPC_ELF_MACHINE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;low, &amp;high, =
NULL, 1, PPC_ELF_MACHINE,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0boot_info.bootstrap_pc =3D entry &am=
p; 0x00ffffff;<br>
&gt;<br>
&gt; diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c<br>
&gt; index 027303d..b8e7652 100644<br>
&gt; --- a/hw/riscv/boot.c<br>
&gt; +++ b/hw/riscv/boot.c<br>
&gt; @@ -101,7 +101,7 @@ target_ulong riscv_load_firmware(const char *firmw=
are_filename,<br>
&gt; =C2=A0 =C2=A0 =C2=A0uint64_t firmware_entry, firmware_start, firmware_=
end;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (load_elf(firmware_filename, NULL, NULL, NULL, =
&amp;firmware_entry,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;fi=
rmware_start, &amp;firmware_end, 0, EM_RISCV, 1, 0) &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;fi=
rmware_start, &amp;firmware_end, NULL, 0, EM_RISCV, 1, 0) &gt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return firmware_entry;<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; @@ -119,7 +119,7 @@ target_ulong riscv_load_kernel(const char *kernel_=
filename, symbol_fn_t sym_cb)<br>
&gt; =C2=A0 =C2=A0 =C2=A0uint64_t kernel_entry, kernel_high;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (load_elf_ram_sym(kernel_filename, NULL, NULL, =
NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&amp;kernel_entry, NULL, &amp;kernel_high, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&amp;kernel_entry, NULL, &amp;kernel_high, NULL, 0,<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 EM_RISCV, 1, 0, NULL, true, sym_cb) &gt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return kernel_entry;<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt; diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c<br>
&gt; index b3ae901..ca8e7db 100644<br>
&gt; --- a/hw/s390x/ipl.c<br>
&gt; +++ b/hw/s390x/ipl.c<br>
&gt; @@ -139,7 +139,7 @@ static void s390_ipl_realize(DeviceState *dev, Err=
or **errp)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios_size =3D load_elf(bios_filename=
, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bios_translate_addr, &amp;fwbase,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;ipl-&gt;bios_start_addr, NULL, NULL=
, 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;ipl-&gt;bios_start_addr, NULL, NULL=
, NULL, 1,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EM_S390, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bios_size &gt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Adjust ELF start ad=
dress to final location */<br>
&gt; @@ -164,7 +164,7 @@ static void s390_ipl_realize(DeviceState *dev, Err=
or **errp)<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (ipl-&gt;kernel) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(ipl-&gt;ker=
nel, NULL, NULL, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;pentry, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, 1, EM_S390, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, 1, EM_S390, 0, 0);<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_i=
mage_targphys(ipl-&gt;kernel, 0, ram_size);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0=
) {<br>
&gt; @@ -473,7 +473,8 @@ static int load_netboot_image(Error **errp)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0img_size =3D load_elf_ram(netboot_filename, NULL, =
NULL, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;ipl-&gt;start_addr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, 1, EM_S390, 0, 0, NULL, false);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, NULL, 1, EM_S390, 0, 0, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 false);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (img_size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0img_size =3D load_image_size(netboot=
_filename, ram_ptr, ram_size);<br>
&gt; diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c<br>
&gt; index 8038887..f5a087d 100644<br>
&gt; --- a/hw/sparc/leon3.c<br>
&gt; +++ b/hw/sparc/leon3.c<br>
&gt; @@ -297,7 +297,7 @@ static void leon3_generic_hw_init(MachineState *ma=
chine)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t entry;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_file=
name, NULL, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 /* big endian */, EM_SPARC, 0, =
0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_u=
image(kernel_filename, NULL, &amp;entry,<br>
&gt; diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c<br>
&gt; index df33b32..25e96db 100644<br>
&gt; --- a/hw/sparc/sun4m.c<br>
&gt; +++ b/hw/sparc/sun4m.c<br>
&gt; @@ -270,7 +270,7 @@ static unsigned long sun4m_load_kernel(const char =
*kernel_filename,<br>
&gt; =C2=A0#endif<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_file=
name, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 translate_kernel_address, NULL,<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, 1, EM_SPARC, 0,=
 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, NULL, 1, EM_SPA=
RC, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_a=
out(kernel_filename, KERNEL_LOAD_ADDR,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RAM_size - KE=
RNEL_LOAD_ADDR, bswap_needed,<br>
&gt; @@ -721,7 +721,7 @@ static void prom_init(hwaddr addr, const char *bio=
s_name)<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (filename) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D load_elf(filename, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 translate_prom_address, &amp;addr, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0NULL, NULL, 1, EM_SPARC, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0NULL, NULL, NULL, 1, EM_SPARC, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0 || ret &gt; PROM_SIZE=
_MAX) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D load_image_tar=
gphys(filename, addr, PROM_SIZE_MAX);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c<br>
&gt; index 5d710d6..b7ac42f 100644<br>
&gt; --- a/hw/sparc64/sun4u.c<br>
&gt; +++ b/hw/sparc64/sun4u.c<br>
&gt; @@ -175,7 +175,8 @@ static uint64_t sun4u_load_kernel(const char *kern=
el_filename,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bswap_needed =3D 0;<br>
&gt; =C2=A0#endif<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_file=
name, NULL, NULL, NULL, kernel_entry,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_addr, &amp;kernel_top, 1, =
EM_SPARCV9, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_addr, &amp;kernel_top, NUL=
L, 1, EM_SPARCV9, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*kernel_addr =3D KERNE=
L_LOAD_ADDR;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*kernel_entry =3D KERN=
EL_LOAD_ADDR;<br>
&gt; @@ -439,7 +440,7 @@ static void prom_init(hwaddr addr, const char *bio=
s_name)<br>
&gt; =C2=A0 =C2=A0 =C2=A0filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, b=
ios_name);<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (filename) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D load_elf(filename, NULL, tra=
nslate_prom_address, &amp;addr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0NULL, NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0 || ret &gt; PROM_SIZE=
_MAX) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D load_image_tar=
gphys(filename, addr, PROM_SIZE_MAX);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testb=
oard.c<br>
&gt; index aef3289..20c9ccb 100644<br>
&gt; --- a/hw/tricore/tricore_testboard.c<br>
&gt; +++ b/hw/tricore/tricore_testboard.c<br>
&gt; @@ -42,7 +42,7 @@ static void tricore_load_kernel(CPUTriCoreState *env=
)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(tricoretb_binfo.kernel_fi=
lename, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, &amp;entry, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, 0,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 EM_TRICORE, 1, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt;=3D 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;no kernel file &#=
39;%s&#39;&quot;,<br>
&gt; diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c<br>
&gt; index a22743a..aeb46d8 100644<br>
&gt; --- a/hw/xtensa/sim.c<br>
&gt; +++ b/hw/xtensa/sim.c<br>
&gt; @@ -108,7 +108,7 @@ void xtensa_sim_load_kernel(XtensaCPU *cpu, Machin=
eState *machine)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t elf_entry;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t elf_lowaddr;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int success =3D load_elf(kernel_file=
name, NULL, translate_phys_addr, cpu,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_entry, &amp;elf_lowaddr,=
 NULL, big_endian,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_entry, &amp;elf_lowaddr,=
 NULL, NULL, big_endian,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EM_XTENSA, 0, 0);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (success &gt; 0) {<br>
&gt; diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c<br>
&gt; index 8220c7a..8e2dd13 100644<br>
&gt; --- a/hw/xtensa/xtfpga.c<br>
&gt; +++ b/hw/xtensa/xtfpga.c<br>
&gt; @@ -415,7 +415,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *boa=
rd, MachineState *machine)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t elf_entry;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t elf_lowaddr;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int success =3D load_elf(kernel_file=
name, NULL, translate_phys_addr, cpu,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;elf_entr=
y, &amp;elf_lowaddr, NULL, be, EM_XTENSA, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;elf_entr=
y, &amp;elf_lowaddr, NULL, NULL, be, EM_XTENSA, 0, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (success &gt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry_point =3D elf_en=
try;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h<br>
&gt; index e07d276..a1411bf 100644<br>
&gt; --- a/include/hw/elf_ops.h<br>
&gt; +++ b/include/hw/elf_ops.h<br>
&gt; @@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, in=
t fd,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *translate_opaque,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int must_swab, uint64_t *pentry,<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *lowaddr, uint64_t *higha=
ddr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int elf_machine, int clear_lsb, int dat=
a_swab,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *pflags, int elf_machine,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int clear_lsb, int data_swab,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AddressSpace *as, bool load_rom,<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0symbol_fn_t sym_cb)<br>
&gt; =C2=A0{<br>
&gt; @@ -389,6 +390,9 @@ static int glue(load_elf, SZ)(const char *name, in=
t fd,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 if (pflags) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *pflags =3D (elf_word)ehdr.e_flags;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (pentry)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*pentry =3D (uint64_t)(elf_sword)ehd=
r.e_entry;<br>
&gt;<br>
&gt; diff --git a/include/hw/loader.h b/include/hw/loader.h<br>
&gt; index 48a96cd..a9eeea3 100644<br>
&gt; --- a/include/hw/loader.h<br>
&gt; +++ b/include/hw/loader.h<br>
&gt; @@ -101,6 +101,7 @@ const char *load_elf_strerror(int error);<br>
&gt; =C2=A0 * @pentry: Populated with program entry point. Ignored if NULL.=
<br>
&gt; =C2=A0 * @lowaddr: Populated with lowest loaded address. Ignored if NU=
LL.<br>
&gt; =C2=A0 * @highaddr: Populated with highest loaded address. Ignored if =
NULL.<br>
&gt; + * @pflags: Populated with ELF processor-specific flags. Ignore if NU=
LL.<br>
&gt; =C2=A0 * @bigendian: Expected ELF endianness. 0 for LE otherwise BE<br=
>
&gt; =C2=A0 * @elf_machine: Expected ELF machine type<br>
&gt; =C2=A0 * @clear_lsb: Set to mask off LSB of addresses (Some architectu=
res use<br>
&gt; @@ -131,8 +132,9 @@ int load_elf_ram_sym(const char *filename,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint64_t (*elf_note_fn)(void *, void *, bool),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint64_t (*translate_fn)(void *, uint64_t),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 void *translate_opaque, uint64_t *pentry,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0uint64_t *lowaddr, uint64_t *highaddr, int big_endian,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int elf_machine, int clear_lsb, int data_swab,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0uint64_t *lowaddr, uint64_t *highaddr, uint32_t *pflags,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int big_endian, int elf_machine,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int clear_lsb, int data_swab,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 AddressSpace *as, bool load_rom, symbol_fn_t sym_cb);<br>
&gt;<br>
&gt; =C2=A0/** load_elf_ram:<br>
&gt; @@ -143,9 +145,9 @@ int load_elf_ram(const char *filename,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_=
t (*elf_note_fn)(void *, void *, bool),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_=
t (*translate_fn)(void *, uint64_t),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *t=
ranslate_opaque, uint64_t *pentry, uint64_t *lowaddr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_=
t *highaddr, int big_endian, int elf_machine,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int cle=
ar_lsb, int data_swab, AddressSpace *as,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool lo=
ad_rom);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_=
t *highaddr, uint32_t *pflags, int big_endian,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int elf=
_machine, int clear_lsb, int data_swab,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Address=
Space *as, bool load_rom);<br>
&gt;<br>
&gt; =C2=A0/** load_elf_as:<br>
&gt; =C2=A0 * Same as load_elf_ram(), but always loads the elf as ROM<br>
&gt; @@ -154,8 +156,9 @@ int load_elf_as(const char *filename,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=
 (*elf_note_fn)(void *, void *, bool),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=
 (*translate_fn)(void *, uint64_t),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *tr=
anslate_opaque, uint64_t *pentry, uint64_t *lowaddr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *hig=
haddr, int big_endian, int elf_machine,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int clear_lsb=
, int data_swab, AddressSpace *as);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *hig=
haddr, uint32_t *pflags, int big_endian,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int elf_machi=
ne, int clear_lsb, int data_swab,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AddressSpace =
*as);<br>
&gt;<br>
&gt; =C2=A0/** load_elf:<br>
&gt; =C2=A0 * Same as load_elf_as(), but doesn&#39;t allow the caller to sp=
ecify an<br>
&gt; @@ -165,8 +168,8 @@ int load_elf(const char *filename,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t (*elf_note_f=
n)(void *, void *, bool),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t (*translate_=
fn)(void *, uint64_t),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *translate_opaqu=
e, uint64_t *pentry, uint64_t *lowaddr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *highaddr, i=
nt big_endian, int elf_machine,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int clear_lsb, int da=
ta_swab);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *highaddr, u=
int32_t *pflags, int big_endian,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int elf_machine, int =
clear_lsb, int data_swab);<br>
&gt;<br>
&gt; =C2=A0/** load_elf_hdr:<br>
&gt; =C2=A0 * @filename: Path of ELF file<br>
&gt; -- <br>
&gt; 2.7.4<br>
&gt;<br>
&gt;<br>
</p>

--000000000000261a16059d3b4631--

