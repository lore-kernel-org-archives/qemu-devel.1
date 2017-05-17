Received: from eggs.gnu.org ([2001:4830:134:3::10]:53972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnL7-00044l-N4
	for qemu-devel@nongnu.org; Tue, 16 May 2017 21:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnL3-0007Ay-3M
	for qemu-devel@nongnu.org; Tue, 16 May 2017 21:01:21 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnL2-0007Am-Vm
	for qemu-devel@nongnu.org; Tue, 16 May 2017 21:01:17 -0400
Received: by mail-qk0-x244.google.com with SMTP id u75so25165123qka.1
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 18:01:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170516224721.13832-1-aurelien@aurel32.net>
	<20170516224721.13832-2-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0e4f8f4e-4d19-8dd1-8a0e-f9aebdffa7d8@amsat.org>
Date: Tue, 16 May 2017 22:01:13 -0300
MIME-Version: 1.0
In-Reply-To: <20170516224721.13832-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/5] target/sh4: log unauthorized accesses
 using qemu_log_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/16/2017 07:47 PM, Aurelien Jarno wrote:
> qemu_log_mask() is preferred over fprintf() for logging errors.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/sh4/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/sh4/helper.c b/target/sh4/helper.c
> index 8f8ce81401..4c024f9529 100644
> --- a/target/sh4/helper.c
> +++ b/target/sh4/helper.c
> @@ -420,7 +420,7 @@ static int get_physical_address(CPUSH4State * env, target_ulong * physical,
>          if (!(env->sr & (1u << SR_MD))
>  	    && (address < 0xe0000000 || address >= 0xe4000000)) {
>  	    /* Unauthorized access in user mode (only store queues are available) */
> -	    fprintf(stderr, "Unauthorized access\n");
> +            qemu_log_mask(LOG_GUEST_ERROR, "Unauthorized access\n");
>  	    if (rw == 0)
>  		return MMU_DADDR_ERROR_READ;
>  	    else if (rw == 1)
>
