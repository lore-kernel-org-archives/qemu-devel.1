Received: from eggs.gnu.org ([2001:4830:134:3::10]:50472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cftj6-0000dH-GV
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cftj5-00059M-M5
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:34:24 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487585521-19445-4-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3371ac2b-aa82-0b31-c514-d4b9d2a33b8c@twiddle.net>
Date: Tue, 21 Feb 2017 06:34:17 +1100
MIME-Version: 1.0
In-Reply-To: <1487585521-19445-4-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/10] target/ppc: move subf logic block
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
>              tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
> -        } else if (add_ca) {
> -            TCGv zero, inv1 = tcg_temp_new();
> -            tcg_gen_not_tl(inv1, arg1);
> -            zero = tcg_const_tl(0);
> -            tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
> -            tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
> -            tcg_temp_free(zero);
> -            tcg_temp_free(inv1);
>          } else {
> -            tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
> -            tcg_gen_sub_tl(t0, arg2, arg1);
> +            if (add_ca) {
> +                TCGv zero, inv1 = tcg_temp_new();
> +                tcg_gen_not_tl(inv1, arg1);
> +                zero = tcg_const_tl(0);
> +                tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
> +                tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
> +                tcg_temp_free(zero);
> +                tcg_temp_free(inv1);
> +            } else {
> +                tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
> +                tcg_gen_sub_tl(t0, arg2, arg1);
> +            }
>          }

Why would you want to increase the indentation for no reason?


r~
