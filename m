Received: from eggs.gnu.org ([2001:4830:134:3::10]:33100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHygM-00016N-LW
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHygJ-0005TN-As
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:09:46 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHygH-0005QL-4e
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:09:43 -0400
Received: by mail-wr1-x434.google.com with SMTP id z16-v6so265854wrv.2
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:09:37 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-24-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6e85cce6-3f02-f71a-3dcf-9fbc5479bdc6@linaro.org>
Date: Wed, 31 Oct 2018 22:09:34 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-24-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 23/35] target/riscv: Remove manual
 decoding from gen_store()
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
> +static bool gen_store(DisasContext *ctx, arg_sb *a, int memop)

Likewise with TCGMemOp.


r~
