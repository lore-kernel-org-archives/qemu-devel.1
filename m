Received: from eggs.gnu.org ([2001:4830:134:3::10]:38444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fFjY1-0006PP-Bg
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fFjXy-0007Ys-9L
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:37 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:36914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fFjXy-0007Y9-3O
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:34 -0400
Received: by mail-it0-x244.google.com with SMTP id 70-v6so12799616ity.2
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 10:03:33 -0700 (PDT)
References: <20180504100547.14621-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8fa77474-f9af-1569-0a41-14dff183a52b@linaro.org>
Date: Mon, 7 May 2018 10:03:30 -0700
MIME-Version: 1.0
In-Reply-To: <20180504100547.14621-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] softfloat: Handle default NaN mode after
 pickNaNMulAdd, not before
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-stable@nongnu.org, patches@linaro.org

On 05/04/2018 03:05 AM, Peter Maydell wrote:
> It is implementation defined whether a multiply-add of
> (0,inf,qnan) or (inf,0,qnan) raises InvalidaOperation or
> not, so we let the target-specific pickNaNMulAdd function
> handle this. This means that we must do the "return the
> default NaN in default NaN mode" check after the call,
> not before. Correct the ordering, and restore the comment
> from the old propagateFloat64MulAddNaN() that warned about
> this corner case.
> 
> This fixes a regression from 2.11 for Arm guests where we would
> incorrectly fail to set the Invalid flag for these cases.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  fpu/softfloat.c | 52 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
