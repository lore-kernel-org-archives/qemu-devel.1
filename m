Received: from eggs.gnu.org ([2001:4830:134:3::10]:33753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHXKv-0004Bn-GU
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHXKp-0002pH-Jg
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:57:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHXKp-0002oA-9M
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:57:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id y144-v6so11993619wmd.4
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 09:57:43 -0700 (PDT)
References: <1540914249-3392-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540914249-3392-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6fc20783-b43a-dff6-3189-f980bb2f3af8@redhat.com>
Date: Tue, 30 Oct 2018 17:57:39 +0100
MIME-Version: 1.0
In-Reply-To: <1540914249-3392-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/5] target/mips: Misc R5900-related
 cosmetic changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: smarkovic@wavecomp.com, pjovanovic@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 30/10/18 16:44, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Misc changes in comments and strings for R5900.
> 
> Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   target/mips/translate_init.inc.c | 12 ------------
>   1 file changed, 12 deletions(-)
> 
> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
> index 85da4a2..cab2003 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -411,18 +411,6 @@ const mips_def_t mips_defs[] =
>           .mmu_type = MMU_TYPE_R4000,
>       },
>       {
> -        /*
> -         * The Toshiba TX System RISC TX79 Core Architecture manual
> -         *
> -         * https://wiki.qemu.org/File:C790.pdf

I still think a single line comment with this URL is well placed here.
This is the entry point to all R5900 specific code.
Anyway, your call.

> -         *
> -         * describes the C790 processor that is a follow-up to the R5900.
> -         * There are a few notable differences in that the R5900 FPU
> -         *
> -         * - is not IEEE 754-1985 compliant,
> -         * - does not implement double format, and
> -         * - its machine code is nonstandard.
> -         */
>           .name = "R5900",
>           .CP0_PRid = 0x00002E00,
>           /* No L2 cache, icache size 32k, dcache size 32k, uncached coherency. */
> 
