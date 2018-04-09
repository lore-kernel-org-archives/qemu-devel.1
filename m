Received: from eggs.gnu.org ([2001:4830:134:3::10]:41161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f5XhG-0005sp-7W
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f5XhB-0003v4-Cm
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:23:02 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:60956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f5XhA-0003u6-Un
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:22:57 -0400
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-17-git-send-email-cota@braap.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <ffd8876e-ea9a-5d4c-b9af-e6595c54e766@mail.uni-paderborn.de>
Date: Mon, 9 Apr 2018 16:22:53 +0200
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-17-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 16/17] target/riscv: convert to
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Palmer Dabbelt <palmer@sifive.com>

On 04/06/2018 08:19 PM, Emilio G. Cota wrote:
> Notes:
> 
> - Did not convert {num,max}_insns, since the corresponding code
>   will go away in the next patch.
> 
> - ctx->pc becomes ctx->base.pc_next, and ctx->next_pc becomes ctx->pc_tmp.

Please call pc_tmp something meaningful, like pc_succ_insn, or pc_next_next.

Cheers,
Bastian
