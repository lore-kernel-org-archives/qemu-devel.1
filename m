Received: from eggs.gnu.org ([2001:4830:134:3::10]:56761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMEV2-00014U-Oi
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMEUz-0005lJ-I1
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:19:24 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:46647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fMEUz-0005k4-Cn
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:19:21 -0400
Received: by mail-pf0-x242.google.com with SMTP id p12-v6so2738029pff.13
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 08:19:21 -0700 (PDT)
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-6-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <431fc9e2-e357-ca34-aaff-30d4f4e36f15@linaro.org>
Date: Fri, 25 May 2018 08:19:15 -0700
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-6-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/30] RISC-V: Allow setting and
 clearing multiple irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On 05/22/2018 05:14 PM, Michael Clark wrote:
> Change the API of riscv_set_local_interrupt to take a
> write mask and value to allow setting and clearing of
> multiple local interrupts atomically in a single call.
> Rename the new function to riscv_cpu_update_mip.
> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
