Received: from eggs.gnu.org ([2001:4830:134:3::10]:54520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fJNCz-0001Ih-01
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fJNCu-0002hK-1X
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:00:57 -0400
Received: from mail-bn3nam01on0050.outbound.protection.outlook.com
	([104.47.33.50]:38448
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1fJNCt-0002gu-OA
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:00:51 -0400
Date: Thu, 17 May 2018 20:00:14 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180517180014.mjir5ojaeb2bhgrg@toto>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-10-edgar.iglesias@gmail.com>
	<61f66a48-28bb-3d3e-473f-a999b40f4d09@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <61f66a48-28bb-3d3e-473f-a999b40f4d09@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com

On Thu, May 17, 2018 at 10:26:00AM -0700, Richard Henderson wrote:
> On 05/16/2018 11:51 AM, Edgar E. Iglesias wrote:
> > -    env->pvr.regs[11] = PVR11_USE_MMU | (16 << 17);
> > +    env->pvr.regs[11] = cpu->cfg.use_mmu ? PVR11_USE_MMU : 0 |
> > +                        16 << 17;
> 
> I believe this needs parenthesis around the ?:.

Goot catch, I've fixed that for v4.

Cheers,
Edgar
