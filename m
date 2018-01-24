Received: from eggs.gnu.org ([2001:4830:134:3::10]:43735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eeKMK-0004RX-Ma
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eeKMC-0003T8-OP
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:40:56 -0500
References: <20180124101358.GA5028@bogon.m.sigxcpu.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <309602cf-58cf-7b1b-25f0-1ab01f3fbaa1@vivier.eu>
Date: Wed, 24 Jan 2018 13:40:35 +0100
MIME-Version: 1.0
In-Reply-To: <20180124101358.GA5028@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix register used for 6th and
 7th syscall argument on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Le 24/01/2018 à 11:13, Guido Günther a écrit :
> Unbreaks the testcase from
> 
>     http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html
> 
> Thanks to Laurent Vivier for spotting the 7th one.
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  linux-user/host/aarch64/safe-syscall.inc.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/host/aarch64/safe-syscall.inc.S b/linux-user/host/aarch64/safe-syscall.inc.S
> index 58a2329b37..bc1f5a9792 100644
> --- a/linux-user/host/aarch64/safe-syscall.inc.S
> +++ b/linux-user/host/aarch64/safe-syscall.inc.S
> @@ -36,7 +36,7 @@ safe_syscall_base:
>  	 *               and return the result in x0
>  	 * and the syscall instruction needs
>  	 *               x8 == syscall number
> -	 *               x0 ... x7 == syscall arguments
> +	 *               x0 ... x6 == syscall arguments
>  	 *               and returns the result in x0
>  	 * Shuffle everything around appropriately.
>  	 */
> @@ -47,8 +47,8 @@ safe_syscall_base:
>  	mov	x2, x4
>  	mov	x3, x5
>  	mov	x4, x6
> -	mov	x6, x7
> -	ldr	x7, [sp]
> +	mov	x5, x7
> +	ldr	x6, [sp]
>  
>  	/* This next sequence of code works in conjunction with the
>  	 * rewind_if_safe_syscall_function(). If a signal is taken
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

for your future patches (I hope there will be), if there are several
versions, add the version number in the Subject (i.e. "[PATCH v2]") and
version history below the signature mark ("---"):

   ...

   Signed-off-by: Guido Günther <agx@sigxcpu.org>
   ---
   v2: fix also 7th arg

     linux-user/host/aarch64/safe-syscall.inc.S | 6 +++---
     1 file changed, 3 insertions(+), 3 deletions(-)

   ...

Thanks,
Laurent
