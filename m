Received: from eggs.gnu.org ([2001:4830:134:3::10]:43491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cmhnV-0005FM-Ge
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 09:15:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cmhnS-00089n-DO
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 09:15:05 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:63559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cmhnS-00089L-2Q
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 09:15:02 -0500
References: <20170311034232.14213-1-rth@twiddle.net>
	<20170311034232.14213-3-rth@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <27335115-a7af-ca20-9ad2-751d61fe306f@vivier.eu>
Date: Sat, 11 Mar 2017 15:14:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170311034232.14213-3-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] linux-user: Fix TARGET_SA_* defines
 for HPPA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, deller@gmx.de, riku.voipio@iki.fi

Le 11/03/2017 à 04:42, Richard Henderson a écrit :
> From: Helge Deller <deller@gmx.de>
> 
> Reported-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> ---
>  linux-user/syscall_defs.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 8b1ad74..2620b56 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -473,6 +473,14 @@ int do_sigaction(int sig, const struct target_sigaction *act,
>  #define TARGET_SA_RESETHAND	0x00000010
>  #define TARGET_SA_NOCLDWAIT	0x00000020 /* not supported yet */
>  #define TARGET_SA_SIGINFO	0x00000040
> +#elif defined(TARGET_HPPA)
> +#define TARGET_SA_ONSTACK       0x00000001
> +#define TARGET_SA_RESETHAND     0x00000004
> +#define TARGET_SA_NOCLDSTOP     0x00000008
> +#define TARGET_SA_SIGINFO       0x00000010
> +#define TARGET_SA_NODEFER       0x00000020
> +#define TARGET_SA_RESTART       0x00000040
> +#define TARGET_SA_NOCLDWAIT     0x00000080
>  #else
>  #define TARGET_SA_NOCLDSTOP	0x00000001
>  #define TARGET_SA_NOCLDWAIT	0x00000002 /* not supported yet */
> 
