Received: from eggs.gnu.org ([2001:4830:134:3::10]:49534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fCkM7-0005DL-RB
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 07:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fCkM2-0006Tb-W6
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 07:18:59 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:48004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1fCkM2-0006TH-IM
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 07:18:54 -0400
References: <7366cfc5-e37f-483d-917b-2aae41d1e59e@gmail.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <7a5d09e7-3e30-3683-41ae-076bd4532786@mail.uni-paderborn.de>
Date: Sun, 29 Apr 2018 13:18:50 +0200
MIME-Version: 1.0
In-Reply-To: <7366cfc5-e37f-483d-917b-2aae41d1e59e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Difference between tcg_gen_ld_i64 and
 tcg_gen_qemu_ld_i64.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rafael Kioji <rafaelkioji@gmail.com>, qemu-devel@nongnu.org

On 04/29/2018 12:15 PM, Rafael Kioji wrote:
> Dear all,
> 
> What is the difference between these two functions? They are located in the file
> "tcg/tcg-op.c". Here is their header:
> 
> 1. static inline void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2,
>    tcg_target_long offset)

This is used to access fields of qemu data structures from generated code, e.g.
CPUArmState.

> 2. void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx,
>    TCGMemOp memop)

This actually generates a load to guest memory.

> 
> I don't quite understand the need for function (1). Especially because it is
> usually passed "cpu_env" for arg2. Like in target/arm/translate-a64.c:595:

cpu_env is a pointer to CPUArmState.

Cheers,
Bastian
