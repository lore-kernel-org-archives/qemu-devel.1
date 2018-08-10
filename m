Received: from eggs.gnu.org ([2001:4830:134:3::10]:48713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fo8jp-0002GH-L2
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fo8jm-0007xu-Ho
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:50:01 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:39425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fo8jm-0007xU-BY
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:49:58 -0400
Received: by mail-ua1-x943.google.com with SMTP id g18-v6so2115084uam.6
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 07:49:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1533574847-19294-11-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c9ac1c0d-e003-fdf2-c45c-b09177cf033f@amsat.org>
Date: Fri, 10 Aug 2018 11:49:50 -0300
MIME-Version: 1.0
In-Reply-To: <1533574847-19294-11-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 10/80] elf: Remove duplicate
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

On 08/06/2018 01:59 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Remove duplicate preprocessor constant definition for EF_MIPS_ARCH.
> 
> The duplicate was introduced in commit 45506bdd. It placed the
> constant EF_MIPS_ARCH in a better place, however it did not remove
> the original. This patch removes the original occurence.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/elf.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/elf.h b/include/elf.h
> index 934dbbd..60f6cbe 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -61,7 +61,6 @@ typedef int64_t  Elf64_Sxword;
>  #define EF_MIPS_ABI		0x0000f000
>  #define EF_MIPS_FP64      0x00000200
>  #define EF_MIPS_NAN2008   0x00000400
> -#define EF_MIPS_ARCH      0xf0000000
>  
>  /* These constants define the different elf file types */
>  #define ET_NONE   0
> 
