Received: from eggs.gnu.org ([2001:4830:134:3::10]:35778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nCQ-00043r-9g
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nCK-0000Pp-Sq
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:52:45 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:39424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7nCK-0000PF-Fx
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:52:40 -0400
Received: by mail-it1-x144.google.com with SMTP id w200-v6so10718483itc.4
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 12:52:40 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <edfe4785-e9ea-2b6c-fd98-4852713651b9@linaro.org>
Date: Wed, 3 Oct 2018 14:52:35 -0500
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/13] target/arm: Define new EXCP type for
 v8M stack overflows
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
> Define EXCP_STKOF, and arrange for it to cause us to take
> a UsageFault with CFSR.STKOF set.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h    | 2 ++
>  target/arm/helper.c | 5 +++++
>  2 files changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
