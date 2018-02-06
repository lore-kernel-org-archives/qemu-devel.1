Received: from eggs.gnu.org ([2001:4830:134:3::10]:50841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eiz4D-0007ZZ-64
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:57:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eiz49-0000d0-Ug
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:57:29 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eiz49-0000ch-Ks
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:57:25 -0500
Received: by mail-wr0-x242.google.com with SMTP id h9so1034964wre.12
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 00:57:25 -0800 (PST)
References: <20180126045742.5487-1-richard.henderson@linaro.org>
	<20180126045742.5487-4-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180126045742.5487-4-richard.henderson@linaro.org>
Date: Tue, 06 Feb 2018 08:57:22 +0000
Message-ID: <87y3k6wl59.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 03/20] tcg: Standardize integral
 arguments to expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Some functions use intN_t arguments, some use uintN_t, some just
> used "unsigned".  To aid putting function pointers in tables, we
> need consistency.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I was a bit confused by converting unsigned into int64_t but I see the
asserts ensure they are all still positives and you need the same types
if you are going to mix things like "and" with "shr" in the same table.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/tcg-op.h | 16 ++++++++--------
>  tcg/tcg-op.c | 42 +++++++++++++++++++++---------------------
>  2 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index 0c02d86b8b..a684ab5890 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -269,12 +269,12 @@ void tcg_gen_mb(TCGBar);
>  void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
>  void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
>  void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
> -void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
> +void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
>  void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
>  void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
> -void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
> -void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
> -void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
> +void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
> +void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
> +void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
>  void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
>  void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
>  void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
> @@ -458,12 +458,12 @@ static inline void tcg_gen_not_i32(TCGv_i32 ret, TC=
Gv_i32 arg)
>  void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
>  void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
>  void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
> -void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
> +void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
>  void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
>  void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
> -void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
> -void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
> -void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
> +void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
> +void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
> +void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
>  void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
>  void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
>  void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 0c509bfe46..3467787323 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -140,7 +140,7 @@ void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, in=
t32_t arg2)
>      }
>  }
>
> -void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
> +void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>  {
>      TCGv_i32 t0;
>      /* Some cases can be optimized here.  */
> @@ -148,17 +148,17 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, =
uint32_t arg2)
>      case 0:
>          tcg_gen_movi_i32(ret, 0);
>          return;
> -    case 0xffffffffu:
> +    case -1:
>          tcg_gen_mov_i32(ret, arg1);
>          return;
> -    case 0xffu:
> +    case 0xff:
>          /* Don't recurse with tcg_gen_ext8u_i32.  */
>          if (TCG_TARGET_HAS_ext8u_i32) {
>              tcg_gen_op2_i32(INDEX_op_ext8u_i32, ret, arg1);
>              return;
>          }
>          break;
> -    case 0xffffu:
> +    case 0xffff:
>          if (TCG_TARGET_HAS_ext16u_i32) {
>              tcg_gen_op2_i32(INDEX_op_ext16u_i32, ret, arg1);
>              return;
> @@ -199,9 +199,9 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, in=
t32_t arg2)
>      }
>  }
>
> -void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
> +void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>  {
> -    tcg_debug_assert(arg2 < 32);
> +    tcg_debug_assert(arg2 >=3D 0 && arg2 < 32);
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i32(ret, arg1);
>      } else {
> @@ -211,9 +211,9 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, un=
signed arg2)
>      }
>  }
>
> -void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
> +void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>  {
> -    tcg_debug_assert(arg2 < 32);
> +    tcg_debug_assert(arg2 >=3D 0 && arg2 < 32);
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i32(ret, arg1);
>      } else {
> @@ -223,9 +223,9 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, un=
signed arg2)
>      }
>  }
>
> -void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
> +void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>  {
> -    tcg_debug_assert(arg2 < 32);
> +    tcg_debug_assert(arg2 >=3D 0 && arg2 < 32);
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i32(ret, arg1);
>      } else {
> @@ -1201,7 +1201,7 @@ void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, =
int64_t arg2)
>      }
>  }
>
> -void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
> +void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>  {
>      TCGv_i64 t0;
>
> @@ -1216,23 +1216,23 @@ void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1=
, uint64_t arg2)
>      case 0:
>          tcg_gen_movi_i64(ret, 0);
>          return;
> -    case 0xffffffffffffffffull:
> +    case -1:
>          tcg_gen_mov_i64(ret, arg1);
>          return;
> -    case 0xffull:
> +    case 0xff:
>          /* Don't recurse with tcg_gen_ext8u_i64.  */
>          if (TCG_TARGET_HAS_ext8u_i64) {
>              tcg_gen_op2_i64(INDEX_op_ext8u_i64, ret, arg1);
>              return;
>          }
>          break;
> -    case 0xffffu:
> +    case 0xffff:
>          if (TCG_TARGET_HAS_ext16u_i64) {
>              tcg_gen_op2_i64(INDEX_op_ext16u_i64, ret, arg1);
>              return;
>          }
>          break;
> -    case 0xffffffffull:
> +    case 0xffffffffu:
>          if (TCG_TARGET_HAS_ext32u_i64) {
>              tcg_gen_op2_i64(INDEX_op_ext32u_i64, ret, arg1);
>              return;
> @@ -1332,9 +1332,9 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret,=
 TCGv_i64 arg1,
>      }
>  }
>
> -void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
> +void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>  {
> -    tcg_debug_assert(arg2 < 64);
> +    tcg_debug_assert(arg2 >=3D 0 && arg2 < 64);
>      if (TCG_TARGET_REG_BITS =3D=3D 32) {
>          tcg_gen_shifti_i64(ret, arg1, arg2, 0, 0);
>      } else if (arg2 =3D=3D 0) {
> @@ -1346,9 +1346,9 @@ void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, =
unsigned arg2)
>      }
>  }
>
> -void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
> +void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>  {
> -    tcg_debug_assert(arg2 < 64);
> +    tcg_debug_assert(arg2 >=3D 0 && arg2 < 64);
>      if (TCG_TARGET_REG_BITS =3D=3D 32) {
>          tcg_gen_shifti_i64(ret, arg1, arg2, 1, 0);
>      } else if (arg2 =3D=3D 0) {
> @@ -1360,9 +1360,9 @@ void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, =
unsigned arg2)
>      }
>  }
>
> -void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
> +void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>  {
> -    tcg_debug_assert(arg2 < 64);
> +    tcg_debug_assert(arg2 >=3D 0 && arg2 < 64);
>      if (TCG_TARGET_REG_BITS =3D=3D 32) {
>          tcg_gen_shifti_i64(ret, arg1, arg2, 1, 1);
>      } else if (arg2 =3D=3D 0) {


--
Alex Benn=C3=A9e
