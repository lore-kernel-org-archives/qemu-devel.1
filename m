Received: from eggs.gnu.org ([2001:4830:134:3::10]:43203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHzGV-0004Ts-Ie
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHzGU-0007yz-R2
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:47:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHzGU-0007ym-K5
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:47:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id v24-v6so6799539wmh.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:47:06 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-35-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cbb7be4b-d50b-43ef-ec7b-8156d4836431@linaro.org>
Date: Wed, 31 Oct 2018 22:47:03 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-35-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 34/35] target/riscv: Splice remaining
 compressed insn pairs for riscv32 vs riscv64
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
> it splices flwsp_ldsp, fswsp_sdsp, and jal_addiw and makes each of them
> reuse the code generator used for the non compressed insns.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  target/riscv/insn16-32.decode           |  7 +++++
>  target/riscv/insn16-64.decode           |  5 ++++
>  target/riscv/insn16.decode              | 12 ++------
>  target/riscv/insn32.decode              |  3 +-
>  target/riscv/insn_trans/trans_rvc.inc.c | 40 -------------------------
>  5 files changed, 16 insertions(+), 51 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
