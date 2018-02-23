Received: from eggs.gnu.org ([2001:4830:134:3::10]:59498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epD5p-0008G9-Ve
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epD5p-00076P-5B
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:08:53 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epD5o-00074b-Up
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:08:53 -0500
Received: by mail-pf0-x243.google.com with SMTP id q13so3496725pff.0
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 05:08:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-15-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 13:08:31 +0000
Message-ID: <CAFEAcA9wa32T_vjH2NVxnsW3jzDw6nwPjMXuAdaBfrAXfCdHEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 14/67] target/arm: Implement SVE Integer
 Arithmetic - Unary Predicated Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  60 +++++++++++++++++++++
>  target/arm/sve_helper.c    | 127 +++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 111 +++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  23 ++++++++
>  4 files changed, 321 insertions(+)

> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 177f338fed..b875501475 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -165,6 +165,29 @@ ASR_zpzw   00000100 .. 011 000 100 ... ..... .....         @rdn_pg_rm
>  LSR_zpzw       00000100 .. 011 001 100 ... ..... .....         @rdn_pg_rm
>  LSL_zpzw       00000100 .. 011 011 100 ... ..... .....         @rdn_pg_rm
>
> +### SVE Integer Arithmetic - Unary Predicated Group
> +
> +# SVE unary bit operations (predicated)
> +# Note esz != 0 for FABS and FNEG.
> +CLS            00000100 .. 011 000 101 ... ..... .....         @rd_pg_rn
> +CLZ            00000100 .. 011 001 101 ... ..... .....         @rd_pg_rn
> +CNT_zpz                00000100 .. 011 010 101 ... ..... .....         @rd_pg_rn
> +CNOT           00000100 .. 011 011 101 ... ..... .....         @rd_pg_rn
> +NOT_zpz                00000100 .. 011 110 101 ... ..... .....         @rd_pg_rn
> +FABS           00000100 .. 011 100 101 ... ..... .....         @rd_pg_rn
> +FNEG           00000100 .. 011 101 101 ... ..... .....         @rd_pg_rn

Indentation seems to be a bit skew for the _zpz lines.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
