Received: from eggs.gnu.org ([2001:4830:134:3::10]:48943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fLNVS-00080F-Ci
	for qemu-devel@nongnu.org; Wed, 23 May 2018 02:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fLNVP-0006UQ-9c
	for qemu-devel@nongnu.org; Wed, 23 May 2018 02:44:18 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51239)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fLNVP-0006Tn-01
	for qemu-devel@nongnu.org; Wed, 23 May 2018 02:44:15 -0400
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-28-git-send-email-mjc@sifive.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <55782969-dd50-ae80-8006-ed53c3d48ca5@vivier.eu>
Date: Wed, 23 May 2018 08:44:04 +0200
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-28-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 27/30] elf: Add RISC-V PSABI ELF header
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Tokarev <mjt@tls.msk.ru>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <Alistair.Francis@wdc.com>

Le 23/05/2018 à 02:15, Michael Clark a écrit :
> Refer to the RISC-V PSABI specification for details:
> 
> - https://github.com/riscv/riscv-elf-psabi-doc/blob/master/riscv-elf.md
> 
> Cc: Michael Tokarev <mjt@tls.msk.ru>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  include/elf.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/elf.h b/include/elf.h
> index 934dbbd6b3ae..d363ba85a688 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -1285,6 +1285,14 @@ typedef struct {
>  #define R_IA64_DTPREL64LSB	0xb7	/* @dtprel(sym + add), data8 LSB */
>  #define R_IA64_LTOFF_DTPREL22	0xba	/* @ltoff(@dtprel(s+a)), imm22 */
>  
> +/* RISC-V specific definitions.  */
> +#define EF_RISCV_RVC 0x0001
> +#define EF_RISCV_FLOAT_ABI_SINGLE 0x0002
> +#define EF_RISCV_FLOAT_ABI_DOUBLE 0x0004
> +#define EF_RISCV_FLOAT_ABI_QUAD (0x0006
                                   ^
Typo here -------------------------|

Thanks,
Laurent
