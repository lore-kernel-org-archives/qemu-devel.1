Received: from eggs.gnu.org ([2001:4830:134:3::10]:45178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFhdu-0003eV-6W
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFhdt-0006ac-CS
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:57:02 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFhdt-0006aL-5Y
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:57:01 -0400
Received: by mail-wr0-x233.google.com with SMTP id j27so1113017wre.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 06:57:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPBYyhT5NFRks8Z4VX=mCdQuVk5+cX4s4qPpO9PQvMMZQ@mail.gmail.com>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<1493122030-32191-3-git-send-email-peter.maydell@linaro.org>
	<CAKmqyKPBYyhT5NFRks8Z4VX=mCdQuVk5+cX4s4qPpO9PQvMMZQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 14:56:39 +0100
Message-ID: <CAFEAcA_NvX4=zXehU4yTdwnWCyPOddB81Que3UDsM0yVhCaFLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/13] arm: Add support for M profile CPUs
 having different MMU index semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Patch Tracking <patches@linaro.org>

On 2 May 2017 at 23:23, Alistair Francis <alistair.francis@xilinx.com> wrote:
> On Tue, Apr 25, 2017 at 5:06 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> The M profile CPU's MPU has an awkward corner case which we
>> would like to implement with a different MMU index.
>>
>> We can avoid having to bump the number of MMU modes ARM
>> uses, because some of our existing MMU indexes are only
>> used by non-M-profile CPUs, so we can borrow one.
>> To avoid that getting too confusing, clean up the code
>> to try to keep the two meanings of the index separate.
>>
>> Instead of ARMMMUIdx enum values being identical to core QEMU
>> MMU index values, they are now the core index values with some
>> high bits set. Any particular CPU always uses the same high
>> bits (so eventually A profile cores and M profile cores will
>> use different bits). New functions arm_to_core_mmu_idx()
>> and core_to_arm_mmu_idx() convert between the two.
>>
>> In general core index values are stored in 'int' types, and
>> ARM values are stored in ARMMMUIdx types.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> This looks ok to me. I'm a little worried it will make SMMU or some
> ARMv9 (or whatever the next thing is) work more complicated as we have
> this.

Mmm, that's always a risk, but I think it will be pretty
easy to undo this if we need to.

thanks
-- PMM
