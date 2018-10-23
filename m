Received: from eggs.gnu.org ([2001:4830:134:3::10]:54891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gEwv0-0004XR-NH
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gEwut-0002an-31
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:40:20 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:50968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gEwus-0002ZK-Qt
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:40:15 -0400
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-4-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <664a27cc-9fe9-12d0-2853-5039f2095801@mail.uni-paderborn.de>
Date: Tue, 23 Oct 2018 15:40:11 +0200
MIME-Version: 1.0
In-Reply-To: <20181023120454.28553-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 3/7] target/riscv: Update for decodetree
 insn argument change
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
> ??? Should be merged back into previous patches.
> ??? Additional changes required for compact mode.
> ---
>   .../riscv/insn_trans/trans_privileged.inc.c   |  19 ++-
>   target/riscv/insn_trans/trans_rva.inc.c       |  44 +++---
>   target/riscv/insn_trans/trans_rvc.inc.c       | 148 +++++++++---------
>   target/riscv/insn_trans/trans_rvd.inc.c       |  64 ++++----
>   target/riscv/insn_trans/trans_rvf.inc.c       |  60 +++----
>   target/riscv/insn_trans/trans_rvi.inc.c       | 114 +++++++-------
>   target/riscv/insn_trans/trans_rvm.inc.c       |  26 +--
>   7 files changed, 234 insertions(+), 241 deletions(-)

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
