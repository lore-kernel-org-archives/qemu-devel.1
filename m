Received: from eggs.gnu.org ([2001:4830:134:3::10]:34411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fIhlx-0005Ox-Sh
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fIhlt-0006VH-Ta
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:46:17 -0400
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com
	([104.47.38.57]:7246
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1fIhlt-0006VC-JU
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:46:13 -0400
Date: Tue, 15 May 2018 23:45:51 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180515214551.oxj5mw4re4rhqgr3@toto>
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
	<20180508173152.29327-11-edgar.iglesias@gmail.com>
	<af4ea432-2c1f-42ad-8d3a-bb95d3cf38eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <af4ea432-2c1f-42ad-8d3a-bb95d3cf38eb@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com

On Wed, May 09, 2018 at 01:51:31PM -0700, Richard Henderson wrote:
> On 05/08/2018 10:31 AM, Edgar E. Iglesias wrote:
> > +    if (cpu->cfg.use_mmu && (env->sregs[SR_MSR] & MSR_VM)
> > +        && mmu_idx != MMU_NOMMU_IDX) {
> 
> For future cleanup, the first condition should be moved to cpu_mmu_index (the
> second condition is already there).  At which point here you need check nothing
> but mmu_idx.

Thanks, I've added a followup patch that does this.

Cheers,
Edgar
