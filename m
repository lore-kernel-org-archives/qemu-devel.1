Received: from eggs.gnu.org ([2001:4830:134:3::10]:40558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fo09S-00040p-Al
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fo09P-0001gx-5A
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:39:54 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:40329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fo09O-0001gf-Tj
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:39:51 -0400
Received: by mail-ua1-x942.google.com with SMTP id m13-v6so705130uaq.7
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 22:39:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1533574847-19294-12-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fe45ed7f-d25c-b961-c722-00c85965ff4b@amsat.org>
Date: Fri, 10 Aug 2018 02:39:43 -0300
MIME-Version: 1.0
In-Reply-To: <1533574847-19294-12-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 11/80] elf: Add ELF flags for MIPS
 machine variants
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
> Add MIPS machine variants ELF flags so that the emulation behavior
> can be adjusted if needed.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  include/elf.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/include/elf.h b/include/elf.h
> index 60f6cbe..002a002 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -62,6 +62,29 @@ typedef int64_t  Elf64_Sxword;
>  #define EF_MIPS_FP64      0x00000200
>  #define EF_MIPS_NAN2008   0x00000400
>  
> +/* MIPS machine variant */
> +#define EF_MIPS_MACH_NONE     0x00000000  /* A standard MIPS implementation  */
> +#define EF_MIPS_MACH_3900     0x00810000  /* Toshiba R3900                   */

Yeah \o/

> +#define EF_MIPS_MACH_4010     0x00820000  /* LSI R4010                       */
> +#define EF_MIPS_MACH_4100     0x00830000  /* NEC VR4100                      */
> +#define EF_MIPS_MACH_4650     0x00850000  /* MIPS R4650                      */
> +#define EF_MIPS_MACH_4120     0x00870000  /* NEC VR4120                      */
> +#define EF_MIPS_MACH_4111     0x00880000  /* NEC VR4111/VR4181               */
> +#define EF_MIPS_MACH_SB1      0x008a0000  /* Broadcom SB-1                   */
> +#define EF_MIPS_MACH_OCTEON   0x008b0000  /* Cavium Networks Octeon          */
> +#define EF_MIPS_MACH_XLR      0x008c0000  /* RMI Xlr                         */
> +#define EF_MIPS_MACH_OCTEON2  0x008d0000  /* Cavium Networks Octeon2         */
> +#define EF_MIPS_MACH_OCTEON3  0x008e0000  /* Cavium Networks Octeon3         */
> +#define EF_MIPS_MACH_5400     0x00910000  /* NEC VR5400                      */
> +#define EF_MIPS_MACH_5900     0x00920000  /* MIPS R5900                      */
> +#define EF_MIPS_MACH_5500     0x00980000  /* NEC VR5500                      */
> +#define EF_MIPS_MACH_9000     0x00990000  /* Unknown                         */

This is the PMC-Sierra's RM9000.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +#define EF_MIPS_MACH_LS2E     0x00a00000  /* ST Microelectronics Loongson 2E */
> +#define EF_MIPS_MACH_LS2F     0x00a10000  /* ST Microelectronics Loongson 2F */
> +#define EF_MIPS_MACH_LS3A     0x00a20000  /* Loongson 3A                     */
> +#define EF_MIPS_MACH          0x00ff0000  /* EF_MIPS_MACH_xxx selection mask */
> +
> +
>  /* These constants define the different elf file types */
>  #define ET_NONE   0
>  #define ET_REL    1
> 
