Received: from eggs.gnu.org ([209.51.188.92]:60603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ3nG-00083C-MF
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ3nC-00067h-T0
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:21:36 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ3n6-00062y-B8
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:21:31 -0400
Received: by mail-pl1-x641.google.com with SMTP id t16so8215493plo.0
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:21:25 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1ef6fe28-b339-c05b-b116-079f1afbe13e@linaro.org>
Date: Tue, 23 Apr 2019 15:21:20 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/26] target/arm: Handle floating point
 registers in exception entry
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
> Handle floating point registers in exception entry.
> This corresponds to the FP-specific parts of the pseudocode
> functions ActivateException() and PushStack().
> 
> We defer the code corresponding to UpdateFPCCR() to a later patch.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 98 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 95 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
