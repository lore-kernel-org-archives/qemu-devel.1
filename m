Received: from eggs.gnu.org ([2001:4830:134:3::10]:46254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eliYE-0006dm-UB
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 16:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eliYB-0003tD-SN
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 16:55:47 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eliYB-0003sv-LP
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 16:55:43 -0500
Date: Tue, 13 Feb 2018 16:55:41 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180213215541.GA1816@flamenco>
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-10-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518053328-34687-10-git-send-email-mjc@sifive.com>
Subject: Re: [Qemu-devel] [PATCH v5 09/23] RISC-V TCG Code Generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Thu, Feb 08, 2018 at 14:28:34 +1300, Michael Clark wrote:
> TCG code generation for the RV32IMAFDC and RV64IMAFDC. The QEMU
> RISC-V code generator has complete coverage for the Base ISA v2.2,
> Privileged ISA v1.9.1 and Privileged ISA v1.10:
> 
> - RISC-V Instruction Set Manual Volume I: User-Level ISA Version 2.2
> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.9.1
> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.10
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
(snip)
> +++ b/target/riscv/translate.c
(snip)
> +enum {
> +    BS_NONE     = 0, /* When seen outside of translation while loop, indicates
> +                     need to exit tb due to end of page. */
> +    BS_STOP     = 1, /* Need to exit tb for syscall, sret, etc. */

Are we planning to use BS_STOP in the future? I see it has no setters,
although we check for it in gen_intermediate_code:

(snip)
> +    switch (ctx.bstate) {
> +    case BS_STOP:
> +        gen_goto_tb(&ctx, 0, ctx.pc);
> +        break;
> +    case BS_NONE: /* handle end of page - DO NOT CHAIN. See gen_goto_tb. */

Should we get rid of it?

		Emilio
