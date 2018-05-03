Received: from eggs.gnu.org ([2001:4830:134:3::10]:48153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIfQ-0004xk-3a
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIfM-0002Q9-4X
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:09:20 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:45355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEIfL-0002Ot-Uj
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:09:16 -0400
Received: by mail-pf0-x243.google.com with SMTP id c10so15334737pfi.12
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:09:15 -0700 (PDT)
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-11-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8230ca0f-7355-f55b-010b-dbc334f2dda8@linaro.org>
Date: Thu, 3 May 2018 11:09:12 -0700
MIME-Version: 1.0
In-Reply-To: <20180503091922.28733-11-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 10/29] target-microblaze: Bypass MMU
 with MMU_NOMMU_IDX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

On 05/03/2018 02:19 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Bypass MMU translation when mmu-index MMU_NOMMU_IDX is used.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
