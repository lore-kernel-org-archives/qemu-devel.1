Received: from eggs.gnu.org ([2001:4830:134:3::10]:34784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eeTHi-0004P7-IP
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 17:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eeTHf-000124-MG
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 17:12:46 -0500
Date: Thu, 25 Jan 2018 09:12:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180124221223.GC14832@umbus>
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <20180124131315.30567-5-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 04/22] target/*/cpu.h: remove softfloat.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 01:12:57PM +0000, Alex Benn=E9e wrote:
> As cpu.h is another typically widely included file which doesn't need
> full access to the softfloat API we can remove the includes from here
> as well. Where they do need types it's typically for float_status and
> the rounding modes so we move that to softfloat-types.h as well.
>=20
> As a result of not having softfloat in every cpu.h call we now need to
> add it to various helpers that do need the full softfloat.h
> definitions.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

ppc part

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/fpu/softfloat-types.h   | 64 +++++++++++++++++++++++++++++++++++=
++++++
>  include/fpu/softfloat.h         | 53 ----------------------------------
>  target/alpha/cpu.h              |  2 --
>  target/arm/cpu.c                |  1 +
>  target/arm/cpu.h                |  2 --
>  target/arm/helper-a64.c         |  1 +
>  target/arm/helper.c             |  1 +
>  target/arm/neon_helper.c        |  1 +
>  target/hppa/cpu.c               |  1 +
>  target/hppa/cpu.h               |  1 -
>  target/hppa/op_helper.c         |  1 +
>  target/i386/cpu.h               |  4 ---
>  target/i386/fpu_helper.c        |  1 +
>  target/m68k/cpu.c               |  2 +-
>  target/m68k/cpu.h               |  1 -
>  target/m68k/fpu_helper.c        |  1 +
>  target/m68k/helper.c            |  1 +
>  target/m68k/translate.c         |  2 ++
>  target/microblaze/cpu.c         |  1 +
>  target/microblaze/cpu.h         |  2 +-
>  target/microblaze/op_helper.c   |  1 +
>  target/moxie/cpu.h              |  1 -
>  target/nios2/cpu.h              |  1 -
>  target/openrisc/cpu.h           |  1 -
>  target/openrisc/fpu_helper.c    |  1 +
>  target/ppc/cpu.h                |  1 -
>  target/ppc/fpu_helper.c         |  1 +
>  target/ppc/int_helper.c         |  1 +
>  target/ppc/translate_init.c     |  1 +
>  target/s390x/cpu.c              |  1 +
>  target/s390x/cpu.h              |  2 --
>  target/s390x/fpu_helper.c       |  1 +
>  target/sh4/cpu.c                |  1 +
>  target/sh4/cpu.h                |  2 --
>  target/sh4/op_helper.c          |  1 +
>  target/sparc/cpu.h              |  2 --
>  target/sparc/fop_helper.c       |  1 +
>  target/tricore/cpu.h            |  1 -
>  target/tricore/fpu_helper.c     |  1 +
>  target/tricore/helper.c         |  1 +
>  target/unicore32/cpu.c          |  1 +
>  target/unicore32/cpu.h          |  1 -
>  target/unicore32/ucf64_helper.c |  1 +
>  target/xtensa/cpu.h             |  1 -
>  target/xtensa/op_helper.c       |  1 +
>  45 files changed, 93 insertions(+), 78 deletions(-)
>=20
> diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
> index 8210a94ea1..4e378cb612 100644
> --- a/include/fpu/softfloat-types.h
> +++ b/include/fpu/softfloat-types.h
> @@ -80,6 +80,12 @@ this code that are retained.
>  #ifndef SOFTFLOAT_TYPES_H
>  #define SOFTFLOAT_TYPES_H
> =20
> +/* This 'flag' type must be able to hold at least 0 and 1. It should
> + * probably be replaced with 'bool' but the uses would need to be audited
> + * to check that they weren't accidentally relying on it being a larger =
type.
> + */
> +typedef uint8_t flag;
> +
>  /*
>   * Software IEC/IEEE floating-point types.
>   */
> @@ -112,4 +118,62 @@ typedef struct {
>  #define make_float128(high_, low_) ((float128) { .high =3D high_, .low =
=3D low_ })
>  #define make_float128_init(high_, low_) { .high =3D high_, .low =3D low_=
 }
