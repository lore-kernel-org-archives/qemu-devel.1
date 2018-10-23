Received: from eggs.gnu.org ([2001:4830:134:3::10]:55039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gEwvb-0004pR-Q3
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gEwvV-0003NE-Ea
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:40:59 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:51104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gEwvV-0003M0-4p
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:40:53 -0400
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-5-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <c68023e2-4e6a-fbbd-395b-9d61f48d903b@mail.uni-paderborn.de>
Date: Tue, 23 Oct 2018 15:40:51 +0200
MIME-Version: 1.0
In-Reply-To: <20181023120454.28553-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 4/7] target/riscv: Rename some argument
 sets in insn32.decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: sagark@eecs.berkeley.edu, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com

On 10/23/18 2:04 PM, Richard Henderson wrote:
> For format x, use &x for the argument set and @x for the extract.
> This is less confusing than e.g. "arith" for format R.
> ---
>   target/riscv/insn_trans/trans_rvi.inc.c |  2 +-
>   target/riscv/translate.c                | 10 +++++-----
>   target/riscv/insn32.decode              | 12 ++++++------
>   3 files changed, 12 insertions(+), 12 deletions(-)
>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
