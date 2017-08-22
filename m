Received: from eggs.gnu.org ([2001:4830:134:3::10]:42143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1dkCvC-0000uj-RV
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1dkCv8-0000eN-Br
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:24:57 -0400
Received: from mail-cys01nam02on0079.outbound.protection.outlook.com
	([104.47.37.79]:61072
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgar@xilinx.com>) id 1dkCv8-0000bp-1X
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:24:54 -0400
Date: Wed, 23 Aug 2017 00:24:38 +0700
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20170822172438.GF3205@toto>
References: <cover.1502993370.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1502993370.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Expose the secure property to the
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, alistair23@gmail.com, edgar.iglesias@gmail.com

On Thu, Aug 17, 2017 at 11:51:59AM -0700, Alistair Francis wrote:
> The EL2 and EL3 work is working well now and interanlly we now have
> tests that expect to start in EL3 and transition through EL2 to EL1. To
> make this easy to run let's expose the secure property to the machine
> and then use that to enable EL2.
> 
> This series also does some machine/name tidying up and makes the first
> move to deprecating the EP108 machine, which was just an early access
> development board.

Hi Alistair,

Reconsidering this, I tend to agree that we're probably better off with
EL2/no-GICv2-virt compared to the possible confusiong of having EL2
without GICv2-virt..

But I wonder if we should have similar options as the virt machine?
I.e, a virtualization option to enable EL2.

Cheers,
Edgar


> 
> Alistair Francis (5):
>   xlnx-ep108: Rename to ZCU102
>   xlnx-zcu102: Manually create the machines
>   xlnx-zcu102: Add a machine level secure property
>   xlnx-zynqmp: Allow the secure prop to enable EL2
>   xlnx-zcu102: Mark the EP108 machine as deprecated
> 
>  hw/arm/Makefile.objs                   |   2 +-
>  hw/arm/{xlnx-ep108.c => xlnx-zcu102.c} | 131 ++++++++++++++++++++++++++++-----
>  hw/arm/xlnx-zynqmp.c                   |   2 +-
>  3 files changed, 114 insertions(+), 21 deletions(-)
>  rename hw/arm/{xlnx-ep108.c => xlnx-zcu102.c} (51%)
> 
> -- 
> 2.11.0
> 
