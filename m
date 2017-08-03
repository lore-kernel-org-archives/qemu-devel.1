Received: from eggs.gnu.org ([2001:4830:134:3::10]:36996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddI0U-0001YM-8H
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddI0T-00020v-A4
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:25:50 -0400
Date: Thu, 3 Aug 2017 17:25:40 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170803152540.GP4859@toto>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-8-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501692241-23310-8-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 07/15] target/arm: Fix outdated comment
 about exception exit
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

On Wed, Aug 02, 2017 at 05:43:53PM +0100, Peter Maydell wrote:
> When we switched our handling of exception exit to detect
> the magic addresses at translate time rather than via
> a do_unassigned_access hook, we forgot to update a
> comment; correct the omission.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index fd83a21..cb88c66 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6143,7 +6143,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>      bool rettobase = false;
>  
>      /* We can only get here from an EXCP_EXCEPTION_EXIT, and
> -     * arm_v7m_do_unassigned_access() enforces the architectural rule
> +     * gen_bx_excret() enforces the architectural rule
>       * that jumps to magic addresses don't have magic behaviour unless
>       * we're in Handler mode (compare pseudocode BXWritePC()).
>       */
> -- 
> 2.7.4
> 
> 
