Received: from eggs.gnu.org ([2001:4830:134:3::10]:48786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDwzQ-0003FH-R9
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 15:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDwzL-0005cU-SU
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 15:32:48 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDwzL-0005Y9-D3
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 15:32:43 -0400
Received: by mail-pl1-x641.google.com with SMTP id e67-v6so8314195plb.6
	for <qemu-devel@nongnu.org>; Sat, 20 Oct 2018 12:32:41 -0700 (PDT)
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-3-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2b5ca4dc-5a8a-0091-bfde-4babe1a91e5f@linaro.org>
Date: Sat, 20 Oct 2018 12:32:36 -0700
MIME-Version: 1.0
In-Reply-To: <20181020071451.27808-3-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/29] targer/riscv: Activate decodetree
 and implemnt LUI & AUIPC
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

On 10/20/18 12:14 AM, Bastian Koppelmann wrote:
> +    static int32_t ex_shift_##amount(int imm) \

Not that it'll matter in practice, but s/int32_t/int/.

That's the type that's passed in, and it's the type that
is stored in the argument set structures.


r~
