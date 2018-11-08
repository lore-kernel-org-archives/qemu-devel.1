Received: from eggs.gnu.org ([2001:4830:134:3::10]:52839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKmTU-0004FL-31
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKmTP-0002HO-HZ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:44:04 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKmTP-0002Gc-9m
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:43:59 -0500
Received: by mail-wr1-x444.google.com with SMTP id 74-v6so21726372wrb.13
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 07:43:59 -0800 (PST)
References: <20181108120628.29926-1-kbastian@mail.uni-paderborn.de>
	<20181108120628.29926-3-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91b7de64-c2d9-3669-bcad-31ff683514ca@linaro.org>
Date: Thu, 8 Nov 2018 16:43:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181108120628.29926-3-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/riscv: Fix sfence.vm/a both
 available in any priv version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On 11/8/18 1:06 PM, Bastian Koppelmann wrote:
> sfence.vm has been replaced in priv v1.10 spec by sfence.vma.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  target/riscv/translate.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
