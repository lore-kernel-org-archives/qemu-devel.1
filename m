Received: from eggs.gnu.org ([2001:4830:134:3::10]:41610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWN1-0001z0-32
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWMx-0006YZ-Qj
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:11:31 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:37410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGWMx-0006YR-Kn
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:11:27 -0400
Received: by mail-pl0-x243.google.com with SMTP id f7-v6so5029683plr.4
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 14:11:27 -0700 (PDT)
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
	<20180508173152.29327-27-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2c19ddc4-0127-2fa2-f45b-709b9ff4d057@linaro.org>
Date: Wed, 9 May 2018 14:11:23 -0700
MIME-Version: 1.0
In-Reply-To: <20180508173152.29327-27-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 26/36] target-microblaze: mmu: Prepare
 for 64-bit addresses
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
> Prepare for 64-bit addresses.
> This makes no functional difference as the upper parts of
> the 64-bit addresses are not yet reachable.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/mmu.c | 14 +++++++-------
>  target/microblaze/mmu.h |  6 +++---
>  2 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
