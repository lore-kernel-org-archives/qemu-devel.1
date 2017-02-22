Received: from eggs.gnu.org ([2001:4830:134:3::10]:42837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgULP-0004dq-8S
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgULM-0002rq-76
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:40:23 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487755788-16415-10-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <efbd6bf4-c5cc-c6ee-afba-e33a26d9afd3@twiddle.net>
Date: Wed, 22 Feb 2017 21:40:11 +1100
MIME-Version: 1.0
In-Reply-To: <1487755788-16415-10-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/11] target/ppc: add ov32 flag for
 multiply low insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 02/22/2017 08:29 PM, Nikunj A Dadhania wrote:
> For Multiply Word:
> SO, OV, and OV32 bits reflects overflow of the 32-bit result
>
> For Multiply DoubleWord:
> SO, OV, and OV32 bits reflects overflow of the 64-bit result
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/ppc/translate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 2a9f508..d676863 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1288,6 +1288,7 @@ static void gen_mullwo(DisasContext *ctx)
>      tcg_gen_sari_i32(t0, t0, 31);
>      tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t1);
>      tcg_gen_extu_i32_tl(cpu_ov, t0);
> +    tcg_gen_mov_tl(cpu_ov32, cpu_ov);
>      tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
>
>      tcg_temp_free_i32(t0);
> @@ -1349,6 +1350,7 @@ static void gen_mulldo(DisasContext *ctx)
>
>      tcg_gen_sari_i64(t0, t0, 63);
>      tcg_gen_setcond_i64(TCG_COND_NE, cpu_ov, t0, t1);
> +    tcg_gen_mov_tl(cpu_ov32, cpu_ov);
>      tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);

isa300 checks?


r~
