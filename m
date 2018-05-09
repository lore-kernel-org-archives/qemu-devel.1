Received: from eggs.gnu.org ([2001:4830:134:3::10]:37991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGW3o-00039v-De
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGW3j-0007kP-JU
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:51:40 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:37652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGW3j-0007k5-De
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:51:35 -0400
Received: by mail-pg0-x22c.google.com with SMTP id a13-v6so23192193pgu.4
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 13:51:35 -0700 (PDT)
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
	<20180508173152.29327-11-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <af4ea432-2c1f-42ad-8d3a-bb95d3cf38eb@linaro.org>
Date: Wed, 9 May 2018 13:51:31 -0700
MIME-Version: 1.0
In-Reply-To: <20180508173152.29327-11-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/36] target-microblaze: Bypass MMU
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
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

On 05/08/2018 10:31 AM, Edgar E. Iglesias wrote:
> +    if (cpu->cfg.use_mmu && (env->sregs[SR_MSR] & MSR_VM)
> +        && mmu_idx != MMU_NOMMU_IDX) {

For future cleanup, the first condition should be moved to cpu_mmu_index (the
second condition is already there).  At which point here you need check nothing
but mmu_idx.


r~
