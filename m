Received: from eggs.gnu.org ([2001:4830:134:3::10]:52401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddOS8-000135-Nx
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddOS5-0003BP-Mp
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:18:48 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-14-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <bbbcc51f-ea2a-039b-7453-b4c9e6e53077@twiddle.net>
Date: Thu, 3 Aug 2017 15:18:42 -0700
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-14-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/15] target/arm: Create and use new
 function arm_v7m_is_handler_mode()
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
> Add a utility function for testing whether the CPU is in Handler
> mode; this is just a check whether v7m.exception is non-zero, but
> we do it in several places and it makes the code a bit easier
> to read to not have to mentally figure out what the test is testing.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h    | 10 ++++++++--
>  target/arm/helper.c |  8 ++++----
>  2 files changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
