Received: from eggs.gnu.org ([209.51.188.92]:35301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ54J-0005fi-VB
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ4qc-0002a9-19
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:29:10 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:44549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ4qb-0002Xk-Dz
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:29:09 -0400
Received: by mail-pg1-x536.google.com with SMTP id z16so3753740pgv.11
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 16:29:08 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-16-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eabbae98-49a9-2d7e-5ad0-d1d45fa470f8@linaro.org>
Date: Tue, 23 Apr 2019 16:29:03 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/26] target/arm: Handle floating point
 registers in exception return
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
> Handle floating point registers in exception return.
> This corresponds to pseudocode functions ValidateExceptionReturn(),
> ExceptionReturn(), PopStack() and ConsumeExcStackFrame().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 142 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 141 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
