Received: from eggs.gnu.org ([209.51.188.92]:38484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gtxEb-0002qg-CL
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gtxEa-00046e-5S
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:18:05 -0500
References: <20190213155414.22285-1-palmer@sifive.com>
	<20190213155414.22285-2-palmer@sifive.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <0ba65ec0-803b-8aff-c562-ab56e317d48a@mail.uni-paderborn.de>
Date: Wed, 13 Feb 2019 17:18:00 +0100
MIME-Version: 1.0
In-Reply-To: <20190213155414.22285-2-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v7 01/35] target/riscv: Move CPURISCVState
 pointer to DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org


On 2/13/19 4:53 PM, Palmer Dabbelt wrote:
> From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>
> CPURISCVState is rarely used, so there is no need to pass it to every
> translate function. This paves the way for decodetree which only passes
> DisasContext to translate functions.
>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>   target/riscv/translate.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

We can drop this patch as you pull request already fixes this. (see 
https://patchwork.kernel.org/patch/10794241/)

Cheers,

Bastian
