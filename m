Received: from eggs.gnu.org ([2001:4830:134:3::10]:37568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZHtV-0005gw-Cw
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZHtQ-00076Y-JO
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:30:05 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3ca40089-a5a6-55a5-7df3-5c019e62fbc2@amsat.org>
Date: Sun, 23 Jul 2017 11:29:39 -0300
MIME-Version: 1.0
In-Reply-To: <20170720150426.12393-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [RFC PATCH for 2.11 01/23] softfloat:
 move existing softfloat2a into versioned directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>, Alexander Graf <agraf@suse.de>, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, qemu-arm@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>, "open list:PowerPC" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Even if some people ever object to use SoftFloat3c and your series, this 
patch fits well for mainline.

On 07/20/2017 12:04 PM, Alex Bennée wrote:
> This is a precursor to importing SoftFloat3c into the QEMU source
> tree. As the two versions of SoftFloat present different APIs the hope
> is to selectively include the version 3 header when required. So for
> this change:
> 
>   - #include "fpu/softloat.h" -> #include "fpu/softfloat2a/softfloat.h"
>   - fpu/softfloat* -> fpu/softfloat2a/
> 
> This is all pretty mechanical and doesn't yet change any capabilities.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   Makefile.target                              | 2 +-
>   fpu/Makefile.objs                            | 1 +
>   fpu/{ => softfloat2a}/softfloat-macros.h     | 0
>   fpu/{ => softfloat2a}/softfloat-specialize.h | 0
>   fpu/{ => softfloat2a}/softfloat.c            | 2 +-
>   include/fpu/{ => softfloat2a}/softfloat.h    | 0
>   include/qemu/bswap.h                         | 2 +-
>   linux-user/arm/nwfpe/double_cpdo.c           | 2 +-
>   linux-user/arm/nwfpe/extended_cpdo.c         | 2 +-
>   linux-user/arm/nwfpe/fpa11.h                 | 2 +-
>   linux-user/arm/nwfpe/fpa11_cpdt.c            | 2 +-
>   linux-user/arm/nwfpe/fpa11_cprt.c            | 2 +-
>   linux-user/arm/nwfpe/fpopcode.c              | 2 +-
>   linux-user/arm/nwfpe/single_cpdo.c           | 2 +-
>   scripts/analyze-inclusions                   | 2 +-
>   target/alpha/cpu.h                           | 2 +-
>   target/alpha/fpu_helper.c                    | 2 +-
>   target/alpha/helper.c                        | 2 +-
>   target/alpha/vax_helper.c                    | 2 +-
>   target/arm/cpu.h                             | 2 +-
>   target/hppa/cpu.h                            | 2 +-
>   target/hppa/helper.c                         | 2 +-
>   target/i386/cpu.h                            | 2 +-
>   target/m68k/cpu.h                            | 2 +-
>   target/microblaze/cpu.h                      | 2 +-
>   target/mips/cpu.h                            | 2 +-
>   target/moxie/cpu.h                           | 2 +-
>   target/nios2/cpu.h                           | 2 +-
>   target/openrisc/cpu.h                        | 2 +-
>   target/ppc/cpu.h                             | 2 +-
>   target/s390x/cpu.h                           | 2 +-
>   target/sh4/cpu.h                             | 2 +-
>   target/sparc/cpu.h                           | 2 +-
>   target/tricore/cpu.h                         | 2 +-
>   target/unicore32/cpu.h                       | 2 +-
>   target/xtensa/cpu.h                          | 2 +-
>   36 files changed, 33 insertions(+), 32 deletions(-)
>   create mode 100644 fpu/Makefile.objs
>   rename fpu/{ => softfloat2a}/softfloat-macros.h (100%)
>   rename fpu/{ => softfloat2a}/softfloat-specialize.h (100%)
>   rename fpu/{ => softfloat2a}/softfloat.c (99%)
>   rename include/fpu/{ => softfloat2a}/softfloat.h (100%)
> 
> diff --git a/Makefile.target b/Makefile.target
> index 2baec9252f..0991847dbd 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -94,7 +94,7 @@ obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
>   obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/tcg-runtime.o
>   obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
>   obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
> -obj-y += fpu/softfloat.o
> +obj-y += fpu/
>   obj-y += target/$(TARGET_BASE_ARCH)/
>   obj-y += disas.o
>   obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
> diff --git a/fpu/Makefile.objs b/fpu/Makefile.objs
> new file mode 100644
> index 0000000000..938b4acbd0
> --- /dev/null
> +++ b/fpu/Makefile.objs
> @@ -0,0 +1 @@
> +obj-y = softfloat2a/softfloat.o
> diff --git a/fpu/softfloat-macros.h b/fpu/softfloat2a/softfloat-macros.h
> similarity index 100%
> rename from fpu/softfloat-macros.h
> rename to fpu/softfloat2a/softfloat-macros.h
> diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat2a/softfloat-specialize.h
> similarity index 100%
> rename from fpu/softfloat-specialize.h
> rename to fpu/softfloat2a/softfloat-specialize.h
> diff --git a/fpu/softfloat.c b/fpu/softfloat2a/softfloat.c
> similarity index 99%
> rename from fpu/softfloat.c
> rename to fpu/softfloat2a/softfloat.c
> index 433c5dad2d..59b9bc9e24 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat2a/softfloat.c
> @@ -84,7 +84,7 @@ this code that are retained.
>    */
>   #include "qemu/osdep.h"
>   
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   /* We only need stdlib for abort() */
>   
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat2a/softfloat.h
> similarity index 100%
> rename from include/fpu/softfloat.h
> rename to include/fpu/softfloat2a/softfloat.h
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 09c78fd28a..0f01edd356 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -1,7 +1,7 @@
>   #ifndef BSWAP_H
>   #define BSWAP_H
>   
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #ifdef CONFIG_MACHINE_BSWAP_H
>   # include <sys/endian.h>
> diff --git a/linux-user/arm/nwfpe/double_cpdo.c b/linux-user/arm/nwfpe/double_cpdo.c
> index 1cef380852..c4824bf4d8 100644
> --- a/linux-user/arm/nwfpe/double_cpdo.c
> +++ b/linux-user/arm/nwfpe/double_cpdo.c
> @@ -20,7 +20,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "fpa11.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   #include "fpopcode.h"
>   
>   float64 float64_exp(float64 Fm);
> diff --git a/linux-user/arm/nwfpe/extended_cpdo.c b/linux-user/arm/nwfpe/extended_cpdo.c
> index 1c8a412292..e2a262b9fe 100644
> --- a/linux-user/arm/nwfpe/extended_cpdo.c
> +++ b/linux-user/arm/nwfpe/extended_cpdo.c
> @@ -20,7 +20,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "fpa11.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   #include "fpopcode.h"
>   
>   floatx80 floatx80_exp(floatx80 Fm);
> diff --git a/linux-user/arm/nwfpe/fpa11.h b/linux-user/arm/nwfpe/fpa11.h
> index d459c5da02..d743a82492 100644
> --- a/linux-user/arm/nwfpe/fpa11.h
> +++ b/linux-user/arm/nwfpe/fpa11.h
> @@ -39,7 +39,7 @@ extern CPUARMState *user_registers;
>   
>   /* includes */
>   #include "fpsr.h"		/* FP control and status register definitions */
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #define		typeNone		0x00
>   #define		typeSingle		0x01
> diff --git a/linux-user/arm/nwfpe/fpa11_cpdt.c b/linux-user/arm/nwfpe/fpa11_cpdt.c
> index c32b0c2faa..3b5285d49d 100644
> --- a/linux-user/arm/nwfpe/fpa11_cpdt.c
> +++ b/linux-user/arm/nwfpe/fpa11_cpdt.c
> @@ -21,7 +21,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "fpa11.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   #include "fpopcode.h"
>   //#include "fpmodule.h"
>   //#include "fpmodule.inl"
> diff --git a/linux-user/arm/nwfpe/fpa11_cprt.c b/linux-user/arm/nwfpe/fpa11_cprt.c
> index 04dc2ebb02..f12fa1d593 100644
> --- a/linux-user/arm/nwfpe/fpa11_cprt.c
> +++ b/linux-user/arm/nwfpe/fpa11_cprt.c
> @@ -21,7 +21,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "fpa11.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   #include "fpopcode.h"
>   #include "fpa11.inl"
>   //#include "fpmodule.h"
> diff --git a/linux-user/arm/nwfpe/fpopcode.c b/linux-user/arm/nwfpe/fpopcode.c
> index 6784256d28..0aa603a935 100644
> --- a/linux-user/arm/nwfpe/fpopcode.c
> +++ b/linux-user/arm/nwfpe/fpopcode.c
> @@ -20,7 +20,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "fpa11.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   #include "fpopcode.h"
>   #include "fpsr.h"
>   //#include "fpmodule.h"
> diff --git a/linux-user/arm/nwfpe/single_cpdo.c b/linux-user/arm/nwfpe/single_cpdo.c
> index 21e177baeb..6a5421ac4b 100644
> --- a/linux-user/arm/nwfpe/single_cpdo.c
> +++ b/linux-user/arm/nwfpe/single_cpdo.c
> @@ -20,7 +20,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "fpa11.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   #include "fpopcode.h"
>   
>   float32 float32_exp(float32 Fm);
> diff --git a/scripts/analyze-inclusions b/scripts/analyze-inclusions
> index 14806e18c6..aa3fe087b2 100644
> --- a/scripts/analyze-inclusions
> +++ b/scripts/analyze-inclusions
> @@ -55,7 +55,7 @@ echo $(grep_include -F 'qapi/error.h') files include qapi/error.h
>   echo $(grep_include -F 'qom/object.h') files include qom/object.h
>   echo $(grep_include -F 'block/aio.h') files include block/aio.h
>   echo $(grep_include -F 'exec/memory.h') files include exec/memory.h
> -echo $(grep_include -F 'fpu/softfloat.h') files include fpu/softfloat.h
> +echo $(grep_include -F 'fpu/softfloat2a/softfloat.h') files include fpu/softfloat2a/softfloat.h
>   echo $(grep_include -F 'qemu/bswap.h') files include qemu/bswap.h
>   echo
>   
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index 691ac00c0b..c35da9a871 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -33,7 +33,7 @@
>   
>   #include "exec/cpu-defs.h"
>   
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #define ICACHE_LINE_SIZE 32
>   #define DCACHE_LINE_SIZE 32
> diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
> index 9645978aaa..6e4cba70d9 100644
> --- a/target/alpha/fpu_helper.c
> +++ b/target/alpha/fpu_helper.c
> @@ -21,7 +21,7 @@
>   #include "cpu.h"
>   #include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #define FP_STATUS (env->fp_status)
>   
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index a5c308859b..7ffbea5e72 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -21,7 +21,7 @@
>   
>   #include "cpu.h"
>   #include "exec/exec-all.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   #include "exec/helper-proto.h"
>   
>   
> diff --git a/target/alpha/vax_helper.c b/target/alpha/vax_helper.c
> index 2b0c178274..c3cf119740 100644
> --- a/target/alpha/vax_helper.c
> +++ b/target/alpha/vax_helper.c
> @@ -21,7 +21,7 @@
>   #include "cpu.h"
>   #include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #define FP_STATUS (env->fp_status)
>   
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 102c58afac..1f565fd503 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -39,7 +39,7 @@
>   #include "cpu-qom.h"
>   #include "exec/cpu-defs.h"
>   
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #define EXCP_UDEF            1   /* undefined instruction */
>   #define EXCP_SWI             2   /* software interrupt */
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index 4cf4ac65e3..6faab8df47 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -31,7 +31,7 @@
>   #define CPUArchState struct CPUHPPAState
>   
>   #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #define TARGET_PAGE_BITS 12
>   
> diff --git a/target/hppa/helper.c b/target/hppa/helper.c
> index ba04a9a52b..7ad874868f 100644
> --- a/target/hppa/helper.c
> +++ b/target/hppa/helper.c
> @@ -21,7 +21,7 @@
>   
>   #include "cpu.h"
>   #include "exec/exec-all.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   #include "exec/helper-proto.h"
>   
>   target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 7a228afd04..09953d8163 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -53,7 +53,7 @@
>   #include "exec/cpu-defs.h"
>   
>   #ifdef CONFIG_TCG
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   #endif
>   
>   #define R_EAX 0
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 38a7e11b92..605f4bc4d3 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -28,7 +28,7 @@
>   #include "qemu-common.h"
>   #include "exec/cpu-defs.h"
>   #include "cpu-qom.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #define OS_BYTE     0
>   #define OS_WORD     1
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 5ce4c82657..b3d4055b83 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -28,7 +28,7 @@
>   #define CPUArchState struct CPUMBState
>   
>   #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   struct CPUMBState;
>   typedef struct CPUMBState CPUMBState;
>   #if !defined(CONFIG_USER_ONLY)
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 4a4747af25..f48970b7cb 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -11,7 +11,7 @@
>   #include "cpu-qom.h"
>   #include "mips-defs.h"
>   #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   struct CPUMIPSState;
>   
> diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
> index 8991aaef9a..4705aaaf85 100644
> --- a/target/moxie/cpu.h
> +++ b/target/moxie/cpu.h
> @@ -34,7 +34,7 @@
>   #define MOXIE_EX_BREAK      16
>   
>   #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #define TARGET_PAGE_BITS 12     /* 4k */
>   
> diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
> index 13931f3f0b..a41a52f752 100644
> --- a/target/nios2/cpu.h
> +++ b/target/nios2/cpu.h
> @@ -28,7 +28,7 @@
>   #define CPUArchState struct CPUNios2State
>   
>   #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   #include "qom/cpu.h"
>   struct CPUNios2State;
>   typedef struct CPUNios2State CPUNios2State;
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index 2721432c4f..95d6d2d2cd 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -29,7 +29,7 @@ struct OpenRISCCPU;
>   
>   #include "qemu-common.h"
>   #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   #include "qom/cpu.h"
>   
>   #define TYPE_OPENRISC_CPU "or1k-cpu"
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 6ee2a26a96..f73598b19f 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -79,7 +79,7 @@
>   
>   #include "exec/cpu-defs.h"
>   #include "cpu-qom.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #if defined (TARGET_PPC64)
>   #define PPC_ELF_MACHINE     EM_PPC64
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 7732d01784..ab7de63c9a 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -40,7 +40,7 @@
>   
>   #include "exec/cpu-all.h"
>   
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #define NB_MMU_MODES 3
>   #define TARGET_INSN_START_EXTRA_WORDS 1
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index ffb91687b8..d1445f26e8 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -40,7 +40,7 @@
>   
>   #include "exec/cpu-defs.h"
>   
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #define TARGET_PAGE_BITS 12	/* 4k XXXXX */
>   
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 95a36a4bdc..28fa4cd4ba 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -29,7 +29,7 @@
>   
>   #include "exec/cpu-defs.h"
>   
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   /*#define EXCP_INTERRUPT 0x100*/
>   
> diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
> index a3493a123c..f79f86b858 100644
> --- a/target/tricore/cpu.h
> +++ b/target/tricore/cpu.h
> @@ -24,7 +24,7 @@
>   #include "qemu-common.h"
>   #include "cpu-qom.h"
>   #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #define CPUArchState struct CPUTriCoreState
>   
> diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
> index 7b5b405e79..4df9bf8c45 100644
> --- a/target/unicore32/cpu.h
> +++ b/target/unicore32/cpu.h
> @@ -23,7 +23,7 @@
>   #include "qemu-common.h"
>   #include "cpu-qom.h"
>   #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #define NB_MMU_MODES            2
>   
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index ee29fb1a14..d84bd86b0e 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -36,7 +36,7 @@
>   #include "qemu-common.h"
>   #include "cpu-qom.h"
>   #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat2a/softfloat.h"
>   
>   #define NB_MMU_MODES 4
>   
> 
