Received: from eggs.gnu.org ([209.51.188.92]:59927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ4PH-00037I-Jg
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ4If-0003g2-NV
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:54:08 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ4Ie-0003ck-D8
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:54:05 -0400
Received: by mail-pl1-x641.google.com with SMTP id o5so3899271pls.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:54:04 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d106ef4a-848a-2543-faba-7a5613788820@linaro.org>
Date: Tue, 23 Apr 2019 15:54:00 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/26] target/arm: Clean excReturn bits
 when tail chaining
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
> The TailChain() pseudocode specifies that a tail chaining
> exception should sanitize the excReturn all-ones bits and
> (if there is no FPU) the excReturn FType bits; we weren't
> doing this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
