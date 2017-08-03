Received: from eggs.gnu.org ([2001:4830:134:3::10]:59491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddOWb-0003ub-Gj
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddOWY-0008RL-GL
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:23:25 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-16-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ead02a80-5ab5-9626-951f-efb6b85e59ea@twiddle.net>
Date: Thu, 3 Aug 2017 15:23:19 -0700
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-16-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/15] nvic: Implement "user accesses
 BusFault" SCS region behaviour
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

On 08/02/2017 09:44 AM, Peter Maydell wrote:
> The ARMv7M architecture specifies that most of the addresses in the
> PPB region (which includes the NVIC, systick and system registers)
> are not accessible to unprivileged accesses, which should
> BusFault with a few exceptions:
>  * the STIR is configurably user-accessible
>  * the ITM (which we don't implement at all) is always
>    user-accessible
> 
> Implement this by switching the register access functions
> to the _with_attrs scheme that lets us distinguish user
> mode accesses.
> 
> This allows us to pull the handling of the CCR.USERSETMPEND
> flag up to the level where we can make it generate a BusFault
> as it should for non-permitted accesses.
> 
> Note that until the core ARM CPU code implements turning
> MEMTX_ERROR into a BusFault the registers will continue to
> act as RAZ/WI to user accesses.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 58 ++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 41 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
