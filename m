Received: from eggs.gnu.org ([2001:4830:134:3::10]:47417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQgSE-0005cQ-8T
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 17:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQgSD-0001Hn-5x
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 17:58:54 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:42612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQgSD-0001HG-0X
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 17:58:53 -0400
Received: by mail-ot0-x22a.google.com with SMTP id 92-v6so9096708otw.9
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 14:58:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180606202320.4lopjnm4be3d5gix@pburton-laptop>
References: <1487722868-9111-1-git-send-email-yongbok.kim@imgtec.com>
	<1487722868-9111-8-git-send-email-yongbok.kim@imgtec.com>
	<CAFEAcA8NehifKn7wsmLgUqiYNHwczzrXGnUcTvx-AbLM=_LeMQ@mail.gmail.com>
	<20180606202320.4lopjnm4be3d5gix@pburton-laptop>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Jun 2018 22:58:31 +0100
Message-ID: <CAFEAcA8GkSweYOsuNTsUuo-QWowh9b4iKnk-5uiLedBm7vYijQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 7/8] hw: xilinx-pcie: Add support for
 Xilinx AXI PCIe Controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Burton <paul.burton@mips.com>
Cc: Yongbok Kim <yongbok.kim@mips.com>, QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 6 June 2018 at 21:23, Paul Burton <paul.burton@mips.com> wrote:
> Hi Peter,
>
> On Mon, Jun 04, 2018 at 11:29:47AM +0100, Peter Maydell wrote:
>> Hi; I was looking at the code for this PCI controller as
>> part of identifying RAM memory regions that don't migrate
>> their contents, and this looks kind of odd. Can you explain
>> why this is using a RAM region for the PCI bus's IO memory
>> space? None of our other PCI controller models do this, so
>> I suspect this is a bug. (The effect would be that PCI IO
>> accesses to addresses which don't have a PCI BAR mapped there
>> will behave as reads-as-written, which seems pretty unlikely
>> to be what the hardware does.)
>>
>> What is the intended semantics for PCI IO accesses with this
>> controller? (It seems to only be used with the MIPS boston
>> board model.)

> The controller here simply doesn't support I/O accesses, and the dummy
> region is there to prevent the rest of QEMU's PCI code & device
> emulation from needing to care about that fact. The region is never
> mapped into the system memory and so software running on the emulated
> system has no way to access it.

Right, I wondered if that was the case. The region should
not be RAM, then, it should be a dummy does-nothing region.
I'll put a patch together at some point.

thanks
-- PMM
