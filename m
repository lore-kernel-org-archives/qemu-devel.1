Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D142EC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 21:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5D820882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 21:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5D820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu19c-0002VV-On
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 16:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iu18M-0001gZ-2Q
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iu18G-0004xk-6s
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:32:24 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iu18G-0004wy-29
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:32:20 -0500
Received: by mail-yb1-f195.google.com with SMTP id p129so2071392ybc.13
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 13:32:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yIytvuxpKwksoK7qFa24q88G7j/gy20Ta7ht2daF0Y0=;
 b=KurKVPD1Gc1x3vUYArL89Cixyh+Zez07RWHOjXHKURIIRPiYPgHHZS/TkLaz9QmfLV
 6KJAyqZLi1pNFZE6e0odmYRezDotCsahJOOimVe6HmrSLUwuxue+MoLuKhe3SX2JgYls
 jNv0x7Lwj8NCOcuNIsXbaFAeuOnsaEVXTztlrJKzka7vpeAxe2DO1wUtUCic5MZZZkDK
 11CWWjixQytATo7WtMaEoWFLIGaZOL/9AtEaU6YD4Gly36Qg4RAgIZa4u4cwQiWUAqlM
 d4FqtHnRqPDM2dbgNJNg6bLuX/8e/eN2C+RDvF6RvGQwI4xDli+chyokXRcAsRFazDvf
 ENWA==
X-Gm-Message-State: APjAAAVb92aM7Dm5o15ZZA+vEmOSfLNna6jGdKrGLFnLiovHdI4LMBHS
 tmVMIea79S3JEl0eHOUuXOK9iV0+Y7Dm0X7ax+I=
X-Google-Smtp-Source: APXvYqyJKCPlUbq06DGbOyQ2ZbVQ5/wX+cn7OQYF8It1mp2rSJ6m6CbcqseLdPYlj1GVZdkloyub4E5M9djrRWJAcIU=
X-Received: by 2002:a25:9cc7:: with SMTP id z7mr5164396ybo.309.1579642339061; 
 Tue, 21 Jan 2020 13:32:19 -0800 (PST)
MIME-Version: 1.0
References: <20191218210329.1960-1-mrolnik@gmail.com>
 <20191218210329.1960-16-mrolnik@gmail.com>
In-Reply-To: <20191218210329.1960-16-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 21 Jan 2020 22:32:07 +0100
Message-ID: <CAAdtpL5C6g+W0tfp97RLtQZMrGf1ot8Hq7kh6f839N6+narrvw@mail.gmail.com>
Subject: Re: [PATCH v39 15/22] target/avr: Add example board configuration
To: Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.195
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
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 10:12 PM Michael Rolnik <mrolnik@gmail.com> wrote:
>
> A simple board setup that configures an AVR CPU to run a given firmware i=
mage.
> This is all that's useful to implement without peripheral emulation as AV=
R CPUs include a lot of on-board peripherals.
>
> NOTE: this is not a real board !!!!
> NOTE: it's used for CPU testing!!!!
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Nacked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/elf.h        |   2 +
>  include/hw/elf_ops.h |   6 +-
>  include/hw/loader.h  |   6 +-
>  hw/core/loader.c     |  15 +--
>  hw/riscv/boot.c      |   2 +-

Previous changes aren't AVR specific and should go in a separate patch.
(and require review from all the maintainers of the other
architectures affected by this change).

You can send send a single patch (not the whole series), else
I'll see if I can split it myself.

