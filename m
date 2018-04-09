Received: from eggs.gnu.org ([2001:4830:134:3::10]:47146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5ZEh-0001UK-8X
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5ZEc-00067i-ET
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:01:39 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59927)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f5ZEc-00066n-7f
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:01:34 -0400
Date: Mon, 9 Apr 2018 12:01:29 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180409160129.GA18168@flamenco>
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-17-git-send-email-cota@braap.org>
	<ffd8876e-ea9a-5d4c-b9af-e6595c54e766@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd8876e-ea9a-5d4c-b9af-e6595c54e766@mail.uni-paderborn.de>
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
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Palmer Dabbelt <palmer@sifive.com>

On Mon, Apr 09, 2018 at 16:22:53 +0200, Bastian Koppelmann wrote:
> On 04/06/2018 08:19 PM, Emilio G. Cota wrote:
> > Notes:
> > 
> > - Did not convert {num,max}_insns, since the corresponding code
> >   will go away in the next patch.
> > 
> > - ctx->pc becomes ctx->base.pc_next, and ctx->next_pc becomes ctx->pc_tmp.
> 
> Please call pc_tmp something meaningful, like pc_succ_insn, or pc_next_next.

For v3 I've renamed it to ctx->pc_succ_insn, as you suggested.

Thanks,

		E.
