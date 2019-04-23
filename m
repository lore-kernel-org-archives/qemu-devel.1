Received: from eggs.gnu.org ([209.51.188.92]:51579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIzMw-00084F-7e
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIzAy-0006z3-Dw
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:25:49 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIzAw-0006dU-D7
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:25:46 -0400
Received: by mail-pl1-x642.google.com with SMTP id b3so7858328plr.7
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 10:25:32 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6b64b6e8-9099-7410-2e20-ce2dba7c0506@linaro.org>
Date: Tue, 23 Apr 2019 10:25:27 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/26] target/arm: Make sure M-profile
 FPSCR RES0 bits are not settable
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
> Enforce that for M-profile various FPSCR bits which are RES0 there
> but have defined meanings on A-profile are never settable. This
> ensures that M-profile code can't enable the A-profile behaviour
> (notably vector length/stride handling) by accident.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/vfp_helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
