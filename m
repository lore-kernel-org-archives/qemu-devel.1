Received: from eggs.gnu.org ([2001:4830:134:3::10]:47446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddOOH-0005l2-Ul
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddOOE-0007Y7-T5
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:14:49 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-12-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2f3523e9-a8b8-ed6d-3fae-33a4dfbaa6db@twiddle.net>
Date: Thu, 3 Aug 2017 15:14:43 -0700
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-12-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/15] target/arm: Make
 arm_cpu_dump_state() handle the M-profile XPSR
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
> Make the arm_cpu_dump_state() debug logging handle the M-profile XPSR
> rather than assuming it's an A-profile CPSR.  On M profile the PSR
> line of a register dump will now look like this:
> 
> XPSR=41000000 -Z-- T priv-thread
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 58 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
