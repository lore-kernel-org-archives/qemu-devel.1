Received: from eggs.gnu.org ([2001:4830:134:3::10]:54060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1daKqC-0001Bl-3j
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1daKqB-0000kv-3l
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:51:00 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1daKqA-0000kM-TZ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:50:59 -0400
Received: by mail-wm0-x22b.google.com with SMTP id m85so65237384wma.1
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 04:50:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170726113308.GG18489@stefanha-x1.localdomain>
References: <20170721093416.17816-1-stefanha@redhat.com>
	<CAFEAcA_+ffmyvExhFvm2JTmoipum6GeWiFPP5kuxRKb9+ezRzA@mail.gmail.com>
	<20170725152052.GP23343@stefanha-x1.localdomain>
	<CAFEAcA9J=m+aVWH1piHA=dzXU_ND9O1=whkpis9mb=WM8m_40g@mail.gmail.com>
	<20170726113308.GG18489@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Jul 2017 12:50:37 +0100
Message-ID: <CAFEAcA_oapBTwRqHH0Rn8gJ6FnRLs2isejYMzr9aXLLwS5Tx+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-iotests: add a "how to"
 to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 26 July 2017 at 12:33, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Tue, Jul 25, 2017 at 04:34:19PM +0100, Peter Maydell wrote:
>> On 25 July 2017 at 16:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> > On Mon, Jul 24, 2017 at 11:20:44AM +0100, Peter Maydell wrote:
>> >> Should ./check be run from the source tree, or the build tree? The
>> >> existing README text doesn't say and I don't think your additions
>> >> do either.
>> >
>> > It doesn't matter, both should work.  The script detects both
>> > possibilities and rejigs itself to compensate.
>>
>> Does that mean
>>  if you run it from the source tree in a tree configured
>>  for out of tree build it will:
>>  (a) pollute your source tree with test output and binaries
>>  (b) give you a helpful message about what to do
>>  (c) magically find the build tree somehow
>>  (d) not need to write any binaries/test output/temp files at all
>>
>> ?
>
> I think it would fail since the binaries would be missing in the source
> tree.

That sounds like "the README should say you need to run it
from the build tree", then ?

thanks
-- PMM
