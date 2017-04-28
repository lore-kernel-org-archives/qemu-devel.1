Received: from eggs.gnu.org ([2001:4830:134:3::10]:53309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d428L-0004fR-3p
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d428H-0000Fi-Qo
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:24:13 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170426182949.13433-1-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <74ab2535-eb5d-88e3-dfda-04f859d5714b@twiddle.net>
Date: Fri, 28 Apr 2017 11:23:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170426182949.13433-1-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/ppc: do not reset reserve_addr in
 exec_enter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Cc: alex.bennee@linaro.org

On 04/26/2017 08:29 PM, Nikunj A Dadhania wrote:
> @@ -728,6 +728,9 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
>       cs->exception_index = POWERPC_EXCP_NONE;
>       env->error_code = 0;
>   
> +    /* Reset the reservation */
> +    env->reserve_addr = -1;
> +

It occurs to me that we might also need this in do_rfi, for transitioning back 
to userspace after the interrupt.


r~
