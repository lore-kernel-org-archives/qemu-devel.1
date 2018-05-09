Received: from eggs.gnu.org ([2001:4830:134:3::10]:41092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWKp-0006n6-LD
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWKm-0005kG-Dc
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:09:15 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:39767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGWKm-0005jo-8I
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:09:12 -0400
Received: by mail-pg0-x243.google.com with SMTP id e1-v6so11858618pga.6
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 14:09:12 -0700 (PDT)
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
	<20180508173152.29327-23-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f6478d8a-609b-0794-a085-4e7d1ac64883@linaro.org>
Date: Wed, 9 May 2018 14:09:08 -0700
MIME-Version: 1.0
In-Reply-To: <20180508173152.29327-23-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 22/36] target-microblaze: Add Extended
 Addressing
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
> Add support for Extended Addressing. Load/stores with EA
> enabled concatenate two 32bit registers to form an extended
> address.
> 
> We don't allow users to enable address sizes larger than
> 32 bits quite yet though. Once the MMU support is in, we'll
> turn it on.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/cpu.c       | 18 +++++++++++++-
>  target/microblaze/cpu.h       |  2 ++
>  target/microblaze/translate.c | 55 +++++++++++++++++++++++++++++++++----------
>  3 files changed, 62 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
