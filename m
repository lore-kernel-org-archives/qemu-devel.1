Received: from eggs.gnu.org ([2001:4830:134:3::10]:36809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddMjT-0007ov-NZ
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 16:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddMjQ-0003tG-5M
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 16:28:35 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-3-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3f6ee028-b7f9-fbe0-1aea-eb1e6faab5a3@twiddle.net>
Date: Thu, 3 Aug 2017 13:28:28 -0700
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/15] target/arm: Don't trap WFI/WFE for M
 profile
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
> M profile cores can never trap on WFI or WFE instructions. Check for
> M profile in check_wfx_trap() to ensure this.
> 
> The existing code will do the right thing for v7M cores because
> the hcr_el2 and scr_el3 registers will be all-zeroes and so we
> won't attempt to trap, but when we start setting ARM_FEATURE_V8
> for v8M cores the v8A handling of SCTLR.nTWE and .nTWI will not
> give the right results.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/op_helper.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

While looking at this, I think there's an error in helper_wfi.  The early exit
for cpu_has_work should happen after the exception check.


r~
