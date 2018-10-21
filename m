Received: from eggs.gnu.org ([2001:4830:134:3::10]:39452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDPw-0004B7-M2
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDLZ-0004qo-AF
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:00:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDLZ-0004qF-3Q
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:00:45 -0400
Received: by mail-wm1-x335.google.com with SMTP id 193-v6so7642876wme.3
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:00:44 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-14-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cf3e7f4a-e976-4529-2abd-4ff1ec209f21@linaro.org>
Date: Sun, 21 Oct 2018 14:00:41 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-14-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 13/56] lm32: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/lm32/op_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

+++ b/target/lm32/op_helper.c
> @@ -31,7 +31,7 @@ void HELPER(hlt)(CPULM32State *env)
>  {
>      CPUState *cs = CPU(lm32_env_get_cpu(env));
>  
> -    cs->halted = 1;
> +    cpu_halted_set(cs, 1);
>      cs->exception_index = EXCP_HLT;
>      cpu_loop_exit(cs);

I am beginning to think this sequence of three should be its own helper...


r~
