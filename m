Received: from eggs.gnu.org ([2001:4830:134:3::10]:49241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDx1R-0004gO-Ur
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 15:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDx1L-0006R3-Op
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 15:34:53 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDx1L-0006Qk-Cb
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 15:34:47 -0400
Received: by mail-pf1-x443.google.com with SMTP id f78-v6so12232703pfe.1
	for <qemu-devel@nongnu.org>; Sat, 20 Oct 2018 12:34:47 -0700 (PDT)
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-4-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <17e84b24-eae4-fd90-8a99-204cfa459eaf@linaro.org>
Date: Sat, 20 Oct 2018 12:34:43 -0700
MIME-Version: 1.0
In-Reply-To: <20181020071451.27808-4-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/29] target/riscv: Convert RVXI branch
 insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/20/18 12:14 AM, Bastian Koppelmann wrote:
> -    case OPC_RISC_AUIPC:
> -        if (rd == 0) {
> -            break; /* NOP */
> -        }
> -        tcg_gen_movi_tl(cpu_gpr[rd], (sextract64(ctx->opcode, 12, 20) << 12) +
> -               ctx->base.pc_next);
> -        break;

This should have been in the previous patch.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
