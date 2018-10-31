Received: from eggs.gnu.org ([2001:4830:134:3::10]:35560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHu5e-0001v6-Rp
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHu5Z-0006kp-4P
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:15:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHu5S-0006ee-3X
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:15:24 -0400
Received: by mail-wm1-x344.google.com with SMTP id w7-v6so4848945wmc.1
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 10:15:17 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-7-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fcac4eb9-8389-9c11-b935-d2642e59e207@linaro.org>
Date: Wed, 31 Oct 2018 17:15:14 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-7-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/35] target/riscv: Convert RVXI
 arithmetic insns to decodetree
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
> we cannot remove the call to gen_arith() in decode_RV32_64G() since it
> is used to translate multiply instructions.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
> v2 -> v3:
>     - moved 64-bit only insn to insn64.decode
>     - dropped insn argument of trans_foo functions
> 
>  target/riscv/insn32.decode              |  25 ++++
>  target/riscv/insn64.decode              |  13 ++
>  target/riscv/insn_trans/trans_rvi.inc.c | 168 ++++++++++++++++++++++++
>  target/riscv/translate.c                |   9 --
>  4 files changed, 206 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
