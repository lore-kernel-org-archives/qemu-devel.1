Received: from eggs.gnu.org ([2001:4830:134:3::10]:37194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CoY-0000SW-3i
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CoV-0004Ei-0M
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:53:42 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180419142151.9862-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1f466289-1d74-713f-4644-751e52a54000@amsat.org>
Date: Thu, 19 Apr 2018 13:53:34 -0300
MIME-Version: 1.0
In-Reply-To: <20180419142151.9862-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target/arm: Remove stale TODO
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 04/19/2018 11:21 AM, Peter Maydell wrote:
> Remove a stale TODO comment -- we have now made the arm_ldl_ptw()
> and arm_ldq_ptw() functions propagate physical memory read errors
> out to their callers.

... in 3b39d734141.

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/helper.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2ebd086ef2..0fa02c31e1 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8681,13 +8681,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
>      return addr;
>  }
>  
> -/* All loads done in the course of a page table walk go through here.
> - * TODO: rather than ignoring errors from physical memory reads (which
> - * are external aborts in ARM terminology) we should propagate this
> - * error out so that we can turn it into a Data Abort if this walk
> - * was being done for a CPU load/store or an address translation instruction
> - * (but not if it was for a debug access).
> - */
> +/* All loads done in the course of a page table walk go through here. */
>  static uint32_t arm_ldl_ptw(CPUState *cs, hwaddr addr, bool is_secure,
>                              ARMMMUIdx mmu_idx, ARMMMUFaultInfo *fi)
>  {
> 
