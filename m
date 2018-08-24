Received: from eggs.gnu.org ([2001:4830:134:3::10]:43151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft3aO-0002M1-RY
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft3aI-00075G-6z
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:20:34 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:42409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ft3aH-00074W-Cf
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:20:29 -0400
Received: by mail-pl1-x633.google.com with SMTP id g23-v6so529425plq.9
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 21:20:28 -0700 (PDT)
References: <20180823175225.22612-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1a00a128-08ca-a214-5f69-971a867cdde7@linaro.org>
Date: Thu, 23 Aug 2018 21:20:25 -0700
MIME-Version: 1.0
In-Reply-To: <20180823175225.22612-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/mps2: Fix ID register errors on
 AN511 and AN385
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/23/2018 10:52 AM, Peter Maydell wrote:
> Fix MPS2 SCC config register values for the mps2-an511
> and mps2-an385 boards:
>  * the SCC_AID bits [23:20] specify the FPGA build target board revision,
>    and the SCC_CFG4 register specifies the actual board revision, so
>    these should have matching values. Claim to be board revision C,
>    consistently -- we had the revision in the wrong part of SCC_AID.
>  * SCC_ID bits [15:4] should be the board number in hex, not decimal
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This fixes a bug that I noticed for the AN505 model and fixed there,
> but forgot to also fix on our other MPS image models.
> 
>  hw/arm/mps2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
