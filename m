Received: from eggs.gnu.org ([2001:4830:134:3::10]:35982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFJx-0003ko-5C
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFJu-0003qR-0W
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:30:57 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:41963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekFJt-0003q3-RU
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:30:53 -0500
Received: by mail-pg0-x241.google.com with SMTP id t4so3299265pgp.8
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 12:30:53 -0800 (PST)
References: <20180209165810.6668-1-peter.maydell@linaro.org>
	<20180209165810.6668-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0c59474d-f417-9acb-6027-0f2ef7261f03@linaro.org>
Date: Fri, 9 Feb 2018 12:30:50 -0800
MIME-Version: 1.0
In-Reply-To: <20180209165810.6668-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/11] hw/intc/armv7m_nvic: Fix ICSR
 PENDNMISET/CLR handling
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

On 02/09/2018 08:58 AM, Peter Maydell wrote:
> The PENDNMISET/CLR bits in the ICSR should be RAZ/WI from
> NonSecure state if the AIRCR.BFHFNMINS bit is zero. We had
> misimplemented this as making the bits RAZ/WI from both
> Secure and NonSecure states. Fix this bug by checking
> attrs.secure so that Secure code can pend and unpend NMIs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
