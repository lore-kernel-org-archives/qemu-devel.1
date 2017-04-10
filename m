Received: from eggs.gnu.org ([2001:4830:134:3::10]:50139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cxUx9-0002nM-Dh
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cxUx8-00041a-JB
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:45:39 -0400
Date: Mon, 10 Apr 2017 10:45:30 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170410084530.GC19103@toto>
References: <1491486340-25988-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491486340-25988-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target/arm: Add missing entries
 to excnames[] for log strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Thu, Apr 06, 2017 at 02:45:40PM +0100, Peter Maydell wrote:
> Recent changes have added new EXCP_ values to ARM but forgot
> to update the excnames[] array which is used to provide
> human-readable strings when printing information about the
> exception for debug logging. Add the missing entries, and
> add a comment to the list of #defines to help avoid the mistake
> being repeated in future.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/arm/cpu.h       | 1 +
>  target/arm/internals.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index a8aabce..e6f05e2 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -58,6 +58,7 @@
>  #define EXCP_SEMIHOST       16   /* semihosting call */
>  #define EXCP_NOCP           17   /* v7M NOCP UsageFault */
>  #define EXCP_INVSTATE       18   /* v7M INVSTATE UsageFault */
> +/* NB: new EXCP_ defines should be added to the excnames[] array too */
>  
>  #define ARMV7M_EXCP_RESET   1
>  #define ARMV7M_EXCP_NMI     2
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index f742a41..97ca034 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -70,6 +70,8 @@ static const char * const excnames[] = {
>      [EXCP_VIRQ] = "Virtual IRQ",
>      [EXCP_VFIQ] = "Virtual FIQ",
>      [EXCP_SEMIHOST] = "Semihosting call",
> +    [EXCP_NOCP] = "v7M NOCP UsageFault",
> +    [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
>  };
>  
>  /* Scale factor for generic timers, ie number of ns per tick.
> -- 
> 2.7.4
> 
> 
