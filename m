Received: from eggs.gnu.org ([2001:4830:134:3::10]:38559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgY6Q-000266-5F
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgY6N-0001jq-0T
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:17:58 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgY6M-0001jR-PQ
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:17:54 -0400
Received: by mail-pg1-x541.google.com with SMTP id s7-v6so3850115pgv.3
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 09:17:54 -0700 (PDT)
References: <20180720145647.8810-1-peter.maydell@linaro.org>
	<20180720145647.8810-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d2e23df0-bfd0-3f32-993c-461313fc4aa8@linaro.org>
Date: Fri, 20 Jul 2018 09:17:51 -0700
MIME-Version: 1.0
In-Reply-To: <20180720145647.8810-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] target/arm: Initialize exc_secure
 correctly in do_v7m_exception_exit()
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

On 07/20/2018 07:56 AM, Peter Maydell wrote:
> In do_v7m_exception_exit(), we use the exc_secure variable to track
> whether the exception we're returning from is secure or non-secure.
> Unfortunately the statement initializing this was accidentally
> inside an "if (env->v7m.exception != ARMV7M_EXCP_NMI)" conditional,
> which meant that we were using the wrong value for NMI handlers.
> Move the initialization out to the right place.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
