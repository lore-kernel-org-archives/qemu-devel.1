Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB699C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 03:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9691C20720
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 03:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HJ5GfYLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9691C20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsIHE-0001Hg-TZ
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 23:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jsIGb-0000bh-Ks; Sun, 05 Jul 2020 23:58:05 -0400
Received: from ozlabs.org ([203.11.71.1]:40957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jsIGW-000740-N6; Sun, 05 Jul 2020 23:58:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B0WxY66jYz9sR4; Mon,  6 Jul 2020 13:57:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594007873;
 bh=nH2SE1S3nl4zdOqtAr2sPNbYLEsco9PORaTSnhs+pUM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HJ5GfYLDcFQygG4lUZXZJZ24Drso5aBCVG8XhBpO1+VatPQ/v4Me2s03n0BkFpfcj
 mHgIkpCTHbwP7Y/hE8WyNbW3LULyW1Dr68X9PsVhbJW/50zS0cD+5kTuwDsMclfCQ8
 nHEjRnuihktgIbwK4W4oO1dSWkAtQeEDeC9mAhxk=
Date: Mon, 6 Jul 2020 13:54:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] load_elf: Remove unused address variables from callers
Message-ID: <20200706035446.GF12576@umbus.fritz.box>
References: <20200705174020.BDD0174633F@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline
In-Reply-To: <20200705174020.BDD0174633F@zero.eik.bme.hu>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 23:57:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Huacai Chen <chenhc@lemote.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, philmd@redhat.com,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 05, 2020 at 07:22:11PM +0200, BALATON Zoltan wrote:
> Several callers of load_elf() pass pointers for lowaddr and highaddr
> parameters which are then not used for anything. This may stem from a
> misunderstanding that load_elf need a value here but in fact it can
> take NULL to ignore these values. Remove such unused variables and
> pass NULL instead from callers that don't need these.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/alpha/dp264.c       |  8 ++++----
>  hw/arm/armv7m.c        |  4 +---
>  hw/cris/boot.c         |  4 ++--
>  hw/microblaze/boot.c   |  4 ++--
>  hw/mips/fuloong2e.c    |  8 ++++----
>  hw/moxie/moxiesim.c    |  4 ++--
>  hw/nios2/boot.c        |  4 ++--
>  hw/ppc/mac_newworld.c  |  6 ++----
>  hw/ppc/mac_oldworld.c  |  6 ++----
>  hw/ppc/ppc440_bamboo.c |  9 +++------
>  hw/ppc/sam460ex.c      | 12 +++++-------
>  hw/ppc/spapr.c         | 11 ++++-------
>  hw/ppc/virtex_ml507.c  |  4 ++--
>  hw/riscv/boot.c        |  8 ++++----
>  hw/xtensa/sim.c        |  3 +--
>  hw/xtensa/xtfpga.c     |  3 +--
>  16 files changed, 41 insertions(+), 57 deletions(-)
>=20
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index f7751b18f6..4d24518d1d 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -62,8 +62,8 @@ static void clipper_init(MachineState *machine)
>      qemu_irq rtc_irq;
>      long size, i;
>      char *palcode_filename;
> -    uint64_t palcode_entry, palcode_low, palcode_high;
> -    uint64_t kernel_entry, kernel_low, kernel_high;
> +    uint64_t palcode_entry;
> +    uint64_t kernel_entry, kernel_low;
>      unsigned int smp_cpus =3D machine->smp.cpus;
> =20
>      /* Create up to 4 cpus.  */
> @@ -113,7 +113,7 @@ static void clipper_init(MachineState *machine)
>          exit(1);
>      }
>      size =3D load_elf(palcode_filename, NULL, cpu_alpha_superpage_to_phy=
s,
> -                    NULL, &palcode_entry, &palcode_low, &palcode_high, N=
ULL,
> +                    NULL, &palcode_entry, NULL, NULL, NULL,
>                      0, EM_ALPHA, 0, 0);
>      if (size < 0) {
>          error_report("could not load palcode '%s'", palcode_filename);
> @@ -132,7 +132,7 @@ static void clipper_init(MachineState *machine)
>          uint64_t param_offset;
> =20
>          size =3D load_elf(kernel_filename, NULL, cpu_alpha_superpage_to_=
phys,
> -                        NULL, &kernel_entry, &kernel_low, &kernel_high, =
NULL,
> +                        NULL, &kernel_entry, &kernel_low, NULL, NULL,
>                          0, EM_ALPHA, 0, 0);
>          if (size < 0) {
>              error_report("could not load kernel '%s'", kernel_filename);
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 3308211e9c..92f859d760 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -309,7 +309,6 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kern=
el_filename, int mem_size)
>  {
>      int image_size;
>      uint64_t entry;
> -    uint64_t lowaddr;
>      int big_endian;
>      AddressSpace *as;
>      int asidx;
> @@ -330,12 +329,11 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *ke=
rnel_filename, int mem_size)
> =20
>      if (kernel_filename) {
>          image_size =3D load_elf_as(kernel_filename, NULL, NULL, NULL,
> -                                 &entry, &lowaddr, NULL,
> +                                 &entry, NULL, NULL,
>                                   NULL, big_endian, EM_ARM, 1, 0, as);
>          if (image_size < 0) {
>              image_size =3D load_image_targphys_as(kernel_filename, 0,
>                                                  mem_size, as);
> -            lowaddr =3D 0;
>          }
>          if (image_size < 0) {
>              error_report("Could not load kernel '%s'", kernel_filename);
> diff --git a/hw/cris/boot.c b/hw/cris/boot.c
> index b8947bc660..aa8d2756d6 100644
> --- a/hw/cris/boot.c
> +++ b/hw/cris/boot.c
> @@ -67,7 +67,7 @@ static uint64_t translate_kernel_address(void *opaque, =
uint64_t addr)
>  void cris_load_image(CRISCPU *cpu, struct cris_load_info *li)
>  {
>      CPUCRISState *env =3D &cpu->env;
> -    uint64_t entry, high;
> +    uint64_t entry;
>      int kcmdline_len;
>      int image_size;
> =20
> @@ -76,7 +76,7 @@ void cris_load_image(CRISCPU *cpu, struct cris_load_inf=
o *li)
>         devboard SDK.  */
>      image_size =3D load_elf(li->image_filename, NULL,
>                            translate_kernel_address, NULL,
> -                          &entry, NULL, &high, NULL, 0, EM_CRIS, 0, 0);
> +                          &entry, NULL, NULL, NULL, 0, EM_CRIS, 0, 0);
>      li->entry =3D entry;
>      if (image_size < 0) {
>          /* Takes a kimage from the axis devboard SDK.  */
> diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
> index 925e3f7c9d..8ad3c27f2c 100644
> --- a/hw/microblaze/boot.c
> +++ b/hw/microblaze/boot.c
> @@ -135,7 +135,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwadd=
r ddr_base,
> =20
>      if (kernel_filename) {
>          int kernel_size;
> -        uint64_t entry, low, high;
> +        uint64_t entry, high;
>          uint32_t base32;
>          int big_endian =3D 0;
> =20
> @@ -145,7 +145,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwadd=
r ddr_base,
> =20
>          /* Boots a kernel elf binary.  */
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> -                               &entry, &low, &high, NULL,
> +                               &entry, NULL, &high, NULL,
>                                 big_endian, EM_MICROBLAZE, 0, 0);
>          base32 =3D entry;
>          if (base32 =3D=3D 0xc0000000) {
> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> index 8ca31e5162..507e549fca 100644
> --- a/hw/mips/fuloong2e.c
> +++ b/hw/mips/fuloong2e.c
> @@ -107,7 +107,7 @@ static void GCC_FMT_ATTR(3, 4) prom_set(uint32_t *pro=
m_buf, int index,
> =20
>  static int64_t load_kernel(CPUMIPSState *env)
>  {
> -    int64_t kernel_entry, kernel_low, kernel_high, initrd_size;
> +    int64_t kernel_entry, kernel_high, initrd_size;
>      int index =3D 0;
>      long kernel_size;
>      ram_addr_t initrd_offset;
> @@ -116,9 +116,9 @@ static int64_t load_kernel(CPUMIPSState *env)
> =20
>      kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
>                             cpu_mips_kseg0_to_phys, NULL,
> -                           (uint64_t *)&kernel_entry,
> -                           (uint64_t *)&kernel_low, (uint64_t *)&kernel_=
high,
> -                           NULL, 0, EM_MIPS, 1, 0);
> +                           (uint64_t *)&kernel_entry, NULL,
> +                           (uint64_t *)&kernel_high, NULL,
> +                           0, EM_MIPS, 1, 0);
>      if (kernel_size < 0) {
>          error_report("could not load kernel '%s': %s",
>                       loaderparams.kernel_filename,
> diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
> index 51a98287b5..a765e9f6be 100644
> --- a/hw/moxie/moxiesim.c
> +++ b/hw/moxie/moxiesim.c
> @@ -52,13 +52,13 @@ typedef struct {
> =20
>  static void load_kernel(MoxieCPU *cpu, LoaderParams *loader_params)
>  {
> -    uint64_t entry, kernel_low, kernel_high;
> +    uint64_t entry, kernel_high;
>      int64_t initrd_size;
>      long kernel_size;
>      ram_addr_t initrd_offset;
> =20
>      kernel_size =3D load_elf(loader_params->kernel_filename,  NULL, NULL=
, NULL,
> -                           &entry, &kernel_low, &kernel_high, NULL, 1, E=
M_MOXIE,
> +                           &entry, NULL, &kernel_high, NULL, 1, EM_MOXIE,
>                             0, 0);
> =20
>      if (kernel_size <=3D 0) {
> diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
> index 88224aa84c..1df3b66c29 100644
> --- a/hw/nios2/boot.c
> +++ b/hw/nios2/boot.c
> @@ -139,7 +139,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
> =20
>      if (kernel_filename) {
>          int kernel_size, fdt_size;
> -        uint64_t entry, low, high;
> +        uint64_t entry, high;
>          int big_endian =3D 0;
> =20
>  #ifdef TARGET_WORDS_BIGENDIAN
> @@ -148,7 +148,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
> =20
>          /* Boots a kernel elf binary. */
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> -                               &entry, &low, &high, NULL,
> +                               &entry, NULL, &high, NULL,
>                                 big_endian, EM_ALTERA_NIOS2, 0, 0);
>          if ((uint32_t)entry =3D=3D 0xc0000000) {
>              /*
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 828c5992ae..a3f25ab479 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -177,7 +177,6 @@ static void ppc_core99_init(MachineState *machine)
>      }
> =20
>      if (linux_boot) {
> -        uint64_t lowaddr =3D 0;
>          int bswap_needed;
> =20
>  #ifdef BSWAP_NEEDED
> @@ -188,9 +187,8 @@ static void ppc_core99_init(MachineState *machine)
>          kernel_base =3D KERNEL_LOAD_ADDR;
> =20
>          kernel_size =3D load_elf(kernel_filename, NULL,
> -                               translate_kernel_address, NULL,
> -                               NULL, &lowaddr, NULL, NULL, 1, PPC_ELF_MA=
CHINE,
> -                               0, 0);
> +                               translate_kernel_address, NULL, NULL, NUL=
L,
> +                               NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
>          if (kernel_size < 0)
>              kernel_size =3D load_aout(kernel_filename, kernel_base,
>                                      ram_size - kernel_base, bswap_needed,
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index f8c204ead7..4bcce22a96 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -150,7 +150,6 @@ static void ppc_heathrow_init(MachineState *machine)
>      }
> =20
>      if (linux_boot) {
> -        uint64_t lowaddr =3D 0;
>          int bswap_needed;
> =20
>  #ifdef BSWAP_NEEDED
> @@ -160,9 +159,8 @@ static void ppc_heathrow_init(MachineState *machine)
>  #endif
>          kernel_base =3D KERNEL_LOAD_ADDR;
>          kernel_size =3D load_elf(kernel_filename, NULL,
> -                               translate_kernel_address, NULL,
> -                               NULL, &lowaddr, NULL, NULL, 1, PPC_ELF_MA=
CHINE,
> -                               0, 0);
> +                               translate_kernel_address, NULL, NULL, NUL=
L,
> +                               NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
>          if (kernel_size < 0)
>              kernel_size =3D load_aout(kernel_filename, kernel_base,
>                                      ram_size - kernel_base, bswap_needed,
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 4c5e9e4373..74028dc986 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -172,9 +172,6 @@ static void bamboo_init(MachineState *machine)
>      PCIBus *pcibus;
>      PowerPCCPU *cpu;
>      CPUPPCState *env;
> -    uint64_t elf_entry;
> -    uint64_t elf_lowaddr;
> -    hwaddr loadaddr =3D LOAD_UIMAGE_LOADADDR_INVALID;
>      target_long initrd_size =3D 0;
>      DeviceState *dev;
>      int success;
> @@ -246,14 +243,14 @@ static void bamboo_init(MachineState *machine)
> =20
>      /* Load kernel. */
>      if (kernel_filename) {
> +        hwaddr loadaddr =3D LOAD_UIMAGE_LOADADDR_INVALID;
>          success =3D load_uimage(kernel_filename, &entry, &loadaddr, NULL,
>                                NULL, NULL);
>          if (success < 0) {
> +            uint64_t elf_entry;
>              success =3D load_elf(kernel_filename, NULL, NULL, NULL, &elf=
_entry,
> -                               &elf_lowaddr, NULL, NULL, 1, PPC_ELF_MACH=
INE,
> -                               0, 0);
> +                               NULL, NULL, NULL, 1, PPC_ELF_MACHINE, 0, =
0);
>              entry =3D elf_entry;
> -            loadaddr =3D elf_lowaddr;
>          }
>          /* XXX try again as binary */
>          if (success < 0) {
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 1a106a68de..71f74e983c 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -286,7 +286,6 @@ static void sam460ex_init(MachineState *machine)
>      CPUPPCState *env;
>      I2CBus *i2c;
>      hwaddr entry =3D UBOOT_ENTRY;
> -    hwaddr loadaddr =3D LOAD_UIMAGE_LOADADDR_INVALID;
>      target_long initrd_size =3D 0;
>      DeviceState *dev;
>      SysBusDevice *sbdev;
> @@ -426,17 +425,16 @@ static void sam460ex_init(MachineState *machine)
> =20
>      /* Load kernel. */
>      if (machine->kernel_filename) {
> +        hwaddr loadaddr =3D LOAD_UIMAGE_LOADADDR_INVALID;
>          success =3D load_uimage(machine->kernel_filename, &entry, &loada=
ddr,
>                                NULL, NULL, NULL);
>          if (success < 0) {
> -            uint64_t elf_entry, elf_lowaddr;
> +            uint64_t elf_entry;
> =20
> -            success =3D load_elf(machine->kernel_filename, NULL,
> -                               NULL, NULL, &elf_entry,
> -                               &elf_lowaddr, NULL, NULL, 1, PPC_ELF_MACH=
INE, 0,
> -                               0);
> +            success =3D load_elf(machine->kernel_filename, NULL, NULL, N=
ULL,
> +                               &elf_entry, NULL, NULL, NULL,
> +                               1, PPC_ELF_MACHINE, 0, 0);
>              entry =3D elf_entry;
> -            loadaddr =3D elf_lowaddr;
>          }
>          /* XXX try again as binary */
>          if (success < 0) {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f6f034d039..f4e8e2e139 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2972,18 +2972,15 @@ static void spapr_machine_init(MachineState *mach=
ine)
>      }
> =20
>      if (kernel_filename) {
> -        uint64_t lowaddr =3D 0;
> -
>          spapr->kernel_size =3D load_elf(kernel_filename, NULL,
>                                        translate_kernel_address, spapr,
> -                                      NULL, &lowaddr, NULL, NULL, 1,
> +                                      NULL, NULL, NULL, NULL, 1,
>                                        PPC_ELF_MACHINE, 0, 0);
>          if (spapr->kernel_size =3D=3D ELF_LOAD_WRONG_ENDIAN) {
>              spapr->kernel_size =3D load_elf(kernel_filename, NULL,
> -                                          translate_kernel_address, spap=
r, NULL,
> -                                          &lowaddr, NULL, NULL, 0,
> -                                          PPC_ELF_MACHINE,
> -                                          0, 0);
> +                                          translate_kernel_address, spap=
r,
> +                                          NULL, NULL, NULL, NULL, 0,
> +                                          PPC_ELF_MACHINE, 0, 0);
>              spapr->kernel_le =3D spapr->kernel_size > 0;
>          }
>          if (spapr->kernel_size < 0) {
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 78c4901be1..c790c1113f 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -250,12 +250,12 @@ static void virtex_init(MachineState *machine)
>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
> =20
>      if (kernel_filename) {
> -        uint64_t entry, low, high;
> +        uint64_t entry, high;
>          hwaddr boot_offset;
> =20
>          /* Boots a kernel elf binary.  */
>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> -                               &entry, &low, &high, NULL, 1, PPC_ELF_MAC=
HINE,
> +                               &entry, NULL, &high, NULL, 1, PPC_ELF_MAC=
HINE,
>                                 0, 0);
>          boot_info.bootstrap_pc =3D entry & 0x00ffffff;
> =20
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index adb421b91b..ab8da252ee 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -85,10 +85,10 @@ target_ulong riscv_load_firmware(const char *firmware=
_filename,
>                                   hwaddr firmware_load_addr,
>                                   symbol_fn_t sym_cb)
>  {
> -    uint64_t firmware_entry, firmware_start, firmware_end;
> +    uint64_t firmware_entry;
> =20
>      if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
> -                         &firmware_entry, &firmware_start, &firmware_end=
, NULL,
> +                         &firmware_entry, NULL, NULL, NULL,
>                           0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
>          return firmware_entry;
>      }
> @@ -104,10 +104,10 @@ target_ulong riscv_load_firmware(const char *firmwa=
re_filename,
> =20
>  target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t =
sym_cb)
>  {
> -    uint64_t kernel_entry, kernel_high;
> +    uint64_t kernel_entry;
> =20
>      if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
> -                         &kernel_entry, NULL, &kernel_high, NULL, 0,
> +                         &kernel_entry, NULL, NULL, NULL, 0,
>                           EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
>          return kernel_entry;
>      }
> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
> index aeb46d86f5..cbac50db2d 100644
> --- a/hw/xtensa/sim.c
> +++ b/hw/xtensa/sim.c
> @@ -106,9 +106,8 @@ void xtensa_sim_load_kernel(XtensaCPU *cpu, MachineSt=
ate *machine)
> =20
>      if (kernel_filename) {
>          uint64_t elf_entry;
> -        uint64_t elf_lowaddr;
>          int success =3D load_elf(kernel_filename, NULL, translate_phys_a=
ddr, cpu,
> -                               &elf_entry, &elf_lowaddr, NULL, NULL, big=
_endian,
> +                               &elf_entry, NULL, NULL, NULL, big_endian,
>                                 EM_XTENSA, 0, 0);
> =20
>          if (success > 0) {
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index 10de15855a..b1470b88e6 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -413,9 +413,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board,=
 MachineState *machine)
>          env->regs[2] =3D tagptr;
> =20
>          uint64_t elf_entry;
> -        uint64_t elf_lowaddr;
>          int success =3D load_elf(kernel_filename, NULL, translate_phys_a=
ddr, cpu,
> -                &elf_entry, &elf_lowaddr, NULL, NULL, be, EM_XTENSA, 0, =
0);
> +                &elf_entry, NULL, NULL, NULL, be, EM_XTENSA, 0, 0);
>          if (success > 0) {
>              entry_point =3D elf_entry;
>          } else {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8CoIAACgkQbDjKyiDZ
s5JRdg/9GnpjGedqRyi1l2kW6lC5g66TxrSILHF9td/niQpvZv+b/SmKeIZzFG3t
cxrX8sZ8NP0gs8HQEy3AOQycsHM0xG/Lu1qdsGFp3gmk5F+9p/hpxNK6AxsON9kE
DLdTolJe7bc6BJaA1ww2D+psYs5r2jQDELTzlk3p6uuEcLIvKoIOCImE5s8/uxYM
8FOWIOpureHLz/vhn0YICqo3Hlnk4awFHZAZ4VWG/1NqJKS3MhLUMfrEQt5vuJHr
mRY+VM3h5IoRuguThVN3DdHbLfIkc6JUtAFhIZWaeEzF2hYNkdLJFMCB2uvaiM52
esxGlGBIAmYieQSLpkJT2/sOA6YBNAHBPYSMiuDc2CeBIGotPH9Evea75ta+2mna
w4xbc87Yelr1SHkWIODQzk4TP4s+OSjUj8C9H+2kq0uX1mixqtRH2Lhhfor+0CZY
64w+WcobSVv4z4UI7lWB8+ykRq/QOcDhb4gQ9qSw0HpNBDXJau3MgAft6Uzbv0MW
AAp2v+TarncXvoU3NiFw6xkswoXQmZdwE3WRXegHwxJhWQ555kfxBEOOYXyLDWSZ
txhMlDMESozgOsicdqbZH3mvDdCMMQTq1b6AoqWzPR1dGWjnt97uhs2ml+f24Skk
VvUxRFdJ5VPnchCcALwvmHWIC+SDwu+PBLZsTh/sAYzNeoW4tmw=
=JCR4
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--

