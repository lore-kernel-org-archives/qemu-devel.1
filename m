Received: from eggs.gnu.org ([2001:4830:134:3::10]:45998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d43C9-0000pZ-TV
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d43C5-0004Z2-Nt
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:32:13 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d43C5-0004Xg-Cw
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:32:09 -0400
Received: by mail-wm0-x230.google.com with SMTP id u65so38467853wmu.1
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 03:32:09 -0700 (PDT)
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-7-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170427120006.20564-7-rth@twiddle.net>
Date: Fri, 28 Apr 2017 11:32:39 +0100
Message-ID: <87vapo7rg8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 06/19] tcg: introduce goto_ptr opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org


Richard Henderson <rth@twiddle.net> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Message-Id: <1493263764-18657-4-git-send-email-cota@braap.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tcg/aarch64/tcg-target.h | 1 +
>  tcg/arm/tcg-target.h     | 1 +
>  tcg/i386/tcg-target.h    | 1 +
>  tcg/ia64/tcg-target.h    | 1 +
>  tcg/mips/tcg-target.h    | 1 +
>  tcg/ppc/tcg-target.h     | 1 +
>  tcg/s390/tcg-target.h    | 1 +
>  tcg/sparc/tcg-target.h   | 1 +
>  tcg/tcg-opc.h            | 1 +
>  tcg/tci/tcg-target.h     | 1 +
>  10 files changed, 10 insertions(+)
>
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index 1a5ea23..b82eac4 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -77,6 +77,7 @@ typedef enum {
>  #define TCG_TARGET_HAS_mulsh_i32        0
>  #define TCG_TARGET_HAS_extrl_i64_i32    0
>  #define TCG_TARGET_HAS_extrh_i64_i32    0
> +#define TCG_TARGET_HAS_goto_ptr         0
>
>  #define TCG_TARGET_HAS_div_i64          1
>  #define TCG_TARGET_HAS_rem_i64          1
> diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
> index 75ea247..c114df7 100644
> --- a/tcg/arm/tcg-target.h
> +++ b/tcg/arm/tcg-target.h
> @@ -123,6 +123,7 @@ extern bool use_idiv_instructions;
>  #define TCG_TARGET_HAS_mulsh_i32        0
>  #define TCG_TARGET_HAS_div_i32          use_idiv_instructions
>  #define TCG_TARGET_HAS_rem_i32          0
> +#define TCG_TARGET_HAS_goto_ptr         0
>
>  enum {
>      TCG_AREG0 = TCG_REG_R6,
> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> index 4275787..59d9835 100644
> --- a/tcg/i386/tcg-target.h
> +++ b/tcg/i386/tcg-target.h
> @@ -107,6 +107,7 @@ extern bool have_popcnt;
>  #define TCG_TARGET_HAS_muls2_i32        1
>  #define TCG_TARGET_HAS_muluh_i32        0
>  #define TCG_TARGET_HAS_mulsh_i32        0
> +#define TCG_TARGET_HAS_goto_ptr         0
>
>  #if TCG_TARGET_REG_BITS == 64
>  #define TCG_TARGET_HAS_extrl_i64_i32    0
> diff --git a/tcg/ia64/tcg-target.h b/tcg/ia64/tcg-target.h
> index 42aea03..901bb75 100644
> --- a/tcg/ia64/tcg-target.h
> +++ b/tcg/ia64/tcg-target.h
> @@ -173,6 +173,7 @@ typedef enum {
>  #define TCG_TARGET_HAS_mulsh_i64        0
>  #define TCG_TARGET_HAS_extrl_i64_i32    0
>  #define TCG_TARGET_HAS_extrh_i64_i32    0
> +#define TCG_TARGET_HAS_goto_ptr         0
>
>  #define TCG_TARGET_deposit_i32_valid(ofs, len) ((len) <= 16)
>  #define TCG_TARGET_deposit_i64_valid(ofs, len) ((len) <= 16)
> diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
> index f46d64a..e3240cf 100644
> --- a/tcg/mips/tcg-target.h
> +++ b/tcg/mips/tcg-target.h
> @@ -130,6 +130,7 @@ extern bool use_mips32r2_instructions;
>  #define TCG_TARGET_HAS_muluh_i32        1
>  #define TCG_TARGET_HAS_mulsh_i32        1
>  #define TCG_TARGET_HAS_bswap32_i32      1
> +#define TCG_TARGET_HAS_goto_ptr         0
>
>  #if TCG_TARGET_REG_BITS == 64
>  #define TCG_TARGET_HAS_add2_i32         0
> diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
> index abd8b3d..a9aa974 100644
> --- a/tcg/ppc/tcg-target.h
> +++ b/tcg/ppc/tcg-target.h
> @@ -82,6 +82,7 @@ extern bool have_isa_3_00;
>  #define TCG_TARGET_HAS_muls2_i32        0
>  #define TCG_TARGET_HAS_muluh_i32        1
>  #define TCG_TARGET_HAS_mulsh_i32        1
> +#define TCG_TARGET_HAS_goto_ptr         0
>
>  #if TCG_TARGET_REG_BITS == 64
>  #define TCG_TARGET_HAS_add2_i32         0
> diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
> index cbdd2a6..6b7bcfb 100644
> --- a/tcg/s390/tcg-target.h
> +++ b/tcg/s390/tcg-target.h
> @@ -92,6 +92,7 @@ extern uint64_t s390_facilities;
>  #define TCG_TARGET_HAS_mulsh_i32      0
>  #define TCG_TARGET_HAS_extrl_i64_i32  0
>  #define TCG_TARGET_HAS_extrh_i64_i32  0
> +#define TCG_TARGET_HAS_goto_ptr       0
>
>  #define TCG_TARGET_HAS_div2_i64       1
>  #define TCG_TARGET_HAS_rot_i64        1
> diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
> index b8b74f96f..9348ddd 100644
> --- a/tcg/sparc/tcg-target.h
> +++ b/tcg/sparc/tcg-target.h
> @@ -123,6 +123,7 @@ extern bool use_vis3_instructions;
>  #define TCG_TARGET_HAS_muls2_i32        1
>  #define TCG_TARGET_HAS_muluh_i32        0
>  #define TCG_TARGET_HAS_mulsh_i32        0
> +#define TCG_TARGET_HAS_goto_ptr         0
>
>  #define TCG_TARGET_HAS_extrl_i64_i32    1
>  #define TCG_TARGET_HAS_extrh_i64_i32    1
> diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
> index f06f894..956fb1e 100644
> --- a/tcg/tcg-opc.h
> +++ b/tcg/tcg-opc.h
> @@ -193,6 +193,7 @@ DEF(insn_start, 0, 0, TLADDR_ARGS * TARGET_INSN_START_WORDS,
>      TCG_OPF_NOT_PRESENT)
>  DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_END)
>  DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_END)
> +DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_END | IMPL(TCG_TARGET_HAS_goto_ptr))
>
>  DEF(qemu_ld_i32, 1, TLADDR_ARGS, 1,
>      TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
> diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
> index 838bf3a..0696328 100644
> --- a/tcg/tci/tcg-target.h
> +++ b/tcg/tci/tcg-target.h
> @@ -85,6 +85,7 @@
>  #define TCG_TARGET_HAS_muls2_i32        0
>  #define TCG_TARGET_HAS_muluh_i32        0
>  #define TCG_TARGET_HAS_mulsh_i32        0
> +#define TCG_TARGET_HAS_goto_ptr         0
>
>  #if TCG_TARGET_REG_BITS == 64
>  #define TCG_TARGET_HAS_extrl_i64_i32    0


--
Alex Bennée
