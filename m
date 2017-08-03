Received: from eggs.gnu.org ([2001:4830:134:3::10]:46269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddMoL-00026l-Jk
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 16:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddMoI-0002b4-2e
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 16:33:37 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-4-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f58e5b02-8023-0737-3b79-507040751ce2@twiddle.net>
Date: Thu, 3 Aug 2017 13:33:30 -0700
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/15] target/arm: Consolidate PMSA
 handling in get_phys_addr()
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
> Currently get_phys_addr() has PMSAv7 handling before the
> "is translation disabled?" check, and then PMSAv5 after it.
> Tidy this up by making the PMSAv5 code handle the "MPU disabled"
> case itself, so that we have all the PMSA code in one place.
> This will make adding the PMSAv8 code slightly cleaner, and
> also means that pre-v7 PMSA cores benefit from the MPU lookup
> logging that the PMSAv7 codepath had.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
