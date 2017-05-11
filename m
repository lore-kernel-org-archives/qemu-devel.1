Received: from eggs.gnu.org ([2001:4830:134:3::10]:52149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1d8jg3-0006wX-HX
	for qemu-devel@nongnu.org; Thu, 11 May 2017 04:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1d8jfy-0004PD-Lp
	for qemu-devel@nongnu.org; Thu, 11 May 2017 04:42:27 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1d8jfy-0004OH-BW
	for qemu-devel@nongnu.org; Thu, 11 May 2017 04:42:22 -0400
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-6-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <06376c63-cf60-5496-60a3-d6b1a129f397@vivier.eu>
Date: Thu, 11 May 2017 10:41:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170510200535.13268-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/8] target/m68k: optimize bcd_flags()
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Le 10/05/2017 à 22:05, Philippe Mathieu-Daudé a écrit :
> Applied using Coccinelle script.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/m68k/translate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 9f60fbc0db..babb9e2c5b 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -1463,8 +1463,7 @@ static void bcd_flags(TCGv val)
>      tcg_gen_andi_i32(QREG_CC_C, val, 0x0ff);
>      tcg_gen_or_i32(QREG_CC_Z, QREG_CC_Z, QREG_CC_C);
>  
> -    tcg_gen_shri_i32(QREG_CC_C, val, 8);
> -    tcg_gen_andi_i32(QREG_CC_C, QREG_CC_C, 1);
> +    tcg_gen_extract_i32(QREG_CC_C, val, 8, 1);
>  
>      tcg_gen_mov_i32(QREG_CC_X, QREG_CC_C);
>  }
> 

Acked-by: Laurent Vivier <laurent@vivier.eu>
