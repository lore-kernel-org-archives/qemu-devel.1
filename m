Received: from eggs.gnu.org ([2001:4830:134:3::10]:41344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWM0-0001G8-9H
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWLw-000696-It
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:10:28 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:40989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGWLw-00068c-AC
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:10:24 -0400
Received: by mail-pl0-x243.google.com with SMTP id az12-v6so5020750plb.8
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 14:10:24 -0700 (PDT)
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
	<20180508173152.29327-26-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b290a225-580a-ff11-073c-042c80abb37a@linaro.org>
Date: Wed, 9 May 2018 14:10:20 -0700
MIME-Version: 1.0
In-Reply-To: <20180508173152.29327-26-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 25/36] target-microblaze: mmu: Remove
 unused register state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

On 05/08/2018 10:31 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add explicit handling for MMU_R_TLBX and log accesses to
> invalid MMU registers. We can now remove the state for
> all regs but PID, ZPR and TLBX (0 - 2).
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/mmu.c | 7 +++++--
>  target/microblaze/mmu.h | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
