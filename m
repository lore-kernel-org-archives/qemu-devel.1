Received: from eggs.gnu.org ([209.51.188.92]:54419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkxNt-00024i-E5
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 15:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkxNs-00087Q-9h
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 15:38:28 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkxNr-00083i-2N
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 15:38:27 -0500
Received: by mail-pl1-x643.google.com with SMTP id b5so7897863plr.4
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 12:38:26 -0800 (PST)
References: <20190108180014.32386-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5ef47526-1794-df32-1bbe-fa29f8cd028c@linaro.org>
Date: Sun, 20 Jan 2019 07:38:18 +1100
MIME-Version: 1.0
In-Reply-To: <20190108180014.32386-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] accel/tcg/user-exec: Don't parse aarch64
 insns to test for read vs write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 1/9/19 5:00 AM, Peter Maydell wrote:
> In cpu_signal_handler() for aarch64 hosts, currently we parse
> the faulting instruction to see if it is a load or a store.
> Since the 3.16 kernel (~2014), the kernel has provided us with
> the syndrome register for a fault, which includes the WnR bit.
> Use this instead if it is present, only falling back to
> instruction parsing if not.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Since I originally asked the kernel folks to add the ESR context
> so we could use it in QEMU, I figured that it was about time
> (five years later...) to write the code to make use of it.
> 
> I wanted to say "everybody surely has at least a 3.16
> kernel for aarch64 machines" and delete the fallback code,
> but it turns out that the gcc compile farm box has 3.13.0...
> ---
>  accel/tcg/user-exec.c | 66 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 52 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I should note that we fail to generate esr_context from aarch64-linux-user.


r~
