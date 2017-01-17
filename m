Received: from eggs.gnu.org ([2001:4830:134:3::10]:35454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cTc3W-0001Ca-9C
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cTc3V-0005Uh-9c
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:16:42 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170117144954.rgw53vmavygrctlo@kamzik.brq.redhat.com>
References: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA9N_YXFCPo8ja-Nan3roL=gdNpFQHoLk_aw6tDixwoT3w@mail.gmail.com>
	<20170117144954.rgw53vmavygrctlo@kamzik.brq.redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 17 Jan 2017 14:16:09 -0800
Message-ID: <CAKmqyKNWnXzs=ZKO94s-tmxCEZva050Cjb14HoYmig9UqBJUrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 00/18] arm: Add
 virtualization to GICv3, and enable EL2 on 64-bit CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>

On Tue, Jan 17, 2017 at 6:49 AM, Andrew Jones <drjones@redhat.com> wrote:
> On Tue, Jan 17, 2017 at 02:07:31PM +0000, Peter Maydell wrote:
>> On 9 January 2017 at 16:05, Peter Maydell <peter.maydell@linaro.org> wrote:
>> > This patchset adds support for the Virtualization extensions to QEMU's
>> > GICv3 emulation. This was the last missing piece that was stopping
>> > us from turning on the EL2 support in the CPU model, so the patchset
>> > also adds support for enabling it all on the virt board via the
>> > '-machine virtualization=on' option.
>>
>> > Patches 1, 4-13, 15, 16 still need review.
>>
>> So is anybody interested in reviewing the complicated
>> bits in the middle of this patchset (5-13) or shall I
>> just throw it into target-arm.next? :-)

I have Acked and Reviewed what I can. I don't know much about GICv3 so
I can't really judge those patches. Overall they look good to me
though.

Thanks,

Alistair

>
> Unfortunately I don't have time right now to give them the justice
> they deserve. FWIW, I've done light testing and light reviewing and
> I don't have any complaints.
>
> Thanks,
> drew
>
>>
>> thanks
>> -- PMM
>>
>
