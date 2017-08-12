Received: from eggs.gnu.org ([2001:4830:134:3::10]:60300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1dgUkg-0006P1-4x
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1dgUkf-000270-0I
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:38:46 -0400
Date: Sat, 12 Aug 2017 13:38:26 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20170812113826.GX12347@toto>
References: <cover.1502488636.git.alistair.francis@xilinx.com>
	<e554047d3a8376721ab5b33dbe8e4162f2b14475.1502488636.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e554047d3a8376721ab5b33dbe8e4162f2b14475.1502488636.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/3] target/arm: Update the memops for
 exclusive load
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

On Fri, Aug 11, 2017 at 03:17:36PM -0700, Alistair Francis wrote:
> Acording to the ARM ARM exclusive loads require the same allignment as
> exclusive stores. Let's update the memops used for the load to match
> that of the store. This adds the alignment requirement to the memops.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
> 
>  target/arm/translate-a64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 58ed4c6d05..245175e2f1 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1854,7 +1854,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
>                                 TCGv_i64 addr, int size, bool is_pair)
>  {
>      TCGv_i64 tmp = tcg_temp_new_i64();
> -    TCGMemOp memop = s->be_data + size;
> +    TCGMemOp memop = size | MO_ALIGN | s->be_data;
>  
>      g_assert(size <= 3);
>      tcg_gen_qemu_ld_i64(tmp, addr, get_mem_index(s), memop);
> -- 
> 2.11.0
> 
