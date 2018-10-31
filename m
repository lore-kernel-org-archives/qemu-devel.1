Received: from eggs.gnu.org ([2001:4830:134:3::10]:41952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHzCC-0002Dh-FU
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHzC8-0005NI-91
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:42:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:38801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHzC8-0005Mx-0r
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:42:36 -0400
Received: by mail-wr1-x430.google.com with SMTP id d10-v6so18229450wrs.5
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:42:35 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-32-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eb3433f6-2e8b-192b-c3cc-98634afab2a0@linaro.org>
Date: Wed, 31 Oct 2018 22:42:32 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-32-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 31/35] target/riscv: Convert @cs_2 insns
 to share translation functions
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
> These all expand simply to R format instructions.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  target/riscv/Makefile.objs              | 10 +++---
>  target/riscv/insn16-64.decode           | 24 ++++++++++++++
>  target/riscv/insn16.decode              | 15 +++++----
>  target/riscv/insn_trans/trans_rvc.inc.c | 44 -------------------------
>  target/riscv/translate.c                | 20 ++++++++---
>  5 files changed, 54 insertions(+), 59 deletions(-)
>  create mode 100644 target/riscv/insn16-64.decode

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
