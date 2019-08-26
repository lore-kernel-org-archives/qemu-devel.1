Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6084CC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 06:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323A121848
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 06:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323A121848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i285L-0005Od-AY
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 02:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i284M-0004xO-57
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 02:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i284J-00011u-Vp
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 02:01:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53842)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i284J-000113-Mi
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 02:01:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7575E18C891F;
 Mon, 26 Aug 2019 06:01:29 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-115.ams2.redhat.com [10.36.116.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9477D5D6A5;
 Mon, 26 Aug 2019 06:01:24 +0000 (UTC)
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20190824184635.34192-1-mrolnik@gmail.com>
 <20190824184635.34192-8-mrolnik@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <173c5b02-638e-3523-48ad-34bc85c580d4@redhat.com>
Date: Mon, 26 Aug 2019 08:01:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824184635.34192-8-mrolnik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Mon, 26 Aug 2019 06:01:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v29 7/8] target/avr: Register AVR support
 with the rest of QEMU, the build system, and the MAINTAINERS file
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
Cc: richard.henderson@linaro.org, philmd@redhat.com, dovgaluk@ispras.ru,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/08/2019 20.46, Michael Rolnik wrote:
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>  MAINTAINERS                     |  6 ++++++
>  arch_init.c                     |  2 ++
>  configure                       |  7 +++++++
>  default-configs/avr-softmmu.mak |  5 +++++
>  include/disas/dis-asm.h         |  6 ++++++
>  include/sysemu/arch_init.h      |  1 +
>  qapi/machine.json               |  3 ++-
>  target/avr/Makefile.objs        | 33 +++++++++++++++++++++++++++++++++
>  tests/machine-none-test.c       |  1 +
>  9 files changed, 63 insertions(+), 1 deletion(-)
>  create mode 100644 default-configs/avr-softmmu.mak
>  create mode 100644 target/avr/Makefile.objs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ef6c01084b..763370e6ff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -163,6 +163,12 @@ S: Maintained
>  F: hw/arm/smmu*
>  F: include/hw/arm/smmu*
>  
> +AVR TCG CPUs
> +M: Michael Rolnik <mrolnik@gmail.com>
> +S: Maintained
> +F: target/avr/
> +F: hw/avr/
> +
>  CRIS TCG CPUs
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
> diff --git a/arch_init.c b/arch_init.c
> index 0a1531124c..fb308aa802 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -85,6 +85,8 @@ int graphic_depth = 32;
>  #define QEMU_ARCH QEMU_ARCH_UNICORE32
>  #elif defined(TARGET_XTENSA)
>  #define QEMU_ARCH QEMU_ARCH_XTENSA
> +#elif defined(TARGET_AVR)
> +#define QEMU_ARCH QEMU_ARCH_AVR
>  #endif
>  
>  const uint32_t arch_type = QEMU_ARCH;
> diff --git a/configure b/configure
> index e44e454c43..1dbecba329 100755
> --- a/configure
> +++ b/configure
> @@ -7510,6 +7510,10 @@ case "$target_name" in
>      target_compiler=$cross_cc_aarch64
>      eval "target_compiler_cflags=\$cross_cc_cflags_${target_name}"
>    ;;
> +  avr)
> +	gdb_xml_files="avr-cpu.xml"

Nit: Above line uses a tab instead of spaces.

