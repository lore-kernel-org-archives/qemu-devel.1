Received: from eggs.gnu.org ([2001:4830:134:3::10]:37836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gFFXu-00030A-3m
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gFFXo-0006n1-P3
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:33:44 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:55326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gFFXo-0006mA-GZ
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:33:40 -0400
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-8-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <5bb7fe79-a2a0-7a01-beb8-c23c3a2d2d5f@mail.uni-paderborn.de>
Date: Wed, 24 Oct 2018 11:33:35 +0200
MIME-Version: 1.0
In-Reply-To: <20181023120454.28553-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 7/7] target/riscv: Splice decodetree inputs
 for riscv32 vs riscv64
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
> This primarily solves the case for RVC that several insns are
> completely different, decode and all, between the two.  But it
> also means that we need less ifdefing for RV{I,M,A,F,D}.
> ---
>   target/riscv/insn_trans/trans_rva.inc.c | 46 +---------------
>   target/riscv/insn_trans/trans_rvc.inc.c | 71 -------------------------
>   target/riscv/insn_trans/trans_rvd.inc.c | 26 +--------
>   target/riscv/insn_trans/trans_rvf.inc.c | 18 +------
>   target/riscv/insn_trans/trans_rvi.inc.c | 49 +++--------------
>   target/riscv/insn_trans/trans_rvm.inc.c | 22 +-------
>   target/riscv/Makefile.objs              | 23 ++++++--
>   target/riscv/insn16-32.decode           | 31 +++++++++++
>   target/riscv/insn16-64.decode           | 33 ++++++++++++
>   target/riscv/insn16.decode              | 24 +++------
>   target/riscv/insn32.decode              | 53 +-----------------
>   target/riscv/insn64.decode              | 71 +++++++++++++++++++++++++
>   12 files changed, 176 insertions(+), 291 deletions(-)
>   create mode 100644 target/riscv/insn16-32.decode
>   create mode 100644 target/riscv/insn16-64.decode
>   create mode 100644 target/riscv/insn64.decode
>

Either this or one of the last two patches breaks booting fedora. I 
couldn't figure the problem out just yet.

Cheers,

Bastian
