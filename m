Received: from eggs.gnu.org ([2001:4830:134:3::10]:37623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cmd6v-0001Po-EU
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 04:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cmd6r-0001l6-GP
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 04:14:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:52876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1cmd6r-0001jT-5K
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 04:14:45 -0500
References: <20170311034232.14213-1-rth@twiddle.net>
	<20170311034232.14213-3-rth@twiddle.net>
From: Helge Deller <deller@gmx.de>
Message-ID: <e1755464-984c-36fd-266c-00e230fe085b@gmx.de>
Date: Sat, 11 Mar 2017 10:14:28 +0100
MIME-Version: 1.0
In-Reply-To: <20170311034232.14213-3-rth@twiddle.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
Cc: peter.maydell@linaro.org, riku.voipio@iki.fi

On 11.03.2017 04:42, Richard Henderson wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Reported-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Signed-off-by: Helge Deller <deller@gmx.de>


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
