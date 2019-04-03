Received: from eggs.gnu.org ([209.51.188.92]:33026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBgZN-0005jk-Bv
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBgZM-0002qT-3S
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:08:49 -0400
Received: from mail-eopbgr710109.outbound.protection.outlook.com
	([40.107.71.109]:54848
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hBgZL-0002nj-Q0
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:08:48 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 3 Apr 2019 14:08:44 +0000
Message-ID: <BN6PR2201MB1251B10567257E3C695F3AF7C6570@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190403125055.26564-1-jbi.octave@gmail.com>,
	<20190403125055.26564-3-jbi.octave@gmail.com>
In-Reply-To: <20190403125055.26564-3-jbi.octave@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/5] target/mips: realign comments to fix
 checkpatch warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jules Irenge <jbi.octave@gmail.com>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Jules Irenge <jbi.octave@gmail.com>
> Subject: [PATCH 2/5] target/mips: realign comments to fix checkpatch warn=
ings
>=20
> Realign comments to fix warnings issued by checkpatch.pl tool
> "WARNING: Block comments use a leading /* on a separate line"
>  within "target/mips/cpu.h" file.
>=20
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  target/mips/cpu.h | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>=20
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 2429fe80ac..bfa595c8a9 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -37,7 +37,8 @@ union fpr_t {
>  /* FPU/MSA register mapping is not tested on big-endian hosts. */
>      wr_t     wr;   /* vector data */
>  };
> -/* define FP_ENDIAN_IDX to access the same location
> +/*
> + * define FP_ENDIAN_IDX to access the same location
>   * in the fpr_t union regardless of the host endianness
>   */
>  #if defined(HOST_WORDS_BIGENDIAN)
> @@ -963,9 +964,11 @@ struct CPUMIPSState {
>      /* TMASK defines different execution modes */
>  #define MIPS_HFLAG_TMASK  0x1F5807FF
>  #define MIPS_HFLAG_MODE   0x00007 /* execution modes                    =
*/
> -    /* The KSU flags must be the lowest bits in hflags. The flag order
> -       must be the same as defined for CP0 Status. This allows to use
> -       the bits as the value of mmu_idx. */
> +    /*
> +     * The KSU flags must be the lowest bits in hflags. The flag order
> +     * must be the same as defined for CP0 Status. This allows to use
> +     * the bits as the value of mmu_idx.
> +     */
>  #define MIPS_HFLAG_KSU    0x00003 /* kernel/supervisor/user mode mask   =
*/
>  #define MIPS_HFLAG_UM     0x00002 /* user mode flag                     =
*/
>  #define MIPS_HFLAG_SM     0x00001 /* supervisor mode flag               =
*/
> @@ -975,18 +978,22 @@ struct CPUMIPSState {
>  #define MIPS_HFLAG_CP0    0x00010 /* CP0 enabled                        =
*/
>  #define MIPS_HFLAG_FPU    0x00020 /* FPU enabled                        =
*/
>  #define MIPS_HFLAG_F64    0x00040 /* 64-bit FPU enabled                 =
*/
> -    /* True if the MIPS IV COP1X instructions can be used.  This also
> -       controls the non-COP1X instructions RECIP.S, RECIP.D, RSQRT.S
> -       and RSQRT.D.  */
> +    /*
> +     * True if the MIPS IV COP1X instructions can be used.  This also
> +     * controls the non-COP1X instructions RECIP.S, RECIP.D, RSQRT.S
> +     * and RSQRT.D.
> +     */
>  #define MIPS_HFLAG_COP1X  0x00080 /* COP1X instructions enabled         =
*/
>  #define MIPS_HFLAG_RE     0x00100 /* Reversed endianness                =
*/
>  #define MIPS_HFLAG_AWRAP  0x00200 /* 32-bit compatibility address wrappi=
ng */
>  #define MIPS_HFLAG_M16    0x00400 /* MIPS16 mode flag                   =
*/
>  #define MIPS_HFLAG_M16_SHIFT 10
> -    /* If translation is interrupted between the branch instruction and
> +    /*
> +     * If translation is interrupted between the branch instruction and
>       * the delay slot, record what type of branch it is so that we can
>       * resume translation properly.  It might be possible to reduce
> -     * this from three bits to two.  */
> +     * this from three bits to two. =20

The last line contains two trailing spaces. Just delete them.

> +     */
>  #define MIPS_HFLAG_BMASK_BASE  0x803800
>  #define MIPS_HFLAG_B      0x00800 /* Unconditional branch               =
*/
>  #define MIPS_HFLAG_BC     0x01000 /* Conditional branch                 =
*/
> @@ -1073,8 +1080,10 @@ void mips_cpu_list (FILE *f, fprintf_function cpu_=
fprintf);
>  extern void cpu_wrdsp(uint32_t rs, uint32_t mask_num, CPUMIPSState *env)=
;
>  extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
>=20
> -/* MMU modes definitions. We carefully match the indices with our
> -   hflags layout. */
> +/*
> + * MMU modes definitions. We carefully match the indices with our
> + * hflags layout.
> + */
>  #define MMU_MODE0_SUFFIX _kernel
>  #define MMU_MODE1_SUFFIX _super
>  #define MMU_MODE2_SUFFIX _user
> @@ -1097,7 +1106,8 @@ static inline int cpu_mmu_index (CPUMIPSState *env,=
 bool ifetch)
>=20
>  #include "exec/cpu-all.h"
>=20
> -/* Memory access type :
> +/*=20

The last line contains a trailing space. Just remove it.

> + * Memory access type :
>   * may be needed for precise access rights control and precise exception=
s.
>   */
>  enum {
> --
> 2.20.1
>=20
>=20

Thanks,
Aleksandar=
