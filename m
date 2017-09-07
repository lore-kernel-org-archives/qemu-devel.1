Received: from eggs.gnu.org ([2001:4830:134:3::10]:41224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dq1Nq-0002iy-OT
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dq1Nl-0006wX-NA
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:18:34 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:44344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dq1Nl-0006w2-Ei
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:18:29 -0400
Received: by mail-wm0-x22a.google.com with SMTP id 137so823743wmj.1
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:18:29 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-4-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170817230114.3655-4-richard.henderson@linaro.org>
Date: Thu, 07 Sep 2017 19:18:26 +0100
Message-ID: <8760cumky5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/8] tcg: Add types for host vectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Nothing uses or enables them yet.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tcg/tcg.h | 5 +++++
>  tcg/tcg.c | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index dd97095af5..1277caed3d 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -256,6 +256,11 @@ typedef struct TCGPool {
>  typedef enum TCGType {
>      TCG_TYPE_I32,
>      TCG_TYPE_I64,
> +
> +    TCG_TYPE_V64,
> +    TCG_TYPE_V128,
> +    TCG_TYPE_V256,
> +
>      TCG_TYPE_COUNT, /* number of different types */
>
>      /* An alias for the size of the host register.  */
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 787c8ba0f7..ea78d47fad 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -118,7 +118,7 @@ static TCGReg tcg_reg_alloc_new(TCGContext *s, TCGType t)
>  static bool tcg_out_ldst_finalize(TCGContext *s);
>  #endif
>
> -static TCGRegSet tcg_target_available_regs[2];
> +static TCGRegSet tcg_target_available_regs[TCG_TYPE_COUNT];
>  static TCGRegSet tcg_target_call_clobber_regs;
>
>  #if TCG_TARGET_INSN_UNIT_SIZE == 1


--
Alex Bennée
