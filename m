Received: from eggs.gnu.org ([2001:4830:134:3::10]:55210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fJNFt-0003WV-64
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fJNFo-0004vd-6g
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:03:57 -0400
Received: from mail-sn1nam02on0089.outbound.protection.outlook.com
	([104.47.36.89]:8768
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1fJNFn-0004v4-TH
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:03:52 -0400
Date: Thu, 17 May 2018 20:03:33 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180517180333.voovwdnnlr5eaapq@toto>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-36-edgar.iglesias@gmail.com>
	<9e6a126f-4fc8-15a9-1b11-e1d3d6dba691@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9e6a126f-4fc8-15a9-1b11-e1d3d6dba691@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 35/38] target-microblaze: Convert
 env_btarget to i64
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

On Thu, May 17, 2018 at 10:34:38AM -0700, Richard Henderson wrote:
> On 05/16/2018 11:51 AM, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> > 
> > Convert env_btarget to i64.
> > No functional change.
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> 
> I thought you were going to drop this one?


I dropped the conversion of env_btaken as it's not really useful
since it's a boolean. btarget will eventually need to be 64bit
allthought strictly necessary in this series so I've kept btarget
as 64bit.

Cheers,
Edgar
