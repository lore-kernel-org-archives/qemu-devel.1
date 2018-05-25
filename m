Received: from eggs.gnu.org ([2001:4830:134:3::10]:57130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMEWW-0002IW-Vr
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMEWT-0007R9-PU
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:20:56 -0400
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:38323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fMEWT-0007QM-IP
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:20:53 -0400
Received: by mail-pl0-x230.google.com with SMTP id c11-v6so3344930plr.5
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 08:20:53 -0700 (PDT)
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-7-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e74f4911-fe58-9884-ea9c-23e13f269700@linaro.org>
Date: Fri, 25 May 2018 08:20:48 -0700
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-7-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 06/30] RISC-V: Move non-ops from
 op_helper to cpu_helper
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
> This patch makes op_helper.c contain only instruction
> operation helpers used by translate.c and moves any
> unrelated cpu helpers into cpu_helper.c. No logic is
> changed by this patch.
> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
