Received: from eggs.gnu.org ([2001:4830:134:3::10]:33697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7n7N-0007xM-Bx
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7n7K-0006NQ-7t
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:47:33 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7n7J-0006Is-V9
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:47:30 -0400
Received: by mail-ot1-x341.google.com with SMTP id j9-v6so6812804otl.2
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 12:47:20 -0700 (PDT)
References: <20181002145940.30931-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f84fdc9b-b3a0-3e0a-19b6-cccade36dc97@linaro.org>
Date: Wed, 3 Oct 2018 14:47:14 -0500
MIME-Version: 1.0
In-Reply-To: <20181002145940.30931-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Correct condition for v8M
 callee stack push
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

On 10/2/18 9:59 AM, Peter Maydell wrote:
> In v7m_exception_taken() we were incorrectly using a
> "LR bit EXCRET.ES is 1" check when it should be 0
> (compare the pseudocode ExceptionTaken() function).
> This meant we didn't stack the callee-saved registers
> when tailchaining from a NonSecure to a Secure exception.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
