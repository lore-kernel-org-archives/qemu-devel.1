Received: from eggs.gnu.org ([2001:4830:134:3::10]:39592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsE6-00076o-F8
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsE2-0000cH-My
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:39:46 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEsE2-0000Ry-5s
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:39:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id d10-v6so687825wrs.5
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 01:39:34 -0700 (PDT)
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-19-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9dce78ea-9acc-a838-c01e-5f01ce8b0dc2@linaro.org>
Date: Tue, 23 Oct 2018 09:39:30 +0100
MIME-Version: 1.0
In-Reply-To: <20181020071451.27808-19-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 18/29] target/riscv: Convert quadrant 2
 of RVXC insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/20/18 8:14 AM, Bastian Koppelmann wrote:
> This also removes all functions that now became obsolete.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  target/riscv/insn16.decode              |  34 +++++-
>  target/riscv/insn_trans/trans_rvc.inc.c | 103 ++++++++++++++++
>  target/riscv/translate.c                | 151 +-----------------------
>  3 files changed, 135 insertions(+), 153 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
