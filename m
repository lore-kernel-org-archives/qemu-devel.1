Received: from eggs.gnu.org ([2001:4830:134:3::10]:54282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4Ri-0004gv-N1
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4Re-00026k-W6
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:54:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:55621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG4Re-0001jX-JN
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:54:42 -0400
Received: by mail-wm1-x32c.google.com with SMTP id s10-v6so1981155wmc.5
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:54:35 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-63-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a435da3a-8a1a-d911-cb0e-7488485ce3c8@linaro.org>
Date: Fri, 26 Oct 2018 16:54:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-63-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 63/71] riscv: convert to
 cpu_has_work_with_iothread_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 10/25/18 3:46 PM, Emilio G. Cota wrote:
> Soon we will call cpu_has_work without the BQL.
> 
> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/riscv/cpu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
