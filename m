Received: from eggs.gnu.org ([2001:4830:134:3::10]:57688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWQFs-0004gO-Iq
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWQFo-0000Sr-8q
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:53:52 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:35663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fWQFn-0000SY-OR
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:53:48 -0400
Received: by mail-pl0-x243.google.com with SMTP id k1-v6so3833720plt.2
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 10:53:47 -0700 (PDT)
References: <1529689531-4024-1-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef642140-0ce4-edf9-261e-2eef4bdfe394@linaro.org>
Date: Fri, 22 Jun 2018 10:53:43 -0700
MIME-Version: 1.0
In-Reply-To: <1529689531-4024-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: fix --disable-tcg build breakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 06/22/2018 10:45 AM, Emilio G. Cota wrote:
> Fix the --disable-tcg breakage introduced by tb_lock's removal by
> relying on the fact that tcg_enabled() is set to 0 at
> compile-time under --disable-tcg.
> 
> While at it, add further asserts to fix builds that enable both
> --disable-tcg and --enable-debug, which were broken even before
> tb_lock's removal.
> 
> Tested to build x86_64-softmmu and i386-softmmu targets.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/stubs/tcg-stub.c | 4 ----
>  cpus.c                 | 4 ++++
>  exec.c                 | 3 +++
>  3 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Peter, I'm assuming you'll take this directly to master as a build fix.


r~
