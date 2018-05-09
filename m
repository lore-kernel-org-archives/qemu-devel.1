Received: from eggs.gnu.org ([2001:4830:134:3::10]:42555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWSG-0006IQ-3K
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWSD-0008Ml-Nz
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:16:56 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGWSD-0008Md-HX
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:16:53 -0400
Received: by mail-pg0-x241.google.com with SMTP id i194-v6so23218494pgd.0
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 14:16:53 -0700 (PDT)
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
	<20180508173152.29327-32-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8747feeb-779e-a2c4-d657-dd5a673f3e62@linaro.org>
Date: Wed, 9 May 2018 14:16:50 -0700
MIME-Version: 1.0
In-Reply-To: <20180508173152.29327-32-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 31/36] target-microblaze: mmu: Cleanup
 debug log messages
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
> Cleanup debug log messages:
> * Avoid long 80+ character lines.
> * Remove D() macro and use qemu_log_mask.
> * Remove logs that are not very useful
> 
> Suggested-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/mmu.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
