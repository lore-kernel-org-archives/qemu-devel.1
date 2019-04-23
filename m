Received: from eggs.gnu.org ([209.51.188.92]:60021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ4PM-0003Fc-18
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ4FI-0006jb-BV
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:50:37 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ4FI-0006h4-1O
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:50:36 -0400
Received: by mail-pl1-x642.google.com with SMTP id n8so8212396plp.10
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:50:35 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <67aeb166-5e80-668a-33aa-3c556a843ecd@linaro.org>
Date: Tue, 23 Apr 2019 15:50:31 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/26] target/arm: Clear CONTROL.SFPA in
 BXNS and BLXNS
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
> For v8M floating point support, transitions from Secure
> to Non-secure state via BLNS and BLXNS must clear the
> CONTROL.SFPA bit. (This corresponds to the pseudocode
> BranchToNS() function.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
