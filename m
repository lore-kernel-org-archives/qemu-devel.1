Received: from eggs.gnu.org ([2001:4830:134:3::10]:41111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddNmf-0006yc-4I
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 17:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddNmc-00089n-7I
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 17:35:57 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-7-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d5672231-9b37-1923-f0e2-2fe9ae10678f@twiddle.net>
Date: Thu, 3 Aug 2017 14:35:51 -0700
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-7-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/15] target/arm: Remove incorrect comment
 about MPU_CTRL
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
> Remove the comment that claims that some MPU_CTRL bits are stored
> in sctlr_el[1]. This has never been true since MPU_CTRL was added
> in commit 29c483a50607 -- the comment is a leftover from
> Michael Davidsaver's original implementation, which I modified
> not to use sctlr_el[1]; I forgot to delete the comment then.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
