Received: from eggs.gnu.org ([2001:4830:134:3::10]:33906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7n7j-00089G-K6
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7n7c-0006aj-Ne
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:47:53 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7n7c-0006ZY-3h
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:47:48 -0400
Received: by mail-ot1-x341.google.com with SMTP id i12-v6so6840692otl.1
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 12:47:47 -0700 (PDT)
References: <20181002150304.2287-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8aa572b9-e354-e610-030c-d8f5cfde509c@linaro.org>
Date: Wed, 3 Oct 2018 14:47:42 -0500
MIME-Version: 1.0
In-Reply-To: <20181002150304.2287-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Don't read r4 from v8M
 exception stackframe twice
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

On 10/2/18 10:03 AM, Peter Maydell wrote:
> A cut-and-paste error meant we were reading r4 from the v8M
> callee-saves exception stack frame twice. This is harmless
> since it just meant we did two memory accesses to the same
> location, but it's unnecessary. Delete it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
