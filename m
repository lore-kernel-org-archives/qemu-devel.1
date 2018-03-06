Received: from eggs.gnu.org ([2001:4830:134:3::10]:38415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLiR-0002Mb-KM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLiM-0002rK-TK
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:09:51 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:37379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLiM-0002ql-MB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:09:46 -0500
Received: by mail-wr0-x241.google.com with SMTP id z12so303149wrg.4
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 15:09:46 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1520369037-37977-1-git-send-email-mjc@sifive.com>
	<1520369037-37977-19-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e7719b4b-ce44-695d-1a8b-21ea4d0a1b9b@amsat.org>
Date: Tue, 6 Mar 2018 20:09:43 -0300
MIME-Version: 1.0
In-Reply-To: <1520369037-37977-19-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 18/22] RISC-V: Remove braces from satp
 case statement with
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches no locals <patches@groups.riscv.org>

On 03/06/2018 05:43 PM, Michael Clark wrote:
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/riscv/op_helper.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index dd3e417..f79716a 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -240,7 +240,7 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
>          csr_write_helper(env, next_mie, CSR_MIE);
>          break;
>      }
> -    case CSR_SATP: /* CSR_SPTBR */ {
> +    case CSR_SATP: /* CSR_SPTBR */
>          if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
>              break;
>          }
> @@ -258,7 +258,6 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
>              env->satp = val_to_write;
>          }
>          break;
> -    }
>      case CSR_SEPC:
>          env->sepc = val_to_write;
>          break;
> 
