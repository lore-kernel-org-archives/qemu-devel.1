Received: from eggs.gnu.org ([2001:4830:134:3::10]:57047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsTIK-0004pT-T0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsTIJ-0003Pl-TH
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:31:00 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:45809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsTIJ-0003OV-O3
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:30:59 -0400
Received: by mail-wm0-x230.google.com with SMTP id g206so619211wme.0
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 05:30:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNrbdGJ2n=HHeUfJOq-EUmwbY_330DGL+BD++BtrSwnxA@mail.gmail.com>
References: <cover.1504222314.git.alistair.francis@xilinx.com>
	<20170907213525.GJ5763@toto>
	<CAKmqyKNrbdGJ2n=HHeUfJOq-EUmwbY_330DGL+BD++BtrSwnxA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 13:30:37 +0100
Message-ID: <CAFEAcA_SG5sPt9xnFJPSbM0L_Zzg0P0XvPA08ERXQoDq59dsKQ@mail.gmail.com>
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
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Edgar Iglesias <edgar.iglesias@gmail.com>

On 7 September 2017 at 22:44, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Thu, Sep 7, 2017 at 2:35 PM, Edgar E. Iglesias
> <edgar.iglesias@xilinx.com> wrote:
>> On Thu, Sep 07, 2017 at 08:56:55AM -0700, Alistair Francis wrote:
>>>
>>> The EL2 and EL3 work is working well now and interanlly we now have
>>> tests that expect to start in EL3 and transition through EL2 to EL1. To
>>> make this easy to run let's expose the secure property to the machine
>>> and also add a virt property that can enable EL2.
>>>
>>> This series also does some machine/name tidying up and makes the first
>>> move to deprecating the EP108 machine, which was just an early access
>>> development board.
>>>
>>> V2:
>>>  - Add a virt option for setting EL2
>>
>>
>> Thanks Alistair!
>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>
> Thanks Edgar.
>
> @Peter I updated the patches on the git branch I pasted earlier to
> include Edgar's review.

Thanks. I've applied the patches to target-arm.next.

-- PMM
