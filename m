Received: from eggs.gnu.org ([2001:4830:134:3::10]:47835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbRl5-0006wC-J8
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbRl4-0003WP-O3
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:30:51 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbRl4-0003Vi-Il
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:30:50 -0400
Received: by mail-oi0-x242.google.com with SMTP id m2-v6so23813954oim.12
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 07:30:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <28C5FDE4-3576-466E-A718-E9A48AC64306@gmail.com>
References: <20180706025352.42643-1-programmingkidx@gmail.com>
	<CAFEAcA-6p5TP=yedqYMY+kaW6qTLMPrXTXdF9YeK0eU78vwLjA@mail.gmail.com>
	<28C5FDE4-3576-466E-A718-E9A48AC64306@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 15:30:29 +0100
Message-ID: <CAFEAcA-7oezxRNKRzVrJqDancGpY2cmbHPgfD3KdJdOrx5j_uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] ui/cocoa.m: replace scrollingDeltaY
 with deltaY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 July 2018 at 15:22, G 3 <programmingkidx@gmail.com> wrote:
>
> On Jul 6, 2018, at 5:11 AM, Peter Maydell wrote:
>
>> On 6 July 2018 at 03:53, John Arbuckle <programmingkidx@gmail.com> wrote:
>>>
>>> The NSEvent class method scrollingDeltaY is available
>>> for Mac OS 10.7 and newer. Since QEMU supports Mac OS
>>> 10.5 and up, we need to be using a method that is
>>> available on these version of Mac OS X. The deltaY
>>> method is a method that does the same thing as
>>> scrollingDeltaY and is available on Mac OS 10.5 and
>>> up. So we simply replace scrollingDeltaY with deltaY.
>>
>>
>> Commit message doesn't match code change.
>
>
> Did you want me to add information on dropping events with a
> deltaY value of zero?

Yes. The code is not doing a simple replace of one method
with the other, so the commit message shouldn't say it is.

thanks
-- PMM
