Received: from eggs.gnu.org ([2001:4830:134:3::10]:55851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0wso-0007e9-V0
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 18:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0wsl-0000LW-Qn
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 18:15:58 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:44753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0wsl-0000LB-MT
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 18:15:55 -0400
Received: by mail-qt0-x242.google.com with SMTP id j26so520618qtl.11
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 15:15:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1522180547-22956-1-git-send-email-mjc@sifive.com>
	<1522180547-22956-3-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <37a9042b-1401-13dc-a062-eb0014ec2716@amsat.org>
Date: Tue, 27 Mar 2018 19:15:50 -0300
MIME-Version: 1.0
In-Reply-To: <1522180547-22956-3-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] RISC-V: Fix incorrect disassembly
 for addiw
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

On 03/27/2018 04:55 PM, Michael Clark wrote:
> This fixes a bug in the disassembler constraints used
> to lift instructions into pseudo-instructions, whereby
> addiw instructions are always lifted to sext.w instead
> of just lifting addiw with a zero immediate.
> 
> An associated fix has been made to the metadata used to
> machine generate the disseasembler:
> 
> https://github.com/michaeljclark/riscv-meta/
> commit/4a6b2f3898430768acfe201405224d2ea31e1477
> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  disas/riscv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 3c17501..74ad16e 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -600,7 +600,7 @@ static const rvc_constraint rvcc_mv[] = { rvc_imm_eq_zero, rvc_end };
>  static const rvc_constraint rvcc_not[] = { rvc_imm_eq_n1, rvc_end };
>  static const rvc_constraint rvcc_neg[] = { rvc_rs1_eq_x0, rvc_end };
>  static const rvc_constraint rvcc_negw[] = { rvc_rs1_eq_x0, rvc_end };
> -static const rvc_constraint rvcc_sext_w[] = { rvc_rs2_eq_x0, rvc_end };
> +static const rvc_constraint rvcc_sext_w[] = { rvc_imm_eq_zero, rvc_end };
>  static const rvc_constraint rvcc_seqz[] = { rvc_imm_eq_p1, rvc_end };
>  static const rvc_constraint rvcc_snez[] = { rvc_rs1_eq_x0, rvc_end };
>  static const rvc_constraint rvcc_sltz[] = { rvc_rs2_eq_x0, rvc_end };
> 
