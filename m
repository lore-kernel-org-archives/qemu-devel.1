Received: from eggs.gnu.org ([2001:4830:134:3::10]:48321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cbzJr-0006if-5X
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cbzJn-0008Ji-V1
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:44:11 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1cbzJn-0008J5-Pv
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:44:07 -0500
Received: by mail-pf0-x242.google.com with SMTP id b145so324244pfb.2
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 16:44:07 -0800 (PST)
Date: Fri, 10 Feb 2017 09:44:04 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170210004404.GM32144@lianli.shorne-pla.net>
References: <20170209045154.16868-1-rth@twiddle.net>
	<20170210000122.4173-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170210000122.4173-1-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 23/22] linux-user: Honor CLONE_SETTLS for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Openrisc <openrisc@lists.librecores.org>

23/22 ?

:)

On Fri, Feb 10, 2017 at 10:01:22AM +1000, Richard Henderson wrote:
> Threads work much better when you set the TLS register.
> This was fixed in the upstream kernel for Linux 4.9.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  linux-user/openrisc/target_cpu.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
> index a21ed1a..f283d96 100644
> --- a/linux-user/openrisc/target_cpu.h
> +++ b/linux-user/openrisc/target_cpu.h
> @@ -30,9 +30,7 @@ static inline void cpu_clone_regs(CPUOpenRISCState *env, target_ulong newsp)
>  
>  static inline void cpu_set_tls(CPUOpenRISCState *env, target_ulong newtls)
>  {
> -    /* Linux kernel 3.10 does not pay any attention to CLONE_SETTLS
> -     * in copy_thread(), so QEMU need not do so either.
> -     */
> +    env->gpr[10] = newtls;
>  }
>  
>  #endif
> -- 
> 2.9.3
> 

Reviewed-by: Stafford Horne <shorne@gmail.com>
