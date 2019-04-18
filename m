Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93685C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD37217FA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD37217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39781 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH5GK-0002bf-FQ
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 07:31:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hH5E6-0000t9-04
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hH5E4-0001oP-2l
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:29:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hH5E3-0001nV-Pv
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:29:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AF4A1F566
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 11:29:07 +0000 (UTC)
Received: from work-vm (ovpn-117-54.ams2.redhat.com [10.36.117.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 53406608C9;
	Thu, 18 Apr 2019 11:29:04 +0000 (UTC)
Date: Thu, 18 Apr 2019 12:29:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190418112901.GD2984@work-vm>
References: <20190417191805.28198-1-armbru@redhat.com>
	<20190417191805.28198-17-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190417191805.28198-17-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 18 Apr 2019 11:29:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 16/17] disas: Rename include/disas/bfd.h
 back to include/disas/dis-asm.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418112901.oXGRhUJjGYXaXccCL5Tv-9tLdyAghe94er6rQR-_GBw@z>

* Markus Armbruster (armbru@redhat.com) wrote:
> Commit dc99065b5f9 (v0.1.0) added dis-asm.h from binutils.
> 
> Commit 43d4145a986 (v0.1.5) inlined bfd.h into dis-asm.h to remove the
> dependency on binutils.
> 
> Commit 76cad71136b (v1.4.0) moved dis-asm.h to include/disas/bfd.h.
> The new name is confusing when you try to match against (pre GPLv3+)
> binutils.  Rename it back.  Keep it in the same directory, of course.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  disas.c                            | 2 +-
>  disas/alpha.c                      | 2 +-
>  disas/arm-a64.cc                   | 2 +-
>  disas/arm.c                        | 2 +-
>  disas/cris.c                       | 2 +-
>  disas/hppa.c                       | 2 +-
>  disas/i386.c                       | 2 +-
>  disas/lm32.c                       | 2 +-
>  disas/m68k.c                       | 2 +-
>  disas/microblaze.c                 | 2 +-
>  disas/mips.c                       | 2 +-
>  disas/moxie.c                      | 2 +-
>  disas/nanomips.cpp                 | 2 +-
>  disas/nios2.c                      | 2 +-
>  disas/ppc.c                        | 2 +-
>  disas/riscv.c                      | 2 +-
>  disas/s390.c                       | 2 +-
>  disas/sh4.c                        | 2 +-
>  disas/sparc.c                      | 2 +-
>  disas/tci.c                        | 2 +-
>  disas/xtensa.c                     | 2 +-
>  include/disas/{bfd.h => dis-asm.h} | 0
>  include/qom/cpu.h                  | 2 +-
>  target/openrisc/disas.c            | 2 +-
>  target/ppc/translate_init.inc.c    | 2 +-
>  25 files changed, 24 insertions(+), 24 deletions(-)
>  rename include/disas/{bfd.h => dis-asm.h} (100%)
> 
> diff --git a/disas.c b/disas.c
> index d15cceb863..41ad0102e2 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -1,7 +1,7 @@
>  /* General "disassemble this chunk" code.  Used for debugging. */
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  #include "elf.h"
>  #include "qemu/qemu-print.h"
>  
> diff --git a/disas/alpha.c b/disas/alpha.c
> index a0c9ecd49d..3db90fa665 100644
> --- a/disas/alpha.c
> +++ b/disas/alpha.c
> @@ -20,7 +20,7 @@ along with this file; see the file COPYING.  If not, see
>  <http://www.gnu.org/licenses/>. */
>  
>  #include "qemu/osdep.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  
>  /* MAX is redefined below, so remove any previous definition. */
>  #undef MAX
> diff --git a/disas/arm-a64.cc b/disas/arm-a64.cc
> index 9280950ce3..9fa779e175 100644
> --- a/disas/arm-a64.cc
> +++ b/disas/arm-a64.cc
> @@ -19,7 +19,7 @@
>  
>  extern "C" {
>  #include "qemu/osdep.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  }
>  
>  #include "vixl/a64/disasm-a64.h"
> diff --git a/disas/arm.c b/disas/arm.c
> index 17ea120b44..7d940f2396 100644
> --- a/disas/arm.c
> +++ b/disas/arm.c
> @@ -23,7 +23,7 @@
>     for things we don't care about.  */
>  
>  #include "qemu/osdep.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  
>  #define ARM_EXT_V1	 0
>  #define ARM_EXT_V2	 0
> diff --git a/disas/cris.c b/disas/cris.c
> index 2dd56deea4..bf9eafc415 100644
> --- a/disas/cris.c
> +++ b/disas/cris.c
> @@ -20,7 +20,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  #include "target/cris/opcode-cris.h"
>  
>  #define CONST_STRNEQ(STR1,STR2) (strncmp ((STR1), (STR2), sizeof (STR2) - 1) == 0)
> diff --git a/disas/hppa.c b/disas/hppa.c
> index a2d371fdb1..2dbd1fc445 100644
> --- a/disas/hppa.c
> +++ b/disas/hppa.c
> @@ -19,7 +19,7 @@
>     along with this program; if not, see <http://www.gnu.org/licenses/>. */
>  
>  #include "qemu/osdep.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  
>  /* HP PA-RISC SOM object file format:  definitions internal to BFD.
>     Copyright 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1998, 1999, 2000,
> diff --git a/disas/i386.c b/disas/i386.c
> index fc03b9f06a..4c1f0f877b 100644
> --- a/disas/i386.c
> +++ b/disas/i386.c
> @@ -32,7 +32,7 @@
>     the Intel manual for details.  */
>  
>  #include "qemu/osdep.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  #include "qemu/cutils.h"
>  
>  /* include/opcode/i386.h r1.78 */
> diff --git a/disas/lm32.c b/disas/lm32.c
> index fcc2cde23d..c0ef8160fe 100644
> --- a/disas/lm32.c
> +++ b/disas/lm32.c
> @@ -19,7 +19,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  
>  typedef enum {
>      LM32_OP_SRUI = 0, LM32_OP_NORI, LM32_OP_MULI, LM32_OP_SH, LM32_OP_LB,
> diff --git a/disas/m68k.c b/disas/m68k.c
> index e544c7137f..863409c67c 100644
> --- a/disas/m68k.c
> +++ b/disas/m68k.c
> @@ -4,7 +4,7 @@
>  #include "qemu/osdep.h"
>  #include <math.h>
>  
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  
>  /* **** floatformat.h from sourceware.org CVS 2005-08-14.  */
>  /* IEEE floating point support declarations, for GDB, the GNU Debugger.
> diff --git a/disas/microblaze.c b/disas/microblaze.c
> index c23605043a..0b89b9c4fa 100644
> --- a/disas/microblaze.c
> +++ b/disas/microblaze.c
> @@ -577,7 +577,7 @@ static const char pvr_register_prefix[] = "rpvr";
>  
>  #endif /* MICROBLAZE_OPC */
>  
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  
>  #define get_field_rd(instr) get_field(instr, RD_MASK, RD_LOW)
>  #define get_field_r1(instr) get_field(instr, RA_MASK, RA_LOW)
> diff --git a/disas/mips.c b/disas/mips.c
> index 97f661a37e..dfefe5e589 100644
> --- a/disas/mips.c
> +++ b/disas/mips.c
> @@ -20,7 +20,7 @@ You should have received a copy of the GNU General Public License
>  along with this program; if not, see <http://www.gnu.org/licenses/>.  */
>  
>  #include "qemu/osdep.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  
>  /* mips.h.  Mips opcode list for GDB, the GNU debugger.
>     Copyright 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003
> diff --git a/disas/moxie.c b/disas/moxie.c
> index 70b49ed74b..e94ab4c33d 100644
> --- a/disas/moxie.c
> +++ b/disas/moxie.c
> @@ -18,7 +18,7 @@
>  #define STATIC_TABLE
>  #define DEFINE_TABLE
>  
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  
>  static void *stream;
>  
> diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
> index c8495b1a19..90e63b8367 100644
> --- a/disas/nanomips.cpp
> +++ b/disas/nanomips.cpp
> @@ -29,7 +29,7 @@
>  
>  extern "C" {
>  #include "qemu/osdep.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  }
>  
>  #include <cstring>
> diff --git a/disas/nios2.c b/disas/nios2.c
> index de11f04cc4..c3e82140c7 100644
> --- a/disas/nios2.c
> +++ b/disas/nios2.c
> @@ -36,7 +36,7 @@
>  
>  /*#include "bfd.h"*/
>  #include "qemu/osdep.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  
>  
>  /****************************************************************************
> diff --git a/disas/ppc.c b/disas/ppc.c
> index da1140ba2b..a545437de9 100644
> --- a/disas/ppc.c
> +++ b/disas/ppc.c
> @@ -19,7 +19,7 @@ You should have received a copy of the GNU General Public License
>  along with this file; see the file COPYING.  If not,
>  see <http://www.gnu.org/licenses/>.  */
>  #include "qemu/osdep.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  #define BFD_DEFAULT_TARGET_SIZE 64
>  
>  /* ppc.h -- Header file for PowerPC opcode table
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 27546dd790..59a9b0437a 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -18,7 +18,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  
>  
>  /* types */
> diff --git a/disas/s390.c b/disas/s390.c
> index 6393860239..b1f4e2a0c1 100644
> --- a/disas/s390.c
> +++ b/disas/s390.c
> @@ -22,7 +22,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  
>  /* include/opcode/s390.h revision 1.9 */
>  /* s390.h -- Header file for S390 opcode table
> diff --git a/disas/sh4.c b/disas/sh4.c
> index 6b66176bed..55ef865a36 100644
> --- a/disas/sh4.c
> +++ b/disas/sh4.c
> @@ -16,7 +16,7 @@
>     along with this program; if not, see <http://www.gnu.org/licenses/>.  */
>  
>  #include "qemu/osdep.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  
>  #define DEFINE_TABLE
>  
> diff --git a/disas/sparc.c b/disas/sparc.c
> index f120f4e86d..5689533ce1 100644
> --- a/disas/sparc.c
> +++ b/disas/sparc.c
> @@ -27,7 +27,7 @@
>     see <http://www.gnu.org/licenses/>.  */
>  
>  #include "qemu/osdep.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  
>  /* The SPARC opcode table (and other related data) is defined in
>     the opcodes library in sparc-opc.c.  If you change anything here, make
> diff --git a/disas/tci.c b/disas/tci.c
> index 1cdf5eeafc..f1d6c6b469 100644
> --- a/disas/tci.c
> +++ b/disas/tci.c
> @@ -19,7 +19,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  #include "tcg/tcg.h"
>  
>  /* Disassemble TCI bytecode. */
> diff --git a/disas/xtensa.c b/disas/xtensa.c
> index 5e3870b9ad..d7dda8c2d6 100644
> --- a/disas/xtensa.c
> +++ b/disas/xtensa.c
> @@ -26,7 +26,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  #include "hw/xtensa/xtensa-isa.h"
>  
>  int print_insn_xtensa(bfd_vma memaddr, struct disassemble_info *info)
> diff --git a/include/disas/bfd.h b/include/disas/dis-asm.h
> similarity index 100%
> rename from include/disas/bfd.h
> rename to include/disas/dis-asm.h
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 9972e07786..e9bec3a5bc 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -21,7 +21,7 @@
>  #define QEMU_CPU_H
>  
>  #include "hw/qdev-core.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  #include "exec/hwaddr.h"
>  #include "exec/memattrs.h"
>  #include "qapi/qapi-types-run-state.h"
> diff --git a/target/openrisc/disas.c b/target/openrisc/disas.c
> index bc63093ee9..5923b2429e 100644
> --- a/target/openrisc/disas.c
> +++ b/target/openrisc/disas.c
> @@ -19,7 +19,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  #include "qemu/bitops.h"
>  #include "cpu.h"
>  
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index 996356dd99..20a64f3b77 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -18,7 +18,7 @@
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
> -#include "disas/bfd.h"
> +#include "disas/dis-asm.h"
>  #include "exec/gdbstub.h"
>  #include "kvm_ppc.h"
>  #include "sysemu/arch_init.h"
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

