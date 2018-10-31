Received: from eggs.gnu.org ([2001:4830:134:3::10]:42807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHzFI-0003nQ-2L
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHzFE-0007Ey-OU
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:45:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHzFE-0007DK-Ei
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:45:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id v24-v6so6797490wmh.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:45:48 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-34-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <db2a445a-ec2b-2c1c-fd2f-8c4acb11e1ec@linaro.org>
Date: Wed, 31 Oct 2018 22:45:45 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-34-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 33/35] target/riscv: Splice fsw_sd and
 flw_ld for riscv32 vs riscv64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org

On 10/31/18 1:20 PM, Bastian Koppelmann wrote:
> this finally removes the old decoder functions that we carried along
> with it.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  target/riscv/Makefile.objs              |   1 +
>  target/riscv/insn16-32.decode           |  24 ++++
>  target/riscv/insn16-64.decode           |   4 +
>  target/riscv/insn16.decode              |   7 +-
>  target/riscv/insn_trans/trans_rvc.inc.c |  22 ----
>  target/riscv/translate.c                | 165 +-----------------------
>  6 files changed, 31 insertions(+), 192 deletions(-)
>  create mode 100644 target/riscv/insn16-32.decode

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
