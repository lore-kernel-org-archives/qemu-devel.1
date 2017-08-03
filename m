Received: from eggs.gnu.org ([2001:4830:134:3::10]:34639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddHz1-0000gx-E8
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddHz0-000870-K6
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:24:19 -0400
Date: Thu, 3 Aug 2017 17:24:08 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170803152408.GO4859@toto>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-7-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501692241-23310-7-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 06/15] target/arm: Remove
 incorrect comment about MPU_CTRL
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

On Wed, Aug 02, 2017 at 05:43:52PM +0100, Peter Maydell wrote:
> Remove the comment that claims that some MPU_CTRL bits are stored
> in sctlr_el[1]. This has never been true since MPU_CTRL was added
> in commit 29c483a50607 -- the comment is a leftover from
> Michael Davidsaver's original implementation, which I modified
> not to use sctlr_el[1]; I forgot to delete the comment then.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/arm/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index b39d64a..b64474c 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -416,7 +416,7 @@ typedef struct CPUARMState {
>          uint32_t dfsr; /* Debug Fault Status Register */
>          uint32_t mmfar; /* MemManage Fault Address */
>          uint32_t bfar; /* BusFault Address */
> -        unsigned mpu_ctrl; /* MPU_CTRL (some bits kept in sctlr_el[1]) */
> +        unsigned mpu_ctrl; /* MPU_CTRL */
>          int exception;
>      } v7m;
>  
> -- 
> 2.7.4
> 
> 
