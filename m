Received: from eggs.gnu.org ([2001:4830:134:3::10]:46616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fYxNe-00020v-BB
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fYxNd-0003CT-J3
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:40:22 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180629161731.16239-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c337edff-5d16-4add-f534-dc0f52a2d420@twiddle.net>
Date: Fri, 29 Jun 2018 10:40:18 -0700
MIME-Version: 1.0
In-Reply-To: <20180629161731.16239-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] accel/tcg: Don't treat invalid TLB
 entries as needing recheck
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, patches@linaro.org

On 06/29/2018 09:17 AM, Peter Maydell wrote:
> In get_page_addr_code() when we check whether the TLB entry
> is marked as TLB_RECHECK, we should not go down that code
> path if the TLB entry is not valid at all (ie the TLB_INVALID
> bit is set).
> 
> Reported-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This fixes the abort that Laurent was seeing with his m68k test case.


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Also, queued to tcg-next.


r~
