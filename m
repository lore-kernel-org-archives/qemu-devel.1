Received: from eggs.gnu.org ([2001:4830:134:3::10]:37893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddO1v-00046B-CL
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 17:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddO1q-0001wm-R7
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 17:51:43 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-9-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <80e9ff87-14d8-2e18-7c21-c1c7803b3a58@twiddle.net>
Date: Thu, 3 Aug 2017 14:51:35 -0700
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-9-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/15] target/arm: Define and use XPSR bit
 masks
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

On 08/02/2017 09:43 AM, Peter Maydell wrote:
> The M profile XPSR is almost the same format as the A profile CPSR,
> but not quite. Define some XPSR_* macros and use them where we
> definitely dealing with an XPSR rather than reusing the CPSR ones.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h    | 38 ++++++++++++++++++++++++++++----------
>  target/arm/helper.c | 15 ++++++++-------
>  2 files changed, 36 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
