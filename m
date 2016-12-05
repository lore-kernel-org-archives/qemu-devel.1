Received: from eggs.gnu.org ([2001:4830:134:3::10]:39116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxVm-0004Ck-5U
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxVl-0000l1-Fj
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:57:10 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-7-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f4a37b42-8854-bbbb-08f9-1b39d44c4849@twiddle.net>
Date: Mon, 5 Dec 2016 09:57:06 -0800
MIME-Version: 1.0
In-Reply-To: <1480937130-24561-7-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/13] target-ppc: implement stxvll
 instructions
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

On 12/05/2016 03:25 AM, Nikunj A Dadhania wrote:
> +    getVSR(xt_num, &xt, env);
> +    if (msr_le) {
> +        for (i = 0; i < end; i++) {
> +            cpu_stb_data_ra(env, addr, xt.u8[i], GETPC());
> +            addr = addr_add(env, addr, 1);
> +        }
> +    } else {
> +        for (i = 15; i > 15 - end; i--) {
> +            cpu_stb_data_ra(env, addr, xt.u8[i], GETPC());
> +            addr = addr_add(env, addr, 1);
> +        }
> +    }

Have you accidentally swapped the implementations of stxvl and stxvll?


r~
