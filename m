Received: from eggs.gnu.org ([2001:4830:134:3::10]:34916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7Y1-0004dQ-Uc
	for qemu-devel@nongnu.org; Fri, 25 May 2018 03:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7Xy-0005eO-SE
	for qemu-devel@nongnu.org; Fri, 25 May 2018 03:54:02 -0400
References: <1527232960-51123-1-git-send-email-mjc@sifive.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4926fd94-b29b-8dad-bbdb-e19729bfa39f@vivier.eu>
Date: Fri, 25 May 2018 09:53:48 +0200
MIME-Version: 1.0
In-Reply-To: <1527232960-51123-1-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] elf: Add RISC-V PSABI ELF header defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@groups.riscv.org, Michael Tokarev <mjt@tls.msk.ru>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <Alistair.Francis@wdc.com>

Le 25/05/2018 à 09:22, Michael Clark a écrit :
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
> index 934dbbd6b3ae..bd0493f43d19 100644
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
> +#define EF_RISCV_FLOAT_ABI_QUAD 0x0006
> +#define EF_RISCV_RVE 0x0008
> +#define EF_RISCV_TSO 0x0010
> +
>  typedef struct elf32_rel {
>    Elf32_Addr	r_offset;
>    Elf32_Word	r_info;
> 

from glibc (and binutils), I have:

  /* RISC-V ELF Flags */
  #define EF_RISCV_RVC                    0x0001
  #define EF_RISCV_FLOAT_ABI              0x0006
  #define EF_RISCV_FLOAT_ABI_SOFT         0x0000
  #define EF_RISCV_FLOAT_ABI_SINGLE       0x0002
  #define EF_RISCV_FLOAT_ABI_DOUBLE       0x0004
  #define EF_RISCV_FLOAT_ABI_QUAD         0x0006

Perhaps you can also define EF_RISCV_FLOAT_ABI_SOFT and EF_RISCV_FLOAT_ABI?

Anyway:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
