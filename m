Received: from eggs.gnu.org ([2001:4830:134:3::10]:46930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eO6HQ-0006Eo-Hj
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 13:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eO6HP-00024a-MD
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 13:24:48 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eO6HP-00024H-H2
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 13:24:47 -0500
Received: by mail-ot0-x244.google.com with SMTP id d5so13010572oti.3
	for <qemu-devel@nongnu.org>; Sun, 10 Dec 2017 10:24:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171208230920.GA11462@flamenco>
References: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
	<1507824216-29058-9-git-send-email-peter.maydell@linaro.org>
	<20171208230920.GA11462@flamenco>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Dec 2017 18:24:26 +0000
Message-ID: <CAFEAcA_2HH2mTrHNzyrn=e3OQgoEdCZSbL7aa+wRHi1fba-8=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 08/13] target/arm: Pull Thumb insn word
 loads up to top level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On 8 December 2017 at 23:09, Emilio G. Cota <cota@braap.org> wrote:
> On Thu, Oct 12, 2017 at 17:03:31 +0100, Peter Maydell wrote:
>> Refactor the Thumb decode to do the loads of the instruction words at
>> the top level rather than only loading the second half of a 32-bit
>> Thumb insn in the middle of the decode.

> This commit breaks the debian-arm boot test (see [1]), boot dies at:
>
>> random: systemd urandom read with 4 bits of entropy available
>> systemd[1]: Caught <SEGV>, core dump failed.
>> systemd[1]: Freezing execution.
>
> Sorry I noticed this so late (-rc4), for a while I thought my development
> was causing this and didn't pay much attention to it. However, just realised
> the problem is present on master. Bisect log below.

It's missed the deadline for getting fixed in 2.11, but I'll have
a look at what's going on here.

thanks
-- PMM
