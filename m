Received: from eggs.gnu.org ([2001:4830:134:3::10]:56777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faz3F-0003vH-NY
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faz3E-0008TZ-Qt
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:51:41 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faz3E-0008Ri-KS
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:51:40 -0400
Received: by mail-oi0-x243.google.com with SMTP id i12-v6so15092750oik.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 00:51:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180704155123.GO4828@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-25-git-send-email-suzuki.poulose@arm.com>
	<20180704142241.GG4828@arm.com> <8636wzysfl.wl-marc.zyngier@arm.com>
	<20180704155123.GO4828@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 08:51:19 +0100
Message-ID: <CAFEAcA9wgnbK8PHMvksezHqgN1BQZd_+sxXCe85AW+E+cfrcXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [kvmtool test PATCH 24/24] kvmtool: arm: Add
 support for creating VM with PA size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <cdall@kernel.org>, kvm-devel <kvm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu, arm-mail-list <linux-arm-kernel@lists.infradead.org>

On 4 July 2018 at 16:51, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Jul 04, 2018 at 03:41:18PM +0100, Marc Zyngier wrote:
>> Not really. Let's say I want my IPA space split in two: memory covers
>> the low 47 bit, and I want MMIO spanning the top 47 bit. With your
>> scheme, you'd end-up with a 47bit IPA space, while you really want 48
>> bits (MMIO space implemented by userspace isn't registered to the
>> kernel).
>
> That still sounds quite niche for a VM. Does QEMU do that?

Not at 47 bits, but we have RAM up to the 256GB mark, and
MMIO above that (including a large PCI window), so the general
arrangement of having the top end of the IPA space not
necessarily be things we've told the kernel about definitely
exists.

thanks
-- PMM
