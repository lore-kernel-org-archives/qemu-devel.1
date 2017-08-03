Received: from eggs.gnu.org ([2001:4830:134:3::10]:42055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddNn6-0007I9-OG
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 17:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddNn4-0000IO-5d
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 17:36:24 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-8-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d94cdb49-a23f-af7e-25b9-4bd67e33db26@twiddle.net>
Date: Thu, 3 Aug 2017 14:36:19 -0700
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/02/2017 09:43 AM, Peter Maydell wrote:
> When we switched our handling of exception exit to detect
> the magic addresses at translate time rather than via
> a do_unassigned_access hook, we forgot to update a
> comment; correct the omission.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
