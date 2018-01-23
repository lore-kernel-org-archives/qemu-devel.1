Received: from eggs.gnu.org ([2001:4830:134:3::10]:54490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edx2c-0000LF-1e
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edx2Y-0005nT-Ut
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:47:02 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1edx2Y-0005n6-MD
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:46:58 -0500
Received: by mail-wm0-x242.google.com with SMTP id r78so1325180wme.0
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 03:46:58 -0800 (PST)
References: <20180123035349.24538-1-richard.henderson@linaro.org>
	<20180123035349.24538-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180123035349.24538-3-richard.henderson@linaro.org>
Date: Tue, 23 Jan 2018 11:46:55 +0000
Message-ID: <87o9lk7q6o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/5] target/arm: Add predicate registers
 for SVE
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

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 1854fe51a8..3f4f6b6144 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -188,6 +188,13 @@ typedef struct ARMVectorReg {
>      uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
>  } ARMVectorReg;
>
> +/* In AArch32 mode, predicate registers do not exist at all.  */
> +#ifdef TARGET_AARCH64
> +typedef struct ARMPredicateReg {
> +    uint64_t p[2 * ARM_MAX_VQ / 8] QEMU_ALIGNED(16);
> +} ARMPredicateReg;
> +#endif
> +
>
>  typedef struct CPUARMState {
>      /* Regs for current mode.  */
> @@ -515,6 +522,11 @@ typedef struct CPUARMState {
>      struct {
>          ARMVectorReg zregs[32];
>
> +#ifdef TARGET_AARCH64
> +        /* Store FFR as pregs[16] to make it easier to treat as any othe=
r.  */
> +        ARMPredicateReg pregs[17];
> +#endif
> +
>          uint32_t xregs[16];
>          /* We store these fpcsr fields separately for convenience.  */
>          int vec_len;


--
Alex Benn=C3=A9e
