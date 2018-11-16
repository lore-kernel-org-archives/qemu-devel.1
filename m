Received: from eggs.gnu.org ([2001:4830:134:3::10]:51886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZy1-0007jm-Rl
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZy1-0006FJ-63
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:59:09 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNZy0-0006Es-W5
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:59:09 -0500
Received: by mail-wr1-x443.google.com with SMTP id 96so7135658wrb.2
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 00:59:08 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<7961f2bc55e109ff10543c4665c5cbc3c75a5bf7.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d11e2ddb-978e-1359-16ff-4b640cd74e6d@linaro.org>
Date: Fri, 16 Nov 2018 09:59:04 +0100
MIME-Version: 1.0
In-Reply-To: <7961f2bc55e109ff10543c4665c5cbc3c75a5bf7.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 14/23] riscv: tcg-target: Add the out load
 and store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 11/15/18 11:36 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  tcg/riscv/tcg-target.inc.c | 56 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
> index 646a4d3ebd..bc433170c4 100644
> --- a/tcg/riscv/tcg-target.inc.c
> +++ b/tcg/riscv/tcg-target.inc.c
> @@ -518,6 +518,62 @@ static void tcg_out_ext32s(TCGContext *s, TCGReg ret, TCGReg arg)
>      tcg_out_opc_imm(s, OPC_ADDIW, ret, arg, 0);
>  }
>  
> +static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
> +                         TCGReg addr, intptr_t offset)
> +{
> +    int32_t imm12 = sextract32(offset, 0, 12);

sextract64 for rv64.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