> =20
> +/*
> + * Software IEC/IEEE floating-point underflow tininess-detection mode.
> + */
> +
> +enum {
> +    float_tininess_after_rounding  =3D 0,
> +    float_tininess_before_rounding =3D 1
> +};
> +
> +/*
> + *Software IEC/IEEE floating-point rounding mode.
> + */
> +
> +enum {
> +    float_round_nearest_even =3D 0,
> +    float_round_down         =3D 1,
> +    float_round_up           =3D 2,
> +    float_round_to_zero      =3D 3,
> +    float_round_ties_away    =3D 4,
> +    /* Not an IEEE rounding mode: round to the closest odd mantissa valu=
e */
> +    float_round_to_odd       =3D 5,
> +};
> +
> +/*
> + * Software IEC/IEEE floating-point exception flags.
> + */
> +
> +enum {
> +    float_flag_invalid   =3D  1,
> +    float_flag_divbyzero =3D  4,
> +    float_flag_overflow  =3D  8,
> +    float_flag_underflow =3D 16,
> +    float_flag_inexact   =3D 32,
> +    float_flag_input_denormal =3D 64,
> +    float_flag_output_denormal =3D 128
> +};
> +
> +
> +/*
> + * Floating Point Status. Individual architectures may maintain
> + * several versions of float_status for different functions. The
> + * correct status for the operation is then passed by reference to
> + * most of the softfloat functions.
> + */
> +
> +typedef struct float_status {
> +    signed char float_detect_tininess;
> +    signed char float_rounding_mode;
> +    uint8_t     float_exception_flags;
> +    signed char floatx80_rounding_precision;
> +    /* should denormalised results go to zero and set the inexact flag? =
*/
> +    flag flush_to_zero;
> +    /* should denormalised inputs go to zero and set the input_denormal =
flag? */
> +    flag flush_inputs_to_zero;
> +    flag default_nan_mode;
> +    flag snan_bit_is_one;
> +} float_status;
> +
>  #endif /* SOFTFLOAT_TYPES_H */
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 4e16e22e58..f3b9008f78 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -82,12 +82,6 @@ this code that are retained.
>  #ifndef SOFTFLOAT_H
>  #define SOFTFLOAT_H
> =20
> -/* This 'flag' type must be able to hold at least 0 and 1. It should
> - * probably be replaced with 'bool' but the uses would need to be audited
> - * to check that they weren't accidentally relying on it being a larger =
type.
> - */
> -typedef uint8_t flag;
> -
>  #define LIT64( a ) a##LL
> =20
>  /*----------------------------------------------------------------------=
------
> @@ -102,53 +96,6 @@ enum {
> =20
>  #include "fpu/softfloat-types.h"
> =20
> -/*----------------------------------------------------------------------=
------
> -| Software IEC/IEEE floating-point underflow tininess-detection mode.
> -*-----------------------------------------------------------------------=
-----*/
> -enum {
> -    float_tininess_after_rounding  =3D 0,
> -    float_tininess_before_rounding =3D 1
> -};
> -
> -/*----------------------------------------------------------------------=
------
> -| Software IEC/IEEE floating-point rounding mode.
> -*-----------------------------------------------------------------------=
-----*/
> -enum {
> -    float_round_nearest_even =3D 0,
> -    float_round_down         =3D 1,
> -    float_round_up           =3D 2,
> -    float_round_to_zero      =3D 3,
> -    float_round_ties_away    =3D 4,
> -    /* Not an IEEE rounding mode: round to the closest odd mantissa valu=
e */
> -    float_round_to_odd       =3D 5,
> -};
> -
> -/*----------------------------------------------------------------------=
------
> -| Software IEC/IEEE floating-point exception flags.
> -*-----------------------------------------------------------------------=
-----*/
> -enum {
> -    float_flag_invalid   =3D  1,
> -    float_flag_divbyzero =3D  4,
> -    float_flag_overflow  =3D  8,
> -    float_flag_underflow =3D 16,
> -    float_flag_inexact   =3D 32,
> -    float_flag_input_denormal =3D 64,
> -    float_flag_output_denormal =3D 128
> -};
> -
> -typedef struct float_status {
> -    signed char float_detect_tininess;
> -    signed char float_rounding_mode;
> -    uint8_t     float_exception_flags;
> -    signed char floatx80_rounding_precision;
> -    /* should denormalised results go to zero and set the inexact flag? =
*/
> -    flag flush_to_zero;
> -    /* should denormalised inputs go to zero and set the input_denormal =
flag? */
> -    flag flush_inputs_to_zero;
> -    flag default_nan_mode;
> -    flag snan_bit_is_one;
> -} float_status;
> -
>  static inline void set_float_detect_tininess(int val, float_status *stat=
us)
>  {
>      status->float_detect_tininess =3D val;
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index 0a9ad35f06..fcb380b769 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -33,8 +33,6 @@
> =20
>  #include "exec/cpu-defs.h"
> =20
> -#include "fpu/softfloat.h"
> -
>  #define ICACHE_LINE_SIZE 32
>  #define DCACHE_LINE_SIZE 32
> =20
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index cc1856c32b..34a7d5631e 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -34,6 +34,7 @@
>  #include "sysemu/hw_accel.h"
>  #include "kvm_arm.h"
>  #include "disas/capstone.h"
> +#include "fpu/softfloat.h"
> =20
>  static void arm_cpu_set_pc(CPUState *cs, vaddr value)
>  {
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 96316700dd..62186e2025 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -39,8 +39,6 @@
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
> =20
> -#include "fpu/softfloat.h"
> -
>  #define EXCP_UDEF            1   /* undefined instruction */
>  #define EXCP_SWI             2   /* software interrupt */
>  #define EXCP_PREFETCH_ABORT  3
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index 3e00a9ead1..320a7d220e 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -31,6 +31,7 @@
>  #include "exec/cpu_ldst.h"
>  #include "qemu/int128.h"
>  #include "tcg.h"
> +#include "fpu/softfloat.h"
>  #include <zlib.h> /* For crc32 */
> =20
>  /* C2.4.7 Multiply and divide */
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c83c901a86..6ae7aae96b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -15,6 +15,7 @@
>  #include <zlib.h> /* For crc32 */
>  #include "exec/semihost.h"
>  #include "sysemu/kvm.h"
> +#include "fpu/softfloat.h"
> =20
>  #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable =
*/
> =20
> diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
> index ebdf7c9b10..2a4592c041 100644
> --- a/target/arm/neon_helper.c
> +++ b/target/arm/neon_helper.c
> @@ -11,6 +11,7 @@
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
> +#include "fpu/softfloat.h"
> =20
>  #define SIGNBIT (uint32_t)0x80000000
>  #define SIGNBIT64 ((uint64_t)1 << 63)
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 9e7b0d4ccb..83db1e0bf9 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -23,6 +23,7 @@
>  #include "cpu.h"
>  #include "qemu-common.h"
>  #include "exec/exec-all.h"
> +#include "fpu/softfloat.h"
> =20
> =20
>  static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index 8d14077763..10523711da 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -31,7 +31,6 @@
>  #define CPUArchState struct CPUHPPAState
> =20
>  #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> =20
>  #define TARGET_PAGE_BITS 12
> =20
> diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
> index 3104404e8d..1542d7c172 100644
> --- a/target/hppa/op_helper.c
> +++ b/target/hppa/op_helper.c
> @@ -22,6 +22,7 @@
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
>  #include "exec/cpu_ldst.h"
> +#include "fpu/softfloat.h"
> =20
>  void QEMU_NORETURN HELPER(excp)(CPUHPPAState *env, int excp)
>  {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 30cc5628d2..65298f5f30 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -52,10 +52,6 @@
> =20
>  #define CPUArchState struct CPUX86State
> =20
> -#ifdef CONFIG_TCG
> -#include "fpu/softfloat.h"
> -#endif
> -
>  enum {
>      R_EAX =3D 0,
>      R_ECX =3D 1,
> diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
> index 9014b6f88a..ea5a0c4861 100644
> --- a/target/i386/fpu_helper.c
> +++ b/target/i386/fpu_helper.c
> @@ -24,6 +24,7 @@
>  #include "qemu/host-utils.h"
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
> +#include "fpu/softfloat.h"
> =20
>  #define FPU_RC_MASK         0xc00
>  #define FPU_RC_NEAR         0x000
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 03126ba543..71b9929971 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -24,7 +24,7 @@
>  #include "qemu-common.h"
>  #include "migration/vmstate.h"
>  #include "exec/exec-all.h"
> -
> +#include "fpu/softfloat.h"
> =20
>  static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
>  {
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 2985b039e1..1f650542dd 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -28,7 +28,6 @@
>  #include "qemu-common.h"
>  #include "exec/cpu-defs.h"
>  #include "cpu-qom.h"
> -#include "fpu/softfloat.h"
> =20
>  #define OS_BYTE     0
>  #define OS_WORD     1
> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
> index 665e7609af..3c5a82aaa0 100644
> --- a/target/m68k/fpu_helper.c
> +++ b/target/m68k/fpu_helper.c
> @@ -23,6 +23,7 @@
>  #include "exec/helper-proto.h"
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
> +#include "fpu/softfloat.h"
> =20
>  /* Undefined offsets may be different on various FPU.
>   * On 68040 they return 0.0 (floatx80_zero)
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index a999389e9a..70550a23ca 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -24,6 +24,7 @@
>  #include "exec/gdbstub.h"
> =20
>  #include "exec/helper-proto.h"
> +#include "fpu/softfloat.h"
> =20
>  #define SIGNBIT (1u << 31)
> =20
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index f0e86a73d4..533a7e3a5d 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -32,6 +32,8 @@
> =20
>  #include "trace-tcg.h"
>  #include "exec/log.h"
> +#include "fpu/softfloat.h"
> +
> =20
>  //#define DEBUG_DISPATCH 1
> =20
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 5700652e06..393520f3ef 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -28,6 +28,7 @@
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
>  #include "exec/exec-all.h"
> +#include "fpu/softfloat.h"
> =20
>  static const struct {
>      const char *name;
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 52b6b6aec7..b3e41f781b 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -28,7 +28,7 @@
>  #define CPUArchState struct CPUMBState
> =20
>  #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat-types.h"
>  struct CPUMBState;
>  typedef struct CPUMBState CPUMBState;
>  #if !defined(CONFIG_USER_ONLY)
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index 4cf51568df..2567bf4031 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -24,6 +24,7 @@
>  #include "qemu/host-utils.h"
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
> +#include "fpu/softfloat.h"
> =20
>  #define D(x)
> =20
> diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
> index d37e6a5572..3c60c3e435 100644
> --- a/target/moxie/cpu.h
> +++ b/target/moxie/cpu.h
> @@ -34,7 +34,6 @@
>  #define MOXIE_EX_BREAK      16
> =20
>  #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> =20
>  #define TARGET_PAGE_BITS 12     /* 4k */
> =20
> diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
> index 88823a6d4d..1443b226fb 100644
> --- a/target/nios2/cpu.h
> +++ b/target/nios2/cpu.h
> @@ -27,7 +27,6 @@
>  #define CPUArchState struct CPUNios2State
> =20
>  #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
>  #include "qom/cpu.h"
>  struct CPUNios2State;
>  typedef struct CPUNios2State CPUNios2State;
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index cc22dc8871..3256f7b6ef 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -29,7 +29,6 @@ struct OpenRISCCPU;
> =20
>  #include "qemu-common.h"
>  #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
>  #include "qom/cpu.h"
> =20
>  #define TYPE_OPENRISC_CPU "or1k-cpu"
> diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
> index 1375cea948..977a1e8e55 100644
> --- a/target/openrisc/fpu_helper.c
> +++ b/target/openrisc/fpu_helper.c
> @@ -22,6 +22,7 @@
>  #include "cpu.h"
>  #include "exec/helper-proto.h"
>  #include "exception.h"
> +#include "fpu/softfloat.h"
> =20
>  static inline uint32_t ieee_ex_to_openrisc(OpenRISCCPU *cpu, int fexcp)
>  {
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 603a38cae8..43fbe7d7cf 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -79,7 +79,6 @@
> =20
>  #include "exec/cpu-defs.h"
>  #include "cpu-qom.h"
> -#include "fpu/softfloat.h"
> =20
>  #if defined (TARGET_PPC64)
>  #define PPC_ELF_MACHINE     EM_PPC64
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index c4dab159e4..9ae418a577 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -21,6 +21,7 @@
>  #include "exec/helper-proto.h"
>  #include "exec/exec-all.h"
>  #include "internal.h"
> +#include "fpu/softfloat.h"
> =20
>  static inline float128 float128_snan_to_qnan(float128 x)
>  {
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 3a50f1e1b7..35bdf09773 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -23,6 +23,7 @@
>  #include "qemu/host-utils.h"
>  #include "exec/helper-proto.h"
>  #include "crypto/aes.h"
> +#include "fpu/softfloat.h"
> =20
>  #include "helper_regs.h"
>  /***********************************************************************=
******/
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 55c99c97e3..54ec2e122a 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -36,6 +36,7 @@
>  #include "sysemu/qtest.h"
>  #include "qemu/cutils.h"
>  #include "disas/capstone.h"
> +#include "fpu/softfloat.h"
> =20
>  //#define PPC_DUMP_CPU
>  //#define PPC_DEBUG_SPR
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index ae3cee91a2..c6670850dd 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -42,6 +42,7 @@
>  #include "sysemu/arch_init.h"
>  #include "sysemu/sysemu.h"
>  #endif
> +#include "fpu/softfloat.h"
> =20
>  #define CR0_RESET       0xE0UL
>  #define CR14_RESET      0xC2000000UL;
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 1a8b6b9ae9..072dd1597f 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -41,8 +41,6 @@
> =20
>  #include "exec/cpu-all.h"
> =20
> -#include "fpu/softfloat.h"
> -
>  #define NB_MMU_MODES 4
>  #define TARGET_INSN_START_EXTRA_WORDS 1
> =20
> diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
> index 334159119f..43f8bf1c94 100644
> --- a/target/s390x/fpu_helper.c
> +++ b/target/s390x/fpu_helper.c
> @@ -24,6 +24,7 @@
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
>  #include "exec/helper-proto.h"
> +#include "fpu/softfloat.h"
> =20
>  /* #define DEBUG_HELPER */
>  #ifdef DEBUG_HELPER
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index e0b99fbc89..4f8c830fe3 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -25,6 +25,7 @@
>  #include "qemu-common.h"
>  #include "migration/vmstate.h"
>  #include "exec/exec-all.h"
> +#include "fpu/softfloat.h"
> =20
> =20
>  static void superh_cpu_set_pc(CPUState *cs, vaddr value)
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index a2c26e0597..d8edab6997 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -40,8 +40,6 @@
> =20
>  #include "exec/cpu-defs.h"
> =20
> -#include "fpu/softfloat.h"
> -
>  #define TARGET_PAGE_BITS 12	/* 4k XXXXX */
> =20
>  #define TARGET_PHYS_ADDR_SPACE_BITS 32
> diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
> index d798f239cf..a8c71a6988 100644
> --- a/target/sh4/op_helper.c
> +++ b/target/sh4/op_helper.c
> @@ -21,6 +21,7 @@
>  #include "exec/helper-proto.h"
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
> +#include "fpu/softfloat.h"
> =20
>  #ifndef CONFIG_USER_ONLY
> =20
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 9fde547fac..f9d5469697 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -29,8 +29,6 @@
> =20
>  #include "exec/cpu-defs.h"
> =20
> -#include "fpu/softfloat.h"
> -
>  /*#define EXCP_INTERRUPT 0x100*/
> =20
>  /* trap definitions */
> diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
> index c7fb176e4c..b6642fd1d7 100644
> --- a/target/sparc/fop_helper.c
> +++ b/target/sparc/fop_helper.c
> @@ -21,6 +21,7 @@
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
> +#include "fpu/softfloat.h"
> =20
>  #define QT0 (env->qt0)
>  #define QT1 (env->qt1)
> diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
> index f41d2ceb69..e7dfe4bcc6 100644
> --- a/target/tricore/cpu.h
> +++ b/target/tricore/cpu.h
> @@ -24,7 +24,6 @@
>  #include "qemu-common.h"
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> =20
>  #define CPUArchState struct CPUTriCoreState
> =20
> diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
> index 7979bb6692..df162902d6 100644
> --- a/target/tricore/fpu_helper.c
> +++ b/target/tricore/fpu_helper.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "exec/helper-proto.h"
> +#include "fpu/softfloat.h"
> =20
>  #define QUIET_NAN 0x7fc00000
>  #define ADD_NAN   0x7fc00001
> diff --git a/target/tricore/helper.c b/target/tricore/helper.c
> index 378c2a4a76..45276d3782 100644
> --- a/target/tricore/helper.c
> +++ b/target/tricore/helper.c
> @@ -19,6 +19,7 @@
> =20
>  #include "cpu.h"
>  #include "exec/exec-all.h"
> +#include "fpu/softfloat.h"
> =20
>  enum {
>      TLBRET_DIRTY =3D -4,
> diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
> index 17dc1504d7..93cbae39d9 100644
> --- a/target/unicore32/cpu.c
> +++ b/target/unicore32/cpu.c
> @@ -18,6 +18,7 @@
>  #include "qemu-common.h"
>  #include "migration/vmstate.h"
>  #include "exec/exec-all.h"
> +#include "fpu/softfloat.h"
> =20
>  static void uc32_cpu_set_pc(CPUState *cs, vaddr value)
>  {
> diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
> index 3dc6fbc6c7..061aaa9fb4 100644
> --- a/target/unicore32/cpu.h
> +++ b/target/unicore32/cpu.h
> @@ -23,7 +23,6 @@
>  #include "qemu-common.h"
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> =20
>  #define NB_MMU_MODES            2
> =20
> diff --git a/target/unicore32/ucf64_helper.c b/target/unicore32/ucf64_hel=
per.c
> index 6c919010c3..fad3fa6618 100644
> --- a/target/unicore32/ucf64_helper.c
> +++ b/target/unicore32/ucf64_helper.c
> @@ -11,6 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "exec/helper-proto.h"
> +#include "fpu/softfloat.h"
> =20
>  /*
>   * The convention used for UniCore-F64 instructions:
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index d9404aa50a..25655a4a07 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -36,7 +36,6 @@
>  #include "qemu-common.h"
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
>  #include "xtensa-isa.h"
> =20
>  #define NB_MMU_MODES 4
> diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
> index 012552817f..435b53a4b2 100644
> --- a/target/xtensa/op_helper.c
> +++ b/target/xtensa/op_helper.c
> @@ -34,6 +34,7 @@
>  #include "exec/cpu_ldst.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/timer.h"
> +#include "fpu/softfloat.h"
> =20
>  void xtensa_cpu_do_unaligned_access(CPUState *cs,
>          vaddr addr, MMUAccessType access_type,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlppBMQACgkQbDjKyiDZ
s5L3Jg//YVgLl9fC8JG3Y09A+Xsa2jE79ygWnfoCMIJtgp/3o8lpw3KrB/1ORICT
0dmYc+piMw8H1aSadcTOrxvT9z2PPErlSALWec6d23s3ICFSaSt0l27NNY3gxu/q
X0ri+FCyJOseQQ5uRa2l1cVSmSoY9Nt3axCHqv0inHo5Oo45TUJGuVl+tWW29OyO
I3xpqDjw6Zai/4EIffsYniLVJGLAM5hxXzT5H5ErkMCt++0js/tCsFWrmKDCpCnb
dEEsDA8T5S55MQTAhPtvc0Rm9sKGJ+n5+7DnM9kQk5NH0nCHsbyNRJyE9gKITv49
8iIuJ/1xynIzCdPA4rtqT7ROFD8ciUaUQcca4WNj9GfBWaYiEsu26J2RNI5SMya7
rHSd17oJBCVBQmsZu7wlesDGaRXYKGKbCFLrsFxqoPpRM8kfspuemb0mGUS2El2z
wESnnInBO0C/1cz5xtUPuIO6b7OXE58IqQmGd/n2MUrFtNWgm0wk2TQsCHDabmgP
tXKsBVAjmVZxcBvslHtMWjTS39kQ/u4l+1Aw6Xm5b31llYzd+gu3ttJ/SzVc4vgn
42Q8cgREj1EXbAcf26VcOjQ9nSJ8yskNF/pco+3HXgwfb4PojO1DtENxa0HB/vGg
rP2LMXDpw/AvI3+zUPIOHGfS76/PDYimGcvcoBEUdnKhxTAyMOQ=
=FaqR
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
