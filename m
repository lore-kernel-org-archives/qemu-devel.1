Received: from eggs.gnu.org ([209.51.188.92]:57212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gm3il-0006AP-M9
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:36:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gm3ih-00039b-LI
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:36:33 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:32889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gm3ia-00033N-HY
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:36:25 -0500
Received: by mail-pf1-x434.google.com with SMTP id c123so35744pfb.0
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 13:36:23 -0800 (PST)
References: <20190122092909.5341-1-kbastian@mail.uni-paderborn.de>
	<20190122092909.5341-20-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f3d4a095-4393-fdff-1acf-2e6d8e0073db@linaro.org>
Date: Tue, 22 Jan 2019 13:32:22 -0800
MIME-Version: 1.0
In-Reply-To: <20190122092909.5341-20-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 19/35] target/riscv: Convert quadrant 2
 of RVXC insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On 1/22/19 1:28 AM, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
>  target/riscv/insn16.decode              |  31 ++++++++
>  target/riscv/insn_trans/trans_rvc.inc.c | 101 ++++++++++++++++++++++++
>  target/riscv/translate.c                |  83 +------------------
>  3 files changed, 134 insertions(+), 81 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
