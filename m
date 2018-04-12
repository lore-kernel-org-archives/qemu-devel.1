Received: from eggs.gnu.org ([2001:4830:134:3::10]:35136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6fuW-0000X9-E9
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6fuV-00038Z-KF
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:21:24 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:44350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6fuV-00038E-F2
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:21:23 -0400
Received: by mail-ot0-x234.google.com with SMTP id p33-v6so6858039otp.11
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 10:21:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180412170139.GH24561@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-10-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA9UpNW8q+vBKDskhAMVxHh4QUOJ5diP8AR6mpMRk+enBQ@mail.gmail.com>
	<20180412170139.GH24561@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 18:21:02 +0100
Message-ID: <CAFEAcA-TQ-mihXqEZUe1AsWeDu8d7Yq3BeZbmnRgO-UCKeRgYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 09/22] target/arm: Add pre-EL change
 hooks
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

On 12 April 2018 at 18:01, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> On Apr 12 17:49, Peter Maydell wrote:
>> Do we make the guarantee that if we call the pre-change hook
>> then we will definitely subsequently call the post-change hook?
>> (ie does the PMU hook rely on that?)
>
> Yes, the PMU relies on the pre- and post- hooks being called in pairs
> since they drive the state machine of sorts that exists in the variables
> holding the counter values/deltas. And unless I've really screwed up the
> implementation, I believe the change hooks in my patchset make that
> guarantee.

Yes, I think I agree. We should document in the comment that
this is a guarantee that we make.

thanks
-- PMM
