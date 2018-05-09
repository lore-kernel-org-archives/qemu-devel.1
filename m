Received: from eggs.gnu.org ([2001:4830:134:3::10]:37501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGW10-0000ty-8M
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGW0w-0006eM-1f
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:48:46 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:34604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGW0v-0006e2-RL
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:48:41 -0400
Received: by mail-pl0-x243.google.com with SMTP id ay10-v6so4992784plb.1
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 13:48:41 -0700 (PDT)
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
	<20180508173152.29327-9-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9e11eab3-23cf-4308-0052-f2e6ad5e6f45@linaro.org>
Date: Wed, 9 May 2018 13:48:37 -0700
MIME-Version: 1.0
In-Reply-To: <20180508173152.29327-9-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/36] target-microblaze: Remove USE_MMU
 PVR checks
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
> We already have a CPU property to control if a core has
> an MMU or not. Remove USE_MMU PVR checks in favor of
> looking at the property.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/helper.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
