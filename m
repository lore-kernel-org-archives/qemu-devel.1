Received: from eggs.gnu.org ([2001:4830:134:3::10]:39063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ddMVP-0004KA-Ct
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 16:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ddMVL-0000bW-4h
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 16:14:03 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:36560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ddMVL-0000ZA-07
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 16:13:59 -0400
Received: by mail-pg0-x22e.google.com with SMTP id v77so10304282pgb.3
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 13:13:57 -0700 (PDT)
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <14c11400-2b2e-57b1-075e-09869dbb2801@linaro.org>
Date: Thu, 3 Aug 2017 13:13:53 -0700
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/15] target/arm: Use MMUAccessType enum
 rather than int
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

On 08/02/2017 09:43 AM, Peter Maydell wrote:
> In the ARM get_phys_addr() code, switch to using the MMUAccessType
> enum and its MMU_* values rather than int and literal 0/1/2.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c    | 30 +++++++++++++++---------------
>  target/arm/internals.h |  3 ++-
>  2 files changed, 17 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
