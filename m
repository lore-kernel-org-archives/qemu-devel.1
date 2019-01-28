Received: from eggs.gnu.org ([209.51.188.92]:59072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1go4yB-0005jj-1d
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1go4y9-0001XQ-CD
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:20:50 -0500
MIME-Version: 1.0
References: <20190125182626.9221-1-peter.maydell@linaro.org>
	<20190125182626.9221-8-peter.maydell@linaro.org>
In-Reply-To: <20190125182626.9221-8-peter.maydell@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 28 Jan 2019 12:20:38 +0100
Message-ID: <CABoDooN5JjtJKWA=5io=Ttycys1Nwe4FQjxj4N+_iMx0hW1qJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 7/7] target/arm/translate-a64: Don't
 underdecode SDOT and UDOT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On Fri, Jan 25, 2019 at 7:26 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In the AdvSIMD scalar x indexed element and vector x indexed element
> encoding group, the SDOT and UDOT instructions are vector only,
> and their opcode is unallocated in the scalar group. Correctly
> UNDEF this unallocated encoding.
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
> index 474d9bfb5f0..30bc2412fc0 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -12641,7 +12641,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
>          break;
>      case 0x0e: /* SDOT */
>      case 0x1e: /* UDOT */
> -        if (size != MO_32 || !dc_isar_feature(aa64_dp, s)) {
> +        if (is_scalar || size != MO_32 || !dc_isar_feature(aa64_dp, s)) {
>              unallocated_encoding(s);
>              return;
>          }
> --
> 2.20.1
>
