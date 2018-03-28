Received: from eggs.gnu.org ([2001:4830:134:3::10]:39175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f12tS-0003px-AC
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f12tO-0003M3-Qx
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:41:02 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:40336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f12t2-0002iw-OZ
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:40:58 -0400
Received: by mail-pg0-x243.google.com with SMTP id g8so517513pgv.7
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 21:40:36 -0700 (PDT)
References: <1522180547-22956-1-git-send-email-mjc@sifive.com>
	<1522180547-22956-3-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b42aa903-82e2-21c6-f31a-cb71b691b037@linaro.org>
Date: Wed, 28 Mar 2018 12:40:23 +0800
MIME-Version: 1.0
In-Reply-To: <1522180547-22956-3-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] RISC-V: Fix incorrect disassembly
 for addiw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, patches@groups.riscv.org

On 03/28/2018 03:55 AM, Michael Clark wrote:
> This fixes a bug in the disassembler constraints used
> to lift instructions into pseudo-instructions, whereby
> addiw instructions are always lifted to sext.w instead
> of just lifting addiw with a zero immediate.
> 
> An associated fix has been made to the metadata used to
> machine generate the disseasembler:
> 
> https://github.com/michaeljclark/riscv-meta/
> commit/4a6b2f3898430768acfe201405224d2ea31e1477
> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  disas/riscv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
