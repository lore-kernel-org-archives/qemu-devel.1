Received: from eggs.gnu.org ([2001:4830:134:3::10]:50609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dkDR3-0002iT-V4
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dkDR3-000396-0G
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:57:54 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dkDR2-000376-Q9
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:57:52 -0400
Received: by mail-wm0-x242.google.com with SMTP id y206so9238505wmd.5
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 10:57:50 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170822172438.GF3205@toto>
References: <cover.1502993370.git.alistair.francis@xilinx.com>
	<20170822172438.GF3205@toto>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 22 Aug 2017 10:57:18 -0700
Message-ID: <CAKmqyKOH8G1LzLHksfuxQLBskFB0KsCy7zP5pPtbtvUmQcZORQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgar.iglesias@gmail.com>

On Tue, Aug 22, 2017 at 10:24 AM, Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
> On Thu, Aug 17, 2017 at 11:51:59AM -0700, Alistair Francis wrote:
>> The EL2 and EL3 work is working well now and interanlly we now have
>> tests that expect to start in EL3 and transition through EL2 to EL1. To
>> make this easy to run let's expose the secure property to the machine
>> and then use that to enable EL2.
>>
>> This series also does some machine/name tidying up and makes the first
>> move to deprecating the EP108 machine, which was just an early access
>> development board.
>
> Hi Alistair,
>
> Reconsidering this, I tend to agree that we're probably better off with
> EL2/no-GICv2-virt compared to the possible confusiong of having EL2
> without GICv2-virt..
>
> But I wonder if we should have similar options as the virt machine?
> I.e, a virtualization option to enable EL2.

That's fine with me.

Just to clarify do you think we should keep the secure option for EL3
and add a virt option for EL2?

Thanks,
Alistair

>
> Cheers,
> Edgar
>
>
>>
>> Alistair Francis (5):
>>   xlnx-ep108: Rename to ZCU102
>>   xlnx-zcu102: Manually create the machines
>>   xlnx-zcu102: Add a machine level secure property
>>   xlnx-zynqmp: Allow the secure prop to enable EL2
>>   xlnx-zcu102: Mark the EP108 machine as deprecated
>>
>>  hw/arm/Makefile.objs                   |   2 +-
>>  hw/arm/{xlnx-ep108.c => xlnx-zcu102.c} | 131 ++++++++++++++++++++++++++++-----
>>  hw/arm/xlnx-zynqmp.c                   |   2 +-
>>  3 files changed, 114 insertions(+), 21 deletions(-)
>>  rename hw/arm/{xlnx-ep108.c => xlnx-zcu102.c} (51%)
>>
>> --
>> 2.11.0
>>
