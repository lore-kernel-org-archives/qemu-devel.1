Received: from eggs.gnu.org ([2001:4830:134:3::10]:49842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nfP-0000Zq-VO
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nfO-0008PP-38
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:22:43 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7nfN-0008IO-JY
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:22:41 -0400
Received: by mail-ot1-x343.google.com with SMTP id e18-v6so6906824oti.8
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 13:22:33 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <17fe3940-f083-86d6-80b0-24be651be902@linaro.org>
Date: Wed, 3 Oct 2018 15:22:29 -0500
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/13] target/arm: Add v8M stack checks for
 MSR to SP_NS
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

On 10/2/18 11:35 AM, Peter Maydell wrote:
> Updating the NS stack pointer via MSR to SP_NS should include
> a check whether the new SP value is below the stack limit.
> No other kinds of update to the various stack pointer and
> limit registers via MSR should perform a check.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
