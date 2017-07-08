Received: from eggs.gnu.org ([2001:4830:134:3::10]:35572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTtIE-0007iM-SX
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 13:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTtID-0007aO-RM
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 13:13:18 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170708025030.15845-1-rth@twiddle.net>
	<20170708025030.15845-4-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f2ea7f49-10f3-520c-4a0e-456a11934410@amsat.org>
Date: Sat, 8 Jul 2017 14:12:08 -0300
MIME-Version: 1.0
In-Reply-To: <20170708025030.15845-4-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/3] linux-user/sh4: Reduce
 TARGET_VIRT_ADDR_SPACE_BITS to 31
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, riku.voipio@iki.fi, laurent@vivier.eu, qemu-arm@nongnu.org

On 07/07/2017 11:50 PM, Richard Henderson wrote:
> The real kernel has TASK_SIZE as 0x7c000000, due to quirks with
> a couple of SH parts.  But nominally user-space is limited to 2GB.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/sh4/cpu.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index e3abb6a..3121d1e 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -45,7 +45,11 @@
>   #define TARGET_PAGE_BITS 12	/* 4k XXXXX */
>   
>   #define TARGET_PHYS_ADDR_SPACE_BITS 32
> -#define TARGET_VIRT_ADDR_SPACE_BITS 32
> +#ifdef CONFIG_USER_ONLY
> +# define TARGET_VIRT_ADDR_SPACE_BITS 31
> +#else
> +# define TARGET_VIRT_ADDR_SPACE_BITS 32
> +#endif
>   
>   #define SR_MD 30
>   #define SR_RB 29
> 
