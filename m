Received: from eggs.gnu.org ([2001:4830:134:3::10]:59758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaAD-0004l2-5N
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaA9-0008D2-4L
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:18:33 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:43202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkaA8-0008Ci-Us
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:18:29 -0400
Received: by mail-vk0-x241.google.com with SMTP id s17-v6so8077758vke.10
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 12:18:28 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-49-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <424a535e-1b51-0d21-ab8e-ad0f041d398e@linaro.org>
Date: Tue, 31 Jul 2018 15:18:23 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-49-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 48/76] target/mips: Adjust behavior of
 Config3's ISAOnExc bit for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
> From: Yongbok Kim <yongbok.kim@mips.com>
> 
> Config3.ISAOnExc is read only in nanoMIPS.
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/op_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index cb83b6d..5e10286 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -1730,7 +1730,8 @@ void helper_mtc0_config2(CPUMIPSState *env, target_ulong arg1)
>  
>  void helper_mtc0_config3(CPUMIPSState *env, target_ulong arg1)
>  {
> -    if (env->insn_flags & ASE_MICROMIPS) {
> +    if ((env->insn_flags & ASE_MICROMIPS) &&
> +        !(env->insn_flags & ISA_NANOMIPS32)) {'

Didn't we say nanomips does not include micromips?


r~
