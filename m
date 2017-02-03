Received: from eggs.gnu.org ([2001:4830:134:3::10]:36806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZbtn-0000K1-EA
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:19:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZbtm-0006PP-H6
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:19:27 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZbtm-0006OP-Ar
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:19:26 -0500
Received: by mail-wm0-x231.google.com with SMTP id c85so23645898wmi.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 03:19:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170201150553.9381-23-alex.bennee@linaro.org>
References: <20170201150553.9381-1-alex.bennee@linaro.org>
	<20170201150553.9381-23-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 11:19:04 +0000
Message-ID: <CAFEAcA9JqYs06T5QdP8jADFNJsuDQfY_xWWJqJkMm1Zar=wOmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 22/25] target-arm/cpu.h: make ARM_CP
 defined consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 1 February 2017 at 15:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> This is a purely mechanical change to make the ARM_CP flags neatly
> align and use a consistent format so it is easier to see which bit
> each flag is.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/cpu.h | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 39bff86daf..d61793ca06 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1452,20 +1452,20 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t c=
pregid)
>   * need to be surrounded by gen_io_start()/gen_io_end(). In particular,
>   * registers which implement clocks or timers require this.
>   */
> -#define ARM_CP_SPECIAL 1
> -#define ARM_CP_CONST 2
> -#define ARM_CP_64BIT 4
> -#define ARM_CP_SUPPRESS_TB_END 8
> -#define ARM_CP_OVERRIDE 16
> -#define ARM_CP_ALIAS 32
> -#define ARM_CP_IO 64
> -#define ARM_CP_NO_RAW 128
> -#define ARM_CP_NOP (ARM_CP_SPECIAL | (1 << 8))
> -#define ARM_CP_WFI (ARM_CP_SPECIAL | (2 << 8))
> -#define ARM_CP_NZCV (ARM_CP_SPECIAL | (3 << 8))
> -#define ARM_CP_CURRENTEL (ARM_CP_SPECIAL | (4 << 8))
> -#define ARM_CP_DC_ZVA (ARM_CP_SPECIAL | (5 << 8))
> -#define ARM_LAST_SPECIAL ARM_CP_DC_ZVA
> +#define ARM_CP_SPECIAL         (1 << 0)
> +#define ARM_CP_CONST           (1 << 1)
> +#define ARM_CP_64BIT           (1 << 2)
> +#define ARM_CP_SUPPRESS_TB_END (1 << 3)
> +#define ARM_CP_OVERRIDE        (1 << 4)
> +#define ARM_CP_ALIAS           (1 << 5)
> +#define ARM_CP_IO              (1 << 6)
> +#define ARM_CP_NO_RAW          (1 << 7)
> +#define ARM_CP_NOP             (ARM_CP_SPECIAL | (1 << 8))
> +#define ARM_CP_WFI             (ARM_CP_SPECIAL | (2 << 8))
> +#define ARM_CP_NZCV            (ARM_CP_SPECIAL | (3 << 8))
> +#define ARM_CP_CURRENTEL       (ARM_CP_SPECIAL | (4 << 8))
> +#define ARM_CP_DC_ZVA          (ARM_CP_SPECIAL | (5 << 8))
> +#define ARM_LAST_SPECIAL       ARM_CP_DC_ZVA
>  /* Used only as a terminator for ARMCPRegInfo lists */
>  #define ARM_CP_SENTINEL 0xffff
>  /* Mask of only the flag bits in a type field */

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
