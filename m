Received: from eggs.gnu.org ([209.51.188.92]:35833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnpW8-0002aH-MC
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 13:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnpW6-000804-Op
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 13:50:52 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:36960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnpW2-0007vB-S7
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 13:50:48 -0500
Received: by mail-pf1-x432.google.com with SMTP id y126so6988685pfb.4
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 10:50:38 -0800 (PST)
References: <20190127014440.21789-1-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9cb57f2c-c727-5a3a-248b-8d53e2309c25@linaro.org>
Date: Sun, 27 Jan 2019 10:50:34 -0800
MIME-Version: 1.0
In-Reply-To: <20190127014440.21789-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: drop function
 xtensa_timer_irq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org

On 1/26/19 5:44 PM, Max Filippov wrote:
> It's a one-liner used in a single place, move its implementation there
> and remove its declaration.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  hw/xtensa/pic_cpu.c | 7 +------
>  target/xtensa/cpu.h | 1 -
>  2 files changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
