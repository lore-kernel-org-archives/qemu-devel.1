Received: from eggs.gnu.org ([208.118.235.92]:52820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfPR3-0003zp-Hr
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfPR2-0006mx-HH
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:22:49 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfPR2-0006mp-4d
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:22:48 -0500
Received: by mail-oi1-x241.google.com with SMTP id u18so30294766oie.10
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 05:22:48 -0800 (PST)
MIME-Version: 1.0
References: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 13:22:36 +0000
Message-ID: <CAFEAcA-JCofFz44oaSaHMnAY-+ZjKVGBCw-hbsyW4upUQADErg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/44] MIPS pull request for December
 2018 - v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Thu, 3 Jan 2019 at 17:08, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 1b3e80082bcd9b760113bbc023496cd22efad2dc:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20181226' into staging (2019-01-03 10:42:21 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-december-2018-v3
>
> for you to fetch changes up to 19749a21d79bc26e35d88b9e9cfe7e2902979273:
>
>   tests/tcg: mips: Test R5900 three-operand MADDU1 (2019-01-03 17:52:52 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for December 2018 - v3
>
>   - this queue contains various amendments to MIPS code
>       - MAINTAINERS updates
>       - MXU support updates
>       - R5900 updates
>       - nanoMIPS disassembler updates
>       - fix for builds on n32 hosts
>   - there are three checkpatch warnings that should be ingnored
>     for given circumstances
>   - most of the patches are not yet visible/noticeable to the end
>     user, just a single note related to Paul's patch (fixing build
>     on n32 hosts) will be added to ChangeLog
>
> v2->v3:
>
>   - corrected two build errors related to declaring counter within
>     "for" loops
>   - rebased to the latest code
>
> v1->v2:
>
>   - added three patches that were meanwhile tested better
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
