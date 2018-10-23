Received: from eggs.gnu.org ([2001:4830:134:3::10]:55213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gEwwL-0005Dn-Vl
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gEwwH-00049B-Ij
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:41:45 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:51224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gEwwD-00041O-NI
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:41:39 -0400
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-6-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <56831f06-bae8-5947-ce62-1aa4cfeabe63@mail.uni-paderborn.de>
Date: Tue, 23 Oct 2018 15:41:34 +0200
MIME-Version: 1.0
In-Reply-To: <20181023120454.28553-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 5/7] target/riscv: Convert @cs_2 insns to
 share translation functions
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
> These all expand simply to R format instructions.
> ---
>   target/riscv/insn_trans/trans_rvc.inc.c | 36 -------------------------
>   target/riscv/translate.c                | 20 +++++++++++---
>   target/riscv/insn16.decode              | 17 +++++++-----
>   3 files changed, 26 insertions(+), 47 deletions(-)
>

Pretty cool :)

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
