Received: from eggs.gnu.org ([209.51.188.92]:35632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ4TD-0006VK-68
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ4T7-0004Se-KV
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:04:58 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ4T7-0004Lx-1P
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:04:53 -0400
Received: by mail-pl1-x643.google.com with SMTP id o5so3911244pls.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 16:04:46 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20f5f564-6d0b-0c28-00e9-b7f2ac46a409@linaro.org>
Date: Tue, 23 Apr 2019 16:04:43 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/26] target/arm: Allow for floating point
 in callee stack integrity check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 4/16/19 5:57 AM, Peter Maydell wrote:
> The magic value pushed onto the callee stack as an integrity
> check is different if floating point is present.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
