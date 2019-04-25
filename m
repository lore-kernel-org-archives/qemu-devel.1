Received: from eggs.gnu.org ([209.51.188.92]:47764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJh1q-0008L2-M2
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJh1p-0008Cr-UI
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:15:18 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJh1p-0008BG-N0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:15:17 -0400
Received: by mail-pf1-x443.google.com with SMTP id y13so134679pfm.11
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:15:17 -0700 (PDT)
References: <mhng-3e3866ac-838d-4c70-8dd4-880201b74b8a@palmer-si-x1e>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c20ee4b9-d6c0-9bce-219b-24d3496cd460@linaro.org>
Date: Thu, 25 Apr 2019 09:15:13 -0700
MIME-Version: 1.0
In-Reply-To: <mhng-3e3866ac-838d-4c70-8dd4-880201b74b8a@palmer-si-x1e>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 3/8] target/riscv: Merge argument
 sets for insn32 and insn16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org

On 4/25/19 9:04 AM, Palmer Dabbelt wrote:
> c.lwsp with rd=0 should be an illegal instruction, but it's not.  We'd need to
> re-introduce the shim to handle that quirk, but since it's not actually a new
> bug I'm OK taking the patch set and fixing that later.

That should be fixable in the decode file, without a shim.
See patch 5, where I introduce trans_illegal, for doing
exactly this for c.addi4spn.


r~
