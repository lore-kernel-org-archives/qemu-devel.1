Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4F0C49ED7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 00:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37052085B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 00:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JJKkMmgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37052085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7qZK-0004m1-Nm
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 20:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i7qYF-0003gq-9z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 20:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i7qYB-0005QS-KS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 20:32:03 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52885 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i7qY1-0005Lc-Oh; Tue, 10 Sep 2019 20:31:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46SjWZ641kz9sP7; Wed, 11 Sep 2019 10:31:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568161898;
 bh=cA7b7aytxaYKxx2ui98cxrsbQcACQ+HLW2FtpmwOsBQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JJKkMmgkcQbm7+Fy0I4tM/dtJy82GaDCP9XYPn6vu+PZ5eieeP9dOIB9ND6nCHfoV
 dH3wJPBCd6VLFDFQ+a4fO2XAuIVdn5oI6EtmIYcjz7rikv4mepyKf/C/M7d9oyzaJI
 kCUrXuz8qBVs4DmJtOrI/tS10yN65mYuqCzvMqnk=
Date: Wed, 11 Sep 2019 10:08:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Message-ID: <20190911000851.GB30740@umbus.fritz.box>
References: <20190910193408.28917-1-alex.bennee@linaro.org>
 <20190910193408.28917-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20190910193408.28917-3-alex.bennee@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v1 2/4] elf: move elf.h to elf/elf.h and
 split out types
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
Cc: peter.maydell@linaro.org, Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Fabien Chouteau <chouteau@adacore.com>,
 "open list:S390-ccw boot" <qemu-s390x@nongnu.org>, qemu-arm@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, "open list:PReP" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2019 at 08:34:06PM +0100, Alex Benn=E9e wrote:
