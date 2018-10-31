Received: from eggs.gnu.org ([2001:4830:134:3::10]:33075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHtyR-0002eP-EA
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHtyK-0001Zg-3I
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:08:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHtyI-0001Vo-2U
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:07:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id v24-v6so6044320wmh.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 10:07:56 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-2-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9b6f4489-d441-84b4-89da-21b864b9895a@linaro.org>
Date: Wed, 31 Oct 2018 17:07:50 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-2-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/35] target/riscv: Move CPURISCVState
 pointer to DisasContext
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

On 10/31/18 1:19 PM, Bastian Koppelmann wrote:
> CPURISCVState is rarely used, so there is no need to pass it to every
> translate function. This paves the way for decodetree which only passes
> DisasContext to translate functions.
> 
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  target/riscv/translate.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
