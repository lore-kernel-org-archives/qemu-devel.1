Received: from eggs.gnu.org ([2001:4830:134:3::10]:50905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gL488-0002sO-Ro
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gL483-0001qc-Rf
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:35:12 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:50939)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gL483-0001pV-Gs
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:35:07 -0500
References: <cover.1541701393.git.noring@nocrew.org>
	<5bea109f0c140da6a821aa7f9705d4b3717e86dc.1541701393.git.noring@nocrew.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f1b41add-dc8c-e3ae-e658-de69fcf9bb76@vivier.eu>
Date: Fri, 9 Nov 2018 11:34:47 +0100
MIME-Version: 1.0
In-Reply-To: <5bea109f0c140da6a821aa7f9705d4b3717e86dc.1541701393.git.noring@nocrew.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user/mips: Support the n32 ABI
 for the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?J=c3=bcrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org, "Maciej W. Rozycki" <macro@linux-mips.org>

On 08/11/2018 19:43, Fredrik Noring wrote:
> Recognise the R5900, which reports itself as MIPS III, as a 64-bit CPU
> supporting the n32 ABI.
> 
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---
>  linux-user/mips64/target_elf.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
> index ec55d8542a..5f2f2df29f 100644
> --- a/linux-user/mips64/target_elf.h
> +++ b/linux-user/mips64/target_elf.h
> @@ -12,6 +12,9 @@ static inline const char *cpu_get_model(uint32_t eflags)
>      if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_64R6) {
>          return "I6400";
>      }
> +    if ((eflags & EF_MIPS_MACH) == EF_MIPS_MACH_5900) {
> +        return "R5900";
> +    }
>      return "5KEf";
>  }
>  #endif
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