> Most of the users of elf.h just want the standard Elf definitions. The
> couple that want more than that want an expansion based on ELF_CLASS
> which can be used for size agnostic code. The later is moved into
> elf/elf-types.inc.h to make it clearer what it is for. While doing
> that I also removed the whitespace damage.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  bsd-user/elfload.c               |  2 +-
>  contrib/elf2dmp/qemu_elf.h       |  2 +-
>  disas.c                          |  2 +-
>  dump/dump.c                      |  2 +-
>  dump/win_dump.c                  |  2 +-
>  hw/alpha/dp264.c                 |  2 +-
>  hw/arm/armv7m.c                  |  2 +-
>  hw/arm/boot.c                    |  2 +-
>  hw/core/loader.c                 |  3 +-
>  hw/cris/axis_dev88.c             |  2 +-
>  hw/cris/boot.c                   |  2 +-
>  hw/hppa/machine.c                |  2 +-
>  hw/i386/multiboot.c              |  2 +-
>  hw/i386/pc.c                     |  2 +-
>  hw/lm32/lm32_boards.c            |  2 +-
>  hw/lm32/milkymist.c              |  2 +-
>  hw/m68k/an5206.c                 |  2 +-
>  hw/m68k/mcf5208.c                |  2 +-
>  hw/microblaze/boot.c             |  2 +-
>  hw/mips/mips_fulong2e.c          |  2 +-
>  hw/mips/mips_malta.c             |  2 +-
>  hw/mips/mips_mipssim.c           |  2 +-
>  hw/mips/mips_r4k.c               |  2 +-
>  hw/moxie/moxiesim.c              |  2 +-
>  hw/nios2/boot.c                  |  2 +-
>  hw/openrisc/openrisc_sim.c       |  2 +-
>  hw/pci-host/prep.c               |  2 +-
>  hw/ppc/e500.c                    |  2 +-
>  hw/ppc/mac_newworld.c            |  2 +-
>  hw/ppc/mac_oldworld.c            |  2 +-
>  hw/ppc/ppc440_bamboo.c           |  2 +-
>  hw/ppc/prep.c                    |  2 +-
>  hw/ppc/sam460ex.c                |  2 +-
>  hw/ppc/spapr.c                   |  2 +-
>  hw/ppc/spapr_vio.c               |  2 +-
>  hw/ppc/virtex_ml507.c            |  2 +-
>  hw/riscv/boot.c                  |  2 +-
>  hw/s390x/ipl.c                   |  2 +-
>  hw/sparc/leon3.c                 |  2 +-
>  hw/sparc/sun4m.c                 |  2 +-
>  hw/sparc64/sun4u.c               |  2 +-
>  hw/tricore/tricore_testboard.c   |  2 +-
>  hw/xtensa/sim.c                  |  2 +-
>  hw/xtensa/xtfpga.c               |  2 +-
>  include/elf/elf-types.inc.h      | 63 ++++++++++++++++++++++++++++++++
>  include/{ =3D> elf}/elf.h          | 42 ---------------------
>  include/hw/core/generic-loader.h |  2 +-
>  linux-user/arm/cpu_loop.c        |  2 +-
>  linux-user/elfload.c             |  5 +--
>  linux-user/main.c                |  2 +-
>  linux-user/mips/cpu_loop.c       |  2 +-
>  linux-user/riscv/cpu_loop.c      |  2 +-
>  target/arm/arch_dump.c           |  2 +-
>  target/i386/arch_dump.c          |  2 +-
>  target/ppc/arch_dump.c           |  2 +-
>  target/ppc/kvm.c                 |  2 +-
>  target/s390x/arch_dump.c         |  2 +-
>  tcg/arm/tcg-target.inc.c         |  2 +-
>  tcg/ppc/tcg-target.inc.c         |  2 +-
>  tcg/s390/tcg-target.inc.c        |  2 +-
>  tcg/tcg.c                        |  5 ++-
>  util/getauxval.c                 |  2 +-
>  62 files changed, 128 insertions(+), 104 deletions(-)
>  create mode 100644 include/elf/elf-types.inc.h
>  rename include/{ =3D> elf}/elf.h (98%)
>=20
> diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
> index 32378af7b2e..321ee98b86b 100644
> --- a/bsd-user/elfload.c
> +++ b/bsd-user/elfload.c
> @@ -509,7 +509,7 @@ static inline void init_thread(struct target_pt_regs =
*regs, struct image_info *i
>  #define bswaptls(ptr) bswap32s(ptr)
>  #endif
> =20
> -#include "elf.h"
> +#include "elf/elf.h"
> =20
>  struct exec
>  {
> diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
> index b2f0d9cbc9b..060d148d7f0 100644
> --- a/contrib/elf2dmp/qemu_elf.h
> +++ b/contrib/elf2dmp/qemu_elf.h
> @@ -7,7 +7,7 @@
>  #ifndef ELF2DMP_QEMU_ELF_H
>  #define ELF2DMP_QEMU_ELF_H
> =20
> -#include "elf.h"
> +#include "elf/elf.h"
> =20
>  typedef struct QEMUCPUSegment {
>      uint32_t selector;
> diff --git a/disas.c b/disas.c
> index 3e2bfa572b1..6f2370cfda7 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -1,7 +1,7 @@
>  /* General "disassemble this chunk" code.  Used for debugging. */
>  #include "qemu/osdep.h"
>  #include "disas/dis-asm.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "qemu/qemu-print.h"
> =20
>  #include "cpu.h"
> diff --git a/dump/dump.c b/dump/dump.c
> index 6fb6e1245ad..6b084a21a2a 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -14,7 +14,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qemu/cutils.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "cpu.h"
>  #include "exec/hwaddr.h"
>  #include "monitor/monitor.h"
> diff --git a/dump/win_dump.c b/dump/win_dump.c
> index eda2a489742..8232c3cb6b3 100644
> --- a/dump/win_dump.c
> +++ b/dump/win_dump.c
> @@ -11,7 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qemu/cutils.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "cpu.h"
>  #include "exec/hwaddr.h"
>  #include "monitor/monitor.h"
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 51feee85581..87e5c77c69c 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -9,7 +9,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "hw/loader.h"
>  #include "alpha_sys.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 7a3c48f0026..559586fa527 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -15,7 +15,7 @@
>  #include "hw/arm/boot.h"
>  #include "hw/loader.h"
>  #include "hw/qdev-properties.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "sysemu/qtest.h"
>  #include "sysemu/reset.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index bf97ef3e339..7818e5b5518 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -20,7 +20,7 @@
>  #include "hw/boards.h"
>  #include "sysemu/reset.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "sysemu/device_tree.h"
>  #include "qemu/config-file.h"
>  #include "qemu/option.h"
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 32f7cc7c33c..e0c6563e643 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -59,6 +59,7 @@
>  #include "hw/boards.h"
>  #include "qemu/cutils.h"
>  #include "sysemu/runstate.h"
> +#include "elf/elf.h"
> =20
>  #include <zlib.h>
> =20
> @@ -295,7 +296,7 @@ static void *load_at(int fd, off_t offset, size_t siz=
e)
>  #endif
> =20
>  #define ELF_CLASS   ELFCLASS32
> -#include "elf.h"
> +#include "elf/elf-types.inc.h"
> =20
>  #define SZ		32
>  #define elf_word        uint32_t
> diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
> index 940c7dd1226..31dc391a637 100644
> --- a/hw/cris/axis_dev88.c
> +++ b/hw/cris/axis_dev88.c
> @@ -32,7 +32,7 @@
>  #include "hw/boards.h"
>  #include "hw/cris/etraxfs.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "boot.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/qtest.h"
> diff --git a/hw/cris/boot.c b/hw/cris/boot.c
> index 2d2cc0c7a53..0b8008ca0b2 100644
> --- a/hw/cris/boot.c
> +++ b/hw/cris/boot.c
> @@ -25,7 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "boot.h"
>  #include "qemu/cutils.h"
>  #include "sysemu/reset.h"
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 2736ce835ee..3c121f1a645 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -6,7 +6,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "hw/loader.h"
>  #include "hw/boards.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> index 9a59f954972..54a7e5f048e 100644
> --- a/hw/i386/multiboot.c
> +++ b/hw/i386/multiboot.c
> @@ -28,7 +28,7 @@
>  #include "hw/nvram/fw_cfg.h"
>  #include "multiboot.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/error-report.h"
> =20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bad866fe44f..e84710a944a 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -39,7 +39,7 @@
>  #include "hw/timer/hpet.h"
>  #include "hw/firmware/smbios.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "migration/vmstate.h"
>  #include "multiboot.h"
>  #include "hw/timer/mc146818rtc.h"
> diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
> index 5ae308bfcfb..12c60ad9b74 100644
> --- a/hw/lm32/lm32_boards.c
> +++ b/hw/lm32/lm32_boards.c
> @@ -26,7 +26,7 @@
>  #include "hw/block/flash.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "lm32_hwsetup.h"
>  #include "lm32.h"
>  #include "exec/address-spaces.h"
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index 460d322de57..9f3a2f2ff5f 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -31,7 +31,7 @@
>  #include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "hw/qdev-properties.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "milkymist-hw.h"
>  #include "hw/display/milkymist_tmu2.h"
>  #include "lm32.h"
> diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
> index 54ccbe1a822..12664b872bc 100644
> --- a/hw/m68k/an5206.c
> +++ b/hw/m68k/an5206.c
> @@ -12,7 +12,7 @@
>  #include "hw/m68k/mcf.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/qtest.h"
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index 012710d057d..42d79bd2f03 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -25,7 +25,7 @@
>  #include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "hw/sysbus.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "exec/address-spaces.h"
> =20
>  #define SYS_FREQ 166666666
> diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
> index bade4d22c00..0c1020cd373 100644
> --- a/hw/microblaze/boot.c
> +++ b/hw/microblaze/boot.c
> @@ -34,7 +34,7 @@
>  #include "sysemu/reset.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "qemu/cutils.h"
> =20
>  #include "boot.h"
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index cf537dd7e63..4ba670cc909 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -37,7 +37,7 @@
>  #include "qemu/log.h"
>  #include "hw/loader.h"
>  #include "hw/ide.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "hw/isa/vt82c686.h"
>  #include "hw/timer/mc146818rtc.h"
>  #include "hw/timer/i8254.h"
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 4d9c64b36ab..1c841298363 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -44,7 +44,7 @@
>  #include "hw/ide.h"
>  #include "hw/irq.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "hw/timer/mc146818rtc.h"
>  #include "hw/timer/i8254.h"
>  #include "exec/address-spaces.h"
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 282bbecb24e..d6acd53b3e3 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -38,7 +38,7 @@
>  #include "hw/boards.h"
>  #include "hw/mips/bios.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "hw/sysbus.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index bc0be265441..7fc2fc51fee 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -27,7 +27,7 @@
>  #include "hw/mips/bios.h"
>  #include "hw/ide.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "hw/timer/mc146818rtc.h"
>  #include "hw/input/i8042.h"
>  #include "hw/timer/i8254.h"
> diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
> index 57af1b48912..bc1cc8b0bf8 100644
> --- a/hw/moxie/moxiesim.c
> +++ b/hw/moxie/moxiesim.c
> @@ -37,7 +37,7 @@
>  #include "hw/loader.h"
>  #include "hw/char/serial.h"
>  #include "exec/address-spaces.h"
> -#include "elf.h"
> +#include "elf/elf.h"
> =20
>  #define PHYS_MEM_BASE 0x80000000
>  #define FIRMWARE_BASE 0x1000
> diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
> index d78bc9ed0e2..ec1eb15bcaa 100644
> --- a/hw/nios2/boot.c
> +++ b/hw/nios2/boot.c
> @@ -39,7 +39,7 @@
>  #include "sysemu/reset.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
> =20
>  #include "boot.h"
> =20
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index 79e70493fc7..f21a2962a90 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -24,7 +24,7 @@
>  #include "cpu.h"
>  #include "hw/irq.h"
>  #include "hw/boards.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "hw/char/serial.h"
>  #include "net/net.h"
>  #include "hw/loader.h"
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index 85d7ba90374..9568746d8e2 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -37,7 +37,7 @@
>  #include "hw/loader.h"
>  #include "hw/or-irq.h"
>  #include "exec/address-spaces.h"
> -#include "elf.h"
> +#include "elf/elf.h"
> =20
>  #define TYPE_RAVEN_PCI_DEVICE "raven"
>  #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 91cd4c26f91..add6277ad6c 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -36,7 +36,7 @@
>  #include "hw/ppc/ppc.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "hw/sysbus.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/host-utils.h"
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index c5bbcc74335..50babbb7a67 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -65,7 +65,7 @@
>  #include "hw/ide.h"
>  #include "hw/loader.h"
>  #include "hw/fw-path-provider.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/reset.h"
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 0fa680b7499..64fe33cd1f3 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -44,7 +44,7 @@
>  #include "hw/ide.h"
>  #include "hw/loader.h"
>  #include "hw/fw-path-provider.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/reset.h"
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 4d95c0f8a88..15f39b332a8 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -23,7 +23,7 @@
>  #include "kvm_ppc.h"
>  #include "sysemu/device_tree.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "exec/address-spaces.h"
>  #include "hw/char/serial.h"
>  #include "hw/ppc/ppc.h"
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 4f3c6bf1901..8bd3209dec7 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -49,7 +49,7 @@
>  #include "sysemu/reset.h"
>  #include "exec/address-spaces.h"
>  #include "trace.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "qemu/units.h"
>  #include "kvm_ppc.h"
> =20
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 437e214210b..982b80e5bad 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -22,7 +22,7 @@
>  #include "sysemu/device_tree.h"
>  #include "sysemu/block-backend.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "exec/address-spaces.h"
>  #include "exec/memory.h"
>  #include "ppc440.h"
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 222a325056c..57f8041ec81 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -36,7 +36,7 @@
>  #include "sysemu/runstate.h"
>  #include "qemu/log.h"
>  #include "hw/fw-path-provider.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "net/net.h"
>  #include "sysemu/device_tree.h"
>  #include "sysemu/cpus.h"
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 0803649658f..6d90322db0b 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -26,7 +26,7 @@
>  #include "hw/irq.h"
>  #include "qemu/log.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "hw/sysbus.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/device_tree.h"
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 68625522d8a..ede7da4bbc2 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -35,7 +35,7 @@
>  #include "hw/boards.h"
>  #include "sysemu/device_tree.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "qemu/error-report.h"
>  #include "qemu/log.h"
>  #include "qemu/option.h"
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 4c63b5cf8a8..9a7b4a5ca87 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -25,7 +25,7 @@
>  #include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "hw/riscv/boot.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "sysemu/qtest.h"
> =20
>  #if defined(TARGET_RISCV32)
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index ca544d64c5e..cf4e06b633e 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -19,7 +19,7 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/tcg.h"
>  #include "cpu.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "hw/loader.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/boards.h"
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index c5f1b1ee72e..735a823fd56 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -37,7 +37,7 @@
>  #include "sysemu/reset.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "trace.h"
>  #include "exec/address-spaces.h"
> =20
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 6c5a17a0205..d542a6c203c 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -49,7 +49,7 @@
>  #include "hw/empty_slot.h"
>  #include "hw/irq.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "trace.h"
> =20
>  /*
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 1ded2a4c9ab..79b15c8aec3 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -54,7 +54,7 @@
>  #include "hw/ide/pci.h"
>  #include "hw/loader.h"
>  #include "hw/fw-path-provider.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "trace.h"
> =20
>  #define KERNEL_LOAD_ADDR     0x00404000
> diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboar=
d.c
> index aef3289f8c3..84e8d7b429f 100644
> --- a/hw/tricore/tricore_testboard.c
> +++ b/hw/tricore/tricore_testboard.c
> @@ -26,7 +26,7 @@
>  #include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "exec/address-spaces.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "hw/tricore/tricore.h"
>  #include "qemu/error-report.h"
> =20
> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
> index 981dbb7bbeb..f8d96fc452c 100644
> --- a/hw/xtensa/sim.c
> +++ b/hw/xtensa/sim.c
> @@ -32,7 +32,7 @@
>  #include "sysemu/sysemu.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "exec/memory.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index 8220c7a3794..5e3ed738fa8 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -33,7 +33,7 @@
>  #include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "hw/qdev-properties.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "exec/memory.h"
>  #include "exec/address-spaces.h"
>  #include "hw/char/serial.h"
> diff --git a/include/elf/elf-types.inc.h b/include/elf/elf-types.inc.h
> new file mode 100644
> index 00000000000..35163adb2b5
> --- /dev/null
> +++ b/include/elf/elf-types.inc.h
> @@ -0,0 +1,63 @@
> +/*
> + * Elf Type Specialisation
> + *
> + * Copyright (c) 2019
> + * Written by Alex Benn=E9e <alex.bennee@linaro.org>
> + *
> + * This code is licensed under the GNU .
> + */
> +
> +#ifndef _ELF_TYPES_INC_H_
> +#define _ELF_TYPES_INC_H_
> +
> +#ifndef ELF_CLASS
> +#error you must define ELF_CLASS before including elf-types.inc.h
> +#else
> +
> +#if ELF_CLASS =3D=3D ELFCLASS32
> +
> +#define elfhdr      elf32_hdr
> +#define elf_phdr    elf32_phdr
> +#define elf_note    elf32_note
> +#define elf_shdr    elf32_shdr
> +#define elf_sym     elf32_sym
> +#define elf_addr_t  Elf32_Off
> +#define elf_rela    elf32_rela
> +
> +#ifdef ELF_USES_RELOCA
> +# define ELF_RELOC  Elf32_Rela
> +#else
> +# define ELF_RELOC  Elf32_Rel
> +#endif
> +
> +#ifndef ElfW
> +#  define ElfW(x)   Elf32_ ## x
> +#  define ELFW(x)   ELF32_ ## x
> +#endif
> +
> +#else /* ELF_CLASS =3D=3D ELFCLASS64 */
> +
> +#define elfhdr      elf64_hdr
> +#define elf_phdr    elf64_phdr
> +#define elf_note    elf64_note
> +#define elf_shdr    elf64_shdr
> +#define elf_sym     elf64_sym
> +#define elf_addr_t  Elf64_Off
> +#define elf_rela    elf64_rela
> +
> +#ifdef ELF_USES_RELOCA
> +# define ELF_RELOC  Elf64_Rela
> +#else
> +# define ELF_RELOC  Elf64_Rel
> +#endif
> +
> +#ifndef ElfW
> +#  define ElfW(x)   Elf64_ ## x
> +#  define ELFW(x)   ELF64_ ## x
> +#endif
> +
> +#endif /* ELF_CLASS =3D=3D ELFCLASS64 */
> +#endif /* ELF_CLASS */
> +#else
> +#error elf-types.inc.h should not be included twice in one compilation u=
nit
> +#endif /* _ELF_TYPES_INC_H_ */
> diff --git a/include/elf.h b/include/elf/elf.h
> similarity index 98%
> rename from include/elf.h
> rename to include/elf/elf.h
> index 3501e0c8d03..2e264c1a7a0 100644
> --- a/include/elf.h
> +++ b/include/elf/elf.h
> @@ -1696,49 +1696,7 @@ struct elf32_fdpic_loadmap {
>  };
> =20
>  #ifdef ELF_CLASS
> -#if ELF_CLASS =3D=3D ELFCLASS32
> -
> -#define elfhdr		elf32_hdr
> -#define elf_phdr	elf32_phdr
> -#define elf_note	elf32_note
> -#define elf_shdr	elf32_shdr
> -#define elf_sym		elf32_sym
> -#define elf_addr_t	Elf32_Off
> -#define elf_rela  elf32_rela
> -
> -#ifdef ELF_USES_RELOCA
> -# define ELF_RELOC      Elf32_Rela
> -#else
> -# define ELF_RELOC      Elf32_Rel
> -#endif
> -
> -#else
> -
> -#define elfhdr		elf64_hdr
> -#define elf_phdr	elf64_phdr
> -#define elf_note	elf64_note
> -#define elf_shdr	elf64_shdr
> -#define elf_sym		elf64_sym
> -#define elf_addr_t	Elf64_Off
> -#define elf_rela  elf64_rela
> -
> -#ifdef ELF_USES_RELOCA
> -# define ELF_RELOC      Elf64_Rela
> -#else
> -# define ELF_RELOC      Elf64_Rel
> -#endif
> -
> -#endif /* ELF_CLASS */
> =20
> -#ifndef ElfW
> -# if ELF_CLASS =3D=3D ELFCLASS32
> -#  define ElfW(x)  Elf32_ ## x
> -#  define ELFW(x)  ELF32_ ## x
> -# else
> -#  define ElfW(x)  Elf64_ ## x
> -#  define ELFW(x)  ELF64_ ## x
> -# endif
> -#endif
> =20
>  #endif /* ELF_CLASS */
> =20
> diff --git a/include/hw/core/generic-loader.h b/include/hw/core/generic-l=
oader.h
> index 9ffce1c5a30..ca97affd8e1 100644
> --- a/include/hw/core/generic-loader.h
> +++ b/include/hw/core/generic-loader.h
> @@ -18,7 +18,7 @@
>  #ifndef GENERIC_LOADER_H
>  #define GENERIC_LOADER_H
> =20
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "hw/qdev-core.h"
> =20
>  typedef struct GenericLoaderState {
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index 8d65de5b9f4..970fff8b1bc 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -20,7 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qemu.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "cpu_loop-common.h"
> =20
>  #define get_user_code_u32(x, gaddr, env)                \
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 3365e192eb3..59a0d21c6f1 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -7,6 +7,7 @@
> =20
>  #include "qemu.h"
>  #include "disas/disas.h"
> +#include "elf/elf.h"
>  #include "qemu/path.h"
>  #include "qemu/queue.h"
>  #include "qemu/guest-random.h"
> @@ -1317,8 +1318,6 @@ static inline void init_thread(struct target_pt_reg=
s *regs,
>  #define ELF_DATA	ELFDATA2MSB
>  #define ELF_ARCH	EM_S390
> =20
> -#include "elf.h"
> -
>  #define ELF_HWCAP get_elf_hwcap()
> =20
>  #define GET_FEATURE(_feat, _hwcap) \
> @@ -1512,7 +1511,7 @@ static void elf_core_copy_regs(target_elf_gregset_t=
 *regs,
>  #define bswaptls(ptr) bswap32s(ptr)
>  #endif
> =20
> -#include "elf.h"
> +#include "elf/elf-types.inc.h"
> =20
>  struct exec
>  {
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 47917bbb20f..c796a15700d 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -40,7 +40,7 @@
>  #include "qemu/timer.h"
>  #include "qemu/envlist.h"
>  #include "qemu/guest-random.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "trace/control.h"
>  #include "target_elf.h"
>  #include "cpu_loop-common.h"
> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> index 39915b3fde2..0d3f0738b58 100644
> --- a/linux-user/mips/cpu_loop.c
> +++ b/linux-user/mips/cpu_loop.c
> @@ -21,7 +21,7 @@
>  #include "qemu-common.h"
>  #include "qemu.h"
>  #include "cpu_loop-common.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "internal.h"
> =20
>  # ifdef TARGET_ABI_MIPSO32
> diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
> index 12aa3c0f16e..f9f5beef431 100644
> --- a/linux-user/riscv/cpu_loop.c
> +++ b/linux-user/riscv/cpu_loop.c
> @@ -22,7 +22,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu.h"
>  #include "cpu_loop-common.h"
> -#include "elf.h"
> +#include "elf/elf.h"
> =20
>  void cpu_loop(CPURISCVState *env)
>  {
> diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
> index 26a2c098687..c05a2845883 100644
> --- a/target/arm/arch_dump.c
> +++ b/target/arm/arch_dump.c
> @@ -20,7 +20,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "sysemu/dump.h"
> =20
>  /* struct user_pt_regs from arch/arm64/include/uapi/asm/ptrace.h */
> diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
> index 004141fc042..9eb1e2a8bcf 100644
> --- a/target/i386/arch_dump.c
> +++ b/target/i386/arch_dump.c
> @@ -14,7 +14,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "sysemu/dump.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "sysemu/memory_mapping.h"
> =20
>  #define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> index 9ab04b2c38f..0e102be1ed5 100644
> --- a/target/ppc/arch_dump.c
> +++ b/target/ppc/arch_dump.c
> @@ -14,7 +14,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "sysemu/dump.h"
>  #include "sysemu/kvm.h"
>  #include "exec/helper-proto.h"
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8c5b1f25cc9..c2e5f72ab0d 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -48,7 +48,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/mmap-alloc.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "sysemu/kvm_int.h"
> =20
>  #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
> diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
> index 50fa0ae4b67..5fe9519d26c 100644
> --- a/target/s390x/arch_dump.c
> +++ b/target/s390x/arch_dump.c
> @@ -14,7 +14,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "internal.h"
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "sysemu/dump.h"
> =20
> =20
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index 94d80d79d1f..e04f726e4a6 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -22,7 +22,7 @@
>   * THE SOFTWARE.
>   */
> =20
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "tcg-pool.inc.c"
> =20
>  int arm_arch =3D __ARM_ARCH;
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index 815edac077f..4886f8c0d39 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -22,7 +22,7 @@
>   * THE SOFTWARE.
>   */
> =20
> -#include "elf.h"
> +#include "elf/elf.h"
>  #include "tcg-pool.inc.c"
> =20
>  #if defined _CALL_DARWIN || defined __APPLE__
> diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
> index 8aaa4cebe8d..82a81d2d94d 100644
> --- a/tcg/s390/tcg-target.inc.c
> +++ b/tcg/s390/tcg-target.inc.c
> @@ -30,7 +30,7 @@
>  #endif
> =20
>  #include "tcg-pool.inc.c"
> -#include "elf.h"
> +#include "elf/elf.h"
> =20
>  /* ??? The translation blocks produced by TCG are generally small enough=
 to
>     be entirely reachable with a 16-bit displacement.  Leaving the option=
 for
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 16b2d0e0ece..b8e2c7956b7 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -50,6 +50,8 @@
> =20
>  #include "tcg-op.h"
> =20
> +#include "elf/elf.h"
> +
>  #if UINTPTR_MAX =3D=3D UINT32_MAX
>  # define ELF_CLASS  ELFCLASS32
>  #else
> @@ -61,7 +63,8 @@
>  # define ELF_DATA   ELFDATA2LSB
>  #endif
> =20
> -#include "elf.h"
> +#include "elf/elf-types.inc.h"
> +
>  #include "exec/log.h"
>  #include "sysemu/sysemu.h"
> =20
> diff --git a/util/getauxval.c b/util/getauxval.c
> index 36afdfb9e62..ee216c81c0b 100644
> --- a/util/getauxval.c
> +++ b/util/getauxval.c
> @@ -36,7 +36,7 @@ unsigned long qemu_getauxval(unsigned long key)
>      return getauxval(key);
>  }
>  #elif defined(__linux__)
> -#include "elf.h"
> +#include "elf/elf.h"
> =20
>  /* Our elf.h doesn't contain Elf32_auxv_t and Elf64_auxv_t, which is ok =
because
>     that just makes it easier to define it properly for the host here.  */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl14OxEACgkQbDjKyiDZ
s5J74hAAseVNj7Muevaw8yrudRLqrpnxRcIGyjzPuiMNLBhdd/bUeO/S/Ls1DzeE
I6tLH9JxA1xZoO+MGN+HuSwxLBtxXuuk0NxrkDvlIXwhQ9qdFmnzPWmZ6e5Y2pk9
WcM2I2vIhlYaoPEvUzcYJPif9rb7vYGb6ZAvGuo9a3QqGDClT8e+nZrSJpxH4I4Z
IYy4ZuJn9zaC4084sCZk0sbMHyUja+w0Wk5pSQtIgos68kj3ESR3voLR8NIX5VCo
sV3kdh8u8B6nacRWMZPwLZZiAdfVCtyf1Ydhv3y7hOLmfsXz6UeUkDvNSpXqCpYj
q9U7JGXAawHB/V+MOtSAFcET/3UoPCNy/ivanY4sJfRpEgutgx2seFUmhIyFKNIQ
gDvB7Udb1UngmiDUhelSWmA18ze7rUGVrhEQ5d7i4q6lK/r1Py+DkxOE70b3QW2q
oLGG3c5gzbErLdquAXP9+Cl72b70FPZGw1ZyymeWXRPkWrj3mUKwGeJc4Kn/+LpO
PRGRst5Nx+n2n3V2JpY4pXO5xmTPmGU1p8c7pMQsamXwkYLIE/qjodbS5tzuhlGf
/0KoLXLikxP8a7H3GzWTcBuxZeEe/PCUg5XB0T+AmH86AmJiyVSHP+7XaPuh2OF+
xV7Ay9h+wM5JU6VLJSE8bpRFRe9UfsExdwcVX50IT9R/5rjISLU=
=isBD
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

