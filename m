Received: from eggs.gnu.org ([209.51.188.92]:49617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1goUnt-0005Tp-18
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1goUZ4-0000D9-6p
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:40:47 -0500
MIME-Version: 1.0
References: <20190129140411.682-1-peter.maydell@linaro.org>
	<20190129140411.682-2-peter.maydell@linaro.org>
In-Reply-To: <20190129140411.682-2-peter.maydell@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Tue, 29 Jan 2019 15:24:58 +0100
Message-ID: <CABoDooNSoV5JyXg9aLTARU1A9exhM+BhFsc48E8ArPq7538AMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] target/arm/translate-a64: Fix FCMLA
 decoding error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On Tue, Jan 29, 2019 at 3:04 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The FCMLA (by element) instruction exists in the
> "vector x indexed element" encoding group, but not in
> the "scalar x indexed element" group. Correctly UNDEF
> the unallocated encodings.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  target/arm/translate-a64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 30bc2412fc0..a7b999d2b5a 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -12650,7 +12650,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
>      case 0x13: /* FCMLA #90 */
>      case 0x15: /* FCMLA #180 */
>      case 0x17: /* FCMLA #270 */
> -        if (!dc_isar_feature(aa64_fcma, s)) {
> +        if (is_scalar || !dc_isar_feature(aa64_fcma, s)) {
>              unallocated_encoding(s);
>              return;
>          }
> --
> 2.20.1
>
