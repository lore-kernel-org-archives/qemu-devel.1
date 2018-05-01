Received: from eggs.gnu.org ([2001:4830:134:3::10]:37100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDeAY-00073I-Ah
	for qemu-devel@nongnu.org; Tue, 01 May 2018 18:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDeAV-0003g4-7d
	for qemu-devel@nongnu.org; Tue, 01 May 2018 18:54:46 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:45595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDeAV-0003fp-2k
	for qemu-devel@nongnu.org; Tue, 01 May 2018 18:54:43 -0400
Received: by mail-qt0-x241.google.com with SMTP id j42-v6so16207369qtj.12
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 15:54:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1525043888-90983-1-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f068146e-f715-9399-7596-6305e036fc67@amsat.org>
Date: Tue, 1 May 2018 19:54:38 -0300
MIME-Version: 1.0
In-Reply-To: <1525043888-90983-1-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Fix missing break statement in
 disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, patches@groups.riscv.org

On 04/29/2018 08:18 PM, Michael Clark wrote:
> This fixes an issue when disassembling rv128 c.sqsp,
> where the code erroneously fell through to c.swsp.
> 
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  disas/riscv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 74ad16eacdd3..ea19f6fbe2b1 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -1470,8 +1470,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>              if (isa == rv128) {
>                  op = rv_op_c_sqsp;
>              } else {
> -                op = rv_op_c_fsdsp; break;
> +                op = rv_op_c_fsdsp;
>              }
> +            break;
>          case 6: op = rv_op_c_swsp; break;
>          case 7:
>              if (isa == rv32) {
> 