> +    target_compiler=$cross_cc_avr
> +  ;;
>    cris)
>      target_compiler=$cross_cc_cris
>    ;;
> @@ -7790,6 +7794,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>        disas_config "ARM_A64"
>      fi
>    ;;
> +  avr)
> +    disas_config "AVR"
> +  ;;
>    cris)
>      disas_config "CRIS"
>    ;;
> diff --git a/default-configs/avr-softmmu.mak b/default-configs/avr-softmmu.mak
> new file mode 100644
> index 0000000000..d1e1c28118
> --- /dev/null
> +++ b/default-configs/avr-softmmu.mak
> @@ -0,0 +1,5 @@
> +# Default configuration for avr-softmmu
> +
> +# Boards:
> +#
> +CONFIG_AVR_SAMPLE=y
> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
> index e9c7dd8eb4..8bedce17ac 100644
> --- a/include/disas/dis-asm.h
> +++ b/include/disas/dis-asm.h
> @@ -211,6 +211,12 @@ enum bfd_architecture
>  #define bfd_mach_m32r          0  /* backwards compatibility */
>    bfd_arch_mn10200,    /* Matsushita MN10200 */
>    bfd_arch_mn10300,    /* Matsushita MN10300 */
> +  bfd_arch_avr,       /* Atmel AVR microcontrollers.  */
> +#define bfd_mach_avr1          1
> +#define bfd_mach_avr2          2
> +#define bfd_mach_avr3          3
> +#define bfd_mach_avr4          4
> +#define bfd_mach_avr5          5
>    bfd_arch_cris,       /* Axis CRIS */
>  #define bfd_mach_cris_v0_v10   255
>  #define bfd_mach_cris_v32      32
> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
> index 62c6fe4cf1..893df26ce2 100644
> --- a/include/sysemu/arch_init.h
> +++ b/include/sysemu/arch_init.h
> @@ -24,6 +24,7 @@ enum {
>      QEMU_ARCH_NIOS2 = (1 << 17),
>      QEMU_ARCH_HPPA = (1 << 18),
>      QEMU_ARCH_RISCV = (1 << 19),
> +    QEMU_ARCH_AVR = (1 << 20),
>  };
>  
>  extern const uint32_t arch_type;
> diff --git a/qapi/machine.json b/qapi/machine.json
> index de5c742d72..a82ba088f4 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -21,11 +21,12 @@
>  #        is true even for "qemu-system-x86_64".
>  #
>  # ppcemb: dropped in 3.1
> +# avr: addin in 4.2

Please use "since 4.2" because that's the word that we use in most spots
in the QAPI documentation.

>  # Since: 3.0
>  ##
>  { 'enum' : 'SysEmuTarget',
> -  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
> +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386', 'lm32',
>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
> new file mode 100644
> index 0000000000..2976affd95
> --- /dev/null
> +++ b/target/avr/Makefile.objs
> @@ -0,0 +1,33 @@
> +#
> +#  QEMU AVR CPU
> +#
> +#  Copyright (c) 2019 Michael Rolnik
> +#
> +#  This library is free software; you can redistribute it and/or
> +#  modify it under the terms of the GNU Lesser General Public
> +#  License as published by the Free Software Foundation; either
> +#  version 2.1 of the License, or (at your option) any later version.
> +#
> +#  This library is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +#  Lesser General Public License for more details.
> +#
> +#  You should have received a copy of the GNU Lesser General Public
> +#  License along with this library; if not, see
> +#  <http://www.gnu.org/licenses/lgpl-2.1.html>
> +#
> +
> +DECODETREE = $(SRC_PATH)/scripts/decodetree.py
> +decode-y = $(SRC_PATH)/target/avr/insn.decode
> +
> +target/avr/decode_insn.inc.c: $(decode-y) $(DECODETREE)
> +	$(call quiet-command, \
> +	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn --insnwidth 16 $<, \
> +	  "GEN", $(TARGET_DIR)$@)
> +
> +target/avr/translate.o: target/avr/decode_insn.inc.c
> +
> +obj-y += translate.o cpu.o helper.o
> +obj-y += gdbstub.o
> +obj-$(CONFIG_SOFTMMU) += machine.o
> diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
> index 5953d31755..3e5c74e73e 100644
> --- a/tests/machine-none-test.c
> +++ b/tests/machine-none-test.c
> @@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] = {
>      /* tested targets list */
>      { "arm", "cortex-a15" },
>      { "aarch64", "cortex-a57" },
> +    { "avr", "avr6-avr-cpu" },
>      { "x86_64", "qemu64,apic-id=0" },
>      { "i386", "qemu32,apic-id=0" },
>      { "alpha", "ev67" },
> 

Apart from the two small nits, the patch looks fine to me.

 Thomas

