Received: from eggs.gnu.org ([2001:4830:134:3::10]:37982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS0bk-0008Nh-Qv
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS0bj-0005sD-S1
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:09:56 -0500
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:34730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eS0bj-0005qU-AZ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:09:55 -0500
Received: by mail-oi0-x229.google.com with SMTP id u193so16795251oie.1
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 05:09:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221084041.GA19441@umbus.fritz.box>
References: <20171219042942.29297-1-david@gibson.dropbear.id.au>
	<CAFEAcA_CrLPQDBxYs6bzYX1Venpau1McP5o7-6PKuL1H-NJR4Q@mail.gmail.com>
	<20171220134550.GH5981@umbus.fritz.box>
	<20171221084041.GA19441@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Dec 2017 13:09:34 +0000
Message-ID: <CAFEAcA_7qqE05WD91kXd9ivwY379E7dN_T8qKTwMVqOivwdh4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] ppc-for-2.12 queue 20171219
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 21 December 2017 at 08:40, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Thu, Dec 21, 2017 at 12:45:50AM +1100, David Gibson wrote:
>> Oh :(.  I ran make check SPEED=slow in a 32-bit x86 container before
>> sending the pull request, and I just retried it now, so that doesn't
>> appear to be the case.
>>
>> I haven't the foggiest what could be broken in an arm host specific
>> way, though.  Nor do I have easy access to an arm system to track it
>> down on.
>
> After I sent that I remembered my Raspberry Pi.  Unfortunately, after
> spending most of the day getting it compiled, I wasn't able to
> reproduce the problem.  The migration-test completed just fine with my
> ppc-for-2.12 tree.
>
> I'm not sure where to go from here, I don't even have a guess as to
> which patch in the series might be causing the problem, since none of
> them seem likely candidates.

I can have another look with the setup that failed, but that won't be
until the new year, I'm afraid.

thanks
-- PMM
