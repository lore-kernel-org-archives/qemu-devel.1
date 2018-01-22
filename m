Received: from eggs.gnu.org ([2001:4830:134:3::10]:59671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edhb3-0005c2-9G
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edhb2-0004ID-CR
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:17:33 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edhb2-0004Hf-83
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:17:32 -0500
Received: by mail-ot0-x244.google.com with SMTP id d9so8477297oth.6
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 11:17:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117161435.28981-4-richard.henderson@linaro.org>
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 19:17:11 +0000
Message-ID: <CAFEAcA_Xy=3Twb_J1VrcT4QnKK=PVbVc_YGBd58ADX7z2YkkaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v10.5 03/20] tcg: Standardize integral
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
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2018 at 16:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Some functions use intN_t arguments, some use uintN_t, some just
> used "unsigned".  To aid putting function pointers in tables, we
> need consistency.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op.h | 16 ++++++++--------
>  tcg/tcg-op.c | 42 +++++++++++++++++++++---------------------
>  2 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index 9b0560e4d3..df2eabaa67 100644
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
> @@ -458,12 +458,12 @@ static inline void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
>  void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
>  void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
>  void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
> -void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
> +void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);

Does changing these types from unsigned to signed definitely
not result in any possible change in behaviour of frontend
code if there's now an unintended sign extension ? I thought
maybe there was, but now I think I was confused and this is safe...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
