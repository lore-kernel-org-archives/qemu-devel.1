Received: from eggs.gnu.org ([2001:4830:134:3::10]:60614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1dgUlU-00071h-88
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1dgUlT-0002WU-2c
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:39:36 -0400
Date: Sat, 12 Aug 2017 13:39:14 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20170812113914.GY12347@toto>
References: <cover.1502488636.git.alistair.francis@xilinx.com>
	<885b354ba1e79510bfd6a905d62971c275645ad5.1502488636.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <885b354ba1e79510bfd6a905d62971c275645ad5.1502488636.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/3] tcg/tcg-op: Expose the
 tcg_gen_ext_i* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, alistair23@gmail.com, edgar.iglesias@gmail.com, qemu-arm@nongnu.org

On Fri, Aug 11, 2017 at 03:17:38PM -0700, Alistair Francis wrote:
> Expose the tcg_gen_ext_i32() and tcg_gen_ext_i64() functions.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
> 
> Although I no longer am using these functions I have left this patch in
> as Richard thought it was a good idea.
> 
>  tcg/tcg-op.c | 4 ++--
>  tcg/tcg-op.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 87f673ef49..d25e3003ef 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -2709,7 +2709,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
>      gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
>  }
>  
> -static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, TCGMemOp opc)
> +void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, TCGMemOp opc)
>  {
>      switch (opc & MO_SSIZE) {
>      case MO_SB:
> @@ -2730,7 +2730,7 @@ static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, TCGMemOp opc)
>      }
>  }
>  
> -static void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, TCGMemOp opc)
> +void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, TCGMemOp opc)
>  {
>      switch (opc & MO_SSIZE) {
>      case MO_SB:
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index 5d3278f243..8c45b79a92 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -835,6 +835,8 @@ void tcg_gen_qemu_ld_i32(TCGv_i32, TCGv, TCGArg, TCGMemOp);
>  void tcg_gen_qemu_st_i32(TCGv_i32, TCGv, TCGArg, TCGMemOp);
>  void tcg_gen_qemu_ld_i64(TCGv_i64, TCGv, TCGArg, TCGMemOp);
>  void tcg_gen_qemu_st_i64(TCGv_i64, TCGv, TCGArg, TCGMemOp);
> +void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, TCGMemOp opc);
> +void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, TCGMemOp opc);
>  
>  static inline void tcg_gen_qemu_ld8u(TCGv ret, TCGv addr, int mem_index)
>  {
> -- 
> 2.11.0
> 
