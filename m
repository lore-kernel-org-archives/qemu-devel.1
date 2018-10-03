Received: from eggs.gnu.org ([2001:4830:134:3::10]:35257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nBB-0002Mj-Hh
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nB9-0008Nm-DI
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:51:28 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:45749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7nB6-0008Hr-DA
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:51:24 -0400
Received: by mail-io1-xd44.google.com with SMTP id e12-v6so6026212iok.12
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 12:51:12 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <135ffcab-c668-9238-48b6-07346866fe29@linaro.org>
Date: Wed, 3 Oct 2018 14:51:06 -0500
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/13] target/arm: Define new TBFLAG for
 v8M stack checking
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
> The Arm v8M architecture includes hardware stack limit checking.
> When certain instructions update the stack pointer, if the new
> value of SP is below the limit set in the associated limit register
> then an exception is taken. Add a TB flag that tracks whether
> the limit-checking code needs to be emitted.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       |  7 +++++++
>  target/arm/translate.h |  1 +
>  target/arm/helper.c    | 10 ++++++++++
>  target/arm/translate.c |  1 +
>  4 files changed, 19 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
