Received: from eggs.gnu.org ([2001:4830:134:3::10]:39489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1cm4-0001Tt-0v
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1cm3-0002Cy-46
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:27:32 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:55944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1cm2-0002CP-T2
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:27:31 -0400
Received: by mail-wm0-x235.google.com with SMTP id u138so25989501wmu.4
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 11:27:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171009144641.GA3676@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
	<20171009144641.GA3676@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 19:27:09 +0100
Message-ID: <CAFEAcA9xYJVy2mSo=CmmHDTfELLaEpzbDx=SubsmJQQY9fwxeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 00/13] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 9 October 2017 at 15:46, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> Unfortunately I'm not sure who to add other than the current recipients,
> but I'm eager for feedback and would love to work this into something
> that will allow for using the full ARM PMU.

Hi -- I do have this on my review queue, but unfortunately it's
sitting behind some other fairly chunky hard-to-review patchsets.

As a first quick "is this going in the right direction" review based
pretty much only on the cover letter:

What extra events do you want to try to support in the emulated PMU?
Part of the reason we only support the cycle counter is because
 (1) a lot of the events in a real PMU would be hard to support
 (2) it's not clear to me that exposing events to the guest would be
     very useful to it anyway -- performance profiling of guest code
     running under emulation is fraught with difficulty

Giving more of an idea of what your use case is would help in
evaluating these patches.

Some of what you're doing looks like it's fixing bugs in our current
implementation, which is definitely fine in principle.

I haven't looked at the icount related stuff (and I can never remember
how it works either) but fiddling with can_do_io does sound like it's not
the right approach...

thanks
-- PMM
