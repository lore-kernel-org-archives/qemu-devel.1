Received: from eggs.gnu.org ([2001:4830:134:3::10]:41914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euHht-0000UY-G9
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euHhp-0007B3-KZ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:05:09 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:41307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euHhp-00079d-DN
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:05:05 -0500
Received: by mail-wr0-x244.google.com with SMTP id f14so8946973wre.8
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 05:05:05 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-3-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6c32be34-d8dd-9884-154e-0a9926925c95@amsat.org>
Date: Fri, 9 Mar 2018 14:05:02 +0100
MIME-Version: 1.0
In-Reply-To: <1519998711-73430-3-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 02/23] RISC-V ELF Machine Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 03/02/2018 02:51 PM, Michael Clark wrote:
> Define RISC-V ELF machine EM_RISCV 243
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
> Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/elf.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/elf.h b/include/elf.h
> index 943ee21..c0dc9bb 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -119,6 +119,8 @@ typedef int64_t  Elf64_Sxword;
>  
>  #define EM_UNICORE32    110     /* UniCore32 */
>  
> +#define EM_RISCV        243     /* RISC-V */
> +
>  /*
>   * This is an interim value that we will use until the committee comes
>   * up with a final number.
> 
