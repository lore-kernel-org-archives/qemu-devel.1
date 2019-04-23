Received: from eggs.gnu.org ([209.51.188.92]:51422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIzMe-00081U-VO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIzCl-0001NU-GA
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:27:40 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIzCl-0001Jt-7W
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:27:39 -0400
Received: by mail-pg1-x542.google.com with SMTP id v12so7961914pgq.1
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 10:27:38 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4a3a72f6-a450-b074-b8da-26fe6615ae59@linaro.org>
Date: Tue, 23 Apr 2019 10:27:34 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/26] hw/intc/armv7m_nvic: Allow reading
 of M-profile MVFR* registers
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
> For M-profile the MVFR* ID registers are memory mapped, in the
> range we implement via the NVIC. Allow them to be read.
> (If the CPU has no FPU, these registers are defined to be RAZ.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
