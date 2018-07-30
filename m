Received: from eggs.gnu.org ([2001:4830:134:3::10]:43850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkBNM-0006kf-3a
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkBNI-00043u-Cp
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:50:28 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fkBNH-00042y-S1
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:50:24 -0400
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-8-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4bc391e5-9aac-57c6-7173-0fdd7a25bccc@vivier.eu>
Date: Mon, 30 Jul 2018 18:49:42 +0200
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-8-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 07/76] elf: Remove duplicate
 preprocessor constant definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

Le 30/07/2018 à 18:11, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Remove duplicate preprocessor constant definition for EF_MIPS_ARCH.
> 
> The duplicate was introduced in commit 45506bdd.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/elf.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/elf.h b/include/elf.h
> index 934dbbd..c8aaa2a 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -33,7 +33,6 @@ typedef int64_t  Elf64_Sxword;
>  
>  /* Flags in the e_flags field of the header */
>  /* MIPS architecture level. */
> -#define EF_MIPS_ARCH            0xf0000000
>  
>  /* Legal values for MIPS architecture level.  */
>  #define EF_MIPS_ARCH_1		0x00000000	/* -mips1 code.  */
> 

You should move the comment "MIPS architecture level" where the other
EF_MIPS_ARCH is defined (see glibc or system elf.h).

Thanks,
Laurent
