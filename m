Received: from eggs.gnu.org ([2001:4830:134:3::10]:46418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJMfI-0005m5-E4
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJMfE-00018W-FB
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:26:08 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:35797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJMfE-00018N-8P
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:26:04 -0400
Received: by mail-pf0-x232.google.com with SMTP id x9-v6so2426486pfm.2
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:26:04 -0700 (PDT)
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-10-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <61f66a48-28bb-3d3e-473f-a999b40f4d09@linaro.org>
Date: Thu, 17 May 2018 10:26:00 -0700
MIME-Version: 1.0
In-Reply-To: <20180516185146.30708-10-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 09/38] target-microblaze: Conditionalize
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

On 05/16/2018 11:51 AM, Edgar E. Iglesias wrote:
> -    env->pvr.regs[11] = PVR11_USE_MMU | (16 << 17);
> +    env->pvr.regs[11] = cpu->cfg.use_mmu ? PVR11_USE_MMU : 0 |
> +                        16 << 17;

I believe this needs parenthesis around the ?:.


r~
