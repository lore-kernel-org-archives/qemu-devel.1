Received: from eggs.gnu.org ([2001:4830:134:3::10]:41868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cyg8P-00035n-7w
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cyg8O-0007i5-D7
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:54:09 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cyg8O-0007ha-5t
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:54:08 -0400
Received: by mail-wm0-x22d.google.com with SMTP id t189so48988333wmt.1
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 07:54:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d2553d23-6710-5a1a-8efb-1d8379a1849e@redhat.com>
References: <20170412204641.GA15762@localhost.localdomain>
	<f5bf12f4-e4fd-87c7-a714-e412cee63e36@redhat.com>
	<20170412222251.GB15762@localhost.localdomain>
	<20170412235420.GB8607@lemon>
	<CAFEAcA9yt49a61JLN-Sv=dFSz6rGC30hxb9=oHDqRnvpyjZXQQ@mail.gmail.com>
	<d2553d23-6710-5a1a-8efb-1d8379a1849e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Apr 2017 15:53:46 +0100
Message-ID: <CAFEAcA9hGHQQbzaH5brYABpzPTgE6UQLLPs_s4CMbgy4dKwUig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Regression from 2.8: stuck in bdrv_drain()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Jeff Cody <jcody@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On 13 April 2017 at 15:33, Eric Blake <eblake@redhat.com> wrote:
> On 04/13/2017 04:48 AM, Peter Maydell wrote:
>> Well, we *hope* there is no -rc5, but if the bug is genuinely
>> a "we can't release like this" bug we will obviously have to
>> do another rc. Basically you all as the block maintainers should
>> make the call about whether it's release-critical or not.
>
> Just curious: is there a technical reason we couldn't spin an -rc5 today
> (with just the fix to this issue), and slip the schedule only by two
> days instead of a full week?  And/or shorten the time for testing -rc5
> from the usual 7 days into 5?

I've just heard about another issue which probably will
require an rc5. Whether that means it makes sense to add
this fix too I don't know.

Not a technical reason, but we're a bit short on time to do an
rc5 today, and I'm away on holiday until Tuesday after that
anyway.

My current plan is that we'll roll rc5 on Tuesday with
either just the fix for that other issue or that plus this
one, and then tag final release Thursday.

What you lot as the block maintainers should decide is
whether this is a release-critical bug that justifies sticking
a fix in at the last minute, and if so make sure you have
a patch on the list which fixes it and has been reviewed
and flag it up to me so I can apply it on Tuesday.

thanks
-- PMM
