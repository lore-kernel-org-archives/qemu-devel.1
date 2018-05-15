Received: from eggs.gnu.org ([2001:4830:134:3::10]:39178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fIiMi-0002Ue-S2
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fIiMe-0005Ww-QR
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:24:16 -0400
Received: from mail-by2nam03on0077.outbound.protection.outlook.com
	([104.47.42.77]:41230
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1fIiMe-0005GS-DU
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:24:12 -0400
Date: Wed, 16 May 2018 00:23:52 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180515222352.mxpzkttzzpc3pddz@toto>
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
	<20180508173152.29327-29-edgar.iglesias@gmail.com>
	<a50ca9bb-377f-5736-5012-ddde6bfdc305@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a50ca9bb-377f-5736-5012-ddde6bfdc305@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 28/36] target-microblaze: Add support
 for extended access to TLBLO
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

On Wed, May 09, 2018 at 02:15:14PM -0700, Richard Henderson wrote:
> On 05/08/2018 10:31 AM, Edgar E. Iglesias wrote:
> > +        if (to) {
> > +            gen_helper_mmu_write(cpu_env, tcg_const_i32(extended),
> > +                                 tcg_const_i32(sr), cpu_R[dc->ra]);
> > +        } else {
> > +            gen_helper_mmu_read(cpu_R[dc->rd], cpu_env,
> > +                                tcg_const_i32(extended), tcg_const_i32(sr));
> > +        }
> 
> These tcg_const_i32 results should be tcg_temp_free'd.

Thanks, I've fixed this for v3.
