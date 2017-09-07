Received: from eggs.gnu.org ([2001:4830:134:3::10]:55133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dq4bI-0005xZ-4r
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 17:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dq4bD-0000FV-D7
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 17:44:40 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170907213525.GJ5763@toto>
References: <cover.1504222314.git.alistair.francis@xilinx.com>
	<20170907213525.GJ5763@toto>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 7 Sep 2017 14:44:01 -0700
Message-ID: <CAKmqyKNrbdGJ2n=HHeUfJOq-EUmwbY_330DGL+BD++BtrSwnxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgar.iglesias@gmail.com>

On Thu, Sep 7, 2017 at 2:35 PM, Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
> On Thu, Sep 07, 2017 at 08:56:55AM -0700, Alistair Francis wrote:
>>
>> The EL2 and EL3 work is working well now and interanlly we now have
>> tests that expect to start in EL3 and transition through EL2 to EL1. To
>> make this easy to run let's expose the secure property to the machine
>> and also add a virt property that can enable EL2.
>>
>> This series also does some machine/name tidying up and makes the first
>> move to deprecating the EP108 machine, which was just an early access
>> development board.
>>
>> V2:
>>  - Add a virt option for setting EL2
>
>
> Thanks Alistair!
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Thanks Edgar.

@Peter I updated the patches on the git branch I pasted earlier to
include Edgar's review.

Thanks,
Alistair

>
>
>
>>
>>
>>
>> Alistair Francis (5):
>>   xlnx-ep108: Rename to ZCU102
>>   xlnx-zcu102: Manually create the machines
>>   xlnx-zcu102: Add a machine level secure property
>>   xlnx-zcu102: Add a machine level virtualization property
>>   xlnx-zcu102: Mark the EP108 machine as deprecated
>>
>>  hw/arm/Makefile.objs         |   2 +-
>>  hw/arm/xlnx-ep108.c          | 137 -----------------------
>>  hw/arm/xlnx-zcu102.c         | 257 +++++++++++++++++++++++++++++++++++++++++++
>>  hw/arm/xlnx-zynqmp.c         |   3 +-
>>  include/hw/arm/xlnx-zynqmp.h |   2 +
>>  5 files changed, 262 insertions(+), 139 deletions(-)
>>  delete mode 100644 hw/arm/xlnx-ep108.c
>>  create mode 100644 hw/arm/xlnx-zcu102.c
>>
>> --
>> 2.11.0
>>
