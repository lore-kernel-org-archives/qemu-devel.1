Received: from eggs.gnu.org ([2001:4830:134:3::10]:42708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMDQI-000443-Dl
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMDQD-0004vq-ML
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:10:26 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:46059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fMDQD-0004uk-Il
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:10:21 -0400
Received: by mail-qk0-x242.google.com with SMTP id c198-v6so4147607qkg.12
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:10:21 -0700 (PDT)
References: <20180523224745.30402-1-edgar.iglesias@gmail.com>
	<20180523224745.30402-2-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9e3d1f80-68bf-43fb-b3a0-7b734215398f@linaro.org>
Date: Fri, 25 May 2018 07:10:15 -0700
MIME-Version: 1.0
In-Reply-To: <20180523224745.30402-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 09/38] target-microblaze: Conditionalize
 setting of PVR11_USE_MMU
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

On 05/23/2018 03:47 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Conditionalize setting of PVR11_USE_MMU on the use_mmu
> CPU property, otherwise we may incorrectly advertise an
> MMU via PVR when the core in fact has none.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