>  hw/avr/sample.c      | 293 +++++++++++++++++++++++++++++++++++++++++++
>  hw/Kconfig           |   1 +
>  hw/avr/Kconfig       |   6 +
>  hw/avr/Makefile.objs |   1 +
>  9 files changed, 321 insertions(+), 11 deletions(-)
>  create mode 100644 hw/avr/sample.c
>  create mode 100644 hw/avr/Kconfig
>  create mode 100644 hw/avr/Makefile.objs
>
> diff --git a/include/elf.h b/include/elf.h
> index 3501e0c8d0..53cdfa23b7 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -202,6 +202,8 @@ typedef struct mips_elf_abiflags_v0 {
>  #define EM_MOXIE           223     /* Moxie processor family */
>  #define EM_MOXIE_OLD       0xFEED
>
> +#define EM_AVR 83 /* AVR 8-bit microcontroller */
> +
>  /* This is the info that is needed to parse the dynamic section of the f=
ile */
>  #define DT_NULL                0
>  #define DT_NEEDED      1
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index e07d276df7..70de85fa72 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, int f=
d,
>                                void *translate_opaque,
>                                int must_swab, uint64_t *pentry,
>                                uint64_t *lowaddr, uint64_t *highaddr,
> -                              int elf_machine, int clear_lsb, int data_s=
wab,
> +                              uint32_t *pe_flags, int elf_machine,
> +                              int clear_lsb, int data_swab,
>                                AddressSpace *as, bool load_rom,
>                                symbol_fn_t sym_cb)
>  {
> @@ -594,6 +595,9 @@ static int glue(load_elf, SZ)(const char *name, int f=
d,
>          }
>      }
>
> +    if (pe_flags) {
> +        *pe_flags =3D (uint32_t)(elf_sword)ehdr.e_flags;
> +    }
>      if (lowaddr)
>          *lowaddr =3D (uint64_t)(elf_sword)low;
>      if (highaddr)
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 48a96cd559..22b59e15ba 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -101,6 +101,7 @@ const char *load_elf_strerror(int error);
>   * @pentry: Populated with program entry point. Ignored if NULL.
>   * @lowaddr: Populated with lowest loaded address. Ignored if NULL.
>   * @highaddr: Populated with highest loaded address. Ignored if NULL.
> + * @pe_flags: Populated with e_flags. Ignore if NULL.
>   * @bigendian: Expected ELF endianness. 0 for LE otherwise BE
>   * @elf_machine: Expected ELF machine type
>   * @clear_lsb: Set to mask off LSB of addresses (Some architectures use
> @@ -131,8 +132,9 @@ int load_elf_ram_sym(const char *filename,
>                       uint64_t (*elf_note_fn)(void *, void *, bool),
>                       uint64_t (*translate_fn)(void *, uint64_t),
>                       void *translate_opaque, uint64_t *pentry,
> -                     uint64_t *lowaddr, uint64_t *highaddr, int big_endi=
an,
> -                     int elf_machine, int clear_lsb, int data_swab,
> +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t *pe=
_flags,
> +                     int big_endian, int elf_machine,
> +                     int clear_lsb, int data_swab,
>                       AddressSpace *as, bool load_rom, symbol_fn_t sym_cb=
);
>
>  /** load_elf_ram:
[...]
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 5099f27dc8..9961b4423b 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -438,7 +438,7 @@ int load_elf_ram(const char *filename,
>  {
>      return load_elf_ram_sym(filename, elf_note_fn,
>                              translate_fn, translate_opaque,
> -                            pentry, lowaddr, highaddr, big_endian,
> +                            pentry, lowaddr, highaddr, NULL, big_endian,
>                              elf_machine, clear_lsb, data_swab, as,
>                              load_rom, NULL);
>  }
> @@ -448,8 +448,9 @@ int load_elf_ram_sym(const char *filename,
>                       uint64_t (*elf_note_fn)(void *, void *, bool),
>                       uint64_t (*translate_fn)(void *, uint64_t),
>                       void *translate_opaque, uint64_t *pentry,
> -                     uint64_t *lowaddr, uint64_t *highaddr, int big_endi=
an,
> -                     int elf_machine, int clear_lsb, int data_swab,
> +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t *pe=
_flags,
> +                     int big_endian, int elf_machine,
> +                     int clear_lsb, int data_swab,
>                       AddressSpace *as, bool load_rom, symbol_fn_t sym_cb=
)
>  {
>      int fd, data_order, target_data_order, must_swab, ret =3D ELF_LOAD_F=
AILED;
> @@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,
>      if (e_ident[EI_CLASS] =3D=3D ELFCLASS64) {
>          ret =3D load_elf64(filename, fd, elf_note_fn,
>                           translate_fn, translate_opaque, must_swab,
> -                         pentry, lowaddr, highaddr, elf_machine, clear_l=
sb,
> -                         data_swab, as, load_rom, sym_cb);
> +                         pentry, lowaddr, highaddr, pe_flags, elf_machin=
e,
> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>      } else {
>          ret =3D load_elf32(filename, fd, elf_note_fn,
>                           translate_fn, translate_opaque, must_swab,
> -                         pentry, lowaddr, highaddr, elf_machine, clear_l=
sb,
> -                         data_swab, as, load_rom, sym_cb);
> +                         pentry, lowaddr, highaddr, pe_flags, elf_machin=
e,
> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>      }
>
>   fail:
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 027303d2a3..746ca1f795 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -119,7 +119,7 @@ target_ulong riscv_load_kernel(const char *kernel_fil=
ename, symbol_fn_t sym_cb)
>      uint64_t kernel_entry, kernel_high;
>
>      if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
> -                         &kernel_entry, NULL, &kernel_high, 0,
> +                         &kernel_entry, NULL, &kernel_high, NULL, 0,
>                           EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
>          return kernel_entry;
>      }
[...]

