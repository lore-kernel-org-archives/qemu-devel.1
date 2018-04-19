Received: from eggs.gnu.org ([2001:4830:134:3::10]:45517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9FF6-0006Sz-9j
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9FF3-00072n-5G
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:29:16 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:37668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9FF2-000727-UL
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:29:13 -0400
Received: by mail-pl0-x243.google.com with SMTP id f7-v6so3830941plr.4
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 12:29:12 -0700 (PDT)
References: <20180419142106.9694-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a490be15-a9ab-bd0e-4336-68ca42426b0f@linaro.org>
Date: Thu, 19 Apr 2018 09:29:08 -1000
MIME-Version: 1.0
In-Reply-To: <20180419142106.9694-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Use v7m_stack_read() for
 reading the frame signature
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

On 04/19/2018 04:21 AM, Peter Maydell wrote:
> In commit 95695effe8caa552b8f2 we changed the v7M/v8M stack
> pop code to use a new v7m_stack_read() function that checks
> whether the read should fail due to an MPU or bus abort.
> We missed one call though, the one which reads the signature
> word for the callee-saved register part of the frame.
> 
> Correct the omission.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
