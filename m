Received: from eggs.gnu.org ([2001:4830:134:3::10]:49705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1cP6pM-0006NT-K7
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:07:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1cP6pI-0004oq-OD
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:07:28 -0500
Received: from jessie.kos.to ([212.47.231.226]:41334 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1cP6pI-0004kY-Hx
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:07:24 -0500
Date: Thu, 5 Jan 2017 12:07:18 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20170105120718.GA19094@kos.to>
References: <1477508932-5827-1-git-send-email-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1477508932-5827-1-git-send-email-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Fix s390x safe-syscall for
 z900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Wed, Oct 26, 2016 at 12:08:52PM -0700, Richard Henderson wrote:
> The LT instruction was added in the extended immediate facility
> introduced with the z9-109 processor.

Sorry I missed this during 2.8. This is stable-2.8 material once it
opens. Applied to linux-user now, thanks.
 
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Fixes: c9bc3437a905b660561a26cd4ecc64579843267b
> Suggested-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  linux-user/host/s390x/safe-syscall.inc.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/host/s390x/safe-syscall.inc.S b/linux-user/host/s390x/safe-syscall.inc.S
> index f1b446a..414b44a 100644
> --- a/linux-user/host/s390x/safe-syscall.inc.S
> +++ b/linux-user/host/s390x/safe-syscall.inc.S
> @@ -72,7 +72,7 @@ safe_syscall_base:
>  	 */
>  safe_syscall_start:
>  	/* if signal_pending is non-zero, don't do the call */
> -	lt	%r0,0(%r8)
> +	icm	%r0,15,0(%r8)
>  	jne	2f
>  	svc	0
>  safe_syscall_end:
> -- 
> 2.7.4
> 
