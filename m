Received: from eggs.gnu.org ([2001:4830:134:3::10]:42383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWRV-0005ow-IO
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWRS-00081o-Bm
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:16:09 -0400
Received: from mail-pl0-x233.google.com ([2607:f8b0:400e:c01::233]:42955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGWRS-00081a-69
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:16:06 -0400
Received: by mail-pl0-x233.google.com with SMTP id u6-v6so5026154pls.9
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 14:16:06 -0700 (PDT)
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
	<20180508173152.29327-31-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6b93bd7b-8a00-468b-09ae-7b82c41ab61c@linaro.org>
Date: Wed, 9 May 2018 14:16:02 -0700
MIME-Version: 1.0
In-Reply-To: <20180508173152.29327-31-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 30/36] target-microblaze: Simplify
 address computation using tcg_gen_addi_i32()
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
> Simplify address computation using tcg_gen_addi_i32().
> tcg_gen_addi_i32() already optimizes the case when the
> immediate is zero.
> 
> No functional change.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
