Received: from eggs.gnu.org ([2001:4830:134:3::10]:54903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkavk-0001Cg-4A
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkavj-0004oe-BE
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:03:08 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:38625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dkavj-0004oI-5Y
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:03:07 -0400
Received: by mail-wm0-x22f.google.com with SMTP id l19so5399898wmi.1
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 12:03:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150342060911.16351.13360526764887940185@loki>
References: <150283106173.12142.14640827565327335906@loki>
	<CAFEAcA9eJ18cPj=MBhCftmVvOBPCmFtDqSKOM8aBH9d+uVuv4Q@mail.gmail.com>
	<150342060911.16351.13360526764887940185@loki>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Aug 2017 20:02:45 +0100
Message-ID: <CAFEAcA9N+t8bFTKSXu=LsDGDhTD7hUpYdS+rK8eS2Ldu2J5UAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.10.0-rc3 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 August 2017 at 17:50, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> Quoting Peter Maydell (2017-08-22 11:20:18)
>> We've had a few late-breaking PPC host bugs that we need
>> to fix, so we'll tag rc3 either today or more likely tomorrow
>> and then have the final release next week.
>
> Ok, thanks for the heads up.

We also ended up with some very late fixes for bad NBD
bugs, which I've just applied to master. Since those
were diagnosed and fixed in a rather short timescale,
I've opted to not tag rc4 just yet, but instead give
it another 24 hours to make sure we're happy we really
did fix all the NBD bugs. Plan is to tag rc4 on Thursday
24th and final release next week (wednesday?)

thanks
-- PMM
