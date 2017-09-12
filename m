Received: from eggs.gnu.org ([2001:4830:134:3::10]:34383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drtMm-0008DM-Ge
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drtMl-0008G5-IZ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:09:12 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drtMl-0008FQ-BM
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:09:11 -0400
Received: by mail-wr0-x233.google.com with SMTP id m18so25326346wrm.2
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 15:09:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150525284073.29079.14299492241937433886.malone@chaenomeles.canonical.com>
References: <150524995294.5903.8871661765030368900.malonedeb@wampee.canonical.com>
	<150525284073.29079.14299492241937433886.malone@chaenomeles.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 23:08:49 +0100
Message-ID: <CAFEAcA_3GeeEYi7f4jLQPyWN567Ja0494ceWbf-fYxEQDN2+Cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1716767] Re: file(1) fails with "Invalid
 argument" on qemu-sh4-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1716767 <1716767@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 September 2017 at 22:47, James Clarke <jrtc27@jrtc27.com> wrote:
> I just ran it myself inside and outside the sh4 chroot. The logging
> output is the same, with the exception of the final line. Something is
> happening once it's decided it's elf; looking at file_tryelf, my guess
> is the fstat call is failing[0].

strace could probably confirm or deny that. I would be unsurprised
if the linux-user definitions for the structure layouts for the
various stat structs were wrong for sh4.

thanks
-- PMM
