Received: from eggs.gnu.org ([2001:4830:134:3::10]:52291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTlVc-0001pf-Pb
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTlVb-0007bH-P3
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:59:08 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:37141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTlVb-0007ax-I5
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:59:07 -0400
Received: by mail-ot0-x244.google.com with SMTP id 101-v6so10380797oth.4
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 02:59:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-jg7iQuYeRSteJVoq9nd4ysvCJcGZTibhRBDhgr3pQ9Q@mail.gmail.com>
References: <20180601141223.26630-1-peter.maydell@linaro.org>
	<CAFEAcA-jg7iQuYeRSteJVoq9nd4ysvCJcGZTibhRBDhgr3pQ9Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 10:58:46 +0100
Message-ID: <CAFEAcA8pBoKkDvXmyesv-cGS=CMoV=KTrQHW7gswnM-ERH_2+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/6] More conversions away from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <huth@tuxfamily.org>, "patches@linaro.org" <patches@linaro.org>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On 11 June 2018 at 15:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 1 June 2018 at 15:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Peter Maydell (6):
>>   hw/sh/sh7750: Convert away from old_mmio
>>   hw/m68k/mcf5206: Convert away from old_mmio
>>   hw/block/pflash_cfi02: Convert away from old_mmio
>>   hw/watchdog/wdt_i6300esb: Convert away from old_mmio
>>   hw/input/pckbd: Convert away from old_mmio
>>   hw/char/parallel: Convert away from old_mmio
>
> Ping for review on patches 1, 4, 5, 6, please?

Thanks all for the review. I propose to put these in via
target-arm.next for (my) convenience, though they're not
really very arm-related.

thanks
-- PMM
