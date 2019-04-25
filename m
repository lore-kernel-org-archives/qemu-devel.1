Received: from eggs.gnu.org ([209.51.188.92]:44565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJgrR-0000sU-Mb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJgrO-0002Kx-OL
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:33 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hJgrK-0002Aj-Pw
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:28 -0400
Received: by mail-pl1-x641.google.com with SMTP id x15so10859pln.9
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:04:26 -0700 (PDT)
Date: Thu, 25 Apr 2019 09:04:24 -0700 (PDT)
In-Reply-To: <20190401031155.21293-9-richard.henderson@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-a0bb1fb9-5aa1-4354-8935-43c8b85dec5b@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 8/8] target/riscv: Remove spaces
 from register names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org

On Sun, 31 Mar 2019 20:11:55 PDT (-0700), richard.henderson@linaro.org wrote:
> These extra spaces make the "-d op" dump look weird.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/cpu.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d61bce6d55..624528efb5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -29,17 +29,17 @@
>  static const char riscv_exts[26] = "IEMAFDQCLBJTPVNSUHKORWXYZG";
>
>  const char * const riscv_int_regnames[] = {
> -  "zero", "ra  ", "sp  ", "gp  ", "tp  ", "t0  ", "t1  ", "t2  ",
> -  "s0  ", "s1  ", "a0  ", "a1  ", "a2  ", "a3  ", "a4  ", "a5  ",
> -  "a6  ", "a7  ", "s2  ", "s3  ", "s4  ", "s5  ", "s6  ", "s7  ",
> -  "s8  ", "s9  ", "s10 ", "s11 ", "t3  ", "t4  ", "t5  ", "t6  "
> +  "zero", "ra", "sp",  "gp",  "tp", "t0", "t1", "t2",
> +  "s0",   "s1", "a0",  "a1",  "a2", "a3", "a4", "a5",
> +  "a6",   "a7", "s2",  "s3",  "s4", "s5", "s6", "s7",
> +  "s8",   "s9", "s10", "s11", "t3", "t4", "t5", "t6"
>  };
>
>  const char * const riscv_fpr_regnames[] = {
> -  "ft0 ", "ft1 ", "ft2 ", "ft3 ", "ft4 ", "ft5 ", "ft6 ",  "ft7 ",
> -  "fs0 ", "fs1 ", "fa0 ", "fa1 ", "fa2 ", "fa3 ", "fa4 ",  "fa5 ",
> -  "fa6 ", "fa7 ", "fs2 ", "fs3 ", "fs4 ", "fs5 ", "fs6 ",  "fs7 ",
> -  "fs8 ", "fs9 ", "fs10", "fs11", "ft8 ", "ft9 ", "ft10",  "ft11"
> +  "ft0", "ft1", "ft2",  "ft3",  "ft4", "ft5", "ft6",  "ft7",
> +  "fs0", "fs1", "fa0",  "fa1",  "fa2", "fa3", "fa4",  "fa5",
> +  "fa6", "fa7", "fs2",  "fs3",  "fs4", "fs5", "fs6",  "fs7",
> +  "fs8", "fs9", "fs10", "fs11", "ft8", "ft9", "ft10", "ft11"
>  };
>
>  const char * const riscv_excp_names[] = {

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
