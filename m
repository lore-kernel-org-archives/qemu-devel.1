Received: from eggs.gnu.org ([2001:4830:134:3::10]:49802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1dq4Sk-0002FW-Fw
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 17:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1dq4Sf-0001bZ-Rb
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 17:35:50 -0400
Date: Fri, 8 Sep 2017 04:35:25 +0700
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20170907213525.GJ5763@toto>
References: <cover.1504222314.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1504222314.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH Resend v2 0/5] Expose the secure and virt
 properties to the
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, alistair23@gmail.com, edgar.iglesias@gmail.com

On Thu, Sep 07, 2017 at 08:56:55AM -0700, Alistair Francis wrote:
> 
> The EL2 and EL3 work is working well now and interanlly we now have
> tests that expect to start in EL3 and transition through EL2 to EL1. To
> make this easy to run let's expose the secure property to the machine
> and also add a virt property that can enable EL2.
> 
> This series also does some machine/name tidying up and makes the first
> move to deprecating the EP108 machine, which was just an early access
> development board.
> 
> V2:
>  - Add a virt option for setting EL2


Thanks Alistair!
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> 
> 
> Alistair Francis (5):
>   xlnx-ep108: Rename to ZCU102
>   xlnx-zcu102: Manually create the machines
>   xlnx-zcu102: Add a machine level secure property
>   xlnx-zcu102: Add a machine level virtualization property
>   xlnx-zcu102: Mark the EP108 machine as deprecated
> 
>  hw/arm/Makefile.objs         |   2 +-
>  hw/arm/xlnx-ep108.c          | 137 -----------------------
>  hw/arm/xlnx-zcu102.c         | 257 +++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/xlnx-zynqmp.c         |   3 +-
>  include/hw/arm/xlnx-zynqmp.h |   2 +
>  5 files changed, 262 insertions(+), 139 deletions(-)
>  delete mode 100644 hw/arm/xlnx-ep108.c
>  create mode 100644 hw/arm/xlnx-zcu102.c
> 
> -- 
> 2.11.0
> 
