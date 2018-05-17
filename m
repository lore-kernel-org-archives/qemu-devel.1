Received: from eggs.gnu.org ([2001:4830:134:3::10]:49126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJMsi-0003Gz-N4
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJMsf-0006pN-Gx
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:40:00 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:44583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJMsf-0006p9-Bg
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:39:57 -0400
Received: by mail-pg0-x244.google.com with SMTP id c22-v6so1461266pgn.11
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:39:57 -0700 (PDT)
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-39-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <80e9f8fa-6628-49dd-b07d-2e5f644b792e@linaro.org>
Date: Thu, 17 May 2018 10:39:53 -0700
MIME-Version: 1.0
In-Reply-To: <20180516185146.30708-39-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 38/38] target-microblaze: Consolidate
 MMU enabled checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

On 05/16/2018 11:51 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Consolidate MMU enabled checks to cpu_mmu_index().
> No functional changes.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/cpu.h    | 4 +++-
>  target/microblaze/helper.c | 6 +++---
>  2 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
