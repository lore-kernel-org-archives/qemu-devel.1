Received: from eggs.gnu.org ([2001:4830:134:3::10]:50226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8TPe-0007HJ-KK
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8TNb-0003tI-C3
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:55:08 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8TNb-0003sx-4N
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:55:07 -0400
Received: by mail-oi1-x244.google.com with SMTP id p125-v6so10947272oic.3
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 09:55:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181005161739.GC4606@localhost.localdomain>
References: <20181005143802.18412-1-peter.maydell@linaro.org>
	<CAFEAcA8-FvVG7XBLrd7NQfRcKrvo6GtPEjfqJzkjd68iP9=TeQ@mail.gmail.com>
	<20181005161739.GC4606@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 17:54:45 +0100
Message-ID: <CAFEAcA-SWRHwnwsa+QiHXfdBRB6u2u0paV9HsEqfjR6nZvAHSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests: Disable test-bdrv-drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 5 October 2018 at 17:17, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 05.10.2018 um 16:41 hat Peter Maydell geschrieben:
>> On 5 October 2018 at 15:38, Peter Maydell <peter.maydell@linaro.org> wrote:
>> > The test-bdrv-drain test fails at least 50% of the time
>> > on my OS build system. Disable the test until we can figure
>>
>> This is a typo: I meant "OSX build system".
>>
>> > out what's going on, as this makes pull request processing
>> > very difficult.
>> >
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Can we disable it conditionally only on OS X instead?
>
> I'd hate to lose this test case, and without OS X I can't really do
> anything to fix the problem (or to even find out if it's a test case
> problem or a bug that the test case reveals).

If we disable it for OSX only then nobody has any incentive
to investigate and fix it...

thanks
-- PMM
