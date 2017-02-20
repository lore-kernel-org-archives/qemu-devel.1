Received: from eggs.gnu.org ([2001:4830:134:3::10]:54851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cfu2U-0003z5-AC
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:54:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cfu2T-0002JJ-LV
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:54:26 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487585521-19445-7-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c12cf81e-9d49-ff45-e94e-fd441cf8302d@twiddle.net>
Date: Tue, 21 Feb 2017 06:54:10 +1100
MIME-Version: 1.0
In-Reply-To: <1487585521-19445-7-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 06/10] target/ppc: use tcg ops for neg
 instruction
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

On 02/20/2017 09:11 PM, Nikunj A Dadhania wrote:
>  static void gen_neg(DisasContext *ctx)
>  {
> -    gen_op_arith_neg(ctx, 0);
> +    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
>  }
>

NACK.  You're forgetting "neg.".


r~
